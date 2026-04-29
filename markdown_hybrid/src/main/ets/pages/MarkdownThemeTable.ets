/**
 * Markdown用户可设置的样式-表格样式
 */
export class MarkdownThemeTable {
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
   * 设置4个外边距为统一值
   *
   * @param margin 外边距
   */
  setTableAllMargin(margin: number): void {
    this.tableMarginTop = margin
    this.tableMarginRight = margin
    this.tableMarginBottom = margin
    this.tableMarginLeft = margin
  }

  /**
   * 分别设置4个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setTableMargin(top?: number, right?: number, bottom?: number, left?: number): void {
    this.tableMarginTop = top
    this.tableMarginRight = right
    this.tableMarginBottom = bottom
    this.tableMarginLeft = left
  }

  /**
   * 设置4个内边距为统一值
   *
   * @param padding 内边距
   */
  setTableAllPadding(padding: number): void {
    this.tablePaddingTop = padding
    this.tablePaddingRight = padding
    this.tablePaddingBottom = padding
    this.tablePaddingLeft = padding
  }

  /**
   * 分别设置4个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setTablePadding(top?: number, right?: number, bottom?: number, left?: number): void {
    this.tablePaddingTop = top
    this.tablePaddingRight = right
    this.tablePaddingBottom = bottom
    this.tablePaddingLeft = left
  }

  /**
   * 设置表格内容内边距
   *
   * @param padding 内边距
   */
  setTableCellAllPadding(padding: number): void {
    this.tableCellPaddingTop = padding
    this.tableCellPaddingRight = padding
    this.tableCellPaddingBottom = padding
    this.tableCellPaddingLeft = padding
  }

  /**
   * 设置表格内容内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setTableCellPadding(top?: number, right?: number, bottom?: number, left?: number): void {
    this.tableCellPaddingTop = top
    this.tableCellPaddingRight = right
    this.tableCellPaddingBottom = bottom
    this.tableCellPaddingLeft = left
  }

  /**
   * 设置表格标题背景颜色
   *
   * @param color 表格标题背景颜色
   */
  setTableTitleBackgroundColor(color: number): void {
    this.tableTitleBackgroundColor = color
  }

  /**
   * 设置表格内容奇数行背景颜色
   *
   * @param color 奇数行背景颜色
   */
  setTableContentOddRowBackgroundColor(color: number): void {
    this.tableContentOddRowBackgroundColor = color
  }

  /**
   * 设置表格内容偶数行背景颜色
   *
   * @param color 偶数行背景颜色
   */
  setTableContentEvenRowBackgroundColor(color: number): void {
    this.tableContentEvenRowBackgroundColor = color
  }

  /**
   * 设置表格边框样式
   *
   * @param style 表格边框样式
   */
  setTableBorderStyle(style: BorderStyle): void {
    this.tableBorderStyle = style
  }

  /**
   * 设置表格边框宽度
   *
   * @param width 表格边框宽度
   */
  setTableBorderWidth(width: number): void {
    this.tableBorderWidth = width
  }

  /**
   * 设置表格边框颜色
   *
   * @param color 表格边框颜色
   */
  setTableBorderColor(color: number): void {
    this.tableBorderColor = color
  }

  /**
   * 设置表格边框4个圆角为统一值
   *
   * @param radius 圆角半径
   */
  setTableAllRadius(radius: number): void {
    this.tableRadiusTopLeft = radius
    this.tableRadiusTopRight = radius
    this.tableRadiusBottomLeft = radius
    this.tableRadiusBottomRight = radius
  }

  /**
   * 分别设置表格边框4个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setTableRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void {
    this.tableRadiusTopLeft = topLeft
    this.tableRadiusTopRight = topRight
    this.tableRadiusBottomLeft = bottomLeft
    this.tableRadiusBottomRight = bottomRight
  }

  /**
   * 设置表格滚动条状态
   *
   * @param state 滚动条状态
   */
  setTableScrollBarState(state: BarState): void {
    this.tableScrollBarState = state
  }

