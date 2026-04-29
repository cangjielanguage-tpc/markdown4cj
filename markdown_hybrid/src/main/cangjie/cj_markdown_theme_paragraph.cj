package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownParagraphTheme {
    /**
     * 段落背景颜色
     */
    var paragraphBackgroundColor: ?Color = None

    /**
     * 段落上外边距
     */
    var paragraphMarginTop: ?Float64 = None

    /**
     * 段落右外边距
     */
    var paragraphMarginRight: ?Float64 = None

    /**
     * 段落下外边距
     */
    var paragraphMarginBottom: ?Float64 = None

    /**
     * 段落左外边距
     */
    var paragraphMarginLeft: ?Float64 = None

    /**
     * 段落上内边距
     */
    var paragraphPaddingTop: ?Float64 = None

    /**
     * 段落右内边距
     */
    var paragraphPaddingRight: ?Float64 = None

    /**
     * 段落下内边距
     */
    var paragraphPaddingBottom: ?Float64 = None

    /**
     * 段落左内边距
     */
    var paragraphPaddingLeft: ?Float64 = None

    /**
     * 段落文本颜色
     */
    var paragraphTextFontColor: ?Color = None

    /**
     * 段落文本尺寸
     */
    var paragraphTextFontSize: ?Float64 = None

    /**
     * 段落文本字体样式
     */
    var paragraphTextFontStyle: ?FontStyle = None

    /**
     * 段落文本字体粗细
     */
    var paragraphTextFontWeight: ?FontWeight = None

    /**
     * 段落文本字体
     */
    var paragraphTextFontFamily: ?String = None

    /**
     * 段落文本行高
     */
    var paragraphTextLineHeight: ?Float64 = None

    /**
     * 段落文本字符间距
     */
    var paragraphTextLetterSpacing: ?Float64 = None

    public init() {}

    /**
     * 设置段落背景颜色
     *
     * @param color 背景颜色
     */
    public func setParagraphBackgroundColor(color: UInt32): Unit {
        paragraphBackgroundColor = transColorForTrasparent(color)
    }

    /**
     * 设置4个外边距为统一值
     *
     * @param margin 外边距
     */
    public func setParagraphAllMargin(margin: Float64): Unit {
        paragraphMarginTop = margin
        paragraphMarginRight = margin
        paragraphMarginBottom = margin
        paragraphMarginLeft = margin
    }

    /**
     * 分别设置4个外边距
     *
     * @param top-上外边距 命名参数
     * @param right-右外边距 命名参数
     * @param bottom-下外边距 命名参数
     * @param left-左外边距 命名参数
     */
    public func setParagraphMargin(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        paragraphMarginTop = top
        paragraphMarginRight = right
        paragraphMarginBottom = bottom
        paragraphMarginLeft = left
    }

    /**
     * 设置4个内边距为统一值
     *
     * @param padding 内边距
     */
    public func setParagraphAllPadding(padding: Float64): Unit {
        paragraphPaddingTop = padding
        paragraphPaddingRight = padding
        paragraphPaddingBottom = padding
        paragraphPaddingLeft = padding
    }

    /**
     * 分别设置4个内边距
     *
     * @param top-上内边距 命名参数
     * @param right-右内边距 命名参数
     * @param bottom-下内边距 命名参数
     * @param left-左内边距 命名参数
     */
    public func setParagraphPadding(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        paragraphPaddingTop = top
        paragraphPaddingRight = right
        paragraphPaddingBottom = bottom
        paragraphPaddingLeft = left
    }

    /**
     * 设置段落文本颜色
     *
     * @param color 文本颜色
     */
    public func setParagraphTextFontColor(color: UInt32): Unit {
        paragraphTextFontColor = transColorForTrasparent(color)
    }

    /**
     * 设置段落文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setParagraphTextFontSize(size: Float64): Unit {
        paragraphTextFontSize = size
    }

    /**
     * 设置段落文本字体样式
     *
     * @param style 文本字体样式
     */
    public func setParagraphTextFontStyle(style: Int64): Unit {
        paragraphTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置段落文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setParagraphTextFontWeight(weight: Int64): Unit {
        paragraphTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置段落文本字体
     *
     * @param family 文本字体
     */
    public func setParagraphTextFontFamily(family: String): Unit {
        paragraphTextFontFamily = family
    }

    /**
     * 设置段落文本行高
     *
     * @param lineHeight 文本行高
     */
    public func setParagraphTextLineHeight(lineHeight: Float64): Unit {
        paragraphTextLineHeight = lineHeight
    }

    /**
     * 设置段落文本字符间距
     *
     * @param spacing 文本字符间距
     */
    public func setParagraphTextLetterSpacing(spacing: Float64): Unit {
        paragraphTextLetterSpacing = spacing
    }
}
