import { BaseMDData } from "./BaseMDData"

export class ItalicData extends BaseMDData {
  _italicTextFontColor: number | undefined = undefined // 斜体文本颜色
  _italicTextFontSize: number = 16 // 斜体文本尺寸
  _italicTextFontWeight: FontWeight = FontWeight.Normal // 斜体文本字体粗细
  _italicTextFontFamily: string = 'HarmonyOS Sans' // 斜体文本字体
  _italicTextLineHeight: number = 20 // 斜体文本行高
  _italicTextLetterSpacing: number = 0 // 斜体文本字符间距

  public set italicTextFontColor(value: number | undefined) {
    this._italicTextFontColor = value
  }

  public set italicTextFontSize(value: number) {
    this._italicTextFontSize = value
  }

  public set italicTextFontWeight(value: FontWeight) {
    this._italicTextFontWeight = value
  }

  public set italicTextFontFamily(value: string) {
    this._italicTextFontFamily = value
  }

  public set italicTextLineHeight(value: number) {
    this._italicTextLineHeight = value
  }

  public set italicTextLetterSpacing(value: number) {
    this._italicTextLetterSpacing = value
  }

  constructor() {
    super()
  }
}