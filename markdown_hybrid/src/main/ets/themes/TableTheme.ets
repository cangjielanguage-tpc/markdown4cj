import { MarkdownMarginOptions, MarkdownPaddingOptions, MarkdownRadiusOptions } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-表格样式
 */
export class TableTheme {
  /**
   * 表格标题背景颜色
   */
  private tableTitleBackgroundColor?: number = undefined

  /**
   * 表格内容奇数行背景颜色
   */
  private tableContentOddRowBackgroundColor?: number = undefined

  /**
   * 表格内容偶数行背景颜色
   */
  private tableContentEvenRowBackgroundColor?: number = undefined

  /**
   * 表格上外边距
   */
  private tableMarginTop?: number = undefined

  /**
   * 表格右外边距
   */
  private tableMarginRight?: number = undefined

  /**
   * 表格下外边距
   */
  private tableMarginBottom?: number = undefined

  /**
   * 表格左外边距
   */
  private tableMarginLeft?: number = undefined

  /**
   * 表格上内边距
   */
  private tablePaddingTop?: number = undefined

  /**
   * 表格右内边距
   */
  private tablePaddingRight?: number = undefined

  /**
   * 表格下内边距
   */
  private tablePaddingBottom?: number = undefined

  /**
   * 表格左内边距
   */
  private tablePaddingLeft?: number = undefined

  /**
   * 表格内容上内边距
   */
  private tableCellPaddingTop?: number = undefined

  /**
   * 表格内容右内边距
   */
  private tableCellPaddingRight?: number = undefined

  /**
   * 表格内容下内边距
   */
  private tableCellPaddingBottom?: number = undefined

  /**
   * 表格内容左内边距
   */
  private tableCellPaddingLeft?: number = undefined

  /**
   * 表格边框样式
   */
  private tableBorderStyle?: BorderStyle = undefined

  /**
   * 表格边框宽度
   */
  private tableBorderWidth?: number = undefined

  /**
   * 表格边框颜色
   */
  private tableBorderColor?: number = undefined

  /**
   * 表格边框左上圆角
   */
  private tableRadiusTopLeft?: number = undefined

  /**
   * 表格边框右上圆角
   */
  private tableRadiusTopRight?: number = undefined

  /**
   * 表格边框左下圆角
   */
  private tableRadiusBottomLeft?: number = undefined

  /**
   * 表格边框右下圆角
   */
  private tableRadiusBottomRight?: number = undefined

  /**
   * 表格滚动条状态，默认不显示
   */
  private tableScrollBarState?: BarState = undefined

  /**
   * 表格滚动条颜色
   */
  private tableScrollBarColor?: number = undefined

  /**
   * 表格一格最小宽度
   */
  private tableMinCellWidth?: number = undefined

  /**
   * 表格一格最大宽度
   */
  private tableMaxCellWidth?: number = undefined

  /**
   * 表格第一列是否加粗
   */
  private tableFirstColumnIsBold?: boolean = undefined

  /**
   * 表格标题文本颜色
   */
  private tableTitleTextFontColor?: number = undefined

  /**
   * 表格标题文本尺寸
   */
  private tableTitleTextFontSize?: number = undefined

  /**
   * 表格标题文本字体样式
   */
  private tableTitleTextFontStyle?: FontStyle = undefined

  /**
   * 表格标题文本字体粗细
   */
  private tableTitleTextFontWeight?: FontWeight = undefined

  /**
   * 表格标题文本字体
   */
  private tableTitleTextFontFamily?: string = undefined

  /**
   * 表格标题文本行高
   */
  private tableTitleTextLineHeight?: number = undefined

  /**
   * 表格标题文本字符间距
   */
  private tableTitleTextLetterSpacing?: number = undefined

  /**
   * 表格内容文本颜色
   */
  private tableContentTextFontColor?: number = undefined

  /**
   * 表格内容文本尺寸
   */
  private tableContentTextFontSize?: number = undefined

  /**
   * 表格内容文本字体样式
   */
  private tableContentTextFontStyle?: FontStyle = undefined

  /**
   * 表格内容文本字体粗细
   */
  private tableContentTextFontWeight?: FontWeight = undefined

