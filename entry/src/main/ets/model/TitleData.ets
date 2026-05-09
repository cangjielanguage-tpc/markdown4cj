import { BaseMDData } from "./BaseMDData"

export class TitleData extends BaseMDData {
  // 一级标题
  _heading1BackgroundColor: number | undefined = undefined // 一级标题背景颜色
  _heading1MarginTop: number = 8 // 一级标题上外边距
  _heading1MarginRight: number = 0 // 一级标题右外边距
  _heading1MarginBottom: number = 8 // 一级标题下外边距
  _heading1MarginLeft: number = 0 // 一级标题左外边距
  _heading1PaddingTop: number = 0 // 一级标题上内边距
  _heading1PaddingRight: number = 0 // 一级标题右内边距
  _heading1PaddingBottom: number = 0 // 一级标题下内边距
  _heading1PaddingLeft: number = 0 // 一级标题左内边距
  _heading1TextFontColor: number | undefined = undefined // 一级标题文本颜色
  _heading1TextFontSize: number = 24 // 一级标题文本尺寸
  _heading1TextFontStyle: FontStyle = FontStyle.Normal // 一级标题文本字体样式
  _heading1TextFontWeight: FontWeight = FontWeight.Bold // 一级标题文本字体粗细
  _heading1TextFontFamily: string = 'HarmonyOS Sans' // 一级标题文本字体
  _heading1TextLineHeight: number = 32 // 一级标题文本行高
  _heading1TextLetterSpacing: number = 0 // 一级标题文本字符间距
  _heading1UnderlineHeight: number = 2 // 一级标题下划线高度
  _heading1UnderlineColor: number | undefined = undefined // 一级标题下划线颜色
  _heading1UnderlineSpacing: number = 4 // 一级标题距离标题文本间距

  // 二级标题
  _heading2BackgroundColor: number | undefined = undefined // 二级标题背景颜色
  _heading2MarginTop: number = 8 // 二级标题上外边距
  _heading2MarginRight: number = 0 // 二级标题右外边距
  _heading2MarginBottom: number = 8 // 二级标题下外边距
  _heading2MarginLeft: number = 0 // 二级标题左外边距
  _heading2PaddingTop: number = 0 // 二级标题上内边距
  _heading2PaddingRight: number = 0 // 二级标题右内边距
  _heading2PaddingBottom: number = 0 // 二级标题下内边距
  _heading2PaddingLeft: number = 0 // 二级标题左内边距
  _heading2TextFontColor: number | undefined = undefined // 二级标题文本颜色
  _heading2TextFontSize: number = 20 // 二级标题文本尺寸
  _heading2TextFontStyle: FontStyle = FontStyle.Normal // 二级标题文本字体样式
  _heading2TextFontWeight: FontWeight = FontWeight.Bold // 二级标题文本字体粗细
  _heading2TextFontFamily: string = 'HarmonyOS Sans' // 二级标题文本字体
  _heading2TextLineHeight: number = 28 // 二级标题文本行高
  _heading2TextLetterSpacing: number = 0 // 二级标题文本字符间距
  _heading2UnderlineHeight: number = 1.5 // 二级标题下划线高度
  _heading2UnderlineColor: number | undefined = undefined // 二级标题下划线颜色
  _heading2UnderlineSpacing: number = 3 // 二级标题距离标题文本间距

  // 三级标题
  _heading3BackgroundColor: number | undefined = undefined // 三级标题背景颜色
  _heading3MarginTop: number = 8 // 三级标题上外边距
  _heading3MarginRight: number = 0 // 三级标题右外边距
  _heading3MarginBottom: number = 8 // 三级标题下外边距
  _heading3MarginLeft: number = 0 // 三级标题左外边距
  _heading3PaddingTop: number = 0 // 三级标题上内边距
  _heading3PaddingRight: number = 0 // 三级标题右内边距
  _heading3PaddingBottom: number = 0 // 三级标题下内边距
  _heading3PaddingLeft: number = 0 // 三级标题左内边距
  _heading3TextFontColor: number | undefined = undefined // 三级标题文本颜色
  _heading3TextFontSize: number = 18 // 三级标题文本尺寸
  _heading3TextFontStyle: FontStyle = FontStyle.Normal // 三级标题文本字体样式
  _heading3TextFontWeight: FontWeight = FontWeight.Bold // 三级标题文本字体粗细
  _heading3TextFontFamily: string = 'HarmonyOS Sans' // 三级标题文本字体
  _heading3TextLineHeight: number = 26 // 三级标题文本行高
  _heading3TextLetterSpacing: number = 0 // 三级标题文本字符间距

