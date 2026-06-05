import { MarkdownMarginOptions, MarkdownPaddingOptions, MarkdownRadiusOptions } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-视频样式
 */
export class VideoTheme {
  /**
   * 视频背景颜色
   */
  private videoBackgroundColor?: number = undefined

  /**
   * 视频上外边距
   */
  private videoMarginTop?: number = undefined

  /**
   * 视频右外边距
   */
  private videoMarginRight?: number = undefined

  /**
   * 视频下外边距
   */
  private videoMarginBottom?: number = undefined

  /**
   * 视频左外边距
   */
  private videoMarginLeft?: number = undefined

  /**
   * 视频上内边距
   */
  private videoPaddingTop?: number = undefined

  /**
   * 视频右内边距
   */
  private videoPaddingRight?: number = undefined

  /**
   * 视频下内边距
   */
  private videoPaddingBottom?: number = undefined

  /**
   * 视频左内边距
   */
  private videoPaddingLeft?: number = undefined

  /**
   * 视频边框左上圆角
   */
  private videoRadiusTopLeft?: number = undefined

  /**
   * 视频边框右上圆角
   */
  private videoRadiusTopRight?: number = undefined

  /**
   * 视频边框左下圆角
   */
  private videoRadiusBottomLeft?: number = undefined

  /**
   * 视频边框右下圆角
   */
  private videoRadiusBottomRight?: number = undefined

  /**
   * 视频边框样式
   */
  private videoBorderStyle?: BorderStyle = undefined

  /**
   * 视频边框宽度
   */
  private videoBorderWidth?: number = undefined

  /**
   * 视频边框颜色
   */
  private videoBorderColor?: number = undefined

  /**
   * 视频占位图
   */
  private videoPlaceholder?: Resource = undefined

  /**
   * 视频图片缩放类型
   */
  private videoImageFitType?: ImageFit = undefined

  /**
   * 播放按钮默认图片
   */
  private videoPlayIcon?: Resource = undefined

  /**
   * 播放按钮图标宽度
   */
  private videoPlayIconWidth?: number = undefined

  /**
   * 播放按钮图标高度
   */
  private videoPlayIconHeight?: number = undefined

  /**
   * 播放按钮图标缩放类型
   */
  private videoPlayIconFitType?: ImageFit = undefined

  /**
   * 视频时间文本颜色
   */
  private videoTimeTextFontColor?: number = undefined

  /**
   * 视频时间文本尺寸
   */
  private videoTimeTextFontSize?: number = undefined

  /**
   * 视频时间文本字体样式
   */
  private videoTimeTextFontStyle?: FontStyle = undefined

  /**
   * 视频时间文本字体粗细
   */
  private videoTimeTextFontWeight?: FontWeight = undefined

  /**
   * 视频时间文本字体
   */
  private videoTimeTextFontFamily?: string = undefined

  /**
   * 视频时间文本行高
   */
  private videoTimeTextLineHeight?: number = undefined

  /**
   * 视频时间文本居右边距
   */
  private videoTimeTextMarginRight?: number = undefined

  /**
   * 视频时间文本居底边距
   */
  private videoTimeTextMarginBottom?: number = undefined

  /**
   * 底部布局是否显示（视频发布/下载按钮）
   */
  private videoBottomLayoutVisible?: boolean = undefined

  /**
   * 底部布局距离视频上边距
   */
  private videoBottomLayoutMarginTop?: number = undefined

  /**
   * 视频发布按钮是否显示
   */
  private videoReleaseButtonVisible?: boolean = undefined

  /**
   * 视频发布按钮背景颜色
   */
  private videoReleaseButtonBackgroundColor?: number = undefined

  /**
   * 视频发布按钮宽度
   */
  private videoReleaseButtonWidth?: number = undefined

  /**
   * 视频发布按钮高度
   */
  private videoReleaseButtonHeight?: number = undefined

  /**
   * 视频发布按钮左上圆角
   */
  private videoReleaseButtonRadiusTopLeft?: number = undefined

  /**
   * 视频发布按钮右上圆角
   */
  private videoReleaseButtonRadiusTopRight?: number = undefined

  /**
   * 视频发布按钮左下圆角
   */
  private videoReleaseButtonRadiusBottomLeft?: number = undefined

  /**
   * 视频发布按钮右下圆角
   */
  private videoReleaseButtonRadiusBottomRight?: number = undefined

  /**
   * 视频发布按钮图标和文本间距
   */
  private videoReleaseButtonIconTextGap?: number = undefined

  /**
   * 视频发布按钮图标
   */
  private videoReleaseButtonIcon?: Resource = undefined

  /**
   * 视频发布按钮图标宽度
   */
  private videoReleaseButtonIconWidth?: number = undefined

  /**
   * 视频发布按钮图标高度
   */
  private videoReleaseButtonIconHeight?: number = undefined

  /**
   * 视频发布按钮默认文本内容
   */
  private videoReleaseButtonText?: string = undefined

