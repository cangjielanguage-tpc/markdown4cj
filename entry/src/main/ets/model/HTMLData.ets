import { MarkdownTextDecorationStyle } from "@cangjie-tpc/markdown_hybrid"
import { BaseMDData } from "./BaseMDData"

export class HTMLData extends BaseMDData {
  _htmlUnderlineTextFontColor: number | undefined = undefined // HTML下划线文本颜色
  _htmlUnderlineTextFontSize: number = 14 // HTML下划线文本尺寸
  _htmlUnderlineTextFontStyle: FontStyle = FontStyle.Normal // HTML下划线文本字体样式
  _htmlUnderlineTextFontWeight: FontWeight = FontWeight.Normal // HTML下划线文本字体粗细
  _htmlUnderlineTextFontFamily: string = 'HarmonyOS Sans' // HTML下划线文本字体
  _htmlUnderlineTextLineHeight: number = 22 // HTML下划线文本行高
  _htmlUnderlineTextLetterSpacing: number = 0 // HTML下划线文本字符间距
  _htmlUnderlineTextDecorationColor: number | undefined = undefined // HTML下划线文本装饰线颜色
  _htmlUnderlineTextDecorationStyle: MarkdownTextDecorationStyle = MarkdownTextDecorationStyle.SOLID // HTML下划线文本装饰线样式

  public set htmlUnderlineTextFontColor(value: number | undefined) {
    this._htmlUnderlineTextFontColor = value
  }

  public set htmlUnderlineTextFontSize(value: number) {
    this._htmlUnderlineTextFontSize = value
  }

  public set htmlUnderlineTextFontStyle(value: FontStyle) {
    this._htmlUnderlineTextFontStyle = value
  }

  public set htmlUnderlineTextFontWeight(value: FontWeight) {
    this._htmlUnderlineTextFontWeight = value
  }

  public set htmlUnderlineTextFontFamily(value: string) {
    this._htmlUnderlineTextFontFamily = value
  }

  public set htmlUnderlineTextLineHeight(value: number) {
    this._htmlUnderlineTextLineHeight = value
  }

  public set htmlUnderlineTextLetterSpacing(value: number) {
    this._htmlUnderlineTextLetterSpacing = value
  }

  public set htmlUnderlineTextDecorationColor(value: number | undefined) {
    this._htmlUnderlineTextDecorationColor = value
  }

  public set htmlUnderlineTextDecorationStyle(value: MarkdownTextDecorationStyle) {
    this._htmlUnderlineTextDecorationStyle = value
  }

  constructor() {
    super()
  }
}