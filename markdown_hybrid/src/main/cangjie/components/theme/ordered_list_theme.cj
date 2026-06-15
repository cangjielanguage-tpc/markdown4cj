package markdown.components.theme

/**
 * 有序列表样式
 */
public class OrderedListTheme <: MarkdownBaseTheme {
    public var orderedListBackgroundColor: ?Color = None // 有序列表背景颜色
    public var orderedListMarginTop: Float64 = 0.0 // 有序列表上外边距
    public var orderedListMarginRight: Float64 = 0.0 // 有序列表右外边距
    public var orderedListMarginBottom: Float64 = 0.0 // 有序列表下外边距
    public var orderedListMarginLeft: Float64 = 8.0 // 有序列表左外边距
    public var orderedListPaddingTop: Float64 = 0.0 // 有序列表上内边距
    public var orderedListPaddingRight: Float64 = 0.0 // 有序列表右内边距
    public var orderedListPaddingBottom: Float64 = 0.0 // 有序列表下内边距
    public var orderedListPaddingLeft: Float64 = 0.0 // 有序列表左内边距
    public var orderedListChildSpacing: Int64 = 8 // 有序列表子模块上下间距
    public var orderedListChildChildSpacing: Int64 = 8 // 有序列表子模块中子模块上下间距
    public var orderedListMarkerSpacing: Float64 = 8.0 // 有序列表列表编号和列表内容间距
    public var orderedListMarkerTextFontColor: Color = COLOR_FF191919 // 有序列表列表编号文本颜色
    public var orderedListMarkerTextFontSize: Float64 = 14.0 // 有序列表列表编号文本尺寸
    public var orderedListMarkerTextFontStyle: FontStyle = FontStyle.Normal // 有序列表列表编号文本字体样式
    public var orderedListMarkerTextFontWeight: FontWeight = FontWeight.W400 // 有序列表列表编号文本字体粗细
    public var orderedListMarkerTextFontFamily: String = "HarmonyOS Sans" // 有序列表列表编号文本字体
    public var orderedListMarkerTextLineHeight: Float64 = 22.0 // 有序列表列表编号文本行高

    /**
     * 设置有序列表背景颜色
     *
     * @param color 有序列表背景颜色
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListBackgroundColor(color: Color): OrderedListTheme {
        this.orderedListBackgroundColor = color
        return this
    }

    /**
     * 统一设置有序列表外边距
     *
     * @param margin 外边距
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListMargin(margin: Float64): OrderedListTheme {
        this.orderedListMarginTop = margin
        this.orderedListMarginRight = margin
        this.orderedListMarginBottom = margin
        this.orderedListMarginLeft = margin
        return this
    }

    /**
     * 分别设置有序列表四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 8.0): OrderedListTheme {
        this.orderedListMarginTop = top
        this.orderedListMarginRight = right
        this.orderedListMarginBottom = bottom
        this.orderedListMarginLeft = left
        return this
    }

    /**
     * 统一设置有序列表内边距
     *
     * @param padding 内边距
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListPadding(padding: Float64): OrderedListTheme {
        this.orderedListPaddingTop = padding
        this.orderedListPaddingRight = padding
        this.orderedListPaddingBottom = padding
        this.orderedListPaddingLeft = padding
        return this
    }

    /**
     * 分别设置有序列表四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListPadding(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): OrderedListTheme {
        this.orderedListPaddingTop = top
        this.orderedListPaddingRight = right
        this.orderedListPaddingBottom = bottom
        this.orderedListPaddingLeft = left
        return this
    }

    /**
     * 设置有序列表子模块上下间距
     *
     * @param spacing 有序列表子模块上下间距
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListChildSpacing(spacing: Int64): OrderedListTheme {
        this.orderedListChildSpacing = spacing
        return this
    }

    /**
     * 设置有序列表子模块中子模块上下间距
     *
     * @param spacing 有序列表子模块中子模块上下间距
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListChildChildSpacing(spacing: Int64): OrderedListTheme {
        this.orderedListChildChildSpacing = spacing
        return this
    }

    /**
     * 设置有序列表列表编号和列表内容间距
     *
     * @param spacing 有序列表列表编号和列表内容间距
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListMarkerSpacing(spacing: Float64): OrderedListTheme {
        this.orderedListMarkerSpacing = spacing
        return this
    }

    /**
     * 设置有序列表列表编号文本颜色
     *
     * @param color 有序列表列表编号文本颜色
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListMarkerTextFontColor(color: Color): OrderedListTheme {
        this.orderedListMarkerTextFontColor = color
        return this
    }

    /**
     * 设置有序列表列表编号文本尺寸
     *
     * @param size 有序列表列表编号文本尺寸
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListMarkerTextFontSize(size: Float64): OrderedListTheme {
        this.orderedListMarkerTextFontSize = size
        return this
    }

    /**
     * 设置有序列表列表编号文本字体样式
     *
     * @param style 有序列表列表编号文本字体样式
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListMarkerTextFontStyle(style: FontStyle): OrderedListTheme {
        this.orderedListMarkerTextFontStyle = style
        return this
    }

    /**
     * 设置有序列表列表编号文本字体粗细
     *
     * @param weight 有序列表列表编号文本字体粗细
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListMarkerTextFontWeight(weight: FontWeight): OrderedListTheme {
        this.orderedListMarkerTextFontWeight = weight
        return this
    }

    /**
     * 设置有序列表列表编号文本字体
     *
     * @param family 有序列表列表编号文本字体
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListMarkerTextFontFamily(family: String): OrderedListTheme {
        this.orderedListMarkerTextFontFamily = family
        return this
    }

    /**
     * 设置有序列表列表编号文本行高
     *
     * @param lineHeight 有序列表列表编号文本行高
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListMarkerTextLineHeight(lineHeight: Float64): OrderedListTheme {
        this.orderedListMarkerTextLineHeight = lineHeight
        return this
    }
}