import { BaseMDData } from "./BaseMDData"

export class AudioMDData extends BaseMDData {
  _audioBackgroundColor: ResourceColor | undefined = undefined // 音频块背景颜色
  _audioMarginTop: Length = 0.0 // 音频块上外边距
  _audioMarginRight: Length = 0.0 // 音频块右外边距
  _audioMarginBottom: Length = 0.0 // 音频块下外边距
  _audioMarginLeft: Length = 0.0 // 音频块左外边距
  _audioPaddingTop: Length = 12.0 // 音频块上内边距
  _audioPaddingRight: Length = 16.0 // 音频块右内边距
  _audioPaddingBottom: Length = 12.0 // 音频块下内边距
  _audioPaddingLeft: Length = 12.0 // 音频块左内边距
  _audioBorderStyle: BorderStyle = BorderStyle.Solid // 音频块边框样式
  _audioBorderWidth: Length = 0.5 // 音频块边框宽度
  _audioBorderColor: ResourceColor | undefined = undefined // 音频块边框颜色
  _audioRadiusTopLeft: Length = 12.0 // 音频块左上圆角
  _audioRadiusTopRight: Length = 12.0 // 音频块右上圆角
  _audioRadiusBottomLeft: Length = 12.0 // 音频块左下圆角
  _audioRadiusBottomRight: Length = 12.0 // 音频块右下圆角
  _audioShadowRadius: number = 12.0 // 音频块阴影半径
  _audioShadowColor: ResourceColor | undefined = undefined // 音频块阴影颜色
  _audioShadowOffsetX: number = 0.0 // 音频块阴影X偏移
  _audioShadowOffsetY: number = 2.0 // 音频块阴影Y偏移
  _audioIcon: Resource | undefined = undefined // 音频图标资源
  _audioIconWidth: Length = 40.0 // 音频图标宽度
  _audioIconHeight: Length = 40.0 // 音频图标高度
  _audioIconRadiusTopLeft: Length = 8.0 // 音频图标左上圆角
  _audioIconRadiusTopRight: Length = 8.0 // 音频图标右上圆角
  _audioIconRadiusBottomLeft: Length = 8.0 // 音频图标左下圆角
  _audioIconRadiusBottomRight: Length = 8.0 // 音频图标右下圆角
  _audioIconFitType: ImageFit = ImageFit.Cover // 音频图标图像适应类型
  _audioTitleToTypeSpacing: number = 2.0 // 音频标题与类型间距
  _audioTitleTextFontColor: ResourceColor | undefined = undefined // 音频标题文本字体颜色
  _audioTitleTextFontSize: number | string | Resource = 15.0 // 音频标题文本字体大小
  _audioTitleTextFontStyle: FontStyle = FontStyle.Normal // 音频标题文本字体样式
  _audioTitleTextFontWeight: number | FontWeight = FontWeight.Bold // 音频标题文本字体粗细
  _audioTitleTextFontFamily: string | Resource = 'HarmonyOS Sans' // 音频标题文本字体族
  _audioTitleTextLineHeight: number | string | Resource = 20.0 // 音频标题文本行高
  _audioTypeTextFontColor: ResourceColor | undefined = undefined // 音频类型文本字体颜色
  _audioTypeTextFontSize: number | string | Resource = 11.0 // 音频类型文本字体大小
  _audioTypeTextFontStyle: FontStyle = FontStyle.Normal // 音频类型文本字体样式
  _audioTypeTextFontWeight: number | FontWeight = FontWeight.Normal // 音频类型文本字体粗细
  _audioTypeTextFontFamily: string | Resource = 'HarmonyOS Sans' // 音频类型文本字体族
  _audioTypeTextLineHeight: number | string | Resource = 15.0 // 音频类型文本行高
  _audioButtonBackgroundColor: ResourceColor | undefined = undefined // 音频播放按钮背景颜色
  _audioButtonWidth: Length = 84.0 // 音频播放按钮宽度
  _audioButtonHeight: Length = 32.0 // 音频播放按钮高度
  _audioButtonBorderStyle: BorderStyle = BorderStyle.Solid // 音频播放按钮边框样式
  _audioButtonBorderWidth: Length = 0.0 // 音频播放按钮边框宽度
  _audioButtonBorderColor: ResourceColor | undefined = undefined // 音频播放按钮边框颜色
  _audioButtonRadiusTopLeft: Length = 16.0 // 音频播放按钮左上圆角
  _audioButtonRadiusTopRight: Length = 16.0 // 音频播放按钮右上圆角
  _audioButtonRadiusBottomLeft: Length = 16.0 // 音频播放按钮左下圆角
  _audioButtonRadiusBottomRight: Length = 16.0 // 音频播放按钮右下圆角
  _audioButtonText: string = '立即播放' // 音频播放按钮文本显示
  _audioButtonTextFontColor: ResourceColor | undefined = undefined // 音频播放按钮文本字体颜色
  _audioButtonTextFontSize: number | string | Resource = 14.0 // 音频播放按钮文本字体大小
  _audioButtonTextFontStyle: FontStyle = FontStyle.Normal // 音频播放按钮文本字体样式
  _audioButtonTextFontWeight: number | FontWeight = FontWeight.Medium // 音频播放按钮文本字体粗细
  _audioButtonTextFontFamily: string | Resource = 'HarmonyOS Sans' // 音频播放按钮文本字体族
  _audioButtonTextLineHeight: number | string | Resource = 22.0 // 音频播放按钮文本行高

  public set audioBackgroundColor(value: ResourceColor | undefined) {
    this._audioBackgroundColor = value
  }

  public set audioMarginTop(value: Length) {
    this._audioMarginTop = value
  }

  public set audioMarginRight(value: Length) {
    this._audioMarginRight = value
  }

