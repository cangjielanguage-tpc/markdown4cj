package markdown.components.theme

/**
 * 内联代码样式
 */
public class InlineCodeTheme <: MarkdownBaseTheme {
    public var inlineCodeTextFontColor: ?Color = None // 内联代码文本颜色
    public var inlineCodeTextFontSize: ?Float64 = None // 内联代码文本尺寸
    public var inlineCodeTextFontStyle: ?FontStyle = None // 内联代码文本字体样式
    public var inlineCodeTextFontWeight: ?FontWeight = None // 内联代码文本字体粗细
    public var inlineCodeTextFontFamily: ?String = None // 内联代码文本字体
    public var inlineCodeTextLineHeight: ?Float64 = None // 内联代码文本行高
    public var inlineCodeTextLetterSpacing: ?Float64 = None // 内联代码文本字符间距
    public var inlineCodeTextBackgroundColor: Color = COLOR_FFEAEAEA // 内联代码文本背景颜色
    public var inlineCodeTextBackgroundRadiusTopLeft: Float64 = 0.0 // 内联代码文本背景左上圆角
    public var inlineCodeTextBackgroundRadiusTopRight: Float64 = 0.0 // 内联代码文本背景右上圆角
    public var inlineCodeTextBackgroundRadiusBottomLeft: Float64 = 0.0 // 内联代码文本背景左下圆角
    public var inlineCodeTextBackgroundRadiusBottomRight: Float64 = 0.0 // 内联代码文本背景右下圆角

    /**
     * 设置内联代码文本颜色
     *
     * @param color 内联代码文本颜色
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextFontColor(color: Color): InlineCodeTheme {
        this.inlineCodeTextFontColor = color
        return this
    }

    /**
     * 设置内联代码文本尺寸
     *
     * @param size 内联代码文本尺寸
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextFontSize(size: Float64): InlineCodeTheme {
        this.inlineCodeTextFontSize = size
        return this
    }

    /**
     * 设置内联代码文本字体样式
     *
     * @param style 内联代码文本字体样式
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextFontStyle(style: FontStyle): InlineCodeTheme {
        this.inlineCodeTextFontStyle = style
        return this
    }

    /**
     * 设置内联代码文本字体粗细
     *
     * @param weight 内联代码文本字体粗细
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextFontWeight(weight: FontWeight): InlineCodeTheme {
        this.inlineCodeTextFontWeight = weight
        return this
    }

    /**
     * 设置内联代码文本字体
     *
     * @param family 内联代码文本字体
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextFontFamily(family: String): InlineCodeTheme {
        this.inlineCodeTextFontFamily = family
        return this
    }

    /**
     * 设置内联代码文本行高
     *
     * @param lineHeight 内联代码文本行高
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextLineHeight(lineHeight: Float64): InlineCodeTheme {
        this.inlineCodeTextLineHeight = lineHeight
        return this
    }

    /**
     * 设置内联代码文本字符间距
     *
     * @param spacing 内联代码文本字符间距
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextLetterSpacing(spacing: Float64): InlineCodeTheme {
        this.inlineCodeTextLetterSpacing = spacing
        return this
    }

    /**
     * 设置内联代码文本背景颜色
     *
     * @param color 内联代码文本背景颜色
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextBackgroundColor(color: Color): InlineCodeTheme {
        this.inlineCodeTextBackgroundColor = color
        return this
    }

    /**
     * 统一设置内联代码文本背景整体圆角
     *
     * @param radius 圆角
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextBackgroundRadius(radius: Float64): InlineCodeTheme {
        this.inlineCodeTextBackgroundRadiusTopLeft = radius
        this.inlineCodeTextBackgroundRadiusTopRight = radius
        this.inlineCodeTextBackgroundRadiusBottomLeft = radius
        this.inlineCodeTextBackgroundRadiusBottomRight = radius
        return this
    }

    /**
     * 分别设置内联代码文本背景四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextBackgroundRadius(topLeft!: Float64 = 0.0, topRight!: Float64 = 0.0, bottomLeft!: Float64 = 0.0, bottomRight!: Float64 = 0.0): InlineCodeTheme {
        this.inlineCodeTextBackgroundRadiusTopLeft = topLeft
        this.inlineCodeTextBackgroundRadiusTopRight = topRight
        this.inlineCodeTextBackgroundRadiusBottomLeft = bottomLeft
        this.inlineCodeTextBackgroundRadiusBottomRight = bottomRight
        return this
    }
}