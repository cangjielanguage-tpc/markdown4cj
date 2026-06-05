import { MarkdownMarginOptions, MarkdownPaddingOptions, MarkdownRadiusOptions } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-音频样式
 */
export class AudioTheme {
  /**
   * 音频背景颜色
   */
  private audioBackgroundColor?: number = undefined

  /**
   * 音频上外边距
   */
  private audioMarginTop?: number = undefined

  /**
   * 音频右外边距
   */
  private audioMarginRight?: number = undefined

  /**
   * 音频下外边距
   */
  private audioMarginBottom?: number = undefined

  /**
   * 音频左外边距
   */
  private audioMarginLeft?: number = undefined

  /**
   * 音频上内边距
   */
  private audioPaddingTop?: number = undefined

  /**
   * 音频右内边距
   */
  private audioPaddingRight?: number = undefined

  /**
   * 音频下内边距
   */
  private audioPaddingBottom?: number = undefined

  /**
   * 音频左内边距
   */
  private audioPaddingLeft?: number = undefined

  /**
   * 音频边框样式
   */
  private audioBorderStyle?: BorderStyle = undefined

  /**
   * 音频边框宽度
   */
  private audioBorderWidth?: number = undefined

  /**
   * 音频边框颜色
   */
  private audioBorderColor?: number = undefined

  /**
   * 音频边框左上圆角
   */
  private audioRadiusTopLeft?: number = undefined

  /**
   * 音频边框右上圆角
   */
  private audioRadiusTopRight?: number = undefined

  /**
   * 音频边框左下圆角
   */
  private audioRadiusBottomLeft?: number = undefined

  /**
   * 音频边框右下圆角
   */
  private audioRadiusBottomRight?: number = undefined

  /**
   * 音频阴影模糊半径
   */
  private audioShadowRadius?: number = undefined

  /**
   * 音频阴影X轴偏移量
   */
  private audioShadowOffsetX?: number = undefined

  /**
   * 音频阴影Y轴偏移量
   */
  private audioShadowOffsetY?: number = undefined

  /**
   * 音频图标
   */
  private audioIcon?: Resource = undefined

  /**
   * 音频图标宽度
   */
  private audioIconWidth?: number = undefined

  /**
   * 音频图标高度
   */
  private audioIconHeight?: number = undefined

  /**
   * 音频图标左上圆角
   */
  private audioIconRadiusTopLeft?: number = undefined

  /**
   * 音频图标右上圆角
   */
  private audioIconRadiusTopRight?: number = undefined

  /**
   * 音频图标左下圆角
   */
  private audioIconRadiusBottomLeft?: number = undefined

  /**
   * 音频图标右下圆角
   */
  private audioIconRadiusBottomRight?: number = undefined

  /**
   * 音频图标缩放类型
   */
  private audioIconFitType?: ImageFit = undefined

  /**
   * 音频标题文本和类型文本间距
   */
  private audioTitleToTypeSpacing?: number = undefined

  /**
   * 音频阴影颜色值
   */
  private audioShadowColor?: number = undefined

  /**
   * 音频按钮宽度
   */
  private audioButtonWidth?: number = undefined

  /**
   * 音频按钮高度
   */
  private audioButtonHeight?: number = undefined

  /**
   * 音频按钮背景颜色
   */
  private audioButtonBackgroundColor?: number = undefined

  /**
   * 音频按钮边框样式
   */
  private audioButtonBorderStyle?: BorderStyle = undefined

  /**
   * 音频按钮边框宽度
   */
  private audioButtonBorderWidth?: number = undefined

  /**
   * 音频按钮边框颜色
   */
  private audioButtonBorderColor?: number = undefined

  /**
   * 音频按钮边框左上圆角
   */
  private audioButtonRadiusTopLeft?: number = undefined

  /**
   * 音频按钮边框右上圆角
   */
  private audioButtonRadiusTopRight?: number = undefined

  /**
   * 音频按钮边框左下圆角
   */
  private audioButtonRadiusBottomLeft?: number = undefined

  /**
   * 音频按钮边框右下圆角
   */
  private audioButtonRadiusBottomRight?: number = undefined

  /**
   * 音频按钮默认文本内容
   */
  private audioButtonText?: string = undefined

  /**
   * 音频按钮文本颜色
   */
  private audioButtonTextFontColor?: number = undefined

