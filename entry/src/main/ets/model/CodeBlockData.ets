import { BaseMDData } from "./BaseMDData"

export class CodeBlockData extends BaseMDData {
  _codeBlockIsDark: boolean = false // 代码深浅色模式
  _codeBlockIsCodeFormat: boolean = false // 是否格式化围栏代码块内容
  _codeBlockUseTab: boolean = false // codeformat是否用制表符
  _codeBlockIndentWidth: number = 4 // codeformat空格缩进数量
  _codeBlockParserSync: boolean = false // 围栏代码块代码高亮是否同步解析
  _codeBlockBackgroundColor: number | undefined = undefined // 代码块背景颜色
  _codeBlockMarginTop: number = 8 // 代码块上外边距
  _codeBlockMarginRight: number = 0 // 代码块右外边距
  _codeBlockMarginBottom: number = 8 // 代码块下外边距
  _codeBlockMarginLeft: number = 0 // 代码块左外边距
  _codeBlockPaddingTop: number = 12 // 代码块上内边距
  _codeBlockPaddingRight: number = 12 // 代码块右内边距
  _codeBlockPaddingBottom: number = 12 // 代码块下内边距
  _codeBlockPaddingLeft: number = 12 // 代码块左内边距
  _codeBlockBorderStyle: BorderStyle = BorderStyle.Solid // 代码块边框样式
  _codeBlockBorderWidth: number = 0 // 代码块边框宽度
  _codeBlockBorderColor: number | undefined = undefined // 代码块边框颜色
  _codeBlockRadiusTopLeft: number = 8 // 代码块边框左上圆角
  _codeBlockRadiusTopRight: number = 8 // 代码块边框右上圆角
  _codeBlockRadiusBottomLeft: number = 8 // 代码块边框左下圆角
  _codeBlockRadiusBottomRight: number = 8 // 代码块边框右下圆角
  _codeBlockTitleLayoutMarginBottom: number = 8 // 代码块类型和代码块内容间距
  _codeBlockTypeTextMarginLeft: number = 8 // 代码块类型左边距
  _codeBlockTypeText: string = "Code" // 代码块没有代码类型时默认显示文本
  _codeBlockTypeTextFontColor: number | undefined = undefined // 代码块类型文本颜色
  _codeBlockTypeTextFontSize: number = 14 // 代码块类型文本尺寸
  _codeBlockTypeTextFontStyle: FontStyle = FontStyle.Normal // 代码块类型文本字体样式
  _codeBlockTypeTextFontWeight: FontWeight = FontWeight.Normal // 代码块类型文本字体粗细
  _codeBlockTypeTextFontFamily: string = 'HarmonyOS Sans' // 代码块类型文本字体
  _codeBlockTypeTextLineHeight: number = 20 // 代码块类型文本行高
  _codeBlockCopyFullScreenSpacing: number = 8 // 代码块代码复制和代码全屏间距
  _codeBlockCopyButtonIsShow: boolean = true // 代码块代码复制按钮是否显示
  _codeBlockCopyTextIsShow: boolean = true // 代码块代码复制文本是否显示
  _codeBlockCopyIcon: Resource | undefined = undefined // 代码块代码复制按钮默认图标
  _codeBlockCopyIconWidth: number = 18 // 代码块代码复制图标宽度
  _codeBlockCopyIconHeight: number = 18 // 代码块代码复制图标高度
  _codeBlockCopyIconTextSpacing: number = 4 // 代码块代码复制图标和文本间距
  _codeBlockCopyText: string = "Copy" // 代码块代码复制默认文本内容
  _codeBlockCopyTextFontColor: number | undefined = undefined // 代码块代码复制文本颜色
  _codeBlockCopyTextFontSize: number = 14 // 代码块代码复制文本尺寸
  _codeBlockCopyTextFontStyle: FontStyle = FontStyle.Normal // 代码块代码复制文本字体样式
  _codeBlockCopyTextFontWeight: FontWeight = FontWeight.Normal // 代码块代码复制文本字体粗细
  _codeBlockCopyTextFontFamily: string = 'HarmonyOS Sans' // 代码块代码复制文本字体
  _codeBlockCopyTextLineHeight: number = 20 // 代码块代码复制文本行高
  _codeBlockFullScreenButtonIsShow: boolean = true // 代码块代码全屏按钮是否显示
  _codeBlockFullScreenTextIsShow: boolean = true // 代码块代码全屏文本是否显示
  _codeBlockFullScreenIcon: Resource | undefined = undefined // 代码块代码全屏按钮默认图标
  _codeBlockFullScreenIconWidth: number = 18 // 代码块代码全屏图标宽度
  _codeBlockFullScreenIconHeight: number = 18 // 代码块代码全屏图标高度
  _codeBlockFullScreenIconTextSpacing: number = 4 // 代码块代码全屏图标和文本间距
  _codeBlockFullScreenText: string = "Full Screen" // 代码块代码全屏默认文本内容
  _codeBlockFullScreenTextFontColor: number | undefined = undefined // 代码块代码全屏文本颜色
  _codeBlockFullScreenTextFontSize: number = 14 // 代码块代码全屏文本尺寸
  _codeBlockFullScreenTextFontStyle: FontStyle = FontStyle.Normal // 代码块代码全屏文本字体样式
  _codeBlockFullScreenTextFontWeight: FontWeight = FontWeight.Normal // 代码块代码全屏文本字体粗细
  _codeBlockFullScreenTextFontFamily: string = 'HarmonyOS Sans' // 代码块代码全屏文本字体
  _codeBlockFullScreenTextLineHeight: number = 20 // 代码块代码全屏文本行高
  _codeBlockLineNumberIsShow: boolean = false // 代码块代码行号是否显示
  _codeBlockLineNumberTextPaddingLeft: number = 8 // 代码块代码行号左内边距
  _codeBlockLineNumberTextFontColor: number | undefined = undefined // 代码块代码行号文本颜色
  _codeBlockLineNumberTextFontSize: number = 13 // 代码块代码行号文本尺寸
  _codeBlockLineNumberTextFontStyle: FontStyle = FontStyle.Normal // 代码块代码行号文本字体样式
  _codeBlockLineNumberTextFontWeight: FontWeight = FontWeight.Normal // 代码块代码行号文本字体粗细
  _codeBlockLineNumberTextFontFamily: string = 'HarmonyOS Sans' // 代码块代码行号文本字体
  _codeBlockLineNumberTextLineHeight: number = 22 // 代码块代码行号文本行高
  _codeBlockDividerColor: number | undefined = undefined // 代码块代码行号和代码块中间分割线颜色
  _codeBlockDividerStrokeWidth: number = 1 // 代码块代码行号和代码块中间分割线宽度
  _codeBlockLineNumberDividerSpacing: number = 8 // 代码块代码行号和分割线间距
  _codeBlockTextFontColor: number | undefined = undefined // 代码块文本颜色
  _codeBlockTextMarginRight: number = 0 // 代码块代码文本右外边距
  _codeBlockTextMarginLeft: number = 0 // 代码块代码文本左外边距
  _codeBlockTextFontSize: number = 13 // 代码块文本尺寸
  _codeBlockTextFontStyle: FontStyle = FontStyle.Normal // 代码块文本字体样式
  _codeBlockTextFontWeight: FontWeight = FontWeight.Normal // 代码块文本字体粗细
  _codeBlockTextFontFamily: string = 'HarmonyOS Sans' // 代码块文本字体
  _codeBlockTextLineHeight: number = 22 // 代码块文本行高
  _codeBlockTextLetterSpacing: number = 0 // 代码块文本字符间距
  _codeBlockListTitleTextSize: number = 14 // 组合代码块未选中标题字体大小
  _codeBlockListTitleSelectTextSize: number = 15 // 组合代码块选中标题字体大小
  _codeBlockListTitleSelectTextColor: number | undefined = undefined // 组合代码块选中标题文本颜色
  _codeBlockListTitleUnselectTextColor: number | undefined = undefined // 组合代码块未选中标题文本颜色
  _codeBlockListTitleSelectBackgroundColor: number | undefined = undefined // 组合代码块选中标题背景颜色
  _codeBlockListTitleUnselectBackgroundColor: number | undefined = undefined // 组合代码块未选中标题背景颜色
  _codeBlockIsSeparate: boolean = false // 是否单独代码块显示
  _codeBlockSeparateWidth: number = 60 // 单独代码块行号宽度
  _codeBlockSeparateIsBottom: boolean = false // 单独代码块是否居底显示

