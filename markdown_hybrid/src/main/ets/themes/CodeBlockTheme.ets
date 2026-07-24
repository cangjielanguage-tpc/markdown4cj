import { MarkdownMarginOptions, MarkdownPaddingOptions, MarkdownRadiusOptions } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-代码块样式
 */
export class CodeBlockTheme {
  /**
   * 代码深浅色模式
   */
  private codeBlockIsDark?: boolean = undefined

  /**
   * 是否格式化围栏代码块内容
   */
  private codeBlockIsCodeFormat?: boolean = undefined

  /**
   * codeformat是否用制表符
   */
  private codeBlockUseTab?: boolean = undefined

  /**
   * codeformat空格缩进数量
   */
  private codeBlockIndentWidth?: number = undefined

  /**
   * 围栏代码块代码高亮是否同步解析
   */
  private codeBlockParserSync?: boolean = undefined

  /**
   * 代码块背景颜色
   */
  private codeBlockBackgroundColor?: number = undefined

  /**
   * 代码块上外边距
   */
  private codeBlockMarginTop?: number = undefined

  /**
   * 代码块右外边距
   */
  private codeBlockMarginRight?: number = undefined

  /**
   * 代码块下外边距
   */
  private codeBlockMarginBottom?: number = undefined

  /**
   * 代码块左外边距
   */
  private codeBlockMarginLeft?: number = undefined

  /**
   * 代码块上内边距
   */
  private codeBlockPaddingTop?: number = undefined

  /**
   * 代码块右内边距
   */
  private codeBlockPaddingRight?: number = undefined

  /**
   * 代码块下内边距
   */
  private codeBlockPaddingBottom?: number = undefined

  /**
   * 代码块左内边距
   */
  private codeBlockPaddingLeft?: number = undefined

  /**
   * 代码块边框样式
   */
  private codeBlockBorderStyle?: BorderStyle = undefined

  /**
   * 代码块边框宽度
   */
  private codeBlockBorderWidth?: number = undefined

  /**
   * 代码块边框颜色
   */
  private codeBlockBorderColor?: number = undefined

  /**
   * 代码块边框左上圆角
   */
  private codeBlockRadiusTopLeft?: number = undefined

  /**
   * 代码块边框右上圆角
   */
  private codeBlockRadiusTopRight?: number = undefined

  /**
   * 代码块边框左下圆角
   */
  private codeBlockRadiusBottomLeft?: number = undefined

  /**
   * 代码块边框右下圆角
   */
  private codeBlockRadiusBottomRight?: number = undefined

  /**
   * 代码块类型和代码块内容间距
   */
  private codeBlockTitleLayoutMarginBottom?: number = undefined

  /**
   * 代码块类型左边距
   */
  private codeBlockTypeTextMarginLeft?: number = undefined

  /**
   * 代码块没有代码类型时默认显示文本
   */
  private codeBlockTypeText?: string = undefined

  /**
   * 代码块类型文本颜色
   */
  private codeBlockTypeTextFontColor?: number = undefined

  /**
   * 代码块类型文本尺寸
   */
  private codeBlockTypeTextFontSize?: number = undefined

  /**
   * 代码块类型文本字体样式
   */
  private codeBlockTypeTextFontStyle?: FontStyle = undefined

  /**
   * 代码块类型文本字体粗细
   */
  private codeBlockTypeTextFontWeight?: FontWeight = undefined

  /**
   * 代码块类型文本字体
   */
  private codeBlockTypeTextFontFamily?: string = undefined

  /**
   * 代码块类型文本行高
   */
  private codeBlockTypeTextLineHeight?: number = undefined

  /**
   * 代码块代码复制和代码全屏间距
   */
  private codeBlockCopyFullScreenSpacing?: number = undefined

  /**
   * 代码块代码复制按钮是否显示
   */
  private codeBlockCopyButtonIsShow?: boolean = undefined

  /**
   * 代码块代码复制文本是否显示
   */
  private codeBlockCopyTextIsShow?: boolean = undefined

  /**
   * 代码块代码复制按钮默认图标
   */
  private codeBlockCopyIcon?: Resource = undefined

  /**
   * 代码块代码复制图标宽度
   */
  private codeBlockCopyIconWidth?: number = undefined

  /**
   * 代码块代码复制图标高度
   */
  private codeBlockCopyIconHeight?: number = undefined

  /**
   * 代码块代码复制图标和文本间距
   */
  private codeBlockCopyIconTextSpacing?: number = undefined

  /**
   * 代码块代码复制默认文本内容
   */
  private codeBlockCopyText?: string = undefined

  /**
   * 代码块代码复制文本颜色
   */
  private codeBlockCopyTextFontColor?: number = undefined

  /**
   * 代码块代码复制文本尺寸
   */
  private codeBlockCopyTextFontSize?: number = undefined

  /**
   * 代码块代码复制文本字体样式
   */
  private codeBlockCopyTextFontStyle?: FontStyle = undefined

  /**
   * 代码块代码复制文本字体粗细
   */
  private codeBlockCopyTextFontWeight?: FontWeight = undefined

  /**
   * 代码块代码复制文本字体
   */
  private codeBlockCopyTextFontFamily?: string = undefined

  /**
   * 代码块代码复制文本行高
   */
  private codeBlockCopyTextLineHeight?: number = undefined

  /**
   * 代码块代码全屏按钮是否显示
   */
  private codeBlockFullScreenButtonIsShow?: boolean = undefined

  /**
   * 代码块代码全屏文本是否显示
   */
  private codeBlockFullScreenTextIsShow?: boolean = undefined

  /**
   * 代码块代码全屏按钮默认图标
   */
  private codeBlockFullScreenIcon?: Resource = undefined

  /**
   * 代码块代码全屏图标宽度
   */
  private codeBlockFullScreenIconWidth?: number = undefined

  /**
   * 代码块代码全屏图标高度
   */
  private codeBlockFullScreenIconHeight?: number = undefined

  /**
   * 代码块代码全屏图标和文本间距
   */
  private codeBlockFullScreenIconTextSpacing?: number = undefined

  /**
   * 代码块代码全屏默认文本内容
   */
  private codeBlockFullScreenText?: string = undefined

  /**
   * 代码块代码全屏文本颜色
   */
  private codeBlockFullScreenTextFontColor?: number = undefined

  /**
   * 代码块代码全屏文本尺寸
   */
  private codeBlockFullScreenTextFontSize?: number = undefined

  /**
   * 代码块代码全屏文本字体样式
   */
  private codeBlockFullScreenTextFontStyle?: FontStyle = undefined

  /**
   * 代码块代码全屏文本字体粗细
   */
  private codeBlockFullScreenTextFontWeight?: FontWeight = undefined

