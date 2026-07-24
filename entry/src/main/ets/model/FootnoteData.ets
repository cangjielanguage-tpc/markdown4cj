import { BaseMDData } from "./BaseMDData"

export class FootnoteData extends BaseMDData {
  // 脚注定义样式
  _footnoteDefBackgroundColor: number | undefined = undefined // 脚注定义背景颜色
  _footnoteDefMarginTop: number = 8 // 脚注定义上外边距
  _footnoteDefMarginRight: number = 0 // 脚注定义右外边距
  _footnoteDefMarginBottom: number = 8 // 脚注定义下外边距
  _footnoteDefMarginLeft: number = 0 // 脚注定义左外边距
  _footnoteDefPaddingTop: number = 0 // 脚注定义上内边距
  _footnoteDefPaddingRight: number = 0 // 脚注定义右内边距
  _footnoteDefPaddingBottom: number = 0 // 脚注定义下内边距
  _footnoteDefPaddingLeft: number = 0 // 脚注定义左内边距

  // 脚注引用样式
  _footnoteRefTextFontColor: number | undefined = undefined // 脚注引用文本颜色
  _footnoteRefTextFontSize: number = 12 // 脚注引用文本尺寸
  _footnoteRefTextFontStyle: FontStyle = FontStyle.Normal // 脚注引用文本字体样式
  _footnoteRefTextFontWeight: FontWeight = FontWeight.Normal // 脚注引用文本字体粗细
  _footnoteRefTextFontFamily: string = 'HarmonyOS Sans' // 脚注引用文本字体
  _footnoteRefTextLineHeight: number = 18 // 脚注引用文本行高
  _footnoteRefTextLetterSpacing: number = 0 // 脚注引用文本字符间距
  _footnoteRefTextDecorationType: TextDecorationType = TextDecorationType.None // 脚注引用文本装饰线类型
  _footnoteRefTextDecorationColor: number | undefined = undefined // 脚注引用文本装饰线颜色
  _footnoteRefTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID // 脚注引用文本装饰线样式
  _footnoteRefTextBackgroundColor: number | undefined = undefined // 脚注引用文本背景颜色
  _footnoteRefTextBackgroundRadiusTopLeft: number = 0 // 脚注引用文本背景左上圆角
  _footnoteRefTextBackgroundRadiusTopRight: number = 0 // 脚注引用文本背景右上圆角
  _footnoteRefTextBackgroundRadiusBottomLeft: number = 0 // 脚注引用文本背景左下圆角
  _footnoteRefTextBackgroundRadiusBottomRight: number = 0 // 脚注引用文本背景右下圆角

  // Setter方法 - 脚注定义
  public set footnoteDefBackgroundColor(value: number | undefined) {
    this._footnoteDefBackgroundColor = value
  }

  public set footnoteDefMarginTop(value: number) {
    this._footnoteDefMarginTop = value
  }

  public set footnoteDefMarginRight(value: number) {
    this._footnoteDefMarginRight = value
  }

  public set footnoteDefMarginBottom(value: number) {
    this._footnoteDefMarginBottom = value
  }

  public set footnoteDefMarginLeft(value: number) {
    this._footnoteDefMarginLeft = value
  }

  public set footnoteDefPaddingTop(value: number) {
    this._footnoteDefPaddingTop = value
  }

  public set footnoteDefPaddingRight(value: number) {
    this._footnoteDefPaddingRight = value
  }

  public set footnoteDefPaddingBottom(value: number) {
    this._footnoteDefPaddingBottom = value
  }

  public set footnoteDefPaddingLeft(value: number) {
    this._footnoteDefPaddingLeft = value
  }

  // Setter方法 - 脚注引用
  public set footnoteRefTextFontColor(value: number | undefined) {
    this._footnoteRefTextFontColor = value
  }

  public set footnoteRefTextFontSize(value: number) {
    this._footnoteRefTextFontSize = value
  }

  public set footnoteRefTextFontStyle(value: FontStyle) {
    this._footnoteRefTextFontStyle = value
  }

  public set footnoteRefTextFontWeight(value: FontWeight) {
    this._footnoteRefTextFontWeight = value
  }

  public set footnoteRefTextFontFamily(value: string) {
    this._footnoteRefTextFontFamily = value
  }

  public set footnoteRefTextLineHeight(value: number) {
    this._footnoteRefTextLineHeight = value
  }

  public set footnoteRefTextLetterSpacing(value: number) {
    this._footnoteRefTextLetterSpacing = value
  }

  public set footnoteRefTextDecorationType(value: TextDecorationType) {
    this._footnoteRefTextDecorationType = value
  }

  public set footnoteRefTextDecorationColor(value: number | undefined) {
    this._footnoteRefTextDecorationColor = value
  }

  public set footnoteRefTextDecorationStyle(value: TextDecorationStyle) {
    this._footnoteRefTextDecorationStyle = value
  }

  public set footnoteRefTextBackgroundColor(value: number | undefined) {
    this._footnoteRefTextBackgroundColor = value
  }

  public set footnoteRefTextBackgroundRadiusTopLeft(value: number) {
    this._footnoteRefTextBackgroundRadiusTopLeft = value
  }

  public set footnoteRefTextBackgroundRadiusTopRight(value: number) {
    this._footnoteRefTextBackgroundRadiusTopRight = value
  }

  public set footnoteRefTextBackgroundRadiusBottomLeft(value: number) {
    this._footnoteRefTextBackgroundRadiusBottomLeft = value
  }

  public set footnoteRefTextBackgroundRadiusBottomRight(value: number) {
    this._footnoteRefTextBackgroundRadiusBottomRight = value
  }

  constructor() {
    super()
  }
}