import { BaseMDData } from "./BaseMDData"

export class HighlightData extends BaseMDData {
  _highlightTextFontColor: ResourceColor | undefined = undefined // 高亮文本颜色
  _highlightTextFontSize: number | string | Resource | undefined = undefined // 高亮文本尺寸
  _highlightTextFontStyle: FontStyle | undefined = undefined // 高亮文本字体样式
  _highlightTextFontWeight: number | FontWeight | undefined = undefined // 高亮文本字体粗细
  _highlightTextFontFamily: string | Resource | undefined = undefined // 高亮文本字体
  _highlightTextLineHeight: number | string | Resource | undefined = undefined // 高亮文本行高
  _highlightTextLetterSpacing: number | undefined = undefined // 高亮文本字符间距
  _highlightTextBackgroundColor: ResourceColor | undefined = undefined // 高亮文本背景颜色
  _highlightTextBackgroundRadiusTopLeft: Length = 0.0 // 高亮文本背景左上圆角
  _highlightTextBackgroundRadiusTopRight: Length = 0.0 // 高亮文本背景右上圆角
  _highlightTextBackgroundRadiusBottomLeft: Length = 0.0 // 高亮文本背景左下圆角
  _highlightTextBackgroundRadiusBottomRight: Length = 0.0 // 高亮文本背景右下圆角

  public set highlightTextFontColor(value: ResourceColor | undefined) {
    this._highlightTextFontColor = value
  }

  public set highlightTextFontSize(value: number | string | Resource | undefined) {
    this._highlightTextFontSize = value
  }

  public set highlightTextFontStyle(value: FontStyle | undefined) {
    this._highlightTextFontStyle = value
  }

  public set highlightTextFontWeight(value: number | FontWeight | undefined) {
    this._highlightTextFontWeight = value
  }

  public set highlightTextFontFamily(value: string | Resource | undefined) {
    this._highlightTextFontFamily = value
  }

  public set highlightTextLineHeight(value: number | string | Resource | undefined) {
    this._highlightTextLineHeight = value
  }

  public set highlightTextLetterSpacing(value: number | undefined) {
    this._highlightTextLetterSpacing = value
  }

  public set highlightTextBackgroundColor(value: ResourceColor | undefined) {
    this._highlightTextBackgroundColor = value
  }

  public set highlightTextBackgroundRadiusTopLeft(value: Length) {
    this._highlightTextBackgroundRadiusTopLeft = value
  }

  public set highlightTextBackgroundRadiusTopRight(value: Length) {
    this._highlightTextBackgroundRadiusTopRight = value
  }

  public set highlightTextBackgroundRadiusBottomLeft(value: Length) {
    this._highlightTextBackgroundRadiusBottomLeft = value
  }

  public set highlightTextBackgroundRadiusBottomRight(value: Length) {
    this._highlightTextBackgroundRadiusBottomRight = value
  }

  constructor() {
    super()
  }
}
