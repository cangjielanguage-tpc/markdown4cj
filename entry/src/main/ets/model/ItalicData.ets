import { BaseMDData } from "./BaseMDData"

export class ItalicData extends BaseMDData {
  _italicTextFontColor: number | undefined = undefined // 斜体文本颜色
  _italicTextFontSize: number | undefined = undefined // 斜体文本尺寸
  _italicTextFontWeight: FontWeight | undefined = undefined // 斜体文本字体粗细
  _italicTextFontFamily: string | undefined = undefined // 斜体文本字体
  _italicTextLineHeight: number | undefined = undefined // 斜体文本行高
  _italicTextLetterSpacing: number | undefined = undefined // 斜体文本字符间距

  public set italicTextFontColor(value: number | undefined) {
    this._italicTextFontColor = value
  }

  public set italicTextFontSize(value: number | undefined) {
    this._italicTextFontSize = value
  }

  public set italicTextFontWeight(value: FontWeight| undefined) {
    this._italicTextFontWeight = value
  }

  public set italicTextFontFamily(value: string| undefined) {
    this._italicTextFontFamily = value
  }

  public set italicTextLineHeight(value: number | undefined) {
    this._italicTextLineHeight = value
  }

  public set italicTextLetterSpacing(value: number | undefined) {
    this._italicTextLetterSpacing = value
  }

  constructor() {
    super()
  }
}