  /**
   * 代码块代码全屏文本字体
   */
  private codeBlockFullScreenTextFontFamily?: string = undefined

  /**
   * 代码块代码全屏文本行高
   */
  private codeBlockFullScreenTextLineHeight?: number = undefined

  /**
   * 代码块代码行号是否显示
   */
  private codeBlockLineNumberIsShow?: boolean = undefined

  /**
   * 代码块代码行号左内边距
   */
  private codeBlockLineNumberTextPaddingLeft?: number = undefined

  /**
   * 代码块代码行号文本颜色
   */
  private codeBlockLineNumberTextFontColor?: number = undefined

  /**
   * 代码块代码行号文本尺寸
   */
  private codeBlockLineNumberTextFontSize?: number = undefined

  /**
   * 代码块代码行号文本字体样式
   */
  private codeBlockLineNumberTextFontStyle?: FontStyle = undefined

  /**
   * 代码块代码行号文本字体粗细
   */
  private codeBlockLineNumberTextFontWeight?: FontWeight = undefined

  /**
   * 代码块代码行号文本字体
   */
  private codeBlockLineNumberTextFontFamily?: string = undefined

  /**
   * 代码块代码行号文本行高
   */
  private codeBlockLineNumberTextLineHeight?: number = undefined

  /**
   * 代码块代码行号和代码块中间分割线颜色
   */
  private codeBlockDividerColor?: number = undefined

  /**
   * 代码块代码行号和代码块中间分割线宽度
   */
  private codeBlockDividerStrokeWidth?: number = undefined

  /**
   * 代码块代码行号和分割线间距
   */
  private codeBlockLineNumberDividerSpacing?: number = undefined

  /**
   * 代码块文本颜色
   */
  private codeBlockTextFontColor?: number = undefined

  /**
   * 代码块代码文本右外边距
   */
  private codeBlockTextMarginRight?: number = undefined

  /**
   * 代码块代码文本左外边距
   */
  private codeBlockTextMarginLeft?: number = undefined

  /**
   * 代码块文本尺寸
   */
  private codeBlockTextFontSize?: number = undefined

  /**
   * 代码块文本字体样式
   */
  private codeBlockTextFontStyle?: FontStyle = undefined

  /**
   * 代码块文本字体粗细
   */
  private codeBlockTextFontWeight?: FontWeight = undefined

  /**
   * 代码块文本字体
   */
  private codeBlockTextFontFamily?: string = undefined

  /**
   * 代码块文本行高
   */
  private codeBlockTextLineHeight?: number = undefined

  /**
   * 代码块文本字符间距
   */
  private codeBlockTextLetterSpacing?: number = undefined

  /**
   * 组合代码块未选中标题字体大小
   */
  private codeBlockListTitleTextSize?: number = undefined

  /**
   * 组合代码块选中标题字体大小
   */
  private codeBlockListTitleSelectTextSize?: number = undefined

  /**
   * 组合代码块选中标题文本颜色
   */
  private codeBlockListTitleSelectTextColor?: number = undefined

  /**
   * 组合代码块未选中标题文本颜色
   */
  private codeBlockListTitleUnselectTextColor?: number = undefined

  /**
   * 组合代码块选中标题背景颜色
   */
  private codeBlockListTitleSelectBackgroundColor?: number = undefined

  /**
   * 组合代码块未选中标题背景颜色
   */
  private codeBlockListTitleUnselectBackgroundColor?: number = undefined

  /**
   * 是否单独代码块显示
   */
  private codeBlockIsSeparate?: boolean = undefined

  /**
   * 单独代码块行号宽度
   */
  private codeBlockSeparateWidth?: number = undefined

  /**
   * 单独代码块是否居底显示
   */
  private codeBlockSeparateIsBottom?: boolean = undefined

  /**
   * 设置代码块深浅色
   *
   * @param isDark 是否是深色 - true：深色；false：浅色。默认false
   */
  setCodeBlockIsDark(isDark: boolean): CodeBlockTheme {
    this.codeBlockIsDark = isDark
    return this
  }

  /**
   * 设置是否格式化围栏代码块内容
   *
   * @param isCodeFormat 是否格式化围栏代码块内容
   */
  setCodeBlockIsCodeFormat(isCodeFormat: boolean): CodeBlockTheme {
    this.codeBlockIsCodeFormat = isCodeFormat
    return this
  }

  /**
   * 设置codeformat是否用制表符
   *
   * @param useTab 是否用制表符
   */
  setCodeBlockUseTab(useTab: boolean): CodeBlockTheme {
    this.codeBlockUseTab = useTab
    return this
  }

  /**
   * 设置codeformat空格缩进数量
   *
   * @param indentWidth 空格缩进数量
   */
  setCodeBlockIndentWidth(indentWidth: number): CodeBlockTheme {
    this.codeBlockIndentWidth = indentWidth
    return this
  }

  /**
   * 设置围栏代码块代码高亮是否同步解析
   *
   * @param parserSync 是否同步解析
   */
  setCodeBlockParserSync(parserSync: boolean): CodeBlockTheme {
    this.codeBlockParserSync = parserSync
    return this
  }

  /**
   * 设置代码块背景颜色
   *
   * @param color 代码块背景颜色
   */
  setCodeBlockBackgroundColor(color: number): CodeBlockTheme {
    this.codeBlockBackgroundColor = color
    return this
  }

  /**
   * 代码块设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setCodeBlockMargin(options: MarkdownMarginOptions | number): CodeBlockTheme {
    if (typeof options === 'number') {
      this.codeBlockMarginTop = options
      this.codeBlockMarginRight = options
      this.codeBlockMarginBottom = options
      this.codeBlockMarginLeft = options
    } else {
      if (options.top !== undefined) {
        this.codeBlockMarginTop = options.top
      }
      if (options.right !== undefined) {
        this.codeBlockMarginRight = options.right
      }
      if (options.bottom !== undefined) {
        this.codeBlockMarginBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.codeBlockMarginLeft = options.left
      }
    }
    return this
  }

  /**
   * 代码块设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setCodeBlockPadding(options: MarkdownPaddingOptions | number): CodeBlockTheme {
    if (typeof options === 'number') {
      this.codeBlockPaddingTop = options
      this.codeBlockPaddingRight = options
      this.codeBlockPaddingBottom = options
      this.codeBlockPaddingLeft = options
    } else {
      if (options.top !== undefined) {
        this.codeBlockPaddingTop = options.top
      }
      if (options.right !== undefined) {
        this.codeBlockPaddingRight = options.right
      }
      if (options.bottom !== undefined) {
        this.codeBlockPaddingBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.codeBlockPaddingLeft = options.left
      }
    }
    return this
  }

  /**
   * 设置代码块边框样式
   *
   * @param borderStyle 代码块边框样式
   */
  setCodeBlockBorderStyle(borderStyle: BorderStyle): CodeBlockTheme {
    this.codeBlockBorderStyle = borderStyle
    return this
  }

