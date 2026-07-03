import { BaseMDData } from "./BaseMDData"

export class HighlightData extends BaseMDData {
  _highlightTextFontColor: ResourceColor | undefined = undefined // 高亮文本颜色
  _highlightTextFontSize: number | string | Resource | undefined = undefined // 高亮文本尺寸
  _highlightTextFontStyle: FontStyle | undefined = undefined // 高亮文本字体样式
  _highlightTextFontWeight: number | FontWeight | undefined = undefined // 高亮文本字体粗细
  _highlightTextFontFamily: string | Resource | undefined = undefined // 高亮文本字体
  _highlightTextLineHeight: number | string | Resource | undefined = undefined // 高亮文本行高
  _highlightTextLetterSpacing: number | undefined = undefined // 高亮文本字符间距
  _highlightTextBackgroundColor: ResourceColor | undefined = undefined // 高亮文本背景颜色
  _highlightTextBackgroundRadiusTopLeft: Length = 0.0 // 高亮文本背景左上圆角
  _highlightTextBackgroundRadiusTopRight: Length = 0.0 // 高亮文本背景右上圆角
  _highlightTextBackgroundRadiusBottomLeft: Length = 0.0 // 高亮文本背景左下圆角
  _highlightTextBackgroundRadiusBottomRight: Length = 0.0 // 高亮文本背景右下圆角

  constructor() {
    super()
  }
}
