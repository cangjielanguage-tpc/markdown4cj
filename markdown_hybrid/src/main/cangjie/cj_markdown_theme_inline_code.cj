package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownInlineCodeTheme {
    /**
     * 内联代码文本颜色
     */
    var inlineCodeTextFontColor: ?Color = None

    /**
     * 内联代码文本尺寸
     */
    var inlineCodeTextFontSize: ?Float64 = None

    /**
     * 内联代码文本字体样式
     */
    var inlineCodeTextFontStyle: ?FontStyle = None

    /**
     * 内联代码文本字体粗细
     */
    var inlineCodeTextFontWeight: ?FontWeight = None

    /**
     * 内联代码文本字体
     */
    var inlineCodeTextFontFamily: ?String = None

    /**
     * 内联代码文本行高
     */
    var inlineCodeTextLineHeight: ?Float64 = None

    /**
     * 内联代码文本字符间距
     */
    var inlineCodeTextLetterSpacing: ?Float64 = None

    /**
     * 内联代码文本背景颜色
     */
    var inlineCodeTextBackgroundColor: ?Color = None

    /**
     * 内联代码文本背景左上圆角
     */
    var inlineCodeTextBackgroundRadiusTopLeft: ?Float64 = None

    /**
     * 内联代码文本背景右上圆角
     */
    var inlineCodeTextBackgroundRadiusTopRight: ?Float64 = None

    /**
     * 内联代码文本背景左下圆角
     */
    var inlineCodeTextBackgroundRadiusBottomLeft: ?Float64 = None

    /**
     * 内联代码文本背景右下圆角
     */
    var inlineCodeTextBackgroundRadiusBottomRight: ?Float64 = None

    public init() {}

    /**
     * 设置内联代码文本颜色
     *
     * @param color 文本颜色
     */
    public func setInlineCodeTextFontColor(color: UInt32): Unit {
        inlineCodeTextFontColor = transColorForTrasparent(color)
    }

    /**
     * 设置内联代码文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setInlineCodeTextFontSize(size: Float64): Unit {
        inlineCodeTextFontSize = size
    }

    /**
     * 设置内联代码文本字体样式
     *
     * @param style 文本字体样式
     */
    public func setInlineCodeTextFontStyle(style: Int64): Unit {
        inlineCodeTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置内联代码文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setInlineCodeTextFontWeight(weight: String): Unit {
        inlineCodeTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置内联代码文本字体
     *
     * @param family 文本字体
     */
    public func setInlineCodeTextFontFamily(family: String): Unit {
        inlineCodeTextFontFamily = family
    }

    /**
     * 设置内联代码文本行高
     *
     * @param lineHeight 文本行高
     */
    public func setInlineCodeTextLineHeight(lineHeight: Float64): Unit {
        inlineCodeTextLineHeight = lineHeight
    }

    /**
     * 设置内联代码文本字符间距
     *
     * @param spacing 文本字符间距
     */
    public func setInlineCodeTextLetterSpacing(spacing: Float64): Unit {
        inlineCodeTextLetterSpacing = spacing
    }

    /**
     * 设置内联代码文本背景颜色
     *
     * @param color 背景颜色
     */
    public func setInlineCodeTextBackgroundColor(color: UInt32): Unit {
        inlineCodeTextBackgroundColor = transColorForTrasparent(color)
    }

    /**
     * 设置内联代码文本背景4个圆角为统一值
     *
     * @param radius 圆角
     */
    public func setInlineCodeTextBackgroundAllRadius(radius: Float64): Unit {
        inlineCodeTextBackgroundRadiusTopLeft = radius
        inlineCodeTextBackgroundRadiusTopRight = radius
        inlineCodeTextBackgroundRadiusBottomLeft = radius
        inlineCodeTextBackgroundRadiusBottomRight = radius
    }

    /**
     * 分别设置内联代码文本背景4个圆角
     *
     * @param topLeft-左上圆角 命名参数
     * @param topRight-右上圆角 命名参数
     * @param bottomLeft-左下圆角 命名参数
     * @param bottomRight-右下圆角 命名参数
     */
    public func setInlineCodeTextBackgroundRadius(topLeft!: Float64, topRight!: Float64, bottomLeft!: Float64, bottomRight!: Float64): Unit {
        inlineCodeTextBackgroundRadiusTopLeft = topLeft
        inlineCodeTextBackgroundRadiusTopRight = topRight
        inlineCodeTextBackgroundRadiusBottomLeft = bottomLeft
        inlineCodeTextBackgroundRadiusBottomRight = bottomRight
    }
}
