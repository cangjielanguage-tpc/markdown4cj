/**
 * Markdown用户可设置的样式-表格样式
 */
export class MarkdownThemeTable {
  /**
   * 表格标题背景颜色
   */
  tableTitleBackgroundColor?: number = undefined

  /**
   * 表格内容奇数行背景颜色
   */
  tableContentOddRowBackgroundColor?: number = undefined

  /**
   * 表格内容偶数行背景颜色
   */
  tableContentEvenRowBackgroundColor?: number = undefined

  /**
   * 表格上外边距
   */
  tableMarginTop?: number = undefined

  /**
   * 表格右外边距
   */
  tableMarginRight?: number = undefined

  /**
   * 表格下外边距
   */
  tableMarginBottom?: number = undefined

  /**
   * 表格左外边距
   */
  tableMarginLeft?: number = undefined

  /**
   * 表格上内边距
   */
  tablePaddingTop?: number = undefined

  /**
   * 表格右内边距
   */
  tablePaddingRight?: number = undefined

  /**
   * 表格下内边距
   */
  tablePaddingBottom?: number = undefined

  /**
   * 表格左内边距
   */
  tablePaddingLeft?: number = undefined

  /**
   * 表格内容上内边距
   */
  tableCellPaddingTop?: number = undefined

  /**
   * 表格内容右内边距
   */
  tableCellPaddingRight?: number = undefined

  /**
   * 表格内容下内边距
   */
  tableCellPaddingBottom?: number = undefined

  /**
   * 表格内容左内边距
   */
  tableCellPaddingLeft?: number = undefined

  /**
   * 表格边框样式
   */
  tableBorderStyle?: BorderStyle = undefined

  /**
   * 表格边框宽度
   */
  tableBorderWidth?: number = undefined

  /**
   * 表格边框颜色
   */
  tableBorderColor?: number = undefined

  /**
   * 表格边框左上圆角
   */
  tableRadiusTopLeft?: number = undefined

  /**
   * 表格边框右上圆角
   */
  tableRadiusTopRight?: number = undefined

  /**
   * 表格边框左下圆角
   */
  tableRadiusBottomLeft?: number = undefined

  /**
   * 表格边框右下圆角
   */
  tableRadiusBottomRight?: number = undefined

  /**
   * 表格滚动条状态，默认不显示
   */
  tableScrollBarState?: BarState = undefined

  /**
   * 表格滚动条颜色
   */
  tableScrollBarColor?: number = undefined

  /**
   * 表格一格最小宽度
   */
  tableMinCellWidth?: number = undefined

  /**
   * 表格一格最大宽度
   */
  tableMaxCellWidth?: number = undefined

  /**
   * 表格第一列是否加粗
   */
  tableFirstColumnIsBold?: boolean = undefined

  /**
   * 表格标题文本颜色
   */
  tableTitleTextFontColor?: number = undefined

  /**
   * 表格标题文本尺寸
   */
  tableTitleTextFontSize?: number = undefined

  /**
   * 表格标题文本字体样式
   */
  tableTitleTextFontStyle?: FontStyle = undefined

  /**
   * 表格标题文本字体粗细
   */
  tableTitleTextFontWeight?: FontWeight = undefined

  /**
   * 表格标题文本字体
   */
  tableTitleTextFontFamily?: string = undefined

  /**
   * 表格标题文本行高
   */
  tableTitleTextLineHeight?: number = undefined

  /**
   * 表格标题文本字符间距
   */
  tableTitleTextLetterSpacing?: number = undefined

  /**
   * 表格内容文本颜色
   */
  tableContentTextFontColor?: number = undefined

  /**
   * 表格内容文本尺寸
   */
  tableContentTextFontSize?: number = undefined

  /**
   * 表格内容文本字体样式
   */
  tableContentTextFontStyle?: FontStyle = undefined

  /**
   * 表格内容文本字体粗细
   */
  tableContentTextFontWeight?: FontWeight = undefined

  /**
   * 表格内容文本字体
   */
  tableContentTextFontFamily?: string = undefined

  /**
   * 表格内容文本行高
   */
  tableContentTextLineHeight?: number = undefined

  /**
   * 表格内容文本字符间距
   */
  tableContentTextLetterSpacing?: number = undefined

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
}
