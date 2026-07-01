import { BaseMDData } from "./BaseMDData"

export class HighlightData extends BaseMDData {
  _highlightTextFontColor: number | undefined = undefined // 高亮文本颜色
  _highlightTextFontSize: number | undefined = undefined // 高亮文本尺寸
  _highlightTextFontStyle: FontStyle | undefined = undefined // 高亮文本字体样式
  _highlightTextFontWeight: FontWeight = FontWeight.Bold // 高亮文本字体粗细
  _highlightTextFontFamily: string | undefined = undefined // 高亮文本字体
  _highlightTextLineHeight: number | undefined = undefined // 高亮文本行高
  _highlightTextLetterSpacing: number | undefined = undefined // 高亮文本字符间距
  _highlightTextBackgroundColor: number | undefined = undefined // 高亮文本背景颜色
  _highlightTextBackgroundRadiusTopLeft: number | undefined = undefined // 高亮文本背景左上圆角
  _highlightTextBackgroundRadiusTopRight: number | undefined = undefined // 高亮文本背景右上圆角
  _highlightTextBackgroundRadiusBottomLeft: number | undefined = undefined // 高亮文本背景左下圆角
  _highlightTextBackgroundRadiusBottomRight: number | undefined = undefined // 高亮文本背景右下圆角

  public set highlightTextFontColor(value: number | undefined) {
    this._highlightTextFontColor = value
  }

  public set highlightTextFontSize(value: number | undefined) {
    this._highlightTextFontSize = value
  }

  public set highlightTextFontStyle(value: FontStyle | undefined) {
    this._highlightTextFontStyle = value
  }

  public set highlightTextFontWeight(value: FontWeight) {
    this._highlightTextFontWeight = value
  }

  public set highlightTextFontFamily(value: string | undefined) {
    this._highlightTextFontFamily = value
  }

  public set highlightTextLineHeight(value: number | undefined) {
    this._highlightTextLineHeight = value
  }

  public set highlightTextLetterSpacing(value: number | undefined) {
    this._highlightTextLetterSpacing = value
  }

  public set highlightTextBackgroundColor(value: number | undefined) {
    this._highlightTextBackgroundColor = value
  }

  public set highlightTextBackgroundRadiusTopLeft(value: number | undefined) {
    this._highlightTextBackgroundRadiusTopLeft = value
  }

  public set highlightTextBackgroundRadiusTopRight(value: number | undefined) {
    this._highlightTextBackgroundRadiusTopRight = value
  }

  public set highlightTextBackgroundRadiusBottomLeft(value: number | undefined) {
    this._highlightTextBackgroundRadiusBottomLeft = value
  }

  public set highlightTextBackgroundRadiusBottomRight(value: number | undefined) {
    this._highlightTextBackgroundRadiusBottomRight = value
  }

  constructor() {
    super()
  }
}
