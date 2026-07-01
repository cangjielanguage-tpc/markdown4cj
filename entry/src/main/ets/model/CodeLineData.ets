import { BaseMDData } from "./BaseMDData"

export class CodeLineData extends BaseMDData {
  _inlineCodeTextFontColor: ResourceColor | undefined = undefined // 内联代码文本颜色
  _inlineCodeTextFontSize: number | string | Resource | undefined = undefined // 内联代码文本尺寸
  _inlineCodeTextFontStyle: FontStyle | undefined = undefined // 内联代码文本字体样式
  _inlineCodeTextFontWeight: number | FontWeight | undefined = undefined // 内联代码文本字体粗细
  _inlineCodeTextFontFamily: string | Resource | undefined = undefined // 内联代码文本字体
  _inlineCodeTextLineHeight: number | string | Resource | undefined = undefined // 内联代码文本行高
  _inlineCodeTextLetterSpacing: number | undefined = undefined // 内联代码文本字符间距
  _inlineCodeTextBackgroundColor: ResourceColor | undefined = undefined // 内联代码文本背景颜色
  _inlineCodeTextBackgroundRadiusTopLeft: Length = 0.0 // 内联代码文本背景左上圆角
  _inlineCodeTextBackgroundRadiusTopRight: Length = 0.0 // 内联代码文本背景右上圆角
  _inlineCodeTextBackgroundRadiusBottomLeft: Length = 0.0 // 内联代码文本背景左下圆角
  _inlineCodeTextBackgroundRadiusBottomRight: Length = 0.0 // 内联代码文本背景右下圆角

  public set inlineCodeTextFontColor(value: ResourceColor | undefined) {
    this._inlineCodeTextFontColor = value
  }

  public set inlineCodeTextFontSize(value: number | string | Resource | undefined) {
    this._inlineCodeTextFontSize = value
  }

  public set inlineCodeTextFontStyle(value: FontStyle | undefined) {
    this._inlineCodeTextFontStyle = value
  }

  public set inlineCodeTextFontWeight(value: number | FontWeight | undefined) {
    this._inlineCodeTextFontWeight = value
  }

  public set inlineCodeTextFontFamily(value: string | Resource | undefined) {
    this._inlineCodeTextFontFamily = value
  }

  public set inlineCodeTextLineHeight(value: number | string | Resource | undefined) {
    this._inlineCodeTextLineHeight = value
  }

  public set inlineCodeTextLetterSpacing(value: number | undefined) {
    this._inlineCodeTextLetterSpacing = value
  }

  public set inlineCodeTextBackgroundColor(value: ResourceColor | undefined) {
    this._inlineCodeTextBackgroundColor = value
  }

  public set inlineCodeTextBackgroundRadiusTopLeft(value: Length) {
    this._inlineCodeTextBackgroundRadiusTopLeft = value
  }

  public set inlineCodeTextBackgroundRadiusTopRight(value: Length) {
    this._inlineCodeTextBackgroundRadiusTopRight = value
  }

  public set inlineCodeTextBackgroundRadiusBottomLeft(value: Length) {
    this._inlineCodeTextBackgroundRadiusBottomLeft = value
  }

  public set inlineCodeTextBackgroundRadiusBottomRight(value: Length) {
    this._inlineCodeTextBackgroundRadiusBottomRight = value
  }

  constructor() {
    super()
  }
}