  /**
   * 视频发布按钮文本颜色
   */
  private videoReleaseButtonTextFontColor?: number = undefined

  /**
   * 视频发布按钮文本尺寸
   */
  private videoReleaseButtonTextFontSize?: number = undefined

  /**
   * 视频发布按钮文本字体样式
   */
  private videoReleaseButtonTextFontStyle?: FontStyle = undefined

  /**
   * 视频发布按钮文本字体粗细
   */
  private videoReleaseButtonTextFontWeight?: FontWeight = undefined

  /**
   * 视频发布按钮文本字体
   */
  private videoReleaseButtonTextFontFamily?: string = undefined

  /**
   * 视频发布按钮文本行高
   */
  private videoReleaseButtonTextLineHeight?: number = undefined

  /**
   * 视频下载按钮是否显示
   */
  private videoDownloadButtonVisible?: boolean = undefined

  /**
   * 视频下载按钮背景颜色
   */
  private videoDownloadButtonBackgroundColor?: number = undefined

  /**
   * 视频下载按钮宽度
   */
  private videoDownloadButtonWidth?: number = undefined

  /**
   * 视频下载按钮高度
   */
  private videoDownloadButtonHeight?: number = undefined

  /**
   * 视频下载按钮左上圆角
   */
  private videoDownloadButtonRadiusTopLeft?: number = undefined

  /**
   * 视频下载按钮右上圆角
   */
  private videoDownloadButtonRadiusTopRight?: number = undefined

  /**
   * 视频下载按钮左下圆角
   */
  private videoDownloadButtonRadiusBottomLeft?: number = undefined

  /**
   * 视频下载按钮右下圆角
   */
  private videoDownloadButtonRadiusBottomRight?: number = undefined

  /**
   * 视频下载按钮图标和文本间距
   */
  private videoDownloadButtonIconTextGap?: number = undefined

  /**
   * 视频下载按钮图标
   */
  private videoDownloadButtonIcon?: Resource = undefined

  /**
   * 视频下载按钮图标宽度
   */
  private videoDownloadButtonIconWidth?: number = undefined

  /**
   * 视频下载按钮图标高度
   */
  private videoDownloadButtonIconHeight?: number = undefined

  /**
   * 视频下载按钮默认文本内容
   */
  private videoDownloadButtonText?: string = undefined

  /**
   * 视频下载按钮文本颜色
   */
  private videoDownloadButtonTextFontColor?: number = undefined

  /**
   * 视频下载按钮文本尺寸
   */
  private videoDownloadButtonTextFontSize?: number = undefined

  /**
   * 视频下载按钮文本字体样式
   */
  private videoDownloadButtonTextFontStyle?: FontStyle = undefined

  /**
   * 视频下载按钮文本字体粗细
   */
  private videoDownloadButtonTextFontWeight?: FontWeight = undefined

  /**
   * 视频下载按钮文本字体
   */
  private videoDownloadButtonTextFontFamily?: string = undefined

  /**
   * 视频下载按钮文本行高
   */
  private videoDownloadButtonTextLineHeight?: number = undefined

  /**
   * 设置视频背景颜色
   *
   * @param color 视频背景颜色
   */
  setVideoBackgroundColor(color: number): void {
    this.videoBackgroundColor = color
  }

  /**
   * 设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setVideoMargin(options: MarkdownMarginOptions | number): void {
    if (typeof options === 'number') {
      this.videoMarginTop = options
      this.videoMarginRight = options
      this.videoMarginBottom = options
      this.videoMarginLeft = options
    } else {
      if (options.top !== undefined) {
        this.videoMarginTop = options.top
      }
      if (options.right !== undefined) {
        this.videoMarginRight = options.right
      }
      if (options.bottom !== undefined) {
        this.videoMarginBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.videoMarginLeft = options.left
      }
    }
  }

  /**
   * 设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setVideoPadding(options: MarkdownPaddingOptions | number): void {
    if (typeof options === 'number') {
      this.videoPaddingTop = options
      this.videoPaddingRight = options
      this.videoPaddingBottom = options
      this.videoPaddingLeft = options
    } else {
      if (options.top !== undefined) {
        this.videoPaddingTop = options.top
      }
      if (options.right !== undefined) {
        this.videoPaddingRight = options.right
      }
      if (options.bottom !== undefined) {
        this.videoPaddingBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.videoPaddingLeft = options.left
      }
    }
  }

  /**
   * 设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setVideoBorderRadius(options: MarkdownRadiusOptions | number): void {
    if (typeof options === 'number') {
      this.videoRadiusTopLeft = options
      this.videoRadiusTopRight = options
      this.videoRadiusBottomLeft = options
      this.videoRadiusBottomRight = options
    } else {
      if (options.topLeft !== undefined) {
        this.videoRadiusTopLeft = options.topLeft
      }
      if (options.topRight !== undefined) {
        this.videoRadiusTopRight = options.topRight
      }
      if (options.bottomLeft !== undefined) {
        this.videoRadiusBottomLeft = options.bottomLeft
      }
      if (options.bottomRight !== undefined) {
        this.videoRadiusBottomRight = options.bottomRight
      }
    }
  }

  /**
   * 设置视频边框样式
   *
   * @param borderStyle 视频边框样式
   */
  setVideoBorderStyle(borderStyle: BorderStyle): void {
    this.videoBorderStyle = borderStyle
  }

