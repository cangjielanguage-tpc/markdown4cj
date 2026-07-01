import { BaseMDData } from "./BaseMDData"

export class VideoData extends BaseMDData {
  _videoBackgroundColor: ResourceColor | undefined = undefined // 视频背景颜色
  _videoMarginTop: Length = 0.0 // 视频上外边距
  _videoMarginRight: Length = 0.0 // 视频右外边距
  _videoMarginBottom: Length = 0.0 // 视频下外边距
  _videoMarginLeft: Length = 0.0 // 视频左外边距
  _videoPaddingTop: Length = 0.0 // 视频上内边距
  _videoPaddingRight: Length = 0.0 // 视频右内边距
  _videoPaddingBottom: Length = 0.0 // 视频下内边距
  _videoPaddingLeft: Length = 0.0 // 视频左内边距
  _videoRadiusTopLeft: Length = 10.0 // 视频边框左上圆角
  _videoRadiusTopRight: Length = 10.0 // 视频边框右上圆角
  _videoRadiusBottomLeft: Length = 10.0 // 视频边框左下圆角
  _videoRadiusBottomRight: Length = 10.0 // 视频边框右下圆角
  _videoBorderStyle: BorderStyle = BorderStyle.Solid // 视频边框样式
  _videoBorderWidth: Length = 0.0 // 视频边框宽度
  _videoBorderColor: ResourceColor | undefined = undefined // 视频边框颜色
  _videoPlaceholder: Resource | undefined = undefined // 视频占位图
  _videoImageFitType: ImageFit = ImageFit.Cover // 视频图片缩放类型
  _videoPlayIcon: Resource | undefined = undefined // 播放按钮默认图片
  _videoPlayIconWidth: Length = 60.0 // 播放按钮图标宽度
  _videoPlayIconHeight: Length = 60.0 // 播放按钮图标高度
  _videoPlayIconFitType: ImageFit = ImageFit.Contain // 播放按钮图标缩放类型
  _videoTimeTextFontColor: ResourceColor | undefined = undefined // 视频时间文本颜色
  _videoTimeTextFontSize: number | string | Resource = 14.0 // 视频时间文本尺寸
  _videoTimeTextFontStyle: FontStyle = FontStyle.Normal // 视频时间文本字体样式
  _videoTimeTextFontWeight: number | FontWeight = FontWeight.Normal // 视频时间文本字体粗细
  _videoTimeTextFontFamily: string | Resource = 'HarmonyOS Sans' // 视频时间文本字体
  _videoTimeTextLineHeight: number | string | Resource = 22.0 // 视频时间文本行高
  _videoTimeTextMarginRight: Length = 10.0 // 视频时间文本居右边距
  _videoTimeTextMarginBottom: Length = 10.0 // 视频时间文本居底边距
  _videoBottomLayoutVisible: boolean = false // 底部布局是否显示（视频发布/下载按钮）
  _videoBottomLayoutMarginTop: Length = 14.0 // 底部布局距离视频上边距
  _videoReleaseButtonVisible: boolean = true // 视频发布按钮是否显示
  _videoReleaseButtonBackgroundColor: ResourceColor | undefined = undefined // 视频发布按钮背景颜色
  _videoReleaseButtonWidth: Length = 144.0 // 视频发布按钮宽度
  _videoReleaseButtonHeight: Length = 44.0 // 视频发布按钮高度
  _videoReleaseButtonRadiusTopLeft: Length = 22.0 // 视频发布按钮左上圆角
  _videoReleaseButtonRadiusTopRight: Length = 22.0 // 视频发布按钮右上圆角
  _videoReleaseButtonRadiusBottomLeft: Length = 22.0 // 视频发布按钮左下圆角
  _videoReleaseButtonRadiusBottomRight: Length = 22.0 // 视频发布按钮右下圆角
  _videoReleaseButtonIconTextGap: number = 6.0 // 视频发布按钮图标和文本间距
  _videoReleaseButtonIcon: Resource | undefined = undefined // 视频发布按钮图标
  _videoReleaseButtonIconWidth: Length = 18.0 // 视频发布按钮图标宽度
  _videoReleaseButtonIconHeight: Length = 18.0 // 视频发布按钮图标高度
  _videoReleaseButtonText: string = '发布视频' // 视频发布按钮默认文本内容
  _videoReleaseButtonTextFontColor: ResourceColor | undefined = undefined // 视频发布按钮文本颜色
  _videoReleaseButtonTextFontSize: number | string | Resource = 16.0 // 视频发布按钮文本尺寸
  _videoReleaseButtonTextFontStyle: FontStyle = FontStyle.Normal // 视频发布按钮文本字体样式
  _videoReleaseButtonTextFontWeight: number | FontWeight = FontWeight.Medium // 视频发布按钮文本字体粗细
  _videoReleaseButtonTextFontFamily: string | Resource = 'HarmonyOS Sans' // 视频发布按钮文本字体
  _videoReleaseButtonTextLineHeight: number | string | Resource = 22.0 // 视频发布按钮文本行高
  _videoDownloadButtonVisible: boolean = true // 视频下载按钮是否显示
  _videoDownloadButtonBackgroundColor: ResourceColor | undefined = undefined // 视频下载按钮背景颜色
  _videoDownloadButtonWidth: Length = 144.0 // 视频下载按钮宽度
  _videoDownloadButtonHeight: Length = 44.0 // 视频下载按钮高度
  _videoDownloadButtonRadiusTopLeft: Length = 22.0 // 视频下载按钮左上圆角
  _videoDownloadButtonRadiusTopRight: Length = 22.0 // 视频下载按钮右上圆角
  _videoDownloadButtonRadiusBottomLeft: Length = 22.0 // 视频下载按钮左下圆角
  _videoDownloadButtonRadiusBottomRight: Length = 22.0 // 视频下载按钮右下圆角
  _videoDownloadButtonIconTextGap: number = 6.0 // 视频下载按钮图标和文本间距
  _videoDownloadButtonIcon: Resource | undefined = undefined // 视频下载按钮图标
  _videoDownloadButtonIconWidth: Length = 18.0 // 视频下载按钮图标宽度
  _videoDownloadButtonIconHeight: Length = 18.0 // 视频下载按钮图标高度
  _videoDownloadButtonText: string = '下载视频' // 视频下载按钮默认文本内容
  _videoDownloadButtonTextFontColor: ResourceColor | undefined = undefined // 视频下载按钮文本颜色
  _videoDownloadButtonTextFontSize: number | string | Resource = 16.0 // 视频下载按钮文本尺寸
  _videoDownloadButtonTextFontStyle: FontStyle = FontStyle.Normal // 视频下载按钮文本字体样式
  _videoDownloadButtonTextFontWeight: number | FontWeight = FontWeight.Medium // 视频下载按钮文本字体粗细
  _videoDownloadButtonTextFontFamily: string | Resource = 'HarmonyOS Sans' // 视频下载按钮文本字体
  _videoDownloadButtonTextLineHeight: number | string | Resource = 22.0 // 视频下载按钮文本行高

