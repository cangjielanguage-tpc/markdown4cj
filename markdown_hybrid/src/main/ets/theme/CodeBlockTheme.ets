import { MarkdownBaseTheme } from './MarkdownBaseTheme'
import {
  COLOR_TRANSPARENT,
  COLOR_RED,
  COLOR_BLACK,
  COLOR_GRAY,
  isMargin,
  isPadding,
  isBorderRadiuses,
  COLOR_FFF5F2F0,
  COLOR_DD000000,
  COLOR_FF2D2D2D,
  COLOR_FFA9B7C6
} from "../base/Constants"

/**
 * 代码块样式配置
 */
@Observed
export class CodeBlockTheme implements MarkdownBaseTheme {
  codeBlockIsDark: boolean = false // 代码深浅色模式
  codeBlockIsCodeFormat: boolean = false // 是否为代码格式
  codeBlockUseTab: boolean = false // 是否使用Tab缩进
  codeBlockIndentWidth: Length = 4 // 缩进宽度
  codeBlockParserSync: boolean = false // 解析器是否同步
  codeBlockBackgroundColor: ResourceColor = COLOR_FFF5F2F0 // 背景颜色
  codeBlockMarginTop: Length = 0.0 // 上边距
  codeBlockMarginRight: Length = 0.0 // 右边距
  codeBlockMarginBottom: Length = 0.0 // 下边距
  codeBlockMarginLeft: Length = 0.0 // 左边距
  codeBlockPaddingTop: Length = 0.0 // 上内边距
  codeBlockPaddingRight: Length = 8.0 // 右内边距
  codeBlockPaddingBottom: Length = 8.0 // 下内边距
  codeBlockPaddingLeft: Length = 0.0 // 左内边距
  codeBlockBorderStyle: BorderStyle = BorderStyle.Solid // 边框样式
  codeBlockBorderWidth: Length = 0.0 // 边框宽度
  codeBlockBorderColor: ResourceColor = COLOR_TRANSPARENT // 边框颜色
  codeBlockRadiusTopLeft: Length = 8.0 // 左上圆角
  codeBlockRadiusTopRight: Length = 8.0 // 右上圆角
  codeBlockRadiusBottomLeft: Length = 8.0 // 左下圆角
  codeBlockRadiusBottomRight: Length = 8.0 // 右下圆角
  codeBlockTitleLayoutMarginBottom: Length = 0.0 // 标题布局下边距
  codeBlockTypeTextMarginLeft: Length = 8.0 // 类型文本左边距
  codeBlockTypeText: string = '' // 类型文本
  codeBlockTypeTextFontColor: ResourceColor | undefined = undefined // 类型文本字体颜色
  codeBlockTypeTextFontSize: number | string | Resource | undefined = undefined // 类型文本字体大小
  codeBlockTypeTextFontStyle: FontStyle | undefined = undefined // 类型文本字体样式
  codeBlockTypeTextFontWeight: number | FontWeight | undefined = undefined // 类型文本字体粗细
  codeBlockTypeTextFontFamily: string | Resource | undefined = undefined // 类型文本字体族
  codeBlockTypeTextLineHeight: number | string | Resource | undefined = undefined // 类型文本行高
  codeBlockCopyFullScreenSpacing: number = 5.0 // 复制与全屏间距
  codeBlockCopyButtonIsShow: boolean = true // 复制按钮是否显示
  codeBlockCopyTextIsShow: boolean = true // 复制文本是否显示
  codeBlockCopyIcon: Resource | undefined = undefined // 复制图标
  codeBlockCopyIconWidth: Length = 24.0 // 复制图标宽度
  codeBlockCopyIconHeight: Length = 24.0 // 复制图标高度
  codeBlockCopyIconTextSpacing: number = 5.0 // 复制图标文本间距
  codeBlockCopyText: string = '复制代码' // 复制文本
  codeBlockCopyTextFontColor: ResourceColor | undefined = undefined // 复制文本字体颜色
  codeBlockCopyTextFontSize: number | string | Resource | undefined = undefined // 复制文本字体大小
  codeBlockCopyTextFontStyle: FontStyle | undefined = undefined // 复制文本字体样式
  codeBlockCopyTextFontWeight: number | FontWeight | undefined = undefined // 复制文本字体粗细
  codeBlockCopyTextFontFamily: string | Resource | undefined = undefined // 复制文本字体族
  codeBlockCopyTextLineHeight: number | string | Resource | undefined = undefined // 复制文本行高
  codeBlockFullScreenButtonIsShow: boolean = true // 全屏按钮是否显示
  codeBlockFullScreenTextIsShow: boolean = true // 全屏文本是否显示
  codeBlockFullScreenIcon: Resource | undefined = undefined // 全屏图标
  codeBlockFullScreenIconWidth: Length = 24.0 // 全屏图标宽度
  codeBlockFullScreenIconHeight: Length = 24.0 // 全屏图标高度
  codeBlockFullScreenIconTextSpacing: number = 5.0 // 全屏图标文本间距
  codeBlockFullScreenText: string = '全屏代码' // 全屏文本
  codeBlockFullScreenTextFontColor: ResourceColor | undefined = undefined // 全屏文本字体颜色
  codeBlockFullScreenTextFontSize: number | string | Resource | undefined = undefined // 全屏文本字体大小
  codeBlockFullScreenTextFontStyle: FontStyle | undefined = undefined // 全屏文本字体样式
  codeBlockFullScreenTextFontWeight: number | FontWeight | undefined = undefined // 全屏文本字体粗细
  codeBlockFullScreenTextFontFamily: string | Resource | undefined = undefined // 全屏文本字体族
  codeBlockFullScreenTextLineHeight: number | string | Resource | undefined = undefined // 全屏文本行高
  codeBlockLineNumberIsShow: boolean = true // 行号是否显示
  codeBlockLineNumberTextPaddingLeft: Length = 8.0 // 行号文本左内边距
  codeBlockLineNumberTextFontColor: ResourceColor | undefined = undefined // 行号文本字体颜色
  codeBlockLineNumberTextFontSize: number | string | Resource | undefined = undefined // 行号文本字体大小
  codeBlockLineNumberTextFontStyle: FontStyle | undefined = undefined // 行号文本字体样式
  codeBlockLineNumberTextFontWeight: number | FontWeight | undefined = undefined // 行号文本字体粗细
  codeBlockLineNumberTextFontFamily: string | Resource | undefined = undefined // 行号文本字体族
  codeBlockLineNumberTextLineHeight: number | string | Resource | undefined = undefined // 行号文本行高
  codeBlockDividerColor: ResourceColor | undefined = undefined // 分割线颜色
  codeBlockDividerStrokeWidth: Length = 0.5 // 分割线宽度
  codeBlockLineNumberDividerSpacing: number = 8.0 // 行号分割线间距
  codeBlockTextMarginRight: Length = 8.0 // 文本右边距
  codeBlockTextMarginLeft: Length = 8.0 // 文本左边距
  codeBlockTextFontColor: ResourceColor = COLOR_DD000000 // 文本字体颜色
  codeBlockTextFontSize: number | string | Resource = 13.0 // 文本字体大小
  codeBlockTextFontStyle: FontStyle = FontStyle.Normal // 文本字体样式
  codeBlockTextFontWeight: number | FontWeight = FontWeight.Normal // 文本字体粗细
  codeBlockTextFontFamily: string | Resource = 'HarmonyOS Sans' // 文本字体族
  codeBlockTextLineHeight: number | string | Resource = 22.0 // 文本行高
  codeBlockTextLetterSpacing: number = 0.0 // 文本字母间距
  codeBlockListTitleTextSize: number = 13.0 // 列表标题文本大小
  codeBlockListTitleSelectTextSize: number = 13.0 // 列表标题选中文本大小
  codeBlockListTitleSelectTextColor: ResourceColor = COLOR_RED // 列表标题选中文本颜色
  codeBlockListTitleUnselectTextColor: ResourceColor = COLOR_BLACK // 列表标题未选中文本颜色
  codeBlockListTitleSelectBackgroundColor: ResourceColor = COLOR_GRAY // 列表标题选中背景颜色
  codeBlockListTitleUnselectBackgroundColor: ResourceColor = COLOR_TRANSPARENT // 列表标题未选中背景颜色
  codeBlockIsSeparate: boolean = false // 是否分离
  codeBlockSeparateWidth: Length = 50.0 // 分离宽度
  codeBlockSeparateIsBottom: boolean = false // 分离是否在底部

