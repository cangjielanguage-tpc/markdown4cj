package markdown.components

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
 * NodeView DataSource
 */
public class NodeViewDataSource <: MarkdownBaseDataSource<NodeView> {
    public NodeViewDataSource(let data: ArrayList<NodeView>) {
        super(data)
    }

    /**
     * 流式增量更新：逐个对比新旧数据的nodeHash/contentHash，替换变化的块
     * Cangjie解析器每次生成全新NodeView对象，旧对象不会被复用，
     * 因此直接用replaceData替换整个对象（不用copyDataFrom就地修改）。
     * 根keyGenerator为"${idx}-${nodeHash}"（不含contentHash），
     * contentHash变化时replaceData→notifyDataChange→@Watch触发子组件就地更新。
     * 子组件keyGenerator含contentHash，key变化时框架重建孙组件。
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
        // 对比重叠区间，hash变化时replaceData（触发key变化→组件重建）
        for (i in 0..minLen) {
            let oldNode = data_[i]
            let newNode = newData[i]
            if (oldNode.nodeHash != newNode.nodeHash || oldNode.contentHash != newNode.contentHash) {
                replaceData(i, newNode)
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