  public set codeBlockIsDark(value: boolean) {
    this._codeBlockIsDark = value
  }

  public set codeBlockIsCodeFormat(value: boolean) {
    this._codeBlockIsCodeFormat = value
  }

  public set codeBlockUseTab(value: boolean) {
    this._codeBlockUseTab = value
  }

  public set codeBlockIndentWidth(value: number) {
    this._codeBlockIndentWidth = value
  }

  public set codeBlockParserSync(value: boolean) {
    this._codeBlockParserSync = value
  }

  public set codeBlockBackgroundColor(value: number | undefined) {
    this._codeBlockBackgroundColor = value
  }

  public set codeBlockMarginTop(value: number) {
    this._codeBlockMarginTop = value
  }

  public set codeBlockMarginRight(value: number) {
    this._codeBlockMarginRight = value
  }

  public set codeBlockMarginBottom(value: number) {
    this._codeBlockMarginBottom = value
  }

  public set codeBlockMarginLeft(value: number) {
    this._codeBlockMarginLeft = value
  }

  public set codeBlockPaddingTop(value: number) {
    this._codeBlockPaddingTop = value
  }

  public set codeBlockPaddingRight(value: number) {
    this._codeBlockPaddingRight = value
  }

  public set codeBlockPaddingBottom(value: number) {
    this._codeBlockPaddingBottom = value
  }