  /**
   * 表格内容文本字体
   */
  private tableContentTextFontFamily?: string = undefined

  /**
   * 表格内容文本行高
   */
  private tableContentTextLineHeight?: number = undefined

  /**
   * 表格内容文本字符间距
   */
  private tableContentTextLetterSpacing?: number = undefined

  /**
   * 表格标题行是否吸顶
   */
  private tableStickyHeader?: boolean = undefined

  /**
   * 表格头复制按钮是否显示
   */
  private tableHeadIsShow?: boolean = undefined

  /**
   * 表格头标题文字
   */
  private tableHeadTitleText?: string = undefined

  /**
   * 表格头标题文本字体族
   */
  private tableHeadTitleTextFontFamily?: string = undefined

  /**
   * 表格头标题文本字体大小
   */
  private tableHeadTitleTextFontSize?: number = undefined

  /**
   * 表格头标题文本字体粗细
   */
  private tableHeadTitleTextFontWeight?: FontWeight = undefined

  /**
   * 表格头标题文本字体样式
   */
  private tableHeadTitleTextFontStyle?: FontStyle = undefined

  /**
   * 表格头标题文本字体颜色
   */
  private tableHeadTitleTextFontColor?: number = undefined

  /**
   * 表格头标题文本行高
   */
  private tableHeadTitleTextLineHeight?: number = undefined

  /**
   * 表格头标题左外边距
   */
  private tableHeadTitleTextMarginLeft?: number = undefined

  /**
   * 表格头复制图标
   */
  private tableHeadCopyIcon?: Resource = undefined

  /**
   * 表格头复制图标宽度
   */
  private tableHeadCopyIconWidth?: number = undefined

  /**
   * 表格头复制图标高度
   */
  private tableHeadCopyIconHeight?: number = undefined

  /**
   * 表格头复制图标右外边距
   */
  private tableHeadCopyIconMarginRight?: number = undefined

  /**
   * 设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setTableMargin(options: MarkdownMarginOptions | number): TableTheme {
    if (typeof options === "number") {
      this.tableMarginTop = options
      this.tableMarginRight = options
      this.tableMarginBottom = options
      this.tableMarginLeft = options
    } else {
      if (options.top !== undefined) {
        this.tableMarginTop = options.top
      }
      if (options.right !== undefined) {
        this.tableMarginRight = options.right
      }
      if (options.bottom !== undefined) {
        this.tableMarginBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.tableMarginLeft = options.left
      }
    }
    return this
  }

  /**
   * 设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setTablePadding(options: MarkdownPaddingOptions | number): TableTheme {
    if (typeof options === "number") {
      this.tablePaddingTop = options
      this.tablePaddingRight = options
      this.tablePaddingBottom = options
      this.tablePaddingLeft = options
    } else {
      if (options.top !== undefined) {
        this.tablePaddingTop = options.top
      }
      if (options.right !== undefined) {
        this.tablePaddingRight = options.right
      }
      if (options.bottom !== undefined) {
        this.tablePaddingBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.tablePaddingLeft = options.left
      }
    }
    return this
  }

  /**
   * 设置表格内容内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setTableCellPadding(options: MarkdownPaddingOptions | number): TableTheme {
    if (typeof options === "number") {
      this.tableCellPaddingTop = options
      this.tableCellPaddingRight = options
      this.tableCellPaddingBottom = options
      this.tableCellPaddingLeft = options
    } else {
      if (options.top !== undefined) {
        this.tableCellPaddingTop = options.top
      }
      if (options.right !== undefined) {
        this.tableCellPaddingRight = options.right
      }
      if (options.bottom !== undefined) {
        this.tableCellPaddingBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.tableCellPaddingLeft = options.left
      }
    }
    return this
  }

  /**
   * 设置表格标题背景颜色
   *
   * @param color 表格标题背景颜色
   */
  setTableTitleBackgroundColor(color: number): TableTheme {
    this.tableTitleBackgroundColor = color
    return this
  }

  /**
   * 设置表格内容奇数行背景颜色
   *
   * @param color 奇数行背景颜色
   */
  setTableContentOddRowBackgroundColor(color: number): TableTheme {
    this.tableContentOddRowBackgroundColor = color
    return this
  }

