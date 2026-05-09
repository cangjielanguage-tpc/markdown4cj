import { BaseMDData } from "./BaseMDData"

export class CodeLineData extends BaseMDData {
  _inlineCodeTextFontColor: number | undefined = undefined // 内联代码文本颜色
  _inlineCodeTextFontSize: number = 13 // 内联代码文本尺寸
  _inlineCodeTextFontStyle: FontStyle = FontStyle.Normal // 内联代码文本字体样式
  _inlineCodeTextFontWeight: FontWeight = FontWeight.Normal // 内联代码文本字体粗细
  _inlineCodeTextFontFamily: string = 'HarmonyOS Sans' // 内联代码文本字体
  _inlineCodeTextLineHeight: number = 20 // 内联代码文本行高
  _inlineCodeTextLetterSpacing: number = 0 // 内联代码文本字符间距
  _inlineCodeTextBackgroundColor: number | undefined = undefined // 内联代码文本背景颜色
  _inlineCodeTextBackgroundRadiusTopLeft: number = 4 // 内联代码文本背景左上圆角
  _inlineCodeTextBackgroundRadiusTopRight: number = 4 // 内联代码文本背景右上圆角
  _inlineCodeTextBackgroundRadiusBottomLeft: number = 4 // 内联代码文本背景左下圆角
  _inlineCodeTextBackgroundRadiusBottomRight: number = 4 // 内联代码文本背景右下圆角

  public set inlineCodeTextFontColor(value: number | undefined) {
    this._inlineCodeTextFontColor = value
  }

  public set inlineCodeTextFontSize(value: number) {
    this._inlineCodeTextFontSize = value
  }

  public set inlineCodeTextFontStyle(value: FontStyle) {
    this._inlineCodeTextFontStyle = value
  }

  public set inlineCodeTextFontWeight(value: FontWeight) {
    this._inlineCodeTextFontWeight = value
  }

  public set inlineCodeTextFontFamily(value: string) {
    this._inlineCodeTextFontFamily = value
  }

  public set inlineCodeTextLineHeight(value: number) {
    this._inlineCodeTextLineHeight = value
  }

  public set inlineCodeTextLetterSpacing(value: number) {
    this._inlineCodeTextLetterSpacing = value
  }

  public set inlineCodeTextBackgroundColor(value: number | undefined) {
    this._inlineCodeTextBackgroundColor = value
  }

  public set inlineCodeTextBackgroundRadiusTopLeft(value: number) {
    this._inlineCodeTextBackgroundRadiusTopLeft = value
  }

  public set inlineCodeTextBackgroundRadiusTopRight(value: number) {
    this._inlineCodeTextBackgroundRadiusTopRight = value
  }

  public set inlineCodeTextBackgroundRadiusBottomLeft(value: number) {
    this._inlineCodeTextBackgroundRadiusBottomLeft = value
  }

  public set inlineCodeTextBackgroundRadiusBottomRight(value: number) {
    this._inlineCodeTextBackgroundRadiusBottomRight = value
  }

  constructor() {
    super()
  }
}