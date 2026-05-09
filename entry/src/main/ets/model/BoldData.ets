import { BaseMDData } from "./BaseMDData"

export class BoldData extends BaseMDData {
  _boldTextFontColor: number | undefined = undefined // 加粗文本颜色
  _boldTextFontSize: number = 16 // 加粗文本尺寸
  _boldTextFontStyle: FontStyle = FontStyle.Normal // 加粗文本字体样式
  _boldTextFontWeight: FontWeight = FontWeight.Bold // 加粗文本字体粗细
  _boldTextFontFamily: string = 'HarmonyOS Sans' // 加粗文本字体
  _boldTextLineHeight: number = 20 // 加粗文本行高
  _boldTextLetterSpacing: number = 0 // 加粗文本字符间距

  public set boldTextFontColor(value: number | undefined) {
    this._boldTextFontColor = value
  }

  public set boldTextFontSize(value: number) {
    this._boldTextFontSize = value
  }

  public set boldTextFontStyle(value: FontStyle) {
    this._boldTextFontStyle = value
  }

  public set boldTextFontWeight(value: FontWeight) {
    this._boldTextFontWeight = value
  }

  public set boldTextFontFamily(value: string) {
    this._boldTextFontFamily = value
  }

  public set boldTextLineHeight(value: number) {
    this._boldTextLineHeight = value
  }

  public set boldTextLetterSpacing(value: number) {
    this._boldTextLetterSpacing = value
  }

  constructor() {
    super()
  }
}