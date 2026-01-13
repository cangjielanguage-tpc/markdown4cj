/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.components

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*

public open class MarkdownBaseDataSource<T> <: IDataSource<T> {
    public MarkdownBaseDataSource(let data_: ArrayList<T>) {}

    public var listenerOp: ArrayList<DataChangeListener> = ArrayList<DataChangeListener>()

    public func totalCount(): Int {
        return data_.size
    }

    public func getData(index: Int): T {
        return data_[index]
    }

    public func registerDataChangeListener(listener: DataChangeListener): Unit {
        for (listeneritem in listenerOp) {
            if (refEq(listeneritem, listener)) {
                return
            }
        }
        listenerOp.add(listener)
    }

    public func unregisterDataChangeListener(listener: DataChangeListener): Unit {
        var index = 0
        while (index < listenerOp.size) {
            let listeneritem = listenerOp[index]
            if (refEq(listeneritem, listener)) {
                listenerOp.remove(at: index)
            } else {
                index++
            }
        }
    }

    public func notifyChange(): Unit {
        for (listeneritem in listenerOp) {
            listeneritem.onDataReloaded()
        }
    }

    public func addDatas(datas: ArrayList<T>) {
        for (item in datas) {
            addData(item)
        }
    }

    public func addDatas(datas: Array<T>) {
        for (item in datas) {
            addData(item)
        }
    }

    public func addData(data: T): Unit {
        let index = totalCount()
        data_.add(data)
        for (listeneritem in listenerOp) {
            listeneritem.onDataAdd(IntNative(index))
        }
    }

    public func notifyDataChange(index: Int): Unit {
        for (listeneritem in listenerOp) {
            listeneritem.onDataChange(IntNative(index))
        }
    }

    public func deleteData(index: Int): Unit {
        data_.remove(at: index)
        for (listeneritem in listenerOp) {
            listeneritem.onDataDelete(IntNative(index))
        }
    }

    public func clear(): Unit {
        data_.clear()
        notifyChange()
    }
}

public class NodeViewDataSource <: MarkdownBaseDataSource<NodeView> {
    public NodeViewDataSource(let data: ArrayList<NodeView>) {
        super(data)
    }
}
