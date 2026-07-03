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

  constructor() {
    super()
  }
}
