package markdown.components.theme

/**
 * 高亮文本样式
 */
public class HighlightTheme <: MarkdownBaseTheme {
    public var highlightTextFontColor: ?Color = None // 高亮文本文本颜色
    public var highlightTextFontSize: ?Float64 = None // 高亮文本文本尺寸
    public var highlightTextFontStyle: ?FontStyle = None // 高亮文本文本字体样式
    public var highlightTextFontWeight: ?FontWeight = None // 高亮文本文本字体粗细
    public var highlightTextFontFamily: ?String = None // 高亮文本文本字体
    public var highlightTextLineHeight: ?Float64 = None // 高亮文本文本行高
    public var highlightTextLetterSpacing: ?Float64 = None // 高亮文本文本字符间距
    public var highlightTextBackgroundColor: Color = COLOR_FFFFF59D // 高亮文本文本背景颜色
    public var highlightTextBackgroundRadiusTopLeft: Float64 = 0.0 // 高亮文本文本背景左上圆角
    public var highlightTextBackgroundRadiusTopRight: Float64 = 0.0 // 高亮文本文本背景右上圆角
    public var highlightTextBackgroundRadiusBottomLeft: Float64 = 0.0 // 高亮文本文本背景左下圆角
    public var highlightTextBackgroundRadiusBottomRight: Float64 = 0.0 // 高亮文本文本背景右下圆角

    /**
     * 设置高亮文本颜色
     *
     * @param color 高亮文本颜色
     * @return 当前HighlightTheme对象
     */
    public func setHighlightTextFontColor(color: Color): HighlightTheme {
        this.highlightTextFontColor = color
        return this
    }

    /**
     * 设置高亮文本尺寸
     *
     * @param size 高亮文本尺寸
     * @return 当前HighlightTheme对象
     */
    public func setHighlightTextFontSize(size: Float64): HighlightTheme {
        this.highlightTextFontSize = size
        return this
    }

    /**
     * 设置高亮文本字体样式
     *
     * @param style 高亮文本字体样式
     * @return 当前HighlightTheme对象
     */
    public func setHighlightTextFontStyle(style: FontStyle): HighlightTheme {
        this.highlightTextFontStyle = style
        return this
    }

    /**
     * 设置高亮文本字体粗细
     *
     * @param weight 高亮文本字体粗细
     * @return 当前HighlightTheme对象
     */
    public func setHighlightTextFontWeight(weight: FontWeight): HighlightTheme {
        this.highlightTextFontWeight = weight
        return this
    }

    /**
     * 设置高亮文本字体
     *
     * @param family 高亮文本字体
     * @return 当前HighlightTheme对象
     */
    public func setHighlightTextFontFamily(family: String): HighlightTheme {
        this.highlightTextFontFamily = family
        return this
    }

    /**
     * 设置高亮文本行高
     *
     * @param lineHeight 高亮文本行高
     * @return 当前HighlightTheme对象
     */
    public func setHighlightTextLineHeight(lineHeight: Float64): HighlightTheme {
        this.highlightTextLineHeight = lineHeight
        return this
    }

    /**
     * 设置高亮文本字符间距
     *
     * @param spacing 高亮文本字符间距
     * @return 当前HighlightTheme对象
     */
    public func setHighlightTextLetterSpacing(spacing: Float64): HighlightTheme {
        this.highlightTextLetterSpacing = spacing
        return this
    }

    /**
     * 设置高亮文本背景颜色
     *
     * @param color 高亮文本背景颜色
     * @return 当前HighlightTheme对象
     */
    public func setHighlightTextBackgroundColor(color: Color): HighlightTheme {
        this.highlightTextBackgroundColor = color
        return this
    }

    /**
     * 统一设置高亮文本背景整体圆角
     *
     * @param radius 圆角
     * @return 当前HighlightTheme对象
     */
    public func setHighlightTextBackgroundRadius(radius: Float64): HighlightTheme {
        this.highlightTextBackgroundRadiusTopLeft = radius
        this.highlightTextBackgroundRadiusTopRight = radius
        this.highlightTextBackgroundRadiusBottomLeft = radius
        this.highlightTextBackgroundRadiusBottomRight = radius
        return this
    }

    /**
     * 分别设置高亮文本背景四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前HighlightTheme对象
     */
    public func setHighlightTextBackgroundRadius(topLeft!: Float64 = 0.0, topRight!: Float64 = 0.0, bottomLeft!: Float64 = 0.0, bottomRight!: Float64 = 0.0): HighlightTheme {
        this.highlightTextBackgroundRadiusTopLeft = topLeft
        this.highlightTextBackgroundRadiusTopRight = topRight
        this.highlightTextBackgroundRadiusBottomLeft = bottomLeft
        this.highlightTextBackgroundRadiusBottomRight = bottomRight
        return this
    }
}
