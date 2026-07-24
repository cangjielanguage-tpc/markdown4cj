package markdown.components.theme

import ohos.state_macro_manage.*

/**
 * 上标文本样式
 */
@Observed
public class SupTheme {
    @Publish
    public var supTextFontColor: ?Color = Option<Color>.None // 上标文本颜色
    @Publish
    public var supTextFontSize: Float64 = 8.0 // 上标文本尺寸
    @Publish
    public var supTextFontStyle: ?FontStyle = Option<FontStyle>.None // 上标文本字体样式
    @Publish
    public var supTextFontWeight: ?FontWeight = Option<FontWeight>.None // 上标文本字体粗细
    @Publish
    public var supTextFontFamily: ?String = Option<String>.None // 上标文本字体
    @Publish
    public var supTextLetterSpacing: ?Float64 = Option<Float64>.None // 上标文本字符间距
    @Publish
    public var supTextBaselineOffset: Float64 = 6.0 // 上标文本基线的偏移量

    /**
     * 设置上标文本颜色
     *
     * @param color 上标文本颜色
     * @return 当前SupTheme对象
     */
    public func setSupTextFontColor(color: Color): SupTheme {
        this.supTextFontColor = color
        return this
    }

    /**
     * 设置上标文本尺寸
     *
     * @param size 上标文本尺寸
     * @return 当前SupTheme对象
     */
    public func setSupTextFontSize(size: Float64): SupTheme {
        this.supTextFontSize = size
        return this
    }

    /**
     * 设置上标文本字体样式
     *
     * @param style 上标文本字体样式
     * @return 当前SupTheme对象
     */
    public func setSupTextFontStyle(style: FontStyle): SupTheme {
        this.supTextFontStyle = style
        return this
    }

    /**
     * 设置上标文本字体粗细
     *
     * @param weight 上标文本字体粗细
     * @return 当前SupTheme对象
     */
    public func setSupTextFontWeight(weight: FontWeight): SupTheme {
        this.supTextFontWeight = weight
        return this
    }

    /**
     * 设置上标文本字体
     *
     * @param family 上标文本字体
     * @return 当前SupTheme对象
     */
    public func setSupTextFontFamily(family: String): SupTheme {
        this.supTextFontFamily = family
        return this
    }

    /**
     * 设置上标文本字符间距
     *
     * @param spacing 上标文本字符间距
     * @return 当前SupTheme对象
     */
    public func setSupTextLetterSpacing(spacing: Float64): SupTheme {
        this.supTextLetterSpacing = spacing
        return this
    }

    /**
     * 设置上标文本基线的偏移量
     *
     * @param offset 上标文本基线的偏移量
     * @return 当前SupTheme对象
     */
    public func setSupTextBaselineOffset(offset: Float64): SupTheme {
        this.supTextBaselineOffset = offset
        return this
    }
}