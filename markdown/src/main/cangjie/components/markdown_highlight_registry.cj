package markdown.components

/**
 * 段落高亮注册表（静态）
 * 用户通过 highlight(nodeHash, color) 高亮指定段落，clearHighlight(nodeHash) 取消高亮，
 * clearAll() 取消所有高亮。
 *
 * 段落组件（MarkdownParagraphComponent / MarkdownHeadingComponent）在 aboutToAppear 时
 * 调用 register 注册监听器，aboutToDisappear 时调用 unregister 注销。
 * 高亮颜色会被缓存，组件销毁后重建（LazyForEach）时自动恢复高亮状态。
 *
 * 用法：
 *   MarkdownHighlightRegistry.highlight(nodeHash, COLOR_FFFFE0B2) // 高亮
 *   MarkdownHighlightRegistry.clearHighlight(nodeHash)             // 取消单条
 *   MarkdownHighlightRegistry.clearAll()                           // 取消全部
 */
public class MarkdownHighlightRegistry {
    static var highlightColors: HashMap<Int64, Color> = HashMap<Int64, Color>()
    static var listeners: HashMap<Int64, (?Color) -> Unit> = HashMap<Int64, (?Color) -> Unit>()

    // 长按前段落默认背景色（配置型，静态中转：核心@Prop配置深拷贝导致实例脱钩，渲染侧从静态读取）
    public static var beforeSelectedBackgroundColor: ?Color = Option<Color>.None
    // 长按选中段落的背景色（配置型，静态中转：核心@Prop配置深拷贝导致实例脱钩，渲染侧从静态读取）
    public static var selectedBackgroundColor: ?Color = Option<Color>.None

    /**
     * 注册段落高亮监听器
     * 若该nodeHash已有缓存的高亮颜色，立即调用listener应用
     *
     * @param nodeHash 段落节点hash
     * @param listener 高亮颜色变化监听器 (?Color: None=取消高亮, Some(color)=高亮)
     */
    public static func register(nodeHash: Int64, listener: (?Color) -> Unit): Unit {
        listeners[nodeHash] = listener
        if (let Some(color) <- highlightColors.get(nodeHash)) {
            listener(Some(color))
        }
    }

    /**
     * 注销段落高亮监听器
     * 不清除缓存的高亮颜色（组件重建时自动恢复）
     *
     * @param nodeHash 段落节点hash
     */
    public static func unregister(nodeHash: Int64): Unit {
        listeners.remove(nodeHash)
    }

    /**
     * 高亮指定段落
     *
     * @param nodeHash 段落节点hash
     * @param color 高亮颜色
     */
    public static func highlight(nodeHash: Int64, color: Color): Bool {
        highlightColors[nodeHash] = color
        if (let Some(listener) <- listeners.get(nodeHash)) {
            listener(Some(color))
            return true
        } else {
            return false
        }
    }

    /**
     * 取消指定段落高亮
     *
     * @param nodeHash 段落节点hash
     */
    public static func clearHighlight(nodeHash: Int64): Bool {
        highlightColors.remove(nodeHash)
        if (let Some(listener) <- listeners.get(nodeHash)) {
            listener(Option<Color>.None)
            return true
        } else {
            return false
        }
    }

    /**
     * 取消所有段落高亮
     * 通知所有已注册的监听器取消高亮，保留监听器注册关系
     */
    public static func clearAll(): Unit {
        for ((_, listener) in listeners) {
            listener(Option<Color>.None)
        }
        highlightColors.clear()
    }

    /**
     * 清空所有数据（监听器+高亮颜色+背景色配置）
     * 由MarkdownComponent在aboutToDisappear时调用
     */
    public static func clear(): Unit {
        highlightColors.clear()
        listeners.clear()
        beforeSelectedBackgroundColor = Option<Color>.None
        selectedBackgroundColor = Option<Color>.None
    }
}
