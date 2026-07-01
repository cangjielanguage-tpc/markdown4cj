import { BaseMDData } from "./BaseMDData"

export class DescListData extends BaseMDData {
  _definitionListBackgroundColor: number | undefined = undefined // 定义列表背景颜色
  _definitionListMarginTop: number = 8 // 定义列表上外边距
  _definitionListMarginRight: number = 0 // 定义列表右外边距
  _definitionListMarginBottom: number = 8 // 定义列表下外边距
  _definitionListMarginLeft: number = 0 // 定义列表左外边距
  _definitionListPaddingTop: number = 0 // 定义列表上内边距
  _definitionListPaddingRight: number = 0 // 定义列表右内边距
  _definitionListPaddingBottom: number = 0 // 定义列表下内边距
  _definitionListPaddingLeft: number = 0 // 定义列表左内边距
  _definitionListTermToDescriptionSpacing: number = 4 // 定义列表术语和定义行之间间距
  _definitionListTermTextFontWeight: FontWeight = FontWeight.Bold // 定义列表术语文本字体粗细
  _definitionListTermTextFontStyle: FontStyle = FontStyle.Normal // 定义列表术语文本字体样式
  _definitionListDescriptionItemSpacing: number = 4 // 定义列表定义行之间间距
  _definitionListDescriptionIndent: number = 16 // 定义列表定义行左缩进距离

  public set definitionListBackgroundColor(value: number | undefined) {
    this._definitionListBackgroundColor = value
  }

  public set definitionListMarginTop(value: number) {
    this._definitionListMarginTop = value
  }

  public set definitionListMarginRight(value: number) {
    this._definitionListMarginRight = value
  }

  public set definitionListMarginBottom(value: number) {
    this._definitionListMarginBottom = value
  }

  public set definitionListMarginLeft(value: number) {
    this._definitionListMarginLeft = value
  }

  public set definitionListPaddingTop(value: number) {
    this._definitionListPaddingTop = value
  }

  public set definitionListPaddingRight(value: number) {
    this._definitionListPaddingRight = value
  }

  public set definitionListPaddingBottom(value: number) {
    this._definitionListPaddingBottom = value
  }

  public set definitionListPaddingLeft(value: number) {
    this._definitionListPaddingLeft = value
  }

  public set definitionListTermToDescriptionSpacing(value: number) {
    this._definitionListTermToDescriptionSpacing = value
  }

  public set definitionListTermTextFontWeight(value: FontWeight) {
    this._definitionListTermTextFontWeight = value
  }

  public set definitionListTermTextFontStyle(value: FontStyle) {
    this._definitionListTermTextFontStyle = value
  }

  public set definitionListDescriptionItemSpacing(value: number) {
    this._definitionListDescriptionItemSpacing = value
  }

  public set definitionListDescriptionIndent(value: number) {
    this._definitionListDescriptionIndent = value
  }

  constructor() {
    super()
  }
}