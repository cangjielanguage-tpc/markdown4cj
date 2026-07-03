import { BaseMDData } from "./BaseMDData"

export class SupData extends BaseMDData {
  _supTextFontColor: ResourceColor | undefined = undefined // 上标文本颜色
  _supTextFontSize: number | string | Resource = 8.0 // 上标文本尺寸
  _supTextFontStyle: FontStyle | undefined = undefined // 上标文本字体样式
  _supTextFontWeight: number | FontWeight | undefined = undefined // 上标文本字体粗细
  _supTextFontFamily: string | Resource | undefined = undefined // 上标文本字体
  _supTextLetterSpacing: number | undefined = undefined // 上标文本字符间距
  _supTextBaselineOffset: number = 6.0 // 上标文本基线的偏移量

  constructor() {
    super()
  }
}