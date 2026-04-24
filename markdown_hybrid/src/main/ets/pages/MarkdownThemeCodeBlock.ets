/**
 * Markdown用户可设置的样式-代码块样式
 */
export class MarkdownThemeCodeBlock {
  /**
   * 代码深浅色模式
   */
  codeBlockIsDark?: boolean = undefined

  /**
   * 是否格式化围栏代码块内容
   */
  codeBlockIsCodeFormat?: boolean = undefined

  /**
   * codeformat是否用制表符
   */
  codeBlockUseTab?: boolean = undefined

  /**
   * codeformat空格缩进数量
   */
  codeBlockIndentWidth?: number = undefined

  /**
   * 围栏代码块代码高亮是否同步解析
   */
  codeBlockParserSync?: boolean = undefined

  /**
   * 代码块背景颜色
   */
  codeBlockBackgroundColor?: number = undefined

  /**
   * 代码块上外边距
   */
  codeBlockMarginTop?: number = undefined

  /**
   * 代码块右外边距
   */
  codeBlockMarginRight?: number = undefined

  /**
   * 代码块下外边距
   */
  codeBlockMarginBottom?: number = undefined

  /**
   * 代码块左外边距
   */
  codeBlockMarginLeft?: number = undefined

  /**
   * 代码块上内边距
   */
  codeBlockPaddingTop?: number = undefined

  /**
   * 代码块右内边距
   */
  codeBlockPaddingRight?: number = undefined

  /**
   * 代码块下内边距
   */
  codeBlockPaddingBottom?: number = undefined

  /**
   * 代码块左内边距
   */
  codeBlockPaddingLeft?: number = undefined

  /**
   * 代码块边框样式
   */
  codeBlockBorderStyle?: BorderStyle = undefined

  /**
   * 代码块边框宽度
   */
  codeBlockBorderWidth?: number = undefined

  /**
   * 代码块边框颜色
   */
  codeBlockBorderColor?: number = undefined

  /**
   * 代码块边框左上圆角
   */
  codeBlockRadiusTopLeft?: number = undefined

  /**
   * 代码块边框右上圆角
   */
  codeBlockRadiusTopRight?: number = undefined

  /**
   * 代码块边框左下圆角
   */
  codeBlockRadiusBottomLeft?: number = undefined

  /**
   * 代码块边框右下圆角
   */
  codeBlockRadiusBottomRight?: number = undefined

  /**
   * 代码块类型和代码块内容间距
   */
  codeBlockTitleLayoutMarginBottom?: number = undefined

  /**
   * 代码块类型左边距
   */
  codeBlockTypeTextMarginLeft?: number = undefined

  /**
   * 代码块没有代码类型时默认显示文本
   */
  codeBlockTypeText?: string = undefined

  /**
   * 代码块类型文本颜色
   */
  codeBlockTypeTextFontColor?: number = undefined

  /**
   * 代码块类型文本尺寸
   */
  codeBlockTypeTextFontSize?: number = undefined

  /**
   * 代码块类型文本字体样式
   */
  codeBlockTypeTextFontStyle?: FontStyle = undefined

  /**
   * 代码块类型文本字体粗细
   */
  codeBlockTypeTextFontWeight?: FontWeight = undefined

  /**
   * 代码块类型文本字体
   */
  codeBlockTypeTextFontFamily?: string = undefined

  /**
   * 代码块类型文本行高
   */
  codeBlockTypeTextLineHeight?: number = undefined

  /**
   * 代码块代码复制和代码全屏间距
   */
  codeBlockCopyFullScreenSpacing?: number = undefined

  /**
   * 代码块代码复制按钮是否显示
   */
  codeBlockCopyButtonIsShow?: boolean = undefined

  /**
   * 代码块代码复制文本是否显示
   */
  codeBlockCopyTextIsShow?: boolean = undefined

  /**
   * 代码块代码复制按钮默认图标
   */
  codeBlockCopyIcon?: Resource = undefined

  /**
   * 代码块代码复制图标宽度
   */
  codeBlockCopyIconWidth?: number = undefined

  /**
   * 代码块代码复制图标高度
   */
  codeBlockCopyIconHeight?: number = undefined

  /**
   * 代码块代码复制图标和文本间距
   */
  codeBlockCopyIconTextSpacing?: number = undefined

