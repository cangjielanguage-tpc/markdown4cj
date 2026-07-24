import { MarkdownRadiusOptions } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-链接文本样式
 */
export class LinkTheme {
  /**
   * 链接是否是图片显示
   */
  private linkIsIcon?: boolean = undefined

  /**
   * 列表中的单行链接是否是图片显示
   */
  private linkListIsIcon?: boolean = undefined

  /**
   * 链接文本颜色
   */
  private linkTextFontColor?: number = undefined

  /**
   * 链接文本尺寸
   */
  private linkTextFontSize?: number = undefined

  /**
   * 链接文本字体样式
   */
  private linkTextFontStyle?: FontStyle = undefined

  /**
   * 链接文本字体粗细
   */
  private linkTextFontWeight?: FontWeight = undefined

  /**
   * 链接文本字体
   */
  private linkTextFontFamily?: string = undefined

  /**
   * 链接文本行高
   */
  private linkTextLineHeight?: number = undefined

  /**
   * 链接文本字符间距
   */
  private linkTextLetterSpacing?: number = undefined

  /**
   * 链接文本装饰线类型
   */
  private linkTextDecorationType?: TextDecorationType = undefined

  /**
   * 链接文本装饰线颜色
   */
  private linkTextDecorationColor?: number = undefined

  /**
   * 链接文本装饰线样式
   */
  private linkTextDecorationStyle?: TextDecorationStyle = undefined

  /**
   * 链接文本背景颜色
   */
  private linkTextBackgroundColor?: number = undefined

  /**
   * 链接文本背景左上圆角
   */
  private linkTextBackgroundRadiusTopLeft?: number = undefined

  /**
   * 链接文本背景右上圆角
   */
  private linkTextBackgroundRadiusTopRight?: number = undefined

  /**
   * 链接文本背景左下圆角
   */
  private linkTextBackgroundRadiusBottomLeft?: number = undefined

  /**
   * 链接文本背景右下圆角
   */
  private linkTextBackgroundRadiusBottomRight?: number = undefined

  /**
   * 圆形图片格式链接主题背景颜色
   */
  private linkCircleIconBackgroundColor?: number = undefined

  /**
   * 圆形图片格式链接控件背景颜色
   */
  private linkCircleIconButtonBackgroundColor?: number = undefined

  /**
   * 圆形图片格式链接文字大小
   */
  private linkCircleIconTextSize?: number = undefined

  /**
   * 圆形图片格式链接文字颜色
   */
  private linkCircleIconTextColor?: number = undefined

  /**
   * 圆形图片格式链接半径
   */
  private linkCircleIconRadius?: number = undefined

  /**
   * 圆形图片格式链接左右外边距
   */
  private linkCircleIconMargin?: number = undefined

  /**
   * 圆角矩形图片格式链接主题背景颜色
   */
  private linkRectIconBackgroundColor?: number = undefined

  /**
   * 圆角矩形图片格式链接控件背景颜色
   */
  private linkRectIconButtonBackgroundColor?: number = undefined

  /**
   * 圆角矩形图片格式链接文字大小
   */
  private linkRectIconTextSize?: number = undefined

  /**
   * 圆角矩形图片格式链接文字颜色
   */
  private linkRectIconTextColor?: number = undefined

  /**
   * 圆角矩形图片格式链接控件高度
   */
  private linkRectIconHeight?: number = undefined

  /**
   * 圆角矩形图片格式链接左右内边距
   */
  private linkRectIconPadding?: number = undefined

  /**
   * 圆角矩形图片格式链接圆角半径
   */
  private linkRectIconRadius?: number = undefined

  /**
   * 圆角矩形图片格式链接左右外边距
   */
  private linkRectIconMargin?: number = undefined

  /**
   * 空心圆角矩形图片格式链接主题背景颜色
   */
  private linkRectToolIconBackgroundColor?: number = undefined

  /**
   * 空心圆角矩形图片格式链接控件背景颜色
   */
  private linkRectToolIconButtonBackgroundColor?: number = undefined

  /**
   * 空心圆角矩形图片格式链接文字大小
   */
  private linkRectToolIconTextSize?: number = undefined