  public set audioMarginBottom(value: Length) {
    this._audioMarginBottom = value
  }

  public set audioMarginLeft(value: Length) {
    this._audioMarginLeft = value
  }

  public set audioPaddingTop(value: Length) {
    this._audioPaddingTop = value
  }

  public set audioPaddingRight(value: Length) {
    this._audioPaddingRight = value
  }

  public set audioPaddingBottom(value: Length) {
    this._audioPaddingBottom = value
  }

  public set audioPaddingLeft(value: Length) {
    this._audioPaddingLeft = value
  }

  public set audioBorderStyle(value: BorderStyle) {
    this._audioBorderStyle = value
  }

  public set audioBorderWidth(value: Length) {
    this._audioBorderWidth = value
  }

  public set audioBorderColor(value: ResourceColor | undefined) {
    this._audioBorderColor = value
  }

  public set audioRadiusTopLeft(value: Length) {
    this._audioRadiusTopLeft = value
  }

  public set audioRadiusTopRight(value: Length) {
    this._audioRadiusTopRight = value
  }

  public set audioRadiusBottomLeft(value: Length) {
    this._audioRadiusBottomLeft = value
  }

  public set audioRadiusBottomRight(value: Length) {
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

  public set audioShadowColor(value: ResourceColor | undefined) {
    this._audioShadowColor = value
  }

  public set audioIcon(value: Resource | undefined) {
    this._audioIcon = value
  }

  public set audioIconWidth(value: Length) {
    this._audioIconWidth = value
  }

  public set audioIconHeight(value: Length) {
    this._audioIconHeight = value
  }

  public set audioIconRadiusTopLeft(value: Length) {
    this._audioIconRadiusTopLeft = value
  }

  public set audioIconRadiusTopRight(value: Length) {
    this._audioIconRadiusTopRight = value
  }

  public set audioIconRadiusBottomLeft(value: Length) {
    this._audioIconRadiusBottomLeft = value
  }

  public set audioIconRadiusBottomRight(value: Length) {
    this._audioIconRadiusBottomRight = value
  }

  public set audioIconFitType(value: ImageFit) {
    this._audioIconFitType = value
  }

  public set audioTitleToTypeSpacing(value: number) {
    this._audioTitleToTypeSpacing = value
  }

  public set audioButtonWidth(value: Length) {
    this._audioButtonWidth = value
  }

  public set audioButtonHeight(value: Length) {
    this._audioButtonHeight = value
  }

  public set audioButtonBackgroundColor(value: ResourceColor | undefined) {
    this._audioButtonBackgroundColor = value
  }

  public set audioButtonBorderStyle(value: BorderStyle) {
    this._audioButtonBorderStyle = value
  }

  public set audioButtonBorderWidth(value: Length) {
    this._audioButtonBorderWidth = value
  }

  public set audioButtonBorderColor(value: ResourceColor | undefined) {
    this._audioButtonBorderColor = value
  }

  public set audioButtonRadiusTopLeft(value: Length) {
    this._audioButtonRadiusTopLeft = value
  }

  public set audioButtonRadiusTopRight(value: Length) {
    this._audioButtonRadiusTopRight = value
  }

  public set audioButtonRadiusBottomLeft(value: Length) {
    this._audioButtonRadiusBottomLeft = value
  }

  public set audioButtonRadiusBottomRight(value: Length) {
    this._audioButtonRadiusBottomRight = value
  }

  public set audioButtonText(value: string) {
    this._audioButtonText = value
  }

  public set audioButtonTextFontColor(value: ResourceColor | undefined) {
    this._audioButtonTextFontColor = value
  }

  public set audioButtonTextFontSize(value: number | string | Resource) {
    this._audioButtonTextFontSize = value
  }

  public set audioButtonTextFontStyle(value: FontStyle) {
    this._audioButtonTextFontStyle = value
  }

  public set audioButtonTextFontWeight(value: number | FontWeight) {
    this._audioButtonTextFontWeight = value
  }

  public set audioButtonTextFontFamily(value: string | Resource) {
    this._audioButtonTextFontFamily = value
  }

  public set audioButtonTextLineHeight(value: number | string | Resource) {
    this._audioButtonTextLineHeight = value
  }

  public set audioTitleTextFontColor(value: ResourceColor | undefined) {
    this._audioTitleTextFontColor = value
  }

  public set audioTitleTextFontSize(value: number | string | Resource) {
    this._audioTitleTextFontSize = value
  }

  public set audioTitleTextFontStyle(value: FontStyle) {
    this._audioTitleTextFontStyle = value
  }

  public set audioTitleTextFontWeight(value: number | FontWeight) {
    this._audioTitleTextFontWeight = value
  }

  public set audioTitleTextFontFamily(value: string | Resource) {
    this._audioTitleTextFontFamily = value
  }

  public set audioTitleTextLineHeight(value: number | string | Resource) {
    this._audioTitleTextLineHeight = value
  }

  public set audioTypeTextFontColor(value: ResourceColor | undefined) {
    this._audioTypeTextFontColor = value
  }

  public set audioTypeTextFontSize(value: number | string | Resource) {
    this._audioTypeTextFontSize = value
  }

  public set audioTypeTextFontStyle(value: FontStyle) {
    this._audioTypeTextFontStyle = value
  }

  public set audioTypeTextFontWeight(value: number | FontWeight) {
    this._audioTypeTextFontWeight = value
  }

  public set audioTypeTextFontFamily(value: string | Resource) {
    this._audioTypeTextFontFamily = value
  }

  public set audioTypeTextLineHeight(value: number | string | Resource) {
    this._audioTypeTextLineHeight = value
  }

  constructor() {
    super()
  }
}