  /**
   * 设置代码块边框宽度
   *
   * @param borderWidth 代码块边框宽度
   */
  setCodeBlockBorderWidth(borderWidth: number): CodeBlockTheme {
    this.codeBlockBorderWidth = borderWidth
    return this
  }

  /**
   * 设置代码块边框颜色
   *
   * @param borderColor 代码块边框颜色
   */
  setCodeBlockBorderColor(borderColor: number): CodeBlockTheme {
    this.codeBlockBorderColor = borderColor
    return this
  }

  /**
   * 代码块设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setCodeBlockRadius(options: MarkdownRadiusOptions | number): CodeBlockTheme {
    if (typeof options === 'number') {
      this.codeBlockRadiusTopLeft = options
      this.codeBlockRadiusTopRight = options
      this.codeBlockRadiusBottomLeft = options
      this.codeBlockRadiusBottomRight = options
    } else {
      if (options.topLeft !== undefined) {
        this.codeBlockRadiusTopLeft = options.topLeft
      }
      if (options.topRight !== undefined) {
        this.codeBlockRadiusTopRight = options.topRight
      }
      if (options.bottomLeft !== undefined) {
        this.codeBlockRadiusBottomLeft = options.bottomLeft
      }
      if (options.bottomRight !== undefined) {
        this.codeBlockRadiusBottomRight = options.bottomRight
      }
    }
    return this
  }

  /**
   * 设置代码块类型和代码块内容间距
   *
   * @param marginBottom 代码块类型和代码块内容间距
   */
  setCodeBlockTitleLayoutMarginBottom(marginBottom: number): CodeBlockTheme {
    this.codeBlockTitleLayoutMarginBottom = marginBottom
    return this
  }

  /**
   * 设置代码块类型左边距
   *
   * @param marginLeft 代码块类型左边距
   */
  setCodeBlockTypeTextMarginLeft(marginLeft: number): CodeBlockTheme {
    this.codeBlockTypeTextMarginLeft = marginLeft
    return this
  }

  /**
   * 设置代码块没有代码类型时默认显示文本
   *
   * @param text 默认显示文本
   */
  setCodeBlockTypeText(text: string): CodeBlockTheme {
    this.codeBlockTypeText = text
    return this
  }

  /**
   * 设置代码块类型文本颜色
   *
   * @param color 代码块类型文本颜色
   */
  setCodeBlockTypeTextFontColor(color: number): CodeBlockTheme {
    this.codeBlockTypeTextFontColor = color
    return this
  }

  /**
   * 设置代码块类型文本尺寸
   *
   * @param size 代码块类型文本尺寸
   */
  setCodeBlockTypeTextFontSize(size: number): CodeBlockTheme {
    this.codeBlockTypeTextFontSize = size
    return this
  }

  /**
   * 设置代码块类型文本字体样式
   *
   * @param style 代码块类型文本字体样式
   */
  setCodeBlockTypeTextFontStyle(style: FontStyle): CodeBlockTheme {
    this.codeBlockTypeTextFontStyle = style
    return this
  }

  /**
   * 设置代码块类型文本字体粗细
   *
   * @param weight 代码块类型文本字体粗细
   */
  setCodeBlockTypeTextFontWeight(weight: FontWeight): CodeBlockTheme {
    this.codeBlockTypeTextFontWeight = weight
    return this
  }

  /**
   * 设置代码块类型文本字体
   *
   * @param family 代码块类型文本字体
   */
  setCodeBlockTypeTextFontFamily(family: string): CodeBlockTheme {
    this.codeBlockTypeTextFontFamily = family
    return this
  }

  /**
   * 设置代码块类型文本行高
   *
   * @param height 代码块类型文本行高
   */
  setCodeBlockTypeTextLineHeight(height: number): CodeBlockTheme {
    this.codeBlockTypeTextLineHeight = height
    return this
  }

  /**
   * 设置代码块代码复制和代码全屏间距
   *
   * @param spacing 代码块代码复制和代码全屏间距
   */
  setCodeBlockCopyFullScreenSpacing(spacing: number): CodeBlockTheme {
    this.codeBlockCopyFullScreenSpacing = spacing
    return this
  }

  /**
   * 设置代码块代码复制按钮是否显示
   *
   * @param isShow 是否显示
   */
  setCodeBlockCopyButtonIsShow(isShow: boolean): CodeBlockTheme {
    this.codeBlockCopyButtonIsShow = isShow
    return this
  }

  /**
   * 设置代码块代码复制文本是否显示
   *
   * @param isShow 是否显示
   */
  setCodeBlockCopyTextIsShow(isShow: boolean): CodeBlockTheme {
    this.codeBlockCopyTextIsShow = isShow
    return this
  }

  /**
   * 设置代码块代码复制按钮默认图标
   *
   * @param icon 默认图标
   */
  setCodeBlockCopyIcon(icon: Resource): CodeBlockTheme {
    this.codeBlockCopyIcon = icon
    return this
  }

  /**
   * 设置代码块代码复制图标宽度
   *
   * @param width 图标宽度
   */
  setCodeBlockCopyIconWidth(width: number): CodeBlockTheme {
    this.codeBlockCopyIconWidth = width
    return this
  }

  /**
   * 设置代码块代码复制图标高度
   *
   * @param height 图标高度
   */
  setCodeBlockCopyIconHeight(height: number): CodeBlockTheme {
    this.codeBlockCopyIconHeight = height
    return this
  }

  /**
   * 设置代码块代码复制图标和文本间距
   *
   * @param spacing 代码块代码复制图标和文本间距
   */
  setCodeBlockCopyIconTextSpacing(spacing: number): CodeBlockTheme {
    this.codeBlockCopyIconTextSpacing = spacing
    return this
  }

  /**
   * 设置代码块代码复制默认文本内容
   *
   * @param text 默认文本内容
   */
  setCodeBlockCopyText(text: string): CodeBlockTheme {
    this.codeBlockCopyText = text
    return this
  }

  /**
   * 设置代码块代码复制文本颜色
   *
   * @param color 代码块代码复制文本颜色
   */
  setCodeBlockCopyTextFontColor(color: number): CodeBlockTheme {
    this.codeBlockCopyTextFontColor = color
    return this
  }

  /**
   * 设置代码块代码复制文本尺寸
   *
   * @param size 代码块代码复制文本尺寸
   */
  setCodeBlockCopyTextFontSize(size: number): CodeBlockTheme {
    this.codeBlockCopyTextFontSize = size
    return this
  }

