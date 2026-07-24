package markdown.components.theme

import ohos.state_macro_manage.*

/**
 * 删除线文本样式
 */
@Observed
public class StrikethroughTheme {
    @Publish
    public var strikethroughTextFontColor: ?Color = Option<Color>.None // 删除线文本颜色
    @Publish
    public var strikethroughTextFontSize: ?Float64 = Option<Float64>.None // 删除线文本尺寸
    @Publish
    public var strikethroughTextFontStyle: ?FontStyle = Option<FontStyle>.None // 删除线文本字体样式
    @Publish
    public var strikethroughTextFontWeight: ?FontWeight = Option<FontWeight>.None // 删除线文本字体粗细
    @Publish
    public var strikethroughTextFontFamily: ?String = Option<String>.None // 删除线文本字体
    @Publish
    public var strikethroughTextLineHeight: ?Float64 = Option<Float64>.None // 删除线文本行高
    @Publish
    public var strikethroughTextLetterSpacing: ?Float64 = Option<Float64>.None // 删除线文本字符间距
    @Publish
    public var strikethroughTextDecorationColor: Color = COLOR_FF191919 // 删除线文本装饰线颜色
    @Publish
    public var strikethroughTextDecorationStyle: MarkdownTextDecorationStyle = MarkdownTextDecorationStyle.SOLID // 删除线文本装饰线样式

    /**
     * 设置删除线文本颜色
     *
     * @param color 删除线文本颜色
     * @return 当前StrikethroughTheme对象
     */
    public func setStrikethroughTextFontColor(color: Color): StrikethroughTheme {
        this.strikethroughTextFontColor = color
        return this
    }

    /**
     * 设置删除线文本尺寸
     *
     * @param size 删除线文本尺寸
     * @return 当前StrikethroughTheme对象
     */
    public func setStrikethroughTextFontSize(size: Float64): StrikethroughTheme {
        this.strikethroughTextFontSize = size
        return this
    }

    /**
     * 设置删除线文本字体样式
     *
     * @param style 删除线文本字体样式
     * @return 当前StrikethroughTheme对象
     */
    public func setStrikethroughTextFontStyle(style: FontStyle): StrikethroughTheme {
        this.strikethroughTextFontStyle = style
        return this
    }

    /**
     * 设置删除线文本字体粗细
     *
     * @param weight 删除线文本字体粗细
     * @return 当前StrikethroughTheme对象
     */
    public func setStrikethroughTextFontWeight(weight: FontWeight): StrikethroughTheme {
        this.strikethroughTextFontWeight = weight
        return this
    }

    /**
     * 设置删除线文本字体
     *
     * @param family 删除线文本字体
     * @return 当前StrikethroughTheme对象
     */
    public func setStrikethroughTextFontFamily(family: String): StrikethroughTheme {
        this.strikethroughTextFontFamily = family
        return this
    }

    /**
     * 设置删除线文本行高
     *
     * @param lineHeight 删除线文本行高
     * @return 当前StrikethroughTheme对象
     */
    public func setStrikethroughTextLineHeight(lineHeight: Float64): StrikethroughTheme {
        this.strikethroughTextLineHeight = lineHeight
        return this
    }

    /**
     * 设置删除线文本字符间距
     *
     * @param spacing 删除线文本字符间距
     * @return 当前StrikethroughTheme对象
     */
    public func setStrikethroughTextLetterSpacing(spacing: Float64): StrikethroughTheme {
        this.strikethroughTextLetterSpacing = spacing
        return this
    }

    /**
     * 设置删除线文本装饰线颜色
     *
     * @param color 删除线文本装饰线颜色
     * @return 当前StrikethroughTheme对象
     */
    public func setStrikethroughTextDecorationColor(color: Color): StrikethroughTheme {
        this.strikethroughTextDecorationColor = color
        return this
    }

    /**
     * 设置删除线文本装饰线样式
     *
     * @param style 删除线文本装饰线样式
     * @return 当前StrikethroughTheme对象
     */
    public func setStrikethroughTextDecorationStyle(style: MarkdownTextDecorationStyle): StrikethroughTheme {
        this.strikethroughTextDecorationStyle = style
        return this
    }
}