  /**
   * 音频按钮文本尺寸
   */
  private audioButtonTextFontSize?: number = undefined

  /**
   * 音频按钮文本字体样式
   */
  private audioButtonTextFontStyle?: FontStyle = undefined

  /**
   * 音频按钮文本字体粗细
   */
  private audioButtonTextFontWeight?: FontWeight = undefined

  /**
   * 音频按钮文本字体
   */
  private audioButtonTextFontFamily?: string = undefined

  /**
   * 音频按钮文本行高
   */
  private audioButtonTextLineHeight?: number = undefined

  /**
   * 音频标题文本颜色
   */
  private audioTitleTextFontColor?: number = undefined

  /**
   * 音频标题文本尺寸
   */
  private audioTitleTextFontSize?: number = undefined

  /**
   * 音频标题文本字体样式
   */
  private audioTitleTextFontStyle?: FontStyle = undefined

  /**
   * 音频标题文本字体粗细
   */
  private audioTitleTextFontWeight?: FontWeight = undefined

  /**
   * 音频标题文本字体
   */
  private audioTitleTextFontFamily?: string = undefined

  /**
   * 音频标题文本行高
   */
  private audioTitleTextLineHeight?: number = undefined

  /**
   * 音频类型文本颜色
   */
  private audioTypeTextFontColor?: number = undefined

  /**
   * 音频类型文本尺寸
   */
  private audioTypeTextFontSize?: number = undefined

  /**
   * 音频类型文本字体样式
   */
  private audioTypeTextFontStyle?: FontStyle = undefined

  /**
   * 音频类型文本字体粗细
   */
  private audioTypeTextFontWeight?: FontWeight = undefined

  /**
   * 音频类型文本字体
   */
  private audioTypeTextFontFamily?: string = undefined

  /**
   * 音频类型文本行高
   */
  private audioTypeTextLineHeight?: number = undefined

  /**
   * 设置音频背景颜色
   *
   * @param color 音频背景颜色
   */
  setAudioBackgroundColor(color: number): void {
    this.audioBackgroundColor = color
  }

  /**
   * 音频设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setAudioMargin(options: MarkdownMarginOptions | number): void {
    if (typeof options === 'number') {
      this.audioMarginTop = options
      this.audioMarginRight = options
      this.audioMarginBottom = options
      this.audioMarginLeft = options
    } else {
      if (options.top !== undefined) {
        this.audioMarginTop = options.top
      }
      if (options.right !== undefined) {
        this.audioMarginRight = options.right
      }
      if (options.bottom !== undefined) {
        this.audioMarginBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.audioMarginLeft = options.left
      }
    }
  }

  /**
   * 音频设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setAudioPadding(options: MarkdownPaddingOptions | number): void {
    if (typeof options === 'number') {
      this.audioPaddingTop = options
      this.audioPaddingRight = options
      this.audioPaddingBottom = options
      this.audioPaddingLeft = options
    } else {
      if (options.top !== undefined) {
        this.audioPaddingTop = options.top
      }
      if (options.right !== undefined) {
        this.audioPaddingRight = options.right
      }
      if (options.bottom !== undefined) {
        this.audioPaddingBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.audioPaddingLeft = options.left
      }
    }
  }

  /**
   * 设置音频边框样式
   *
   * @param borderStyle 音频边框样式
   */
  setAudioBorderStyle(borderStyle: BorderStyle): void {
    this.audioBorderStyle = borderStyle
  }

  /**
   * 设置音频边框宽度
   *
   * @param borderWidth 音频边框宽度
   */
  setAudioBorderWidth(borderWidth: number): void {
    this.audioBorderWidth = borderWidth
  }

  /**
   * 设置音频边框颜色
   *
   * @param borderColor 音频边框颜色
   */
  setAudioBorderColor(borderColor: number): void {
    this.audioBorderColor = borderColor
  }