  /**
   * 设置代码块代码复制文本字体样式
   *
   * @param style 代码块代码复制文本字体样式
   */
  setCodeBlockCopyTextFontStyle(style: FontStyle): CodeBlockTheme {
    this.codeBlockCopyTextFontStyle = style
    return this
  }

  /**
   * 设置代码块代码复制文本字体粗细
   *
   * @param weight 代码块代码复制文本字体粗细
   */
  setCodeBlockCopyTextFontWeight(weight: FontWeight): CodeBlockTheme {
    this.codeBlockCopyTextFontWeight = weight
    return this
  }

  /**
   * 设置代码块代码复制文本字体
   *
   * @param family 代码块代码复制文本字体
   */
  setCodeBlockCopyTextFontFamily(family: string): CodeBlockTheme {
    this.codeBlockCopyTextFontFamily = family
    return this
  }

  /**
   * 设置代码块代码复制文本行高
   *
   * @param height 代码块代码复制文本行高
   */
  setCodeBlockCopyTextLineHeight(height: number): CodeBlockTheme {
    this.codeBlockCopyTextLineHeight = height
    return this
  }

  /**
   * 设置代码块代码全屏按钮是否显示
   *
   * @param isShow 是否显示
   */
  setCodeBlockFullScreenButtonIsShow(isShow: boolean): CodeBlockTheme {
    this.codeBlockFullScreenButtonIsShow = isShow
    return this
  }

  /**
   * 设置代码块代码全屏文本是否显示
   *
   * @param isShow 是否显示
   */
  setCodeBlockFullScreenTextIsShow(isShow: boolean): CodeBlockTheme {
    this.codeBlockFullScreenTextIsShow = isShow
    return this
  }

  /**
   * 设置代码块代码全屏按钮默认图标
   *
   * @param icon 默认图标
   */
  setCodeBlockFullScreenIcon(icon: Resource): CodeBlockTheme {
    this.codeBlockFullScreenIcon = icon
    return this
  }

  /**
   * 设置代码块代码全屏图标宽度
   *
   * @param width 图标宽度
   */
  setCodeBlockFullScreenIconWidth(width: number): CodeBlockTheme {
    this.codeBlockFullScreenIconWidth = width
    return this
  }

  /**
   * 设置代码块代码全屏图标高度
   *
   * @param height 图标高度
   */
  setCodeBlockFullScreenIconHeight(height: number): CodeBlockTheme {
    this.codeBlockFullScreenIconHeight = height
    return this
  }

  /**
   * 设置代码块代码全屏图标和文本间距
   *
   * @param spacing 代码块代码全屏图标和文本间距
   */
  setCodeBlockFullScreenIconTextSpacing(spacing: number): CodeBlockTheme {
    this.codeBlockFullScreenIconTextSpacing = spacing
    return this
  }

  /**
   * 设置代码块代码全屏默认文本内容
   *
   * @param text 默认文本内容
   */
  setCodeBlockFullScreenText(text: string): CodeBlockTheme {
    this.codeBlockFullScreenText = text
    return this
  }

  /**
   * 设置代码块代码全屏文本颜色
   *
   * @param color 代码块代码全屏文本颜色
   */
  setCodeBlockFullScreenTextFontColor(color: number): CodeBlockTheme {
    this.codeBlockFullScreenTextFontColor = color
    return this
  }

  /**
   * 设置代码块代码全屏文本尺寸
   *
   * @param size 代码块代码全屏文本尺寸
   */
  setCodeBlockFullScreenTextFontSize(size: number): CodeBlockTheme {
    this.codeBlockFullScreenTextFontSize = size
    return this
  }

  /**
   * 设置代码块代码全屏文本字体样式
   *
   * @param style 代码块代码全屏文本字体样式
   */
  setCodeBlockFullScreenTextFontStyle(style: FontStyle): CodeBlockTheme {
    this.codeBlockFullScreenTextFontStyle = style
    return this
  }

  /**
   * 设置代码块代码全屏文本字体粗细
   *
   * @param weight 代码块代码全屏文本字体粗细
   */
  setCodeBlockFullScreenTextFontWeight(weight: FontWeight): CodeBlockTheme {
    this.codeBlockFullScreenTextFontWeight = weight
    return this
  }

  /**
   * 设置代码块代码全屏文本字体
   *
   * @param family 代码块代码全屏文本字体
   */
  setCodeBlockFullScreenTextFontFamily(family: string): CodeBlockTheme {
    this.codeBlockFullScreenTextFontFamily = family
    return this
  }

  /**
   * 设置代码块代码全屏文本行高
   *
   * @param height 代码块代码全屏文本行高
   */
  setCodeBlockFullScreenTextLineHeight(height: number): CodeBlockTheme {
    this.codeBlockFullScreenTextLineHeight = height
    return this
  }

  /**
   * 设置代码块代码行号是否显示
   *
   * @param isShow 是否显示
   */
  setCodeBlockLineNumberIsShow(isShow: boolean): CodeBlockTheme {
    this.codeBlockLineNumberIsShow = isShow
    return this
  }

  /**
   * 设置代码块代码行号左内边距
   *
   * @param left 代码块代码行号左内边距
   */
  setCodeBlockLineNumberTextPaddingLeft(left: number): CodeBlockTheme {
    this.codeBlockLineNumberTextPaddingLeft = left
    return this
  }

  /**
   * 设置代码块代码行号文本颜色
   *
   * @param color 代码块代码行号文本颜色
   */
  setCodeBlockLineNumberTextFontColor(color: number): CodeBlockTheme {
    this.codeBlockLineNumberTextFontColor = color
    return this
  }

  /**
   * 设置代码块代码行号文本尺寸
   *
   * @param size 代码块代码行号文本尺寸
   */
  setCodeBlockLineNumberTextFontSize(size: number): CodeBlockTheme {
    this.codeBlockLineNumberTextFontSize = size
    return this
  }

  /**
   * 设置代码块代码行号文本字体样式
   *
   * @param style 代码块代码行号文本字体样式
   */
  setCodeBlockLineNumberTextFontStyle(style: FontStyle): CodeBlockTheme {
    this.codeBlockLineNumberTextFontStyle = style
    return this
  }

  /**
   * 设置代码块代码行号文本字体粗细
   *
   * @param weight 代码块代码行号文本字体粗细
   */
  setCodeBlockLineNumberTextFontWeight(weight: FontWeight): CodeBlockTheme {
    this.codeBlockLineNumberTextFontWeight = weight
    return this
  }

  /**
   * 设置代码块代码行号文本字体
   *
   * @param family 代码块代码行号文本字体
   */
  setCodeBlockLineNumberTextFontFamily(family: string): CodeBlockTheme {
    this.codeBlockLineNumberTextFontFamily = family
    return this
  }

