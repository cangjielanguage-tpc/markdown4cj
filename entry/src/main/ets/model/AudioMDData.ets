import { BaseMDData } from "./BaseMDData"

export class AudioMDData extends BaseMDData {
  _audioShadowColor: number | undefined = undefined
  _audioBorderColor: number | undefined = undefined
  _audioBorderWidth: number = 0.5
  _audioBorderRadius: number = 12
  _audioButtonBackgroundColor: number | undefined = undefined
  _audioButtonTextColor: number | undefined = undefined
  _audioButtonTextSize: number = 14.0
  _audioButtonText: string = "立即播放"
  _audioButtonBorderRadius: number = 16.0
  _audioTitleTextSize: number = 15.0
  _audioTitleTextColor: number | undefined = undefined
  _audioTitleTextLineHeight: number = 20.0
  _audioTypeTextSize: number = 11.0
  _audioTypeTextColor: number | undefined = undefined
  _audioTypeTextLineHeight: number = 15.0
  _audioMarginTop: number = 10.0
  _audioMarginBottom: number = 10.0

  public set audioShadowColor(value: number | undefined) {
    this._audioShadowColor = value
  }

  public set audioBorderColor(value: number | undefined) {
    this._audioBorderColor = value
  }


  public set audioBorderWidth(value: number) {
    this._audioBorderWidth = value
  }

  public set audioBorderRadius(value: number) {
    this._audioBorderRadius = value
  }


  public set audioButtonBackgroundColor(value: number | undefined) {
    this._audioButtonBackgroundColor = value
  }


  public set audioButtonTextColor(value: number | undefined) {
    this._audioButtonTextColor = value
  }

  public set audioButtonTextSize(value: number) {
    this._audioButtonTextSize = value
  }


  public set audioButtonText(value: string) {
    this._audioButtonText = value
  }

  public set audioButtonBorderRadius(value: number) {
    this._audioButtonBorderRadius = value
  }


  public set audioTitleTextSize(value: number) {
    this._audioTitleTextSize = value
  }


  public set audioTitleTextColor(value: number | undefined) {
    this._audioTitleTextColor = value
  }


  public set audioTitleTextLineHeight(value: number) {
    this._audioTitleTextLineHeight = value
  }

  public set audioTypeTextSize(value: number) {
    this._audioTypeTextSize = value
  }

  public set audioTypeTextColor(value: number | undefined) {
    this._audioTypeTextColor = value
  }


  public set audioTypeTextLineHeight(value: number) {
    this._audioTypeTextLineHeight = value
  }

  public set audioMarginTop(value: number) {
    this._audioMarginTop = value
  }


  public set audioMarginBottom(value: number) {
    this._audioMarginBottom = value
  }

  constructor() {
    super()
  }
}