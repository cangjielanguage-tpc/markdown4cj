import { ImageFitType } from "@cangjie-tpc/markdown_hybrid"
import { BaseMDData } from "./BaseMDData"

export class ImageDataMD extends BaseMDData {
  _imageMarginTop: number = 10 // 图片上外边距
  _imageMarginRight: number = 0 // 图片右外边距
  _imageMarginBottom: number = 10 // 图片下外边距
  _imageMarginLeft: number = 0 // 图片左外边距
  _imageRadiusTopLeft: number = 0 // 图片边框左上圆角
  _imageRadiusTopRight: number = 0 // 图片边框右上圆角
  _imageRadiusBottomLeft: number = 0 // 图片边框左下圆角
  _imageRadiusBottomRight: number = 0 // 图片边框右下圆角
  _imageBorderStyle: BorderStyle = BorderStyle.Solid // 图片边框样式
  _imageBorderWidth: number = 0 // 图片边框宽度
  _imageBorderColor: number | undefined = undefined // 图片边框颜色
  _imagePlaceholder: Resource | undefined = undefined // 图片默认占位图
  _imageReplace: boolean = true // 图片是否替换
  _imageAutoResize: boolean = true // 网络图片是否压缩
  _isImageMixedLayout: boolean = true // 是否图文混排
  _imageMaximumWidth: number = 1.0 // 图片基于自身宽度缩放百分比
  _imageFixedRatioWidth: number | undefined = undefined // 图片基于父布局宽度缩放百分比
  _imageMaxHeight: number | undefined = undefined // 图片最大高度
  _imageHeight: number | undefined = undefined // 图片高度
  _imageMaxWidth: number | undefined = undefined // 图片最大宽度
  _imageWidth: number | undefined = undefined // 图片宽度
  _imageFitType: ImageFitType = ImageFitType.Contain // 图片缩放类型
  _imageBottomLayoutMarginTop: number = 8 // 底部布局距离图片上边距
  _imageDownloadButtonVisible: boolean = true // 图片下载按钮是否显示
  _imageDownloadButtonWidth: number = 144 // 图片下载按钮宽度
  _imageDownloadButtonHeight: number = 44 // 图片下载按钮高度
  _imageDownloadButtonRadiusTopLeft: number = 22 // 图片下载按钮左上圆角
  _imageDownloadButtonRadiusTopRight: number = 22 // 图片下载按钮右上圆角
  _imageDownloadButtonRadiusBottomLeft: number = 22 // 图片下载按钮左下圆角
  _imageDownloadButtonRadiusBottomRight: number = 22 // 图片下载按钮右下圆角
  _imageDownloadButtonIcon: Resource | undefined = undefined // 图片下载按钮图标
  _imageDownloadButtonIconWidth: number = 18 // 图片下载按钮图标宽度
  _imageDownloadButtonIconHeight: number = 18 // 图片下载按钮图标高度
  _imageDownloadButtonIconTextGap: number = 6 // 图片下载按钮图标和文本间距
  _imageDownloadButtonBackgroundColor: number | undefined = undefined // 图片下载按钮背景颜色
  _imageDownloadButtonText: string = "下载图片" // 图片下载按钮默认文本内容
  _imageDownloadButtonTextFontColor: number | undefined = undefined // 图片下载按钮文本颜色
  _imageDownloadButtonTextFontSize: number = 16 // 图片下载按钮文本尺寸
  _imageDownloadButtonTextFontStyle: FontStyle = FontStyle.Normal // 图片下载按钮文本字体样式
  _imageDownloadButtonTextFontWeight: FontWeight = FontWeight.Normal // 图片下载按钮文本字体粗细
  _imageDownloadButtonTextFontFamily: string = 'HarmonyOS Sans' // 图片下载按钮文本字体
  _imageDownloadButtonTextLineHeight: number = 20 // 图片下载按钮文本行高

  public set imageMarginTop(value: number) {
    this._imageMarginTop = value
  }

  public set imageMarginRight(value: number) {
    this._imageMarginRight = value
  }

  public set imageMarginBottom(value: number) {
    this._imageMarginBottom = value
  }

  public set imageMarginLeft(value: number) {
    this._imageMarginLeft = value
  }