  /**
   * 设置视频边框宽度
   *
   * @param borderWidth 视频边框宽度
   */
  setVideoBorderWidth(borderWidth: number): void {
    this.videoBorderWidth = borderWidth
  }

  /**
   * 设置视频边框颜色
   *
   * @param borderColor 视频边框颜色
   */
  setVideoBorderColor(borderColor: number): void {
    this.videoBorderColor = borderColor
  }

  /**
   * 设置视频占位图
   *
   * @param resource 视频占位图
   */
  setVideoPlaceholder(resource: Resource): void {
    this.videoPlaceholder = resource
  }

  /**
   * 设置视频图片缩放类型
   *
   * @param fitType 视频图片缩放类型
   */
  setVideoImageFitType(fitType: ImageFit): void {
    this.videoImageFitType = fitType
  }

  /**
   * 设置播放按钮默认图片
   *
   * @param icon 播放按钮默认图片
   */
  setVideoPlayIcon(icon: Resource): void {
    this.videoPlayIcon = icon
  }

  /**
   * 设置播放按钮图标宽度
   *
   * @param width 播放按钮图标宽度
   */
  setVideoPlayIconWidth(width: number): void {
    this.videoPlayIconWidth = width
  }

  /**
   * 设置播放按钮图标高度
   *
   * @param height 播放按钮图标高度
   */
  setVideoPlayIconHeight(height: number): void {
    this.videoPlayIconHeight = height
  }

  /**
   * 设置播放按钮图标缩放类型
   *
   * @param fitType 播放按钮图标缩放类型
   */
  setVideoPlayIconFitType(fitType: ImageFit): void {
    this.videoPlayIconFitType = fitType
  }

  /**
   * 设置视频时间文本颜色
   *
   * @param color 视频时间文本颜色
   */
  setVideoTimeTextFontColor(color: number): void {
    this.videoTimeTextFontColor = color
  }

  /**
   * 设置视频时间文本尺寸
   *
   * @param size 视频时间文本尺寸
   */
  setVideoTimeTextFontSize(size: number): void {
    this.videoTimeTextFontSize = size
  }

  /**
   * 设置视频时间文本字体样式
   *
   * @param style 视频时间文本字体样式
   */
  setVideoTimeTextFontStyle(style: FontStyle): void {
    this.videoTimeTextFontStyle = style
  }

  /**
   * 设置视频时间文本字体粗细
   *
   * @param weight 视频时间文本字体粗细
   */
  setVideoTimeTextFontWeight(weight: FontWeight): void {
    this.videoTimeTextFontWeight = weight
  }

  /**
   * 设置视频时间文本字体
   *
   * @param family 视频时间文本字体
   */
  setVideoTimeTextFontFamily(family: string): void {
    this.videoTimeTextFontFamily = family
  }

  /**
   * 设置视频时间文本行高
   *
   * @param lineHeight 视频时间文本行高
   */
  setVideoTimeTextLineHeight(lineHeight: number): void {
    this.videoTimeTextLineHeight = lineHeight
  }

  /**
   * 设置视频时间文本居右边距
   *
   * @param margin 视频时间文本居右边距
   */
  setVideoTimeTextMarginRight(margin: number): void {
    this.videoTimeTextMarginRight = margin
  }

  /**
   * 设置视频时间文本居底边距
   *
   * @param margin 视频时间文本居底边距
   */
  setVideoTimeTextMarginBottom(margin: number): void {
    this.videoTimeTextMarginBottom = margin
  }

  /**
   * 设置底部布局是否显示
   *
   * @param visible 底部布局是否显示
   */
  setVideoBottomLayoutVisible(visible: boolean): void {
    this.videoBottomLayoutVisible = visible
  }

  /**
   * 设置底部布局距离视频上边距
   *
   * @param marginTop 底部布局距离视频上边距
   */
  setVideoBottomLayoutMarginTop(marginTop: number): void {
    this.videoBottomLayoutMarginTop = marginTop
  }

  /**
   * 设置视频发布按钮是否显示
   *
   * @param visible 视频发布按钮是否显示
   */
  setVideoReleaseButtonVisible(visible: boolean): void {
    this.videoReleaseButtonVisible = visible
  }

  /**
   * 设置视频发布按钮背景颜色
   *
   * @param color 视频发布按钮背景颜色
   */
  setVideoReleaseButtonBackgroundColor(color: number): void {
    this.videoReleaseButtonBackgroundColor = color
  }

  /**
   * 设置视频发布按钮宽度
   *
   * @param width 视频发布按钮宽度
   */
  setVideoReleaseButtonWidth(width: number): void {
    this.videoReleaseButtonWidth = width
  }

