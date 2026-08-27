import { NodeView } from "../model/NodeView"

export class MarkdownDataSource implements IDataSource {
  dataArray: NodeView[] = []
  listener: DataChangeListener | undefined
  // 上一次smartUpdateDataArray结束时的hash快照（"nodeHash|contentHash"）
  // nodeToNodeView复用分支会就地修改dataArray对象的hash，导致下次对比时新旧hash恒等。
  // 保存上一次的hash快照，下次调用时对比当前hash和快照，即可检测就地修改的变更。
  // 顶层和嵌套DataSource都自动生效，无需调用方传参。
  private savedHashes: string[] = []

  constructor(dataArray: NodeView[]) {
    this.dataArray = dataArray
  }

  /**
   * 注册数据改变的监听器
   *
   * @param listener 监听器
   */
  registerDataChangeListener(listener: DataChangeListener): void {
    this.listener = listener
  }

  /**
   * 注销数据改变的监听器
   *
   * @param listener 监听器
   */
  unregisterDataChangeListener(listener: DataChangeListener): void {
    this.listener = undefined
  }

  /**
   * 通知组件重新加载所有数据
   */
  public notifyChange(): void {
    this.listener?.onDataReloaded()
  }

  /**
   * 通知组件index的位置有数据添加
   *
   * @param index 位置
   */
  public notifyDataAddChange(index: number): void {
    this.listener?.onDataAdd(index)
  }

  /**
   * 通知组件删除index位置的数据并刷新LazyForEach的展示内容
   *
   * @param index 位置
   */
  public notifyDataDeleteChange(index: number): void {
    this.listener?.onDataDelete(index)
  }

  /**
   * 通知组件index的位置有数据有变化
   *
   * @param index 位置
   */
  public notifyDataChange(index: number): void {
    this.listener?.onDataChange(index)
  }

  /**
   * 通知组件数据有移动
   *
   * @param fromIdx 数据移动起始位置
   * @param toIdx 数据移动目标位置
   */
  public notifyDataMoveChange(fromIdx: number, toIdx: number): void {
    this.listener?.onDataMove(fromIdx, toIdx)
  }

  /**
   * 获得数据总数
   *
   * @return 数据总数
   */
  public totalCount(): number {
    return this.dataArray.length
  }

  /**
   * 获取索引值index对应的数据
   * 越界时返回空NodeView（安全降级，build()渲染空ListItem），
   * 不再返回dataArray[0]以避免错误内容出现在错误位置（重复渲染）。
   * LazyForEach在数据变化瞬间可能短暂请求越界index，属正常现象。
   *
   * @param index 索引值
   * @return 数据
   */
  public getData(index: number): NodeView {
    if (index < 0 || index >= this.dataArray.length) {
      return new NodeView()
    }
    return this.dataArray[index]
  }

  /**
   * 获取所有的数据
   *
   * @return 所有的数据
   */
  public getAllData(): Array<NodeView> {
    return this.dataArray
  }

  /**
   * 在列表最后添加Array列表
   *
   * @param dataArray 列表
   */
  public pushDataArray(dataArray: Array<NodeView>): void {
    for (let i = 0; i < dataArray.length; i++) {
      this.pushData(dataArray[i])
    }
    this.saveCurrentHashes()
  }

  /**
   * 在列表最后添加一条数据
   *
   * @param data 一条数据
   */
  public pushData(data: NodeView): void {
    let index = this.totalCount()
    this.dataArray.push(data)
    this.notifyDataAddChange(index)
  }

  /**
   * 删除一条数据
   *
   * @param index 一条数据
   */
  public deleteData(index: number): void {
    if (index < 0 || index >= this.dataArray.length) {
      return
    }
    this.dataArray.splice(index, 1)
    this.notifyDataDeleteChange(index)
  }

  /**
   * 在index位置更新数据,并刷新页面
   *
   * @param index 位置
   * @param data 一条数据
   */
  public replaceData(index: number, data: NodeView): void {
    if (index < 0 || index >= this.dataArray.length) {
      return
    }
    this.dataArray[index] = data
    this.notifyDataChange(index)
  }

  /**
   * 清空数据
   */
  public clear(): void {
    if (this.dataArray.length === 0) {
      return
    }
    // 逐个通知删除，确保LazyForEach移除每个组件
    // onDataReloaded()在数据为空时可能不清除已缓存的组件
    for (let i = this.dataArray.length - 1; i >= 0; i--) {
      this.notifyDataDeleteChange(i)
    }
    for (let i = 0; i < this.dataArray.length; i++) {
      this.dataArray[i].releaseOwnPixelMaps()
      this.dataArray[i].releaseChildrenPixelMaps()
    }
    this.dataArray = []
    this.savedHashes = []
  }

  /**
   * 替换全部数据（单次通知，避免clear+pushDataArray的短暂空状态）
   *
   * @param newData 新数据列表
   */
  public replaceAll(newData: Array<NodeView>): void {
    for (let i = 0; i < this.dataArray.length; i++) {
      this.dataArray[i].releaseOwnPixelMaps()
      this.dataArray[i].releaseChildrenPixelMaps()
    }
    this.dataArray = newData
    this.notifyChange()
    this.saveCurrentHashes()
  }

  /**
   * 流式增量更新：逐个对比新旧数据，更新变化的块
   * 不同对象一律copyDataFrom（不信任isBlockStable，避免parser未更新hash时漏更新）
   * 同一对象用savedHashes快照检测就地hash修改
   *
   * @param newData 解析后的新数据列表
   */
  public smartUpdateDataArray(newData: Array<NodeView>): void {
    if (this.dataArray.length === 0) {
      this.pushDataArray(newData)
      return
    }

    const existingLen = this.dataArray.length
    const newLen = newData.length
    const minLen = Math.min(existingLen, newLen)

    for (let i = 0; i < minLen; i++) {
      if (this.dataArray[i] === newData[i]) {
        // 同一对象（复用分支就地修改了属性）：对比savedHashes和当前hash
        let isStable: boolean
        if (i < this.savedHashes.length) {
          const currentHash = this.dataArray[i].nodeHash + '|' + this.dataArray[i].contentHash
          isStable = currentHash === this.savedHashes[i]
        } else {
          isStable = true
        }
        if (!isStable) {
          this.notifyDataChange(i)
        }
      } else {
        // 不同对象：一律copyDataFrom，不依赖hash判断
        // copyDataFrom就地修改children等属性，@Observed检测到变化触发@Watch
        this.dataArray[i].copyDataFrom(newData[i])
        this.notifyDataChange(i)
      }
    }

    if (newLen > existingLen) {
      for (let i = existingLen; i < newLen; i++) {
        this.pushData(newData[i])
      }
    } else if (existingLen > newLen) {
      for (let i = existingLen - 1; i >= newLen; i--) {
        this.dataArray[i].releaseOwnPixelMaps()
        this.dataArray[i].releaseChildrenPixelMaps()
        this.dataArray.splice(i, 1)
        this.notifyDataDeleteChange(i)
      }
    }

    this.saveCurrentHashes()
  }

  private saveCurrentHashes(): void {
    this.savedHashes = []
    for (let i = 0; i < this.dataArray.length; i++) {
      const item = this.dataArray[i]
      this.savedHashes.push(item.nodeHash + '|' + item.contentHash)
    }
  }
}