  /**
   * 音频设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setAudioBorderRadius(options: MarkdownRadiusOptions | number): void {
    if (typeof options === 'number') {
      this.audioRadiusTopLeft = options
      this.audioRadiusTopRight = options
      this.audioRadiusBottomLeft = options
      this.audioRadiusBottomRight = options
    } else {
      if (options.topLeft !== undefined) {
        this.audioRadiusTopLeft = options.topLeft
      }
      if (options.topRight !== undefined) {
        this.audioRadiusTopRight = options.topRight
      }
      if (options.bottomLeft !== undefined) {
        this.audioRadiusBottomLeft = options.bottomLeft
      }
      if (options.bottomRight !== undefined) {
        this.audioRadiusBottomRight = options.bottomRight
      }
    }
  }

  /**
   * 设置音频阴影模糊半径
   *
   * @param radius 音频阴影模糊半径
   */
  setAudioShadowRadius(radius: number): void {
    this.audioShadowRadius = radius
  }

  /**
   * 设置音频阴影X轴偏移量
   *
   * @param offsetX 音频阴影X轴偏移量
   */
  setAudioShadowOffsetX(offsetX: number): void {
    this.audioShadowOffsetX = offsetX
  }

  /**
   * 设置音频阴影Y轴偏移量
   *
   * @param offsetY 音频阴影Y轴偏移量
   */
  setAudioShadowOffsetY(offsetY: number): void {
    this.audioShadowOffsetY = offsetY
  }

  /**
   * 设置音频图标
   *
   * @param icon 音频图标
   */
  setAudioIcon(icon: Resource): void {
    this.audioIcon = icon
  }

  /**
   * 设置音频图标宽度
   *
   * @param width 音频图标宽度
   */
  setAudioIconWidth(width: number): void {
    this.audioIconWidth = width
  }

  /**
   * 设置音频图标高度
   *
   * @param height 音频图标高度
   */
  setAudioIconHeight(height: number): void {
    this.audioIconHeight = height
  }

  /**
   * 音频图标设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setAudioIconRadius(options: MarkdownRadiusOptions | number): void {
    if (typeof options === 'number') {
      this.audioIconRadiusTopLeft = options
      this.audioIconRadiusTopRight = options
      this.audioIconRadiusBottomLeft = options
      this.audioIconRadiusBottomRight = options
    } else {
      if (options.topLeft !== undefined) {
        this.audioIconRadiusTopLeft = options.topLeft
      }
      if (options.topRight !== undefined) {
        this.audioIconRadiusTopRight = options.topRight
      }
      if (options.bottomLeft !== undefined) {
        this.audioIconRadiusBottomLeft = options.bottomLeft
      }
      if (options.bottomRight !== undefined) {
        this.audioIconRadiusBottomRight = options.bottomRight
      }
    }
  }

  /**
   * 设置音频图标缩放类型
   *
   * @param fitType 音频图标缩放类型
   */
  setAudioIconFitType(fitType: ImageFit): void {
    this.audioIconFitType = fitType
  }

  /**
   * 设置音频标题文本和类型文本间距
   *
   * @param spacing 音频标题文本和类型文本间距
   */
  setAudioTitleToTypeSpacing(spacing: number): void {
    this.audioTitleToTypeSpacing = spacing
  }

  /**
   * 设置音频阴影颜色
   *
   * @param color 音频阴影颜色
   */
  setAudioShadowColor(color: number): void {
    this.audioShadowColor = color
  }

  /**
   * 设置音频按钮宽度
   *
   * @param width 音频按钮宽度
   */
  setAudioButtonWidth(width: number): void {
    this.audioButtonWidth = width
  }

  /**
   * 设置音频按钮高度
   *
   * @param height 音频按钮高度
   */
  setAudioButtonHeight(height: number): void {
    this.audioButtonHeight = height
  }

  /**
   * 设置音频按钮背景颜色
   *
   * @param color 音频按钮背景颜色
   */
  setAudioButtonBackgroundColor(color: number): void {
    this.audioButtonBackgroundColor = color
  }

  /**
   * 设置音频按钮边框样式
   *
   * @param borderStyle 音频按钮边框样式
   */
  setAudioButtonBorderStyle(borderStyle: BorderStyle): void {
    this.audioButtonBorderStyle = borderStyle
  }

  /**
   * 设置音频按钮边框宽度
   *
   * @param borderWidth 音频按钮边框宽度
   */
  setAudioButtonBorderWidth(borderWidth: number): void {
    this.audioButtonBorderWidth = borderWidth
  }