  /**
   * 设置表格滚动条颜色
   *
   * @param color 滚动条颜色
   */
  setTableScrollBarColor(color: number): void {
    this.tableScrollBarColor = color
  }

  /**
   * 设置表格一格最小宽度
   *
   * @param width 最小宽度
   */
  setTableMinCellWidth(width: number): void {
    this.tableMinCellWidth = width
  }

  /**
   * 设置表格一格最大宽度
   *
   * @param width 最大宽度
   */
  setTableMaxCellWidth(width: number): void {
    this.tableMaxCellWidth = width
  }

  /**
   * 设置表格第一列是否加粗
   *
   * @param isBold 是否加粗
   */
  setTableFirstColumnIsBold(isBold: boolean): void {
    this.tableFirstColumnIsBold = isBold
  }

  /**
   * 设置表格标题文本颜色
   *
   * @param color 表格标题文本颜色
   */
  setTableTitleTextFontColor(color: number): void {
    this.tableTitleTextFontColor = color
  }

  /**
   * 设置表格标题文本尺寸
   *
   * @param size 表格标题文本尺寸
   */
  setTableTitleTextFontSize(size: number): void {
    this.tableTitleTextFontSize = size
  }

  /**
   * 设置表格标题文本字体样式
   *
   * @param style 表格标题文本字体样式
   */
  setTableTitleTextFontStyle(style: FontStyle): void {
    this.tableTitleTextFontStyle = style
  }

  /**
   * 设置表格标题文本字体粗细
   *
   * @param weight 表格标题文本字体粗细
   */
  setTableTitleTextFontWeight(weight: FontWeight): void {
    this.tableTitleTextFontWeight = weight
  }

  /**
   * 设置表格标题文本字体
   *
   * @param family 表格标题文本字体
   */
  setTableTitleTextFontFamily(family: string): void {
    this.tableTitleTextFontFamily = family
  }

  /**
   * 设置表格标题文本行高
   *
   * @param lineHeight 表格标题文本行高
   */
  setTableTitleTextLineHeight(lineHeight: number): void {
    this.tableTitleTextLineHeight = lineHeight
  }

  /**
   * 设置表格标题文本字符间距
   *
   * @param spacing 表格标题文本字符间距
   */
  setTableTitleTextLetterSpacing(spacing: number): void {
    this.tableTitleTextLetterSpacing = spacing
  }

  /**
   * 设置表格内容文本颜色
   *
   * @param color 表格内容文本颜色
   */
  setTableContentTextFontColor(color: number): void {
    this.tableContentTextFontColor = color
  }

  /**
   * 设置表格内容文本尺寸
   *
   * @param size 表格内容文本尺寸
   */
  setTableContentTextFontSize(size: number): void {
    this.tableContentTextFontSize = size
  }

  /**
   * 设置表格内容文本字体样式
   *
   * @param style 表格内容文本字体样式
   */
  setTableContentTextFontStyle(style: FontStyle): void {
    this.tableContentTextFontStyle = style
  }

  /**
   * 设置表格内容文本字体粗细
   *
   * @param weight 表格内容文本字体粗细
   */
  setTableContentTextFontWeight(weight: FontWeight): void {
    this.tableContentTextFontWeight = weight
  }

  /**
   * 设置表格内容文本字体
   *
   * @param family 表格内容文本字体
   */
  setTableContentTextFontFamily(family: string): void {
    this.tableContentTextFontFamily = family
  }

  /**
   * 设置表格内容文本行高
   *
   * @param lineHeight 表格内容文本行高
   */
  setTableContentTextLineHeight(lineHeight: number): void {
    this.tableContentTextLineHeight = lineHeight
  }

  /**
   * 设置表格内容文本字符间距
   *
   * @param spacing 表格内容文本字符间距
   */
  setTableContentTextLetterSpacing(spacing: number): void {
    this.tableContentTextLetterSpacing = spacing
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
}
