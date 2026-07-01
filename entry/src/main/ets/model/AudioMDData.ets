import { BaseMDData } from "./BaseMDData"

export class AudioMDData extends BaseMDData {
  _audioBackgroundColor: number | undefined = undefined // 音频背景颜色
  _audioMarginTop: number = 10 // 音频上外边距
  _audioMarginRight: number = 0 // 音频右外边距
  _audioMarginBottom: number = 10 // 音频下外边距
  _audioMarginLeft: number = 0 // 音频左外边距
  _audioPaddingTop: number = 0 // 音频上内边距
  _audioPaddingRight: number = 0 // 音频右内边距
  _audioPaddingBottom: number = 0 // 音频下内边距
  _audioPaddingLeft: number = 0 // 音频左内边距
  _audioBorderStyle: BorderStyle = BorderStyle.Solid // 音频边框样式
  _audioBorderWidth: number = 0.5 // 音频边框宽度
  _audioBorderColor: number | undefined = undefined // 音频边框颜色
  _audioRadiusTopLeft: number = 12 // 音频边框左上圆角
  _audioRadiusTopRight: number = 12 // 音频边框右上圆角
  _audioRadiusBottomLeft: number = 12 // 音频边框左下圆角
  _audioRadiusBottomRight: number = 12 // 音频边框右下圆角
  _audioShadowRadius: number = 0 // 音频阴影模糊半径
  _audioShadowOffsetX: number = 0 // 音频阴影X轴偏移量
  _audioShadowOffsetY: number = 0 // 音频阴影Y轴偏移量
  _audioShadowColor: number | undefined = undefined // 音频阴影颜色值
  _audioIcon: Resource | undefined = undefined // 音频图标
  _audioIconWidth: number = 40 // 音频图标宽度
  _audioIconHeight: number = 40 // 音频图标高度
  _audioIconRadiusTopLeft: number = 0 // 音频图标左上圆角
  _audioIconRadiusTopRight: number = 0 // 音频图标右上圆角
  _audioIconRadiusBottomLeft: number = 0 // 音频图标左下圆角
  _audioIconRadiusBottomRight: number = 0 // 音频图标右下圆角
  _audioIconFitType: ImageFit = ImageFit.Contain // 音频图标缩放类型
  _audioTitleToTypeSpacing: number = 8 // 音频标题文本和类型文本间距
  _audioButtonWidth: number = 100 // 音频按钮宽度
  _audioButtonHeight: number = 32 // 音频按钮高度
  _audioButtonBackgroundColor: number | undefined = undefined // 音频按钮背景颜色
  _audioButtonBorderStyle: BorderStyle = BorderStyle.Solid // 音频按钮边框样式
  _audioButtonBorderWidth: number = 0 // 音频按钮边框宽度
  _audioButtonBorderColor: number | undefined = undefined // 音频按钮边框颜色
  _audioButtonRadiusTopLeft: number = 16 // 音频按钮边框左上圆角
  _audioButtonRadiusTopRight: number = 16 // 音频按钮边框右上圆角
  _audioButtonRadiusBottomLeft: number = 16 // 音频按钮边框左下圆角
  _audioButtonRadiusBottomRight: number = 16 // 音频按钮边框右下圆角
  _audioButtonText: string = "立即播放" // 音频按钮默认文本内容
  _audioButtonTextFontColor: number | undefined = undefined // 音频按钮文本颜色
  _audioButtonTextFontSize: number = 14 // 音频按钮文本尺寸
  _audioButtonTextFontStyle: FontStyle = FontStyle.Normal // 音频按钮文本字体样式
  _audioButtonTextFontWeight: FontWeight = FontWeight.Normal // 音频按钮文本字体粗细
  _audioButtonTextFontFamily: string = 'HarmonyOS Sans' // 音频按钮文本字体
  _audioButtonTextLineHeight: number = 20 // 音频按钮文本行高
  _audioTitleTextFontColor: number | undefined = undefined // 音频标题文本颜色
  _audioTitleTextFontSize: number = 15 // 音频标题文本尺寸
  _audioTitleTextFontStyle: FontStyle = FontStyle.Normal // 音频标题文本字体样式
  _audioTitleTextFontWeight: FontWeight = FontWeight.Normal // 音频标题文本字体粗细
  _audioTitleTextFontFamily: string = 'HarmonyOS Sans' // 音频标题文本字体
  _audioTitleTextLineHeight: number = 20 // 音频标题文本行高
  _audioTypeTextFontColor: number | undefined = undefined // 音频类型文本颜色
  _audioTypeTextFontSize: number = 11 // 音频类型文本尺寸
  _audioTypeTextFontStyle: FontStyle = FontStyle.Normal // 音频类型文本字体样式
  _audioTypeTextFontWeight: FontWeight = FontWeight.Normal // 音频类型文本字体粗细
  _audioTypeTextFontFamily: string = 'HarmonyOS Sans' // 音频类型文本字体
  _audioTypeTextLineHeight: number = 15 // 音频类型文本行高

  public set audioBackgroundColor(value: number | undefined) {
    this._audioBackgroundColor = value
  }

  public set audioMarginTop(value: number) {
    this._audioMarginTop = value
  }

  public set audioMarginRight(value: number) {
    this._audioMarginRight = value
  }

  public set audioMarginBottom(value: number) {
    this._audioMarginBottom = value
  }

  public set audioMarginLeft(value: number) {
    this._audioMarginLeft = value
  }

  public set audioPaddingTop(value: number) {
    this._audioPaddingTop = value
  }