  /**
   * 空心圆角矩形图片格式链接控件高度
   */
  private linkRectToolIconHeight?: number = undefined

  /**
   * 空心圆角矩形图片格式链接左右内边距
   */
  private linkRectToolIconPadding?: number = undefined

  /**
   * 空心圆角矩形图片格式链接边框宽度
   */
  private linkRectToolIconBorderWidth?: number = undefined

  /**
   * 空心圆角矩形图片格式链接分割线宽度
   */
  private linkRectToolIconDividingLineWidth?: number = undefined

  /**
   * 空心圆角矩形图片格式链接左右外边距
   */
  private linkRectToolIconMargin?: number = undefined

  /**
   * 空心圆角矩形图片格式分割线和文本左边距
   */
  private linkRectToolIconLineLeftPadding?: number = undefined

  /**
   * 空心圆角矩形图片格式分割线和文本右边距
   */
  private linkRectToolIconLineRightPadding?: number = undefined

  /**
   * 设置链接是否是图片显示
   *
   * @param isIcon 链接是否是图片显示
   */
  setLinkIsIcon(isIcon: boolean): LinkTheme {
    this.linkIsIcon = isIcon
    return this
  }

  /**
   * 设置列表中的单行链接是否是图片显示
   *
   * @param isIcon 列表中的单行链接是否是图片显示
   */
  setLinkListIsIcon(isIcon: boolean): LinkTheme {
    this.linkListIsIcon = isIcon
    return this
  }

  /**
   * 设置链接文本颜色
   *
   * @param color 链接文本颜色
   */
  setLinkTextFontColor(color: number): LinkTheme {
    this.linkTextFontColor = color
    return this
  }

  /**
   * 设置链接文本尺寸
   *
   * @param size 链接文本尺寸
   */
  setLinkTextFontSize(size: number | undefined): LinkTheme {
    this.linkTextFontSize = size
    return this
  }

  /**
   * 设置链接文本字体样式
   *
   * @param style 链接文本字体样式
   */
  setLinkTextFontStyle(style: FontStyle): LinkTheme {
    this.linkTextFontStyle = style
    return this
  }

  /**
   * 设置链接文本字体粗细
   *
   * @param weight 链接文本字体粗细
   */
  setLinkTextFontWeight(weight: FontWeight): LinkTheme {
    this.linkTextFontWeight = weight
    return this
  }

  /**
   * 设置链接文本字体
   *
   * @param family 链接文本字体
   */
  setLinkTextFontFamily(family: string): LinkTheme {
    this.linkTextFontFamily = family
    return this
  }

  /**
   * 设置链接文本行高
   *
   * @param lineHeight 链接文本行高
   */
  setLinkTextLineHeight(lineHeight: number): LinkTheme {
    this.linkTextLineHeight = lineHeight
    return this
  }

  /**
   * 设置链接文本字符间距
   *
   * @param spacing 链接文本字符间距
   */
  setLinkTextLetterSpacing(spacing: number): LinkTheme {
    this.linkTextLetterSpacing = spacing
    return this
  }

  /**
   * 设置链接文本装饰线类型
   *
   * @param decorationType 链接文本装饰线类型
   */
  setLinkTextDecorationType(decorationType: TextDecorationType): LinkTheme {
    this.linkTextDecorationType = decorationType
    return this
  }

  /**
   * 设置链接文本装饰线颜色
   *
   * @param color 链接文本装饰线颜色
   */
  setLinkTextDecorationColor(color: number): LinkTheme {
    this.linkTextDecorationColor = color
    return this
  }

  /**
   * 设置链接文本装饰线样式
   *
   * @param style 链接文本装饰线样式
   */
  setLinkTextDecorationStyle(style: TextDecorationStyle): LinkTheme {
    this.linkTextDecorationStyle = style
    return this
  }

  /**
   * 设置链接文本背景颜色
   *
   * @param color 链接文本背景颜色
   */
  setLinkTextBackgroundColor(color: number): LinkTheme {
    this.linkTextBackgroundColor = color
    return this
  }