  public set videoBackgroundColor(value: ResourceColor | undefined) {
    this._videoBackgroundColor = value
  }

  public set videoMarginTop(value: Length) {
    this._videoMarginTop = value
  }

  public set videoMarginRight(value: Length) {
    this._videoMarginRight = value
  }

  public set videoMarginBottom(value: Length) {
    this._videoMarginBottom = value
  }

  public set videoMarginLeft(value: Length) {
    this._videoMarginLeft = value
  }

  public set videoPaddingTop(value: Length) {
    this._videoPaddingTop = value
  }

  public set videoPaddingRight(value: Length) {
    this._videoPaddingRight = value
  }

  public set videoPaddingBottom(value: Length) {
    this._videoPaddingBottom = value
  }

  public set videoPaddingLeft(value: Length) {
    this._videoPaddingLeft = value
  }

  public set videoRadiusTopLeft(value: Length) {
    this._videoRadiusTopLeft = value
  }

  public set videoRadiusTopRight(value: Length) {
    this._videoRadiusTopRight = value
  }

  public set videoRadiusBottomLeft(value: Length) {
    this._videoRadiusBottomLeft = value
  }

  public set videoRadiusBottomRight(value: Length) {
    this._videoRadiusBottomRight = value
  }

  public set videoBorderStyle(value: BorderStyle) {
    this._videoBorderStyle = value
  }

