import { ImageFitType } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-图片样式
 */
export class MarkdownThemeImage {
  /**
   * 图片上外边距
   */
  imageMarginTop?: number = undefined

  /**
   * 图片右外边距
   */
  imageMarginRight?: number = undefined

  /**
   * 图片下外边距
   */
  imageMarginBottom?: number = undefined

  /**
   * 图片左外边距
   */
  imageMarginLeft?: number = undefined

  /**
   * 图片边框左上圆角
   */
  imageRadiusTopLeft?: number = undefined

  /**
   * 图片边框右上圆角
   */
  imageRadiusTopRight?: number = undefined

  /**
   * 图片边框左下圆角
   */
  imageRadiusBottomLeft?: number = undefined

  /**
   * 图片边框右下圆角
   */
  imageRadiusBottomRight?: number = undefined

  /**
   * 图片边框样式
   */
  imageBorderStyle?: BorderStyle = undefined

  /**
   * 图片边框宽度
   */
  imageBorderWidth?: number = undefined

  /**
   * 图片边框颜色
   */
  imageBorderColor?: number = undefined

  /**
   * 图片默认占位图
   */
  imagePlaceholder?: Resource = undefined

  /**
   * 网络图片是否压缩
   */
  imageAutoResize?: boolean = undefined

  /**
   * 是否图文混排
   */
  isImageMixedLayout?: boolean = undefined

  /**
   * 图片基于自身宽度缩放百分比
   */
  imageMaximumWidth?: number = undefined

  /**
   * 图片基于父布局宽度缩放百分比
   */
  imageFixedRatioWidth?: number = undefined

  /**
   * 图片最大高度
   */
  imageMaxHeight?: number = undefined

  /**
   * 图片高度
   */
  imageHeight?: number = undefined

  /**
   * 图片最大宽度
   */
  imageMaxWidth?: number = undefined

  /**
   * 图片宽度
   */
  imageWidth?: number = undefined

  /**
   * 图片缩放类型
   */
  imageFitType?: ImageFitType = undefined

  /**
   * 底部布局距离图片上边距
   */
  imageBottomLayoutMarginTop?: number = undefined

  /**
   * 图片下载按钮是否显示
   */
  imageDownloadButtonVisible?: boolean = undefined

  /**
   * 图片下载按钮宽度
   */
  imageDownloadButtonWidth?: number = undefined

  /**
   * 图片下载按钮高度
   */
  imageDownloadButtonHeight?: number = undefined

  /**
   * 图片下载按钮左上圆角
   */
  imageDownloadButtonRadiusTopLeft?: number = undefined

  /**
   * 图片下载按钮右上圆角
   */
  imageDownloadButtonRadiusTopRight?: number = undefined

  /**
   * 图片下载按钮左下圆角
   */
  imageDownloadButtonRadiusBottomLeft?: number = undefined

  /**
   * 图片下载按钮右下圆角
   */
  imageDownloadButtonRadiusBottomRight?: number = undefined

  /**
   * 图片下载按钮图标
   */
  imageDownloadButtonIcon?: Resource = undefined

  /**
   * 图片下载按钮图标宽度
   */
  imageDownloadButtonIconWidth?: number = undefined

  /**
   * 图片下载按钮图标高度
   */
  imageDownloadButtonIconHeight?: number = undefined

  /**
   * 图片下载按钮图标和文本间距
   */
  imageDownloadButtonIconTextGap?: number = undefined

  /**
   * 图片下载按钮背景颜色
   */
  imageDownloadButtonBackgroundColor?: number = undefined

  /**
   * 图片下载按钮默认文本内容
   */
  imageDownloadButtonText?: string = undefined

  /**
   * 图片下载按钮文本颜色
   */
  imageDownloadButtonTextFontColor?: number = undefined

  /**
   * 图片下载按钮文本尺寸
   */
  imageDownloadButtonTextFontSize?: number = undefined

  /**
   * 图片下载按钮文本字体样式
   */
  imageDownloadButtonTextFontStyle?: FontStyle = undefined

  /**
   * 图片下载按钮文本字体粗细
   */
  imageDownloadButtonTextFontWeight?: FontWeight = undefined

  /**
   * 图片下载按钮文本字体
   */
  imageDownloadButtonTextFontFamily?: string = undefined

  /**
   * 图片下载按钮文本行高
   */
  imageDownloadButtonTextLineHeight?: number = undefined