  /**
   * 设置代码块代码行号文本行高
   *
   * @param height 代码块代码行号文本行高
   */
  setCodeBlockLineNumberTextLineHeight(height: number): CodeBlockTheme {
    this.codeBlockLineNumberTextLineHeight = height
    return this
  }

  /**
   * 设置代码块代码行号和代码块中间分割线颜色
   *
   * @param color 分割线颜色
   */
  setCodeBlockDividerColor(color: number): CodeBlockTheme {
    this.codeBlockDividerColor = color
    return this
  }

  /**
   * 设置代码块代码行号和代码块中间分割线宽度
   *
   * @param strokeWidth 分割线宽度
   */
  setCodeBlockDividerStrokeWidth(strokeWidth: number): CodeBlockTheme {
    this.codeBlockDividerStrokeWidth = strokeWidth
    return this
  }

  /**
   * 设置代码块代码行号和分割线间距
   *
   * @param spacing 代码块代码行号和分割线间距
   */
  setCodeBlockLineNumberDividerSpacing(spacing: number): CodeBlockTheme {
    this.codeBlockLineNumberDividerSpacing = spacing
    return this
  }

  /**
   * 设置代码块文本颜色
   *
   * @param color 代码块文本颜色
   */
  setCodeBlockTextFontColor(color: number): CodeBlockTheme {
    this.codeBlockTextFontColor = color
    return this
  }

  /**
   * 设置代码块代码文本右外边距
   *
   * @param marginRight 代码块代码文本右外边距
   */
  setCodeBlockTextMarginRight(marginRight: number): CodeBlockTheme {
    this.codeBlockTextMarginRight = marginRight
    return this
  }

  /**
   * 设置代码块代码文本左外边距
   *
   * @param marginLeft 代码块代码文本左外边距
   */
  setCodeBlockTextMarginLeft(marginLeft: number): CodeBlockTheme {
    this.codeBlockTextMarginLeft = marginLeft
    return this
  }

  /**
   * 设置代码块文本尺寸
   *
   * @param size 代码块文本尺寸
   */
  setCodeBlockTextFontSize(size: number): CodeBlockTheme {
    this.codeBlockTextFontSize = size
    return this
  }

  /**
   * 设置代码块文本字体样式
   *
   * @param style 代码块文本字体样式
   */
  setCodeBlockTextFontStyle(style: FontStyle): CodeBlockTheme {
    this.codeBlockTextFontStyle = style
    return this
  }

  /**
   * 设置代码块文本字体粗细
   *
   * @param weight 代码块文本字体粗细
   */
  setCodeBlockTextFontWeight(weight: FontWeight): CodeBlockTheme {
    this.codeBlockTextFontWeight = weight
    return this
  }

  /**
   * 设置代码块文本字体
   *
   * @param family 代码块文本字体
   */
  setCodeBlockTextFontFamily(family: string): CodeBlockTheme {
    this.codeBlockTextFontFamily = family
    return this
  }

  /**
   * 设置代码块文本行高
   *
   * @param height 代码块文本行高
   */
  setCodeBlockTextLineHeight(height: number): CodeBlockTheme {
    this.codeBlockTextLineHeight = height
    return this
  }

  /**
   * 设置代码块文本字符间距
   *
   * @param spacing 代码块文本字符间距
   */
  setCodeBlockTextLetterSpacing(spacing: number): CodeBlockTheme {
    this.codeBlockTextLetterSpacing = spacing
    return this
  }

  /**
   * 设置组合代码块未选中标题字体大小
   *
   * @param size 字体大小
   */
  setCodeBlockListTitleTextSize(size: number): CodeBlockTheme {
    this.codeBlockListTitleTextSize = size
    return this
  }

  /**
   * 设置组合代码块选中标题字体大小
   *
   * @param size 字体大小
   */
  setCodeBlockListTitleSelectTextSize(size: number): CodeBlockTheme {
    this.codeBlockListTitleSelectTextSize = size
    return this
  }

  /**
   * 设置组合代码块选中标题文本颜色
   *
   * @param color 文本颜色
   */
  setCodeBlockListTitleSelectTextColor(color: number): CodeBlockTheme {
    this.codeBlockListTitleSelectTextColor = color
    return this
  }

  /**
   * 设置组合代码块未选中标题文本颜色
   *
   * @param color 文本颜色
   */
  setCodeBlockListTitleUnselectTextColor(color: number): CodeBlockTheme {
    this.codeBlockListTitleUnselectTextColor = color
    return this
  }

  /**
   * 设置组合代码块选中标题背景颜色
   *
   * @param color 背景颜色
   */
  setCodeBlockListTitleSelectBackgroundColor(color: number): CodeBlockTheme {
    this.codeBlockListTitleSelectBackgroundColor = color
    return this
  }

  /**
   * 设置组合代码块未选中标题背景颜色
   *
   * @param color 背景颜色
   */
  setCodeBlockListTitleUnselectBackgroundColor(color: number): CodeBlockTheme {
    this.codeBlockListTitleUnselectBackgroundColor = color
    return this
  }

  /**
   * 设置是否单独代码块显示
   *
   * @param isSeparate 是否单独显示
   */
  setCodeBlockIsSeparate(isSeparate: boolean): CodeBlockTheme {
    this.codeBlockIsSeparate = isSeparate
    return this
  }

  /**
   * 设置单独代码块行号宽度
   *
   * @param width 行号宽度
   */
  setCodeBlockSeparateWidth(width: number): CodeBlockTheme {
    this.codeBlockSeparateWidth = width
    return this
  }

  /**
   * 设置单独代码块是否居底显示
   *
   * @param isBottom 是否居底
   */
  setCodeBlockSeparateIsBottom(isBottom: boolean): CodeBlockTheme {
    this.codeBlockSeparateIsBottom = isBottom
    return this
  }

  /**
   * 获取codeBlockIsDark
   *
   * @returns codeBlockIsDark
   */
  getCodeBlockIsDark(): boolean | undefined {
    return this.codeBlockIsDark
  }

  /**
   * 获取codeBlockIsCodeFormat
   *
   * @returns codeBlockIsCodeFormat
   */
  getCodeBlockIsCodeFormat(): boolean | undefined {
    return this.codeBlockIsCodeFormat
  }

  /**
   * 获取codeBlockUseTab
   *
   * @returns codeBlockUseTab
   */
  getCodeBlockUseTab(): boolean | undefined {
    return this.codeBlockUseTab
  }

  /**
   * 获取codeBlockIndentWidth
   *
   * @returns codeBlockIndentWidth
   */
  getCodeBlockIndentWidth(): number | undefined {
    return this.codeBlockIndentWidth
  }