  public set videoBorderWidth(value: Length) {
    this._videoBorderWidth = value
  }

  public set videoBorderColor(value: ResourceColor | undefined) {
    this._videoBorderColor = value
  }

  public set videoPlaceholder(value: Resource | undefined) {
    this._videoPlaceholder = value
  }

  public set videoImageFitType(value: ImageFit) {
    this._videoImageFitType = value
  }

  public set videoPlayIcon(value: Resource | undefined) {
    this._videoPlayIcon = value
  }

  public set videoPlayIconWidth(value: Length) {
    this._videoPlayIconWidth = value
  }

  public set videoPlayIconHeight(value: Length) {
    this._videoPlayIconHeight = value
  }

  public set videoPlayIconFitType(value: ImageFit) {
    this._videoPlayIconFitType = value
  }

  public set videoTimeTextFontColor(value: ResourceColor | undefined) {
    this._videoTimeTextFontColor = value
  }

  public set videoTimeTextFontSize(value: number | string | Resource) {
    this._videoTimeTextFontSize = value
  }

  public set videoTimeTextFontStyle(value: FontStyle) {
    this._videoTimeTextFontStyle = value
  }

  public set videoTimeTextFontWeight(value: number | FontWeight) {
    this._videoTimeTextFontWeight = value
  }

  public set videoTimeTextFontFamily(value: string | Resource) {
    this._videoTimeTextFontFamily = value
  }

  public set videoTimeTextLineHeight(value: number | string | Resource) {
    this._videoTimeTextLineHeight = value
  }

  public set videoTimeTextMarginRight(value: Length) {
    this._videoTimeTextMarginRight = value
  }

  public set videoTimeTextMarginBottom(value: Length) {
    this._videoTimeTextMarginBottom = value
  }

  public set videoBottomLayoutVisible(value: boolean) {
    this._videoBottomLayoutVisible = value
  }

  public set videoBottomLayoutMarginTop(value: Length) {
    this._videoBottomLayoutMarginTop = value
  }

  public set videoReleaseButtonVisible(value: boolean) {
    this._videoReleaseButtonVisible = value
  }

  public set videoReleaseButtonBackgroundColor(value: ResourceColor | undefined) {
    this._videoReleaseButtonBackgroundColor = value
  }

  public set videoReleaseButtonWidth(value: Length) {
    this._videoReleaseButtonWidth = value
  }

  public set videoReleaseButtonHeight(value: Length) {
    this._videoReleaseButtonHeight = value
  }

  public set videoReleaseButtonRadiusTopLeft(value: Length) {
    this._videoReleaseButtonRadiusTopLeft = value
  }

  public set videoReleaseButtonRadiusTopRight(value: Length) {
    this._videoReleaseButtonRadiusTopRight = value
  }

  public set videoReleaseButtonRadiusBottomLeft(value: Length) {
    this._videoReleaseButtonRadiusBottomLeft = value
  }

  public set videoReleaseButtonRadiusBottomRight(value: Length) {
    this._videoReleaseButtonRadiusBottomRight = value
  }

  public set videoReleaseButtonIconTextGap(value: number) {
    this._videoReleaseButtonIconTextGap = value
  }

