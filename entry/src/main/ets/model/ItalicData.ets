import { BaseMDData } from "./BaseMDData"

export class ItalicData extends BaseMDData {
  _italicTextFontColor: ResourceColor | undefined = undefined // 斜体文本颜色
  _italicTextFontSize: number | string | Resource | undefined = undefined // 斜体文本尺寸
  _italicTextFontWeight: number | FontWeight | undefined = undefined // 斜体文本字体粗细
  _italicTextFontFamily: string | Resource | undefined = undefined // 斜体文本字体
  _italicTextLineHeight: number | string | Resource | undefined = undefined // 斜体文本行高
  _italicTextLetterSpacing: number | undefined = undefined // 斜体文本字符间距

  constructor() {
    super()
  }
}