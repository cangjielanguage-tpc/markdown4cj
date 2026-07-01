import { BaseMDData } from "./BaseMDData"

export class DescListData extends BaseMDData {
  _definitionListBackgroundColor: ResourceColor | undefined = undefined // 定义列表背景颜色
  _definitionListMarginTop: Length = 0.0 // 定义列表上外边距
  _definitionListMarginRight: Length = 0.0 // 定义列表右外边距
  _definitionListMarginBottom: Length = 0.0 // 定义列表下外边距
  _definitionListMarginLeft: Length = 0.0 // 定义列表左外边距
  _definitionListPaddingTop: Length = 0.0 // 定义列表上内边距
  _definitionListPaddingRight: Length = 0.0 // 定义列表右内边距
  _definitionListPaddingBottom: Length = 0.0 // 定义列表下内边距
  _definitionListPaddingLeft: Length = 0.0 // 定义列表左内边距
  _definitionListTermToDescriptionSpacing: number = 8.0 // 定义列表术语和定义行之间间距
  _definitionListTermTextFontWeight: number | FontWeight = FontWeight.Bold // 定义列表术语文本字体粗细
  _definitionListTermTextFontStyle: FontStyle = FontStyle.Italic // 定义列表术语文本字体样式
  _definitionListDescriptionItemSpacing: number = 8.0 // 定义列表定义行之间间距
  _definitionListDescriptionIndent: number = 8.0 // 定义列表定义行左缩进距离

  public set definitionListBackgroundColor(value: ResourceColor | undefined) {
    this._definitionListBackgroundColor = value
  }

  public set definitionListMarginTop(value: Length) {
    this._definitionListMarginTop = value
  }

  public set definitionListMarginRight(value: Length) {
    this._definitionListMarginRight = value
  }

  public set definitionListMarginBottom(value: Length) {
    this._definitionListMarginBottom = value
  }

  public set definitionListMarginLeft(value: Length) {
    this._definitionListMarginLeft = value
  }

  public set definitionListPaddingTop(value: Length) {
    this._definitionListPaddingTop = value
  }

  public set definitionListPaddingRight(value: Length) {
    this._definitionListPaddingRight = value
  }

  public set definitionListPaddingBottom(value: Length) {
    this._definitionListPaddingBottom = value
  }

  public set definitionListPaddingLeft(value: Length) {
    this._definitionListPaddingLeft = value
  }

  public set definitionListTermToDescriptionSpacing(value: number) {
    this._definitionListTermToDescriptionSpacing = value
  }

  public set definitionListTermTextFontWeight(value: number | FontWeight) {
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