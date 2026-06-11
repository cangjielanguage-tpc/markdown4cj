package markdown.components.theme

/**
 * HTML下划线文本样式
 */
public class HtmlUnderlineTheme <: MarkdownBaseTheme {
    public var htmlUnderlineTextFontColor: ?Color = None // HTML下划线文本颜色
    public var htmlUnderlineTextFontSize: ?Float64 = None // HTML下划线文本尺寸
    public var htmlUnderlineTextFontStyle: ?FontStyle = None // HTML下划线文本字体样式
    public var htmlUnderlineTextFontWeight: ?FontWeight = None // HTML下划线文本字体粗细
    public var htmlUnderlineTextFontFamily: ?String = None // HTML下划线文本字体
    public var htmlUnderlineTextLineHeight: ?Float64 = None // HTML下划线文本行高
    public var htmlUnderlineTextLetterSpacing: ?Float64 = None // HTML下划线文本字符间距
    public var htmlUnderlineTextDecorationColor: Color = COLOR_FF191919 // HTML下划线文本装饰线颜色
    public var htmlUnderlineTextDecorationStyle: MarkdownTextDecorationStyle = MarkdownTextDecorationStyle.SOLID // HTML下划线文本装饰线样式

    /**
     * 设置HTML下划线文本颜色
     *
     * @param color HTML下划线文本颜色
     * @return 当前HtmlUnderlineTheme对象
     */
    public func setHtmlUnderlineTextFontColor(color: Color): HtmlUnderlineTheme {
        this.htmlUnderlineTextFontColor = color
        return this
    }

    /**
     * 设置HTML下划线文本尺寸
     *
     * @param size HTML下划线文本尺寸
     * @return 当前HtmlUnderlineTheme对象
     */
    public func setHtmlUnderlineTextFontSize(size: Float64): HtmlUnderlineTheme {
        this.htmlUnderlineTextFontSize = size
        return this
    }

    /**
     * 设置HTML下划线文本字体样式
     *
     * @param style HTML下划线文本字体样式
     * @return 当前HtmlUnderlineTheme对象
     */
    public func setHtmlUnderlineTextFontStyle(style: FontStyle): HtmlUnderlineTheme {
        this.htmlUnderlineTextFontStyle = style
        return this
    }

    /**
     * 设置HTML下划线文本字体粗细
     *
     * @param weight HTML下划线文本字体粗细
     * @return 当前HtmlUnderlineTheme对象
     */
    public func setHtmlUnderlineTextFontWeight(weight: FontWeight): HtmlUnderlineTheme {
        this.htmlUnderlineTextFontWeight = weight
        return this
    }

    /**
     * 设置HTML下划线文本字体
     *
     * @param family HTML下划线文本字体
     * @return 当前HtmlUnderlineTheme对象
     */
    public func setHtmlUnderlineTextFontFamily(family: String): HtmlUnderlineTheme {
        this.htmlUnderlineTextFontFamily = family
        return this
    }

    /**
     * 设置HTML下划线文本行高
     *
     * @param lineHeight HTML下划线文本行高
     * @return 当前HtmlUnderlineTheme对象
     */
    public func setHtmlUnderlineTextLineHeight(lineHeight: Float64): HtmlUnderlineTheme {
        this.htmlUnderlineTextLineHeight = lineHeight
        return this
    }

    /**
     * 设置HTML下划线文本字符间距
     *
     * @param spacing HTML下划线文本字符间距
     * @return 当前HtmlUnderlineTheme对象
     */
    public func setHtmlUnderlineTextLetterSpacing(spacing: Float64): HtmlUnderlineTheme {
        this.htmlUnderlineTextLetterSpacing = spacing
        return this
    }

    /**
     * 设置HTML下划线文本装饰线颜色
     *
     * @param color HTML下划线文本装饰线颜色
     * @return 当前HtmlUnderlineTheme对象
     */
    public func setHtmlUnderlineTextDecorationColor(color: Color): HtmlUnderlineTheme {
        this.htmlUnderlineTextDecorationColor = color
        return this
    }

    /**
     * 设置HTML下划线文本装饰线样式
     *
     * @param style HTML下划线文本装饰线样式
     * @return 当前HtmlUnderlineTheme对象
     */
    public func setHtmlUnderlineTextDecorationStyle(style: MarkdownTextDecorationStyle): HtmlUnderlineTheme {
        this.htmlUnderlineTextDecorationStyle = style
        return this
    }
}