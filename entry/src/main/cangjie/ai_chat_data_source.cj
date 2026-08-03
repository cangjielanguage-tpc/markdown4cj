package ohos_app_cangjie_entry

import std.collection.ArrayList
import ohos.component.IDataSource
import ohos.component.DataChangeListener

/**
 * 懒加载数据源（对齐 ArkTS ForLazyRender.ets GeneralDataSource）
 *
 * 在 IDataSource 基础上增加：
 * - append(item)      ：尾部追加并通知
 * - reload()          ：通知最后一条数据变化（用于流式更新）
 * - get(index)        ：负索引支持（-1 表示最后一条）
 * - set(index, item)  ：负索引支持并通知重载
 */
public class MessageDataSource <: IDataSource<Message> {
    private var data: ArrayList<Message> = ArrayList<Message>()
    public var listener: ?DataChangeListener = None

    public init() {}

    public func totalCount(): Int {
        return data.size
    }

    public func getData(index: Int): Message {
        return data[index]
    }

    public func onRegisterDataChangeListener(listener: DataChangeListener): Unit {
        this.listener = listener
    }

    public func onUnregisterDataChangeListener(_: DataChangeListener): Unit {
        this.listener = None
    }

    public func append(item: Message): Unit {
        let index = totalCount()
        data.add(item)
        listener?.onDataAdd(index)
    }

    public func reload(): Unit {
        if (data.size > 0) {
            listener?.onDataChange(data.size - 1)
        }
    }

    public func notifyReload(): Unit {
        listener?.onDataReloaded()
    }

    public func get(index: Int): Message {
        if (index < 0) {
            return data[data.size + index]
        }
        return data[index]
    }

    public func set(index: Int, item: Message): Unit {
        if (index < 0) {
            data[data.size + index] = item
        } else {
            data[index] = item
        }
        listener?.onDataReloaded()
    }
}