  /**
   * 代码块代码复制默认文本内容
   */
  codeBlockCopyText?: string = undefined

  /**
   * 代码块代码复制文本颜色
   */
  codeBlockCopyTextFontColor?: number = undefined

  /**
   * 代码块代码复制文本尺寸
   */
  codeBlockCopyTextFontSize?: number = undefined

  /**
   * 代码块代码复制文本字体样式
   */
  codeBlockCopyTextFontStyle?: FontStyle = undefined

  /**
   * 代码块代码复制文本字体粗细
   */
  codeBlockCopyTextFontWeight?: FontWeight = undefined

  /**
   * 代码块代码复制文本字体
   */
  codeBlockCopyTextFontFamily?: string = undefined

  /**
   * 代码块代码复制文本行高
   */
  codeBlockCopyTextLineHeight?: number = undefined

  /**
   * 代码块代码全屏按钮是否显示
   */
  codeBlockFullScreenButtonIsShow?: boolean = undefined

  /**
   * 代码块代码全屏文本是否显示
   */
  codeBlockFullScreenTextIsShow?: boolean = undefined

  /**
   * 代码块代码全屏按钮默认图标
   */
  codeBlockFullScreenIcon?: Resource = undefined

  /**
   * 代码块代码全屏图标宽度
   */
  codeBlockFullScreenIconWidth?: number = undefined

  /**
   * 代码块代码全屏图标高度
   */
  codeBlockFullScreenIconHeight?: number = undefined

  /**
   * 代码块代码全屏图标和文本间距
   */
  codeBlockFullScreenIconTextSpacing?: number = undefined

  /**
   * 代码块代码全屏默认文本内容
   */
  codeBlockFullScreenText?: string = undefined

  /**
   * 代码块代码全屏文本颜色
   */
  codeBlockFullScreenTextFontColor?: number = undefined

  /**
   * 代码块代码全屏文本尺寸
   */
  codeBlockFullScreenTextFontSize?: number = undefined

  /**
   * 代码块代码全屏文本字体样式
   */
  codeBlockFullScreenTextFontStyle?: FontStyle = undefined

  /**
   * 代码块代码全屏文本字体粗细
   */
  codeBlockFullScreenTextFontWeight?: FontWeight = undefined

  /**
   * 代码块代码全屏文本字体
   */
  codeBlockFullScreenTextFontFamily?: string = undefined

  /**
   * 代码块代码全屏文本行高
   */
  codeBlockFullScreenTextLineHeight?: number = undefined

  /**
   * 代码块代码行号是否显示
   */
  codeBlockLineNumberIsShow?: boolean = undefined

  /**
   * 代码块代码行号左内边距
   */
  codeBlockLineNumberTextPaddingLeft?: number = undefined

  /**
   * 代码块代码行号文本颜色
   */
  codeBlockLineNumberTextFontColor?: number = undefined

  /**
   * 代码块代码行号文本尺寸
   */
  codeBlockLineNumberTextFontSize?: number = undefined

  /**
   * 代码块代码行号文本字体样式
   */
  codeBlockLineNumberTextFontStyle?: FontStyle = undefined

  /**
   * 代码块代码行号文本字体粗细
   */
  codeBlockLineNumberTextFontWeight?: FontWeight = undefined

  /**
   * 代码块代码行号文本字体
   */
  codeBlockLineNumberTextFontFamily?: string = undefined

  /**
   * 代码块代码行号文本行高
   */
  codeBlockLineNumberTextLineHeight?: number = undefined

  /**
   * 代码块代码行号和代码块中间分割线颜色
   */
  codeBlockDividerColor?: number = undefined

  /**
   * 代码块代码行号和代码块中间分割线宽度
   */
  codeBlockDividerStrokeWidth?: number = undefined

  /**
   * 代码块代码行号和分割线间距
   */
  codeBlockLineNumberDividerSpacing?: number = undefined

  /**
   * 代码块文本颜色
   */
  codeBlockTextFontColor?: number = undefined

  /**
   * 代码块代码文本右外边距
   */
  codeBlockTextMarginRight?: number = undefined

  /**
   * 代码块代码文本左外边距
   */
  codeBlockTextMarginLeft?: number = undefined

  /**
   * 代码块文本尺寸
   */
  codeBlockTextFontSize?: number = undefined