  /**
   * 获取codeBlockParserSync
   *
   * @returns codeBlockParserSync
   */
  getCodeBlockParserSync(): boolean | undefined {
    return this.codeBlockParserSync
  }

  /**
   * 获取codeBlockBackgroundColor
   *
   * @returns codeBlockBackgroundColor
   */
  getCodeBlockBackgroundColor(): number | undefined {
    return this.codeBlockBackgroundColor
  }

  /**
   * 获取codeBlockMarginTop
   *
   * @returns codeBlockMarginTop
   */
  getCodeBlockMarginTop(): number | undefined {
    return this.codeBlockMarginTop
  }

  /**
   * 获取codeBlockMarginRight
   *
   * @returns codeBlockMarginRight
   */
  getCodeBlockMarginRight(): number | undefined {
    return this.codeBlockMarginRight
  }

  /**
   * 获取codeBlockMarginBottom
   *
   * @returns codeBlockMarginBottom
   */
  getCodeBlockMarginBottom(): number | undefined {
    return this.codeBlockMarginBottom
  }

  /**
   * 获取codeBlockMarginLeft
   *
   * @returns codeBlockMarginLeft
   */
  getCodeBlockMarginLeft(): number | undefined {
    return this.codeBlockMarginLeft
  }

  /**
   * 获取codeBlockPaddingTop
   *
   * @returns codeBlockPaddingTop
   */
  getCodeBlockPaddingTop(): number | undefined {
    return this.codeBlockPaddingTop
  }

  /**
   * 获取codeBlockPaddingRight
   *
   * @returns codeBlockPaddingRight
   */
  getCodeBlockPaddingRight(): number | undefined {
    return this.codeBlockPaddingRight
  }

  /**
   * 获取codeBlockPaddingBottom
   *
   * @returns codeBlockPaddingBottom
   */
  getCodeBlockPaddingBottom(): number | undefined {
    return this.codeBlockPaddingBottom
  }

  /**
   * 获取codeBlockPaddingLeft
   *
   * @returns codeBlockPaddingLeft
   */
  getCodeBlockPaddingLeft(): number | undefined {
    return this.codeBlockPaddingLeft
  }

  /**
   * 获取codeBlockBorderStyle
   *
   * @returns codeBlockBorderStyle
   */
  getCodeBlockBorderStyle(): BorderStyle | undefined {
    return this.codeBlockBorderStyle
  }

  /**
   * 获取codeBlockBorderWidth
   *
   * @returns codeBlockBorderWidth
   */
  getCodeBlockBorderWidth(): number | undefined {
    return this.codeBlockBorderWidth
  }

  /**
   * 获取codeBlockBorderColor
   *
   * @returns codeBlockBorderColor
   */
  getCodeBlockBorderColor(): number | undefined {
    return this.codeBlockBorderColor
  }

  /**
   * 获取codeBlockRadiusTopLeft
   *
   * @returns codeBlockRadiusTopLeft
   */
  getCodeBlockRadiusTopLeft(): number | undefined {
    return this.codeBlockRadiusTopLeft
  }

  /**
   * 获取codeBlockRadiusTopRight
   *
   * @returns codeBlockRadiusTopRight
   */
  getCodeBlockRadiusTopRight(): number | undefined {
    return this.codeBlockRadiusTopRight
  }

  /**
   * 获取codeBlockRadiusBottomLeft
   *
   * @returns codeBlockRadiusBottomLeft
   */
  getCodeBlockRadiusBottomLeft(): number | undefined {
    return this.codeBlockRadiusBottomLeft
  }

  /**
   * 获取codeBlockRadiusBottomRight
   *
   * @returns codeBlockRadiusBottomRight
   */
  getCodeBlockRadiusBottomRight(): number | undefined {
    return this.codeBlockRadiusBottomRight
  }

  /**
   * 获取codeBlockTitleLayoutMarginBottom
   *
   * @returns codeBlockTitleLayoutMarginBottom
   */
  getCodeBlockTitleLayoutMarginBottom(): number | undefined {
    return this.codeBlockTitleLayoutMarginBottom
  }

  /**
   * 获取codeBlockTypeTextMarginLeft
   *
   * @returns codeBlockTypeTextMarginLeft
   */
  getCodeBlockTypeTextMarginLeft(): number | undefined {
    return this.codeBlockTypeTextMarginLeft
  }

  /**
   * 获取codeBlockTypeText
   *
   * @returns codeBlockTypeText
   */
  getCodeBlockTypeText(): string | undefined {
    return this.codeBlockTypeText
  }

  /**
   * 获取codeBlockTypeTextFontColor
   *
   * @returns codeBlockTypeTextFontColor
   */
  getCodeBlockTypeTextFontColor(): number | undefined {
    return this.codeBlockTypeTextFontColor
  }

  /**
   * 获取codeBlockTypeTextFontSize
   *
   * @returns codeBlockTypeTextFontSize
   */
  getCodeBlockTypeTextFontSize(): number | undefined {
    return this.codeBlockTypeTextFontSize
  }

  /**
   * 获取codeBlockTypeTextFontStyle
   *
   * @returns codeBlockTypeTextFontStyle
   */
  getCodeBlockTypeTextFontStyle(): FontStyle | undefined {
    return this.codeBlockTypeTextFontStyle
  }

  /**
   * 获取codeBlockTypeTextFontWeight
   *
   * @returns codeBlockTypeTextFontWeight
   */
  getCodeBlockTypeTextFontWeight(): FontWeight | undefined {
    return this.codeBlockTypeTextFontWeight
  }

  /**
   * 获取codeBlockTypeTextFontFamily
   *
   * @returns codeBlockTypeTextFontFamily
   */
  getCodeBlockTypeTextFontFamily(): string | undefined {
    return this.codeBlockTypeTextFontFamily
  }

  /**
   * 获取codeBlockTypeTextLineHeight
   *
   * @returns codeBlockTypeTextLineHeight
   */
  getCodeBlockTypeTextLineHeight(): number | undefined {
    return this.codeBlockTypeTextLineHeight
  }

  /**
   * 获取codeBlockCopyFullScreenSpacing
   *
   * @returns codeBlockCopyFullScreenSpacing
   */
  getCodeBlockCopyFullScreenSpacing(): number | undefined {
    return this.codeBlockCopyFullScreenSpacing
  }

  /**
   * 获取codeBlockCopyButtonIsShow
   *
   * @returns codeBlockCopyButtonIsShow
   */
  getCodeBlockCopyButtonIsShow(): boolean | undefined {
    return this.codeBlockCopyButtonIsShow
  }

  /**
   * 获取codeBlockCopyTextIsShow
   *
   * @returns codeBlockCopyTextIsShow
   */
  getCodeBlockCopyTextIsShow(): boolean | undefined {
    return this.codeBlockCopyTextIsShow
  }