  /**
   * 设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setLinkTextBackgroundRadius(options: MarkdownRadiusOptions | number): LinkTheme {
    if (typeof options === 'number') {
      this.linkTextBackgroundRadiusTopLeft = options
      this.linkTextBackgroundRadiusTopRight = options
      this.linkTextBackgroundRadiusBottomLeft = options
      this.linkTextBackgroundRadiusBottomRight = options
    } else {
      if (options.topLeft !== undefined) {
        this.linkTextBackgroundRadiusTopLeft = options.topLeft
      }
      if (options.topRight !== undefined) {
        this.linkTextBackgroundRadiusTopRight = options.topRight
      }
      if (options.bottomLeft !== undefined) {
        this.linkTextBackgroundRadiusBottomLeft = options.bottomLeft
      }
      if (options.bottomRight !== undefined) {
        this.linkTextBackgroundRadiusBottomRight = options.bottomRight
      }
    }
    return this
  }

  /**
   * 设置圆形图片格式链接主题背景颜色
   *
   * @param color 圆形图片格式链接主题背景颜色
   */
  setLinkCircleIconBackgroundColor(color: number): LinkTheme {
    this.linkCircleIconBackgroundColor = color
    return this
  }

  /**
   * 设置圆形图片格式链接控件背景颜色
   *
   * @param color 圆形图片格式链接控件背景颜色
   */
  setLinkCircleIconButtonBackgroundColor(color: number): LinkTheme {
    this.linkCircleIconButtonBackgroundColor = color
    return this
  }

  /**
   * 设置圆形图片格式链接文字大小
   *
   * @param size 圆形图片格式链接文字大小
   */
  setLinkCircleIconTextSize(size: number): LinkTheme {
    this.linkCircleIconTextSize = size
    return this
  }

  /**
   * 设置圆形图片格式链接文字颜色
   *
   * @param color 圆形图片格式链接文字颜色
   */
  setLinkCircleIconTextColor(color: number): LinkTheme {
    this.linkCircleIconTextColor = color
    return this
  }

  /**
   * 设置圆形图片格式链接半径
   *
   * @param radius 圆形图片格式链接半径
   */
  setLinkCircleIconRadius(radius: number): LinkTheme {
    this.linkCircleIconRadius = radius
    return this
  }

  /**
   * 设置圆形图片格式链接左右外边距
   *
   * @param margin 圆形图片格式链接左右外边距
   */
  setLinkCircleIconMargin(margin: number): LinkTheme {
    this.linkCircleIconMargin = margin
    return this
  }

  /**
   * 设置圆角矩形图片格式链接主题背景颜色
   *
   * @param color 圆角矩形图片格式链接主题背景颜色
   */
  setLinkRectIconBackgroundColor(color: number): LinkTheme {
    this.linkRectIconBackgroundColor = color
    return this
  }

  /**
   * 设置圆角矩形图片格式链接控件背景颜色
   *
   * @param color 圆角矩形图片格式链接控件背景颜色
   */
  setLinkRectIconButtonBackgroundColor(color: number): LinkTheme {
    this.linkRectIconButtonBackgroundColor = color
    return this
  }

  /**
   * 设置圆角矩形图片格式链接文字大小
   *
   * @param size 圆角矩形图片格式链接文字大小
   */
  setLinkRectIconTextSize(size: number): LinkTheme {
    this.linkRectIconTextSize = size
    return this
  }

  /**
   * 设置圆角矩形图片格式链接文字颜色
   *
   * @param color 圆角矩形图片格式链接文字颜色
   */
  setLinkRectIconTextColor(color: number): LinkTheme {
    this.linkRectIconTextColor = color
    return this
  }

  /**
   * 设置圆角矩形图片格式链接控件高度
   *
   * @param height 圆角矩形图片格式链接控件高度
   */
  setLinkRectIconHeight(height: number): LinkTheme {
    this.linkRectIconHeight = height
    return this
  }

  /**
   * 设置圆角矩形图片格式链接左右内边距
   *
   * @param padding 圆角矩形图片格式链接左右内边距
   */
  setLinkRectIconPadding(padding: number): LinkTheme {
    this.linkRectIconPadding = padding
    return this
  }

