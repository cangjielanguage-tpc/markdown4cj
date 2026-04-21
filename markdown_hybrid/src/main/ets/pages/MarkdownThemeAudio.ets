/**
 * Markdown用户可设置的样式-音频样式
 */
export class MarkdownThemeAudio {
  /**
   * 音频背景颜色
   */
  audioBackgroundColor?: number = undefined

  /**
   * 音频上外边距
   */
  audioMarginTop?: number = undefined

  /**
   * 音频右外边距
   */
  audioMarginRight?: number = undefined

  /**
   * 音频下外边距
   */
  audioMarginBottom?: number = undefined

  /**
   * 音频左外边距
   */
  audioMarginLeft?: number = undefined

  /**
   * 音频上内边距
   */
  audioPaddingTop?: number = undefined

  /**
   * 音频右内边距
   */
  audioPaddingRight?: number = undefined

  /**
   * 音频下内边距
   */
  audioPaddingBottom?: number = undefined

  /**
   * 音频左内边距
   */
  audioPaddingLeft?: number = undefined

  /**
   * 音频边框样式
   */
  audioBorderStyle?: BorderStyle = undefined

  /**
   * 音频边框宽度
   */
  audioBorderWidth?: number = undefined

  /**
   * 音频边框颜色
   */
  audioBorderColor?: number = undefined

  /**
   * 音频边框左上圆角
   */
  audioRadiusTopLeft?: number = undefined

  /**
   * 音频边框右上圆角
   */
  audioRadiusTopRight?: number = undefined

  /**
   * 音频边框左下圆角
   */
  audioRadiusBottomLeft?: number = undefined

  /**
   * 音频边框右下圆角
   */
  audioRadiusBottomRight?: number = undefined

  /**
   * 音频阴影模糊半径
   */
  audioShadowRadius?: number = undefined

  /**
   * 音频阴影X轴偏移量
   */
  audioShadowOffsetX?: number = undefined

  /**
   * 音频阴影Y轴偏移量
   */
  audioShadowOffsetY?: number = undefined

  /**
   * 音频图标
   */
  audioIcon?: Resource = undefined

  /**
   * 音频图标宽度
   */
  audioIconWidth?: number = undefined

  /**
   * 音频图标高度
   */
  audioIconHeight?: number = undefined

  /**
   * 音频图标左上圆角
   */
  audioIconRadiusTopLeft?: number = undefined

  /**
   * 音频图标右上圆角
   */
  audioIconRadiusTopRight?: number = undefined

  /**
   * 音频图标左下圆角
   */
  audioIconRadiusBottomLeft?: number = undefined

  /**
   * 音频图标右下圆角
   */
  audioIconRadiusBottomRight?: number = undefined

  /**
   * 音频图标缩放类型
   */
  audioIconFitType?: ImageFit = undefined

  /**
   * 音频标题文本和类型文本间距
   */
  audioTitleToTypeSpacing?: number = undefined

  /**
   * 音频阴影颜色值
   */
  audioShadowColor?: number = undefined

  /**
   * 音频按钮宽度
   */
  audioButtonWidth?: number = undefined

  /**
   * 音频按钮高度
   */
  audioButtonHeight?: number = undefined

  /**
   * 音频按钮背景颜色
   */
  audioButtonBackgroundColor?: number = undefined

  /**
   * 音频按钮边框样式
   */
  audioButtonBorderStyle?: BorderStyle = undefined

  /**
   * 音频按钮边框宽度
   */
  audioButtonBorderWidth?: number = undefined

  /**
   * 音频按钮边框颜色
   */
  audioButtonBorderColor?: number = undefined

  /**
   * 音频按钮边框左上圆角
   */
  audioButtonRadiusTopLeft?: number = undefined

  /**
   * 音频按钮边框右上圆角
   */
  audioButtonRadiusTopRight?: number = undefined

  /**
   * 音频按钮边框左下圆角
   */
  audioButtonRadiusBottomLeft?: number = undefined

  /**
   * 音频按钮边框右下圆角
   */
  audioButtonRadiusBottomRight?: number = undefined

  /**
   * 音频按钮默认文本内容
   */
  audioButtonText?: string = undefined

  /**
   * 音频按钮文本颜色
   */
  audioButtonTextFontColor?: number = undefined

  /**
   * 音频按钮文本尺寸
   */
  audioButtonTextFontSize?: number = undefined

  /**
   * 音频按钮文本字体样式
   */
  audioButtonTextFontStyle?: FontStyle = undefined

  /**
   * 音频按钮文本字体粗细
   */
  audioButtonTextFontWeight?: FontWeight = undefined

