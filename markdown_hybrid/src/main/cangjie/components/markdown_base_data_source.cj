package markdown_hybrid.components

/**
 * 基础DataSource
 */
public open class MarkdownBaseDataSource<T> <: IDataSource<T> {
    public MarkdownBaseDataSource(let data_: ArrayList<T>) {}

    public var listener: ?DataChangeListener = None

    /**
     * 获得数据总数。
     *
     * @return 数据总数
     */
    public override func totalCount(): Int {
        return data_.size
    }

    /**
     * 获取索引值index对应的数据
     *
     * @param index 索引值
     * @return 数据
     */
    public override func getData(index: Int): T {
        return data_[index]
    }

    /**
     * 获取所有的数据
     *
     * @return 所有的数据
     */
    public func getAllData(): ArrayList<T> {
        return data_
    }

    /**
     * 注册数据改变的监听器
     *
     * @param listener 监听器
     */
    public override func onRegisterDataChangeListener(listener: DataChangeListener): Unit {
        this.listener = listener
    }

    /**
     * 注销数据改变的监听器。
     *
     * @param _ 监听器
     */
    public override func onUnregisterDataChangeListener(_: DataChangeListener): Unit {
        this.listener = None
    }

    /**
     * 通知组件重新加载所有数据。
     */
    public func notifyChange(): Unit {
        this.listener?.onDataReloaded()
    }

    /**
     * 通知组件index的位置有数据添加。
     *
     * @param index 位置
     */
    public func notifyDataAddChange(index: Int): Unit {
        this.listener?.onDataAdd(index)
    }

    /**
     * 通知组件删除index位置的数据并刷新LazyForEach的展示内容。
     *
     * @param index 位置
     */
    public func notifyDataDeleteChange(index: Int): Unit {
        this.listener?.onDataDelete(index)
    }

    /**
     * 通知组件index的位置有数据有变化。
     *
     * @param index 位置
     */
    public func notifyDataChange(index: Int): Unit {
        this.listener?.onDataChange(index)
    }

    /**
     * 通知组件数据有移动。
     *
     * @param fromIdx 数据移动起始位置。
     * @param toIdx 数据移动目标位置。
     */
    public func notifyDataMoveChange(fromIdx: Int64, toIdx: Int64): Unit {
        this.listener?.onDataMove(fromIdx, toIdx)
    }

    /**
     * 在列表最后添加ArrayList列表
     *
     * @param datas 列表
     */
    public func addDatas(datas: ArrayList<T>): Unit {
        for (item in datas) {
            addData(item)
        }
    }

    /**
     * 在列表最后添加Array列表
     *
     * @param datas 列表
     */
    public func addDatas(datas: Array<T>): Unit {
        for (item in datas) {
            addData(item)
        }
    }

    /**
     * 在列表最后添加一条数据
     *
     * @param data 一条数据
     */
    public func addData(data: T): Unit {
        let index = totalCount()
        data_.add(data)
        notifyDataAddChange(index)
    }

    /**
     * 删除一条数据
     *
     * @param index 一条数据
     */
    public func deleteData(index: Int): Unit {
        data_.remove(at: index)
        notifyDataDeleteChange(index)
    }

    /**
     * 删除一条数据,并刷新页面
     *
     * @param index 一条数据
     */
    public func removeData(index: Int): Unit {
        data_.remove(at: index)
    }

    /**
     * 在index位置更新数据,并刷新页面
     *
     * @param index 位置
     * @param data 一条数据
     */
    public func replaceData(index: Int, data: T): Unit {
        data_[index] = data
        notifyDataChange(index)
    }

    /**
     * 在index位置更新数据
     *
     * @param index 位置
     * @param data 一条数据
     */
    public func update(index: Int, data: T): Unit {
        data_[index] = data
    }

    /**
     * 清空数据
     */
    public func clear(): Unit {
        data_.clear()
        notifyChange()
    }
}


public open class MarkdownBaseListDataSource<T> <: IDataSource<T> {
    public MarkdownBaseListDataSource(let data_: ObservedArrayList<T>) {}

    public var listener: ?DataChangeListener = None

    /**
     * 获得数据总数。
     *
     * @return 数据总数
     */
    public override func totalCount(): Int {
        return data_.size
    }

    /**
     * 获取索引值index对应的数据
     *
     * @param index 索引值
     * @return 数据
     */
    public override func getData(index: Int): T {
        return data_[index]
    }

    /**
     * 获取所有的数据
     *
     * @return 所有的数据
     */
    public func getAllData(): ObservedArrayList<T> {
        return data_
    }

    /**
     * 注册数据改变的监听器
     *
     * @param listener 监听器
     */
    public override func onRegisterDataChangeListener(listener: DataChangeListener): Unit {
        this.listener = listener
    }

    /**
     * 注销数据改变的监听器。
     *
     * @param _ 监听器
     */
    public override func onUnregisterDataChangeListener(_: DataChangeListener): Unit {
        this.listener = None
    }

    /**
     * 通知组件重新加载所有数据。
     */
    public func notifyChange(): Unit {
        this.listener?.onDataReloaded()
    }

    /**
     * 通知组件index的位置有数据添加。
     *
     * @param index 位置
     */
    public func notifyDataAddChange(index: Int): Unit {
        this.listener?.onDataAdd(index)
    }

    /**
     * 通知组件删除index位置的数据并刷新LazyForEach的展示内容。
     *
     * @param index 位置
     */
    public func notifyDataDeleteChange(index: Int): Unit {
        this.listener?.onDataDelete(index)
    }