  /**
   * 代码块文本字体样式
   */
  codeBlockTextFontStyle?: FontStyle = undefined

  /**
   * 代码块文本字体粗细
   */
  codeBlockTextFontWeight?: FontWeight = undefined

  /**
   * 代码块文本字体
   */
  codeBlockTextFontFamily?: string = undefined

  /**
   * 代码块文本行高
   */
  codeBlockTextLineHeight?: number = undefined

  /**
   * 代码块文本字符间距
   */
  codeBlockTextLetterSpacing?: number = undefined

  /**
   * 组合代码块未选中标题字体大小
   */
  codeBlockListTitleTextSize?: number = undefined

  /**
   * 组合代码块选中标题字体大小
   */
  codeBlockListTitleSelectTextSize?: number = undefined

  /**
   * 组合代码块选中标题文本颜色
   */
  codeBlockListTitleSelectTextColor?: number = undefined

  /**
   * 组合代码块未选中标题文本颜色
   */
  codeBlockListTitleUnselectTextColor?: number = undefined

  /**
   * 组合代码块选中标题背景颜色
   */
  codeBlockListTitleSelectBackgroundColor?: number = undefined

  /**
   * 组合代码块未选中标题背景颜色
   */
  codeBlockListTitleUnselectBackgroundColor?: number = undefined

  /**
   * 是否单独代码块显示
   */
  codeBlockIsSeparate?: boolean = undefined

  /**
   * 单独代码块行号宽度
   */
  codeBlockSeparateWidth?: number = undefined

  /**
   * 单独代码块是否居底显示
   */
  codeBlockSeparateIsBottom?: boolean = undefined

  /**
   * 设置代码块深浅色
   *
   * @param isDark 是否是深色 - true：深色；false：浅色。默认false
   */
  setCodeBlockIsDark(isDark: boolean): void {
    this.codeBlockIsDark = isDark
  }

  /**
   * 设置是否格式化围栏代码块内容
   *
   * @param isCodeFormat 是否格式化围栏代码块内容
   */
  setCodeBlockIsCodeFormat(isCodeFormat: boolean): void {
    this.codeBlockIsCodeFormat = isCodeFormat
  }

  /**
   * 设置codeformat是否用制表符
   *
   * @param useTab 是否用制表符
   */
  setCodeBlockUseTab(useTab: boolean): void {
    this.codeBlockUseTab = useTab
  }

  /**
   * 设置codeformat空格缩进数量
   *
   * @param indentWidth 空格缩进数量
   */
  setCodeBlockIndentWidth(indentWidth: number): void {
    this.codeBlockIndentWidth = indentWidth
  }

  /**
   * 设置围栏代码块代码高亮是否同步解析
   *
   * @param parserSync 是否同步解析
   */
  setCodeBlockParserSync(parserSync: boolean): void {
    this.codeBlockParserSync = parserSync
  }

  /**
   * 设置代码块背景颜色
   *
   * @param color 代码块背景颜色
   */
  setCodeBlockBackgroundColor(color: number): void {
    this.codeBlockBackgroundColor = color
  }

  /**
   * 代码块整体外边距
   *
   * @param margin 外边距
   */
  setCodeBlockAllMargin(margin: number): void {
    this.codeBlockMarginTop = margin
    this.codeBlockMarginRight = margin
    this.codeBlockMarginBottom = margin
    this.codeBlockMarginLeft = margin
  }

  /**
   * 代码块分别设置四个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setCodeBlockMargin(top?: number, right?: number, bottom?: number, left?: number): void {
    this.codeBlockMarginTop = top
    this.codeBlockMarginRight = right
    this.codeBlockMarginBottom = bottom
    this.codeBlockMarginLeft = left
  }

  /**
   * 代码块整体内边距
   *
   * @param padding 内边距
   */
  setCodeBlockAllPadding(padding: number): void {
    this.codeBlockPaddingTop = padding
    this.codeBlockPaddingRight = padding
    this.codeBlockPaddingBottom = padding
    this.codeBlockPaddingLeft = padding
  }

  /**
   * 代码块分别设置四个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setCodeBlockPadding(top?: number, right?: number, bottom?: number, left?: number): void {
    this.codeBlockPaddingTop = top
    this.codeBlockPaddingRight = right
    this.codeBlockPaddingBottom = bottom
    this.codeBlockPaddingLeft = left
  }

  /**
   * 设置代码块边框样式
   *
   * @param borderStyle 代码块边框样式
   */
  setCodeBlockBorderStyle(borderStyle: BorderStyle): void {
    this.codeBlockBorderStyle = borderStyle
  }

