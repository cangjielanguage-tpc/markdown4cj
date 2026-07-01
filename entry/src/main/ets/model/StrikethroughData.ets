import { BaseMDData } from "./BaseMDData"

export class StrikethroughData extends BaseMDData {
  _strikethroughTextFontColor: number | undefined = undefined // 删除线文本颜色
  _strikethroughTextFontSize: number | undefined = undefined // 删除线文本尺寸
  _strikethroughTextFontStyle: FontStyle | undefined = undefined // 删除线文本字体样式
  _strikethroughTextFontWeight: FontWeight | undefined = undefined // 删除线文本字体粗细
  _strikethroughTextFontFamily: string | undefined = undefined // 删除线文本字体
  _strikethroughTextLineHeight: number | undefined = undefined // 删除线文本行高
  _strikethroughTextLetterSpacing: number | undefined = undefined // 删除线文本字符间距
  _strikethroughTextDecorationColor: number | undefined = undefined // 删除线文本装饰线颜色
  _strikethroughTextDecorationStyle: TextDecorationStyle | undefined = undefined // 删除线文本装饰线样式

  public set strikethroughTextFontColor(value: number | undefined) {
    this._strikethroughTextFontColor = value
  }

  public set strikethroughTextFontSize(value: number | undefined) {
    this._strikethroughTextFontSize = value
  }

  public set strikethroughTextFontStyle(value: FontStyle | undefined) {
    this._strikethroughTextFontStyle = value
  }

  public set strikethroughTextFontWeight(value: FontWeight | undefined) {
    this._strikethroughTextFontWeight = value
  }

  public set strikethroughTextFontFamily(value: string | undefined) {
    this._strikethroughTextFontFamily = value
  }

  public set strikethroughTextLineHeight(value: number | undefined) {
    this._strikethroughTextLineHeight = value
  }

  public set strikethroughTextLetterSpacing(value: number | undefined) {
    this._strikethroughTextLetterSpacing = value
  }

  public set strikethroughTextDecorationColor(value: number | undefined) {
    this._strikethroughTextDecorationColor = value
  }

  public set strikethroughTextDecorationStyle(value: TextDecorationStyle | undefined) {
    this._strikethroughTextDecorationStyle = value
  }

  constructor() {
    super()
  }
}