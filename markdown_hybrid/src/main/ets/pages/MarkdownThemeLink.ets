/**
 * Markdown用户可设置的样式-链接文本样式
 */
export class MarkdownThemeLink {
  /**
   * 链接是否是图片显示
   */
  linkIsIcon?: boolean = undefined

  /**
   * 列表中的单行链接是否是图片显示
   */
  linkListIsIcon?: boolean = undefined

  /**
   * 链接文本颜色
   */
  linkTextFontColor?: number = undefined

  /**
   * 链接文本尺寸
   */
  linkTextFontSize?: number = undefined

  /**
   * 链接文本字体样式
   */
  linkTextFontStyle?: FontStyle = undefined

  /**
   * 链接文本字体粗细
   */
  linkTextFontWeight?: FontWeight = undefined

  /**
   * 链接文本字体
   */
  linkTextFontFamily?: string = undefined

  /**
   * 链接文本行高
   */
  linkTextLineHeight?: number = undefined

  /**
   * 链接文本字符间距
   */
  linkTextLetterSpacing?: number = undefined

  /**
   * 链接文本装饰线类型
   */
  linkTextDecorationType?: TextDecorationType = undefined

  /**
   * 链接文本装饰线颜色
   */
  linkTextDecorationColor?: number = undefined

  /**
   * 链接文本装饰线样式
   */
  linkTextDecorationStyle?: TextDecorationStyle = undefined

  /**
   * 链接文本背景颜色
   */
  linkTextBackgroundColor?: number = undefined

  /**
   * 链接文本背景左上圆角
   */
  linkTextBackgroundRadiusTopLeft?: number = undefined

  /**
   * 链接文本背景右上圆角
   */
  linkTextBackgroundRadiusTopRight?: number = undefined

  /**
   * 链接文本背景左下圆角
   */
  linkTextBackgroundRadiusBottomLeft?: number = undefined

  /**
   * 链接文本背景右下圆角
   */
  linkTextBackgroundRadiusBottomRight?: number = undefined

  /**
   * 圆形图片格式链接主题背景颜色
   */
  linkCircleIconBackgroundColor?: number = undefined

  /**
   * 圆形图片格式链接控件背景颜色
   */
  linkCircleIconButtonBackgroundColor?: number = undefined

  /**
   * 圆形图片格式链接文字大小
   */
  linkCircleIconTextSize?: number = undefined

  /**
   * 圆形图片格式链接文字颜色
   */
  linkCircleIconTextColor?: number = undefined

  /**
   * 圆形图片格式链接半径
   */
  linkCircleIconRadius?: number = undefined

  /**
   * 圆形图片格式链接左右外边距
   */
  linkCircleIconMargin?: number = undefined

  /**
   * 圆角矩形图片格式链接主题背景颜色
   */
  linkRectIconBackgroundColor?: number = undefined

  /**
   * 圆角矩形图片格式链接控件背景颜色
   */
  linkRectIconButtonBackgroundColor?: number = undefined

  /**
   * 圆角矩形图片格式链接文字大小
   */
  linkRectIconTextSize?: number = undefined

  /**
   * 圆角矩形图片格式链接文字颜色
   */
  linkRectIconTextColor?: number = undefined

  /**
   * 圆角矩形图片格式链接控件高度
   */
  linkRectIconHeight?: number = undefined

  /**
   * 圆角矩形图片格式链接左右内边距
   */
  linkRectIconPadding?: number = undefined

  /**
   * 圆角矩形图片格式链接圆角半径
   */
  linkRectIconRadius?: number = undefined

  /**
   * 圆角矩形图片格式链接左右外边距
   */
  linkRectIconMargin?: number = undefined

  /**
   * 空心圆角矩形图片格式链接主题背景颜色
   */
  linkRectToolIconBackgroundColor?: number = undefined

  /**
   * 空心圆角矩形图片格式链接控件背景颜色
   */
  linkRectToolIconButtonBackgroundColor?: number = undefined

  /**
   * 空心圆角矩形图片格式链接文字大小
   */
  linkRectToolIconTextSize?: number = undefined

  /**
   * 空心圆角矩形图片格式链接控件高度
   */
  linkRectToolIconHeight?: number = undefined

  /**
   * 空心圆角矩形图片格式链接左右内边距
   */
  linkRectToolIconPadding?: number = undefined

  /**
   * 空心圆角矩形图片格式链接边框宽度
   */
  linkRectToolIconBorderWidth?: number = undefined

  /**
   * 空心圆角矩形图片格式链接分割线宽度
   */
  linkRectToolIconDividingLineWidth?: number = undefined

  /**
   * 空心圆角矩形图片格式链接左右外边距
   */
  linkRectToolIconMargin?: number = undefined

  /**
   * 空心圆角矩形图片格式分割线和文本左边距
   */
  linkRectToolIconLineLeftPadding?: number = undefined

  /**
   * 空心圆角矩形图片格式分割线和文本右边距
   */
  linkRectToolIconLineRightPadding?: number = undefined