  // 四级标题
  _heading4BackgroundColor: number | undefined = undefined // 四级标题背景颜色
  _heading4MarginTop: number = 8 // 四级标题上外边距
  _heading4MarginRight: number = 0 // 四级标题右外边距
  _heading4MarginBottom: number = 8 // 四级标题下外边距
  _heading4MarginLeft: number = 0 // 四级标题左外边距
  _heading4PaddingTop: number = 0 // 四级标题上内边距
  _heading4PaddingRight: number = 0 // 四级标题右内边距
  _heading4PaddingBottom: number = 0 // 四级标题下内边距
  _heading4PaddingLeft: number = 0 // 四级标题左内边距
  _heading4TextFontColor: number | undefined = undefined // 四级标题文本颜色
  _heading4TextFontSize: number = 16 // 四级标题文本尺寸
  _heading4TextFontStyle: FontStyle = FontStyle.Normal // 四级标题文本字体样式
  _heading4TextFontWeight: FontWeight = FontWeight.Bold // 四级标题文本字体粗细
  _heading4TextFontFamily: string = 'HarmonyOS Sans' // 四级标题文本字体
  _heading4TextLineHeight: number = 24 // 四级标题文本行高
  _heading4TextLetterSpacing: number = 0 // 四级标题文本字符间距

  // 五级标题
  _heading5BackgroundColor: number | undefined = undefined // 五级标题背景颜色
  _heading5MarginTop: number = 8 // 五级标题上外边距
  _heading5MarginRight: number = 0 // 五级标题右外边距
  _heading5MarginBottom: number = 8 // 五级标题下外边距
  _heading5MarginLeft: number = 0 // 五级标题左外边距
  _heading5PaddingTop: number = 0 // 五级标题上内边距
  _heading5PaddingRight: number = 0 // 五级标题右内边距
  _heading5PaddingBottom: number = 0 // 五级标题下内边距
  _heading5PaddingLeft: number = 0 // 五级标题左内边距
  _heading5TextFontColor: number | undefined = undefined // 五级标题文本颜色
  _heading5TextFontSize: number = 15 // 五级标题文本尺寸
  _heading5TextFontStyle: FontStyle = FontStyle.Normal // 五级标题文本字体样式
  _heading5TextFontWeight: FontWeight = FontWeight.Bold // 五级标题文本字体粗细
  _heading5TextFontFamily: string = 'HarmonyOS Sans' // 五级标题文本字体
  _heading5TextLineHeight: number = 23 // 五级标题文本行高
  _heading5TextLetterSpacing: number = 0 // 五级标题文本字符间距

  // 六级标题
  _heading6BackgroundColor: number | undefined = undefined // 六级标题背景颜色
  _heading6MarginTop: number = 8 // 六级标题上外边距
  _heading6MarginRight: number = 0 // 六级标题右外边距
  _heading6MarginBottom: number = 8 // 六级标题下外边距
  _heading6MarginLeft: number = 0 // 六级标题左外边距
  _heading6PaddingTop: number = 0 // 六级标题上内边距
  _heading6PaddingRight: number = 0 // 六级标题右内边距
  _heading6PaddingBottom: number = 0 // 六级标题下内边距
  _heading6PaddingLeft: number = 0 // 六级标题左内边距
  _heading6TextFontColor: number | undefined = undefined // 六级标题文本颜色
  _heading6TextFontSize: number = 14 // 六级标题文本尺寸
  _heading6TextFontStyle: FontStyle = FontStyle.Normal // 六级标题文本字体样式
  _heading6TextFontWeight: FontWeight = FontWeight.Bold // 六级标题文本字体粗细
  _heading6TextFontFamily: string = 'HarmonyOS Sans' // 六级标题文本字体
  _heading6TextLineHeight: number = 22 // 六级标题文本行高
  _heading6TextLetterSpacing: number = 0 // 六级标题文本字符间距

  // Setter方法 - 一级标题
  public set heading1BackgroundColor(value: number | undefined) {
    this._heading1BackgroundColor = value
  }

  public set heading1MarginTop(value: number) {
    this._heading1MarginTop = value
  }

  public set heading1MarginRight(value: number) {
    this._heading1MarginRight = value
  }

  public set heading1MarginBottom(value: number) {
    this._heading1MarginBottom = value
  }

  public set heading1MarginLeft(value: number) {
    this._heading1MarginLeft = value
  }

  public set heading1PaddingTop(value: number) {
    this._heading1PaddingTop = value
  }

  public set heading1PaddingRight(value: number) {
    this._heading1PaddingRight = value
  }

  public set heading1PaddingBottom(value: number) {
    this._heading1PaddingBottom = value
  }

  public set heading1PaddingLeft(value: number) {
    this._heading1PaddingLeft = value
  }