  /**
   * 设置代码块边框宽度
   *
   * @param borderWidth 代码块边框宽度
   */
  setCodeBlockBorderWidth(borderWidth: number): void {
    this.codeBlockBorderWidth = borderWidth
  }

  /**
   * 设置代码块边框颜色
   *
   * @param borderColor 代码块边框颜色
   */
  setCodeBlockBorderColor(borderColor: number): void {
    this.codeBlockBorderColor = borderColor
  }

  /**
   * 代码块整体圆角
   *
   * @param radius 圆角
   */
  setCodeBlockAllRadius(radius: number): void {
    this.codeBlockRadiusTopLeft = radius
    this.codeBlockRadiusTopRight = radius
    this.codeBlockRadiusBottomLeft = radius
    this.codeBlockRadiusBottomRight = radius
  }

  /**
   * 代码块分别设置四个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setCodeBlockRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void {
    this.codeBlockRadiusTopLeft = topLeft
    this.codeBlockRadiusTopRight = topRight
    this.codeBlockRadiusBottomLeft = bottomLeft
    this.codeBlockRadiusBottomRight = bottomRight
  }

  /**
   * 设置代码块类型和代码块内容间距
   *
   * @param marginBottom 代码块类型和代码块内容间距
   */
  setCodeBlockTitleLayoutMarginBottom(marginBottom: number): void {
    this.codeBlockTitleLayoutMarginBottom = marginBottom
  }

  /**
   * 设置代码块类型左边距
   *
   * @param marginLeft 代码块类型左边距
   */
  setCodeBlockTypeTextMarginLeft(marginLeft: number): void {
    this.codeBlockTypeTextMarginLeft = marginLeft
  }

  /**
   * 设置代码块没有代码类型时默认显示文本
   *
   * @param text 默认显示文本
   */
  setCodeBlockTypeText(text: string): void {
    this.codeBlockTypeText = text
  }

  /**
   * 设置代码块类型文本颜色
   *
   * @param color 代码块类型文本颜色
   */
  setCodeBlockTypeTextFontColor(color: number): void {
    this.codeBlockTypeTextFontColor = color
  }

  /**
   * 设置代码块类型文本尺寸
   *
   * @param size 代码块类型文本尺寸
   */
  setCodeBlockTypeTextFontSize(size: number): void {
    this.codeBlockTypeTextFontSize = size
  }

  /**
   * 设置代码块类型文本字体样式
   *
   * @param style 代码块类型文本字体样式
   */
  setCodeBlockTypeTextFontStyle(style: FontStyle): void {
    this.codeBlockTypeTextFontStyle = style
  }

  /**
   * 设置代码块类型文本字体粗细
   *
   * @param weight 代码块类型文本字体粗细
   */
  setCodeBlockTypeTextFontWeight(weight: FontWeight): void {
    this.codeBlockTypeTextFontWeight = weight
  }

  /**
   * 设置代码块类型文本字体
   *
   * @param family 代码块类型文本字体
   */
  setCodeBlockTypeTextFontFamily(family: string): void {
    this.codeBlockTypeTextFontFamily = family
  }

  /**
   * 设置代码块类型文本行高
   *
   * @param height 代码块类型文本行高
   */
  setCodeBlockTypeTextLineHeight(height: number): void {
    this.codeBlockTypeTextLineHeight = height
  }

  /**
   * 设置代码块代码复制和代码全屏间距
   *
   * @param spacing 代码块代码复制和代码全屏间距
   */
  setCodeBlockCopyFullScreenSpacing(spacing: number): void {
    this.codeBlockCopyFullScreenSpacing = spacing
  }

  /**
   * 设置代码块代码复制按钮是否显示
   *
   * @param isShow 是否显示
   */
  setCodeBlockCopyButtonIsShow(isShow: boolean): void {
    this.codeBlockCopyButtonIsShow = isShow
  }

  /**
   * 设置代码块代码复制文本是否显示
   *
   * @param isShow 是否显示
   */
  setCodeBlockCopyTextIsShow(isShow: boolean): void {
    this.codeBlockCopyTextIsShow = isShow
  }