  /**
   * 设置4个外边距为统一值
   *
   * @param margin 外边距
   */
  setImageAllMargin(margin: number): void {
    this.imageMarginTop = margin
    this.imageMarginRight = margin
    this.imageMarginBottom = margin
    this.imageMarginLeft = margin
  }

  /**
   * 分别设置4个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setImageMargin(top?: number, right?: number, bottom?: number, left?: number): void {
    this.imageMarginTop = top
    this.imageMarginRight = right
    this.imageMarginBottom = bottom
    this.imageMarginLeft = left
  }

  /**
   * 设置4个圆角为统一值
   *
   * @param radius 圆角
   */
  setImageAllRadius(radius: number): void {
    this.imageRadiusTopLeft = radius
    this.imageRadiusTopRight = radius
    this.imageRadiusBottomLeft = radius
    this.imageRadiusBottomRight = radius
  }

  /**
   * 分别设置4个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setImageRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void {
    this.imageRadiusTopLeft = topLeft
    this.imageRadiusTopRight = topRight
    this.imageRadiusBottomLeft = bottomLeft
    this.imageRadiusBottomRight = bottomRight
  }

  /**
   * 设置图片边框样式
   *
   * @param borderStyle 图片边框样式
   */
  setImageBorderStyle(borderStyle: BorderStyle): void {
    this.imageBorderStyle = borderStyle
  }

  /**
   * 设置图片边框宽度
   *
   * @param borderWidth 图片边框宽度
   */
  setImageBorderWidth(borderWidth: number): void {
    this.imageBorderWidth = borderWidth
  }

  /**
   * 设置图片边框颜色
   *
   * @param borderColor 图片边框颜色
   */
  setImageBorderColor(borderColor: number): void {
    this.imageBorderColor = borderColor
  }

  /**
   * 设置图片默认占位图
   *
   * @param placeholder 图片默认占位图
   */
  setImagePlaceholder(placeholder: Resource): void {
    this.imagePlaceholder = placeholder
  }

  /**
   * 设置网络图片是否压缩
   *
   * @param imageAutoResize 网络图片是否压缩
   */
  setImageAutoResize(imageAutoResize: boolean): void {
    this.imageAutoResize = imageAutoResize
  }

  /**
   * 设置是否图文混排
   *
   * @param mixedLayout 是否图文混排
   */
  setIsImageMixedLayout(mixedLayout: boolean): void {
    this.isImageMixedLayout = mixedLayout
  }

  /**
   * 设置图片基于自身宽度缩放百分比
   *
   * @param maximumWidth 图片基于自身宽度缩放百分比
   */
  setImageMaximumWidth(maximumWidth: number): void {
    this.imageMaximumWidth = maximumWidth
  }

  /**
   * 设置图片基于父布局宽度缩放百分比
   *
   * @param fixedRatioWidth 图片基于父布局宽度缩放百分比
   */
  setImageFixedRatioWidth(fixedRatioWidth: number): void {
    this.imageFixedRatioWidth = fixedRatioWidth
  }

  /**
   * 设置图片最大高度
   *
   * @param maxHeight 图片最大高度
   */
  setImageMaxHeight(maxHeight: number): void {
    this.imageMaxHeight = maxHeight
  }

  /**
   * 设置图片高度
   *
   * @param height 图片高度
   */
  setImageHeight(height: number): void {
    this.imageHeight = height
  }

  /**
   * 设置图片最大宽度
   *
   * @param maxWidth 图片最大宽度
   */
  setImageMaxWidth(maxWidth: number): void {
    this.imageMaxWidth = maxWidth
  }

  /**
   * 设置图片宽度
   *
   * @param width 图片宽度
   */
  setImageWidth(width: number): void {
    this.imageWidth = width
  }

  /**
   * 设置图片缩放类型
   *
   * @param fitType 图片缩放类型
   */
  setImageFitType(fitType: ImageFitType): void {
    this.imageFitType = fitType
  }

  /**
   * 设置底部布局距离图片上边距
   *
   * @param marginTop 底部布局距离图片上边距
   */
  setImageBottomLayoutMarginTop(marginTop: number): void {
    this.imageBottomLayoutMarginTop = marginTop
  }