  /**
   * 设置代码块深浅色
   *
   * @param isDark 是否是深色 - true：深色；false：浅色。默认false
   * @return CodeBlockTheme
   */
  setCodeBlockIsDark(isDark: boolean): CodeBlockTheme {
    if (isDark) {
      this.codeBlockBackgroundColor = COLOR_FF2D2D2D
      this.codeBlockTextFontColor = COLOR_FFA9B7C6
    } else {
      this.codeBlockBackgroundColor = COLOR_FFF5F2F0
      this.codeBlockTextFontColor = COLOR_DD000000
    }
    this.codeBlockIsDark = isDark
    return this
  }

  /**
   * 设置代码块是否为代码格式
   *
   * @param isCodeFormat 是否为代码格式
   * @return CodeBlockTheme
   */
  setCodeBlockIsCodeFormat(isCodeFormat: boolean): CodeBlockTheme {
    this.codeBlockIsCodeFormat = isCodeFormat
    return this
  }

  /**
   * 设置代码块是否使用Tab缩进
   *
   * @param useTab 是否使用Tab缩进
   * @return CodeBlockTheme
   */
  setCodeBlockUseTab(useTab: boolean): CodeBlockTheme {
    this.codeBlockUseTab = useTab
    return this
  }

  /**
   * 设置代码块缩进宽度
   *
   * @param indentWidth 缩进宽度
   * @return CodeBlockTheme
   */
  setCodeBlockIndentWidth(indentWidth: Length): CodeBlockTheme {
    this.codeBlockIndentWidth = indentWidth
    return this
  }