  public set codeBlockPaddingLeft(value: number) {
    this._codeBlockPaddingLeft = value
  }

  public set codeBlockBorderStyle(value: BorderStyle) {
    this._codeBlockBorderStyle = value
  }

  public set codeBlockBorderWidth(value: number) {
    this._codeBlockBorderWidth = value
  }

  public set codeBlockBorderColor(value: number | undefined) {
    this._codeBlockBorderColor = value
  }

  public set codeBlockRadiusTopLeft(value: number) {
    this._codeBlockRadiusTopLeft = value
  }

  public set codeBlockRadiusTopRight(value: number) {
    this._codeBlockRadiusTopRight = value
  }

  public set codeBlockRadiusBottomLeft(value: number) {
    this._codeBlockRadiusBottomLeft = value
  }

  public set codeBlockRadiusBottomRight(value: number) {
    this._codeBlockRadiusBottomRight = value
  }

  public set codeBlockTitleLayoutMarginBottom(value: number) {
    this._codeBlockTitleLayoutMarginBottom = value
  }

  public set codeBlockTypeTextMarginLeft(value: number) {
    this._codeBlockTypeTextMarginLeft = value
  }

  public set codeBlockTypeText(value: string) {
    this._codeBlockTypeText = value
  }

  public set codeBlockTypeTextFontColor(value: number | undefined) {
    this._codeBlockTypeTextFontColor = value
  }

  public set codeBlockTypeTextFontSize(value: number) {
    this._codeBlockTypeTextFontSize = value
  }

  public set codeBlockTypeTextFontStyle(value: FontStyle) {
    this._codeBlockTypeTextFontStyle = value
  }

  public set codeBlockTypeTextFontWeight(value: FontWeight) {
    this._codeBlockTypeTextFontWeight = value
  }

  public set codeBlockTypeTextFontFamily(value: string) {
    this._codeBlockTypeTextFontFamily = value
  }

  public set codeBlockTypeTextLineHeight(value: number) {
    this._codeBlockTypeTextLineHeight = value
  }

  public set codeBlockCopyFullScreenSpacing(value: number) {
    this._codeBlockCopyFullScreenSpacing = value
  }

  public set codeBlockCopyButtonIsShow(value: boolean) {
    this._codeBlockCopyButtonIsShow = value
  }

  public set codeBlockCopyTextIsShow(value: boolean) {
    this._codeBlockCopyTextIsShow = value
  }

  public set codeBlockCopyIcon(value: Resource | undefined) {
    this._codeBlockCopyIcon = value
  }

  public set codeBlockCopyIconWidth(value: number) {
    this._codeBlockCopyIconWidth = value
  }

  public set codeBlockCopyIconHeight(value: number) {
    this._codeBlockCopyIconHeight = value
  }

  public set codeBlockCopyIconTextSpacing(value: number) {
    this._codeBlockCopyIconTextSpacing = value
  }

  public set codeBlockCopyText(value: string) {
    this._codeBlockCopyText = value
  }

  public set codeBlockCopyTextFontColor(value: number | undefined) {
    this._codeBlockCopyTextFontColor = value
  }

  public set codeBlockCopyTextFontSize(value: number) {
    this._codeBlockCopyTextFontSize = value
  }

  public set codeBlockCopyTextFontStyle(value: FontStyle) {
    this._codeBlockCopyTextFontStyle = value
  }

  public set codeBlockCopyTextFontWeight(value: FontWeight) {
    this._codeBlockCopyTextFontWeight = value
  }

  public set codeBlockCopyTextFontFamily(value: string) {
    this._codeBlockCopyTextFontFamily = value
  }

  public set codeBlockCopyTextLineHeight(value: number) {
    this._codeBlockCopyTextLineHeight = value
  }

  public set codeBlockFullScreenButtonIsShow(value: boolean) {
    this._codeBlockFullScreenButtonIsShow = value
  }

  public set codeBlockFullScreenTextIsShow(value: boolean) {
    this._codeBlockFullScreenTextIsShow = value
  }

  public set codeBlockFullScreenIcon(value: Resource | undefined) {
    this._codeBlockFullScreenIcon = value
  }

  public set codeBlockFullScreenIconWidth(value: number) {
    this._codeBlockFullScreenIconWidth = value
  }

  public set codeBlockFullScreenIconHeight(value: number) {
    this._codeBlockFullScreenIconHeight = value
  }