  /**
   * 设置音频按钮边框颜色
   *
   * @param borderColor 音频按钮边框颜色
   */
  setAudioButtonBorderColor(borderColor: number): void {
    this.audioButtonBorderColor = borderColor
  }

  /**
   * 音频按钮设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setAudioButtonRadius(options: MarkdownRadiusOptions | number): void {
    if (typeof options === 'number') {
      this.audioButtonRadiusTopLeft = options
      this.audioButtonRadiusTopRight = options
      this.audioButtonRadiusBottomLeft = options
      this.audioButtonRadiusBottomRight = options
    } else {
      if (options.topLeft !== undefined) {
        this.audioButtonRadiusTopLeft = options.topLeft
      }
      if (options.topRight !== undefined) {
        this.audioButtonRadiusTopRight = options.topRight
      }
      if (options.bottomLeft !== undefined) {
        this.audioButtonRadiusBottomLeft = options.bottomLeft
      }
      if (options.bottomRight !== undefined) {
        this.audioButtonRadiusBottomRight = options.bottomRight
      }
    }
  }

  /**
   * 设置音频按钮默认文本内容
   *
   * @param text 音频按钮默认文本内容
   */
  setAudioButtonText(text: string): void {
    this.audioButtonText = text
  }

  /**
   * 设置音频按钮文本颜色
   *
   * @param color 音频按钮文本颜色
   */
  setAudioButtonTextFontColor(color: number): void {
    this.audioButtonTextFontColor = color
  }

  /**
   * 设置音频按钮文本尺寸
   *
   * @param size 音频按钮文本尺寸
   */
  setAudioButtonTextFontSize(size: number): void {
    this.audioButtonTextFontSize = size
  }

  /**
   * 设置音频按钮文本字体样式
   *
   * @param style 音频按钮文本字体样式
   */
  setAudioButtonTextFontStyle(style: FontStyle): void {
    this.audioButtonTextFontStyle = style
  }

  /**
   * 设置音频按钮文本字体粗细
   *
   * @param weight 音频按钮文本字体粗细
   */
  setAudioButtonTextFontWeight(weight: FontWeight): void {
    this.audioButtonTextFontWeight = weight
  }

  /**
   * 设置音频按钮文本字体
   *
   * @param family 音频按钮文本字体
   */
  setAudioButtonTextFontFamily(family: string): void {
    this.audioButtonTextFontFamily = family
  }

  /**
   * 设置音频按钮文本行高
   *
   * @param height 音频按钮文本行高
   */
  setAudioButtonTextLineHeight(height: number): void {
    this.audioButtonTextLineHeight = height
  }

  /**
   * 设置音频标题文本颜色
   *
   * @param color 音频标题文本颜色
   */
  setAudioTitleTextFontColor(color: number): void {
    this.audioTitleTextFontColor = color
  }

  /**
   * 设置音频标题文本尺寸
   *
   * @param size 音频标题文本尺寸
   */
  setAudioTitleTextFontSize(size: number): void {
    this.audioTitleTextFontSize = size
  }

  /**
   * 设置音频标题文本字体样式
   *
   * @param style 音频标题文本字体样式
   */
  setAudioTitleTextFontStyle(style: FontStyle): void {
    this.audioTitleTextFontStyle = style
  }

  /**
   * 设置音频标题文本字体粗细
   *
   * @param weight 音频标题文本字体粗细
   */
  setAudioTitleTextFontWeight(weight: FontWeight): void {
    this.audioTitleTextFontWeight = weight
  }

  /**
   * 设置音频标题文本字体
   *
   * @param family 音频标题文本字体
   */
  setAudioTitleTextFontFamily(family: string): void {
    this.audioTitleTextFontFamily = family
  }

  /**
   * 设置音频标题文本行高
   *
   * @param height 音频标题文本行高
   */
  setAudioTitleTextLineHeight(height: number): void {
    this.audioTitleTextLineHeight = height
  }

  /**
   * 设置音频类型文本颜色
   *
   * @param color 音频类型文本颜色
   */
  setAudioTypeTextFontColor(color: number): void {
    this.audioTypeTextFontColor = color
  }

  /**
   * 设置音频类型文本尺寸
   *
   * @param size 音频类型文本尺寸
   */
  setAudioTypeTextFontSize(size: number): void {
    this.audioTypeTextFontSize = size
  }

