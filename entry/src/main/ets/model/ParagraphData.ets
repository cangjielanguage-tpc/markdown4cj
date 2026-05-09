import { BaseMDData } from "./BaseMDData"

export class ParagraphData extends BaseMDData {
  _paragraphBackgroundColor: number | undefined = undefined // 段落背景颜色
  _paragraphMarginTop: number = 8 // 段落上外边距
  _paragraphMarginRight: number = 8 // 段落右外边距
  _paragraphMarginBottom: number = 8 // 段落下外边距
  _paragraphMarginLeft: number = 8 // 段落左外边距
  _paragraphPaddingTop: number = 0 // 段落上内边距
  _paragraphPaddingRight: number = 0 // 段落右内边距
  _paragraphPaddingBottom: number = 0 // 段落下内边距
  _paragraphPaddingLeft: number = 0 // 段落左内边距
  _paragraphTextFontColor: number | undefined = undefined // 段落文本颜色
  _paragraphTextFontSize: number = 14 // 段落文本尺寸
  _paragraphTextFontStyle: FontStyle = FontStyle.Normal // 段落文本字体样式
  _paragraphTextFontWeight: FontWeight = FontWeight.Normal // 段落文本字体粗细
  _paragraphTextFontFamily: string = 'HarmonyOS Sans' // 段落文本字体
  _paragraphTextLineHeight: number = 22 // 段落文本行高
  _paragraphTextLetterSpacing: number = 0 // 段落文本字符间距

  public set paragraphBackgroundColor(value: number | undefined) {
    this._paragraphBackgroundColor = value
  }

  public set paragraphMarginTop(value: number) {
    this._paragraphMarginTop = value
  }

  public set paragraphMarginRight(value: number) {
    this._paragraphMarginRight = value
  }

  public set paragraphMarginBottom(value: number) {
    this._paragraphMarginBottom = value
  }

  public set paragraphMarginLeft(value: number) {
    this._paragraphMarginLeft = value
  }

  public set paragraphPaddingTop(value: number) {
    this._paragraphPaddingTop = value
  }

  public set paragraphPaddingRight(value: number) {
    this._paragraphPaddingRight = value
  }

  public set paragraphPaddingBottom(value: number) {
    this._paragraphPaddingBottom = value
  }

  public set paragraphPaddingLeft(value: number) {
    this._paragraphPaddingLeft = value
  }

  public set paragraphTextFontColor(value: number | undefined) {
    this._paragraphTextFontColor = value
  }

  public set paragraphTextFontSize(value: number) {
    this._paragraphTextFontSize = value
  }

  public set paragraphTextFontStyle(value: FontStyle) {
    this._paragraphTextFontStyle = value
  }

  public set paragraphTextFontWeight(value: FontWeight) {
    this._paragraphTextFontWeight = value
  }

  public set paragraphTextFontFamily(value: string) {
    this._paragraphTextFontFamily = value
  }

  public set paragraphTextLineHeight(value: number) {
    this._paragraphTextLineHeight = value
  }

  public set paragraphTextLetterSpacing(value: number) {
    this._paragraphTextLetterSpacing = value
  }

  constructor() {
    super()
  }
}