  /**
   * 获取codeBlockCopyIcon
   *
   * @returns codeBlockCopyIcon
   */
  getCodeBlockCopyIcon(): Resource | undefined {
    return this.codeBlockCopyIcon
  }

  /**
   * 获取codeBlockCopyIconWidth
   *
   * @returns codeBlockCopyIconWidth
   */
  getCodeBlockCopyIconWidth(): number | undefined {
    return this.codeBlockCopyIconWidth
  }

  /**
   * 获取codeBlockCopyIconHeight
   *
   * @returns codeBlockCopyIconHeight
   */
  getCodeBlockCopyIconHeight(): number | undefined {
    return this.codeBlockCopyIconHeight
  }

  /**
   * 获取codeBlockCopyIconTextSpacing
   *
   * @returns codeBlockCopyIconTextSpacing
   */
  getCodeBlockCopyIconTextSpacing(): number | undefined {
    return this.codeBlockCopyIconTextSpacing
  }

  /**
   * 获取codeBlockCopyText
   *
   * @returns codeBlockCopyText
   */
  getCodeBlockCopyText(): string | undefined {
    return this.codeBlockCopyText
  }

  /**
   * 获取codeBlockCopyTextFontColor
   *
   * @returns codeBlockCopyTextFontColor
   */
  getCodeBlockCopyTextFontColor(): number | undefined {
    return this.codeBlockCopyTextFontColor
  }

  /**
   * 获取codeBlockCopyTextFontSize
   *
   * @returns codeBlockCopyTextFontSize
   */
  getCodeBlockCopyTextFontSize(): number | undefined {
    return this.codeBlockCopyTextFontSize
  }

  /**
   * 获取codeBlockCopyTextFontStyle
   *
   * @returns codeBlockCopyTextFontStyle
   */
  getCodeBlockCopyTextFontStyle(): FontStyle | undefined {
    return this.codeBlockCopyTextFontStyle
  }

  /**
   * 获取codeBlockCopyTextFontWeight
   *
   * @returns codeBlockCopyTextFontWeight
   */
  getCodeBlockCopyTextFontWeight(): FontWeight | undefined {
    return this.codeBlockCopyTextFontWeight
  }

  /**
   * 获取codeBlockCopyTextFontFamily
   *
   * @returns codeBlockCopyTextFontFamily
   */
  getCodeBlockCopyTextFontFamily(): string | undefined {
    return this.codeBlockCopyTextFontFamily
  }

  /**
   * 获取codeBlockCopyTextLineHeight
   *
   * @returns codeBlockCopyTextLineHeight
   */
  getCodeBlockCopyTextLineHeight(): number | undefined {
    return this.codeBlockCopyTextLineHeight
  }

  /**
   * 获取codeBlockFullScreenButtonIsShow
   *
   * @returns codeBlockFullScreenButtonIsShow
   */
  getCodeBlockFullScreenButtonIsShow(): boolean | undefined {
    return this.codeBlockFullScreenButtonIsShow
  }

  /**
   * 获取codeBlockFullScreenTextIsShow
   *
   * @returns codeBlockFullScreenTextIsShow
   */
  getCodeBlockFullScreenTextIsShow(): boolean | undefined {
    return this.codeBlockFullScreenTextIsShow
  }

  /**
   * 获取codeBlockFullScreenIcon
   *
   * @returns codeBlockFullScreenIcon
   */
  getCodeBlockFullScreenIcon(): Resource | undefined {
    return this.codeBlockFullScreenIcon
  }

  /**
   * 获取codeBlockFullScreenIconWidth
   *
   * @returns codeBlockFullScreenIconWidth
   */
  getCodeBlockFullScreenIconWidth(): number | undefined {
    return this.codeBlockFullScreenIconWidth
  }

  /**
   * 获取codeBlockFullScreenIconHeight
   *
   * @returns codeBlockFullScreenIconHeight
   */
  getCodeBlockFullScreenIconHeight(): number | undefined {
    return this.codeBlockFullScreenIconHeight
  }

  /**
   * 获取codeBlockFullScreenIconTextSpacing
   *
   * @returns codeBlockFullScreenIconTextSpacing
   */
  getCodeBlockFullScreenIconTextSpacing(): number | undefined {
    return this.codeBlockFullScreenIconTextSpacing
  }

  /**
   * 获取codeBlockFullScreenText
   *
   * @returns codeBlockFullScreenText
   */
  getCodeBlockFullScreenText(): string | undefined {
    return this.codeBlockFullScreenText
  }

  /**
   * 获取codeBlockFullScreenTextFontColor
   *
   * @returns codeBlockFullScreenTextFontColor
   */
  getCodeBlockFullScreenTextFontColor(): number | undefined {
    return this.codeBlockFullScreenTextFontColor
  }

  /**
   * 获取codeBlockFullScreenTextFontSize
   *
   * @returns codeBlockFullScreenTextFontSize
   */
  getCodeBlockFullScreenTextFontSize(): number | undefined {
    return this.codeBlockFullScreenTextFontSize
  }

  /**
   * 获取codeBlockFullScreenTextFontStyle
   *
   * @returns codeBlockFullScreenTextFontStyle
   */
  getCodeBlockFullScreenTextFontStyle(): FontStyle | undefined {
    return this.codeBlockFullScreenTextFontStyle
  }

  /**
   * 获取codeBlockFullScreenTextFontWeight
   *
   * @returns codeBlockFullScreenTextFontWeight
   */
  getCodeBlockFullScreenTextFontWeight(): FontWeight | undefined {
    return this.codeBlockFullScreenTextFontWeight
  }

  /**
   * 获取codeBlockFullScreenTextFontFamily
   *
   * @returns codeBlockFullScreenTextFontFamily
   */
  getCodeBlockFullScreenTextFontFamily(): string | undefined {
    return this.codeBlockFullScreenTextFontFamily
  }

  /**
   * 获取codeBlockFullScreenTextLineHeight
   *
   * @returns codeBlockFullScreenTextLineHeight
   */
  getCodeBlockFullScreenTextLineHeight(): number | undefined {
    return this.codeBlockFullScreenTextLineHeight
  }

  /**
   * 获取codeBlockLineNumberIsShow
   *
   * @returns codeBlockLineNumberIsShow
   */
  getCodeBlockLineNumberIsShow(): boolean | undefined {
    return this.codeBlockLineNumberIsShow
  }

  /**
   * 获取codeBlockLineNumberTextPaddingLeft
   *
   * @returns codeBlockLineNumberTextPaddingLeft
   */
  getCodeBlockLineNumberTextPaddingLeft(): number | undefined {
    return this.codeBlockLineNumberTextPaddingLeft
  }