  /**
   * 设置代码块解析器是否同步
   *
   * @param parserSync 解析器是否同步
   * @return CodeBlockTheme
   */
  setCodeBlockParserSync(parserSync: boolean): CodeBlockTheme {
    this.codeBlockParserSync = parserSync
    return this
  }

  /**
   * 设置代码块背景颜色
   *
   * @param color 背景颜色
   * @return CodeBlockTheme
   */
  setCodeBlockBackgroundColor(color: ResourceColor): CodeBlockTheme {
    this.codeBlockBackgroundColor = color
    return this
  }

  /**
   * 设置代码块边距
   *
   * @param options 边距选项
   * @return CodeBlockTheme
   */
  setMargin(options: Margin | Length): CodeBlockTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.codeBlockMarginTop = options
      this.codeBlockMarginRight = options
      this.codeBlockMarginBottom = options
      this.codeBlockMarginLeft = options
    }
    // 2. 如果是 object，它要么是 Margin，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Margin 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Margin 处理
      if (isMargin(options)) {
        const margin = options as Margin
        if (margin.top !== undefined) {
          this.codeBlockMarginTop = margin.top
        }
        if (margin.right !== undefined) {
          this.codeBlockMarginRight = margin.right
        }
        if (margin.bottom !== undefined) {
          this.codeBlockMarginBottom = margin.bottom
        }
        if (margin.left !== undefined) {
          this.codeBlockMarginLeft = margin.left
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.codeBlockMarginTop = options as Length
        this.codeBlockMarginRight = options as Length
        this.codeBlockMarginBottom = options as Length
        this.codeBlockMarginLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置代码块内边距
   *
   * @param options 内边距选项
   * @return CodeBlockTheme
   */
  setPadding(options: Padding | Length): CodeBlockTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.codeBlockPaddingTop = options
      this.codeBlockPaddingRight = options
      this.codeBlockPaddingBottom = options
      this.codeBlockPaddingLeft = options
    }
    // 2. 如果是 object，它要么是 Padding，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Padding 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Padding 处理
      if (isPadding(options)) {
        const padding = options as Padding
        if (padding.top !== undefined) {
          this.codeBlockPaddingTop = padding.top
        }
        if (padding.right !== undefined) {
          this.codeBlockPaddingRight = padding.right
        }
        if (padding.bottom !== undefined) {
          this.codeBlockPaddingBottom = padding.bottom
        }
        if (padding.left !== undefined) {
          this.codeBlockPaddingLeft = padding.left
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.codeBlockPaddingTop = options as Length
        this.codeBlockPaddingRight = options as Length
        this.codeBlockPaddingBottom = options as Length
        this.codeBlockPaddingLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置代码块边框样式
   *
   * @param borderStyle 边框样式
   * @return CodeBlockTheme
   */
  setCodeBlockBorderStyle(borderStyle: BorderStyle): CodeBlockTheme {
    this.codeBlockBorderStyle = borderStyle
    return this
  }

  /**
   * 设置代码块边框宽度
   *
   * @param borderWidth 边框宽度
   * @return CodeBlockTheme
   */
  setCodeBlockBorderWidth(borderWidth: Length): CodeBlockTheme {
    this.codeBlockBorderWidth = borderWidth
    return this
  }

  /**
   * 设置代码块边框颜色
   *
   * @param borderColor 边框颜色
   * @return CodeBlockTheme
   */
  setCodeBlockBorderColor(borderColor: ResourceColor): CodeBlockTheme {
    this.codeBlockBorderColor = borderColor
    return this
  }

  /**
   * 设置代码块圆角
   *
   * @param options 圆角选项
   * @return CodeBlockTheme
   */
  setRadius(options: BorderRadiuses | Length): CodeBlockTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.codeBlockRadiusTopLeft = options
      this.codeBlockRadiusTopRight = options
      this.codeBlockRadiusBottomLeft = options
      this.codeBlockRadiusBottomRight = options
    }
    // 2. 如果是 object，它要么是 BorderRadiuses，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 BorderRadiuses 的专属属性来区分
      // 如果包含 topLeft/topRight/bottomLeft/bottomRight 任意一个，就当作 BorderRadiuses 处理
      if (isBorderRadiuses(options)) {
        const radius = options as BorderRadiuses
        if (radius.topLeft !== undefined) {
          this.codeBlockRadiusTopLeft = radius.topLeft
        }
        if (radius.topRight !== undefined) {
          this.codeBlockRadiusTopRight = radius.topRight
        }
        if (radius.bottomLeft !== undefined) {
          this.codeBlockRadiusBottomLeft = radius.bottomLeft
        }
        if (radius.bottomRight !== undefined) {
          this.codeBlockRadiusBottomRight = radius.bottomRight
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.codeBlockRadiusTopLeft = options as Length
        this.codeBlockRadiusTopRight = options as Length
        this.codeBlockRadiusBottomLeft = options as Length
        this.codeBlockRadiusBottomRight = options as Length
      }
    }
    return this
  }

  /**
   * 设置代码块标题布局下边距
   *
   * @param marginBottom 下边距
   * @return CodeBlockTheme
   */
  setCodeBlockTitleLayoutMarginBottom(marginBottom: Length): CodeBlockTheme {
    this.codeBlockTitleLayoutMarginBottom = marginBottom
    return this
  }

  /**
   * 设置代码块类型文本左边距
   *
   * @param marginLeft 左边距
   * @return CodeBlockTheme
   */
  setCodeBlockTypeTextMarginLeft(marginLeft: Length): CodeBlockTheme {
    this.codeBlockTypeTextMarginLeft = marginLeft
    return this
  }

  /**
   * 设置代码块类型文本
   *
   * @param text 类型文本
   * @return CodeBlockTheme
   */
  setCodeBlockTypeText(text: string): CodeBlockTheme {
    this.codeBlockTypeText = text
    return this
  }

  /**
   * 设置代码块类型文本字体颜色
   *
   * @param color 字体颜色
   * @return CodeBlockTheme
   */
  setCodeBlockTypeTextFontColor(color: ResourceColor): CodeBlockTheme {
    this.codeBlockTypeTextFontColor = color
    return this
  }

  /**
   * 设置代码块类型文本字体大小
   *
   * @param size 字体大小
   * @return CodeBlockTheme
   */
  setCodeBlockTypeTextFontSize(size: number | string | Resource): CodeBlockTheme {
    this.codeBlockTypeTextFontSize = size
    return this
  }

  /**
   * 设置代码块类型文本字体样式
   *
   * @param style 字体样式
   * @return CodeBlockTheme
   */
  setCodeBlockTypeTextFontStyle(style: FontStyle): CodeBlockTheme {
    this.codeBlockTypeTextFontStyle = style
    return this
  }

  /**
   * 设置代码块类型文本字体粗细
   *
   * @param weight 字体粗细
   * @return CodeBlockTheme
   */
  setCodeBlockTypeTextFontWeight(weight: number | FontWeight): CodeBlockTheme {
    this.codeBlockTypeTextFontWeight = weight
    return this
  }

  /**
   * 设置代码块类型文本字体族
   *
   * @param family 字体族
   * @return CodeBlockTheme
   */
  setCodeBlockTypeTextFontFamily(family: string | Resource): CodeBlockTheme {
    this.codeBlockTypeTextFontFamily = family
    return this
  }

  /**
   * 设置代码块类型文本行高
   *
   * @param height 行高
   * @return CodeBlockTheme
   */
  setCodeBlockTypeTextLineHeight(height: number | string | Resource): CodeBlockTheme {
    this.codeBlockTypeTextLineHeight = height
    return this
  }

  /**
   * 设置代码块复制与全屏间距
   *
   * @param spacing 间距
   * @return CodeBlockTheme
   */
  setCodeBlockCopyFullScreenSpacing(spacing: number): CodeBlockTheme {
    this.codeBlockCopyFullScreenSpacing = spacing
    return this
  }

  /**
   * 设置代码块复制按钮是否显示
   *
   * @param isShow 是否显示
   * @return CodeBlockTheme
   */
  setCodeBlockCopyButtonIsShow(isShow: boolean): CodeBlockTheme {
    this.codeBlockCopyButtonIsShow = isShow
    return this
  }

  /**
   * 设置代码块复制文本是否显示
   *
   * @param isShow 是否显示
   * @return CodeBlockTheme
   */
  setCodeBlockCopyTextIsShow(isShow: boolean): CodeBlockTheme {
    this.codeBlockCopyTextIsShow = isShow
    return this
  }

  /**
   * 设置代码块复制图标
   *
   * @param icon 图标
   * @return CodeBlockTheme
   */
  setCodeBlockCopyIcon(icon: Resource): CodeBlockTheme {
    this.codeBlockCopyIcon = icon
    return this
  }

  /**
   * 设置代码块复制图标宽度
   *
   * @param width 宽度
   * @return CodeBlockTheme
   */
  setCodeBlockCopyIconWidth(width: Length): CodeBlockTheme {
    this.codeBlockCopyIconWidth = width
    return this
  }

  /**
   * 设置代码块复制图标高度
   *
   * @param height 高度
   * @return CodeBlockTheme
   */
  setCodeBlockCopyIconHeight(height: Length): CodeBlockTheme {
    this.codeBlockCopyIconHeight = height
    return this
  }

  /**
   * 设置代码块复制图标文本间距
   *
   * @param spacing 间距
   * @return CodeBlockTheme
   */
  setCodeBlockCopyIconTextSpacing(spacing: number): CodeBlockTheme {
    this.codeBlockCopyIconTextSpacing = spacing
    return this
  }

  /**
   * 设置代码块复制文本
   *
   * @param text 复制文本
   * @return CodeBlockTheme
   */
  setCodeBlockCopyText(text: string): CodeBlockTheme {
    this.codeBlockCopyText = text
    return this
  }

  /**
   * 设置代码块复制文本字体颜色
   *
   * @param color 字体颜色
   * @return CodeBlockTheme
   */
  setCodeBlockCopyTextFontColor(color: ResourceColor): CodeBlockTheme {
    this.codeBlockCopyTextFontColor = color
    return this
  }

  /**
   * 设置代码块复制文本字体大小
   *
   * @param size 字体大小
   * @return CodeBlockTheme
   */
  setCodeBlockCopyTextFontSize(size: number | string | Resource): CodeBlockTheme {
    this.codeBlockCopyTextFontSize = size
    return this
  }

  /**
   * 设置代码块复制文本字体样式
   *
   * @param style 字体样式
   * @return CodeBlockTheme
   */
  setCodeBlockCopyTextFontStyle(style: FontStyle): CodeBlockTheme {
    this.codeBlockCopyTextFontStyle = style
    return this
  }

  /**
   * 设置代码块复制文本字体粗细
   *
   * @param weight 字体粗细
   * @return CodeBlockTheme
   */
  setCodeBlockCopyTextFontWeight(weight: number | FontWeight): CodeBlockTheme {
    this.codeBlockCopyTextFontWeight = weight
    return this
  }

  /**
   * 设置代码块复制文本字体族
   *
   * @param family 字体族
   * @return CodeBlockTheme
   */
  setCodeBlockCopyTextFontFamily(family: string | Resource): CodeBlockTheme {
    this.codeBlockCopyTextFontFamily = family
    return this
  }

  /**
   * 设置代码块复制文本行高
   *
   * @param height 行高
   * @return CodeBlockTheme
   */
  setCodeBlockCopyTextLineHeight(height: number | string | Resource): CodeBlockTheme {
    this.codeBlockCopyTextLineHeight = height
    return this
  }

  /**
   * 设置代码块全屏按钮是否显示
   *
   * @param isShow 是否显示
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenButtonIsShow(isShow: boolean): CodeBlockTheme {
    this.codeBlockFullScreenButtonIsShow = isShow
    return this
  }

  /**
   * 设置代码块全屏文本是否显示
   *
   * @param isShow 是否显示
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenTextIsShow(isShow: boolean): CodeBlockTheme {
    this.codeBlockFullScreenTextIsShow = isShow
    return this
  }

  /**
   * 设置代码块全屏图标
   *
   * @param icon 图标
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenIcon(icon: Resource): CodeBlockTheme {
    this.codeBlockFullScreenIcon = icon
    return this
  }

  /**
   * 设置代码块全屏图标宽度
   *
   * @param width 宽度
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenIconWidth(width: Length): CodeBlockTheme {
    this.codeBlockFullScreenIconWidth = width
    return this
  }

  /**
   * 设置代码块全屏图标高度
   *
   * @param height 高度
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenIconHeight(height: Length): CodeBlockTheme {
    this.codeBlockFullScreenIconHeight = height
    return this
  }

  /**
   * 设置代码块全屏图标文本间距
   *
   * @param spacing 间距
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenIconTextSpacing(spacing: number): CodeBlockTheme {
    this.codeBlockFullScreenIconTextSpacing = spacing
    return this
  }

  /**
   * 设置代码块全屏文本
   *
   * @param text 全屏文本
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenText(text: string): CodeBlockTheme {
    this.codeBlockFullScreenText = text
    return this
  }

  /**
   * 设置代码块全屏文本字体颜色
   *
   * @param color 字体颜色
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenTextFontColor(color: ResourceColor): CodeBlockTheme {
    this.codeBlockFullScreenTextFontColor = color
    return this
  }

  /**
   * 设置代码块全屏文本字体大小
   *
   * @param size 字体大小
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenTextFontSize(size: number | string | Resource): CodeBlockTheme {
    this.codeBlockFullScreenTextFontSize = size
    return this
  }

  /**
   * 设置代码块全屏文本字体样式
   *
   * @param style 字体样式
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenTextFontStyle(style: FontStyle): CodeBlockTheme {
    this.codeBlockFullScreenTextFontStyle = style
    return this
  }

  /**
   * 设置代码块全屏文本字体粗细
   *
   * @param weight 字体粗细
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenTextFontWeight(weight: number | FontWeight): CodeBlockTheme {
    this.codeBlockFullScreenTextFontWeight = weight
    return this
  }

  /**
   * 设置代码块全屏文本字体族
   *
   * @param family 字体族
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenTextFontFamily(family: string | Resource): CodeBlockTheme {
    this.codeBlockFullScreenTextFontFamily = family
    return this
  }

  /**
   * 设置代码块全屏文本行高
   *
   * @param height 行高
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenTextLineHeight(height: number | string | Resource): CodeBlockTheme {
    this.codeBlockFullScreenTextLineHeight = height
    return this
  }

  /**
   * 设置代码块行号是否显示
   *
   * @param isShow 是否显示
   * @return CodeBlockTheme
   */
  setCodeBlockLineNumberIsShow(isShow: boolean): CodeBlockTheme {
    this.codeBlockLineNumberIsShow = isShow
    return this
  }

  /**
   * 设置代码块行号文本左内边距
   *
   * @param left 左内边距
   * @return CodeBlockTheme
   */
  setCodeBlockLineNumberTextPaddingLeft(left: Length): CodeBlockTheme {
    this.codeBlockLineNumberTextPaddingLeft = left
    return this
  }

  /**
   * 设置代码块行号文本字体颜色
   *
   * @param color 字体颜色
   * @return CodeBlockTheme
   */
  setCodeBlockLineNumberTextFontColor(color: ResourceColor): CodeBlockTheme {
    this.codeBlockLineNumberTextFontColor = color
    return this
  }

  /**
   * 设置代码块行号文本字体大小
   *
   * @param size 字体大小
   * @return CodeBlockTheme
   */
  setCodeBlockLineNumberTextFontSize(size: number | string | Resource): CodeBlockTheme {
    this.codeBlockLineNumberTextFontSize = size
    return this
  }

  /**
   * 设置代码块行号文本字体样式
   *
   * @param style 字体样式
   * @return CodeBlockTheme
   */
  setCodeBlockLineNumberTextFontStyle(style: FontStyle): CodeBlockTheme {
    this.codeBlockLineNumberTextFontStyle = style
    return this
  }

  /**
   * 设置代码块行号文本字体粗细
   *
   * @param weight 字体粗细
   * @return CodeBlockTheme
   */
  setCodeBlockLineNumberTextFontWeight(weight: number | FontWeight): CodeBlockTheme {
    this.codeBlockLineNumberTextFontWeight = weight
    return this
  }

  /**
   * 设置代码块行号文本字体族
   *
   * @param family 字体族
   * @return CodeBlockTheme
   */
  setCodeBlockLineNumberTextFontFamily(family: string | Resource): CodeBlockTheme {
    this.codeBlockLineNumberTextFontFamily = family
    return this
  }

  /**
   * 设置代码块行号文本行高
   *
   * @param height 行高
   * @return CodeBlockTheme
   */
  setCodeBlockLineNumberTextLineHeight(height: number | string | Resource): CodeBlockTheme {
    this.codeBlockLineNumberTextLineHeight = height
    return this
  }

  /**
   * 设置代码块分割线颜色
   *
   * @param color 分割线颜色
   * @return CodeBlockTheme
   */
  setCodeBlockDividerColor(color: ResourceColor): CodeBlockTheme {
    this.codeBlockDividerColor = color
    return this
  }

  /**
   * 设置代码块分割线宽度
   *
   * @param strokeWidth 分割线宽度
   * @return CodeBlockTheme
   */
  setCodeBlockDividerStrokeWidth(strokeWidth: Length): CodeBlockTheme {
    this.codeBlockDividerStrokeWidth = strokeWidth
    return this
  }

  /**
   * 设置代码块行号分割线间距
   *
   * @param spacing 间距
   * @return CodeBlockTheme
   */
  setCodeBlockLineNumberDividerSpacing(spacing: number): CodeBlockTheme {
    this.codeBlockLineNumberDividerSpacing = spacing
    return this
  }

  /**
   * 设置代码块文本右边距
   *
   * @param marginRight 右边距
   * @return CodeBlockTheme
   */
  setCodeBlockTextMarginRight(marginRight: Length): CodeBlockTheme {
    this.codeBlockTextMarginRight = marginRight
    return this
  }

  /**
   * 设置代码块文本左边距
   *
   * @param marginLeft 左边距
   * @return CodeBlockTheme
   */
  setCodeBlockTextMarginLeft(marginLeft: Length): CodeBlockTheme {
    this.codeBlockTextMarginLeft = marginLeft
    return this
  }

  /**
   * 设置代码块文本字体颜色
   *
   * @param color 字体颜色
   * @return CodeBlockTheme
   */
  setCodeBlockTextFontColor(color: ResourceColor): CodeBlockTheme {
    this.codeBlockTextFontColor = color
    return this
  }

  /**
   * 设置代码块文本字体大小
   *
   * @param size 字体大小
   * @return CodeBlockTheme
   */
  setCodeBlockTextFontSize(size: number | string | Resource): CodeBlockTheme {
    this.codeBlockTextFontSize = size
    return this
  }

  /**
   * 设置代码块文本字体样式
   *
   * @param style 字体样式
   * @return CodeBlockTheme
   */
  setCodeBlockTextFontStyle(style: FontStyle): CodeBlockTheme {
    this.codeBlockTextFontStyle = style
    return this
  }

  /**
   * 设置代码块文本字体粗细
   *
   * @param weight 字体粗细
   * @return CodeBlockTheme
   */
  setCodeBlockTextFontWeight(weight: number | FontWeight): CodeBlockTheme {
    this.codeBlockTextFontWeight = weight
    return this
  }

  /**
   * 设置代码块文本字体族
   *
   * @param family 字体族
   * @return CodeBlockTheme
   */
  setCodeBlockTextFontFamily(family: string | Resource): CodeBlockTheme {
    this.codeBlockTextFontFamily = family
    return this
  }

  /**
   * 设置代码块文本行高
   *
   * @param height 行高
   * @return CodeBlockTheme
   */
  setCodeBlockTextLineHeight(height: number | string | Resource): CodeBlockTheme {
    this.codeBlockTextLineHeight = height
    return this
  }

  /**
   * 设置代码块文本字母间距
   *
   * @param spacing 字母间距
   * @return CodeBlockTheme
   */
  setCodeBlockTextLetterSpacing(spacing: number): CodeBlockTheme {
    this.codeBlockTextLetterSpacing = spacing
    return this
  }

  /**
   * 设置代码块列表标题文本大小
   *
   * @param size 文本大小
   * @return CodeBlockTheme
   */
  setCodeBlockListTitleTextSize(size: number): CodeBlockTheme {
    this.codeBlockListTitleTextSize = size
    return this
  }

  /**
   * 设置代码块列表标题选中文本大小
   *
   * @param size 选中文本大小
   * @return CodeBlockTheme
   */
  setCodeBlockListTitleSelectTextSize(size: number): CodeBlockTheme {
    this.codeBlockListTitleSelectTextSize = size
    return this
  }

  /**
   * 设置代码块列表标题选中文本颜色
   *
   * @param color 选中文本颜色
   * @return CodeBlockTheme
   */
  setCodeBlockListTitleSelectTextColor(color: ResourceColor): CodeBlockTheme {
    this.codeBlockListTitleSelectTextColor = color
    return this
  }

  /**
   * 设置代码块列表标题未选中文本颜色
   *
   * @param color 未选中文本颜色
   * @return CodeBlockTheme
   */
  setCodeBlockListTitleUnselectTextColor(color: ResourceColor): CodeBlockTheme {
    this.codeBlockListTitleUnselectTextColor = color
    return this
  }

  /**
   * 设置代码块列表标题选中背景颜色
   *
   * @param color 选中背景颜色
   * @return CodeBlockTheme
   */
  setCodeBlockListTitleSelectBackgroundColor(color: ResourceColor): CodeBlockTheme {
    this.codeBlockListTitleSelectBackgroundColor = color
    return this
  }

  /**
   * 设置代码块列表标题未选中背景颜色
   *
   * @param color 未选中背景颜色
   * @return CodeBlockTheme
   */
  setCodeBlockListTitleUnselectBackgroundColor(color: ResourceColor): CodeBlockTheme {
    this.codeBlockListTitleUnselectBackgroundColor = color
    return this
  }

  /**
   * 设置代码块是否分离
   *
   * @param isSeparate 是否分离
   * @return CodeBlockTheme
   */
  setCodeBlockIsSeparate(isSeparate: boolean): CodeBlockTheme {
    this.codeBlockIsSeparate = isSeparate
    return this
  }

  /**
   * 设置代码块分离宽度
   *
   * @param width 分离宽度
   * @return CodeBlockTheme
   */
  setCodeBlockSeparateWidth(width: Length): CodeBlockTheme {
    this.codeBlockSeparateWidth = width
    return this
  }

  /**
   * 设置代码块分离是否在底部
   *
   * @param isBottom 是否在底部
   * @return CodeBlockTheme
   */
  setCodeBlockSeparateIsBottom(isBottom: boolean): CodeBlockTheme {
    this.codeBlockSeparateIsBottom = isBottom
    return this
  }
}
