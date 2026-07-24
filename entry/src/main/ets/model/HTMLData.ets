import { BaseMDData } from "./BaseMDData"

export class HTMLData extends BaseMDData {
  _htmlUnderlineTextFontColor: number | undefined = undefined // HTML下划线文本颜色
  _htmlUnderlineTextFontSize: number | undefined = undefined // HTML下划线文本尺寸
  _htmlUnderlineTextFontStyle: FontStyle | undefined = undefined // HTML下划线文本字体样式
  _htmlUnderlineTextFontWeight: FontWeight | undefined = undefined // HTML下划线文本字体粗细
  _htmlUnderlineTextFontFamily: string | undefined = undefined // HTML下划线文本字体
  _htmlUnderlineTextLineHeight: number | undefined = undefined // HTML下划线文本行高
  _htmlUnderlineTextLetterSpacing: number | undefined = undefined // HTML下划线文本字符间距
  _htmlUnderlineTextDecorationColor: number | undefined = undefined // HTML下划线文本装饰线颜色
  _htmlUnderlineTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID // HTML下划线文本装饰线样式

  public set htmlUnderlineTextFontColor(value: number | undefined) {
    this._htmlUnderlineTextFontColor = value
  }

  public set htmlUnderlineTextFontSize(value: number | undefined) {
    this._htmlUnderlineTextFontSize = value
  }

  public set htmlUnderlineTextFontStyle(value: FontStyle | undefined) {
    this._htmlUnderlineTextFontStyle = value
  }

  public set htmlUnderlineTextFontWeight(value: FontWeight | undefined) {
    this._htmlUnderlineTextFontWeight = value
  }

  public set htmlUnderlineTextFontFamily(value: string | undefined) {
    this._htmlUnderlineTextFontFamily = value
  }

  public set htmlUnderlineTextLineHeight(value: number | undefined) {
    this._htmlUnderlineTextLineHeight = value
  }

  public set htmlUnderlineTextLetterSpacing(value: number | undefined) {
    this._htmlUnderlineTextLetterSpacing = value
  }

  public set htmlUnderlineTextDecorationColor(value: number | undefined) {
    this._htmlUnderlineTextDecorationColor = value
  }

  public set htmlUnderlineTextDecorationStyle(value: TextDecorationStyle) {
    this._htmlUnderlineTextDecorationStyle = value
  }

  constructor() {
    super()
  }
}