  public set videoReleaseButtonIcon(value: Resource | undefined) {
    this._videoReleaseButtonIcon = value
  }

  public set videoReleaseButtonIconWidth(value: Length) {
    this._videoReleaseButtonIconWidth = value
  }

  public set videoReleaseButtonIconHeight(value: Length) {
    this._videoReleaseButtonIconHeight = value
  }

  public set videoReleaseButtonText(value: string) {
    this._videoReleaseButtonText = value
  }

  public set videoReleaseButtonTextFontColor(value: ResourceColor | undefined) {
    this._videoReleaseButtonTextFontColor = value
  }

  public set videoReleaseButtonTextFontSize(value: number | string | Resource) {
    this._videoReleaseButtonTextFontSize = value
  }

  public set videoReleaseButtonTextFontStyle(value: FontStyle) {
    this._videoReleaseButtonTextFontStyle = value
  }

  public set videoReleaseButtonTextFontWeight(value: number | FontWeight) {
    this._videoReleaseButtonTextFontWeight = value
  }

  public set videoReleaseButtonTextFontFamily(value: string | Resource) {
    this._videoReleaseButtonTextFontFamily = value
  }

  public set videoReleaseButtonTextLineHeight(value: number | string | Resource) {
    this._videoReleaseButtonTextLineHeight = value
  }

  public set videoDownloadButtonVisible(value: boolean) {
    this._videoDownloadButtonVisible = value
  }

  public set videoDownloadButtonBackgroundColor(value: ResourceColor | undefined) {
    this._videoDownloadButtonBackgroundColor = value
  }

  public set videoDownloadButtonWidth(value: Length) {
    this._videoDownloadButtonWidth = value
  }

  public set videoDownloadButtonHeight(value: Length) {
    this._videoDownloadButtonHeight = value
  }

  public set videoDownloadButtonRadiusTopLeft(value: Length) {
    this._videoDownloadButtonRadiusTopLeft = value
  }

  public set videoDownloadButtonRadiusTopRight(value: Length) {
    this._videoDownloadButtonRadiusTopRight = value
  }

  public set videoDownloadButtonRadiusBottomLeft(value: Length) {
    this._videoDownloadButtonRadiusBottomLeft = value
  }

  public set videoDownloadButtonRadiusBottomRight(value: Length) {
    this._videoDownloadButtonRadiusBottomRight = value
  }

  public set videoDownloadButtonIconTextGap(value: number) {
    this._videoDownloadButtonIconTextGap = value
  }

  public set videoDownloadButtonIcon(value: Resource | undefined) {
    this._videoDownloadButtonIcon = value
  }

  public set videoDownloadButtonIconWidth(value: Length) {
    this._videoDownloadButtonIconWidth = value
  }

  public set videoDownloadButtonIconHeight(value: Length) {
    this._videoDownloadButtonIconHeight = value
  }

  public set videoDownloadButtonText(value: string) {
    this._videoDownloadButtonText = value
  }

  public set videoDownloadButtonTextFontColor(value: ResourceColor | undefined) {
    this._videoDownloadButtonTextFontColor = value
  }

  public set videoDownloadButtonTextFontSize(value: number | string | Resource) {
    this._videoDownloadButtonTextFontSize = value
  }

  public set videoDownloadButtonTextFontStyle(value: FontStyle) {
    this._videoDownloadButtonTextFontStyle = value
  }

  public set videoDownloadButtonTextFontWeight(value: number | FontWeight) {
    this._videoDownloadButtonTextFontWeight = value
  }

  public set videoDownloadButtonTextFontFamily(value: string | Resource) {
    this._videoDownloadButtonTextFontFamily = value
  }

  public set videoDownloadButtonTextLineHeight(value: number | string | Resource) {
    this._videoDownloadButtonTextLineHeight = value
  }

  constructor() {
    super()
  }
}
