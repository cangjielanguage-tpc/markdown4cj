package markdown.components

import std.collection.HashMap
import ohos.component.Scroller

/**
 * 外层滚动Y持有者（监听器模式）
 *
 * 对齐ArkUI StickyScrollYHolder.ets：通过对象引用传递（引用不变，不触发build()），
 * 通过监听器模式通知表格组件更新吸顶偏移量。
 * 由MarkdownComponent创建，@Provide给后代Table @Consume使用。
 *
 * scrollY语义（对齐ArkUI AIChatTableStickyPage）：
 *   - 外层Scroll模式（scrollController提供）：页面传递relativeScrollY = scrollY - markdownStartY
 *     （markdown起点已滚出视口顶部的距离；<0表示markdown尚未到达视口顶部）
 *   - 内层List模式（无scrollController）：onScroll传递List内部scrollY
 *     （List内部滚动偏移；=0表示未滚动）
 */
public class StickyScrollYHolder {
    private var y: Float64 = 0.0 // 当前滚动Y（由页面或onScroll设置）
    private var enabled: Bool = false // 是否启用吸顶模式
    private var listeners: HashMap<Int64, (Float64) -> Unit> = HashMap<Int64, (Float64) -> Unit>()
    private var nextId: Int64 = 0
    private var listScroller: ?Scroller = Option<Scroller>.None // 内层List的Scroller（用于getItemRect查询ListItem在List中的布局位置）

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
     * 设置内层List的Scroller
     * 表格组件通过此Scroller的getItemRect接口查询自身ListItem在List中的布局位置，
     * 与getListScrollY()配合计算ListItem在List内容中的绝对布局位置（layout-time常量）。
     *
     * @param scroller 内层List的Scroller
     */
    public func setScroller(scroller: Scroller): Unit {
        this.listScroller = scroller
    }

    /**
     * 查询指定索引的ListItem在List视口中的当前Y位置
     * 当ListItem位于视口顶部时返回0；向上滚出视口时返回负值；尚未到达视口时返回正值
     * 索引非法或不可见时返回0
     *
     * @param index ListItem在List中的索引
     * @return ListItem相对List视口顶部的Y位置（vp）
     */
    public func getListItemY(index: Int32): Float64 {
        if (let Some(scroller) <- listScroller) {
            let rect = scroller.getItemRect(index)
            return rect.y
        }
        return 0.0
    }

    /**
     * 获取内层List的当前滚动偏移量
     * 用于计算ListItem在List内容中的绝对布局位置：
     *   listItemPositionInList = getListItemY(index) + getListScrollY()
     * 该值为layout-time常量（ListItem在List内容中的位置不随滚动变化）。
     *
     * @return List的当前yOffset（未滚动时为0）
     */
    public func getListScrollY(): Float64 {
        if (let Some(scroller) <- listScroller) {
            return scroller.currentOffset().yOffset
        }
        return 0.0
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
 * 外层滚动控制器（对齐ArkUI MarkdownScrollController.ets）
 *
 * 不固定高度模式下，页面通过此控制器将外层Scroll的滚动Y传递给MarkdownComponent，
 * MarkdownComponent再通过StickyScrollYHolder分发给表格组件，实现offset吸顶。
 *
 * 用法：
 * 1. 页面创建控制器：private mdScrollController = MarkdownScrollController()
 * 2. 传给MarkdownConfiguration：.setScrollController(mdScrollController)
 * 3. 外层Scroll的onScrollFrameBegin中调用：mdScrollController.notifyScrollY(relativeScrollY)
 *    其中 relativeScrollY = scrollY - markdownStartY（markdown起点已滚出视口顶部的距离）
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
     * @param yOffset 当前外层Scroll的滚动Y值（应为relativeScrollY = scrollY - markdownStartY）
     */
    public func notifyScrollY(yOffset: Float64): Unit {
        if (let Some(l) <- scrollYListener) {
            l(yOffset)
        }
    }
}