  /**
   * 设置表格内容偶数行背景颜色
   *
   * @param color 偶数行背景颜色
   */
  setTableContentEvenRowBackgroundColor(color: number): TableTheme {
    this.tableContentEvenRowBackgroundColor = color
    return this
  }

  /**
   * 设置表格边框样式
   *
   * @param style 表格边框样式
   */
  setTableBorderStyle(style: BorderStyle): TableTheme {
    this.tableBorderStyle = style
    return this
  }

  /**
   * 设置表格边框宽度
   *
   * @param width 表格边框宽度
   */
  setTableBorderWidth(width: number): TableTheme {
    this.tableBorderWidth = width
    return this
  }

  /**
   * 设置表格边框颜色
   *
   * @param color 表格边框颜色
   */
  setTableBorderColor(color: number): TableTheme {
    this.tableBorderColor = color
    return this
  }

  /**
   * 分别设置表格边框4个圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setTableRadius(options: MarkdownRadiusOptions | number): TableTheme {
    if (typeof options === "number") {
      this.tableRadiusTopLeft = options
      this.tableRadiusTopRight = options
      this.tableRadiusBottomLeft = options
      this.tableRadiusBottomRight = options
    } else {
      if (options.topLeft !== undefined) {
        this.tableRadiusTopLeft = options.topLeft
      }
      if (options.topRight !== undefined) {
        this.tableRadiusTopRight = options.topRight
      }
      if (options.bottomLeft !== undefined) {
        this.tableRadiusBottomLeft = options.bottomLeft
      }
      if (options.bottomRight !== undefined) {
        this.tableRadiusBottomRight = options.bottomRight
      }
    }
    return this
  }

  /**
   * 设置表格滚动条状态
   *
   * @param state 滚动条状态
   */
  setTableScrollBarState(state: BarState): TableTheme {
    this.tableScrollBarState = state
    return this
  }

  /**
   * 设置表格滚动条颜色
   *
   * @param color 滚动条颜色
   */
  setTableScrollBarColor(color: number): TableTheme {
    this.tableScrollBarColor = color
    return this
  }

  /**
   * 设置表格一格最小宽度
   *
   * @param width 最小宽度
   */
  setTableMinCellWidth(width: number): TableTheme {
    this.tableMinCellWidth = width
    return this
  }

  /**
   * 设置表格一格最大宽度
   *
   * @param width 最大宽度
   */
  setTableMaxCellWidth(width: number): TableTheme {
    this.tableMaxCellWidth = width
    return this
  }

  /**
   * 设置表格第一列是否加粗
   *
   * @param isBold 是否加粗
   */
  setTableFirstColumnIsBold(isBold: boolean): TableTheme {
    this.tableFirstColumnIsBold = isBold
    return this
  }

  /**
   * 设置表格标题文本颜色
   *
   * @param color 表格标题文本颜色
   */
  setTableTitleTextFontColor(color: number): TableTheme {
    this.tableTitleTextFontColor = color
    return this
  }

  /**
   * 设置表格标题文本尺寸
   *
   * @param size 表格标题文本尺寸
   */
  setTableTitleTextFontSize(size: number): TableTheme {
    this.tableTitleTextFontSize = size
    return this
  }

  /**
   * 设置表格标题文本字体样式
   *
   * @param style 表格标题文本字体样式
   */
  setTableTitleTextFontStyle(style: FontStyle): TableTheme {
    this.tableTitleTextFontStyle = style
    return this
  }

  /**
   * 设置表格标题文本字体粗细
   *
   * @param weight 表格标题文本字体粗细
   */
  setTableTitleTextFontWeight(weight: FontWeight): TableTheme {
    this.tableTitleTextFontWeight = weight
    return this
  }

  /**
   * 设置表格标题文本字体
   *
   * @param family 表格标题文本字体
   */
  setTableTitleTextFontFamily(family: string): TableTheme {
    this.tableTitleTextFontFamily = family
    return this
  }

  /**
   * 设置表格标题文本行高
   *
   * @param lineHeight 表格标题文本行高
   */
  setTableTitleTextLineHeight(lineHeight: number): TableTheme {
    this.tableTitleTextLineHeight = lineHeight
    return this
  }