  /**
   * 音频按钮文本字体
   */
  audioButtonTextFontFamily?: string = undefined

  /**
   * 音频按钮文本行高
   */
  audioButtonTextLineHeight?: number = undefined

  /**
   * 音频标题文本颜色
   */
  audioTitleTextFontColor?: number = undefined

  /**
   * 音频标题文本尺寸
   */
  audioTitleTextFontSize?: number = undefined

  /**
   * 音频标题文本字体样式
   */
  audioTitleTextFontStyle?: FontStyle = undefined

  /**
   * 音频标题文本字体粗细
   */
  audioTitleTextFontWeight?: FontWeight = undefined

  /**
   * 音频标题文本字体
   */
  audioTitleTextFontFamily?: string = undefined

  /**
   * 音频标题文本行高
   */
  audioTitleTextLineHeight?: number = undefined

  /**
   * 音频类型文本颜色
   */
  audioTypeTextFontColor?: number = undefined

  /**
   * 音频类型文本尺寸
   */
  audioTypeTextFontSize?: number = undefined

  /**
   * 音频类型文本字体样式
   */
  audioTypeTextFontStyle?: FontStyle = undefined

  /**
   * 音频类型文本字体粗细
   */
  audioTypeTextFontWeight?: FontWeight = undefined

  /**
   * 音频类型文本字体
   */
  audioTypeTextFontFamily?: string = undefined

  /**
   * 音频类型文本行高
   */
  audioTypeTextLineHeight?: number = undefined

  /**
   * 设置音频背景颜色
   *
   * @param color 音频背景颜色
   */
  setAudioBackgroundColor(color: number): void {
    this.audioBackgroundColor = color
  }

  /**
   * 音频整体外边距
   *
   * @param margin 外边距
   */
  setAudioAllMargin(margin: number): void {
    this.audioMarginTop = margin
    this.audioMarginRight = margin
    this.audioMarginBottom = margin
    this.audioMarginLeft = margin
  }

  /**
   * 音频分别设置四个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setAudioMargin(top?: number, right?: number, bottom?: number, left?: number): void {
    this.audioMarginTop = top
    this.audioMarginRight = right
    this.audioMarginBottom = bottom
    this.audioMarginLeft = left
  }

  /**
   * 音频整体内边距
   *
   * @param padding 内边距
   */
  setAudioAllPadding(padding: number): void {
    this.audioPaddingTop = padding
    this.audioPaddingRight = padding
    this.audioPaddingBottom = padding
    this.audioPaddingLeft = padding
  }

  /**
   * 音频分别设置四个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setAudioPadding(top?: number, right?: number, bottom?: number, left?: number): void {
    this.audioPaddingTop = top
    this.audioPaddingRight = right
    this.audioPaddingBottom = bottom
    this.audioPaddingLeft = left
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
   * 音频整体圆角
   *
   * @param radius 圆角
   */
  setAudioAllRadius(radius: number): void {
    this.audioRadiusTopLeft = radius
    this.audioRadiusTopRight = radius
    this.audioRadiusBottomLeft = radius
    this.audioRadiusBottomRight = radius
  }

  /**
   * 音频分别设置四个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setAudioRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void {
    this.audioRadiusTopLeft = topLeft
    this.audioRadiusTopRight = topRight
    this.audioRadiusBottomLeft = bottomLeft
    this.audioRadiusBottomRight = bottomRight
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
   * 音频图标整体圆角
   *
   * @param radius 圆角
   */
  setAudioIconAllRadius(radius: number): void {
    this.audioIconRadiusTopLeft = radius
    this.audioIconRadiusTopRight = radius
    this.audioIconRadiusBottomLeft = radius
    this.audioIconRadiusBottomRight = radius
  }

  /**
   * 音频图标分别设置四个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setAudioIconRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void {
    this.audioIconRadiusTopLeft = topLeft
    this.audioIconRadiusTopRight = topRight
    this.audioIconRadiusBottomLeft = bottomLeft
    this.audioIconRadiusBottomRight = bottomRight
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
   * 音频按钮整体圆角
   *
   * @param radius 圆角
   */
  setAudioButtonAllRadius(radius: number): void {
    this.audioButtonRadiusTopLeft = radius
    this.audioButtonRadiusTopRight = radius
    this.audioButtonRadiusBottomLeft = radius
    this.audioButtonRadiusBottomRight = radius
  }

  /**
   * 音频按钮分别设置四个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setAudioButtonRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void {
    this.audioButtonRadiusTopLeft = topLeft
    this.audioButtonRadiusTopRight = topRight
    this.audioButtonRadiusBottomLeft = bottomLeft
    this.audioButtonRadiusBottomRight = bottomRight
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
}
