import { BaseMDData } from "./BaseMDData"

export class ImageDataMD extends BaseMDData {
  _callback: boolean = false
  _imageResource: Resource | undefined = undefined
  _imageMarginTop: number = 10
  _imageMarginBottom: number = 10
  _imageBorderRadius: number = 0
  _imageBorderWidth: number = 0
  _imageBorderColor: number = 0xFF000000
  _imageMaximumWidth: number = 1.0
  _imageFixedRatioWidth: number | undefined = undefined
  _imageMaxHeight: number | undefined = undefined
  _imageMaxWidth: number | undefined = undefined
  _isImageDownload: boolean = false
  _isImageMixedLayout: boolean = true
  _imageDownloadImageWidthHeight: number = 18
  _imageDownloadWidth: number = 144
  _imageDownloadHeight: number = 44
  _imageDownloadRadius: number = 22
  _imageDownloadText: string = "下载图片"
  _imageDownloadTexSize: number = 16
  _imageDownloadTexColor: number = 0xE6000000
  _imageDownloadBackgroundColor: number = 0xFFF5F5F5

  public set callback(value: boolean) {
    this._callback = value
  }

  public set imageResource(value: Resource | undefined) {
    this._imageResource = value
  }

  public set imageMarginTop(value: number) {
    this._imageMarginTop = value
  }

  public set imageMarginBottom(value: number) {
    this._imageMarginBottom = value
  }

  public set imageBorderRadius(value: number) {
    this._imageBorderRadius = value
  }

  public set imageBorderWidth(value: number) {
    this._imageBorderWidth = value
  }

  public set imageBorderColor(value: number) {
    this._imageBorderColor = value
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

  public set imageMaxWidth(value: number | undefined) {
    this._imageMaxWidth = value
  }

  public set isImageDownload(value: boolean) {
    this._isImageDownload = value
  }

  public set isImageMixedLayout(value: boolean) {
    this._isImageMixedLayout = value
  }

  public set imageDownloadImageWidthHeight(value: number) {
    this._imageDownloadImageWidthHeight = value
  }

  public set imageDownloadWidth(value: number) {
    this._imageDownloadWidth = value
  }

  public set imageDownloadHeight(value: number) {
    this._imageDownloadHeight = value
  }

  public set imageDownloadRadius(value: number) {
    this._imageDownloadRadius = value
  }

  public set imageDownloadText(value: string) {
    this._imageDownloadText = value
  }

  public set imageDownloadTexSize(value: number) {
    this._imageDownloadTexSize = value
  }

  public set imageDownloadTexColor(value: number) {
    this._imageDownloadTexColor = value
  }

  public set imageDownloadBackgroundColor(value: number) {
    this._imageDownloadBackgroundColor = value
  }

  constructor() {
    super()
  }
}