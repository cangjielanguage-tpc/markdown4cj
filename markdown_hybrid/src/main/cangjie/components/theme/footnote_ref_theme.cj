package markdown.components.theme

/**
 * 脚注引用样式
 */
public class FootnoteRefTheme <: MarkdownBaseTheme {
    public var footnoteRefTextFontColor: Color = COLOR_RED // 脚注引用文本颜色
    public var footnoteRefTextFontSize: ?Float64 = None // 脚注引用文本尺寸
    public var footnoteRefTextFontStyle: ?FontStyle = None // 脚注引用文本字体样式
    public var footnoteRefTextFontWeight: ?FontWeight = None // 脚注引用文本字体粗细
    public var footnoteRefTextFontFamily: ?String = None // 脚注引用文本字体
    public var footnoteRefTextLineHeight: ?Float64 = None // 脚注引用文本行高
    public var footnoteRefTextLetterSpacing: ?Float64 = None // 脚注引用文本字符间距
    public var footnoteRefTextDecorationType: TextDecorationType = TextDecorationType.Underline // 脚注引用文本装饰线类型
    public var footnoteRefTextDecorationColor: Color = COLOR_RED // 脚注引用文本装饰线颜色
    public var footnoteRefTextDecorationStyle: MarkdownTextDecorationStyle = MarkdownTextDecorationStyle.SOLID // 脚注引用文本装饰线样式
    public var footnoteRefTextBackgroundColor: Color = COLOR_TRANSPARENT // 脚注引用文本背景颜色
    public var footnoteRefTextBackgroundRadiusTopLeft: Float64 = 0.0 // 脚注引用文本背景左上圆角
    public var footnoteRefTextBackgroundRadiusTopRight: Float64 = 0.0 // 脚注引用文本背景右上圆角
    public var footnoteRefTextBackgroundRadiusBottomLeft: Float64 = 0.0 // 脚注引用文本背景左下圆角
    public var footnoteRefTextBackgroundRadiusBottomRight: Float64 = 0.0 // 脚注引用文本背景右下圆角

    /**
     * 设置脚注引用文本颜色
     *
     * @param color 脚注引用文本颜色
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextFontColor(color: Color): FootnoteRefTheme {
        this.footnoteRefTextFontColor = color
        return this
    }

    /**
     * 设置脚注引用文本尺寸
     *
     * @param size 脚注引用文本尺寸
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextFontSize(size: Float64): FootnoteRefTheme {
        this.footnoteRefTextFontSize = size
        return this
    }

    /**
     * 设置脚注引用文本字体样式
     *
     * @param style 脚注引用文本字体样式
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextFontStyle(style: FontStyle): FootnoteRefTheme {
        this.footnoteRefTextFontStyle = style
        return this
    }

    /**
     * 设置脚注引用文本字体粗细
     *
     * @param weight 脚注引用文本字体粗细
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextFontWeight(weight: FontWeight): FootnoteRefTheme {
        this.footnoteRefTextFontWeight = weight
        return this
    }

    /**
     * 设置脚注引用文本字体
     *
     * @param family 脚注引用文本字体
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextFontFamily(family: String): FootnoteRefTheme {
        this.footnoteRefTextFontFamily = family
        return this
    }

    /**
     * 设置脚注引用文本行高
     *
     * @param lineHeight 脚注引用文本行高
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextLineHeight(lineHeight: Float64): FootnoteRefTheme {
        this.footnoteRefTextLineHeight = lineHeight
        return this
    }

    /**
     * 设置脚注引用文本字符间距
     *
     * @param spacing 脚注引用文本字符间距
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextLetterSpacing(spacing: Float64): FootnoteRefTheme {
        this.footnoteRefTextLetterSpacing = spacing
        return this
    }

    /**
     * 设置脚注引用文本装饰线类型
     *
     * @param decorationType 脚注引用文本装饰线类型
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextDecorationType(decorationType: TextDecorationType): FootnoteRefTheme {
        this.footnoteRefTextDecorationType = decorationType
        return this
    }

    /**
     * 设置脚注引用文本装饰线颜色
     *
     * @param color 脚注引用文本装饰线颜色
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextDecorationColor(color: Color): FootnoteRefTheme {
        this.footnoteRefTextDecorationColor = color
        return this
    }

    /**
     * 设置脚注引用文本装饰线样式
     *
     * @param style 脚注引用文本装饰线样式
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextDecorationStyle(style: MarkdownTextDecorationStyle): FootnoteRefTheme {
        this.footnoteRefTextDecorationStyle = style
        return this
    }

    /**
     * 设置脚注引用文本背景颜色
     *
     * @param color 脚注引用文本背景颜色
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextBackgroundColor(color: Color): FootnoteRefTheme {
        this.footnoteRefTextBackgroundColor = color
        return this
    }

    /**
     * 统一设置脚注引用文本背景整体圆角
     *
     * @param radius 圆角
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextBackgroundRadius(radius: Float64): FootnoteRefTheme {
        this.footnoteRefTextBackgroundRadiusTopLeft = radius
        this.footnoteRefTextBackgroundRadiusTopRight = radius
        this.footnoteRefTextBackgroundRadiusBottomLeft = radius
        this.footnoteRefTextBackgroundRadiusBottomRight = radius
        return this
    }

    /**
     * 分别设置脚注引用文本背景四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextBackgroundRadius(topLeft!: Float64 = 0.0, topRight!: Float64 = 0.0, bottomLeft!: Float64 = 0.0, bottomRight!: Float64 = 0.0): FootnoteRefTheme {
        this.footnoteRefTextBackgroundRadiusTopLeft = topLeft
        this.footnoteRefTextBackgroundRadiusTopRight = topRight
        this.footnoteRefTextBackgroundRadiusBottomLeft = bottomLeft
        this.footnoteRefTextBackgroundRadiusBottomRight = bottomRight
        return this
    }
}