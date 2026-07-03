import { BaseMDData } from "./BaseMDData"

export class FootnoteData extends BaseMDData {
  // 脚注定义样式
  _footnoteDefBackgroundColor: ResourceColor | undefined = undefined // 脚注定义背景颜色
  _footnoteDefMarginTop: Length = 0.0 // 脚注定义上外边距
  _footnoteDefMarginRight: Length = 0.0 // 脚注定义右外边距
  _footnoteDefMarginBottom: Length = 0.0 // 脚注定义下外边距
  _footnoteDefMarginLeft: Length = 0.0 // 脚注定义左外边距
  _footnoteDefPaddingTop: Length = 0.0 // 脚注定义上内边距
  _footnoteDefPaddingRight: Length = 0.0 // 脚注定义右内边距
  _footnoteDefPaddingBottom: Length = 0.0 // 脚注定义下内边距
  _footnoteDefPaddingLeft: Length = 0.0 // 脚注定义左内边距

  // 脚注引用样式
  _footnoteRefTextFontColor: ResourceColor | undefined = undefined // 脚注引用文本颜色
  _footnoteRefTextFontSize: number | string | Resource | undefined = undefined // 脚注引用文本尺寸
  _footnoteRefTextFontStyle: FontStyle | undefined = undefined // 脚注引用文本字体样式
  _footnoteRefTextFontWeight: number | FontWeight | undefined = undefined // 脚注引用文本字体粗细
  _footnoteRefTextFontFamily: string | Resource | undefined = undefined // 脚注引用文本字体
  _footnoteRefTextLineHeight: number | string | Resource | undefined = undefined // 脚注引用文本行高
  _footnoteRefTextLetterSpacing: number | undefined = undefined // 脚注引用文本字符间距
  _footnoteRefTextDecorationType: TextDecorationType = TextDecorationType.Underline // 脚注引用文本装饰线类型
  _footnoteRefTextDecorationColor: ResourceColor | undefined = undefined // 脚注引用文本装饰线颜色
  _footnoteRefTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID // 脚注引用文本装饰线样式
  _footnoteRefTextBackgroundColor: ResourceColor | undefined = undefined // 脚注引用文本背景颜色
  _footnoteRefTextBackgroundRadiusTopLeft: Length = 0.0 // 脚注引用文本背景左上圆角
  _footnoteRefTextBackgroundRadiusTopRight: Length = 0.0 // 脚注引用文本背景右上圆角
  _footnoteRefTextBackgroundRadiusBottomLeft: Length = 0.0 // 脚注引用文本背景左下圆角
  _footnoteRefTextBackgroundRadiusBottomRight: Length = 0.0 // 脚注引用文本背景右下圆角

  constructor() {
    super()
  }
}