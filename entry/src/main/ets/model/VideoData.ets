import { BaseMDData } from "./BaseMDData"

export class VideoData extends BaseMDData {
  _videoBackgroundColor: number | undefined = undefined // 视频背景颜色
  _videoMarginTop: number = 10 // 视频上外边距
  _videoMarginRight: number = 0 // 视频右外边距
  _videoMarginBottom: number = 10 // 视频下外边距
  _videoMarginLeft: number = 0 // 视频左外边距
  _videoPaddingTop: number = 0 // 视频上内边距
  _videoPaddingRight: number = 0 // 视频右内边距
  _videoPaddingBottom: number = 0 // 视频下内边距
  _videoPaddingLeft: number = 0 // 视频左内边距
  _videoRadiusTopLeft: number = 10 // 视频边框左上圆角
  _videoRadiusTopRight: number = 10 // 视频边框右上圆角
  _videoRadiusBottomLeft: number = 10 // 视频边框左下圆角
  _videoRadiusBottomRight: number = 10 // 视频边框右下圆角
  _videoBorderStyle: BorderStyle = BorderStyle.Solid // 视频边框样式
  _videoBorderWidth: number = 0 // 视频边框宽度
  _videoBorderColor: number | undefined = undefined // 视频边框颜色
  _videoPlaceholder: Resource | undefined = undefined // 视频占位图
  _videoImageFitType: ImageFit = ImageFit.Contain // 视频图片缩放类型
  _videoPlayIcon: Resource | undefined = undefined // 播放按钮默认图片
  _videoPlayIconWidth: number = 40 // 播放按钮图标宽度
  _videoPlayIconHeight: number = 40 // 播放按钮图标高度
  _videoPlayIconFitType: ImageFit = ImageFit.Contain // 播放按钮图标缩放类型
  _videoTimeTextFontColor: number | undefined = undefined // 视频时间文本颜色
  _videoTimeTextFontSize: number = 14 // 视频时间文本尺寸
  _videoTimeTextFontStyle: FontStyle = FontStyle.Normal // 视频时间文本字体样式
  _videoTimeTextFontWeight: FontWeight = FontWeight.Normal // 视频时间文本字体粗细
  _videoTimeTextFontFamily: string = 'HarmonyOS Sans' // 视频时间文本字体
  _videoTimeTextLineHeight: number = 20 // 视频时间文本行高
  _videoTimeTextMarginRight: number = 10 // 视频时间文本居右边距
  _videoTimeTextMarginBottom: number = 10 // 视频时间文本居底边距
  _videoBottomLayoutVisible: boolean = false // 底部布局是否显示（视频发布/下载按钮）
  _videoBottomLayoutMarginTop: number = 8 // 底部布局距离视频上边距
  _videoReleaseButtonVisible: boolean = true // 视频发布按钮是否显示
  _videoReleaseButtonBackgroundColor: number | undefined = undefined // 视频发布按钮背景颜色
  _videoReleaseButtonWidth: number = 144 // 视频发布按钮宽度
  _videoReleaseButtonHeight: number = 44 // 视频发布按钮高度
  _videoReleaseButtonRadiusTopLeft: number = 22 // 视频发布按钮左上圆角
  _videoReleaseButtonRadiusTopRight: number = 22 // 视频发布按钮右上圆角
  _videoReleaseButtonRadiusBottomLeft: number = 22 // 视频发布按钮左下圆角
  _videoReleaseButtonRadiusBottomRight: number = 22 // 视频发布按钮右下圆角
  _videoReleaseButtonIconTextGap: number = 6 // 视频发布按钮图标和文本间距
  _videoReleaseButtonIcon: Resource | undefined = undefined // 视频发布按钮图标
  _videoReleaseButtonIconWidth: number = 18 // 视频发布按钮图标宽度
  _videoReleaseButtonIconHeight: number = 18 // 视频发布按钮图标高度
  _videoReleaseButtonText: string = "发布视频" // 视频发布按钮默认文本内容
  _videoReleaseButtonTextFontColor: number | undefined = undefined // 视频发布按钮文本颜色
  _videoReleaseButtonTextFontSize: number = 16 // 视频发布按钮文本尺寸
  _videoReleaseButtonTextFontStyle: FontStyle = FontStyle.Normal // 视频发布按钮文本字体样式
  _videoReleaseButtonTextFontWeight: FontWeight = FontWeight.Normal // 视频发布按钮文本字体粗细
  _videoReleaseButtonTextFontFamily: string = 'HarmonyOS Sans' // 视频发布按钮文本字体
  _videoReleaseButtonTextLineHeight: number = 20 // 视频发布按钮文本行高
  _videoDownloadButtonVisible: boolean = true // 视频下载按钮是否显示
  _videoDownloadButtonBackgroundColor: number | undefined = undefined // 视频下载按钮背景颜色
  _videoDownloadButtonWidth: number = 144 // 视频下载按钮宽度
  _videoDownloadButtonHeight: number = 44 // 视频下载按钮高度
  _videoDownloadButtonRadiusTopLeft: number = 22 // 视频下载按钮左上圆角
  _videoDownloadButtonRadiusTopRight: number = 22 // 视频下载按钮右上圆角
  _videoDownloadButtonRadiusBottomLeft: number = 22 // 视频下载按钮左下圆角
  _videoDownloadButtonRadiusBottomRight: number = 22 // 视频下载按钮右下圆角
  _videoDownloadButtonIconTextGap: number = 6 // 视频下载按钮图标和文本间距
  _videoDownloadButtonIcon: Resource | undefined = undefined // 视频下载按钮图标
  _videoDownloadButtonIconWidth: number = 18 // 视频下载按钮图标宽度
  _videoDownloadButtonIconHeight: number = 18 // 视频下载按钮图标高度
  _videoDownloadButtonText: string = "下载视频" // 视频下载按钮默认文本内容
  _videoDownloadButtonTextFontColor: number | undefined = undefined // 视频下载按钮文本颜色
  _videoDownloadButtonTextFontSize: number = 16 // 视频下载按钮文本尺寸
  _videoDownloadButtonTextFontStyle: FontStyle = FontStyle.Normal // 视频下载按钮文本字体样式
  _videoDownloadButtonTextFontWeight: FontWeight = FontWeight.Normal // 视频下载按钮文本字体粗细
  _videoDownloadButtonTextFontFamily: string = 'HarmonyOS Sans' // 视频下载按钮文本字体
  _videoDownloadButtonTextLineHeight: number = 20 // 视频下载按钮文本行高

