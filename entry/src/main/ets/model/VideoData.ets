import { BaseMDData } from "./BaseMDData"

export class VideoData extends BaseMDData {
  _videoBorderRadius: number = 10
  _videoTimeTextColor: number | undefined = undefined
  _videoTimeTextSize: number = 14
  _videoTimeTextMarginRight: number = 10
  _videoTimeTextMarginBottom: number = 10
  _videoMarginTop: number = 10
  _videoMarginBottom: number = 10
  _isVideoBottomLayout: boolean = false
  _videoReleaseImageWidthHeight: number = 18
  _videoReleaseWidth: number = 144
  _videoReleaseHeight: number = 44
  _videoReleaseRadius: number = 22
  _videoReleaseText: string = "发布视频"
  _videoReleaseTexSize: number = 16
  _videoReleaseTexColor: number | undefined = undefined
  _videoReleaseBackgroundColor: number | undefined = undefined
  _videoDownloadImageWidthHeight: number = 18
  _videoDownloadWidth: number = 144
  _videoDownloadHeight: number = 44
  _videoDownloadRadius: number = 22
  _videoDownloadText: string = "下载视频"
  _videoDownloadTexSize: number = 16
  _videoDownloadTexColor: number | undefined = undefined
  _videoDownloadBackgroundColor: number | undefined = undefined

  public set videoBorderRadius(value: number) {
    this._videoBorderRadius = value
  }

  public set videoTimeTextColor(value: number | undefined) {
    this._videoTimeTextColor = value
  }

  public set videoTimeTextSize(value: number) {
    this._videoTimeTextSize = value
  }

  public set videoTimeTextMarginRight(value: number) {
    this._videoTimeTextMarginRight = value
  }

  public set videoTimeTextMarginBottom(value: number) {
    this._videoTimeTextMarginBottom = value
  }

  public set videoMarginTop(value: number) {
    this._videoMarginTop = value
  }

  public set videoMarginBottom(value: number) {
    this._videoMarginBottom = value
  }

  public set isVideoBottomLayout(value: boolean) {
    this._isVideoBottomLayout = value
  }

  public set videoReleaseImageWidthHeight(value: number) {
    this._videoReleaseImageWidthHeight = value
  }

  public set videoReleaseWidth(value: number) {
    this._videoReleaseWidth = value
  }

  public set videoReleaseHeight(value: number) {
    this._videoReleaseHeight = value
  }

  public set videoReleaseRadius(value: number) {
    this._videoReleaseRadius = value
  }

  public set videoReleaseText(value: string) {
    this._videoReleaseText = value
  }

  public set videoReleaseTexSize(value: number) {
    this._videoReleaseTexSize = value
  }

  public set videoReleaseTexColor(value: number | undefined) {
    this._videoReleaseTexColor = value
  }

  public set videoReleaseBackgroundColor(value: number | undefined) {
    this._videoReleaseBackgroundColor = value
  }

  public set videoDownloadImageWidthHeight(value: number) {
    this._videoDownloadImageWidthHeight = value
  }

  public set videoDownloadWidth(value: number) {
    this._videoDownloadWidth = value
  }

  public set videoDownloadHeight(value: number) {
    this._videoDownloadHeight = value
  }

  public set videoDownloadRadius(value: number) {
    this._videoDownloadRadius = value
  }

  public set videoDownloadText(value: string) {
    this._videoDownloadText = value
  }

  public set videoDownloadTexSize(value: number) {
    this._videoDownloadTexSize = value
  }

  public set videoDownloadTexColor(value: number | undefined) {
    this._videoDownloadTexColor = value
  }

  public set videoDownloadBackgroundColor(value: number | undefined) {
    this._videoDownloadBackgroundColor = value
  }

  constructor() {
    super()
  }
}