  /**
   * 获取codeBlockLineNumberTextFontColor
   *
   * @returns codeBlockLineNumberTextFontColor
   */
  getCodeBlockLineNumberTextFontColor(): number | undefined {
    return this.codeBlockLineNumberTextFontColor
  }

  /**
   * 获取codeBlockLineNumberTextFontSize
   *
   * @returns codeBlockLineNumberTextFontSize
   */
  getCodeBlockLineNumberTextFontSize(): number | undefined {
    return this.codeBlockLineNumberTextFontSize
  }

  /**
   * 获取codeBlockLineNumberTextFontStyle
   *
   * @returns codeBlockLineNumberTextFontStyle
   */
  getCodeBlockLineNumberTextFontStyle(): FontStyle | undefined {
    return this.codeBlockLineNumberTextFontStyle
  }

  /**
   * 获取codeBlockLineNumberTextFontWeight
   *
   * @returns codeBlockLineNumberTextFontWeight
   */
  getCodeBlockLineNumberTextFontWeight(): FontWeight | undefined {
    return this.codeBlockLineNumberTextFontWeight
  }

  /**
   * 获取codeBlockLineNumberTextFontFamily
   *
   * @returns codeBlockLineNumberTextFontFamily
   */
  getCodeBlockLineNumberTextFontFamily(): string | undefined {
    return this.codeBlockLineNumberTextFontFamily
  }

  /**
   * 获取codeBlockLineNumberTextLineHeight
   *
   * @returns codeBlockLineNumberTextLineHeight
   */
  getCodeBlockLineNumberTextLineHeight(): number | undefined {
    return this.codeBlockLineNumberTextLineHeight
  }

  /**
   * 获取codeBlockDividerColor
   *
   * @returns codeBlockDividerColor
   */
  getCodeBlockDividerColor(): number | undefined {
    return this.codeBlockDividerColor
  }

  /**
   * 获取codeBlockDividerStrokeWidth
   *
   * @returns codeBlockDividerStrokeWidth
   */
  getCodeBlockDividerStrokeWidth(): number | undefined {
    return this.codeBlockDividerStrokeWidth
  }

  /**
   * 获取codeBlockLineNumberDividerSpacing
   *
   * @returns codeBlockLineNumberDividerSpacing
   */
  getCodeBlockLineNumberDividerSpacing(): number | undefined {
    return this.codeBlockLineNumberDividerSpacing
  }

  /**
   * 获取codeBlockTextFontColor
   *
   * @returns codeBlockTextFontColor
   */
  getCodeBlockTextFontColor(): number | undefined {
    return this.codeBlockTextFontColor
  }

  /**
   * 获取codeBlockTextMarginRight
   *
   * @returns codeBlockTextMarginRight
   */
  getCodeBlockTextMarginRight(): number | undefined {
    return this.codeBlockTextMarginRight
  }

  /**
   * 获取codeBlockTextMarginLeft
   *
   * @returns codeBlockTextMarginLeft
   */
  getCodeBlockTextMarginLeft(): number | undefined {
    return this.codeBlockTextMarginLeft
  }

  /**
   * 获取codeBlockTextFontSize
   *
   * @returns codeBlockTextFontSize
   */
  getCodeBlockTextFontSize(): number | undefined {
    return this.codeBlockTextFontSize
  }

  /**
   * 获取codeBlockTextFontStyle
   *
   * @returns codeBlockTextFontStyle
   */
  getCodeBlockTextFontStyle(): FontStyle | undefined {
    return this.codeBlockTextFontStyle
  }

  /**
   * 获取codeBlockTextFontWeight
   *
   * @returns codeBlockTextFontWeight
   */
  getCodeBlockTextFontWeight(): FontWeight | undefined {
    return this.codeBlockTextFontWeight
  }

  /**
   * 获取codeBlockTextFontFamily
   *
   * @returns codeBlockTextFontFamily
   */
  getCodeBlockTextFontFamily(): string | undefined {
    return this.codeBlockTextFontFamily
  }

  /**
   * 获取codeBlockTextLineHeight
   *
   * @returns codeBlockTextLineHeight
   */
  getCodeBlockTextLineHeight(): number | undefined {
    return this.codeBlockTextLineHeight
  }

  /**
   * 获取codeBlockTextLetterSpacing
   *
   * @returns codeBlockTextLetterSpacing
   */
  getCodeBlockTextLetterSpacing(): number | undefined {
    return this.codeBlockTextLetterSpacing
  }

  /**
   * 获取codeBlockListTitleTextSize
   *
   * @returns codeBlockListTitleTextSize
   */
  getCodeBlockListTitleTextSize(): number | undefined {
    return this.codeBlockListTitleTextSize
  }

  /**
   * 获取codeBlockListTitleSelectTextSize
   *
   * @returns codeBlockListTitleSelectTextSize
   */
  getCodeBlockListTitleSelectTextSize(): number | undefined {
    return this.codeBlockListTitleSelectTextSize
  }

  /**
   * 获取codeBlockListTitleSelectTextColor
   *
   * @returns codeBlockListTitleSelectTextColor
   */
  getCodeBlockListTitleSelectTextColor(): number | undefined {
    return this.codeBlockListTitleSelectTextColor
  }

  /**
   * 获取codeBlockListTitleUnselectTextColor
   *
   * @returns codeBlockListTitleUnselectTextColor
   */
  getCodeBlockListTitleUnselectTextColor(): number | undefined {
    return this.codeBlockListTitleUnselectTextColor
  }

  /**
   * 获取codeBlockListTitleSelectBackgroundColor
   *
   * @returns codeBlockListTitleSelectBackgroundColor
   */
  getCodeBlockListTitleSelectBackgroundColor(): number | undefined {
    return this.codeBlockListTitleSelectBackgroundColor
  }

  /**
   * 获取codeBlockListTitleUnselectBackgroundColor
   *
   * @returns codeBlockListTitleUnselectBackgroundColor
   */
  getCodeBlockListTitleUnselectBackgroundColor(): number | undefined {
    return this.codeBlockListTitleUnselectBackgroundColor
  }

  /**
   * 获取codeBlockIsSeparate
   *
   * @returns codeBlockIsSeparate
   */
  getCodeBlockIsSeparate(): boolean | undefined {
    return this.codeBlockIsSeparate
  }

  /**
   * 获取codeBlockSeparateWidth
   *
   * @returns codeBlockSeparateWidth
   */
  getCodeBlockSeparateWidth(): number | undefined {
    return this.codeBlockSeparateWidth
  }

  /**
   * 获取codeBlockSeparateIsBottom
   *
   * @returns codeBlockSeparateIsBottom
   */
  getCodeBlockSeparateIsBottom(): boolean | undefined {
    return this.codeBlockSeparateIsBottom
  }
}
