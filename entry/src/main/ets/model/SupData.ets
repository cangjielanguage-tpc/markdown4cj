import { BaseMDData } from "./BaseMDData"

export class SupData extends BaseMDData {
  _supTextFontColor: number | undefined = undefined // 上标文本颜色
  _supTextFontSize: number = 8 // 上标文本尺寸
  _supTextFontStyle: FontStyle = FontStyle.Normal // 上标文本字体样式
  _supTextFontWeight: FontWeight = FontWeight.Normal // 上标文本字体粗细
  _supTextFontFamily: string = 'HarmonyOS Sans' // 上标文本字体
  _supTextLetterSpacing: number = 0 // 上标文本字符间距
  _supTextBaselineOffset: number = 6 // 上标文本基线的偏移量

  public set supTextFontColor(value: number | undefined) {
    this._supTextFontColor = value
  }

  public set supTextFontSize(value: number) {
    this._supTextFontSize = value
  }

  public set supTextFontStyle(value: FontStyle) {
    this._supTextFontStyle = value
  }

  public set supTextFontWeight(value: FontWeight) {
    this._supTextFontWeight = value
  }

  public set supTextFontFamily(value: string) {
    this._supTextFontFamily = value
  }

  public set supTextLetterSpacing(value: number) {
    this._supTextLetterSpacing = value
  }

  public set supTextBaselineOffset(value: number) {
    this._supTextBaselineOffset = value
  }

  constructor() {
    super()
  }
}