  public set codeBlockFullScreenIconTextSpacing(value: number) {
    this._codeBlockFullScreenIconTextSpacing = value
  }

  public set codeBlockFullScreenText(value: string) {
    this._codeBlockFullScreenText = value
  }

  public set codeBlockFullScreenTextFontColor(value: number | undefined) {
    this._codeBlockFullScreenTextFontColor = value
  }

  public set codeBlockFullScreenTextFontSize(value: number) {
    this._codeBlockFullScreenTextFontSize = value
  }

  public set codeBlockFullScreenTextFontStyle(value: FontStyle) {
    this._codeBlockFullScreenTextFontStyle = value
  }

  public set codeBlockFullScreenTextFontWeight(value: FontWeight) {
    this._codeBlockFullScreenTextFontWeight = value
  }

  public set codeBlockFullScreenTextFontFamily(value: string) {
    this._codeBlockFullScreenTextFontFamily = value
  }

  public set codeBlockFullScreenTextLineHeight(value: number) {
    this._codeBlockFullScreenTextLineHeight = value
  }

  public set codeBlockLineNumberIsShow(value: boolean) {
    this._codeBlockLineNumberIsShow = value
  }

  public set codeBlockLineNumberTextPaddingLeft(value: number) {
    this._codeBlockLineNumberTextPaddingLeft = value
  }

  public set codeBlockLineNumberTextFontColor(value: number | undefined) {
    this._codeBlockLineNumberTextFontColor = value
  }

  public set codeBlockLineNumberTextFontSize(value: number) {
    this._codeBlockLineNumberTextFontSize = value
  }

  public set codeBlockLineNumberTextFontStyle(value: FontStyle) {
    this._codeBlockLineNumberTextFontStyle = value
  }

  public set codeBlockLineNumberTextFontWeight(value: FontWeight) {
    this._codeBlockLineNumberTextFontWeight = value
  }

  public set codeBlockLineNumberTextFontFamily(value: string) {
    this._codeBlockLineNumberTextFontFamily = value
  }

  public set codeBlockLineNumberTextLineHeight(value: number) {
    this._codeBlockLineNumberTextLineHeight = value
  }

  public set codeBlockDividerColor(value: number | undefined) {
    this._codeBlockDividerColor = value
  }

  public set codeBlockDividerStrokeWidth(value: number) {
    this._codeBlockDividerStrokeWidth = value
  }

  public set codeBlockLineNumberDividerSpacing(value: number) {
    this._codeBlockLineNumberDividerSpacing = value
  }

  public set codeBlockTextFontColor(value: number | undefined) {
    this._codeBlockTextFontColor = value
  }

  public set codeBlockTextMarginRight(value: number) {
    this._codeBlockTextMarginRight = value
  }

  public set codeBlockTextMarginLeft(value: number) {
    this._codeBlockTextMarginLeft = value
  }

  public set codeBlockTextFontSize(value: number) {
    this._codeBlockTextFontSize = value
  }

  public set codeBlockTextFontStyle(value: FontStyle) {
    this._codeBlockTextFontStyle = value
  }

  public set codeBlockTextFontWeight(value: FontWeight) {
    this._codeBlockTextFontWeight = value
  }

  public set codeBlockTextFontFamily(value: string) {
    this._codeBlockTextFontFamily = value
  }

  public set codeBlockTextLineHeight(value: number) {
    this._codeBlockTextLineHeight = value
  }

  public set codeBlockTextLetterSpacing(value: number) {
    this._codeBlockTextLetterSpacing = value
  }

  public set codeBlockListTitleTextSize(value: number) {
    this._codeBlockListTitleTextSize = value
  }

  public set codeBlockListTitleSelectTextSize(value: number) {
    this._codeBlockListTitleSelectTextSize = value
  }

  public set codeBlockListTitleSelectTextColor(value: number | undefined) {
    this._codeBlockListTitleSelectTextColor = value
  }

  public set codeBlockListTitleUnselectTextColor(value: number | undefined) {
    this._codeBlockListTitleUnselectTextColor = value
  }

  public set codeBlockListTitleSelectBackgroundColor(value: number | undefined) {
    this._codeBlockListTitleSelectBackgroundColor = value
  }

  public set codeBlockListTitleUnselectBackgroundColor(value: number | undefined) {
    this._codeBlockListTitleUnselectBackgroundColor = value
  }

  public set codeBlockIsSeparate(value: boolean) {
    this._codeBlockIsSeparate = value
  }

  public set codeBlockSeparateWidth(value: number) {
    this._codeBlockSeparateWidth = value
  }

  public set codeBlockSeparateIsBottom(value: boolean) {
    this._codeBlockSeparateIsBottom = value
  }

  constructor() {
    super()
  }
}
