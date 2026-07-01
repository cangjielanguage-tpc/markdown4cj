import { BaseMDData } from "./BaseMDData"

export class BannerData extends BaseMDData {
  _bannerMarginTop: number = 0 // banner上外边距
  _bannerMarginRight: number = 0 // banner右外边距
  _bannerMarginBottom: number = 0 // banner下外边距
  _bannerMarginLeft: number = 0 // banner左外边距
  _bannerPaddingTop: number = 0 // banner上内边距
  _bannerPaddingRight: number = 0 // banner右内边距
  _bannerPaddingBottom: number = 0 // banner下内边距
  _bannerPaddingLeft: number = 0 // banner左内边距
  _bannerPlaceholder: Resource | undefined = undefined // banner占位图

  public set bannerMarginTop(value: number) {
    this._bannerMarginTop = value
  }

  public set bannerMarginRight(value: number) {
    this._bannerMarginRight = value
  }

  public set bannerMarginBottom(value: number) {
    this._bannerMarginBottom = value
  }

  public set bannerMarginLeft(value: number) {
    this._bannerMarginLeft = value
  }

  public set bannerPaddingTop(value: number) {
    this._bannerPaddingTop = value
  }

  public set bannerPaddingRight(value: number) {
    this._bannerPaddingRight = value
  }

  public set bannerPaddingBottom(value: number) {
    this._bannerPaddingBottom = value
  }

  public set bannerPaddingLeft(value: number) {
    this._bannerPaddingLeft = value
  }

  public set bannerPlaceholder(value: Resource | undefined) {
    this._bannerPlaceholder = value
  }

  constructor() {
    super()
  }
}