  /**
   * 设置表格标题文本字符间距
   *
   * @param spacing 表格标题文本字符间距
   */
  setTableTitleTextLetterSpacing(spacing: number): TableTheme {
    this.tableTitleTextLetterSpacing = spacing
    return this
  }

  /**
   * 设置表格内容文本颜色
   *
   * @param color 表格内容文本颜色
   */
  setTableContentTextFontColor(color: number): TableTheme {
    this.tableContentTextFontColor = color
    return this
  }

  /**
   * 设置表格内容文本尺寸
   *
   * @param size 表格内容文本尺寸
   */
  setTableContentTextFontSize(size: number): TableTheme {
    this.tableContentTextFontSize = size
    return this
  }

  /**
   * 设置表格内容文本字体样式
   *
   * @param style 表格内容文本字体样式
   */
  setTableContentTextFontStyle(style: FontStyle): TableTheme {
    this.tableContentTextFontStyle = style
    return this
  }

  /**
   * 设置表格内容文本字体粗细
   *
   * @param weight 表格内容文本字体粗细
   */
  setTableContentTextFontWeight(weight: FontWeight): TableTheme {
    this.tableContentTextFontWeight = weight
    return this
  }

  /**
   * 设置表格内容文本字体
   *
   * @param family 表格内容文本字体
   */
  setTableContentTextFontFamily(family: string): TableTheme {
    this.tableContentTextFontFamily = family
    return this
  }

  /**
   * 设置表格内容文本行高
   *
   * @param lineHeight 表格内容文本行高
   */
  setTableContentTextLineHeight(lineHeight: number): TableTheme {
    this.tableContentTextLineHeight = lineHeight
    return this
  }

  /**
   * 设置表格内容文本字符间距
   *
   * @param spacing 表格内容文本字符间距
   */
  setTableContentTextLetterSpacing(spacing: number): TableTheme {
    this.tableContentTextLetterSpacing = spacing
    return this
  }

  /**
   * 获取tableTitleBackgroundColor
   *
   * @returns tableTitleBackgroundColor
   */
  getTableTitleBackgroundColor(): number | undefined {
    return this.tableTitleBackgroundColor
  }

  /**
   * 获取tableContentOddRowBackgroundColor
   *
   * @returns tableContentOddRowBackgroundColor
   */
  getTableContentOddRowBackgroundColor(): number | undefined {
    return this.tableContentOddRowBackgroundColor
  }

  /**
   * 获取tableContentEvenRowBackgroundColor
   *
   * @returns tableContentEvenRowBackgroundColor
   */
  getTableContentEvenRowBackgroundColor(): number | undefined {
    return this.tableContentEvenRowBackgroundColor
  }

  /**
   * 获取tableMarginTop
   *
   * @returns tableMarginTop
   */
  getTableMarginTop(): number | undefined {
    return this.tableMarginTop
  }

  /**
   * 获取tableMarginRight
   *
   * @returns tableMarginRight
   */
  getTableMarginRight(): number | undefined {
    return this.tableMarginRight
  }

  /**
   * 获取tableMarginBottom
   *
   * @returns tableMarginBottom
   */
  getTableMarginBottom(): number | undefined {
    return this.tableMarginBottom
  }

  /**
   * 获取tableMarginLeft
   *
   * @returns tableMarginLeft
   */
  getTableMarginLeft(): number | undefined {
    return this.tableMarginLeft
  }

  /**
   * 获取tablePaddingTop
   *
   * @returns tablePaddingTop
   */
  getTablePaddingTop(): number | undefined {
    return this.tablePaddingTop
  }

  /**
   * 获取tablePaddingRight
   *
   * @returns tablePaddingRight
   */
  getTablePaddingRight(): number | undefined {
    return this.tablePaddingRight
  }

  /**
   * 获取tablePaddingBottom
   *
   * @returns tablePaddingBottom
   */
  getTablePaddingBottom(): number | undefined {
    return this.tablePaddingBottom
  }

  /**
   * 获取tablePaddingLeft
   *
   * @returns tablePaddingLeft
   */
  getTablePaddingLeft(): number | undefined {
    return this.tablePaddingLeft
  }

