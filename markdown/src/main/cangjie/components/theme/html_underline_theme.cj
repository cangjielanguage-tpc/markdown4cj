package markdown.components.theme

import ohos.state_macro_manage.*

/**
 * HTML下划线文本样式
 */
@Observed
public class HtmlUnderlineTheme {
    @Publish
    public var htmlUnderlineTextFontColor: ?Color = Option<Color>.None // HTML下划线文本颜色
    @Publish
    public var htmlUnderlineTextFontSize: ?Float64 = Option<Float64>.None // HTML下划线文本尺寸
    @Publish
    public var htmlUnderlineTextFontStyle: ?FontStyle = Option<FontStyle>.None // HTML下划线文本字体样式
    @Publish
    public var htmlUnderlineTextFontWeight: ?FontWeight = Option<FontWeight>.None // HTML下划线文本字体粗细
    @Publish
    public var htmlUnderlineTextFontFamily: ?String = Option<String>.None // HTML下划线文本字体
    @Publish
    public var htmlUnderlineTextLineHeight: ?Float64 = Option<Float64>.None // HTML下划线文本行高
    @Publish
    public var htmlUnderlineTextLetterSpacing: ?Float64 = Option<Float64>.None // HTML下划线文本字符间距
    @Publish
    public var htmlUnderlineTextDecorationColor: Color = COLOR_FF191919 // HTML下划线文本装饰线颜色
    @Publish
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