  /**
   * 设置圆角矩形图片格式链接圆角半径
   *
   * @param radius 圆角矩形图片格式链接圆角半径
   */
  setLinkRectIconRadius(radius: number): LinkTheme {
    this.linkRectIconRadius = radius
    return this
  }

  /**
   * 设置圆角矩形图片格式链接左右外边距
   *
   * @param margin 圆角矩形图片格式链接左右外边距
   */
  setLinkRectIconMargin(margin: number): LinkTheme {
    this.linkRectIconMargin = margin
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接主题背景颜色
   *
   * @param color 空心圆角矩形图片格式链接主题背景颜色
   */
  setLinkRectToolIconBackgroundColor(color: number): LinkTheme {
    this.linkRectToolIconBackgroundColor = color
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接控件背景颜色
   *
   * @param color 空心圆角矩形图片格式链接控件背景颜色
   */
  setLinkRectToolIconButtonBackgroundColor(color: number): LinkTheme {
    this.linkRectToolIconButtonBackgroundColor = color
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接文字大小
   *
   * @param size 空心圆角矩形图片格式链接文字大小
   */
  setLinkRectToolIconTextSize(size: number): LinkTheme {
    this.linkRectToolIconTextSize = size
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接控件高度
   *
   * @param height 空心圆角矩形图片格式链接控件高度
   */
  setLinkRectToolIconHeight(height: number): LinkTheme {
    this.linkRectToolIconHeight = height
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接左右内边距
   *
   * @param padding 空心圆角矩形图片格式链接左右内边距
   */
  setLinkRectToolIconPadding(padding: number): LinkTheme {
    this.linkRectToolIconPadding = padding
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接边框宽度
   *
   * @param width 空心圆角矩形图片格式链接边框宽度
   */
  setLinkRectToolIconBorderWidth(width: number): LinkTheme {
    this.linkRectToolIconBorderWidth = width
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接分割线宽度
   *
   * @param width 空心圆角矩形图片格式链接分割线宽度
   */
  setLinkRectToolIconDividingLineWidth(width: number): LinkTheme {
    this.linkRectToolIconDividingLineWidth = width
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接左右外边距
   *
   * @param margin 空心圆角矩形图片格式链接左右外边距
   */
  setLinkRectToolIconMargin(margin: number): LinkTheme {
    this.linkRectToolIconMargin = margin
    return this
  }

  /**
   * 设置空心圆角矩形图片格式分割线和文本左边距
   *
   * @param padding 空心圆角矩形图片格式分割线和文本左边距
   */
  setLinkRectToolIconLineLeftPadding(padding: number): LinkTheme {
    this.linkRectToolIconLineLeftPadding = padding
    return this
  }

  /**
   * 设置空心圆角矩形图片格式分割线和文本右边距
   *
   * @param padding 空心圆角矩形图片格式分割线和文本右边距
   */
  setLinkRectToolIconLineRightPadding(padding: number): LinkTheme {
    this.linkRectToolIconLineRightPadding = padding
    return this
  }

  /**
   * 获取linkIsIcon
   *
   * @returns linkIsIcon
   */
  getLinkIsIcon(): boolean | undefined {
    return this.linkIsIcon
  }

  /**
   * 获取linkListIsIcon
   *
   * @returns linkListIsIcon
   */
  getLinkListIsIcon(): boolean | undefined {
    return this.linkListIsIcon
  }

  /**
   * 获取linkTextFontColor
   *
   * @returns linkTextFontColor
   */
  getLinkTextFontColor(): number | undefined {
    return this.linkTextFontColor
  }

  /**
   * 获取linkTextFontSize
   *
   * @returns linkTextFontSize
   */
  getLinkTextFontSize(): number | undefined {
    return this.linkTextFontSize
  }

  /**
   * 获取linkTextFontStyle
   *
   * @returns linkTextFontStyle
   */
  getLinkTextFontStyle(): FontStyle | undefined {
    return this.linkTextFontStyle
  }

  /**
   * 获取linkTextFontWeight
   *
   * @returns linkTextFontWeight
   */
  getLinkTextFontWeight(): FontWeight | undefined {
    return this.linkTextFontWeight
  }

  /**
   * 获取linkTextFontFamily
   *
   * @returns linkTextFontFamily
   */
  getLinkTextFontFamily(): string | undefined {
    return this.linkTextFontFamily
  }

  /**
   * 获取linkTextLineHeight
   *
   * @returns linkTextLineHeight
   */
  getLinkTextLineHeight(): number | undefined {
    return this.linkTextLineHeight
  }

  /**
   * 获取linkTextLetterSpacing
   *
   * @returns linkTextLetterSpacing
   */
  getLinkTextLetterSpacing(): number | undefined {
    return this.linkTextLetterSpacing
  }

  /**
   * 获取linkTextDecorationType
   *
   * @returns linkTextDecorationType
   */
  getLinkTextDecorationType(): TextDecorationType | undefined {
    return this.linkTextDecorationType
  }

  /**
   * 获取linkTextDecorationColor
   *
   * @returns linkTextDecorationColor
   */
  getLinkTextDecorationColor(): number | undefined {
    return this.linkTextDecorationColor
  }

  /**
   * 获取linkTextDecorationStyle
   *
   * @returns linkTextDecorationStyle
   */
  getLinkTextDecorationStyle(): TextDecorationStyle | undefined {
    return this.linkTextDecorationStyle
  }

  /**
   * 获取linkTextBackgroundColor
   *
   * @returns linkTextBackgroundColor
   */
  getLinkTextBackgroundColor(): number | undefined {
    return this.linkTextBackgroundColor
  }

  /**
   * 获取linkTextBackgroundRadiusTopLeft
   *
   * @returns linkTextBackgroundRadiusTopLeft
   */
  getLinkTextBackgroundRadiusTopLeft(): number | undefined {
    return this.linkTextBackgroundRadiusTopLeft
  }

  /**
   * 获取linkTextBackgroundRadiusTopRight
   *
   * @returns linkTextBackgroundRadiusTopRight
   */
  getLinkTextBackgroundRadiusTopRight(): number | undefined {
    return this.linkTextBackgroundRadiusTopRight
  }

  /**
   * 获取linkTextBackgroundRadiusBottomLeft
   *
   * @returns linkTextBackgroundRadiusBottomLeft
   */
  getLinkTextBackgroundRadiusBottomLeft(): number | undefined {
    return this.linkTextBackgroundRadiusBottomLeft
  }

  /**
   * 获取linkTextBackgroundRadiusBottomRight
   *
   * @returns linkTextBackgroundRadiusBottomRight
   */
  getLinkTextBackgroundRadiusBottomRight(): number | undefined {
    return this.linkTextBackgroundRadiusBottomRight
  }

  /**
   * 获取linkCircleIconBackgroundColor
   *
   * @returns linkCircleIconBackgroundColor
   */
  getLinkCircleIconBackgroundColor(): number | undefined {
    return this.linkCircleIconBackgroundColor
  }

  /**
   * 获取linkCircleIconButtonBackgroundColor
   *
   * @returns linkCircleIconButtonBackgroundColor
   */
  getLinkCircleIconButtonBackgroundColor(): number | undefined {
    return this.linkCircleIconButtonBackgroundColor
  }

  /**
   * 获取linkCircleIconTextSize
   *
   * @returns linkCircleIconTextSize
   */
  getLinkCircleIconTextSize(): number | undefined {
    return this.linkCircleIconTextSize
  }

  /**
   * 获取linkCircleIconTextColor
   *
   * @returns linkCircleIconTextColor
   */
  getLinkCircleIconTextColor(): number | undefined {
    return this.linkCircleIconTextColor
  }

  /**
   * 获取linkCircleIconRadius
   *
   * @returns linkCircleIconRadius
   */
  getLinkCircleIconRadius(): number | undefined {
    return this.linkCircleIconRadius
  }

  /**
   * 获取linkCircleIconMargin
   *
   * @returns linkCircleIconMargin
   */
  getLinkCircleIconMargin(): number | undefined {
    return this.linkCircleIconMargin
  }

  /**
   * 获取linkRectIconBackgroundColor
   *
   * @returns linkRectIconBackgroundColor
   */
  getLinkRectIconBackgroundColor(): number | undefined {
    return this.linkRectIconBackgroundColor
  }

  /**
   * 获取linkRectIconButtonBackgroundColor
   *
   * @returns linkRectIconButtonBackgroundColor
   */
  getLinkRectIconButtonBackgroundColor(): number | undefined {
    return this.linkRectIconButtonBackgroundColor
  }

  /**
   * 获取linkRectIconTextSize
   *
   * @returns linkRectIconTextSize
   */
  getLinkRectIconTextSize(): number | undefined {
    return this.linkRectIconTextSize
  }

  /**
   * 获取linkRectIconTextColor
   *
   * @returns linkRectIconTextColor
   */
  getLinkRectIconTextColor(): number | undefined {
    return this.linkRectIconTextColor
  }

  /**
   * 获取linkRectIconHeight
   *
   * @returns linkRectIconHeight
   */
  getLinkRectIconHeight(): number | undefined {
    return this.linkRectIconHeight
  }

  /**
   * 获取linkRectIconPadding
   *
   * @returns linkRectIconPadding
   */
  getLinkRectIconPadding(): number | undefined {
    return this.linkRectIconPadding
  }

  /**
   * 获取linkRectIconRadius
   *
   * @returns linkRectIconRadius
   */
  getLinkRectIconRadius(): number | undefined {
    return this.linkRectIconRadius
  }

  /**
   * 获取linkRectIconMargin
   *
   * @returns linkRectIconMargin
   */
  getLinkRectIconMargin(): number | undefined {
    return this.linkRectIconMargin
  }

  /**
   * 获取linkRectToolIconBackgroundColor
   *
   * @returns linkRectToolIconBackgroundColor
   */
  getLinkRectToolIconBackgroundColor(): number | undefined {
    return this.linkRectToolIconBackgroundColor
  }

  /**
   * 获取linkRectToolIconButtonBackgroundColor
   *
   * @returns linkRectToolIconButtonBackgroundColor
   */
  getLinkRectToolIconButtonBackgroundColor(): number | undefined {
    return this.linkRectToolIconButtonBackgroundColor
  }

  /**
   * 获取linkRectToolIconTextSize
   *
   * @returns linkRectToolIconTextSize
   */
  getLinkRectToolIconTextSize(): number | undefined {
    return this.linkRectToolIconTextSize
  }

  /**
   * 获取linkRectToolIconHeight
   *
   * @returns linkRectToolIconHeight
   */
  getLinkRectToolIconHeight(): number | undefined {
    return this.linkRectToolIconHeight
  }

  /**
   * 获取linkRectToolIconPadding
   *
   * @returns linkRectToolIconPadding
   */
  getLinkRectToolIconPadding(): number | undefined {
    return this.linkRectToolIconPadding
  }

  /**
   * 获取linkRectToolIconBorderWidth
   *
   * @returns linkRectToolIconBorderWidth
   */
  getLinkRectToolIconBorderWidth(): number | undefined {
    return this.linkRectToolIconBorderWidth
  }

  /**
   * 获取linkRectToolIconDividingLineWidth
   *
   * @returns linkRectToolIconDividingLineWidth
   */
  getLinkRectToolIconDividingLineWidth(): number | undefined {
    return this.linkRectToolIconDividingLineWidth
  }

  /**
   * 获取linkRectToolIconMargin
   *
   * @returns linkRectToolIconMargin
   */
  getLinkRectToolIconMargin(): number | undefined {
    return this.linkRectToolIconMargin
  }

  /**
   * 获取linkRectToolIconLineLeftPadding
   *
   * @returns linkRectToolIconLineLeftPadding
   */
  getLinkRectToolIconLineLeftPadding(): number | undefined {
    return this.linkRectToolIconLineLeftPadding
  }

  /**
   * 获取linkRectToolIconLineRightPadding
   *
   * @returns linkRectToolIconLineRightPadding
   */
  getLinkRectToolIconLineRightPadding(): number | undefined {
    return this.linkRectToolIconLineRightPadding
  }
}