  public set audioPaddingRight(value: number) {
    this._audioPaddingRight = value
  }

  public set audioPaddingBottom(value: number) {
    this._audioPaddingBottom = value
  }

  public set audioPaddingLeft(value: number) {
    this._audioPaddingLeft = value
  }

  public set audioBorderStyle(value: BorderStyle) {
    this._audioBorderStyle = value
  }

  public set audioBorderWidth(value: number) {
    this._audioBorderWidth = value
  }

  public set audioBorderColor(value: number | undefined) {
    this._audioBorderColor = value
  }

  public set audioRadiusTopLeft(value: number) {
    this._audioRadiusTopLeft = value
  }

  public set audioRadiusTopRight(value: number) {
    this._audioRadiusTopRight = value
  }

  public set audioRadiusBottomLeft(value: number) {
    this._audioRadiusBottomLeft = value
  }

  public set audioRadiusBottomRight(value: number) {
    this._audioRadiusBottomRight = value
  }

  public set audioShadowRadius(value: number) {
    this._audioShadowRadius = value
  }

  public set audioShadowOffsetX(value: number) {
    this._audioShadowOffsetX = value
  }

  public set audioShadowOffsetY(value: number) {
    this._audioShadowOffsetY = value
  }

  public set audioShadowColor(value: number | undefined) {
    this._audioShadowColor = value
  }

  public set audioIcon(value: Resource | undefined) {
    this._audioIcon = value
  }

  public set audioIconWidth(value: number) {
    this._audioIconWidth = value
  }

  public set audioIconHeight(value: number) {
    this._audioIconHeight = value
  }

  public set audioIconRadiusTopLeft(value: number) {
    this._audioIconRadiusTopLeft = value
  }

  public set audioIconRadiusTopRight(value: number) {
    this._audioIconRadiusTopRight = value
  }

  public set audioIconRadiusBottomLeft(value: number) {
    this._audioIconRadiusBottomLeft = value
  }

  public set audioIconRadiusBottomRight(value: number) {
    this._audioIconRadiusBottomRight = value
  }

  public set audioIconFitType(value: ImageFit) {
    this._audioIconFitType = value
  }

  public set audioTitleToTypeSpacing(value: number) {
    this._audioTitleToTypeSpacing = value
  }

  public set audioButtonWidth(value: number) {
    this._audioButtonWidth = value
  }

  public set audioButtonHeight(value: number) {
    this._audioButtonHeight = value
  }

  public set audioButtonBackgroundColor(value: number | undefined) {
    this._audioButtonBackgroundColor = value
  }

  public set audioButtonBorderStyle(value: BorderStyle) {
    this._audioButtonBorderStyle = value
  }

  public set audioButtonBorderWidth(value: number) {
    this._audioButtonBorderWidth = value
  }

  public set audioButtonBorderColor(value: number | undefined) {
    this._audioButtonBorderColor = value
  }

  public set audioButtonRadiusTopLeft(value: number) {
    this._audioButtonRadiusTopLeft = value
  }

  public set audioButtonRadiusTopRight(value: number) {
    this._audioButtonRadiusTopRight = value
  }

  public set audioButtonRadiusBottomLeft(value: number) {
    this._audioButtonRadiusBottomLeft = value
  }

  public set audioButtonRadiusBottomRight(value: number) {
    this._audioButtonRadiusBottomRight = value
  }

  public set audioButtonText(value: string) {
    this._audioButtonText = value
  }

  public set audioButtonTextFontColor(value: number | undefined) {
    this._audioButtonTextFontColor = value
  }

  public set audioButtonTextFontSize(value: number) {
    this._audioButtonTextFontSize = value
  }

  public set audioButtonTextFontStyle(value: FontStyle) {
    this._audioButtonTextFontStyle = value
  }

  public set audioButtonTextFontWeight(value: FontWeight) {
    this._audioButtonTextFontWeight = value
  }

  public set audioButtonTextFontFamily(value: string) {
    this._audioButtonTextFontFamily = value
  }

  public set audioButtonTextLineHeight(value: number) {
    this._audioButtonTextLineHeight = value
  }

  public set audioTitleTextFontColor(value: number | undefined) {
    this._audioTitleTextFontColor = value
  }

  public set audioTitleTextFontSize(value: number) {
    this._audioTitleTextFontSize = value
  }

  public set audioTitleTextFontStyle(value: FontStyle) {
    this._audioTitleTextFontStyle = value
  }

  public set audioTitleTextFontWeight(value: FontWeight) {
    this._audioTitleTextFontWeight = value
  }

  public set audioTitleTextFontFamily(value: string) {
    this._audioTitleTextFontFamily = value
  }

  public set audioTitleTextLineHeight(value: number) {
    this._audioTitleTextLineHeight = value
  }

  public set audioTypeTextFontColor(value: number | undefined) {
    this._audioTypeTextFontColor = value
  }

  public set audioTypeTextFontSize(value: number) {
    this._audioTypeTextFontSize = value
  }

  public set audioTypeTextFontStyle(value: FontStyle) {
    this._audioTypeTextFontStyle = value
  }

  public set audioTypeTextFontWeight(value: FontWeight) {
    this._audioTypeTextFontWeight = value
  }

  public set audioTypeTextFontFamily(value: string) {
    this._audioTypeTextFontFamily = value
  }

  public set audioTypeTextLineHeight(value: number) {
    this._audioTypeTextLineHeight = value
  }

  constructor() {
    super()
  }
}
