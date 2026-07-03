import { BaseMDData } from "./BaseMDData"

export class HTMLData extends BaseMDData {
  _htmlUnderlineTextFontColor: ResourceColor | undefined = undefined // HTML下划线文本颜色
  _htmlUnderlineTextFontSize: number | string | Resource | undefined = undefined // HTML下划线文本尺寸
  _htmlUnderlineTextFontStyle: FontStyle | undefined = undefined // HTML下划线文本字体样式
  _htmlUnderlineTextFontWeight: number | FontWeight | undefined = undefined // HTML下划线文本字体粗细
  _htmlUnderlineTextFontFamily: string | Resource | undefined = undefined // HTML下划线文本字体
  _htmlUnderlineTextLineHeight: number | string | Resource | undefined = undefined // HTML下划线文本行高
  _htmlUnderlineTextLetterSpacing: number | undefined = undefined // HTML下划线文本字符间距
  _htmlUnderlineTextDecorationColor: ResourceColor | undefined = undefined // HTML下划线文本装饰线颜色
  _htmlUnderlineTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID // HTML下划线文本装饰线样式

  constructor() {
    super()
  }
}