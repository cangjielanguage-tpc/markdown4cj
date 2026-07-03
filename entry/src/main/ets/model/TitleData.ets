import { BaseMDData } from "./BaseMDData"

export class TitleData extends BaseMDData {
  // 一级标题
  _heading1BackgroundColor: ResourceColor | undefined = undefined // 一级标题背景颜色
  _heading1MarginTop: Length = 0.0 // 一级标题上外边距
  _heading1MarginRight: Length = 0.0 // 一级标题右外边距
  _heading1MarginBottom: Length = 0.0 // 一级标题下外边距
  _heading1MarginLeft: Length = 0.0 // 一级标题左外边距
  _heading1PaddingTop: Length = 0.0 // 一级标题上内边距
  _heading1PaddingRight: Length = 0.0 // 一级标题右内边距
  _heading1PaddingBottom: Length = 0.0 // 一级标题下内边距
  _heading1PaddingLeft: Length = 0.0 // 一级标题左内边距
  _heading1TextFontColor: ResourceColor | undefined = undefined // 一级标题文本颜色
  _heading1TextFontSize: number | string | Resource = 20.0 // 一级标题文本尺寸
  _heading1TextFontStyle: FontStyle = FontStyle.Normal // 一级标题文本字体样式
  _heading1TextFontWeight: number | FontWeight = FontWeight.Bold // 一级标题文本字体粗细
  _heading1TextFontFamily: string | Resource = 'HarmonyOS Sans' // 一级标题文本字体
  _heading1TextLineHeight: number | string | Resource = 22.0 // 一级标题文本行高
  _heading1TextLetterSpacing: number = 0.0 // 一级标题文本字符间距
  _heading1UnderlineHeight: number = 0.5 // 一级标题下划线高度
  _heading1UnderlineColor: ResourceColor | undefined = undefined // 一级标题下划线颜色
  _heading1UnderlineSpacing: number = 0.0 // 一级标题距离标题文本间距

  // 二级标题
  _heading2BackgroundColor: ResourceColor | undefined = undefined // 二级标题背景颜色
  _heading2MarginTop: Length = 0.0 // 二级标题上外边距
  _heading2MarginRight: Length = 0.0 // 二级标题右外边距
  _heading2MarginBottom: Length = 0.0 // 二级标题下外边距
  _heading2MarginLeft: Length = 0.0 // 二级标题左外边距
  _heading2PaddingTop: Length = 0.0 // 二级标题上内边距
  _heading2PaddingRight: Length = 0.0 // 二级标题右内边距
  _heading2PaddingBottom: Length = 0.0 // 二级标题下内边距
  _heading2PaddingLeft: Length = 0.0 // 二级标题左内边距
  _heading2TextFontColor: ResourceColor | undefined = undefined // 二级标题文本颜色
  _heading2TextFontSize: number | string | Resource = 17.0 // 二级标题文本尺寸
  _heading2TextFontStyle: FontStyle = FontStyle.Normal // 二级标题文本字体样式
  _heading2TextFontWeight: number | FontWeight = FontWeight.Bold // 二级标题文本字体粗细
  _heading2TextFontFamily: string | Resource = 'HarmonyOS Sans' // 二级标题文本字体
  _heading2TextLineHeight: number | string | Resource = 22.0 // 二级标题文本行高
  _heading2TextLetterSpacing: number = 0.0 // 二级标题文本字符间距
  _heading2UnderlineHeight: number = 0.5 // 二级标题下划线高度
  _heading2UnderlineColor: ResourceColor | undefined = undefined // 二级标题下划线颜色
  _heading2UnderlineSpacing: number = 0.0 // 二级标题距离标题文本间距

  // 三级标题
  _heading3BackgroundColor: ResourceColor | undefined = undefined // 三级标题背景颜色
  _heading3MarginTop: Length = 0.0 // 三级标题上外边距
  _heading3MarginRight: Length = 0.0 // 三级标题右外边距
  _heading3MarginBottom: Length = 0.0 // 三级标题下外边距
  _heading3MarginLeft: Length = 0.0 // 三级标题左外边距
  _heading3PaddingTop: Length = 0.0 // 三级标题上内边距
  _heading3PaddingRight: Length = 0.0 // 三级标题右内边距
  _heading3PaddingBottom: Length = 0.0 // 三级标题下内边距
  _heading3PaddingLeft: Length = 0.0 // 三级标题左内边距
  _heading3TextFontColor: ResourceColor | undefined = undefined // 三级标题文本颜色
  _heading3TextFontSize: number | string | Resource = 16.0 // 三级标题文本尺寸
  _heading3TextFontStyle: FontStyle = FontStyle.Normal // 三级标题文本字体样式
  _heading3TextFontWeight: number | FontWeight = FontWeight.Bold // 三级标题文本字体粗细
  _heading3TextFontFamily: string | Resource = 'HarmonyOS Sans' // 三级标题文本字体
  _heading3TextLineHeight: number | string | Resource = 22.0 // 三级标题文本行高
  _heading3TextLetterSpacing: number = 0.0 // 三级标题文本字符间距