  /**
   * 获取tableCellPaddingTop
   *
   * @returns tableCellPaddingTop
   */
  getTableCellPaddingTop(): number | undefined {
    return this.tableCellPaddingTop
  }

  /**
   * 获取tableCellPaddingRight
   *
   * @returns tableCellPaddingRight
   */
  getTableCellPaddingRight(): number | undefined {
    return this.tableCellPaddingRight
  }

  /**
   * 获取tableCellPaddingBottom
   *
   * @returns tableCellPaddingBottom
   */
  getTableCellPaddingBottom(): number | undefined {
    return this.tableCellPaddingBottom
  }

  /**
   * 获取tableCellPaddingLeft
   *
   * @returns tableCellPaddingLeft
   */
  getTableCellPaddingLeft(): number | undefined {
    return this.tableCellPaddingLeft
  }

  /**
   * 获取tableBorderStyle
   *
   * @returns tableBorderStyle
   */
  getTableBorderStyle(): BorderStyle | undefined {
    return this.tableBorderStyle
  }

  /**
   * 获取tableBorderWidth
   *
   * @returns tableBorderWidth
   */
  getTableBorderWidth(): number | undefined {
    return this.tableBorderWidth
  }

  /**
   * 获取tableBorderColor
   *
   * @returns tableBorderColor
   */
  getTableBorderColor(): number | undefined {
    return this.tableBorderColor
  }

  /**
   * 获取tableRadiusTopLeft
   *
   * @returns tableRadiusTopLeft
   */
  getTableRadiusTopLeft(): number | undefined {
    return this.tableRadiusTopLeft
  }

  /**
   * 获取tableRadiusTopRight
   *
   * @returns tableRadiusTopRight
   */
  getTableRadiusTopRight(): number | undefined {
    return this.tableRadiusTopRight
  }

  /**
   * 获取tableRadiusBottomLeft
   *
   * @returns tableRadiusBottomLeft
   */
  getTableRadiusBottomLeft(): number | undefined {
    return this.tableRadiusBottomLeft
  }

  /**
   * 获取tableRadiusBottomRight
   *
   * @returns tableRadiusBottomRight
   */
  getTableRadiusBottomRight(): number | undefined {
    return this.tableRadiusBottomRight
  }

  /**
   * 获取tableScrollBarState
   *
   * @returns tableScrollBarState
   */
  getTableScrollBarState(): BarState | undefined {
    return this.tableScrollBarState
  }

  /**
   * 获取tableScrollBarColor
   *
   * @returns tableScrollBarColor
   */
  getTableScrollBarColor(): number | undefined {
    return this.tableScrollBarColor
  }

  /**
   * 获取tableMinCellWidth
   *
   * @returns tableMinCellWidth
   */
  getTableMinCellWidth(): number | undefined {
    return this.tableMinCellWidth
  }

  /**
   * 获取tableMaxCellWidth
   *
   * @returns tableMaxCellWidth
   */
  getTableMaxCellWidth(): number | undefined {
    return this.tableMaxCellWidth
  }

  /**
   * 获取tableFirstColumnIsBold
   *
   * @returns tableFirstColumnIsBold
   */
  getTableFirstColumnIsBold(): boolean | undefined {
    return this.tableFirstColumnIsBold
  }

  /**
   * 获取tableTitleTextFontColor
   *
   * @returns tableTitleTextFontColor
   */
  getTableTitleTextFontColor(): number | undefined {
    return this.tableTitleTextFontColor
  }

  /**
   * 获取tableTitleTextFontSize
   *
   * @returns tableTitleTextFontSize
   */
  getTableTitleTextFontSize(): number | undefined {
    return this.tableTitleTextFontSize
  }

  /**
   * 获取tableTitleTextFontStyle
   *
   * @returns tableTitleTextFontStyle
   */
  getTableTitleTextFontStyle(): FontStyle | undefined {
    return this.tableTitleTextFontStyle
  }

  /**
   * 获取tableTitleTextFontWeight
   *
   * @returns tableTitleTextFontWeight
   */
  getTableTitleTextFontWeight(): FontWeight | undefined {
    return this.tableTitleTextFontWeight
  }

