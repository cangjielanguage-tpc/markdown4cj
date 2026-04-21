package markdown.components.theme

/**
 * 块引用样式
 */
public class BlockQuoteTheme <: MarkdownBaseTheme {
    public var blockQuoteBackgroundColor: Color = COLOR_FFEAEAEA // 块引用背景颜色
    public var blockQuoteMarginTop: Float64 = 0.0 // 块引用上外边距
    public var blockQuoteMarginRight: Float64 = 0.0 // 块引用右外边距
    public var blockQuoteMarginBottom: Float64 = 0.0 // 块引用下外边距
    public var blockQuoteMarginLeft: Float64 = 8.0 // 块引用左外边距
    public var blockQuotePaddingTop: Float64 = 0.0 // 块引用上内边距
    public var blockQuotePaddingRight: Float64 = 0.0 // 块引用右内边距
    public var blockQuotePaddingBottom: Float64 = 0.0 // 块引用下内边距
    public var blockQuotePaddingLeft: Float64 = 0.0 // 块引用左内边距
    public var blockQuoteRadiusTopLeft: Float64 = 0.0 // 块引用边框左上圆角
    public var blockQuoteRadiusTopRight: Float64 = 0.0 // 块引用边框右上圆角
    public var blockQuoteRadiusBottomLeft: Float64 = 0.0 // 块引用边框左下圆角
    public var blockQuoteRadiusBottomRight: Float64 = 0.0 // 块引用边框右下圆角
    public var blockQuoteLeftBorderWidth: Float64 = 1.0 // 块引用左侧边框宽度
    public var blockQuoteLeftBorderColor: Color = COLOR_FF191919 // 块引用左侧边框颜色
    public var blockQuoteBorderContentSpacing: Float64 = 8.0 // 块引用左侧线条和内容的间距
    public var blockQuoteChildSpacing: Int64 = 8 // 块引用子模块间距

    /**
     * 设置块引用背景颜色
     *
     * @param color 块引用背景颜色
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuoteBackgroundColor(color: Color): BlockQuoteTheme {
        this.blockQuoteBackgroundColor = color
        return this
    }

    /**
     * 统一设置块引用整体外边距
     *
     * @param margin 外边距
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuoteMargin(margin: Float64): BlockQuoteTheme {
        this.blockQuoteMarginTop = margin
        this.blockQuoteMarginRight = margin
        this.blockQuoteMarginBottom = margin
        this.blockQuoteMarginLeft = margin
        return this
    }

    /**
     * 分别设置块引用四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuoteMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 8.0): BlockQuoteTheme {
        this.blockQuoteMarginTop = top
        this.blockQuoteMarginRight = right
        this.blockQuoteMarginBottom = bottom
        this.blockQuoteMarginLeft = left
        return this
    }

    /**
     * 统一设置块引用整体内边距
     *
     * @param padding 内边距
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuotePadding(padding: Float64): BlockQuoteTheme {
        this.blockQuotePaddingTop = padding
        this.blockQuotePaddingRight = padding
        this.blockQuotePaddingBottom = padding
        this.blockQuotePaddingLeft = padding
        return this
    }

    /**
     * 分别设置块引用四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuotePadding(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): BlockQuoteTheme {
        this.blockQuotePaddingTop = top
        this.blockQuotePaddingRight = right
        this.blockQuotePaddingBottom = bottom
        this.blockQuotePaddingLeft = left
        return this
    }

    /**
     * 统一设置块引用整体圆角
     *
     * @param radius 圆角
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuoteRadius(radius: Float64): BlockQuoteTheme {
        this.blockQuoteRadiusTopLeft = radius
        this.blockQuoteRadiusTopRight = radius
        this.blockQuoteRadiusBottomLeft = radius
        this.blockQuoteRadiusBottomRight = radius
        return this
    }

    /**
     * 分别设置块引用四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuoteRadius(topLeft!: Float64 = 0.0, topRight!: Float64 = 0.0, bottomLeft!: Float64 = 0.0, bottomRight!: Float64 = 0.0): BlockQuoteTheme {
        this.blockQuoteRadiusTopLeft = topLeft
        this.blockQuoteRadiusTopRight = topRight
        this.blockQuoteRadiusBottomLeft = bottomLeft
        this.blockQuoteRadiusBottomRight = bottomRight
        return this
    }

    /**
     * 设置块引用左侧边框宽度
     *
     * @param width 块引用左侧边框宽度
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuoteLeftBorderWidth(width: Float64): BlockQuoteTheme {
        this.blockQuoteLeftBorderWidth = width
        return this
    }

    /**
     * 设置块引用左侧边框颜色
     *
     * @param color 块引用左侧边框颜色
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuoteLeftBorderColor(color: Color): BlockQuoteTheme {
        this.blockQuoteLeftBorderColor = color
        return this
    }

    /**
     * 设置块引用左侧线条和内容的间距
     *
     * @param space 块引用左侧线条和内容的间距
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuoteBorderContentSpacing(space: Float64): BlockQuoteTheme {
        this.blockQuoteBorderContentSpacing = space
        return this
    }

    /**
     * 设置块引用子模块间距
     *
     * @param space 块引用子模块间距
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuoteChildSpacing(space: Int64): BlockQuoteTheme {
        this.blockQuoteChildSpacing = space
        return this
    }
}