import { BaseMDData } from "./BaseMDData"

export class BannerData extends BaseMDData {
  _bannerMarginTop: Length = 0.0 // banner上外边距
  _bannerMarginRight: Length = 0.0 // banner右外边距
  _bannerMarginBottom: Length = 0.0 // banner下外边距
  _bannerMarginLeft: Length = 0.0 // banner左外边距
  _bannerPaddingTop: Length = 0.0 // banner上内边距
  _bannerPaddingRight: Length = 0.0 // banner右内边距
  _bannerPaddingBottom: Length = 0.0 // banner下内边距
  _bannerPaddingLeft: Length = 0.0 // banner左内边距
  _bannerPlaceholder: Resource | undefined = undefined // banner占位图

  public set bannerMarginTop(value: Length) {
    this._bannerMarginTop = value
  }

  public set bannerMarginRight(value: Length) {
    this._bannerMarginRight = value
  }

  public set bannerMarginBottom(value: Length) {
    this._bannerMarginBottom = value
  }

  public set bannerMarginLeft(value: Length) {
    this._bannerMarginLeft = value
  }

  public set bannerPaddingTop(value: Length) {
    this._bannerPaddingTop = value
  }

  public set bannerPaddingRight(value: Length) {
    this._bannerPaddingRight = value
  }

  public set bannerPaddingBottom(value: Length) {
    this._bannerPaddingBottom = value
  }

  public set bannerPaddingLeft(value: Length) {
    this._bannerPaddingLeft = value
  }

  public set bannerPlaceholder(value: Resource | undefined) {
    this._bannerPlaceholder = value
  }

  constructor() {
    super()
  }
}