  public set heading1TextFontColor(value: number | undefined) {
    this._heading1TextFontColor = value
  }

  public set heading1TextFontSize(value: number) {
    this._heading1TextFontSize = value
  }

  public set heading1TextFontStyle(value: FontStyle) {
    this._heading1TextFontStyle = value
  }

  public set heading1TextFontWeight(value: FontWeight) {
    this._heading1TextFontWeight = value
  }

  public set heading1TextFontFamily(value: string) {
    this._heading1TextFontFamily = value
  }

  public set heading1TextLineHeight(value: number) {
    this._heading1TextLineHeight = value
  }

  public set heading1TextLetterSpacing(value: number) {
    this._heading1TextLetterSpacing = value
  }

  public set heading1UnderlineHeight(value: number) {
    this._heading1UnderlineHeight = value
  }

  public set heading1UnderlineColor(value: number | undefined) {
    this._heading1UnderlineColor = value
  }

  public set heading1UnderlineSpacing(value: number) {
    this._heading1UnderlineSpacing = value
  }

  // Setter方法 - 二级标题
  public set heading2BackgroundColor(value: number | undefined) {
    this._heading2BackgroundColor = value
  }

  public set heading2MarginTop(value: number) {
    this._heading2MarginTop = value
  }

  public set heading2MarginRight(value: number) {
    this._heading2MarginRight = value
  }

  public set heading2MarginBottom(value: number) {
    this._heading2MarginBottom = value
  }

  public set heading2MarginLeft(value: number) {
    this._heading2MarginLeft = value
  }

  public set heading2PaddingTop(value: number) {
    this._heading2PaddingTop = value
  }

  public set heading2PaddingRight(value: number) {
    this._heading2PaddingRight = value
  }

  public set heading2PaddingBottom(value: number) {
    this._heading2PaddingBottom = value
  }

  public set heading2PaddingLeft(value: number) {
    this._heading2PaddingLeft = value
  }

  public set heading2TextFontColor(value: number | undefined) {
    this._heading2TextFontColor = value
  }

  public set heading2TextFontSize(value: number) {
    this._heading2TextFontSize = value
  }

  public set heading2TextFontStyle(value: FontStyle) {
    this._heading2TextFontStyle = value
  }

  public set heading2TextFontWeight(value: FontWeight) {
    this._heading2TextFontWeight = value
  }

  public set heading2TextFontFamily(value: string) {
    this._heading2TextFontFamily = value
  }

  public set heading2TextLineHeight(value: number) {
    this._heading2TextLineHeight = value
  }

  public set heading2TextLetterSpacing(value: number) {
    this._heading2TextLetterSpacing = value
  }

  public set heading2UnderlineHeight(value: number) {
    this._heading2UnderlineHeight = value
  }

  public set heading2UnderlineColor(value: number | undefined) {
    this._heading2UnderlineColor = value
  }

  public set heading2UnderlineSpacing(value: number) {
    this._heading2UnderlineSpacing = value
  }

  // Setter方法 - 三级标题
  public set heading3BackgroundColor(value: number | undefined) {
    this._heading3BackgroundColor = value
  }

  public set heading3MarginTop(value: number) {
    this._heading3MarginTop = value
  }

  public set heading3MarginRight(value: number) {
    this._heading3MarginRight = value
  }

  public set heading3MarginBottom(value: number) {
    this._heading3MarginBottom = value
  }

  public set heading3MarginLeft(value: number) {
    this._heading3MarginLeft = value
  }

  public set heading3PaddingTop(value: number) {
    this._heading3PaddingTop = value
  }

  public set heading3PaddingRight(value: number) {
    this._heading3PaddingRight = value
  }

  public set heading3PaddingBottom(value: number) {
    this._heading3PaddingBottom = value
  }

  public set heading3PaddingLeft(value: number) {
    this._heading3PaddingLeft = value
  }

  public set heading3TextFontColor(value: number | undefined) {
    this._heading3TextFontColor = value
  }

  public set heading3TextFontSize(value: number) {
    this._heading3TextFontSize = value
  }

  public set heading3TextFontStyle(value: FontStyle) {
    this._heading3TextFontStyle = value
  }

  public set heading3TextFontWeight(value: FontWeight) {
    this._heading3TextFontWeight = value
  }

  public set heading3TextFontFamily(value: string) {
    this._heading3TextFontFamily = value
  }

  public set heading3TextLineHeight(value: number) {
    this._heading3TextLineHeight = value
  }

  public set heading3TextLetterSpacing(value: number) {
    this._heading3TextLetterSpacing = value
  }

  // Setter方法 - 四级标题
  public set heading4BackgroundColor(value: number | undefined) {
    this._heading4BackgroundColor = value
  }