  /**
   * 设置视频发布按钮高度
   *
   * @param height 视频发布按钮高度
   */
  setVideoReleaseButtonHeight(height: number): void {
    this.videoReleaseButtonHeight = height
  }

  /**
   * 设置视频发布按钮圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setVideoReleaseButtonRadius(options: MarkdownRadiusOptions | number): void {
    if (typeof options === 'number') {
      this.videoReleaseButtonRadiusTopLeft = options
      this.videoReleaseButtonRadiusTopRight = options
      this.videoReleaseButtonRadiusBottomLeft = options
      this.videoReleaseButtonRadiusBottomRight = options
    } else {
      if (options.topLeft !== undefined) {
        this.videoReleaseButtonRadiusTopLeft = options.topLeft
      }
      if (options.topRight !== undefined) {
        this.videoReleaseButtonRadiusTopRight = options.topRight
      }
      if (options.bottomLeft !== undefined) {
        this.videoReleaseButtonRadiusBottomLeft = options.bottomLeft
      }
      if (options.bottomRight !== undefined) {
        this.videoReleaseButtonRadiusBottomRight = options.bottomRight
      }
    }
  }

  /**
   * 设置视频发布按钮图标和文本间距
   *
   * @param gap 视频发布按钮图标和文本间距
   */
  setVideoReleaseButtonIconTextGap(gap: number): void {
    this.videoReleaseButtonIconTextGap = gap
  }

  /**
   * 设置视频发布按钮图标
   *
   * @param icon 视频发布按钮图标
   */
  setVideoReleaseButtonIcon(icon: Resource): void {
    this.videoReleaseButtonIcon = icon
  }

  /**
   * 设置视频发布按钮图标宽度
   *
   * @param width 视频发布按钮图标宽度
   */
  setVideoReleaseButtonIconWidth(width: number): void {
    this.videoReleaseButtonIconWidth = width
  }

  /**
   * 设置视频发布按钮图标高度
   *
   * @param height 视频发布按钮图标高度
   */
  setVideoReleaseButtonIconHeight(height: number): void {
    this.videoReleaseButtonIconHeight = height
  }

  /**
   * 设置视频发布按钮默认文本内容
   *
   * @param text 视频发布按钮默认文本内容
   */
  setVideoReleaseButtonText(text: string): void {
    this.videoReleaseButtonText = text
  }

  /**
   * 设置视频发布按钮文本颜色
   *
   * @param color 视频发布按钮文本颜色
   */
  setVideoReleaseButtonTextFontColor(color: number): void {
    this.videoReleaseButtonTextFontColor = color
  }

  /**
   * 设置视频发布按钮文本尺寸
   *
   * @param size 视频发布按钮文本尺寸
   */
  setVideoReleaseButtonTextFontSize(size: number): void {
    this.videoReleaseButtonTextFontSize = size
  }

  /**
   * 设置视频发布按钮文本字体样式
   *
   * @param style 视频发布按钮文本字体样式
   */
  setVideoReleaseButtonTextFontStyle(style: FontStyle): void {
    this.videoReleaseButtonTextFontStyle = style
  }

  /**
   * 设置视频发布按钮文本字体粗细
   *
   * @param weight 视频发布按钮文本字体粗细
   */
  setVideoReleaseButtonTextFontWeight(weight: FontWeight): void {
    this.videoReleaseButtonTextFontWeight = weight
  }

  /**
   * 设置视频发布按钮文本字体
   *
   * @param family 视频发布按钮文本字体
   */
  setVideoReleaseButtonTextFontFamily(family: string): void {
    this.videoReleaseButtonTextFontFamily = family
  }

  /**
   * 设置视频发布按钮文本行高
   *
   * @param lineHeight 视频发布按钮文本行高
   */
  setVideoReleaseButtonTextLineHeight(lineHeight: number): void {
    this.videoReleaseButtonTextLineHeight = lineHeight
  }

  /**
   * 设置视频下载按钮是否显示
   *
   * @param visible 视频下载按钮是否显示
   */
  setVideoDownloadButtonVisible(visible: boolean): void {
    this.videoDownloadButtonVisible = visible
  }

  /**
   * 设置视频下载按钮背景颜色
   *
   * @param color 视频下载按钮背景颜色
   */
  setVideoDownloadButtonBackgroundColor(color: number): void {
    this.videoDownloadButtonBackgroundColor = color
  }

  /**
   * 设置视频下载按钮宽度
   *
   * @param width 视频下载按钮宽度
   */
  setVideoDownloadButtonWidth(width: number): void {
    this.videoDownloadButtonWidth = width
  }

  /**
   * 设置视频下载按钮高度
   *
   * @param height 视频下载按钮高度
   */
  setVideoDownloadButtonHeight(height: number): void {
    this.videoDownloadButtonHeight = height
  }

