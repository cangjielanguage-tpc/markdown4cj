package markdown.components.theme

/**
 * 分割线样式
 */
public class DividerTheme <: MarkdownBaseTheme {
    public var dividerMarginTop: Float64 = 0.0 // 分割线上外边距
    public var dividerMarginRight: Float64 = 0.0 // 分割线右外边距
    public var dividerMarginBottom: Float64 = 0.0 // 分割线下外边距
    public var dividerMarginLeft: Float64 = 0.0 // 分割线左外边距
    public var dividerPaddingTop: Float64 = 0.0 // 分割线上内边距
    public var dividerPaddingRight: Float64 = 0.0 // 分割线右内边距
    public var dividerPaddingBottom: Float64 = 0.0 // 分割线下内边距
    public var dividerPaddingLeft: Float64 = 0.0 // 分割线左内边距
    public var dividerColor: Color = COLOR_FF191919 // 分割线颜色
    public var dividerStrokeWidth: Float64 = 0.5 // 分割线宽度
    public var dividerStyle: LineCapStyle = LineCapStyle.Butt // 分割线端点样式

    /**
     * 统一设置分割线整体外边距
     *
     * @param margin 外边距
     * @return 当前DividerTheme对象
     */
    public func setDividerMargin(margin: Float64): DividerTheme {
        this.dividerMarginTop = margin
        this.dividerMarginRight = margin
        this.dividerMarginBottom = margin
        this.dividerMarginLeft = margin
        return this
    }

    /**
     * 分别设置分割线四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前DividerTheme对象
     */
    public func setDividerMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): DividerTheme {
        this.dividerMarginTop = top
        this.dividerMarginRight = right
        this.dividerMarginBottom = bottom
        this.dividerMarginLeft = left
        return this
    }

    /**
     * 统一设置分割线整体内边距
     *
     * @param padding 内边距
     * @return 当前DividerTheme对象
     */
    public func setDividerPadding(padding: Float64): DividerTheme {
        this.dividerPaddingTop = padding
        this.dividerPaddingRight = padding
        this.dividerPaddingBottom = padding
        this.dividerPaddingLeft = padding
        return this
    }

    /**
     * 分别设置分割线四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前DividerTheme对象
     */
    public func setDividerPadding(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): DividerTheme {
        this.dividerPaddingTop = top
        this.dividerPaddingRight = right
        this.dividerPaddingBottom = bottom
        this.dividerPaddingLeft = left
        return this
    }

    /**
     * 设置分割线颜色
     *
     * @param color 分割线颜色
     * @return 当前DividerTheme对象
     */
    public func setDividerColor(color: Color): DividerTheme {
        this.dividerColor = color
        return this
    }

    /**
     * 设置分割线宽度
     *
     * @param strokeWidth 分割线宽度
     * @return 当前DividerTheme对象
     */
    public func setDividerStrokeWidth(strokeWidth: Float64): DividerTheme {
        this.dividerStrokeWidth = strokeWidth
        return this
    }

    /**
     * 设置分割线端点样式
     *
     * @param style 分割线端点样式
     * @return 当前DividerTheme对象
     */
    public func setDividerStyle(style: LineCapStyle): DividerTheme {
        this.dividerStyle = style
        return this
    }
}