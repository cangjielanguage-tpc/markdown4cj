import { ImageFitType } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-图片样式
 */
export class MarkdownThemeImage {
  /**
   * 图片上外边距
   */
  private imageMarginTop?: number = undefined

  /**
   * 图片右外边距
   */
  private imageMarginRight?: number = undefined

  /**
   * 图片下外边距
   */
  private imageMarginBottom?: number = undefined

  /**
   * 图片左外边距
   */
  private imageMarginLeft?: number = undefined

  /**
   * 图片边框左上圆角
   */
  private imageRadiusTopLeft?: number = undefined

  /**
   * 图片边框右上圆角
   */
  private imageRadiusTopRight?: number = undefined

  /**
   * 图片边框左下圆角
   */
  private imageRadiusBottomLeft?: number = undefined

  /**
   * 图片边框右下圆角
   */
  private imageRadiusBottomRight?: number = undefined

  /**
   * 图片边框样式
   */
  private imageBorderStyle?: BorderStyle = undefined

  /**
   * 图片边框宽度
   */
  private imageBorderWidth?: number = undefined

  /**
   * 图片边框颜色
   */
  private imageBorderColor?: number = undefined

  /**
   * 图片默认占位图
   */
  private imagePlaceholder?: Resource = undefined

  /**
   * 网络图片是否压缩
   */
  private imageAutoResize?: boolean = undefined

  /**
   * 是否图文混排
   */
  private isImageMixedLayout?: boolean = undefined

  /**
   * 图片基于自身宽度缩放百分比
   */
  private imageMaximumWidth?: number = undefined

  /**
   * 图片基于父布局宽度缩放百分比
   */
  private imageFixedRatioWidth?: number = undefined

  /**
   * 图片最大高度
   */
  private imageMaxHeight?: number = undefined

  /**
   * 图片高度
   */
  private imageHeight?: number = undefined

  /**
   * 图片最大宽度
   */
  private imageMaxWidth?: number = undefined

  /**
   * 图片宽度
   */
  private imageWidth?: number = undefined

  /**
   * 图片缩放类型
   */
  private imageFitType?: ImageFitType = undefined

  /**
   * 底部布局距离图片上边距
   */
  private imageBottomLayoutMarginTop?: number = undefined

  /**
   * 图片下载按钮是否显示
   */
  private imageDownloadButtonVisible?: boolean = undefined

  /**
   * 图片下载按钮宽度
   */
  private imageDownloadButtonWidth?: number = undefined

  /**
   * 图片下载按钮高度
   */
  private imageDownloadButtonHeight?: number = undefined

  /**
   * 图片下载按钮左上圆角
   */
  private imageDownloadButtonRadiusTopLeft?: number = undefined

  /**
   * 图片下载按钮右上圆角
   */
  private imageDownloadButtonRadiusTopRight?: number = undefined

  /**
   * 图片下载按钮左下圆角
   */
  private imageDownloadButtonRadiusBottomLeft?: number = undefined

  /**
   * 图片下载按钮右下圆角
   */
  private imageDownloadButtonRadiusBottomRight?: number = undefined

  /**
   * 图片下载按钮图标
   */
  private imageDownloadButtonIcon?: Resource = undefined

  /**
   * 图片下载按钮图标宽度
   */
  private imageDownloadButtonIconWidth?: number = undefined

  /**
   * 图片下载按钮图标高度
   */
  private imageDownloadButtonIconHeight?: number = undefined

  /**
   * 图片下载按钮图标和文本间距
   */
  private imageDownloadButtonIconTextGap?: number = undefined

  /**
   * 图片下载按钮背景颜色
   */
  private imageDownloadButtonBackgroundColor?: number = undefined

  /**
   * 图片下载按钮默认文本内容
   */
  private imageDownloadButtonText?: string = undefined

  /**
   * 图片下载按钮文本颜色
   */
  private imageDownloadButtonTextFontColor?: number = undefined

  /**
   * 图片下载按钮文本尺寸
   */
  private imageDownloadButtonTextFontSize?: number = undefined

  /**
   * 图片下载按钮文本字体样式
   */
  private imageDownloadButtonTextFontStyle?: FontStyle = undefined

  /**
   * 图片下载按钮文本字体粗细
   */
  private imageDownloadButtonTextFontWeight?: FontWeight = undefined

  /**
   * 图片下载按钮文本字体
   */
  private imageDownloadButtonTextFontFamily?: string = undefined

