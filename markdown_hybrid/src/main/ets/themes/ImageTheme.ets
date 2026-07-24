import { ImageFitType, MarkdownMarginOptions, MarkdownRadiusOptions } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-图片样式
 */
export class ImageTheme {
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
   * 设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setImageMargin(options: MarkdownMarginOptions | number): ImageTheme {
    if (typeof options === "number") {
      this.imageMarginTop = options
      this.imageMarginRight = options
      this.imageMarginBottom = options
      this.imageMarginLeft = options
    } else {
      if (options.top !== undefined) {
        this.imageMarginTop = options.top
      }
      if (options.right !== undefined) {
        this.imageMarginRight = options.right
      }
      if (options.bottom !== undefined) {
        this.imageMarginBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.imageMarginLeft = options.left
      }
    }
    return this
  }

  /**
   * 设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setImageBorderRadius(options: MarkdownRadiusOptions | number): ImageTheme {
    if (typeof options === "number") {
      this.imageRadiusTopLeft = options
      this.imageRadiusTopRight = options
      this.imageRadiusBottomLeft = options
      this.imageRadiusBottomRight = options
    } else {
      if (options.topLeft !== undefined) {
        this.imageRadiusTopLeft = options.topLeft
      }
      if (options.topRight !== undefined) {
        this.imageRadiusTopRight = options.topRight
      }
      if (options.bottomLeft !== undefined) {
        this.imageRadiusBottomLeft = options.bottomLeft
      }
      if (options.bottomRight !== undefined) {
        this.imageRadiusBottomRight = options.bottomRight
      }
    }
    return this
  }

  /**
   * 设置图片边框样式
   *
   * @param borderStyle 图片边框样式
   */
  setImageBorderStyle(borderStyle: BorderStyle): ImageTheme {
    this.imageBorderStyle = borderStyle
    return this
  }

  /**
   * 设置图片边框宽度
   *
   * @param borderWidth 图片边框宽度
   */
  setImageBorderWidth(borderWidth: number): ImageTheme {
    this.imageBorderWidth = borderWidth
    return this
  }

  /**
   * 设置图片边框颜色
   *
   * @param borderColor 图片边框颜色
   */
  setImageBorderColor(borderColor: number): ImageTheme {
    this.imageBorderColor = borderColor
    return this
  }

  /**
   * 设置图片默认占位图
   *
   * @param placeholder 图片默认占位图
   */
  setImagePlaceholder(placeholder: Resource): ImageTheme {
    this.imagePlaceholder = placeholder
    return this
  }

  /**
   * 设置网络图片是否压缩
   *
   * @param imageAutoResize 网络图片是否压缩
   */
  setImageAutoResize(imageAutoResize: boolean): ImageTheme {
    this.imageAutoResize = imageAutoResize
    return this
  }

  /**
   * 设置是否图文混排
   *
   * @param mixedLayout 是否图文混排
   */
  setIsImageMixedLayout(mixedLayout: boolean): ImageTheme {
    this.isImageMixedLayout = mixedLayout
    return this
  }

  /**
   * 设置图片基于自身宽度缩放百分比
   *
   * @param maximumWidth 图片基于自身宽度缩放百分比
   */
  setImageMaximumWidth(maximumWidth: number): ImageTheme {
    this.imageMaximumWidth = maximumWidth
    return this
  }

  /**
   * 设置图片基于父布局宽度缩放百分比
   *
   * @param fixedRatioWidth 图片基于父布局宽度缩放百分比
   */
  setImageFixedRatioWidth(fixedRatioWidth: number): ImageTheme {
    this.imageFixedRatioWidth = fixedRatioWidth
    return this
  }

  /**
   * 设置图片最大高度
   *
   * @param maxHeight 图片最大高度
   */
  setImageMaxHeight(maxHeight: number): ImageTheme {
    this.imageMaxHeight = maxHeight
    return this
  }

  /**
   * 设置图片高度
   *
   * @param height 图片高度
   */
  setImageHeight(height: number): ImageTheme {
    this.imageHeight = height
    return this
  }

  /**
   * 设置图片最大宽度
   *
   * @param maxWidth 图片最大宽度
   */
  setImageMaxWidth(maxWidth: number): ImageTheme {
    this.imageMaxWidth = maxWidth
    return this
  }

  /**
   * 设置图片宽度
   *
   * @param width 图片宽度
   */
  setImageWidth(width: number): ImageTheme {
    this.imageWidth = width
    return this
  }

  /**
   * 设置图片缩放类型
   *
   * @param fitType 图片缩放类型
   */
  setImageFitType(fitType: ImageFitType): ImageTheme {
    this.imageFitType = fitType
    return this
  }

  /**
   * 设置底部布局距离图片上边距
   *
   * @param marginTop 底部布局距离图片上边距
   */
  setImageBottomLayoutMarginTop(marginTop: number): ImageTheme {
    this.imageBottomLayoutMarginTop = marginTop
    return this
  }

