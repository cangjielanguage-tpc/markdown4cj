import { MarkdownTextDecorationStyle } from "@cangjie-tpc/markdown_hybrid"
import { BaseMDData } from "./BaseMDData"

export class StrikethroughData extends BaseMDData {
  _strikethroughTextFontColor: number | undefined = undefined // 删除线文本颜色
  _strikethroughTextFontSize: number = 16 // 删除线文本尺寸
  _strikethroughTextFontStyle: FontStyle = FontStyle.Normal // 删除线文本字体样式
  _strikethroughTextFontWeight: FontWeight = FontWeight.Normal // 删除线文本字体粗细
  _strikethroughTextFontFamily: string = 'HarmonyOS Sans' // 删除线文本字体
  _strikethroughTextLineHeight: number = 20 // 删除线文本行高
  _strikethroughTextLetterSpacing: number = 0 // 删除线文本字符间距
  _strikethroughTextDecorationColor: number | undefined = undefined // 删除线文本装饰线颜色
  _strikethroughTextDecorationStyle: MarkdownTextDecorationStyle = MarkdownTextDecorationStyle.SOLID // 删除线文本装饰线样式

  public set strikethroughTextFontColor(value: number | undefined) {
    this._strikethroughTextFontColor = value
  }

  public set strikethroughTextFontSize(value: number) {
    this._strikethroughTextFontSize = value
  }

  public set strikethroughTextFontStyle(value: FontStyle) {
    this._strikethroughTextFontStyle = value
  }

  public set strikethroughTextFontWeight(value: FontWeight) {
    this._strikethroughTextFontWeight = value
  }

  public set strikethroughTextFontFamily(value: string) {
    this._strikethroughTextFontFamily = value
  }

  public set strikethroughTextLineHeight(value: number) {
    this._strikethroughTextLineHeight = value
  }

  public set strikethroughTextLetterSpacing(value: number) {
    this._strikethroughTextLetterSpacing = value
  }

  public set strikethroughTextDecorationColor(value: number | undefined) {
    this._strikethroughTextDecorationColor = value
  }

  public set strikethroughTextDecorationStyle(value: MarkdownTextDecorationStyle) {
    this._strikethroughTextDecorationStyle = value
  }

  constructor() {
    super()
  }
}