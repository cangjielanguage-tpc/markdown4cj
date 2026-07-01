import { BaseMDData } from "./BaseMDData"

export class ParagraphData extends BaseMDData {
  _paragraphBackgroundColor: ResourceColor | undefined = undefined // 段落背景颜色
  _paragraphMarginTop: Length = 0.0 // 段落上外边距
  _paragraphMarginRight: Length = 0.0 // 段落右外边距
  _paragraphMarginBottom: Length = 0.0 // 段落下外边距
  _paragraphMarginLeft: Length = 0.0 // 段落左外边距
  _paragraphPaddingTop: Length = 0.0 // 段落上内边距
  _paragraphPaddingRight: Length = 0.0 // 段落右内边距
  _paragraphPaddingBottom: Length = 0.0 // 段落下内边距
  _paragraphPaddingLeft: Length = 0.0 // 段落左内边距
  _paragraphTextFontColor: ResourceColor | undefined = undefined // 段落文本颜色
  _paragraphTextFontSize: number | string | Resource = 14.0 // 段落文本尺寸
  _paragraphTextFontStyle: FontStyle = FontStyle.Normal // 段落文本字体样式
  _paragraphTextFontWeight: number | FontWeight = FontWeight.Normal // 段落文本字体粗细
  _paragraphTextFontFamily: string | Resource = 'HarmonyOS Sans' // 段落文本字体
  _paragraphTextLineHeight: number | string | Resource = 22.0 // 段落文本行高
  _paragraphTextLetterSpacing: number = 0.0 // 段落文本字符间距

  public set paragraphBackgroundColor(value: ResourceColor | undefined) {
    this._paragraphBackgroundColor = value
  }

  public set paragraphMarginTop(value: Length) {
    this._paragraphMarginTop = value
  }

  public set paragraphMarginRight(value: Length) {
    this._paragraphMarginRight = value
  }

  public set paragraphMarginBottom(value: Length) {
    this._paragraphMarginBottom = value
  }

  public set paragraphMarginLeft(value: Length) {
    this._paragraphMarginLeft = value
  }

  public set paragraphPaddingTop(value: Length) {
    this._paragraphPaddingTop = value
  }

  public set paragraphPaddingRight(value: Length) {
    this._paragraphPaddingRight = value
  }

  public set paragraphPaddingBottom(value: Length) {
    this._paragraphPaddingBottom = value
  }

  public set paragraphPaddingLeft(value: Length) {
    this._paragraphPaddingLeft = value
  }

  public set paragraphTextFontColor(value: ResourceColor | undefined) {
    this._paragraphTextFontColor = value
  }

  public set paragraphTextFontSize(value: number | string | Resource) {
    this._paragraphTextFontSize = value
  }

  public set paragraphTextFontStyle(value: FontStyle) {
    this._paragraphTextFontStyle = value
  }

  public set paragraphTextFontWeight(value: number | FontWeight) {
    this._paragraphTextFontWeight = value
  }

  public set paragraphTextFontFamily(value: string | Resource) {
    this._paragraphTextFontFamily = value
  }

  public set paragraphTextLineHeight(value: number | string | Resource) {
    this._paragraphTextLineHeight = value
  }

  public set paragraphTextLetterSpacing(value: number) {
    this._paragraphTextLetterSpacing = value
  }

  constructor() {
    super()
  }
}