  /**
   * 设置代码块代码复制按钮默认图标
   *
   * @param icon 默认图标
   */
  setCodeBlockCopyIcon(icon: Resource): void {
    this.codeBlockCopyIcon = icon
  }

  /**
   * 设置代码块代码复制图标宽度
   *
   * @param width 图标宽度
   */
  setCodeBlockCopyIconWidth(width: number): void {
    this.codeBlockCopyIconWidth = width
  }

  /**
   * 设置代码块代码复制图标高度
   *
   * @param height 图标高度
   */
  setCodeBlockCopyIconHeight(height: number): void {
    this.codeBlockCopyIconHeight = height
  }

  /**
   * 设置代码块代码复制图标和文本间距
   *
   * @param spacing 代码块代码复制图标和文本间距
   */
  setCodeBlockCopyIconTextSpacing(spacing: number): void {
    this.codeBlockCopyIconTextSpacing = spacing
  }

  /**
   * 设置代码块代码复制默认文本内容
   *
   * @param text 默认文本内容
   */
  setCodeBlockCopyText(text: string): void {
    this.codeBlockCopyText = text
  }

  /**
   * 设置代码块代码复制文本颜色
   *
   * @param color 代码块代码复制文本颜色
   */
  setCodeBlockCopyTextFontColor(color: number): void {
    this.codeBlockCopyTextFontColor = color
  }

  /**
   * 设置代码块代码复制文本尺寸
   *
   * @param size 代码块代码复制文本尺寸
   */
  setCodeBlockCopyTextFontSize(size: number): void {
    this.codeBlockCopyTextFontSize = size
  }

  /**
   * 设置代码块代码复制文本字体样式
   *
   * @param style 代码块代码复制文本字体样式
   */
  setCodeBlockCopyTextFontStyle(style: FontStyle): void {
    this.codeBlockCopyTextFontStyle = style
  }

  /**
   * 设置代码块代码复制文本字体粗细
   *
   * @param weight 代码块代码复制文本字体粗细
   */
  setCodeBlockCopyTextFontWeight(weight: FontWeight): void {
    this.codeBlockCopyTextFontWeight = weight
  }

  /**
   * 设置代码块代码复制文本字体
   *
   * @param family 代码块代码复制文本字体
   */
  setCodeBlockCopyTextFontFamily(family: string): void {
    this.codeBlockCopyTextFontFamily = family
  }

  /**
   * 设置代码块代码复制文本行高
   *
   * @param height 代码块代码复制文本行高
   */
  setCodeBlockCopyTextLineHeight(height: number): void {
    this.codeBlockCopyTextLineHeight = height
  }

  /**
   * 设置代码块代码全屏按钮是否显示
   *
   * @param isShow 是否显示
   */
  setCodeBlockFullScreenButtonIsShow(isShow: boolean): void {
    this.codeBlockFullScreenButtonIsShow = isShow
  }

  /**
   * 设置代码块代码全屏文本是否显示
   *
   * @param isShow 是否显示
   */
  setCodeBlockFullScreenTextIsShow(isShow: boolean): void {
    this.codeBlockFullScreenTextIsShow = isShow
  }

  /**
   * 设置代码块代码全屏按钮默认图标
   *
   * @param icon 默认图标
   */
  setCodeBlockFullScreenIcon(icon: Resource): void {
    this.codeBlockFullScreenIcon = icon
  }

  /**
   * 设置代码块代码全屏图标宽度
   *
   * @param width 图标宽度
   */
  setCodeBlockFullScreenIconWidth(width: number): void {
    this.codeBlockFullScreenIconWidth = width
  }

  /**
   * 设置代码块代码全屏图标高度
   *
   * @param height 图标高度
   */
  setCodeBlockFullScreenIconHeight(height: number): void {
    this.codeBlockFullScreenIconHeight = height
  }

  /**
   * 设置代码块代码全屏图标和文本间距
   *
   * @param spacing 代码块代码全屏图标和文本间距
   */
  setCodeBlockFullScreenIconTextSpacing(spacing: number): void {
    this.codeBlockFullScreenIconTextSpacing = spacing
  }

  /**
   * 设置代码块代码全屏默认文本内容
   *
   * @param text 默认文本内容
   */
  setCodeBlockFullScreenText(text: string): void {
    this.codeBlockFullScreenText = text
  }

