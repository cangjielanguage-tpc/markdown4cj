package markdown_hybrid.components.theme

import ohos.state_macro_manage.*

/**
 * 斜体文本样式
 */
@Observed
public class ItalicTheme {
    @Publish
    public var italicTextFontColor: ?Color = Option<Color>.None // 斜体文本颜色
    @Publish
    public var italicTextFontSize: ?Float64 = Option<Float64>.None // 斜体文本尺寸
    @Publish
    public var italicTextFontWeight: ?FontWeight = Option<FontWeight>.None // 斜体文本字体粗细
    @Publish
    public var italicTextFontFamily: ?String = Option<String>.None // 斜体文本字体
    @Publish
    public var italicTextLineHeight: ?Float64 = Option<Float64>.None // 斜体文本行高
    @Publish
    public var italicTextLetterSpacing: ?Float64 = Option<Float64>.None // 斜体文本字符间距

    /**
     * 设置斜体文本颜色
     *
     * @param color 斜体文本颜色
     * @return 当前ItalicTheme对象
     */
    public func setItalicTextFontColor(color: Color): ItalicTheme {
        this.italicTextFontColor = color
        return this
    }

    /**
     * 设置斜体文本尺寸
     *
     * @param size 斜体文本尺寸
     * @return 当前ItalicTheme对象
     */
    public func setItalicTextFontSize(size: Float64): ItalicTheme {
        this.italicTextFontSize = size
        return this
    }

    /**
     * 设置斜体文本字体粗细
     *
     * @param weight 斜体文本字体粗细
     * @return 当前ItalicTheme对象
     */
    public func setItalicTextFontWeight(weight: FontWeight): ItalicTheme {
        this.italicTextFontWeight = weight
        return this
    }

    /**
     * 设置斜体文本字体
     *
     * @param family 斜体文本字体
     * @return 当前ItalicTheme对象
     */
    public func setItalicTextFontFamily(family: String): ItalicTheme {
        this.italicTextFontFamily = family
        return this
    }

    /**
     * 设置斜体文本行高
     *
     * @param lineHeight 斜体文本行高
     * @return 当前ItalicTheme对象
     */
    public func setItalicTextLineHeight(lineHeight: Float64): ItalicTheme {
        this.italicTextLineHeight = lineHeight
        return this
    }

    /**
     * 设置斜体文本字符间距
     *
     * @param spacing 斜体文本字符间距
     * @return 当前ItalicTheme对象
     */
    public func setItalicTextLetterSpacing(spacing: Float64): ItalicTheme {
        this.italicTextLetterSpacing = spacing
        return this
    }
}