    /**
     * 通知组件index的位置有数据有变化。
     *
     * @param index 位置
     */
    public func notifyDataChange(index: Int): Unit {
        this.listener?.onDataChange(index)
    }

    /**
     * 通知组件数据有移动。
     *
     * @param fromIdx 数据移动起始位置。
     * @param toIdx 数据移动目标位置。
     */
    public func notifyDataMoveChange(fromIdx: Int64, toIdx: Int64): Unit {
        this.listener?.onDataMove(fromIdx, toIdx)
    }

    /**
     * 在列表最后添加ArrayList列表
     *
     * @param datas 列表
     */
    public func addDatas(datas: ObservedArrayList<T>): Unit {
        for (i in 0..datas.size) {
            addData(datas[i])
        }
    }

    /**
     * 在列表最后添加ArrayList列表
     *
     * @param datas 列表
     */
    public func addDatas(datas: ArrayList<T>): Unit {
        for (item in datas) {
            addData(item)
        }
    }

    /**
     * 在列表最后添加Array列表
     *
     * @param datas 列表
     */
    public func addDatas(datas: Array<T>): Unit {
        for (item in datas) {
            addData(item)
        }
    }

    /**
     * 在列表最后添加一条数据
     *
     * @param data 一条数据
     */
    public func addData(data: T): Unit {
        let index = totalCount()
        data_.append(data)
        notifyDataAddChange(index)
    }

    /**
     * 删除一条数据
     *
     * @param index 一条数据
     */
    public func deleteData(index: Int): Unit {
        data_.remove(index)
        notifyDataDeleteChange(index)
    }

    /**
     * 在index位置更新数据,并刷新页面
     *
     * @param index 位置
     * @param data 一条数据
     */
    public func replaceData(index: Int, data: T): Unit {
        data_[index] = data
        notifyDataChange(index)
    }

    /**
     * 清空数据
     */
    public func clear(): Unit {
        data_.clear()
        notifyChange()
    }
}


/**
 * 组件刷新注册表
 * @Watch在LazyForEach的updateWithValueParams中不触发，
 * 通过此注册表直接调用组件的refreshXxxData(newNodeView)就地更新，
 * 避免组件重建导致的UI闪屏。
 * 每个组件在aboutToAppear中注册，aboutToDisappear中注销。
 */
public class MarkdownRefreshRegistry {
    private static let map: HashMap<Int64, (NodeView) -> Unit> = HashMap<Int64, (NodeView) -> Unit>()

    public static func register(hash: Int64, callback: (NodeView) -> Unit): Unit {
        map[hash] = callback
    }

    public static func unregister(hash: Int64): Unit {
        map.remove(hash)
    }

    public static func refresh(hash: Int64, nodeView: NodeView): Unit {
        match(map.get(hash)) {
            case Some(cb) => cb(nodeView)
            case _ => ()
        }
    }

    public static func clear(): Unit {
        map.clear()
    }
}


/**
 * NodeView DataSource
 */
public class NodeViewDataSource <: MarkdownBaseDataSource<NodeView> {
    public NodeViewDataSource(let data: ArrayList<NodeView>) {
        super(data)
    }

    /**
     * 流式增量更新：逐个对比新旧数据的nodeHash/contentHash
     * - nodeHash变化：replaceData→notifyDataChange→框架重建组件
     * - contentHash变化（nodeHash不变）：通过MarkdownRefreshRegistry直接调用
     *   组件refreshXxxData(newNodeView)就地更新，不触发框架重建（避免闪屏）
     * - 新增节点：addData→框架创建新组件
     * - 删除节点：deleteData→框架销毁组件
     *
     * @param newData 解析后的新数据列表
     */
    public func smartUpdateDataArray(newData: ArrayList<NodeView>): Unit {
        let existingLen = data_.size
        if (existingLen == 0) {
            for (item in newData) {
                addData(item)
            }
            return
        }
        let newLen = newData.size
        let minLen = if (existingLen < newLen) { existingLen } else { newLen }
        for (i in 0..minLen) {
            let oldNode = data_[i]
            let newNode = newData[i]
            if (oldNode.nodeHash != newNode.nodeHash) {
                // nodeHash变化 → 框架重建组件
                replaceData(i, newNode)
            } else if (oldNode.contentHash != newNode.contentHash) {
                // contentHash变化（nodeHash不变）→ 就地更新，不触发框架重建
                data_[i] = newNode
                MarkdownRefreshRegistry.refresh(newNode.nodeHash, newNode)
            }
        }
        // 新增部分
        if (newLen > existingLen) {
            for (i in existingLen..newLen) {
                addData(newData[i])
            }
        } else if (existingLen > newLen) {
            // 删除多余部分（从后往前删，避免索引移位）
            for (i in existingLen - 1..=newLen : -1) {
                deleteData(i)
            }
        }
    }
}

/**
 * Node DataSource
 */
public class NodeDataSource <: MarkdownBaseDataSource<CommonmarkNode> {
    public NodeDataSource(let data: ArrayList<CommonmarkNode>) {
        super(data)
    }
}

/**
 * String DataSource
 */
public class StringDataSource <: MarkdownBaseDataSource<String> {
    public StringDataSource(let data: ArrayList<String>) {
        super(data)
    }
}

/**
 * Int64 DataSource
 */
public class Int64DataSource <: MarkdownBaseDataSource<Int64> {
    public Int64DataSource(let data: ArrayList<Int64>) {
        super(data)
    }
}