  /**
   * 获取tableTitleTextFontFamily
   *
   * @returns tableTitleTextFontFamily
   */
  getTableTitleTextFontFamily(): string | undefined {
    return this.tableTitleTextFontFamily
  }

  /**
   * 获取tableTitleTextLineHeight
   *
   * @returns tableTitleTextLineHeight
   */
  getTableTitleTextLineHeight(): number | undefined {
    return this.tableTitleTextLineHeight
  }

  /**
   * 获取tableTitleTextLetterSpacing
   *
   * @returns tableTitleTextLetterSpacing
   */
  getTableTitleTextLetterSpacing(): number | undefined {
    return this.tableTitleTextLetterSpacing
  }

  /**
   * 获取tableContentTextFontColor
   *
   * @returns tableContentTextFontColor
   */
  getTableContentTextFontColor(): number | undefined {
    return this.tableContentTextFontColor
  }

  /**
   * 获取tableContentTextFontSize
   *
   * @returns tableContentTextFontSize
   */
  getTableContentTextFontSize(): number | undefined {
    return this.tableContentTextFontSize
  }

  /**
   * 获取tableContentTextFontStyle
   *
   * @returns tableContentTextFontStyle
   */
  getTableContentTextFontStyle(): FontStyle | undefined {
    return this.tableContentTextFontStyle
  }

  /**
   * 获取tableContentTextFontWeight
   *
   * @returns tableContentTextFontWeight
   */
  getTableContentTextFontWeight(): FontWeight | undefined {
    return this.tableContentTextFontWeight
  }

  /**
   * 获取tableContentTextFontFamily
   *
   * @returns tableContentTextFontFamily
   */
  getTableContentTextFontFamily(): string | undefined {
    return this.tableContentTextFontFamily
  }

  /**
   * 获取tableContentTextLineHeight
   *
   * @returns tableContentTextLineHeight
   */
  getTableContentTextLineHeight(): number | undefined {
    return this.tableContentTextLineHeight
  }

  /**
   * 获取tableContentTextLetterSpacing
   *
   * @returns tableContentTextLetterSpacing
   */
  getTableContentTextLetterSpacing(): number | undefined {
    return this.tableContentTextLetterSpacing
  }

  /**
   * 设置表格标题行是否吸顶
   *
   * @param enable 是否吸顶
   */
  setTableStickyHeader(enable: boolean): TableTheme {
    this.tableStickyHeader = enable
    return this
  }

  /**
   * 获取表格标题行是否吸顶
   *
   * @returns 是否吸顶
   */
  getTableStickyHeader(): boolean | undefined {
    return this.tableStickyHeader
  }

  /**
   * 设置表格头复制按钮是否显示
   *
   * @param enable 是否显示
   */
  setTableHeadIsShow(enable: boolean): TableTheme {
    this.tableHeadIsShow = enable
    return this
  }

  /**
   * 获取表格头复制按钮是否显示
   *
   * @returns 是否显示
   */
  getTableHeadIsShow(): boolean | undefined {
    return this.tableHeadIsShow
  }

  /**
   * 设置表格头标题文字
   *
   * @param text 标题文字
   */
  setTableHeadTitleText(text: string): TableTheme {
    this.tableHeadTitleText = text
    return this
  }

  /**
   * 获取表格头标题文字
   *
   * @returns 标题文字
   */
  getTableHeadTitleText(): string | undefined {
    return this.tableHeadTitleText
  }

  /**
   * 设置表格头标题文本字体族
   *
   * @param family 字体族
   */
  setTableHeadTitleTextFontFamily(family: string): TableTheme {
    this.tableHeadTitleTextFontFamily = family
    return this
  }

  /**
   * 获取表格头标题文本字体族
   *
   * @returns 字体族
   */
  getTableHeadTitleTextFontFamily(): string | undefined {
    return this.tableHeadTitleTextFontFamily
  }

  /**
   * 设置表格头标题文本字体大小
   *
   * @param size 字体大小
   */
  setTableHeadTitleTextFontSize(size: number): TableTheme {
    this.tableHeadTitleTextFontSize = size
    return this
  }

  /**
   * 获取表格头标题文本字体大小
   *
   * @returns 字体大小
   */
  getTableHeadTitleTextFontSize(): number | undefined {
    return this.tableHeadTitleTextFontSize
  }

