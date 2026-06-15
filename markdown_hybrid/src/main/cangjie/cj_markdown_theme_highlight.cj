package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownHighlightTheme {
    /**
     * 高亮文本文本颜色
     */
    var highlightTextFontColor: ?Color = None
    /**
     * 高亮文本文本尺寸
     */
    var highlightTextFontSize: ?Float64 = None
    /**
     * 高亮文本文本字体样式
     */
    var highlightTextFontStyle: ?FontStyle = None
    /**
     * 高亮文本文本字体粗细
     */
    var highlightTextFontWeight: ?FontWeight = None
    /**
     * 高亮文本文本字体
     */
    var highlightTextFontFamily: ?String = None
    /**
     * 高亮文本文本行高
     */
    var highlightTextLineHeight: ?Float64 = None
    /**
     * 高亮文本文本字符间距
     */
    var highlightTextLetterSpacing: ?Float64 = None
    /**
     * 高亮文本文本背景颜色
     */
    var highlightTextBackgroundColor: ?Color = None
    /**
     * 高亮文本文本背景左上圆角
     */
    var highlightTextBackgroundRadiusTopLeft: ?Float64 = None
    /**
     * 高亮文本文本背景右上圆角
     */
    var highlightTextBackgroundRadiusTopRight: ?Float64 = None
    /**
     * 高亮文本文本背景左下圆角
     */
    var highlightTextBackgroundRadiusBottomLeft: ?Float64 = None
    /**
     * 高亮文本文本背景右下圆角
     */
    var highlightTextBackgroundRadiusBottomRight: ?Float64 = None

    public init() {}

    /**
     * 设置高亮文本颜色
     *
     * @param color 高亮文本颜色
     */
    public func setHighlightTextFontColor(color: UInt32): Unit {
        highlightTextFontColor = transColorForTransparent(color)
    }
    /**
     * 设置高亮文本尺寸
     *
     * @param size 高亮文本尺寸
     */
    public func setHighlightTextFontSize(size: Float64): Unit {
        highlightTextFontSize = size
    }
    /**
     * 设置高亮文本字体样式
     *
     * @param style 高亮文本字体样式
     */
    public func setHighlightTextFontStyle(style: Int64): Unit {
        highlightTextFontStyle = convertFontStyle(style)
    }
    /**
     * 设置高亮文本字体粗细
     *
     * @param weight 高亮文本字体粗细
     */
    public func setHighlightTextFontWeight(weight: Int64): Unit {
        highlightTextFontWeight = convertFontWeight(weight)
    }
    /**
     * 设置高亮文本字体
     *
     * @param family 高亮文本字体
     */
    public func setHighlightTextFontFamily(family: String): Unit {
        highlightTextFontFamily = family
    }
    /**
     * 设置高亮文本行高
     *
     * @param lineHeight 高亮文本行高
     */
    public func setHighlightTextLineHeight(lineHeight: Float64): Unit {
        highlightTextLineHeight = lineHeight
    }
    /**
     * 设置高亮文本字符间距
     *
     * @param spacing 高亮文本字符间距
     */
    public func setHighlightTextLetterSpacing(spacing: Float64): Unit {
        highlightTextLetterSpacing = spacing
    }
    /**
     * 设置高亮文本背景颜色
     *
     * @param color 高亮文本背景颜色
     */
    public func setHighlightTextBackgroundColor(color: UInt32): Unit {
        highlightTextBackgroundColor = transColorForTransparent(color)
    }
    /**
     * 设置高亮文本背景4个圆角为统一值
     *
     * @param radius 圆角
     */
    public func setHighlightTextBackgroundAllRadius(radius: Float64): Unit {
        highlightTextBackgroundRadiusTopLeft = radius
        highlightTextBackgroundRadiusTopRight = radius
        highlightTextBackgroundRadiusBottomLeft = radius
        highlightTextBackgroundRadiusBottomRight = radius
    }
    /**
     * 分别设置高亮文本背景4个圆角
     *
     * @param topLeft-左上圆角 命名参数
     * @param topRight-右上圆角 命名参数
     * @param bottomLeft-左下圆角 命名参数
     * @param bottomRight-右下圆角 命名参数
     */
    public func setHighlightTextBackgroundRadius(topLeft!: Float64, topRight!: Float64, bottomLeft!: Float64, bottomRight!: Float64): Unit {
        highlightTextBackgroundRadiusTopLeft = topLeft
        highlightTextBackgroundRadiusTopRight = topRight
        highlightTextBackgroundRadiusBottomLeft = bottomLeft
        highlightTextBackgroundRadiusBottomRight = bottomRight
    }
}
