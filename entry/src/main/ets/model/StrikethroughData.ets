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

  public set strikethroughTextFontColor(value: ResourceColor | undefined) {
    this._strikethroughTextFontColor = value
  }

  public set strikethroughTextFontSize(value: number | string | Resource | undefined) {
    this._strikethroughTextFontSize = value
  }

  public set strikethroughTextFontStyle(value: FontStyle | undefined) {
    this._strikethroughTextFontStyle = value
  }

  public set strikethroughTextFontWeight(value: number | FontWeight | undefined) {
    this._strikethroughTextFontWeight = value
  }

  public set strikethroughTextFontFamily(value: string | Resource | undefined) {
    this._strikethroughTextFontFamily = value
  }

  public set strikethroughTextLineHeight(value: number | string | Resource | undefined) {
    this._strikethroughTextLineHeight = value
  }

  public set strikethroughTextLetterSpacing(value: number | undefined) {
    this._strikethroughTextLetterSpacing = value
  }

  public set strikethroughTextDecorationColor(value: ResourceColor | undefined) {
    this._strikethroughTextDecorationColor = value
  }

  public set strikethroughTextDecorationStyle(value: TextDecorationStyle) {
    this._strikethroughTextDecorationStyle = value
  }

  constructor() {
    super()
  }
}