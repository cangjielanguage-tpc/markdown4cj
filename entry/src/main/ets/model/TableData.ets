import { BaseMDData } from "./BaseMDData"

export class TableData extends BaseMDData {
  _tableTitleBackgroundColor: ResourceColor | undefined = undefined // 表格标题背景颜色
  _tableContentOddRowBackgroundColor: ResourceColor | undefined = undefined // 表格内容奇数行背景颜色
  _tableContentEvenRowBackgroundColor: ResourceColor | undefined = undefined // 表格内容偶数行背景颜色
  _tableMarginTop: Length = 0.0 // 表格上外边距
  _tableMarginRight: Length = 0.0 // 表格右外边距
  _tableMarginBottom: Length = 0.0 // 表格下外边距
  _tableMarginLeft: Length = 0.0 // 表格左外边距
  _tablePaddingTop: Length = 0.0 // 表格上内边距
  _tablePaddingRight: Length = 0.0 // 表格右内边距
  _tablePaddingBottom: Length = 0.0 // 表格下内边距
  _tablePaddingLeft: Length = 0.0 // 表格左内边距
  _tableCellPaddingTop: Length = 4.0 // 表格内容上内边距
  _tableCellPaddingRight: Length = 4.0 // 表格内容右内边距
  _tableCellPaddingBottom: Length = 4.0 // 表格内容下内边距
  _tableCellPaddingLeft: Length = 4.0 // 表格内容左内边距
  _tableBorderStyle: BorderStyle = BorderStyle.Solid // 表格边框样式
  _tableBorderWidth: Length = 1.0 // 表格边框宽度
  _tableBorderColor: ResourceColor | undefined = undefined // 表格边框颜色
  _tableRadiusTopLeft: Length = 5.0 // 表格边框左上圆角
  _tableRadiusTopRight: Length = 5.0 // 表格边框右上圆角
  _tableRadiusBottomLeft: Length = 5.0 // 表格边框左下圆角
  _tableRadiusBottomRight: Length = 5.0 // 表格边框右下圆角
  _tableScrollBarState: BarState = BarState.Off // 表格滚动条状态
  _tableScrollBarColor: ResourceColor | undefined = undefined // 表格滚动条颜色
  _tableMinCellWidth: Length = 50.0 // 表格一格最小宽度
  _tableMaxCellWidth: Length = 300.0 // 表格一格最大宽度
  _tableFirstColumnIsBold: boolean = false // 表格第一列是否加粗
  _tableTitleTextFontColor: ResourceColor | undefined = undefined // 表格标题文本颜色
  _tableTitleTextFontSize: number | string | Resource = 14.0 // 表格标题文本尺寸
  _tableTitleTextFontStyle: FontStyle = FontStyle.Normal // 表格标题文本字体样式
  _tableTitleTextFontWeight: number | FontWeight = FontWeight.Bold // 表格标题文本字体粗细
  _tableTitleTextFontFamily: string | Resource = 'HarmonyOS Sans' // 表格标题文本字体
  _tableTitleTextLineHeight: number | string | Resource = 22.0 // 表格标题文本行高
  _tableTitleTextLetterSpacing: number = 0.0 // 表格标题文本字符间距
  _tableContentTextFontColor: ResourceColor | undefined = undefined // 表格内容文本颜色
  _tableContentTextFontSize: number | string | Resource = 14.0 // 表格内容文本尺寸
  _tableContentTextFontStyle: FontStyle = FontStyle.Normal // 表格内容文本字体样式
  _tableContentTextFontWeight: number | FontWeight = FontWeight.Normal // 表格内容文本字体粗细
  _tableContentTextFontFamily: string | Resource = 'HarmonyOS Sans' // 表格内容文本字体
  _tableContentTextLineHeight: number | string | Resource = 22.0 // 表格内容文本行高
  _tableContentTextLetterSpacing: number = 0.0 // 表格内容文本字符间距
  _tableStickyHeader: boolean = false // 表格标题行是否吸顶

  constructor() {
    super()
  }
}