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

  // Setter方法 - 一级标题
  public set heading1BackgroundColor(value: ResourceColor | undefined) {
    this._heading1BackgroundColor = value
  }

  public set heading1MarginTop(value: Length) {
    this._heading1MarginTop = value
  }

  public set heading1MarginRight(value: Length) {
    this._heading1MarginRight = value
  }

  public set heading1MarginBottom(value: Length) {
    this._heading1MarginBottom = value
  }

  public set heading1MarginLeft(value: Length) {
    this._heading1MarginLeft = value
  }

  public set heading1PaddingTop(value: Length) {
    this._heading1PaddingTop = value
  }

  public set heading1PaddingRight(value: Length) {
    this._heading1PaddingRight = value
  }

  public set heading1PaddingBottom(value: Length) {
    this._heading1PaddingBottom = value
  }

  public set heading1PaddingLeft(value: Length) {
    this._heading1PaddingLeft = value
  }

  public set heading1TextFontColor(value: ResourceColor | undefined) {
    this._heading1TextFontColor = value
  }

  public set heading1TextFontSize(value: number | string | Resource) {
    this._heading1TextFontSize = value
  }

  public set heading1TextFontStyle(value: FontStyle) {
    this._heading1TextFontStyle = value
  }

  public set heading1TextFontWeight(value: number | FontWeight) {
    this._heading1TextFontWeight = value
  }

  public set heading1TextFontFamily(value: string | Resource) {
    this._heading1TextFontFamily = value
  }

  public set heading1TextLineHeight(value: number | string | Resource) {
    this._heading1TextLineHeight = value
  }

  public set heading1TextLetterSpacing(value: number) {
    this._heading1TextLetterSpacing = value
  }

  public set heading1UnderlineHeight(value: number) {
    this._heading1UnderlineHeight = value
  }

  public set heading1UnderlineColor(value: ResourceColor | undefined) {
    this._heading1UnderlineColor = value
  }

  public set heading1UnderlineSpacing(value: number) {
    this._heading1UnderlineSpacing = value
  }

  // Setter方法 - 二级标题
  public set heading2BackgroundColor(value: ResourceColor | undefined) {
    this._heading2BackgroundColor = value
  }

  public set heading2MarginTop(value: Length) {
    this._heading2MarginTop = value
  }

  public set heading2MarginRight(value: Length) {
    this._heading2MarginRight = value
  }

  public set heading2MarginBottom(value: Length) {
    this._heading2MarginBottom = value
  }

  public set heading2MarginLeft(value: Length) {
    this._heading2MarginLeft = value
  }

  public set heading2PaddingTop(value: Length) {
    this._heading2PaddingTop = value
  }

  public set heading2PaddingRight(value: Length) {
    this._heading2PaddingRight = value
  }

  public set heading2PaddingBottom(value: Length) {
    this._heading2PaddingBottom = value
  }

  public set heading2PaddingLeft(value: Length) {
    this._heading2PaddingLeft = value
  }

  public set heading2TextFontColor(value: ResourceColor | undefined) {
    this._heading2TextFontColor = value
  }

  public set heading2TextFontSize(value: number | string | Resource) {
    this._heading2TextFontSize = value
  }

  public set heading2TextFontStyle(value: FontStyle) {
    this._heading2TextFontStyle = value
  }

  public set heading2TextFontWeight(value: number | FontWeight) {
    this._heading2TextFontWeight = value
  }

  public set heading2TextFontFamily(value: string | Resource) {
    this._heading2TextFontFamily = value
  }

  public set heading2TextLineHeight(value: number | string | Resource) {
    this._heading2TextLineHeight = value
  }

  public set heading2TextLetterSpacing(value: number) {
    this._heading2TextLetterSpacing = value
  }

  public set heading2UnderlineHeight(value: number) {
    this._heading2UnderlineHeight = value
  }

  public set heading2UnderlineColor(value: ResourceColor | undefined) {
    this._heading2UnderlineColor = value
  }

  public set heading2UnderlineSpacing(value: number) {
    this._heading2UnderlineSpacing = value
  }

  // Setter方法 - 三级标题
  public set heading3BackgroundColor(value: ResourceColor | undefined) {
    this._heading3BackgroundColor = value
  }

  public set heading3MarginTop(value: Length) {
    this._heading3MarginTop = value
  }

  public set heading3MarginRight(value: Length) {
    this._heading3MarginRight = value
  }

  public set heading3MarginBottom(value: Length) {
    this._heading3MarginBottom = value
  }

  public set heading3MarginLeft(value: Length) {
    this._heading3MarginLeft = value
  }

  public set heading3PaddingTop(value: Length) {
    this._heading3PaddingTop = value
  }

  public set heading3PaddingRight(value: Length) {
    this._heading3PaddingRight = value
  }

  public set heading3PaddingBottom(value: Length) {
    this._heading3PaddingBottom = value
  }

  public set heading3PaddingLeft(value: Length) {
    this._heading3PaddingLeft = value
  }

  public set heading3TextFontColor(value: ResourceColor | undefined) {
    this._heading3TextFontColor = value
  }

  public set heading3TextFontSize(value: number | string | Resource) {
    this._heading3TextFontSize = value
  }

  public set heading3TextFontStyle(value: FontStyle) {
    this._heading3TextFontStyle = value
  }

  public set heading3TextFontWeight(value: number | FontWeight) {
    this._heading3TextFontWeight = value
  }

  public set heading3TextFontFamily(value: string | Resource) {
    this._heading3TextFontFamily = value
  }

  public set heading3TextLineHeight(value: number | string | Resource) {
    this._heading3TextLineHeight = value
  }

  public set heading3TextLetterSpacing(value: number) {
    this._heading3TextLetterSpacing = value
  }

  // Setter方法 - 四级标题
  public set heading4BackgroundColor(value: ResourceColor | undefined) {
    this._heading4BackgroundColor = value
  }

  public set heading4MarginTop(value: Length) {
    this._heading4MarginTop = value
  }

  public set heading4MarginRight(value: Length) {
    this._heading4MarginRight = value
  }

  public set heading4MarginBottom(value: Length) {
    this._heading4MarginBottom = value
  }

  public set heading4MarginLeft(value: Length) {
    this._heading4MarginLeft = value
  }

  public set heading4PaddingTop(value: Length) {
    this._heading4PaddingTop = value
  }

  public set heading4PaddingRight(value: Length) {
    this._heading4PaddingRight = value
  }

  public set heading4PaddingBottom(value: Length) {
    this._heading4PaddingBottom = value
  }

  public set heading4PaddingLeft(value: Length) {
    this._heading4PaddingLeft = value
  }

  public set heading4TextFontColor(value: ResourceColor | undefined) {
    this._heading4TextFontColor = value
  }

  public set heading4TextFontSize(value: number | string | Resource) {
    this._heading4TextFontSize = value
  }

  public set heading4TextFontStyle(value: FontStyle) {
    this._heading4TextFontStyle = value
  }

  public set heading4TextFontWeight(value: number | FontWeight) {
    this._heading4TextFontWeight = value
  }

  public set heading4TextFontFamily(value: string | Resource) {
    this._heading4TextFontFamily = value
  }

  public set heading4TextLineHeight(value: number | string | Resource) {
    this._heading4TextLineHeight = value
  }

  public set heading4TextLetterSpacing(value: number) {
    this._heading4TextLetterSpacing = value
  }

  // Setter方法 - 五级标题
  public set heading5BackgroundColor(value: ResourceColor | undefined) {
    this._heading5BackgroundColor = value
  }

  public set heading5MarginTop(value: Length) {
    this._heading5MarginTop = value
  }

  public set heading5MarginRight(value: Length) {
    this._heading5MarginRight = value
  }

  public set heading5MarginBottom(value: Length) {
    this._heading5MarginBottom = value
  }

  public set heading5MarginLeft(value: Length) {
    this._heading5MarginLeft = value
  }

  public set heading5PaddingTop(value: Length) {
    this._heading5PaddingTop = value
  }

  public set heading5PaddingRight(value: Length) {
    this._heading5PaddingRight = value
  }

  public set heading5PaddingBottom(value: Length) {
    this._heading5PaddingBottom = value
  }

  public set heading5PaddingLeft(value: Length) {
    this._heading5PaddingLeft = value
  }

  public set heading5TextFontColor(value: ResourceColor | undefined) {
    this._heading5TextFontColor = value
  }

  public set heading5TextFontSize(value: number | string | Resource) {
    this._heading5TextFontSize = value
  }

  public set heading5TextFontStyle(value: FontStyle) {
    this._heading5TextFontStyle = value
  }

  public set heading5TextFontWeight(value: number | FontWeight) {
    this._heading5TextFontWeight = value
  }

  public set heading5TextFontFamily(value: string | Resource) {
    this._heading5TextFontFamily = value
  }

  public set heading5TextLineHeight(value: number | string | Resource) {
    this._heading5TextLineHeight = value
  }

  public set heading5TextLetterSpacing(value: number) {
    this._heading5TextLetterSpacing = value
  }

  // Setter方法 - 六级标题
  public set heading6BackgroundColor(value: ResourceColor | undefined) {
    this._heading6BackgroundColor = value
  }

  public set heading6MarginTop(value: Length) {
    this._heading6MarginTop = value
  }

  public set heading6MarginRight(value: Length) {
    this._heading6MarginRight = value
  }

  public set heading6MarginBottom(value: Length) {
    this._heading6MarginBottom = value
  }

  public set heading6MarginLeft(value: Length) {
    this._heading6MarginLeft = value
  }

  public set heading6PaddingTop(value: Length) {
    this._heading6PaddingTop = value
  }

  public set heading6PaddingRight(value: Length) {
    this._heading6PaddingRight = value
  }

  public set heading6PaddingBottom(value: Length) {
    this._heading6PaddingBottom = value
  }

  public set heading6PaddingLeft(value: Length) {
    this._heading6PaddingLeft = value
  }

  public set heading6TextFontColor(value: ResourceColor | undefined) {
    this._heading6TextFontColor = value
  }

  public set heading6TextFontSize(value: number | string | Resource) {
    this._heading6TextFontSize = value
  }

  public set heading6TextFontStyle(value: FontStyle) {
    this._heading6TextFontStyle = value
  }

  public set heading6TextFontWeight(value: number | FontWeight) {
    this._heading6TextFontWeight = value
  }

  public set heading6TextFontFamily(value: string | Resource) {
    this._heading6TextFontFamily = value
  }

  public set heading6TextLineHeight(value: number | string | Resource) {
    this._heading6TextLineHeight = value
  }

  public set heading6TextLetterSpacing(value: number) {
    this._heading6TextLetterSpacing = value
  }

  constructor() {
    super()
  }
}
