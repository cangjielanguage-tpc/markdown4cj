import { BaseMDData } from "./BaseMDData"

export class SubData extends BaseMDData {
  _subTextFontColor: number | undefined = undefined // 下标文本颜色
  _subTextFontSize: number = 8 // 下标文本尺寸
  _subTextFontStyle: FontStyle = FontStyle.Normal // 下标文本字体样式
  _subTextFontWeight: FontWeight = FontWeight.Normal // 下标文本字体粗细
  _subTextFontFamily: string = 'HarmonyOS Sans' // 下标文本字体
  _subTextLetterSpacing: number = 0 // 下标文本字符间距
  _subTextBaselineOffset: number = 0 // 下标文本基线的偏移量

  public set subTextFontColor(value: number | undefined) {
    this._subTextFontColor = value
  }

  public set subTextFontSize(value: number) {
    this._subTextFontSize = value
  }

  public set subTextFontStyle(value: FontStyle) {
    this._subTextFontStyle = value
  }

  public set subTextFontWeight(value: FontWeight) {
    this._subTextFontWeight = value
  }

  public set subTextFontFamily(value: string) {
    this._subTextFontFamily = value
  }

  public set subTextLetterSpacing(value: number) {
    this._subTextLetterSpacing = value
  }

  public set subTextBaselineOffset(value: number) {
    this._subTextBaselineOffset = value
  }

  constructor() {
    super()
  }
}