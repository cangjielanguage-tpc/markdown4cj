package markdown.components

import std.collection.HashMap

/**
 * 外层滚动Y持有者（监听器模式）
 *
 * 通过对象引用传递（引用不变，不触发build()），
 * 通过监听器模式通知表格组件更新吸顶偏移量。
 * 由MarkdownComponent创建，传递给MarkdownTableBlockComponent使用。
 */
public class StickyScrollYHolder {
    private var y: Float64 = -1.0 // 当前滚动Y
    private var enabled: Bool = false // 是否启用吸顶模式
    private var listeners: HashMap<Int64, (Float64) -> Unit> = HashMap<Int64, (Float64) -> Unit>()
    private var nextId: Int64 = 0

    /**
     * 设置当前滚动Y值
     * 相同值不重复触发监听器
     *
     * @param newY 新的滚动Y值
     */
    public func setY(newY: Float64): Unit {
        if (this.y == newY) {
            return
        }
        this.y = newY
        for ((_, listener) in listeners) {
            listener(newY)
        }
    }

    /**
     * 获取当前滚动Y值
     *
     * @return 当前滚动Y值
     */
    public func getY(): Float64 {
        return this.y
    }

    /**
     * 设置是否启用吸顶模式
     *
     * @param enable 是否启用
     */
    public func setEnabled(enable: Bool): Unit {
        this.enabled = enable
    }

    /**
     * 获取是否启用吸顶模式
     *
     * @return 是否启用
     */
    public func getEnabled(): Bool {
        return this.enabled
    }

    /**
     * 添加滚动Y变化监听器
     *
     * @param listener 监听回调
     * @return 监听器ID（用于removeListener）
     */
    public func addListener(listener: (Float64) -> Unit): Int64 {
        let id = nextId
        nextId += 1
        listeners[id] = listener
        return id
    }

    /**
     * 移除滚动Y变化监听器
     *
     * @param id 监听器ID（由addListener返回）
     */
    public func removeListener(id: Int64): Unit {
        listeners.remove(id)
    }

    /**
     * 清除所有监听器
     */
    public func clearListeners(): Unit {
        listeners.clear()
    }
}

/**
 * 吸顶偏移量注册表
 *
 * 与MarkdownRefreshRegistry类似的模式：
 * 表格的StickyOffsetApplier组件注册回调，
 * 当外层滚动Y变化时，表格组件计算偏移量并通过本注册表通知Applier更新。
 * 只有Applier重渲染（极轻量），不触发整个表格build()。
 */
public class StickyOffsetRegistry {
    static var callbacks: HashMap<Int64, (Float64) -> Unit> = HashMap<Int64, (Float64) -> Unit>()
    static var offsets: HashMap<Int64, Float64> = HashMap<Int64, Float64>()

    /**
     * 注册吸顶偏移量回调
     * 注册时若已有缓存的偏移量，立即应用，避免组件重建时偏移量归零导致闪烁
     *
     * @param hash 组件唯一标识（使用NodeView.nodeHash）
     * @param callback 偏移量更新回调
     */
    public static func register(hash: Int64, callback: (Float64) -> Unit): Unit {
        callbacks[hash] = callback
        if (let Some(offset) <- offsets.get(hash)) {
            callback(offset)
        }
    }

    /**
     * 注销吸顶偏移量回调
     *
     * @param hash 组件唯一标识
     */
    public static func unregister(hash: Int64): Unit {
        callbacks.remove(hash)
    }

    /**
     * 更新吸顶偏移量
     * 通知对应hash的Applier组件重新渲染
     *
     * @param hash 组件唯一标识
     * @param offset 新的偏移量
     */
    public static func updateOffset(hash: Int64, offset: Float64): Unit {
        offsets[hash] = offset
        if (let Some(cb) <- callbacks.get(hash)) {
            cb(offset)
        }
    }

    /**
     * 清除所有注册和缓存的偏移量
     */
    public static func clear(): Unit {
        callbacks.clear()
        offsets.clear()
    }
}

/**
 * 外层滚动控制器
 *
 * 不固定高度模式下，页面通过此控制器将外层Scroll的滚动Y传递给MarkdownComponent，
 * MarkdownComponent再通过StickyScrollYHolder分发给表格组件，实现offset吸顶。
 *
 * 用法：
 * 1. 页面创建控制器：private mdScrollController = MarkdownScrollController()
 * 2. 传给MarkdownConfiguration：.setScrollController(mdScrollController)
 * 3. 外层Scroll的onScrollFrameBegin中调用：mdScrollController.notifyScrollY(newY)
 */
public class MarkdownScrollController {
    private var scrollYListener: ?(Float64) -> Unit = None

    /**
     * 注册滚动Y监听（由MarkdownComponent内部调用）
     *
     * @param listener 滚动Y监听回调
     */
    public func setListener(listener: ?(Float64) -> Unit): Unit {
        this.scrollYListener = listener
    }

    /**
     * 通知滚动Y变化（由页面在外层Scroll.onScrollFrameBegin中调用）
     *
     * @param yOffset 当前滚动Y值
     */
    public func notifyScrollY(yOffset: Float64): Unit {
        if (let Some(l) <- scrollYListener) {
            l(yOffset)
        }
    }
}