  /**
   * 设置表格头标题文本字体粗细
   *
   * @param weight 字体粗细
   */
  setTableHeadTitleTextFontWeight(weight: FontWeight): TableTheme {
    this.tableHeadTitleTextFontWeight = weight
    return this
  }

  /**
   * 获取表格头标题文本字体粗细
   *
   * @returns 字体粗细
   */
  getTableHeadTitleTextFontWeight(): FontWeight | undefined {
    return this.tableHeadTitleTextFontWeight
  }

  /**
   * 设置表格头标题文本字体样式
   *
   * @param style 字体样式
   */
  setTableHeadTitleTextFontStyle(style: FontStyle): TableTheme {
    this.tableHeadTitleTextFontStyle = style
    return this
  }

  /**
   * 获取表格头标题文本字体样式
   *
   * @returns 字体样式
   */
  getTableHeadTitleTextFontStyle(): FontStyle | undefined {
    return this.tableHeadTitleTextFontStyle
  }

  /**
   * 设置表格头标题文本字体颜色
   *
   * @param color 颜色
   */
  setTableHeadTitleTextFontColor(color: number): TableTheme {
    this.tableHeadTitleTextFontColor = color
    return this
  }

  /**
   * 获取表格头标题文本字体颜色
   *
   * @returns 颜色
   */
  getTableHeadTitleTextFontColor(): number | undefined {
    return this.tableHeadTitleTextFontColor
  }

  /**
   * 设置表格头标题文本行高
   *
   * @param lineHeight 行高
   */
  setTableHeadTitleTextLineHeight(lineHeight: number): TableTheme {
    this.tableHeadTitleTextLineHeight = lineHeight
    return this
  }

  /**
   * 获取表格头标题文本行高
   *
   * @returns 行高
   */
  getTableHeadTitleTextLineHeight(): number | undefined {
    return this.tableHeadTitleTextLineHeight
  }

  /**
   * 设置表格头标题左外边距
   *
   * @param marginLeft 左外边距
   */
  setTableHeadTitleTextMarginLeft(marginLeft: number): TableTheme {
    this.tableHeadTitleTextMarginLeft = marginLeft
    return this
  }

  /**
   * 获取表格头标题左外边距
   *
   * @returns 左外边距
   */
  getTableHeadTitleTextMarginLeft(): number | undefined {
    return this.tableHeadTitleTextMarginLeft
  }

  /**
   * 设置表格头复制图标
   *
   * @param icon 复制图标资源
   */
  setTableHeadCopyIcon(icon: Resource): TableTheme {
    this.tableHeadCopyIcon = icon
    return this
  }

  /**
   * 获取表格头复制图标
   *
   * @returns 复制图标资源
   */
  getTableHeadCopyIcon(): Resource | undefined {
    return this.tableHeadCopyIcon
  }

  /**
   * 设置表格头复制图标宽度
   *
   * @param width 宽度
   */
  setTableHeadCopyIconWidth(width: number): TableTheme {
    this.tableHeadCopyIconWidth = width
    return this
  }

  /**
   * 获取表格头复制图标宽度
   *
   * @returns 宽度
   */
  getTableHeadCopyIconWidth(): number | undefined {
    return this.tableHeadCopyIconWidth
  }

  /**
   * 设置表格头复制图标高度
   *
   * @param height 高度
   */
  setTableHeadCopyIconHeight(height: number): TableTheme {
    this.tableHeadCopyIconHeight = height
    return this
  }

  /**
   * 获取表格头复制图标高度
   *
   * @returns 高度
   */
  getTableHeadCopyIconHeight(): number | undefined {
    return this.tableHeadCopyIconHeight
  }

  /**
   * 设置表格头复制图标右外边距
   *
   * @param marginRight 右外边距
   */
  setTableHeadCopyIconMarginRight(marginRight: number): TableTheme {
    this.tableHeadCopyIconMarginRight = marginRight
    return this
  }

  /**
   * 获取表格头复制图标右外边距
   *
   * @returns 右外边距
   */
  getTableHeadCopyIconMarginRight(): number | undefined {
    return this.tableHeadCopyIconMarginRight
  }
}