  /**
   * 设置图片下载按钮是否显示
   *
   * @param visible 图片下载按钮是否显示
   */
  setImageDownloadButtonVisible(visible: boolean): ImageTheme {
    this.imageDownloadButtonVisible = visible
    return this
  }

  /**
   * 设置图片下载按钮宽度
   *
   * @param width 图片下载按钮宽度
   */
  setImageDownloadButtonWidth(width: number): ImageTheme {
    this.imageDownloadButtonWidth = width
    return this
  }

  /**
   * 设置图片下载按钮高度
   *
   * @param height 图片下载按钮高度
   */
  setImageDownloadButtonHeight(height: number): ImageTheme {
    this.imageDownloadButtonHeight = height
    return this
  }

  /**
   * 设置图片下载按钮圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setImageDownloadButtonRadius(options: MarkdownRadiusOptions | number): ImageTheme {
    if (typeof options === 'number') {
      this.imageDownloadButtonRadiusTopLeft = options
      this.imageDownloadButtonRadiusTopRight = options
      this.imageDownloadButtonRadiusBottomLeft = options
      this.imageDownloadButtonRadiusBottomRight = options
    } else {
      if (options.topLeft !== undefined) {
        this.imageDownloadButtonRadiusTopLeft = options.topLeft
      }
      if (options.topRight !== undefined) {
        this.imageDownloadButtonRadiusTopRight = options.topRight
      }
      if (options.bottomLeft !== undefined) {
        this.imageDownloadButtonRadiusBottomLeft = options.bottomLeft
      }
      if (options.bottomRight !== undefined) {
        this.imageDownloadButtonRadiusBottomRight = options.bottomRight
      }
    }
    return this
  }

  /**
   * 设置图片下载按钮图标
   *
   * @param icon 图片下载按钮图标
   */
  setImageDownloadButtonIcon(icon: Resource): ImageTheme {
    this.imageDownloadButtonIcon = icon
    return this
  }

  /**
   * 设置图片下载按钮图标宽度
   *
   * @param width 图片下载按钮图标宽度
   */
  setImageDownloadButtonIconWidth(width: number): ImageTheme {
    this.imageDownloadButtonIconWidth = width
    return this
  }

  /**
   * 设置图片下载按钮图标高度
   *
   * @param height 图片下载按钮图标高度
   */
  setImageDownloadButtonIconHeight(height: number): ImageTheme {
    this.imageDownloadButtonIconHeight = height
    return this
  }

  /**
   * 设置图片下载按钮图标和文本间距
   *
   * @param gap 图片下载按钮图标和文本间距
   */
  setImageDownloadButtonIconTextGap(gap: number): ImageTheme {
    this.imageDownloadButtonIconTextGap = gap
    return this
  }

  /**
   * 设置图片下载按钮背景颜色
   *
   * @param color 图片下载按钮背景颜色
   */
  setImageDownloadButtonBackgroundColor(color: number): ImageTheme {
    this.imageDownloadButtonBackgroundColor = color
    return this
  }

  /**
   * 设置图片下载按钮默认文本内容
   *
   * @param text 图片下载按钮默认文本内容
   */
  setImageDownloadButtonText(text: string): ImageTheme {
    this.imageDownloadButtonText = text
    return this
  }

  /**
   * 设置图片下载按钮文本颜色
   *
   * @param color 图片下载按钮文本颜色
   */
  setImageDownloadButtonTextFontColor(color: number): ImageTheme {
    this.imageDownloadButtonTextFontColor = color
    return this
  }

  /**
   * 设置图片下载按钮文本尺寸
   *
   * @param size 图片下载按钮文本尺寸
   */
  setImageDownloadButtonTextFontSize(size: number): ImageTheme {
    this.imageDownloadButtonTextFontSize = size
    return this
  }

  /**
   * 设置图片下载按钮文本字体样式
   *
   * @param style 图片下载按钮文本字体样式
   */
  setImageDownloadButtonTextFontStyle(style: FontStyle): ImageTheme {
    this.imageDownloadButtonTextFontStyle = style
    return this
  }

  /**
   * 设置图片下载按钮文本字体粗细
   *
   * @param weight 图片下载按钮文本字体粗细
   */
  setImageDownloadButtonTextFontWeight(weight: FontWeight): ImageTheme {
    this.imageDownloadButtonTextFontWeight = weight
    return this
  }

  /**
   * 设置图片下载按钮文本字体
   *
   * @param family 图片下载按钮文本字体
   */
  setImageDownloadButtonTextFontFamily(family: string): ImageTheme {
    this.imageDownloadButtonTextFontFamily = family
    return this
  }

  /**
   * 设置图片下载按钮文本行高
   *
   * @param lineHeight 图片下载按钮文本行高
   */
  setImageDownloadButtonTextLineHeight(lineHeight: number): ImageTheme {
    this.imageDownloadButtonTextLineHeight = lineHeight
    return this
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