  public set heading4MarginTop(value: number) {
    this._heading4MarginTop = value
  }

  public set heading4MarginRight(value: number) {
    this._heading4MarginRight = value
  }

  public set heading4MarginBottom(value: number) {
    this._heading4MarginBottom = value
  }

  public set heading4MarginLeft(value: number) {
    this._heading4MarginLeft = value
  }

  public set heading4PaddingTop(value: number) {
    this._heading4PaddingTop = value
  }

  public set heading4PaddingRight(value: number) {
    this._heading4PaddingRight = value
  }

  public set heading4PaddingBottom(value: number) {
    this._heading4PaddingBottom = value
  }

  public set heading4PaddingLeft(value: number) {
    this._heading4PaddingLeft = value
  }

  public set heading4TextFontColor(value: number | undefined) {
    this._heading4TextFontColor = value
  }

  public set heading4TextFontSize(value: number) {
    this._heading4TextFontSize = value
  }

  public set heading4TextFontStyle(value: FontStyle) {
    this._heading4TextFontStyle = value
  }

  public set heading4TextFontWeight(value: FontWeight) {
    this._heading4TextFontWeight = value
  }

  public set heading4TextFontFamily(value: string) {
    this._heading4TextFontFamily = value
  }

  public set heading4TextLineHeight(value: number) {
    this._heading4TextLineHeight = value
  }

  public set heading4TextLetterSpacing(value: number) {
    this._heading4TextLetterSpacing = value
  }

  // Setter方法 - 五级标题
  public set heading5BackgroundColor(value: number | undefined) {
    this._heading5BackgroundColor = value
  }

  public set heading5MarginTop(value: number) {
    this._heading5MarginTop = value
  }

  public set heading5MarginRight(value: number) {
    this._heading5MarginRight = value
  }

  public set heading5MarginBottom(value: number) {
    this._heading5MarginBottom = value
  }

  public set heading5MarginLeft(value: number) {
    this._heading5MarginLeft = value
  }

  public set heading5PaddingTop(value: number) {
    this._heading5PaddingTop = value
  }

  public set heading5PaddingRight(value: number) {
    this._heading5PaddingRight = value
  }

  public set heading5PaddingBottom(value: number) {
    this._heading5PaddingBottom = value
  }

  public set heading5PaddingLeft(value: number) {
    this._heading5PaddingLeft = value
  }

  public set heading5TextFontColor(value: number | undefined) {
    this._heading5TextFontColor = value
  }

  public set heading5TextFontSize(value: number) {
    this._heading5TextFontSize = value
  }

  public set heading5TextFontStyle(value: FontStyle) {
    this._heading5TextFontStyle = value
  }

  public set heading5TextFontWeight(value: FontWeight) {
    this._heading5TextFontWeight = value
  }

  public set heading5TextFontFamily(value: string) {
    this._heading5TextFontFamily = value
  }

  public set heading5TextLineHeight(value: number) {
    this._heading5TextLineHeight = value
  }

  public set heading5TextLetterSpacing(value: number) {
    this._heading5TextLetterSpacing = value
  }

  // Setter方法 - 六级标题
  public set heading6BackgroundColor(value: number | undefined) {
    this._heading6BackgroundColor = value
  }

  public set heading6MarginTop(value: number) {
    this._heading6MarginTop = value
  }

  public set heading6MarginRight(value: number) {
    this._heading6MarginRight = value
  }

  public set heading6MarginBottom(value: number) {
    this._heading6MarginBottom = value
  }

  public set heading6MarginLeft(value: number) {
    this._heading6MarginLeft = value
  }

  public set heading6PaddingTop(value: number) {
    this._heading6PaddingTop = value
  }

  public set heading6PaddingRight(value: number) {
    this._heading6PaddingRight = value
  }

  public set heading6PaddingBottom(value: number) {
    this._heading6PaddingBottom = value
  }

  public set heading6PaddingLeft(value: number) {
    this._heading6PaddingLeft = value
  }

  public set heading6TextFontColor(value: number | undefined) {
    this._heading6TextFontColor = value
  }

  public set heading6TextFontSize(value: number) {
    this._heading6TextFontSize = value
  }

  public set heading6TextFontStyle(value: FontStyle) {
    this._heading6TextFontStyle = value
  }

  public set heading6TextFontWeight(value: FontWeight) {
    this._heading6TextFontWeight = value
  }

  public set heading6TextFontFamily(value: string) {
    this._heading6TextFontFamily = value
  }

  public set heading6TextLineHeight(value: number) {
    this._heading6TextLineHeight = value
  }

  public set heading6TextLetterSpacing(value: number) {
    this._heading6TextLetterSpacing = value
  }

  constructor() {
    super()
  }
}