  /**
   * 设置链接是否是图片显示
   *
   * @param isIcon 链接是否是图片显示
   */
  setLinkIsIcon(isIcon: boolean): void {
    this.linkIsIcon = isIcon
  }

  /**
   * 设置列表中的单行链接是否是图片显示
   *
   * @param isIcon 列表中的单行链接是否是图片显示
   */
  setLinkListIsIcon(isIcon: boolean): void {
    this.linkListIsIcon = isIcon
  }

  /**
   * 设置链接文本颜色
   *
   * @param color 链接文本颜色
   */
  setLinkTextFontColor(color: number): void {
    this.linkTextFontColor = color
  }

  /**
   * 设置链接文本尺寸
   *
   * @param size 链接文本尺寸
   */
  setLinkTextFontSize(size: number): void {
    this.linkTextFontSize = size
  }

  /**
   * 设置链接文本字体样式
   *
   * @param style 链接文本字体样式
   */
  setLinkTextFontStyle(style: FontStyle): void {
    this.linkTextFontStyle = style
  }

  /**
   * 设置链接文本字体粗细
   *
   * @param weight 链接文本字体粗细
   */
  setLinkTextFontWeight(weight: FontWeight): void {
    this.linkTextFontWeight = weight
  }

  /**
   * 设置链接文本字体
   *
   * @param family 链接文本字体
   */
  setLinkTextFontFamily(family: string): void {
    this.linkTextFontFamily = family
  }

  /**
   * 设置链接文本行高
   *
   * @param lineHeight 链接文本行高
   */
  setLinkTextLineHeight(lineHeight: number): void {
    this.linkTextLineHeight = lineHeight
  }

  /**
   * 设置链接文本字符间距
   *
   * @param spacing 链接文本字符间距
   */
  setLinkTextLetterSpacing(spacing: number): void {
    this.linkTextLetterSpacing = spacing
  }

  /**
   * 设置链接文本装饰线类型
   *
   * @param decorationType 链接文本装饰线类型
   */
  setLinkTextDecorationType(decorationType: TextDecorationType): void {
    this.linkTextDecorationType = decorationType
  }

  /**
   * 设置链接文本装饰线颜色
   *
   * @param color 链接文本装饰线颜色
   */
  setLinkTextDecorationColor(color: number): void {
    this.linkTextDecorationColor = color
  }

  /**
   * 设置链接文本装饰线样式
   *
   * @param style 链接文本装饰线样式
   */
  setLinkTextDecorationStyle(style: TextDecorationStyle): void {
    this.linkTextDecorationStyle = style
  }

  /**
   * 设置链接文本背景颜色
   *
   * @param color 链接文本背景颜色
   */
  setLinkTextBackgroundColor(color: number): void {
    this.linkTextBackgroundColor = color
  }

  /**
   * 统一设置链接文本背景四个圆角
   *
   * @param radius 统一圆角半径，同时赋值给四个角
   */
  setLinkTextBackgroundAllRadius(radius: number): void {
    this.linkTextBackgroundRadiusTopLeft = radius
    this.linkTextBackgroundRadiusTopRight = radius
    this.linkTextBackgroundRadiusBottomLeft = radius
    this.linkTextBackgroundRadiusBottomRight = radius
  }

  /**
   * 分别设置4个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setLinkTextBackgroundRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void {
    this.linkTextBackgroundRadiusTopLeft = topLeft
    this.linkTextBackgroundRadiusTopRight = topRight
    this.linkTextBackgroundRadiusBottomLeft = bottomLeft
    this.linkTextBackgroundRadiusBottomRight = bottomRight
  }

  /**
   * 设置圆形图片格式链接主题背景颜色
   *
   * @param color 圆形图片格式链接主题背景颜色
   */
  setLinkCircleIconBackgroundColor(color: number): void {
    this.linkCircleIconBackgroundColor = color
  }

  /**
   * 设置圆形图片格式链接控件背景颜色
   *
   * @param color 圆形图片格式链接控件背景颜色
   */
  setLinkCircleIconButtonBackgroundColor(color: number): void {
    this.linkCircleIconButtonBackgroundColor = color
  }

  /**
   * 设置圆形图片格式链接文字大小
   *
   * @param size 圆形图片格式链接文字大小
   */
  setLinkCircleIconTextSize(size: number): void {
    this.linkCircleIconTextSize = size
  }

  /**
   * 设置圆形图片格式链接文字颜色
   *
   * @param color 圆形图片格式链接文字颜色
   */
  setLinkCircleIconTextColor(color: number): void {
    this.linkCircleIconTextColor = color
  }

  /**
   * 设置圆形图片格式链接半径
   *
   * @param radius 圆形图片格式链接半径
   */
  setLinkCircleIconRadius(radius: number): void {
    this.linkCircleIconRadius = radius
  }