  /**
   * 设置视频下载按钮圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setVideoDownloadButtonRadius(options: MarkdownRadiusOptions | number): void {
    if (typeof options === 'number') {
      this.videoDownloadButtonRadiusTopLeft = options
      this.videoDownloadButtonRadiusTopRight = options
      this.videoDownloadButtonRadiusBottomLeft = options
      this.videoDownloadButtonRadiusBottomRight = options
    } else {
      if (options.topLeft !== undefined) {
        this.videoDownloadButtonRadiusTopLeft = options.topLeft
      }
      if (options.topRight !== undefined) {
        this.videoDownloadButtonRadiusTopRight = options.topRight
      }
      if (options.bottomLeft !== undefined) {
        this.videoDownloadButtonRadiusBottomLeft = options.bottomLeft
      }
      if (options.bottomRight !== undefined) {
        this.videoDownloadButtonRadiusBottomRight = options.bottomRight
      }
    }
  }

  /**
   * 设置视频下载按钮图标和文本间距
   *
   * @param gap 视频下载按钮图标和文本间距
   */
  setVideoDownloadButtonIconTextGap(gap: number): void {
    this.videoDownloadButtonIconTextGap = gap
  }

  /**
   * 设置视频下载按钮图标
   *
   * @param icon 视频下载按钮图标
   */
  setVideoDownloadButtonIcon(icon: Resource): void {
    this.videoDownloadButtonIcon = icon
  }

  /**
   * 设置视频下载按钮图标宽度
   *
   * @param width 视频下载按钮图标宽度
   */
  setVideoDownloadButtonIconWidth(width: number): void {
    this.videoDownloadButtonIconWidth = width
  }

  /**
   * 设置视频下载按钮图标高度
   *
   * @param height 视频下载按钮图标高度
   */
  setVideoDownloadButtonIconHeight(height: number): void {
    this.videoDownloadButtonIconHeight = height
  }

  /**
   * 设置视频下载按钮默认文本内容
   *
   * @param text 视频下载按钮默认文本内容
   */
  setVideoDownloadButtonText(text: string): void {
    this.videoDownloadButtonText = text
  }

  /**
   * 设置视频下载按钮文本颜色
   *
   * @param color 视频下载按钮文本颜色
   */
  setVideoDownloadButtonTextFontColor(color: number): void {
    this.videoDownloadButtonTextFontColor = color
  }

  /**
   * 设置视频下载按钮文本尺寸
   *
   * @param size 视频下载按钮文本尺寸
   */
  setVideoDownloadButtonTextFontSize(size: number): void {
    this.videoDownloadButtonTextFontSize = size
  }

  /**
   * 设置视频下载按钮文本字体样式
   *
   * @param style 视频下载按钮文本字体样式
   */
  setVideoDownloadButtonTextFontStyle(style: FontStyle): void {
    this.videoDownloadButtonTextFontStyle = style
  }

  /**
   * 设置视频下载按钮文本字体粗细
   *
   * @param weight 视频下载按钮文本字体粗细
   */
  setVideoDownloadButtonTextFontWeight(weight: FontWeight): void {
    this.videoDownloadButtonTextFontWeight = weight
  }

  /**
   * 设置视频下载按钮文本字体
   *
   * @param family 视频下载按钮文本字体
   */
  setVideoDownloadButtonTextFontFamily(family: string): void {
    this.videoDownloadButtonTextFontFamily = family
  }

  /**
   * 设置视频下载按钮文本行高
   *
   * @param lineHeight 视频下载按钮文本行高
   */
  setVideoDownloadButtonTextLineHeight(lineHeight: number): void {
    this.videoDownloadButtonTextLineHeight = lineHeight
  }

