package markdown.components.theme

/**
 * 表格样式
 */
public class TableTheme <: MarkdownBaseTheme {
    public var tableTitleBackgroundColor: Color = COLOR_WHITE // 表格标题背景颜色
    public var tableContentOddRowBackgroundColor: Color = COLOR_FFE0E0E0 // 表格内容奇数行背景颜色
    public var tableContentEvenRowBackgroundColor: Color = COLOR_WHITE // 表格内容偶数行背景颜色
    public var tableMarginTop: Float64 = 0.0 // 表格上外边距
    public var tableMarginRight: Float64 = 0.0 // 表格右外边距
    public var tableMarginBottom: Float64 = 0.0 // 表格下外边距
    public var tableMarginLeft: Float64 = 0.0 // 表格左外边距
    public var tablePaddingTop: Float64 = 0.0 // 表格上内边距
    public var tablePaddingRight: Float64 = 0.0 // 表格右内边距
    public var tablePaddingBottom: Float64 = 0.0 // 表格下内边距
    public var tablePaddingLeft: Float64 = 0.0 // 表格左内边距
    public var tableCellPaddingTop: Float64 = 4.0 // 表格内容上内边距
    public var tableCellPaddingRight: Float64 = 4.0 // 表格内容右内边距
    public var tableCellPaddingBottom: Float64 = 4.0 // 表格内容下内边距
    public var tableCellPaddingLeft: Float64 = 4.0 // 表格内容左内边距
    public var tableBorderStyle: BorderStyle = BorderStyle.Solid // 表格边框样式
    public var tableBorderWidth: Float64 = 1.0 // 表格边框宽度
    public var tableBorderColor: Color = COLOR_BLACK // 表格边框颜色
    public var tableRadiusTopLeft: Float64 = 5.0 // 表格边框左上圆角
    public var tableRadiusTopRight: Float64 = 5.0 // 表格边框右上圆角
    public var tableRadiusBottomLeft: Float64 = 5.0 // 表格边框左下圆角
    public var tableRadiusBottomRight: Float64 = 5.0 // 表格边框右下圆角
    public var tableScrollBarState: BarState = BarState.Off // 表格滚动条状态，默认不显示
    public var tableScrollBarColor: Color = COLOR_FF191919 // 表格滚动条颜色
    public var tableMinCellWidth: Float64 = 50.0 // 表格一格最小宽度
    public var tableMaxCellWidth: Float64 = 300.0 // 表格一格最大宽度
    public var tableFirstColumnIsBold: Bool = false // 表格第一列是否加粗 - 默认表格标题粗细
    public var tableTitleTextFontColor: Color = COLOR_FF191919 // 表格标题文本颜色
    public var tableTitleTextFontSize: Float64 = 14.0 // 表格标题文本尺寸
    public var tableTitleTextFontStyle: FontStyle = FontStyle.Normal // 表格标题文本字体样式
    public var tableTitleTextFontWeight: FontWeight = FontWeight.W600 // 表格标题文本字体粗细
    public var tableTitleTextFontFamily: String = "HarmonyOS Sans" // 表格标题文本字体
    public var tableTitleTextLineHeight: Float64 = 22.0 // 表格标题文本行高
    public var tableTitleTextLetterSpacing: Float64 = 0.0 // 表格标题文本字符间距
    public var tableContentTextFontColor: Color = COLOR_FF191919 // 表格内容文本颜色
    public var tableContentTextFontSize: Float64 = 14.0 // 表格内容文本尺寸
    public var tableContentTextFontStyle: FontStyle = FontStyle.Normal // 表格内容文本字体样式
    public var tableContentTextFontWeight: FontWeight = FontWeight.W400 // 表格内容文本字体粗细
    public var tableContentTextFontFamily: String = "HarmonyOS Sans" // 表格内容文本字体
    public var tableContentTextLineHeight: Float64 = 22.0 // 表格内容文本行高
    public var tableContentTextLetterSpacing: Float64 = 0.0 // 表格内容文本字符间距

    /**
     * 设置表格标题背景颜色
     *
     * @param color 表格标题背景颜色
     * @return 当前TableTheme对象
     */
    public func setTableTitleBackgroundColor(color: Color): TableTheme {
        this.tableTitleBackgroundColor = color
        return this
    }

    /**
     * 设置表格内容奇数行背景颜色
     *
     * @param color 奇数行背景颜色
     * @return 当前TableTheme对象
     */
    public func setTableContentOddRowBackgroundColor(color: Color): TableTheme {
        this.tableContentOddRowBackgroundColor = color
        return this
    }