  /**
   * 设置图片下载按钮是否显示
   *
   * @param visible 图片下载按钮是否显示
   */
  setImageDownloadButtonVisible(visible: boolean): void {
    this.imageDownloadButtonVisible = visible
  }

  /**
   * 设置图片下载按钮宽度
   *
   * @param width 图片下载按钮宽度
   */
  setImageDownloadButtonWidth(width: number): void {
    this.imageDownloadButtonWidth = width
  }

  /**
   * 设置图片下载按钮高度
   *
   * @param height 图片下载按钮高度
   */
  setImageDownloadButtonHeight(height: number): void {
    this.imageDownloadButtonHeight = height
  }

  /**
   * 设置图片下载按钮4个圆角为统一值
   *
   * @param radius 圆角
   */
  setImageDownloadButtonAllRadius(radius: number): void {
    this.imageDownloadButtonRadiusTopLeft = radius
    this.imageDownloadButtonRadiusTopRight = radius
    this.imageDownloadButtonRadiusBottomLeft = radius
    this.imageDownloadButtonRadiusBottomRight = radius
  }

  /**
   * 分别设置图片下载按钮4个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setImageDownloadButtonRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void {
    this.imageDownloadButtonRadiusTopLeft = topLeft
    this.imageDownloadButtonRadiusTopRight = topRight
    this.imageDownloadButtonRadiusBottomLeft = bottomLeft
    this.imageDownloadButtonRadiusBottomRight = bottomRight
  }

  /**
   * 设置图片下载按钮图标
   *
   * @param icon 图片下载按钮图标
   */
  setImageDownloadButtonIcon(icon: Resource): void {
    this.imageDownloadButtonIcon = icon
  }

  /**
   * 设置图片下载按钮图标宽度
   *
   * @param width 图片下载按钮图标宽度
   */
  setImageDownloadButtonIconWidth(width: number): void {
    this.imageDownloadButtonIconWidth = width
  }

  /**
   * 设置图片下载按钮图标高度
   *
   * @param height 图片下载按钮图标高度
   */
  setImageDownloadButtonIconHeight(height: number): void {
    this.imageDownloadButtonIconHeight = height
  }

  /**
   * 设置图片下载按钮图标和文本间距
   *
   * @param gap 图片下载按钮图标和文本间距
   */
  setImageDownloadButtonIconTextGap(gap: number): void {
    this.imageDownloadButtonIconTextGap = gap
  }

  /**
   * 设置图片下载按钮背景颜色
   *
   * @param color 图片下载按钮背景颜色
   */
  setImageDownloadButtonBackgroundColor(color: number): void {
    this.imageDownloadButtonBackgroundColor = color
  }

  /**
   * 设置图片下载按钮默认文本内容
   *
   * @param text 图片下载按钮默认文本内容
   */
  setImageDownloadButtonText(text: string): void {
    this.imageDownloadButtonText = text
  }

  /**
   * 设置图片下载按钮文本颜色
   *
   * @param color 图片下载按钮文本颜色
   */
  setImageDownloadButtonTextFontColor(color: number): void {
    this.imageDownloadButtonTextFontColor = color
  }

  /**
   * 设置图片下载按钮文本尺寸
   *
   * @param size 图片下载按钮文本尺寸
   */
  setImageDownloadButtonTextFontSize(size: number): void {
    this.imageDownloadButtonTextFontSize = size
  }

  /**
   * 设置图片下载按钮文本字体样式
   *
   * @param style 图片下载按钮文本字体样式
   */
  setImageDownloadButtonTextFontStyle(style: FontStyle): void {
    this.imageDownloadButtonTextFontStyle = style
  }

  /**
   * 设置图片下载按钮文本字体粗细
   *
   * @param weight 图片下载按钮文本字体粗细
   */
  setImageDownloadButtonTextFontWeight(weight: FontWeight): void {
    this.imageDownloadButtonTextFontWeight = weight
  }

  /**
   * 设置图片下载按钮文本字体
   *
   * @param family 图片下载按钮文本字体
   */
  setImageDownloadButtonTextFontFamily(family: string): void {
    this.imageDownloadButtonTextFontFamily = family
  }

  /**
   * 设置图片下载按钮文本行高
   *
   * @param lineHeight 图片下载按钮文本行高
   */
  setImageDownloadButtonTextLineHeight(lineHeight: number): void {
    this.imageDownloadButtonTextLineHeight = lineHeight
  }
}