  /**
   * 设置代码块代码全屏文本颜色
   *
   * @param color 代码块代码全屏文本颜色
   */
  setCodeBlockFullScreenTextFontColor(color: number): void {
    this.codeBlockFullScreenTextFontColor = color
  }

  /**
   * 设置代码块代码全屏文本尺寸
   *
   * @param size 代码块代码全屏文本尺寸
   */
  setCodeBlockFullScreenTextFontSize(size: number): void {
    this.codeBlockFullScreenTextFontSize = size
  }

  /**
   * 设置代码块代码全屏文本字体样式
   *
   * @param style 代码块代码全屏文本字体样式
   */
  setCodeBlockFullScreenTextFontStyle(style: FontStyle): void {
    this.codeBlockFullScreenTextFontStyle = style
  }

  /**
   * 设置代码块代码全屏文本字体粗细
   *
   * @param weight 代码块代码全屏文本字体粗细
   */
  setCodeBlockFullScreenTextFontWeight(weight: FontWeight): void {
    this.codeBlockFullScreenTextFontWeight = weight
  }

  /**
   * 设置代码块代码全屏文本字体
   *
   * @param family 代码块代码全屏文本字体
   */
  setCodeBlockFullScreenTextFontFamily(family: string): void {
    this.codeBlockFullScreenTextFontFamily = family
  }

  /**
   * 设置代码块代码全屏文本行高
   *
   * @param height 代码块代码全屏文本行高
   */
  setCodeBlockFullScreenTextLineHeight(height: number): void {
    this.codeBlockFullScreenTextLineHeight = height
  }

  /**
   * 设置代码块代码行号是否显示
   *
   * @param isShow 是否显示
   */
  setCodeBlockLineNumberIsShow(isShow: boolean): void {
    this.codeBlockLineNumberIsShow = isShow
  }

  /**
   * 设置代码块代码行号左内边距
   *
   * @param left 代码块代码行号左内边距
   */
  setCodeBlockLineNumberTextPaddingLeft(left: number): void {
    this.codeBlockLineNumberTextPaddingLeft = left
  }

  /**
   * 设置代码块代码行号文本颜色
   *
   * @param color 代码块代码行号文本颜色
   */
  setCodeBlockLineNumberTextFontColor(color: number): void {
    this.codeBlockLineNumberTextFontColor = color
  }

  /**
   * 设置代码块代码行号文本尺寸
   *
   * @param size 代码块代码行号文本尺寸
   */
  setCodeBlockLineNumberTextFontSize(size: number): void {
    this.codeBlockLineNumberTextFontSize = size
  }

  /**
   * 设置代码块代码行号文本字体样式
   *
   * @param style 代码块代码行号文本字体样式
   */
  setCodeBlockLineNumberTextFontStyle(style: FontStyle): void {
    this.codeBlockLineNumberTextFontStyle = style
  }

  /**
   * 设置代码块代码行号文本字体粗细
   *
   * @param weight 代码块代码行号文本字体粗细
   */
  setCodeBlockLineNumberTextFontWeight(weight: FontWeight): void {
    this.codeBlockLineNumberTextFontWeight = weight
  }

  /**
   * 设置代码块代码行号文本字体
   *
   * @param family 代码块代码行号文本字体
   */
  setCodeBlockLineNumberTextFontFamily(family: string): void {
    this.codeBlockLineNumberTextFontFamily = family
  }

  /**
   * 设置代码块代码行号文本行高
   *
   * @param height 代码块代码行号文本行高
   */
  setCodeBlockLineNumberTextLineHeight(height: number): void {
    this.codeBlockLineNumberTextLineHeight = height
  }

  /**
   * 设置代码块代码行号和代码块中间分割线颜色
   *
   * @param color 分割线颜色
   */
  setCodeBlockDividerColor(color: number): void {
    this.codeBlockDividerColor = color
  }

  /**
   * 设置代码块代码行号和代码块中间分割线宽度
   *
   * @param strokeWidth 分割线宽度
   */
  setCodeBlockDividerStrokeWidth(strokeWidth: number): void {
    this.codeBlockDividerStrokeWidth = strokeWidth
  }

