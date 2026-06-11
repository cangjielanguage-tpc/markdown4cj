package markdown.components.theme

/**
 * 下标文本样式
 */
public class SubTheme <: MarkdownBaseTheme {
    public var subTextFontColor: ?Color = None // 下标文本颜色
    public var subTextFontSize: Float64 = 8.0 // 下标文本尺寸
    public var subTextFontStyle: ?FontStyle = None // 下标文本字体样式
    public var subTextFontWeight: ?FontWeight = None // 下标文本字体粗细
    public var subTextFontFamily: ?String = None // 下标文本字体
    public var subTextLetterSpacing: ?Float64 = None // 下标文本字符间距
    public var subTextBaselineOffset: Float64 = 0.0 // 下标文本基线的偏移量

    /**
     * 设置下标文本颜色
     *
     * @param color 下标文本颜色
     * @return 当前SubTheme对象
     */
    public func setSubTextFontColor(color: Color): SubTheme {
        this.subTextFontColor = color
        return this
    }

    /**
     * 设置下标文本尺寸
     *
     * @param size 下标文本尺寸
     * @return 当前SubTheme对象
     */
    public func setSubTextFontSize(size: Float64): SubTheme {
        this.subTextFontSize = size
        return this
    }

    /**
     * 设置下标文本字体样式
     *
     * @param style 下标文本字体样式
     * @return 当前SubTheme对象
     */
    public func setSubTextFontStyle(style: FontStyle): SubTheme {
        this.subTextFontStyle = style
        return this
    }

    /**
     * 设置下标文本字体粗细
     *
     * @param weight 下标文本字体粗细
     * @return 当前SubTheme对象
     */
    public func setSubTextFontWeight(weight: FontWeight): SubTheme {
        this.subTextFontWeight = weight
        return this
    }

    /**
     * 设置下标文本字体
     *
     * @param family 下标文本字体
     * @return 当前SubTheme对象
     */
    public func setSubTextFontFamily(family: String): SubTheme {
        this.subTextFontFamily = family
        return this
    }

    /**
     * 设置下标文本字符间距
     *
     * @param spacing 下标文本字符间距
     * @return 当前SubTheme对象
     */
    public func setSubTextLetterSpacing(spacing: Float64): SubTheme {
        this.subTextLetterSpacing = spacing
        return this
    }

    /**
     * 设置下标文本基线的偏移量
     *
     * @param offset 下标文本基线的偏移量
     * @return 当前SubTheme对象
     */
    public func setSubTextBaselineOffset(offset: Float64): SubTheme {
        this.subTextBaselineOffset = offset
        return this
    }
}