  // 四级标题
  _heading4BackgroundColor: ResourceColor | undefined = undefined // 四级标题背景颜色
  _heading4MarginTop: Length = 0.0 // 四级标题上外边距
  _heading4MarginRight: Length = 0.0 // 四级标题右外边距
  _heading4MarginBottom: Length = 0.0 // 四级标题下外边距
  _heading4MarginLeft: Length = 0.0 // 四级标题左外边距
  _heading4PaddingTop: Length = 0.0 // 四级标题上内边距
  _heading4PaddingRight: Length = 0.0 // 四级标题右内边距
  _heading4PaddingBottom: Length = 0.0 // 四级标题下内边距
  _heading4PaddingLeft: Length = 0.0 // 四级标题左内边距
  _heading4TextFontColor: ResourceColor | undefined = undefined // 四级标题文本颜色
  _heading4TextFontSize: number | string | Resource = 15.0 // 四级标题文本尺寸
  _heading4TextFontStyle: FontStyle = FontStyle.Normal // 四级标题文本字体样式
  _heading4TextFontWeight: number | FontWeight = FontWeight.Bold // 四级标题文本字体粗细
  _heading4TextFontFamily: string | Resource = 'HarmonyOS Sans' // 四级标题文本字体
  _heading4TextLineHeight: number | string | Resource = 22.0 // 四级标题文本行高
  _heading4TextLetterSpacing: number = 0.0 // 四级标题文本字符间距

  // 五级标题
  _heading5BackgroundColor: ResourceColor | undefined = undefined // 五级标题背景颜色
  _heading5MarginTop: Length = 0.0 // 五级标题上外边距
  _heading5MarginRight: Length = 0.0 // 五级标题右外边距
  _heading5MarginBottom: Length = 0.0 // 五级标题下外边距
  _heading5MarginLeft: Length = 0.0 // 五级标题左外边距
  _heading5PaddingTop: Length = 0.0 // 五级标题上内边距
  _heading5PaddingRight: Length = 0.0 // 五级标题右内边距
  _heading5PaddingBottom: Length = 0.0 // 五级标题下内边距
  _heading5PaddingLeft: Length = 0.0 // 五级标题左内边距
  _heading5TextFontColor: ResourceColor | undefined = undefined // 五级标题文本颜色
  _heading5TextFontSize: number | string | Resource = 15.0 // 五级标题文本尺寸
  _heading5TextFontStyle: FontStyle = FontStyle.Normal // 五级标题文本字体样式
  _heading5TextFontWeight: number | FontWeight = FontWeight.Bold // 五级标题文本字体粗细
  _heading5TextFontFamily: string | Resource = 'HarmonyOS Sans' // 五级标题文本字体
  _heading5TextLineHeight: number | string | Resource = 22.0 // 五级标题文本行高
  _heading5TextLetterSpacing: number = 0.0 // 五级标题文本字符间距

  // 六级标题
  _heading6BackgroundColor: ResourceColor | undefined = undefined // 六级标题背景颜色
  _heading6MarginTop: Length = 0.0 // 六级标题上外边距
  _heading6MarginRight: Length = 0.0 // 六级标题右外边距
  _heading6MarginBottom: Length = 0.0 // 六级标题下外边距
  _heading6MarginLeft: Length = 0.0 // 六级标题左外边距
  _heading6PaddingTop: Length = 0.0 // 六级标题上内边距
  _heading6PaddingRight: Length = 0.0 // 六级标题右内边距
  _heading6PaddingBottom: Length = 0.0 // 六级标题下内边距
  _heading6PaddingLeft: Length = 0.0 // 六级标题左内边距
  _heading6TextFontColor: ResourceColor | undefined = undefined // 六级标题文本颜色
  _heading6TextFontSize: number | string | Resource = 13.0 // 六级标题文本尺寸
  _heading6TextFontStyle: FontStyle = FontStyle.Normal // 六级标题文本字体样式
  _heading6TextFontWeight: number | FontWeight = FontWeight.Bold // 六级标题文本字体粗细
  _heading6TextFontFamily: string | Resource = 'HarmonyOS Sans' // 六级标题文本字体
  _heading6TextLineHeight: number | string | Resource = 22.0 // 六级标题文本行高
  _heading6TextLetterSpacing: number = 0.0 // 六级标题文本字符间距

  constructor() {
    super()
  }
}