  /**
   * 设置圆形图片格式链接左右外边距
   *
   * @param margin 圆形图片格式链接左右外边距
   */
  setLinkCircleIconMargin(margin: number): void {
    this.linkCircleIconMargin = margin
  }

  /**
   * 设置圆角矩形图片格式链接主题背景颜色
   *
   * @param color 圆角矩形图片格式链接主题背景颜色
   */
  setLinkRectIconBackgroundColor(color: number): void {
    this.linkRectIconBackgroundColor = color
  }

  /**
   * 设置圆角矩形图片格式链接控件背景颜色
   *
   * @param color 圆角矩形图片格式链接控件背景颜色
   */
  setLinkRectIconButtonBackgroundColor(color: number): void {
    this.linkRectIconButtonBackgroundColor = color
  }

  /**
   * 设置圆角矩形图片格式链接文字大小
   *
   * @param size 圆角矩形图片格式链接文字大小
   */
  setLinkRectIconTextSize(size: number): void {
    this.linkRectIconTextSize = size
  }

  /**
   * 设置圆角矩形图片格式链接文字颜色
   *
   * @param color 圆角矩形图片格式链接文字颜色
   */
  setLinkRectIconTextColor(color: number): void {
    this.linkRectIconTextColor = color
  }

  /**
   * 设置圆角矩形图片格式链接控件高度
   *
   * @param height 圆角矩形图片格式链接控件高度
   */
  setLinkRectIconHeight(height: number): void {
    this.linkRectIconHeight = height
  }

  /**
   * 设置圆角矩形图片格式链接左右内边距
   *
   * @param padding 圆角矩形图片格式链接左右内边距
   */
  setLinkRectIconPadding(padding: number): void {
    this.linkRectIconPadding = padding
  }

  /**
   * 设置圆角矩形图片格式链接圆角半径
   *
   * @param radius 圆角矩形图片格式链接圆角半径
   */
  setLinkRectIconRadius(radius: number): void {
    this.linkRectIconRadius = radius
  }

  /**
   * 设置圆角矩形图片格式链接左右外边距
   *
   * @param margin 圆角矩形图片格式链接左右外边距
   */
  setLinkRectIconMargin(margin: number): void {
    this.linkRectIconMargin = margin
  }

  /**
   * 设置空心圆角矩形图片格式链接主题背景颜色
   *
   * @param color 空心圆角矩形图片格式链接主题背景颜色
   */
  setLinkRectToolIconBackgroundColor(color: number): void {
    this.linkRectToolIconBackgroundColor = color
  }

  /**
   * 设置空心圆角矩形图片格式链接控件背景颜色
   *
   * @param color 空心圆角矩形图片格式链接控件背景颜色
   */
  setLinkRectToolIconButtonBackgroundColor(color: number): void {
    this.linkRectToolIconButtonBackgroundColor = color
  }

  /**
   * 设置空心圆角矩形图片格式链接文字大小
   *
   * @param size 空心圆角矩形图片格式链接文字大小
   */
  setLinkRectToolIconTextSize(size: number): void {
    this.linkRectToolIconTextSize = size
  }

  /**
   * 设置空心圆角矩形图片格式链接控件高度
   *
   * @param height 空心圆角矩形图片格式链接控件高度
   */
  setLinkRectToolIconHeight(height: number): void {
    this.linkRectToolIconHeight = height
  }

  /**
   * 设置空心圆角矩形图片格式链接左右内边距
   *
   * @param padding 空心圆角矩形图片格式链接左右内边距
   */
  setLinkRectToolIconPadding(padding: number): void {
    this.linkRectToolIconPadding = padding
  }

  /**
   * 设置空心圆角矩形图片格式链接边框宽度
   *
   * @param width 空心圆角矩形图片格式链接边框宽度
   */
  setLinkRectToolIconBorderWidth(width: number): void {
    this.linkRectToolIconBorderWidth = width
  }

  /**
   * 设置空心圆角矩形图片格式链接分割线宽度
   *
   * @param width 空心圆角矩形图片格式链接分割线宽度
   */
  setLinkRectToolIconDividingLineWidth(width: number): void {
    this.linkRectToolIconDividingLineWidth = width
  }

  /**
   * 设置空心圆角矩形图片格式链接左右外边距
   *
   * @param margin 空心圆角矩形图片格式链接左右外边距
   */
  setLinkRectToolIconMargin(margin: number): void {
    this.linkRectToolIconMargin = margin
  }

  /**
   * 设置空心圆角矩形图片格式分割线和文本左边距
   *
   * @param padding 空心圆角矩形图片格式分割线和文本左边距
   */
  setLinkRectToolIconLineLeftPadding(padding: number): void {
    this.linkRectToolIconLineLeftPadding = padding
  }

  /**
   * 设置空心圆角矩形图片格式分割线和文本右边距
   *
   * @param padding 空心圆角矩形图片格式分割线和文本右边距
   */
  setLinkRectToolIconLineRightPadding(padding: number): void {
    this.linkRectToolIconLineRightPadding = padding
  }
}