  public set imageRadiusTopLeft(value: number) {
    this._imageRadiusTopLeft = value
  }

  public set imageRadiusTopRight(value: number) {
    this._imageRadiusTopRight = value
  }

  public set imageRadiusBottomLeft(value: number) {
    this._imageRadiusBottomLeft = value
  }

  public set imageRadiusBottomRight(value: number) {
    this._imageRadiusBottomRight = value
  }

  public set imageBorderStyle(value: BorderStyle) {
    this._imageBorderStyle = value
  }

  public set imageBorderWidth(value: number) {
    this._imageBorderWidth = value
  }

  public set imageBorderColor(value: number | undefined) {
    this._imageBorderColor = value
  }

  public set imagePlaceholder(value: Resource | undefined) {
    this._imagePlaceholder = value
  }

  public set imageReplace(value: boolean) {
    this._imageReplace = value
  }

  public set imageAutoResize(value: boolean) {
    this._imageAutoResize = value
  }

  public set isImageMixedLayout(value: boolean) {
    this._isImageMixedLayout = value
  }

  public set imageMaximumWidth(value: number) {
    this._imageMaximumWidth = value
  }

  public set imageFixedRatioWidth(value: number | undefined) {
    this._imageFixedRatioWidth = value
  }

  public set imageMaxHeight(value: number | undefined) {
    this._imageMaxHeight = value
  }

  public set imageHeight(value: number | undefined) {
    this._imageHeight = value
  }

  public set imageMaxWidth(value: number | undefined) {
    this._imageMaxWidth = value
  }

  public set imageWidth(value: number | undefined) {
    this._imageWidth = value
  }

  public set imageFitType(value: ImageFitType) {
    this._imageFitType = value
  }

  public set imageBottomLayoutMarginTop(value: number) {
    this._imageBottomLayoutMarginTop = value
  }

  public set imageDownloadButtonVisible(value: boolean) {
    this._imageDownloadButtonVisible = value
  }

  public set imageDownloadButtonWidth(value: number) {
    this._imageDownloadButtonWidth = value
  }

  public set imageDownloadButtonHeight(value: number) {
    this._imageDownloadButtonHeight = value
  }

  public set imageDownloadButtonRadiusTopLeft(value: number) {
    this._imageDownloadButtonRadiusTopLeft = value
  }

  public set imageDownloadButtonRadiusTopRight(value: number) {
    this._imageDownloadButtonRadiusTopRight = value
  }

  public set imageDownloadButtonRadiusBottomLeft(value: number) {
    this._imageDownloadButtonRadiusBottomLeft = value
  }

  public set imageDownloadButtonRadiusBottomRight(value: number) {
    this._imageDownloadButtonRadiusBottomRight = value
  }

  public set imageDownloadButtonIcon(value: Resource | undefined) {
    this._imageDownloadButtonIcon = value
  }

  public set imageDownloadButtonIconWidth(value: number) {
    this._imageDownloadButtonIconWidth = value
  }

  public set imageDownloadButtonIconHeight(value: number) {
    this._imageDownloadButtonIconHeight = value
  }

  public set imageDownloadButtonIconTextGap(value: number) {
    this._imageDownloadButtonIconTextGap = value
  }

  public set imageDownloadButtonBackgroundColor(value: number | undefined) {
    this._imageDownloadButtonBackgroundColor = value
  }

  public set imageDownloadButtonText(value: string) {
    this._imageDownloadButtonText = value
  }

  public set imageDownloadButtonTextFontColor(value: number | undefined) {
    this._imageDownloadButtonTextFontColor = value
  }

  public set imageDownloadButtonTextFontSize(value: number) {
    this._imageDownloadButtonTextFontSize = value
  }

  public set imageDownloadButtonTextFontStyle(value: FontStyle) {
    this._imageDownloadButtonTextFontStyle = value
  }

  public set imageDownloadButtonTextFontWeight(value: FontWeight) {
    this._imageDownloadButtonTextFontWeight = value
  }

  public set imageDownloadButtonTextFontFamily(value: string) {
    this._imageDownloadButtonTextFontFamily = value
  }

  public set imageDownloadButtonTextLineHeight(value: number) {
    this._imageDownloadButtonTextLineHeight = value
  }

  constructor() {
    super()
  }
}
