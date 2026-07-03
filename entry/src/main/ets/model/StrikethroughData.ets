import { BaseMDData } from "./BaseMDData"

export class StrikethroughData extends BaseMDData {
  _strikethroughTextFontColor: ResourceColor | undefined = undefined // 删除线文本颜色
  _strikethroughTextFontSize: number | string | Resource | undefined = undefined // 删除线文本尺寸
  _strikethroughTextFontStyle: FontStyle | undefined = undefined // 删除线文本字体样式
  _strikethroughTextFontWeight: number | FontWeight | undefined = undefined // 删除线文本字体粗细
  _strikethroughTextFontFamily: string | Resource | undefined = undefined // 删除线文本字体
  _strikethroughTextLineHeight: number | string | Resource | undefined = undefined // 删除线文本行高
  _strikethroughTextLetterSpacing: number | undefined = undefined // 删除线文本字符间距
  _strikethroughTextDecorationColor: ResourceColor | undefined = undefined // 删除线文本装饰线颜色
  _strikethroughTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID // 删除线文本装饰线样式

  constructor() {
    super()
  }
}