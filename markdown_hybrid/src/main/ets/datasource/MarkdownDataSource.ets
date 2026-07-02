import { NodeView } from "../model/NodeView"

export class MarkdownDataSource implements IDataSource {
  dataArray: NodeView[] = []
  listener: DataChangeListener | undefined

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
   *
   * @param index 索引值
   * @return 数据
   */
  public getData(index: number): NodeView {
    if (index < 0 || index >= this.dataArray.length) {
      if (this.dataArray.length > 0) {
        return this.dataArray[0]
      }
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
  }

  /**
   * 流式增量更新：对比新旧数据，仅更新变化的尾部块，避免全量重建
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

    let stableCount = 0
    for (let i = 0; i < minLen; i++) {
      if (this.isBlockStable(this.dataArray[i], newData[i])) {
        stableCount++
      } else {
        break
      }
    }

    for (let i = stableCount; i < minLen; i++) {
      // 就地更新旧NodeView的属性，保持对象引用不变
      // 这样@Observed检测到属性变化，@ObjectLink的@Watch触发refreshData
      // 避免替换整个对象导致LazyForEach重建组件（图片闪烁）
      this.dataArray[i].copyDataFrom(newData[i])
      this.notifyDataChange(i)
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
  }

  /**
   * 判断两个块是否稳定（内容未变化）
   *
   * @param existing 已有数据
   * @param newBlock 新数据
   * @return 是否稳定
   */
  private isBlockStable(
    existing: NodeView,
    newBlock: NodeView
  ): boolean {
    if (existing.nodeHash !== "0"
      && newBlock.nodeHash !== "0"
      && existing.nodeHash === newBlock.nodeHash
      && existing.contentHash === newBlock.contentHash
    ) {
      return true
    }
    return existing.nodeType === newBlock.nodeType &&
      existing.nodeText === newBlock.nodeText &&
      existing.contentFingerprint() === newBlock.contentFingerprint()
  }
}