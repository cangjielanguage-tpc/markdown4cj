package markdown_hybrid.components

import ohos.component.Scroller

/**
 * 表格横向滚动同步器
 *
 * 用于吸顶表头模式下，header Scroll与body Scroll的横向滚动同步。
 * 任意一端滚动时，通过currentOffset读取绝对偏移，再scrollTo到另一端，
 * 实现标题行与内容行的横向联动。
 *
 * 防抖策略：
 * - isSyncing标志位防止scrollTo触发的回调递归
 * - 仅同步用户手势触发的滚动
 */
public class TableHorizontalScrollSync {
    private var headerScroller: ?Scroller = None // header端Scroller
    private var bodyScroller: ?Scroller = None // body端Scroller
    private var offset: Float64 = 0.0 // 当前同步的横向偏移（vp）
    private var isSyncing: Bool = false // 是否正在程序化同步中（防止递归）

    /**
     * 注册header端Scroller
     * 注册时应用当前偏移，确保新挂载的header与body对齐
     *
     * @param scroller header Scroll的控制器
     */
    public func registerHeader(scroller: Scroller): Unit {
        this.headerScroller = scroller
        applyOffsetTo(scroller)
    }

    /**
     * 注册body端Scroller
     * 注册时应用当前偏移，确保新挂载的body与header对齐
     *
     * @param scroller body Scroll的控制器
     */
    public func registerBody(scroller: Scroller): Unit {
        this.bodyScroller = scroller
        applyOffsetTo(scroller)
    }

    /**
     * 注销header端Scroller
     */
    public func unregisterHeader(): Unit {
        this.headerScroller = None
    }

    /**
     * 注销body端Scroller
     */
    public func unregisterBody(): Unit {
        this.bodyScroller = None
    }

    /**
     * 通知header端发生了用户手势滚动
     *
     * @param xOffset header当前绝对横向偏移
     */
    public func onHeaderScrolled(xOffset: Float64): Unit {
        if (this.isSyncing) {
            return
        }
        this.offset = xOffset
        syncToBody(xOffset)
    }

    /**
     * 通知body端发生了用户手势滚动
     *
     * @param xOffset body当前绝对横向偏移
     */
    public func onBodyScrolled(xOffset: Float64): Unit {
        if (this.isSyncing) {
            return
        }
        this.offset = xOffset
        syncToHeader(xOffset)
    }

    /**
     * 获取当前横向偏移
     *
     * @return 当前横向偏移（vp）
     */
    public func getOffset(): Float64 {
        return this.offset
    }

    /**
     * 重置偏移（表格销毁/数据清空时调用）
     */
    public func reset(): Unit {
        this.offset = 0.0
    }

    /**
     * 将当前偏移应用到指定Scroller（新挂载时对齐用）
     *
     * @param scroller 目标Scroller
     */
    private func applyOffsetTo(scroller: Scroller): Unit {
        if (this.offset == 0.0) {
            return
        }
        this.isSyncing = true
        try {
            scroller.scrollTo(xOffset: this.offset, yOffset: 0.0)
        } catch (e: Exception) {
        }
        this.isSyncing = false
    }

    /**
     * 同步偏移到body
     *
     * @param xOffset 目标横向偏移
     */
    private func syncToBody(xOffset: Float64): Unit {
        if (let Some(scroller) <- this.bodyScroller) {
            this.isSyncing = true
            try {
                scroller.scrollTo(xOffset: xOffset, yOffset: 0.0)
            } catch (e: Exception) {
            }
            this.isSyncing = false
        }
    }

    /**
     * 同步偏移到header
     *
     * @param xOffset 目标横向偏移
     */
    private func syncToHeader(xOffset: Float64): Unit {
        if (let Some(scroller) <- this.headerScroller) {
            this.isSyncing = true
            try {
                scroller.scrollTo(xOffset: xOffset, yOffset: 0.0)
            } catch (e: Exception) {
            }
            this.isSyncing = false
        }
    }
}