  /**
   * 设置音频类型文本字体样式
   *
   * @param style 音频类型文本字体样式
   */
  setAudioTypeTextFontStyle(style: FontStyle): void {
    this.audioTypeTextFontStyle = style
  }

  /**
   * 设置音频类型文本字体粗细
   *
   * @param weight 音频类型文本字体粗细
   */
  setAudioTypeTextFontWeight(weight: FontWeight): void {
    this.audioTypeTextFontWeight = weight
  }

  /**
   * 设置音频类型文本字体
   *
   * @param family 音频类型文本字体
   */
  setAudioTypeTextFontFamily(family: string): void {
    this.audioTypeTextFontFamily = family
  }

  /**
   * 设置音频类型文本行高
   *
   * @param height 音频类型文本行高
   */
  setAudioTypeTextLineHeight(height: number): void {
    this.audioTypeTextLineHeight = height
  }

  /**
   * 获取音频背景颜色
   *
   * @returns 音频背景颜色
   */
  getAudioBackgroundColor(): number | undefined {
    return this.audioBackgroundColor
  }

  /**
   * 获取音频上外边距
   *
   * @returns 音频上外边距
   */
  getAudioMarginTop(): number | undefined {
    return this.audioMarginTop
  }

  /**
   * 获取音频右外边距
   *
   * @returns 音频右外边距
   */
  getAudioMarginRight(): number | undefined {
    return this.audioMarginRight
  }

  /**
   * 获取音频下外边距
   *
   * @returns 音频下外边距
   */
  getAudioMarginBottom(): number | undefined {
    return this.audioMarginBottom
  }

  /**
   * 获取音频左外边距
   *
   * @returns 音频左外边距
   */
  getAudioMarginLeft(): number | undefined {
    return this.audioMarginLeft
  }

  /**
   * 获取音频上内边距
   *
   * @returns 音频上内边距
   */
  getAudioPaddingTop(): number | undefined {
    return this.audioPaddingTop
  }

  /**
   * 获取音频右内边距
   *
   * @returns 音频右内边距
   */
  getAudioPaddingRight(): number | undefined {
    return this.audioPaddingRight
  }

  /**
   * 获取音频下内边距
   *
   * @returns 音频下内边距
   */
  getAudioPaddingBottom(): number | undefined {
    return this.audioPaddingBottom
  }

  /**
   * 获取音频左内边距
   *
   * @returns 音频左内边距
   */
  getAudioPaddingLeft(): number | undefined {
    return this.audioPaddingLeft
  }

  /**
   * 获取音频边框样式
   *
   * @returns 音频边框样式
   */
  getAudioBorderStyle(): BorderStyle | undefined {
    return this.audioBorderStyle
  }

  /**
   * 获取音频边框宽度
   *
   * @returns 音频边框宽度
   */
  getAudioBorderWidth(): number | undefined {
    return this.audioBorderWidth
  }

  /**
   * 获取音频边框颜色
   *
   * @returns 音频边框颜色
   */
  getAudioBorderColor(): number | undefined {
    return this.audioBorderColor
  }

  /**
   * 获取音频边框左上圆角
   *
   * @returns 音频边框左上圆角
   */
  getAudioRadiusTopLeft(): number | undefined {
    return this.audioRadiusTopLeft
  }

  /**
   * 获取音频边框右上圆角
   *
   * @returns 音频边框右上圆角
   */
  getAudioRadiusTopRight(): number | undefined {
    return this.audioRadiusTopRight
  }

  /**
   * 获取音频边框左下圆角
   *
   * @returns 音频边框左下圆角
   */
  getAudioRadiusBottomLeft(): number | undefined {
    return this.audioRadiusBottomLeft
  }

  /**
   * 获取音频边框右下圆角
   *
   * @returns 音频边框右下圆角
   */
  getAudioRadiusBottomRight(): number | undefined {
    return this.audioRadiusBottomRight
  }

  /**
   * 获取音频阴影模糊半径
   *
   * @returns 音频阴影模糊半径
   */
  getAudioShadowRadius(): number | undefined {
    return this.audioShadowRadius
  }

  /**
   * 获取音频阴影X轴偏移量
   *
   * @returns 音频阴影X轴偏移量
   */
  getAudioShadowOffsetX(): number | undefined {
    return this.audioShadowOffsetX
  }

