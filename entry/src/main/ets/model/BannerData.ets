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

  constructor() {
    super()
  }
}