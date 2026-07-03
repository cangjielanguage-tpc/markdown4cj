import { BaseMDData } from "./BaseMDData"

export class ParagraphData extends BaseMDData {
  _paragraphBackgroundColor: ResourceColor | undefined = undefined // 段落背景颜色
  _paragraphMarginTop: Length = 0.0 // 段落上外边距
  _paragraphMarginRight: Length = 0.0 // 段落右外边距
  _paragraphMarginBottom: Length = 0.0 // 段落下外边距
  _paragraphMarginLeft: Length = 0.0 // 段落左外边距
  _paragraphPaddingTop: Length = 0.0 // 段落上内边距
  _paragraphPaddingRight: Length = 0.0 // 段落右内边距
  _paragraphPaddingBottom: Length = 0.0 // 段落下内边距
  _paragraphPaddingLeft: Length = 0.0 // 段落左内边距
  _paragraphTextFontColor: ResourceColor | undefined = undefined // 段落文本颜色
  _paragraphTextFontSize: number | string | Resource = 14.0 // 段落文本尺寸
  _paragraphTextFontStyle: FontStyle = FontStyle.Normal // 段落文本字体样式
  _paragraphTextFontWeight: number | FontWeight = FontWeight.Normal // 段落文本字体粗细
  _paragraphTextFontFamily: string | Resource = 'HarmonyOS Sans' // 段落文本字体
  _paragraphTextLineHeight: number | string | Resource = 22.0 // 段落文本行高
  _paragraphTextLetterSpacing: number = 0.0 // 段落文本字符间距

  constructor() {
    super()
  }
}