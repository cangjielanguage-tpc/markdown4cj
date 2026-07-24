package markdown_hybrid.components.theme

import ohos.state_macro_manage.*

/**
 * 加粗文本样式
 */
@Observed
public class BoldTheme {
    @Publish
    public var boldTextFontColor: ?Color = Option<Color>.None // 加粗文本颜色
    @Publish
    public var boldTextFontSize: ?Float64 = Option<Float64>.None // 加粗文本尺寸
    @Publish
    public var boldTextFontStyle: ?FontStyle = Option<FontStyle>.None // 加粗文本字体样式
    @Publish
    public var boldTextFontWeight: FontWeight = FontWeight.W600 // 加粗文本字体粗细
    @Publish
    public var boldTextFontFamily: ?String = Option<String>.None // 加粗文本字体
    @Publish
    public var boldTextLineHeight: ?Float64 = Option<Float64>.None // 加粗文本行高
    @Publish
    public var boldTextLetterSpacing: ?Float64 = Option<Float64>.None // 加粗文本字符间距

    /**
     * 设置加粗文本颜色
     *
     * @param color 加粗文本颜色
     * @return 当前BoldTheme对象
     */
    public func setBoldTextFontColor(color: Color): BoldTheme {
        this.boldTextFontColor = color
        return this
    }

    /**
     * 设置加粗文本尺寸
     *
     * @param size 加粗文本尺寸
     * @return 当前BoldTheme对象
     */
    public func setBoldTextFontSize(size: Float64): BoldTheme {
        this.boldTextFontSize = size
        return this
    }

    /**
     * 设置加粗文本字体样式
     *
     * @param style 加粗文本字体样式
     * @return 当前BoldTheme对象
     */
    public func setBoldTextFontStyle(style: FontStyle): BoldTheme {
        this.boldTextFontStyle = style
        return this
    }

    /**
     * 设置加粗文本字体粗细
     *
     * @param weight 加粗文本字体粗细
     * @return 当前BoldTheme对象
     */
    public func setBoldTextFontWeight(weight: FontWeight): BoldTheme {
        this.boldTextFontWeight = weight
        return this
    }

    /**
     * 设置加粗文本字体
     *
     * @param family 加粗文本字体
     * @return 当前BoldTheme对象
     */
    public func setBoldTextFontFamily(family: String): BoldTheme {
        this.boldTextFontFamily = family
        return this
    }

    /**
     * 设置加粗文本行高
     *
     * @param lineHeight 加粗文本行高
     * @return 当前BoldTheme对象
     */
    public func setBoldTextLineHeight(lineHeight: Float64): BoldTheme {
        this.boldTextLineHeight = lineHeight
        return this
    }

    /**
     * 设置加粗文本字符间距
     *
     * @param spacing 加粗文本字符间距
     * @return 当前BoldTheme对象
     */
    public func setBoldTextLetterSpacing(spacing: Float64): BoldTheme {
        this.boldTextLetterSpacing = spacing
        return this
    }
}