  /**
   * 获取videoBackgroundColor
   *
   * @returns videoBackgroundColor
   */
  getVideoBackgroundColor(): number | undefined {
    return this.videoBackgroundColor
  }
  /**
   * 获取videoMarginTop
   *
   * @returns videoMarginTop
   */
  getVideoMarginTop(): number | undefined {
    return this.videoMarginTop
  }
  /**
   * 获取videoMarginRight
   *
   * @returns videoMarginRight
   */
  getVideoMarginRight(): number | undefined {
    return this.videoMarginRight
  }
  /**
   * 获取videoMarginBottom
   *
   * @returns videoMarginBottom
   */
  getVideoMarginBottom(): number | undefined {
    return this.videoMarginBottom
  }
  /**
   * 获取videoMarginLeft
   *
   * @returns videoMarginLeft
   */
  getVideoMarginLeft(): number | undefined {
    return this.videoMarginLeft
  }
  /**
   * 获取videoPaddingTop
   *
   * @returns videoPaddingTop
   */
  getVideoPaddingTop(): number | undefined {
    return this.videoPaddingTop
  }
  /**
   * 获取videoPaddingRight
   *
   * @returns videoPaddingRight
   */
  getVideoPaddingRight(): number | undefined {
    return this.videoPaddingRight
  }
  /**
   * 获取videoPaddingBottom
   *
   * @returns videoPaddingBottom
   */
  getVideoPaddingBottom(): number | undefined {
    return this.videoPaddingBottom
  }
  /**
   * 获取videoPaddingLeft
   *
   * @returns videoPaddingLeft
   */
  getVideoPaddingLeft(): number | undefined {
    return this.videoPaddingLeft
  }
  /**
   * 获取videoRadiusTopLeft
   *
   * @returns videoRadiusTopLeft
   */
  getVideoRadiusTopLeft(): number | undefined {
    return this.videoRadiusTopLeft
  }
  /**
   * 获取videoRadiusTopRight
   *
   * @returns videoRadiusTopRight
   */
  getVideoRadiusTopRight(): number | undefined {
    return this.videoRadiusTopRight
  }
  /**
   * 获取videoRadiusBottomLeft
   *
   * @returns videoRadiusBottomLeft
   */
  getVideoRadiusBottomLeft(): number | undefined {
    return this.videoRadiusBottomLeft
  }
  /**
   * 获取videoRadiusBottomRight
   *
   * @returns videoRadiusBottomRight
   */
  getVideoRadiusBottomRight(): number | undefined {
    return this.videoRadiusBottomRight
  }
  /**
   * 获取videoBorderStyle
   *
   * @returns videoBorderStyle
   */
  getVideoBorderStyle(): BorderStyle | undefined {
    return this.videoBorderStyle
  }
  /**
   * 获取videoBorderWidth
   *
   * @returns videoBorderWidth
   */
  getVideoBorderWidth(): number | undefined {
    return this.videoBorderWidth
  }
  /**
   * 获取videoBorderColor
   *
   * @returns videoBorderColor
   */
  getVideoBorderColor(): number | undefined {
    return this.videoBorderColor
  }
  /**
   * 获取videoPlaceholder
   *
   * @returns videoPlaceholder
   */
  getVideoPlaceholder(): Resource | undefined {
    return this.videoPlaceholder
  }
  /**
   * 获取videoImageFitType
   *
   * @returns videoImageFitType
   */
  getVideoImageFitType(): ImageFit | undefined {
    return this.videoImageFitType
  }
  /**
   * 获取videoPlayIcon
   *
   * @returns videoPlayIcon
   */
  getVideoPlayIcon(): Resource | undefined {
    return this.videoPlayIcon
  }
  /**
   * 获取videoPlayIconWidth
   *
   * @returns videoPlayIconWidth
   */
  getVideoPlayIconWidth(): number | undefined {
    return this.videoPlayIconWidth
  }
  /**
   * 获取videoPlayIconHeight
   *
   * @returns videoPlayIconHeight
   */
  getVideoPlayIconHeight(): number | undefined {
    return this.videoPlayIconHeight
  }
  /**
   * 获取videoPlayIconFitType
   *
   * @returns videoPlayIconFitType
   */
  getVideoPlayIconFitType(): ImageFit | undefined {
    return this.videoPlayIconFitType
  }
  /**
   * 获取videoTimeTextFontColor
   *
   * @returns videoTimeTextFontColor
   */
  getVideoTimeTextFontColor(): number | undefined {
    return this.videoTimeTextFontColor
  }
  /**
   * 获取videoTimeTextFontSize
   *
   * @returns videoTimeTextFontSize
   */
  getVideoTimeTextFontSize(): number | undefined {
    return this.videoTimeTextFontSize
  }
  /**
   * 获取videoTimeTextFontStyle
   *
   * @returns videoTimeTextFontStyle
   */
  getVideoTimeTextFontStyle(): FontStyle | undefined {
    return this.videoTimeTextFontStyle
  }
  /**
   * 获取videoTimeTextFontWeight
   *
   * @returns videoTimeTextFontWeight
   */
  getVideoTimeTextFontWeight(): FontWeight | undefined {
    return this.videoTimeTextFontWeight
  }
  /**
   * 获取videoTimeTextFontFamily
   *
   * @returns videoTimeTextFontFamily
   */
  getVideoTimeTextFontFamily(): string | undefined {
    return this.videoTimeTextFontFamily
  }
  /**
   * 获取videoTimeTextLineHeight
   *
   * @returns videoTimeTextLineHeight
   */
  getVideoTimeTextLineHeight(): number | undefined {
    return this.videoTimeTextLineHeight
  }
  /**
   * 获取videoTimeTextMarginRight
   *
   * @returns videoTimeTextMarginRight
   */
  getVideoTimeTextMarginRight(): number | undefined {
    return this.videoTimeTextMarginRight
  }
  /**
   * 获取videoTimeTextMarginBottom
   *
   * @returns videoTimeTextMarginBottom
   */
  getVideoTimeTextMarginBottom(): number | undefined {
    return this.videoTimeTextMarginBottom
  }
  /**
   * 获取videoBottomLayoutVisible
   *
   * @returns videoBottomLayoutVisible
   */
  getVideoBottomLayoutVisible(): boolean | undefined {
    return this.videoBottomLayoutVisible
  }
  /**
   * 获取videoBottomLayoutMarginTop
   *
   * @returns videoBottomLayoutMarginTop
   */
  getVideoBottomLayoutMarginTop(): number | undefined {
    return this.videoBottomLayoutMarginTop
  }
  /**
   * 获取videoReleaseButtonVisible
   *
   * @returns videoReleaseButtonVisible
   */
  getVideoReleaseButtonVisible(): boolean | undefined {
    return this.videoReleaseButtonVisible
  }
  /**
   * 获取videoReleaseButtonBackgroundColor
   *
   * @returns videoReleaseButtonBackgroundColor
   */
  getVideoReleaseButtonBackgroundColor(): number | undefined {
    return this.videoReleaseButtonBackgroundColor
  }
  /**
   * 获取videoReleaseButtonWidth
   *
   * @returns videoReleaseButtonWidth
   */
  getVideoReleaseButtonWidth(): number | undefined {
    return this.videoReleaseButtonWidth
  }
  /**
   * 获取videoReleaseButtonHeight
   *
   * @returns videoReleaseButtonHeight
   */
  getVideoReleaseButtonHeight(): number | undefined {
    return this.videoReleaseButtonHeight
  }
  /**
   * 获取videoReleaseButtonRadiusTopLeft
   *
   * @returns videoReleaseButtonRadiusTopLeft
   */
  getVideoReleaseButtonRadiusTopLeft(): number | undefined {
    return this.videoReleaseButtonRadiusTopLeft
  }
  /**
   * 获取videoReleaseButtonRadiusTopRight
   *
   * @returns videoReleaseButtonRadiusTopRight
   */
  getVideoReleaseButtonRadiusTopRight(): number | undefined {
    return this.videoReleaseButtonRadiusTopRight
  }
  /**
   * 获取videoReleaseButtonRadiusBottomLeft
   *
   * @returns videoReleaseButtonRadiusBottomLeft
   */
  getVideoReleaseButtonRadiusBottomLeft(): number | undefined {
    return this.videoReleaseButtonRadiusBottomLeft
  }
  /**
   * 获取videoReleaseButtonRadiusBottomRight
   *
   * @returns videoReleaseButtonRadiusBottomRight
   */
  getVideoReleaseButtonRadiusBottomRight(): number | undefined {
    return this.videoReleaseButtonRadiusBottomRight
  }
  /**
   * 获取videoReleaseButtonIconTextGap
   *
   * @returns videoReleaseButtonIconTextGap
   */
  getVideoReleaseButtonIconTextGap(): number | undefined {
    return this.videoReleaseButtonIconTextGap
  }
  /**
   * 获取videoReleaseButtonIcon
   *
   * @returns videoReleaseButtonIcon
   */
  getVideoReleaseButtonIcon(): Resource | undefined {
    return this.videoReleaseButtonIcon
  }
  /**
   * 获取videoReleaseButtonIconWidth
   *
   * @returns videoReleaseButtonIconWidth
   */
  getVideoReleaseButtonIconWidth(): number | undefined {
    return this.videoReleaseButtonIconWidth
  }
  /**
   * 获取videoReleaseButtonIconHeight
   *
   * @returns videoReleaseButtonIconHeight
   */
  getVideoReleaseButtonIconHeight(): number | undefined {
    return this.videoReleaseButtonIconHeight
  }
  /**
   * 获取videoReleaseButtonText
   *
   * @returns videoReleaseButtonText
   */
  getVideoReleaseButtonText(): string | undefined {
    return this.videoReleaseButtonText
  }
  /**
   * 获取videoReleaseButtonTextFontColor
   *
   * @returns videoReleaseButtonTextFontColor
   */
  getVideoReleaseButtonTextFontColor(): number | undefined {
    return this.videoReleaseButtonTextFontColor
  }
  /**
   * 获取videoReleaseButtonTextFontSize
   *
   * @returns videoReleaseButtonTextFontSize
   */
  getVideoReleaseButtonTextFontSize(): number | undefined {
    return this.videoReleaseButtonTextFontSize
  }
  /**
   * 获取videoReleaseButtonTextFontStyle
   *
   * @returns videoReleaseButtonTextFontStyle
   */
  getVideoReleaseButtonTextFontStyle(): FontStyle | undefined {
    return this.videoReleaseButtonTextFontStyle
  }
  /**
   * 获取videoReleaseButtonTextFontWeight
   *
   * @returns videoReleaseButtonTextFontWeight
   */
  getVideoReleaseButtonTextFontWeight(): FontWeight | undefined {
    return this.videoReleaseButtonTextFontWeight
  }
  /**
   * 获取videoReleaseButtonTextFontFamily
   *
   * @returns videoReleaseButtonTextFontFamily
   */
  getVideoReleaseButtonTextFontFamily(): string | undefined {
    return this.videoReleaseButtonTextFontFamily
  }
  /**
   * 获取videoReleaseButtonTextLineHeight
   *
   * @returns videoReleaseButtonTextLineHeight
   */
  getVideoReleaseButtonTextLineHeight(): number | undefined {
    return this.videoReleaseButtonTextLineHeight
  }
  /**
   * 获取videoDownloadButtonVisible
   *
   * @returns videoDownloadButtonVisible
   */
  getVideoDownloadButtonVisible(): boolean | undefined {
    return this.videoDownloadButtonVisible
  }
  /**
   * 获取videoDownloadButtonBackgroundColor
   *
   * @returns videoDownloadButtonBackgroundColor
   */
  getVideoDownloadButtonBackgroundColor(): number | undefined {
    return this.videoDownloadButtonBackgroundColor
  }
  /**
   * 获取videoDownloadButtonWidth
   *
   * @returns videoDownloadButtonWidth
   */
  getVideoDownloadButtonWidth(): number | undefined {
    return this.videoDownloadButtonWidth
  }
  /**
   * 获取videoDownloadButtonHeight
   *
   * @returns videoDownloadButtonHeight
   */
  getVideoDownloadButtonHeight(): number | undefined {
    return this.videoDownloadButtonHeight
  }
  /**
   * 获取videoDownloadButtonRadiusTopLeft
   *
   * @returns videoDownloadButtonRadiusTopLeft
   */
  getVideoDownloadButtonRadiusTopLeft(): number | undefined {
    return this.videoDownloadButtonRadiusTopLeft
  }
  /**
   * 获取videoDownloadButtonRadiusTopRight
   *
   * @returns videoDownloadButtonRadiusTopRight
   */
  getVideoDownloadButtonRadiusTopRight(): number | undefined {
    return this.videoDownloadButtonRadiusTopRight
  }
  /**
   * 获取videoDownloadButtonRadiusBottomLeft
   *
   * @returns videoDownloadButtonRadiusBottomLeft
   */
  getVideoDownloadButtonRadiusBottomLeft(): number | undefined {
    return this.videoDownloadButtonRadiusBottomLeft
  }
  /**
   * 获取videoDownloadButtonRadiusBottomRight
   *
   * @returns videoDownloadButtonRadiusBottomRight
   */
  getVideoDownloadButtonRadiusBottomRight(): number | undefined {
    return this.videoDownloadButtonRadiusBottomRight
  }
  /**
   * 获取videoDownloadButtonIconTextGap
   *
   * @returns videoDownloadButtonIconTextGap
   */
  getVideoDownloadButtonIconTextGap(): number | undefined {
    return this.videoDownloadButtonIconTextGap
  }
  /**
   * 获取videoDownloadButtonIcon
   *
   * @returns videoDownloadButtonIcon
   */
  getVideoDownloadButtonIcon(): Resource | undefined {
    return this.videoDownloadButtonIcon
  }
  /**
   * 获取videoDownloadButtonIconWidth
   *
   * @returns videoDownloadButtonIconWidth
   */
  getVideoDownloadButtonIconWidth(): number | undefined {
    return this.videoDownloadButtonIconWidth
  }
  /**
   * 获取videoDownloadButtonIconHeight
   *
   * @returns videoDownloadButtonIconHeight
   */
  getVideoDownloadButtonIconHeight(): number | undefined {
    return this.videoDownloadButtonIconHeight
  }
  /**
   * 获取videoDownloadButtonText
   *
   * @returns videoDownloadButtonText
   */
  getVideoDownloadButtonText(): string | undefined {
    return this.videoDownloadButtonText
  }
  /**
   * 获取videoDownloadButtonTextFontColor
   *
   * @returns videoDownloadButtonTextFontColor
   */
  getVideoDownloadButtonTextFontColor(): number | undefined {
    return this.videoDownloadButtonTextFontColor
  }
  /**
   * 获取videoDownloadButtonTextFontSize
   *
   * @returns videoDownloadButtonTextFontSize
   */
  getVideoDownloadButtonTextFontSize(): number | undefined {
    return this.videoDownloadButtonTextFontSize
  }
  /**
   * 获取videoDownloadButtonTextFontStyle
   *
   * @returns videoDownloadButtonTextFontStyle
   */
  getVideoDownloadButtonTextFontStyle(): FontStyle | undefined {
    return this.videoDownloadButtonTextFontStyle
  }
  /**
   * 获取videoDownloadButtonTextFontWeight
   *
   * @returns videoDownloadButtonTextFontWeight
   */
  getVideoDownloadButtonTextFontWeight(): FontWeight | undefined {
    return this.videoDownloadButtonTextFontWeight
  }
  /**
   * 获取videoDownloadButtonTextFontFamily
   *
   * @returns videoDownloadButtonTextFontFamily
   */
  getVideoDownloadButtonTextFontFamily(): string | undefined {
    return this.videoDownloadButtonTextFontFamily
  }
  /**
   * 获取videoDownloadButtonTextLineHeight
   *
   * @returns videoDownloadButtonTextLineHeight
   */
  getVideoDownloadButtonTextLineHeight(): number | undefined {
    return this.videoDownloadButtonTextLineHeight
  }
}