  /**
   * 获取音频阴影Y轴偏移量
   *
   * @returns 音频阴影Y轴偏移量
   */
  getAudioShadowOffsetY(): number | undefined {
    return this.audioShadowOffsetY
  }

  /**
   * 获取音频图标
   *
   * @returns 音频图标
   */
  getAudioIcon(): Resource | undefined {
    return this.audioIcon
  }

  /**
   * 获取音频图标宽度
   *
   * @returns 音频图标宽度
   */
  getAudioIconWidth(): number | undefined {
    return this.audioIconWidth
  }

  /**
   * 获取音频图标高度
   *
   * @returns 音频图标高度
   */
  getAudioIconHeight(): number | undefined {
    return this.audioIconHeight
  }

  /**
   * 获取音频图标左上圆角
   *
   * @returns 音频图标左上圆角
   */
  getAudioIconRadiusTopLeft(): number | undefined {
    return this.audioIconRadiusTopLeft
  }

  /**
   * 获取音频图标右上圆角
   *
   * @returns 音频图标右上圆角
   */
  getAudioIconRadiusTopRight(): number | undefined {
    return this.audioIconRadiusTopRight
  }

  /**
   * 获取音频图标左下圆角
   *
   * @returns 音频图标左下圆角
   */
  getAudioIconRadiusBottomLeft(): number | undefined {
    return this.audioIconRadiusBottomLeft
  }

  /**
   * 获取音频图标右下圆角
   *
   * @returns 音频图标右下圆角
   */
  getAudioIconRadiusBottomRight(): number | undefined {
    return this.audioIconRadiusBottomRight
  }

  /**
   * 获取音频图标缩放类型
   *
   * @returns 音频图标缩放类型
   */
  getAudioIconFitType(): ImageFit | undefined {
    return this.audioIconFitType
  }

  /**
   * 获取音频标题文本和类型文本间距
   *
   * @returns 音频标题文本和类型文本间距
   */
  getAudioTitleToTypeSpacing(): number | undefined {
    return this.audioTitleToTypeSpacing
  }

  /**
   * 获取音频阴影颜色值
   *
   * @returns 音频阴影颜色值
   */
  getAudioShadowColor(): number | undefined {
    return this.audioShadowColor
  }

  /**
   * 获取音频按钮宽度
   *
   * @returns 音频按钮宽度
   */
  getAudioButtonWidth(): number | undefined {
    return this.audioButtonWidth
  }

  /**
   * 获取音频按钮高度
   *
   * @returns 音频按钮高度
   */
  getAudioButtonHeight(): number | undefined {
    return this.audioButtonHeight
  }

  /**
   * 获取音频按钮背景颜色
   *
   * @returns 音频按钮背景颜色
   */
  getAudioButtonBackgroundColor(): number | undefined {
    return this.audioButtonBackgroundColor
  }

  /**
   * 获取音频按钮边框样式
   *
   * @returns 音频按钮边框样式
   */
  getAudioButtonBorderStyle(): BorderStyle | undefined {
    return this.audioButtonBorderStyle
  }

  /**
   * 获取音频按钮边框宽度
   *
   * @returns 音频按钮边框宽度
   */
  getAudioButtonBorderWidth(): number | undefined {
    return this.audioButtonBorderWidth
  }

  /**
   * 获取音频按钮边框颜色
   *
   * @returns 音频按钮边框颜色
   */
  getAudioButtonBorderColor(): number | undefined {
    return this.audioButtonBorderColor
  }

  /**
   * 获取音频按钮边框左上圆角
   *
   * @returns 音频按钮边框左上圆角
   */
  getAudioButtonRadiusTopLeft(): number | undefined {
    return this.audioButtonRadiusTopLeft
  }

  /**
   * 获取音频按钮边框右上圆角
   *
   * @returns 音频按钮边框右上圆角
   */
  getAudioButtonRadiusTopRight(): number | undefined {
    return this.audioButtonRadiusTopRight
  }

  /**
   * 获取音频按钮边框左下圆角
   *
   * @returns 音频按钮边框左下圆角
   */
  getAudioButtonRadiusBottomLeft(): number | undefined {
    return this.audioButtonRadiusBottomLeft
  }

