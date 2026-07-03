import { BaseMDData } from "./BaseMDData"

export class SubData extends BaseMDData {
  _subTextFontColor: ResourceColor | undefined = undefined // 下标文本颜色
  _subTextFontSize: number | string | Resource = 8.0 // 下标文本尺寸
  _subTextFontStyle: FontStyle | undefined = undefined // 下标文本字体样式
  _subTextFontWeight: number | FontWeight | undefined = undefined // 下标文本字体粗细
  _subTextFontFamily: string | Resource | undefined = undefined // 下标文本字体
  _subTextLetterSpacing: number | undefined = undefined // 下标文本字符间距
  _subTextBaselineOffset: number = 0.0 // 下标文本基线的偏移量

  constructor() {
    super()
  }
}