  /**
   * 图片下载按钮文本行高
   */
  private imageDownloadButtonTextLineHeight?: number = undefined

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
  setImageBorderAllRadius(radius: number): void {
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
  setImageBorderRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void {
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

  /**
   * 获取imageMarginTop
   *
   * @returns imageMarginTop
   */
  getImageMarginTop(): number | undefined {
    return this.imageMarginTop
  }

  /**
   * 获取imageMarginRight
   *
   * @returns imageMarginRight
   */
  getImageMarginRight(): number | undefined {
    return this.imageMarginRight
  }

  /**
   * 获取imageMarginBottom
   *
   * @returns imageMarginBottom
   */
  getImageMarginBottom(): number | undefined {
    return this.imageMarginBottom
  }

  /**
   * 获取imageMarginLeft
   *
   * @returns imageMarginLeft
   */
  getImageMarginLeft(): number | undefined {
    return this.imageMarginLeft
  }

  /**
   * 获取imageRadiusTopLeft
   *
   * @returns imageRadiusTopLeft
   */
  getImageRadiusTopLeft(): number | undefined {
    return this.imageRadiusTopLeft
  }

  /**
   * 获取imageRadiusTopRight
   *
   * @returns imageRadiusTopRight
   */
  getImageRadiusTopRight(): number | undefined {
    return this.imageRadiusTopRight
  }

  /**
   * 获取imageRadiusBottomLeft
   *
   * @returns imageRadiusBottomLeft
   */
  getImageRadiusBottomLeft(): number | undefined {
    return this.imageRadiusBottomLeft
  }

  /**
   * 获取imageRadiusBottomRight
   *
   * @returns imageRadiusBottomRight
   */
  getImageRadiusBottomRight(): number | undefined {
    return this.imageRadiusBottomRight
  }

  /**
   * 获取imageBorderStyle
   *
   * @returns imageBorderStyle
   */
  getImageBorderStyle(): BorderStyle | undefined {
    return this.imageBorderStyle
  }

  /**
   * 获取imageBorderWidth
   *
   * @returns imageBorderWidth
   */
  getImageBorderWidth(): number | undefined {
    return this.imageBorderWidth
  }

  /**
   * 获取imageBorderColor
   *
   * @returns imageBorderColor
   */
  getImageBorderColor(): number | undefined {
    return this.imageBorderColor
  }

  /**
   * 获取imagePlaceholder
   *
   * @returns imagePlaceholder
   */
  getImagePlaceholder(): Resource | undefined {
    return this.imagePlaceholder
  }

  /**
   * 获取imageAutoResize
   *
   * @returns imageAutoResize
   */
  getImageAutoResize(): boolean | undefined {
    return this.imageAutoResize
  }

  /**
   * 获取isImageMixedLayout
   *
   * @returns isImageMixedLayout
   */
  getIsImageMixedLayout(): boolean | undefined {
    return this.isImageMixedLayout
  }

  /**
   * 获取imageMaximumWidth
   *
   * @returns imageMaximumWidth
   */
  getImageMaximumWidth(): number | undefined {
    return this.imageMaximumWidth
  }

  /**
   * 获取imageFixedRatioWidth
   *
   * @returns imageFixedRatioWidth
   */
  getImageFixedRatioWidth(): number | undefined {
    return this.imageFixedRatioWidth
  }

  /**
   * 获取imageMaxHeight
   *
   * @returns imageMaxHeight
   */
  getImageMaxHeight(): number | undefined {
    return this.imageMaxHeight
  }

  /**
   * 获取imageHeight
   *
   * @returns imageHeight
   */
  getImageHeight(): number | undefined {
    return this.imageHeight
  }

  /**
   * 获取imageMaxWidth
   *
   * @returns imageMaxWidth
   */
  getImageMaxWidth(): number | undefined {
    return this.imageMaxWidth
  }

  /**
   * 获取imageWidth
   *
   * @returns imageWidth
   */
  getImageWidth(): number | undefined {
    return this.imageWidth
  }

  /**
   * 获取imageFitType
   *
   * @returns imageFitType
   */
  getImageFitType(): ImageFitType | undefined {
    return this.imageFitType
  }

  /**
   * 获取imageBottomLayoutMarginTop
   *
   * @returns imageBottomLayoutMarginTop
   */
  getImageBottomLayoutMarginTop(): number | undefined {
    return this.imageBottomLayoutMarginTop
  }

  /**
   * 获取imageDownloadButtonVisible
   *
   * @returns imageDownloadButtonVisible
   */
  getImageDownloadButtonVisible(): boolean | undefined {
    return this.imageDownloadButtonVisible
  }

  /**
   * 获取imageDownloadButtonWidth
   *
   * @returns imageDownloadButtonWidth
   */
  getImageDownloadButtonWidth(): number | undefined {
    return this.imageDownloadButtonWidth
  }

  /**
   * 获取imageDownloadButtonHeight
   *
   * @returns imageDownloadButtonHeight
   */
  getImageDownloadButtonHeight(): number | undefined {
    return this.imageDownloadButtonHeight
  }

  /**
   * 获取imageDownloadButtonRadiusTopLeft
   *
   * @returns imageDownloadButtonRadiusTopLeft
   */
  getImageDownloadButtonRadiusTopLeft(): number | undefined {
    return this.imageDownloadButtonRadiusTopLeft
  }

  /**
   * 获取imageDownloadButtonRadiusTopRight
   *
   * @returns imageDownloadButtonRadiusTopRight
   */
  getImageDownloadButtonRadiusTopRight(): number | undefined {
    return this.imageDownloadButtonRadiusTopRight
  }

  /**
   * 获取imageDownloadButtonRadiusBottomLeft
   *
   * @returns imageDownloadButtonRadiusBottomLeft
   */
  getImageDownloadButtonRadiusBottomLeft(): number | undefined {
    return this.imageDownloadButtonRadiusBottomLeft
  }

  /**
   * 获取imageDownloadButtonRadiusBottomRight
   *
   * @returns imageDownloadButtonRadiusBottomRight
   */
  getImageDownloadButtonRadiusBottomRight(): number | undefined {
    return this.imageDownloadButtonRadiusBottomRight
  }

  /**
   * 获取imageDownloadButtonIcon
   *
   * @returns imageDownloadButtonIcon
   */
  getImageDownloadButtonIcon(): Resource | undefined {
    return this.imageDownloadButtonIcon
  }

  /**
   * 获取imageDownloadButtonIconWidth
   *
   * @returns imageDownloadButtonIconWidth
   */
  getImageDownloadButtonIconWidth(): number | undefined {
    return this.imageDownloadButtonIconWidth
  }

  /**
   * 获取imageDownloadButtonIconHeight
   *
   * @returns imageDownloadButtonIconHeight
   */
  getImageDownloadButtonIconHeight(): number | undefined {
    return this.imageDownloadButtonIconHeight
  }

  /**
   * 获取imageDownloadButtonIconTextGap
   *
   * @returns imageDownloadButtonIconTextGap
   */
  getImageDownloadButtonIconTextGap(): number | undefined {
    return this.imageDownloadButtonIconTextGap
  }

  /**
   * 获取imageDownloadButtonBackgroundColor
   *
   * @returns imageDownloadButtonBackgroundColor
   */
  getImageDownloadButtonBackgroundColor(): number | undefined {
    return this.imageDownloadButtonBackgroundColor
  }

  /**
   * 获取imageDownloadButtonText
   *
   * @returns imageDownloadButtonText
   */
  getImageDownloadButtonText(): string | undefined {
    return this.imageDownloadButtonText
  }

  /**
   * 获取imageDownloadButtonTextFontColor
   *
   * @returns imageDownloadButtonTextFontColor
   */
  getImageDownloadButtonTextFontColor(): number | undefined {
    return this.imageDownloadButtonTextFontColor
  }

  /**
   * 获取imageDownloadButtonTextFontSize
   *
   * @returns imageDownloadButtonTextFontSize
   */
  getImageDownloadButtonTextFontSize(): number | undefined {
    return this.imageDownloadButtonTextFontSize
  }

  /**
   * 获取imageDownloadButtonTextFontStyle
   *
   * @returns imageDownloadButtonTextFontStyle
   */
  getImageDownloadButtonTextFontStyle(): FontStyle | undefined {
    return this.imageDownloadButtonTextFontStyle
  }

  /**
   * 获取imageDownloadButtonTextFontWeight
   *
   * @returns imageDownloadButtonTextFontWeight
   */
  getImageDownloadButtonTextFontWeight(): FontWeight | undefined {
    return this.imageDownloadButtonTextFontWeight
  }

  /**
   * 获取imageDownloadButtonTextFontFamily
   *
   * @returns imageDownloadButtonTextFontFamily
   */
  getImageDownloadButtonTextFontFamily(): string | undefined {
    return this.imageDownloadButtonTextFontFamily
  }

  /**
   * 获取imageDownloadButtonTextLineHeight
   *
   * @returns imageDownloadButtonTextLineHeight
   */
  getImageDownloadButtonTextLineHeight(): number | undefined {
    return this.imageDownloadButtonTextLineHeight
  }
}