  /**
   * 获取音频按钮边框右下圆角
   *
   * @returns 音频按钮边框右下圆角
   */
  getAudioButtonRadiusBottomRight(): number | undefined {
    return this.audioButtonRadiusBottomRight
  }

  /**
   * 获取音频按钮默认文本内容
   *
   * @returns 音频按钮默认文本内容
   */
  getAudioButtonText(): string | undefined {
    return this.audioButtonText
  }

  /**
   * 获取音频按钮文本颜色
   *
   * @returns 音频按钮文本颜色
   */
  getAudioButtonTextFontColor(): number | undefined {
    return this.audioButtonTextFontColor
  }

  /**
   * 获取音频按钮文本尺寸
   *
   * @returns 音频按钮文本尺寸
   */
  getAudioButtonTextFontSize(): number | undefined {
    return this.audioButtonTextFontSize
  }

  /**
   * 获取音频按钮文本字体样式
   *
   * @returns 音频按钮文本字体样式
   */
  getAudioButtonTextFontStyle(): FontStyle | undefined {
    return this.audioButtonTextFontStyle
  }

  /**
   * 获取音频按钮文本字体粗细
   *
   * @returns 音频按钮文本字体粗细
   */
  getAudioButtonTextFontWeight(): FontWeight | undefined {
    return this.audioButtonTextFontWeight
  }

  /**
   * 获取音频按钮文本字体
   *
   * @returns 音频按钮文本字体
   */
  getAudioButtonTextFontFamily(): string | undefined {
    return this.audioButtonTextFontFamily
  }

  /**
   * 获取音频按钮文本行高
   *
   * @returns 音频按钮文本行高
   */
  getAudioButtonTextLineHeight(): number | undefined {
    return this.audioButtonTextLineHeight
  }

  /**
   * 获取音频标题文本颜色
   *
   * @returns 音频标题文本颜色
   */
  getAudioTitleTextFontColor(): number | undefined {
    return this.audioTitleTextFontColor
  }

  /**
   * 获取音频标题文本尺寸
   *
   * @returns 音频标题文本尺寸
   */
  getAudioTitleTextFontSize(): number | undefined {
    return this.audioTitleTextFontSize
  }

  /**
   * 获取音频标题文本字体样式
   *
   * @returns 音频标题文本字体样式
   */
  getAudioTitleTextFontStyle(): FontStyle | undefined {
    return this.audioTitleTextFontStyle
  }

  /**
   * 获取音频标题文本字体粗细
   *
   * @returns 音频标题文本字体粗细
   */
  getAudioTitleTextFontWeight(): FontWeight | undefined {
    return this.audioTitleTextFontWeight
  }

  /**
   * 获取音频标题文本字体
   *
   * @returns 音频标题文本字体
   */
  getAudioTitleTextFontFamily(): string | undefined {
    return this.audioTitleTextFontFamily
  }

  /**
   * 获取音频标题文本行高
   *
   * @returns 音频标题文本行高
   */
  getAudioTitleTextLineHeight(): number | undefined {
    return this.audioTitleTextLineHeight
  }

  /**
   * 获取音频类型文本颜色
   *
   * @returns 音频类型文本颜色
   */
  getAudioTypeTextFontColor(): number | undefined {
    return this.audioTypeTextFontColor
  }

  /**
   * 获取音频类型文本尺寸
   *
   * @returns 音频类型文本尺寸
   */
  getAudioTypeTextFontSize(): number | undefined {
    return this.audioTypeTextFontSize
  }

  /**
   * 获取音频类型文本字体样式
   *
   * @returns 音频类型文本字体样式
   */
  getAudioTypeTextFontStyle(): FontStyle | undefined {
    return this.audioTypeTextFontStyle
  }

  /**
   * 获取音频类型文本字体粗细
   *
   * @returns 音频类型文本字体粗细
   */
  getAudioTypeTextFontWeight(): FontWeight | undefined {
    return this.audioTypeTextFontWeight
  }

  /**
   * 获取音频类型文本字体
   *
   * @returns 音频类型文本字体
   */
  getAudioTypeTextFontFamily(): string | undefined {
    return this.audioTypeTextFontFamily
  }

  /**
   * 获取音频类型文本行高
   *
   * @returns 音频类型文本行高
   */
  getAudioTypeTextLineHeight(): number | undefined {
    return this.audioTypeTextLineHeight
  }
}