  public set videoBackgroundColor(value: number | undefined) {
    this._videoBackgroundColor = value
  }

  public set videoMarginTop(value: number) {
    this._videoMarginTop = value
  }

  public set videoMarginRight(value: number) {
    this._videoMarginRight = value
  }

  public set videoMarginBottom(value: number) {
    this._videoMarginBottom = value
  }

  public set videoMarginLeft(value: number) {
    this._videoMarginLeft = value
  }

  public set videoPaddingTop(value: number) {
    this._videoPaddingTop = value
  }

  public set videoPaddingRight(value: number) {
    this._videoPaddingRight = value
  }

  public set videoPaddingBottom(value: number) {
    this._videoPaddingBottom = value
  }

  public set videoPaddingLeft(value: number) {
    this._videoPaddingLeft = value
  }

  public set videoRadiusTopLeft(value: number) {
    this._videoRadiusTopLeft = value
  }

  public set videoRadiusTopRight(value: number) {
    this._videoRadiusTopRight = value
  }

  public set videoRadiusBottomLeft(value: number) {
    this._videoRadiusBottomLeft = value
  }

  public set videoRadiusBottomRight(value: number) {
    this._videoRadiusBottomRight = value
  }

  public set videoBorderStyle(value: BorderStyle) {
    this._videoBorderStyle = value
  }

  public set videoBorderWidth(value: number) {
    this._videoBorderWidth = value
  }

