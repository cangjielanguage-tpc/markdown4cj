import { BaseMDData } from "./BaseMDData"

export class DescListData extends BaseMDData {
  _definitionListBackgroundColor: ResourceColor | undefined = undefined // 定义列表背景颜色
  _definitionListMarginTop: Length = 0.0 // 定义列表上外边距
  _definitionListMarginRight: Length = 0.0 // 定义列表右外边距
  _definitionListMarginBottom: Length = 0.0 // 定义列表下外边距
  _definitionListMarginLeft: Length = 0.0 // 定义列表左外边距
  _definitionListPaddingTop: Length = 0.0 // 定义列表上内边距
  _definitionListPaddingRight: Length = 0.0 // 定义列表右内边距
  _definitionListPaddingBottom: Length = 0.0 // 定义列表下内边距
  _definitionListPaddingLeft: Length = 0.0 // 定义列表左内边距
  _definitionListTermToDescriptionSpacing: number = 8.0 // 定义列表术语和定义行之间间距
  _definitionListTermTextFontWeight: number | FontWeight = FontWeight.Bold // 定义列表术语文本字体粗细
  _definitionListTermTextFontStyle: FontStyle = FontStyle.Italic // 定义列表术语文本字体样式
  _definitionListDescriptionItemSpacing: number = 8.0 // 定义列表定义行之间间距
  _definitionListDescriptionIndent: number = 8.0 // 定义列表定义行左缩进距离

  constructor() {
    super()
  }
}