package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownDefinitionListTheme {
    /**
     * 定义列表背景颜色
     */
    var definitionListBackgroundColor: ?Color = None

    /**
     * 定义列表上外边距
     */
    var definitionListMarginTop: ?Float64 = None

    /**
     * 定义列表右外边距
     */
    var definitionListMarginRight: ?Float64 = None

    /**
     * 定义列表下外边距
     */
    var definitionListMarginBottom: ?Float64 = None

    /**
     * 定义列表左外边距
     */
    var definitionListMarginLeft: ?Float64 = None

    /**
     * 定义列表上内边距
     */
    var definitionListPaddingTop: ?Float64 = None

    /**
     * 定义列表右内边距
     */
    var definitionListPaddingRight: ?Float64 = None

    /**
     * 定义列表下内边距
     */
    var definitionListPaddingBottom: ?Float64 = None

    /**
     * 定义列表左内边距
     */
    var definitionListPaddingLeft: ?Float64 = None

    /**
     * 定义列表术语和定义行之间间距
     */
    var definitionListTermToDescriptionSpacing: ?Float64 = None

    /**
     * 定义列表术语文本字体粗细
     */
    var definitionListTermTextFontWeight: ?FontWeight = None

    /**
     * 定义列表术语文本字体样式
     */
    var definitionListTermTextFontStyle: ?FontStyle = None

    /**
     * 定义列表定义行之间间距
     */
    var definitionListDescriptionItemSpacing: ?Float64 = None

    /**
     * 定义列表定义行左缩进距离
     */
    var definitionListDescriptionIndent: ?Float64 = None

    public init() {}

    /**
     * 设置定义列表背景颜色
     *
     * @param color 背景颜色
     */
    public func setDefinitionListBackgroundColor(color: UInt32): Unit {
        definitionListBackgroundColor = transColorForTrasparent(color)
    }

    /**
     * 设置4个外边距为统一值
     *
     * @param margin 外边距
     */
    public func setDefinitionListAllMargin(margin: Float64): Unit {
        definitionListMarginTop = margin
        definitionListMarginRight = margin
        definitionListMarginBottom = margin
        definitionListMarginLeft = margin
    }

    /**
     * 分别设置4个外边距
     *
     * @param top-上外边距 命名参数
     * @param right-右外边距 命名参数
     * @param bottom-下外边距 命名参数
     * @param left-左外边距 命名参数
     */
    public func setDefinitionListMargin(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        definitionListMarginTop = top
        definitionListMarginRight = right
        definitionListMarginBottom = bottom
        definitionListMarginLeft = left
    }

    /**
     * 设置4个内边距为统一值
     *
     * @param padding 内边距
     */
    public func setDefinitionListAllPadding(padding: Float64): Unit {
        definitionListPaddingTop = padding
        definitionListPaddingRight = padding
        definitionListPaddingBottom = padding
        definitionListPaddingLeft = padding
    }

    /**
     * 分别设置4个内边距
     *
     * @param top-上内边距 命名参数
     * @param right-右内边距 命名参数
     * @param bottom-下内边距 命名参数
     * @param left-左内边距 命名参数
     */
    public func setDefinitionListPadding(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        definitionListPaddingTop = top
        definitionListPaddingRight = right
        definitionListPaddingBottom = bottom
        definitionListPaddingLeft = left
    }

    /**
     * 设置定义列表术语和定义行之间间距
     *
     * @param spacing 间距
     */
    public func setDefinitionListTermToDescriptionSpacing(spacing: Float64): Unit {
        definitionListTermToDescriptionSpacing = spacing
    }

    /**
     * 定义列表术语文本字体粗细
     *
     * @param isBold 是否加粗
     */
    public func setDefinitionListTermTextFontWeight(weight: Int64): Unit {
        definitionListTermTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 定义列表术语文本字体样式
     *
     * @param isBold 是否加粗
     */
    public func setDefinitionListTermTextFontStyle(style: Int64): Unit {
        definitionListTermTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置定义列表定义行之间间距
     *
     * @param spacing 间距
     */
    public func setDefinitionListDescriptionItemSpacing(spacing: Float64): Unit {
        definitionListDescriptionItemSpacing = spacing
    }

    /**
     * 设置定义列表定义行左缩进距离
     *
     * @param indent 左缩进距离
     */
    public func setDefinitionListDescriptionIndent(indent: Float64): Unit {
        definitionListDescriptionIndent = indent
    }
}