    /**
     * 设置表格内容偶数行背景颜色
     *
     * @param color 偶数行背景颜色
     * @return 当前TableTheme对象
     */
    public func setTableContentEvenRowBackgroundColor(color: Color): TableTheme {
        this.tableContentEvenRowBackgroundColor = color
        return this
    }

    /**
     * 统一设置表格外边距
     *
     * @param margin 外边距
     * @return 当前TableTheme对象
     */
    public func setTableMargin(margin: Float64): TableTheme {
        this.tableMarginTop = margin
        this.tableMarginRight = margin
        this.tableMarginBottom = margin
        this.tableMarginLeft = margin
        return this
    }

    /**
     * 分别设置表格四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前TableTheme对象
     */
    public func setTableMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): TableTheme {
        this.tableMarginTop = top
        this.tableMarginRight = right
        this.tableMarginBottom = bottom
        this.tableMarginLeft = left
        return this
    }

    /**
     * 统一设置表格内边距
     *
     * @param padding 内边距
     * @return 当前TableTheme对象
     */
    public func setTablePadding(padding: Float64): TableTheme {
        this.tablePaddingTop = padding
        this.tablePaddingRight = padding
        this.tablePaddingBottom = padding
        this.tablePaddingLeft = padding
        return this
    }

    /**
     * 分别设置表格四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前TableTheme对象
     */
    public func setTablePadding(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): TableTheme {
        this.tablePaddingTop = top
        this.tablePaddingRight = right
        this.tablePaddingBottom = bottom
        this.tablePaddingLeft = left
        return this
    }

    /**
     * 统一设置表格内容内边距
     *
     * @param padding 内边距
     * @return 当前TableTheme对象
     */
    public func setTableCellPadding(padding: Float64): TableTheme {
        this.tableCellPaddingTop = padding
        this.tableCellPaddingRight = padding
        this.tableCellPaddingBottom = padding
        this.tableCellPaddingLeft = padding
        return this
    }

    /**
     * 分别设置表格内容四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前TableTheme对象
     */
    public func setTableCellPadding(top!: Float64 = 4.0, right!: Float64 = 4.0, bottom!: Float64 = 4.0, left!: Float64 = 4.0): TableTheme {
        this.tableCellPaddingTop = top
        this.tableCellPaddingRight = right
        this.tableCellPaddingBottom = bottom
        this.tableCellPaddingLeft = left
        return this
    }

    /**
     * 设置表格边框样式
     *
     * @param style 表格边框样式
     * @return 当前TableTheme对象
     */
    public func setTableBorderStyle(style: BorderStyle): TableTheme {
        this.tableBorderStyle = style
        return this
    }

    /**
     * 设置表格边框宽度
     *
     * @param width 表格边框宽度
     * @return 当前TableTheme对象
     */
    public func setTableBorderWidth(width: Float64): TableTheme {
        this.tableBorderWidth = width
        return this
    }

    /**
     * 设置表格边框颜色
     *
     * @param color 表格边框颜色
     * @return 当前TableTheme对象
     */
    public func setTableBorderColor(color: Color): TableTheme {
        this.tableBorderColor = color
        return this
    }

    /**
     * 统一设置表格边框四个圆角
     *
     * @param radius 圆角半径
     * @return 当前TableTheme对象
     */
    public func setTableRadius(radius: Float64): TableTheme {
        this.tableRadiusTopLeft = radius
        this.tableRadiusTopRight = radius
        this.tableRadiusBottomLeft = radius
        this.tableRadiusBottomRight = radius
        return this
    }

    /**
     * 分别设置表格边框四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前TableTheme对象
     */
    public func setTableRadius(topLeft!: Float64 = 5.0, topRight!: Float64 = 5.0, bottomLeft!: Float64 = 5.0, bottomRight!: Float64 = 5.0): TableTheme {
        this.tableRadiusTopLeft = topLeft
        this.tableRadiusTopRight = topRight
        this.tableRadiusBottomLeft = bottomLeft
        this.tableRadiusBottomRight = bottomRight
        return this
    }

    /**
     * 设置表格滚动条状态
     *
     * @param state 滚动条状态
     * @return 当前TableTheme对象
     */
    public func setTableScrollBarState(state: BarState): TableTheme {
        this.tableScrollBarState = state
        return this
    }

    /**
     * 设置表格滚动条颜色
     *
     * @param color 滚动条颜色
     * @return 当前TableTheme对象
     */
    public func setTableScrollBarColor(color: Color): TableTheme {
        this.tableScrollBarColor = color
        return this
    }

    /**
     * 设置表格一格最小宽度
     *
     * @param width 最小宽度
     * @return 当前TableTheme对象
     */
    public func setTableMinCellWidth(width: Float64): TableTheme {
        this.tableMinCellWidth = width
        return this
    }

    /**
     * 设置表格一格最大宽度
     *
     * @param width 最大宽度
     * @return 当前TableTheme对象
     */
    public func setTableMaxCellWidth(width: Float64): TableTheme {
        this.tableMaxCellWidth = width
        return this
    }

    /**
     * 设置表格第一列是否加粗
     *
     * @param isBold 是否加粗
     * @return 当前TableTheme对象
     */
    public func setTableFirstColumnIsBold(isBold: Bool): TableTheme {
        this.tableFirstColumnIsBold = isBold
        return this
    }

    /**
     * 设置表格标题文本颜色
     *
     * @param color 表格标题文本颜色
     * @return 当前TableTheme对象
     */
    public func setTableTitleTextFontColor(color: Color): TableTheme {
        this.tableTitleTextFontColor = color
        return this
    }

    /**
     * 设置表格标题文本尺寸
     *
     * @param size 表格标题文本尺寸
     * @return 当前TableTheme对象
     */
    public func setTableTitleTextFontSize(size: Float64): TableTheme {
        this.tableTitleTextFontSize = size
        return this
    }

    /**
     * 设置表格标题文本字体样式
     *
     * @param style 表格标题文本字体样式
     * @return 当前TableTheme对象
     */
    public func setTableTitleTextFontStyle(style: FontStyle): TableTheme {
        this.tableTitleTextFontStyle = style
        return this
    }

    /**
     * 设置表格标题文本字体粗细
     *
     * @param weight 表格标题文本字体粗细
     * @return 当前TableTheme对象
     */
    public func setTableTitleTextFontWeight(weight: FontWeight): TableTheme {
        this.tableTitleTextFontWeight = weight
        return this
    }

    /**
     * 设置表格标题文本字体
     *
     * @param family 表格标题文本字体
     * @return 当前TableTheme对象
     */
    public func setTableTitleTextFontFamily(family: String): TableTheme {
        this.tableTitleTextFontFamily = family
        return this
    }

    /**
     * 设置表格标题文本行高
     *
     * @param lineHeight 表格标题文本行高
     * @return 当前TableTheme对象
     */
    public func setTableTitleTextLineHeight(lineHeight: Float64): TableTheme {
        this.tableTitleTextLineHeight = lineHeight
        return this
    }

    /**
     * 设置表格标题文本字符间距
     *
     * @param spacing 表格标题文本字符间距
     * @return 当前TableTheme对象
     */
    public func setTableTitleTextLetterSpacing(spacing: Float64): TableTheme {
        this.tableTitleTextLetterSpacing = spacing
        return this
    }

    /**
     * 设置表格内容文本颜色
     *
     * @param color 表格内容文本颜色
     * @return 当前TableTheme对象
     */
    public func setTableContentTextFontColor(color: Color): TableTheme {
        this.tableContentTextFontColor = color
        return this
    }

    /**
     * 设置表格内容文本尺寸
     *
     * @param size 表格内容文本尺寸
     * @return 当前TableTheme对象
     */
    public func setTableContentTextFontSize(size: Float64): TableTheme {
        this.tableContentTextFontSize = size
        return this
    }

    /**
     * 设置表格内容文本字体样式
     *
     * @param style 表格内容文本字体样式
     * @return 当前TableTheme对象
     */
    public func setTableContentTextFontStyle(style: FontStyle): TableTheme {
        this.tableContentTextFontStyle = style
        return this
    }

    /**
     * 设置表格内容文本字体粗细
     *
     * @param weight 表格内容文本字体粗细
     * @return 当前TableTheme对象
     */
    public func setTableContentTextFontWeight(weight: FontWeight): TableTheme {
        this.tableContentTextFontWeight = weight
        return this
    }

    /**
     * 设置表格内容文本字体
     *
     * @param family 表格内容文本字体
     * @return 当前TableTheme对象
     */
    public func setTableContentTextFontFamily(family: String): TableTheme {
        this.tableContentTextFontFamily = family
        return this
    }

    /**
     * 设置表格内容文本行高
     *
     * @param lineHeight 表格内容文本行高
     * @return 当前TableTheme对象
     */
    public func setTableContentTextLineHeight(lineHeight: Float64): TableTheme {
        this.tableContentTextLineHeight = lineHeight
        return this
    }

    /**
     * 设置表格内容文本字符间距
     *
     * @param spacing 表格内容文本字符间距
     * @return 当前TableTheme对象
     */
    public func setTableContentTextLetterSpacing(spacing: Float64): TableTheme {
        this.tableContentTextLetterSpacing = spacing
        return this
    }
}