package markdown_hybrid

import ohos.ark_interop_macro.*

/**
 * 元素曝光事件（对齐ArkTS MarkdownExposureEvent：eventType/visible/data）
 */
@Interop[ArkTS]
public class CJMarkdownExposureEvent {
    /**
     * 曝光元素的类型。暂时只有 'link'，预留 'image'/'regex'
     */
    public var eventType: String = ""

    /**
     * 是否可见。true=进入可见态（显示），false=离开可见态（消失）
     */
    public var visible: Bool = false

    /**
     * 元素数据。eventType='link' 时为链接 url 字符串
     */
    public var data: String = ""

    public init() {}
}

/**
 * 段落高亮配置（互操作封装）
 *
 * 管理可高亮段落的nodeHash集合，外部通过getAllParagraphItems获取全部可高亮段落，
 * 通过setParagraphHighlight/clearParagraphHighlight控制高亮状态。
 */
@Interop[ArkTS]
public class CJMarkdownHighlightParagraph {
    /**
     * 内部段落高亮对象（对ArkTS不可见）
     */
    @Interop[ArkTS, Invisible]
    public var highlightParagraph: MarkdownHighlightParagraph = MarkdownHighlightParagraph.create()

    /**
     * 段落nodeHash现算器（对ArkTS不可见）。
     * 核心MarkdownComponent的@Prop配置被拷贝，rebuildIndexes写回的段落集合落在副本上，
     * 本实例读不到；getAllParagraphItems优先通过该现算器从解析树获取最新集合。
     */
    @Interop[ArkTS, Invisible]
    public var hashCollector: ?() -> ArrayList<String> = None

    public init() {}

    /**
     * 获取所有可以设置高亮的段落的nodeHash集合
     *
     * 优先通过现算器从解析树获取（与核心rebuildIndexes同源同规则，流式场景自动跟随最新解析结果）；
     * 未设置现算器时回退读实例字段（核心写回路径）。
     *
     * @return 段落nodeHash集合
     */
    public func getAllParagraphItems(): JSArrayEx<String> {
        let result = ArrayList<String>()
        if (let Some(c) <- hashCollector) {
            for (item in c()) {
                result.add(item)
            }
        } else {
            for (item in this.highlightParagraph.getAllParagraphItems()) {
                result.add(item)
            }
        }
        return JSArrayEx<String>(result.toArray())
    }

    /**
     * 设置指定段落高亮显示
     * 多次设置时先清除已有高亮，全局仅保留最后一次设置的段落和颜色
     *
     * @param nodeHash 段落的nodeHash
     * @param color 段落高亮颜色（ARGB值，如0xFFFA8072）
     * @return 是否设置成功 false表示未找到nodeHash
     */
    public func setParagraphHighlight(nodeHash: String, color: Float64): Bool {
        return this.highlightParagraph.setParagraphHighlight(nodeHash, transColorForTransparent(UInt32(color)))
    }

    /**
     * 取消指定段落的高亮
     *
     * @param nodeHash 段落的nodeHash
     * @return 是否取消成功 false表示该段落没有高亮或者未找到nodeHash
     */
    public func clearParagraphHighlight(nodeHash: String): Bool {
        return this.highlightParagraph.clearParagraphHighlight(nodeHash)
    }

    /**
     * 取消所有段落高亮
     */
    public func clearAllParagraphHighlights(): Unit {
        this.highlightParagraph.clearAllParagraphHighlights()
    }
}

/**
 * 外层滚动控制器（互操作封装）
 *
 * 不固定高度模式下，页面通过此控制器将外层Scroll的滚动Y传递给MarkdownComponent，
 * 实现表格吸顶功能。固定高度模式下无需设置。
 */
@Interop[ArkTS]
public class CJMarkdownScrollController {
    /**
     * 内部滚动控制器（对ArkTS不可见）
     */
    @Interop[ArkTS, Invisible]
    public var scrollController: MarkdownScrollController = MarkdownScrollController()

    public init() {}

    /**
     * 通知滚动Y变化（由页面在外层Scroll.onScrollFrameBegin中调用）
     *
     * @param y 当前外层Scroll的滚动Y值（应为relativeScrollY = scrollY - markdownStartY）
     */
    public func setScrollY(y: Float64): Unit {
        this.scrollController.notifyScrollY(y)
    }
}
