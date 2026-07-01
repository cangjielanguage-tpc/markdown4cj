import { BaseMDData } from "./BaseMDData"

export class ItalicData extends BaseMDData {
  _italicTextFontColor: ResourceColor | undefined = undefined // 斜体文本颜色
  _italicTextFontSize: number | string | Resource | undefined = undefined // 斜体文本尺寸
  _italicTextFontWeight: number | FontWeight | undefined = undefined // 斜体文本字体粗细
  _italicTextFontFamily: string | Resource | undefined = undefined // 斜体文本字体
  _italicTextLineHeight: number | string | Resource | undefined = undefined // 斜体文本行高
  _italicTextLetterSpacing: number | undefined = undefined // 斜体文本字符间距

  public set italicTextFontColor(value: ResourceColor | undefined) {
    this._italicTextFontColor = value
  }

  public set italicTextFontSize(value: number | string | Resource | undefined) {
    this._italicTextFontSize = value
  }

  public set italicTextFontWeight(value: number | FontWeight | undefined) {
    this._italicTextFontWeight = value
  }

  public set italicTextFontFamily(value: string | Resource | undefined) {
    this._italicTextFontFamily = value
  }

  public set italicTextLineHeight(value: number | string | Resource | undefined) {
    this._italicTextLineHeight = value
  }

  public set italicTextLetterSpacing(value: number | undefined) {
    this._italicTextLetterSpacing = value
  }

  constructor() {
    super()
  }
}