import { BaseMDData } from "./BaseMDData"

export class TableData extends BaseMDData {
  _tableTitleBackgroundColor: number | undefined = undefined // 表格标题背景颜色
  _tableContentOddRowBackgroundColor: number | undefined = undefined // 表格内容奇数行背景颜色
  _tableContentEvenRowBackgroundColor: number | undefined = undefined // 表格内容偶数行背景颜色
  _tableMarginTop: number = 8 // 表格上外边距
  _tableMarginRight: number = 8 // 表格右外边距
  _tableMarginBottom: number = 8 // 表格下外边距
  _tableMarginLeft: number = 8 // 表格左外边距
  _tablePaddingTop: number = 0 // 表格上内边距
  _tablePaddingRight: number = 0 // 表格右内边距
  _tablePaddingBottom: number = 0 // 表格下内边距
  _tablePaddingLeft: number = 0 // 表格左内边距
  _tableCellPaddingTop: number = 4 // 表格内容上内边距
  _tableCellPaddingRight: number = 4 // 表格内容右内边距
  _tableCellPaddingBottom: number = 4 // 表格内容下内边距
  _tableCellPaddingLeft: number = 4 // 表格内容左内边距
  _tableBorderStyle: BorderStyle = BorderStyle.Solid // 表格边框样式
  _tableBorderWidth: number = 1 // 表格边框宽度
  _tableBorderColor: number | undefined = undefined // 表格边框颜色
  _tableRadiusTopLeft: number = 5 // 表格边框左上圆角
  _tableRadiusTopRight: number = 5 // 表格边框右上圆角
  _tableRadiusBottomLeft: number = 5 // 表格边框左下圆角
  _tableRadiusBottomRight: number = 5 // 表格边框右下圆角
  _tableScrollBarState: BarState = BarState.Off // 表格滚动条状态
  _tableScrollBarColor: number | undefined = undefined // 表格滚动条颜色
  _tableMinCellWidth: number = 50 // 表格一格最小宽度
  _tableMaxCellWidth: number = 300 // 表格一格最大宽度
  _tableFirstColumnIsBold: boolean = false // 表格第一列是否加粗
  _tableTitleTextFontColor: number | undefined = undefined // 表格标题文本颜色
  _tableTitleTextFontSize: number = 14 // 表格标题文本尺寸
  _tableTitleTextFontStyle: FontStyle = FontStyle.Normal // 表格标题文本字体样式
  _tableTitleTextFontWeight: FontWeight = FontWeight.Normal // 表格标题文本字体粗细
  _tableTitleTextFontFamily: string = 'HarmonyOS Sans' // 表格标题文本字体
  _tableTitleTextLineHeight: number = 22 // 表格标题文本行高
  _tableTitleTextLetterSpacing: number = 0 // 表格标题文本字符间距
  _tableContentTextFontColor: number | undefined = undefined // 表格内容文本颜色
  _tableContentTextFontSize: number = 14 // 表格内容文本尺寸
  _tableContentTextFontStyle: FontStyle = FontStyle.Normal // 表格内容文本字体样式
  _tableContentTextFontWeight: FontWeight = FontWeight.Normal // 表格内容文本字体粗细
  _tableContentTextFontFamily: string = 'HarmonyOS Sans' // 表格内容文本字体
  _tableContentTextLineHeight: number = 22 // 表格内容文本行高
  _tableContentTextLetterSpacing: number = 0 // 表格内容文本字符间距

  public set tableTitleBackgroundColor(value: number | undefined) {
    this._tableTitleBackgroundColor = value
  }

  public set tableContentOddRowBackgroundColor(value: number | undefined) {
    this._tableContentOddRowBackgroundColor = value
  }

  public set tableContentEvenRowBackgroundColor(value: number | undefined) {
    this._tableContentEvenRowBackgroundColor = value
  }

  public set tableMarginTop(value: number) {
    this._tableMarginTop = value
  }

  public set tableMarginRight(value: number) {
    this._tableMarginRight = value
  }

  public set tableMarginBottom(value: number) {
    this._tableMarginBottom = value
  }

  public set tableMarginLeft(value: number) {
    this._tableMarginLeft = value
  }

  public set tablePaddingTop(value: number) {
    this._tablePaddingTop = value
  }

  public set tablePaddingRight(value: number) {
    this._tablePaddingRight = value
  }

  public set tablePaddingBottom(value: number) {
    this._tablePaddingBottom = value
  }

  public set tablePaddingLeft(value: number) {
    this._tablePaddingLeft = value
  }

  public set tableCellPaddingTop(value: number) {
    this._tableCellPaddingTop = value
  }

  public set tableCellPaddingRight(value: number) {
    this._tableCellPaddingRight = value
  }

  public set tableCellPaddingBottom(value: number) {
    this._tableCellPaddingBottom = value
  }

  public set tableCellPaddingLeft(value: number) {
    this._tableCellPaddingLeft = value
  }

  public set tableBorderStyle(value: BorderStyle) {
    this._tableBorderStyle = value
  }

  public set tableBorderWidth(value: number) {
    this._tableBorderWidth = value
  }

  public set tableBorderColor(value: number | undefined) {
    this._tableBorderColor = value
  }

  public set tableRadiusTopLeft(value: number) {
    this._tableRadiusTopLeft = value
  }

  public set tableRadiusTopRight(value: number) {
    this._tableRadiusTopRight = value
  }

  public set tableRadiusBottomLeft(value: number) {
    this._tableRadiusBottomLeft = value
  }

  public set tableRadiusBottomRight(value: number) {
    this._tableRadiusBottomRight = value
  }

  public set tableScrollBarState(value: BarState) {
    this._tableScrollBarState = value
  }

  public set tableScrollBarColor(value: number | undefined) {
    this._tableScrollBarColor = value
  }

  public set tableMinCellWidth(value: number) {
    this._tableMinCellWidth = value
  }

  public set tableMaxCellWidth(value: number) {
    this._tableMaxCellWidth = value
  }

  public set tableFirstColumnIsBold(value: boolean) {
    this._tableFirstColumnIsBold = value
  }

  public set tableTitleTextFontColor(value: number | undefined) {
    this._tableTitleTextFontColor = value
  }

  public set tableTitleTextFontSize(value: number) {
    this._tableTitleTextFontSize = value
  }

  public set tableTitleTextFontStyle(value: FontStyle) {
    this._tableTitleTextFontStyle = value
  }

  public set tableTitleTextFontWeight(value: FontWeight) {
    this._tableTitleTextFontWeight = value
  }

  public set tableTitleTextFontFamily(value: string) {
    this._tableTitleTextFontFamily = value
  }

  public set tableTitleTextLineHeight(value: number) {
    this._tableTitleTextLineHeight = value
  }

  public set tableTitleTextLetterSpacing(value: number) {
    this._tableTitleTextLetterSpacing = value
  }

  public set tableContentTextFontColor(value: number | undefined) {
    this._tableContentTextFontColor = value
  }

  public set tableContentTextFontSize(value: number) {
    this._tableContentTextFontSize = value
  }

  public set tableContentTextFontStyle(value: FontStyle) {
    this._tableContentTextFontStyle = value
  }

  public set tableContentTextFontWeight(value: FontWeight) {
    this._tableContentTextFontWeight = value
  }

  public set tableContentTextFontFamily(value: string) {
    this._tableContentTextFontFamily = value
  }

  public set tableContentTextLineHeight(value: number) {
    this._tableContentTextLineHeight = value
  }

  public set tableContentTextLetterSpacing(value: number) {
    this._tableContentTextLetterSpacing = value
  }

  constructor() {
    super()
  }
}