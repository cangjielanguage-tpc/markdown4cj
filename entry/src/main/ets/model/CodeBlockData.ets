import { BaseMDData } from "./BaseMDData"

export class CodeBlockData extends BaseMDData {
  _codeBlockIsDark: boolean = false // 代码深浅色模式
  _codeBlockIsCodeFormat: boolean = false // 是否格式化围栏代码块内容
  _codeBlockUseTab: boolean = false // codeformat是否用制表符
  _codeBlockIndentWidth: Length = 4 // codeformat空格缩进数量
  _codeBlockParserSync: boolean = false // 围栏代码块代码高亮是否同步解析
  _codeBlockBackgroundColor: ResourceColor | undefined = undefined // 代码块背景颜色
  _codeBlockMarginTop: Length = 0.0 // 代码块上外边距
  _codeBlockMarginRight: Length = 0.0 // 代码块右外边距
  _codeBlockMarginBottom: Length = 0.0 // 代码块下外边距
  _codeBlockMarginLeft: Length = 0.0 // 代码块左外边距
  _codeBlockPaddingTop: Length = 0.0 // 代码块上内边距
  _codeBlockPaddingRight: Length = 8.0 // 代码块右内边距
  _codeBlockPaddingBottom: Length = 8.0 // 代码块下内边距
  _codeBlockPaddingLeft: Length = 0.0 // 代码块左内边距
  _codeBlockBorderStyle: BorderStyle = BorderStyle.Solid // 代码块边框样式
  _codeBlockBorderWidth: Length = 0.0 // 代码块边框宽度
  _codeBlockBorderColor: ResourceColor | undefined = undefined // 代码块边框颜色
  _codeBlockRadiusTopLeft: Length = 8.0 // 代码块边框左上圆角
  _codeBlockRadiusTopRight: Length = 8.0 // 代码块边框右上圆角
  _codeBlockRadiusBottomLeft: Length = 8.0 // 代码块边框左下圆角
  _codeBlockRadiusBottomRight: Length = 8.0 // 代码块边框右下圆角
  _codeBlockTitleLayoutMarginBottom: Length = 0.0 // 代码块类型和代码块内容间距
  _codeBlockTypeTextMarginLeft: Length = 8.0 // 代码块类型左边距
  _codeBlockTypeText: string = '' // 代码块没有代码类型时默认显示文本
  _codeBlockTypeTextFontColor: ResourceColor | undefined = undefined // 代码块类型文本颜色
  _codeBlockTypeTextFontSize: number | string | Resource | undefined = undefined // 代码块类型文本尺寸
  _codeBlockTypeTextFontStyle: FontStyle | undefined = undefined // 代码块类型文本字体样式
  _codeBlockTypeTextFontWeight: FontWeight | undefined = undefined // 代码块类型文本字体粗细
  _codeBlockTypeTextFontFamily: string | undefined = undefined // 代码块类型文本字体
  _codeBlockTypeTextLineHeight: number | string | Resource | undefined = undefined // 代码块类型文本行高
  _codeBlockCopyFullScreenSpacing: number = 5.0 // 代码块代码复制和代码全屏间距
  _codeBlockCopyButtonIsShow: boolean = true // 代码块代码复制按钮是否显示
  _codeBlockCopyTextIsShow: boolean = true // 代码块代码复制文本是否显示
  _codeBlockCopyIcon: Resource | undefined = undefined // 代码块代码复制按钮默认图标
  _codeBlockCopyIconWidth: Length = 24.0 // 代码块代码复制图标宽度
  _codeBlockCopyIconHeight: Length = 24.0 // 代码块代码复制图标高度
  _codeBlockCopyIconTextSpacing: number = 5.0 // 代码块代码复制图标和文本间距
  _codeBlockCopyText: string = '复制代码' // 代码块代码复制默认文本内容
  _codeBlockCopyTextFontColor: ResourceColor | undefined = undefined // 代码块代码复制文本颜色
  _codeBlockCopyTextFontSize: number | string | Resource | undefined = undefined // 代码块代码复制文本尺寸
  _codeBlockCopyTextFontStyle: FontStyle | undefined = undefined // 代码块代码复制文本字体样式
  _codeBlockCopyTextFontWeight: FontWeight | undefined = undefined // 代码块代码复制文本字体粗细
  _codeBlockCopyTextFontFamily: string | undefined = undefined // 代码块代码复制文本字体
  _codeBlockCopyTextLineHeight: number | string | Resource | undefined = undefined // 代码块代码复制文本行高
  _codeBlockFullScreenButtonIsShow: boolean = true // 代码块代码全屏按钮是否显示
  _codeBlockFullScreenTextIsShow: boolean = true // 代码块代码全屏文本是否显示
  _codeBlockFullScreenIcon: Resource | undefined = undefined // 代码块代码全屏按钮默认图标
  _codeBlockFullScreenIconWidth: Length = 24.0 // 代码块代码全屏图标宽度
  _codeBlockFullScreenIconHeight: Length = 24.0 // 代码块代码全屏图标高度
  _codeBlockFullScreenIconTextSpacing: number = 5.0 // 代码块代码全屏图标和文本间距
  _codeBlockFullScreenText: string = '全屏代码' // 代码块代码全屏默认文本内容
  _codeBlockFullScreenTextFontColor: ResourceColor | undefined = undefined // 代码块代码全屏文本颜色
  _codeBlockFullScreenTextFontSize: number | string | Resource | undefined = undefined // 代码块代码全屏文本尺寸
  _codeBlockFullScreenTextFontStyle: FontStyle | undefined = undefined // 代码块代码全屏文本字体样式
  _codeBlockFullScreenTextFontWeight: FontWeight | undefined = undefined // 代码块代码全屏文本字体粗细
  _codeBlockFullScreenTextFontFamily: string | undefined = undefined // 代码块代码全屏文本字体
  _codeBlockFullScreenTextLineHeight: number | string | Resource | undefined = undefined // 代码块代码全屏文本行高
  _codeBlockLineNumberIsShow: boolean = false // 代码块代码行号是否显示
  _codeBlockLineNumberTextPaddingLeft: Length = 8.0 // 代码块代码行号左内边距
  _codeBlockLineNumberTextFontColor: ResourceColor | undefined = undefined // 代码块代码行号文本颜色
  _codeBlockLineNumberTextFontSize: number | string | Resource | undefined = undefined // 代码块代码行号文本尺寸
  _codeBlockLineNumberTextFontStyle: FontStyle | undefined = undefined // 代码块代码行号文本字体样式
  _codeBlockLineNumberTextFontWeight: FontWeight | undefined = undefined // 代码块代码行号文本字体粗细
  _codeBlockLineNumberTextFontFamily: string | undefined = undefined // 代码块代码行号文本字体
  _codeBlockLineNumberTextLineHeight: number | string | Resource | undefined = undefined // 代码块代码行号文本行高
  _codeBlockDividerColor: ResourceColor | undefined = undefined // 代码块代码行号和代码块中间分割线颜色
  _codeBlockDividerStrokeWidth: Length = 0.5 // 代码块代码行号和代码块中间分割线宽度
  _codeBlockLineNumberDividerSpacing: number = 8.0 // 代码块代码行号和分割线间距
  _codeBlockTextFontColor: ResourceColor | undefined = undefined // 代码块文本颜色
  _codeBlockTextMarginRight: Length = 8.0 // 代码块代码文本右外边距
  _codeBlockTextMarginLeft: Length = 8.0 // 代码块代码文本左外边距
  _codeBlockTextFontSize: number | string | Resource = 13.0 // 代码块文本尺寸
  _codeBlockTextFontStyle: FontStyle = FontStyle.Normal // 代码块文本字体样式
  _codeBlockTextFontWeight: number | FontWeight = FontWeight.Normal // 代码块文本字体粗细
  _codeBlockTextFontFamily: string | Resource = 'HarmonyOS Sans' // 代码块文本字体
  _codeBlockTextLineHeight: number | string | Resource = 22.0 // 代码块文本行高
  _codeBlockTextLetterSpacing: number = 0.0 // 代码块文本字符间距

  constructor() {
    super()
  }
}