  /**
   * 设置代码块代码行号和分割线间距
   *
   * @param spacing 代码块代码行号和分割线间距
   */
  setCodeBlockLineNumberDividerSpacing(spacing: number): void {
    this.codeBlockLineNumberDividerSpacing = spacing
  }

  /**
   * 设置代码块文本颜色
   *
   * @param color 代码块文本颜色
   */
  setCodeBlockTextFontColor(color: number): void {
    this.codeBlockTextFontColor = color
  }

  /**
   * 设置代码块代码文本右外边距
   *
   * @param marginRight 代码块代码文本右外边距
   */
  setCodeBlockTextMarginRight(marginRight: number): void {
    this.codeBlockTextMarginRight = marginRight
  }

  /**
   * 设置代码块代码文本左外边距
   *
   * @param marginLeft 代码块代码文本左外边距
   */
  setCodeBlockTextMarginLeft(marginLeft: number): void {
    this.codeBlockTextMarginLeft = marginLeft
  }

  /**
   * 设置代码块文本尺寸
   *
   * @param size 代码块文本尺寸
   */
  setCodeBlockTextFontSize(size: number): void {
    this.codeBlockTextFontSize = size
  }

  /**
   * 设置代码块文本字体样式
   *
   * @param style 代码块文本字体样式
   */
  setCodeBlockTextFontStyle(style: FontStyle): void {
    this.codeBlockTextFontStyle = style
  }

  /**
   * 设置代码块文本字体粗细
   *
   * @param weight 代码块文本字体粗细
   */
  setCodeBlockTextFontWeight(weight: FontWeight): void {
    this.codeBlockTextFontWeight = weight
  }

  /**
   * 设置代码块文本字体
   *
   * @param family 代码块文本字体
   */
  setCodeBlockTextFontFamily(family: string): void {
    this.codeBlockTextFontFamily = family
  }

  /**
   * 设置代码块文本行高
   *
   * @param height 代码块文本行高
   */
  setCodeBlockTextLineHeight(height: number): void {
    this.codeBlockTextLineHeight = height
  }

  /**
   * 设置代码块文本字符间距
   *
   * @param spacing 代码块文本字符间距
   */
  setCodeBlockTextLetterSpacing(spacing: number): void {
    this.codeBlockTextLetterSpacing = spacing
  }

  /**
   * 设置组合代码块未选中标题字体大小
   *
   * @param size 字体大小
   */
  setCodeBlockListTitleTextSize(size: number): void {
    this.codeBlockListTitleTextSize = size
  }

  /**
   * 设置组合代码块选中标题字体大小
   *
   * @param size 字体大小
   */
  setCodeBlockListTitleSelectTextSize(size: number): void {
    this.codeBlockListTitleSelectTextSize = size
  }

  /**
   * 设置组合代码块选中标题文本颜色
   *
   * @param color 文本颜色
   */
  setCodeBlockListTitleSelectTextColor(color: number): void {
    this.codeBlockListTitleSelectTextColor = color
  }

  /**
   * 设置组合代码块未选中标题文本颜色
   *
   * @param color 文本颜色
   */
  setCodeBlockListTitleUnselectTextColor(color: number): void {
    this.codeBlockListTitleUnselectTextColor = color
  }

  /**
   * 设置组合代码块选中标题背景颜色
   *
   * @param color 背景颜色
   */
  setCodeBlockListTitleSelectBackgroundColor(color: number): void {
    this.codeBlockListTitleSelectBackgroundColor = color
  }

  /**
   * 设置组合代码块未选中标题背景颜色
   *
   * @param color 背景颜色
   */
  setCodeBlockListTitleUnselectBackgroundColor(color: number): void {
    this.codeBlockListTitleUnselectBackgroundColor = color
  }

  /**
   * 设置是否单独代码块显示
   *
   * @param isSeparate 是否单独显示
   */
  setCodeBlockIsSeparate(isSeparate: boolean): void {
    this.codeBlockIsSeparate = isSeparate
  }

  /**
   * 设置单独代码块行号宽度
   *
   * @param width 行号宽度
   */
  setCodeBlockSeparateWidth(width: number): void {
    this.codeBlockSeparateWidth = width
  }

  /**
   * 设置单独代码块是否居底显示
   *
   * @param isBottom 是否居底
   */
  setCodeBlockSeparateIsBottom(isBottom: boolean): void {
    this.codeBlockSeparateIsBottom = isBottom
  }
}
