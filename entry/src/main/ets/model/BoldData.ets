import { BaseMDData } from "./BaseMDData"

export class BoldData extends BaseMDData {
  _boldTextFontColor: ResourceColor | undefined = undefined // 字体颜色
  _boldTextFontSize: number | string | Resource | undefined = undefined // 字体大小
  _boldTextFontStyle: FontStyle | undefined = undefined // 字体样式
  _boldTextFontWeight: number | FontWeight = FontWeight.Bold // 字体粗细
  _boldTextFontFamily: string | Resource | undefined = undefined // 字体族
  _boldTextLineHeight: number | string | Resource | undefined = undefined // 行高
  _boldTextLetterSpacing: number | undefined = undefined // 字间距

  constructor() {
    super()
  }
}