  public set videoBorderColor(value: number | undefined) {
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

  public set videoPlayIconWidth(value: number) {
    this._videoPlayIconWidth = value
  }

  public set videoPlayIconHeight(value: number) {
    this._videoPlayIconHeight = value
  }

  public set videoPlayIconFitType(value: ImageFit) {
    this._videoPlayIconFitType = value
  }

  public set videoTimeTextFontColor(value: number | undefined) {
    this._videoTimeTextFontColor = value
  }

  public set videoTimeTextFontSize(value: number) {
    this._videoTimeTextFontSize = value
  }

  public set videoTimeTextFontStyle(value: FontStyle) {
    this._videoTimeTextFontStyle = value
  }

  public set videoTimeTextFontWeight(value: FontWeight) {
    this._videoTimeTextFontWeight = value
  }

  public set videoTimeTextFontFamily(value: string) {
    this._videoTimeTextFontFamily = value
  }

  public set videoTimeTextLineHeight(value: number) {
    this._videoTimeTextLineHeight = value
  }

  public set videoTimeTextMarginRight(value: number) {
    this._videoTimeTextMarginRight = value
  }

  public set videoTimeTextMarginBottom(value: number) {
    this._videoTimeTextMarginBottom = value
  }

  public set videoBottomLayoutVisible(value: boolean) {
    this._videoBottomLayoutVisible = value
  }

  public set videoBottomLayoutMarginTop(value: number) {
    this._videoBottomLayoutMarginTop = value
  }

  public set videoReleaseButtonVisible(value: boolean) {
    this._videoReleaseButtonVisible = value
  }

  public set videoReleaseButtonBackgroundColor(value: number | undefined) {
    this._videoReleaseButtonBackgroundColor = value
  }

  public set videoReleaseButtonWidth(value: number) {
    this._videoReleaseButtonWidth = value
  }

  public set videoReleaseButtonHeight(value: number) {
    this._videoReleaseButtonHeight = value
  }

  public set videoReleaseButtonRadiusTopLeft(value: number) {
    this._videoReleaseButtonRadiusTopLeft = value
  }

  public set videoReleaseButtonRadiusTopRight(value: number) {
    this._videoReleaseButtonRadiusTopRight = value
  }

  public set videoReleaseButtonRadiusBottomLeft(value: number) {
    this._videoReleaseButtonRadiusBottomLeft = value
  }

  public set videoReleaseButtonRadiusBottomRight(value: number) {
    this._videoReleaseButtonRadiusBottomRight = value
  }

  public set videoReleaseButtonIconTextGap(value: number) {
    this._videoReleaseButtonIconTextGap = value
  }

  public set videoReleaseButtonIcon(value: Resource | undefined) {
    this._videoReleaseButtonIcon = value
  }

  public set videoReleaseButtonIconWidth(value: number) {
    this._videoReleaseButtonIconWidth = value
  }

  public set videoReleaseButtonIconHeight(value: number) {
    this._videoReleaseButtonIconHeight = value
  }

  public set videoReleaseButtonText(value: string) {
    this._videoReleaseButtonText = value
  }

  public set videoReleaseButtonTextFontColor(value: number | undefined) {
    this._videoReleaseButtonTextFontColor = value
  }

  public set videoReleaseButtonTextFontSize(value: number) {
    this._videoReleaseButtonTextFontSize = value
  }

  public set videoReleaseButtonTextFontStyle(value: FontStyle) {
    this._videoReleaseButtonTextFontStyle = value
  }

  public set videoReleaseButtonTextFontWeight(value: FontWeight) {
    this._videoReleaseButtonTextFontWeight = value
  }

  public set videoReleaseButtonTextFontFamily(value: string) {
    this._videoReleaseButtonTextFontFamily = value
  }

  public set videoReleaseButtonTextLineHeight(value: number) {
    this._videoReleaseButtonTextLineHeight = value
  }

  public set videoDownloadButtonVisible(value: boolean) {
    this._videoDownloadButtonVisible = value
  }

  public set videoDownloadButtonBackgroundColor(value: number | undefined) {
    this._videoDownloadButtonBackgroundColor = value
  }

  public set videoDownloadButtonWidth(value: number) {
    this._videoDownloadButtonWidth = value
  }

  public set videoDownloadButtonHeight(value: number) {
    this._videoDownloadButtonHeight = value
  }

  public set videoDownloadButtonRadiusTopLeft(value: number) {
    this._videoDownloadButtonRadiusTopLeft = value
  }

  public set videoDownloadButtonRadiusTopRight(value: number) {
    this._videoDownloadButtonRadiusTopRight = value
  }

  public set videoDownloadButtonRadiusBottomLeft(value: number) {
    this._videoDownloadButtonRadiusBottomLeft = value
  }

  public set videoDownloadButtonRadiusBottomRight(value: number) {
    this._videoDownloadButtonRadiusBottomRight = value
  }

  public set videoDownloadButtonIconTextGap(value: number) {
    this._videoDownloadButtonIconTextGap = value
  }

  public set videoDownloadButtonIcon(value: Resource | undefined) {
    this._videoDownloadButtonIcon = value
  }

  public set videoDownloadButtonIconWidth(value: number) {
    this._videoDownloadButtonIconWidth = value
  }

  public set videoDownloadButtonIconHeight(value: number) {
    this._videoDownloadButtonIconHeight = value
  }

  public set videoDownloadButtonText(value: string) {
    this._videoDownloadButtonText = value
  }

  public set videoDownloadButtonTextFontColor(value: number | undefined) {
    this._videoDownloadButtonTextFontColor = value
  }

  public set videoDownloadButtonTextFontSize(value: number) {
    this._videoDownloadButtonTextFontSize = value
  }

  public set videoDownloadButtonTextFontStyle(value: FontStyle) {
    this._videoDownloadButtonTextFontStyle = value
  }

  public set videoDownloadButtonTextFontWeight(value: FontWeight) {
    this._videoDownloadButtonTextFontWeight = value
  }

  public set videoDownloadButtonTextFontFamily(value: string) {
    this._videoDownloadButtonTextFontFamily = value
  }

  public set videoDownloadButtonTextLineHeight(value: number) {
    this._videoDownloadButtonTextLineHeight = value
  }

  constructor() {
    super()
  }
}
