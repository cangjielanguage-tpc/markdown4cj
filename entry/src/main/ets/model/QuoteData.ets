import { BaseMDData } from "./BaseMDData"

export class QuoteData extends BaseMDData {
  _blockQuoteBackgroundColor: number | undefined = undefined // 块引用背景颜色
  _blockQuoteMarginTop: number = 8 // 块引用上外边距
  _blockQuoteMarginRight: number = 8 // 块引用右外边距
  _blockQuoteMarginBottom: number = 8 // 块引用下外边距
  _blockQuoteMarginLeft: number = 8 // 块引用左外边距
  _blockQuotePaddingTop: number = 8 // 块引用上内边距
  _blockQuotePaddingRight: number = 8 // 块引用右内边距
  _blockQuotePaddingBottom: number = 8 // 块引用下内边距
  _blockQuotePaddingLeft: number = 8 // 块引用左内边距
  _blockQuoteRadiusTopLeft: number = 0 // 块引用边框左上圆角
  _blockQuoteRadiusTopRight: number = 0 // 块引用边框右上圆角
  _blockQuoteRadiusBottomLeft: number = 0 // 块引用边框左下圆角
  _blockQuoteRadiusBottomRight: number = 0 // 块引用边框右下圆角
  _blockQuoteLeftBorderWidth: number = 4 // 块引用左侧边框宽度
  _blockQuoteLeftBorderColor: number | undefined = undefined // 块引用左侧边框颜色
  _blockQuoteChildSpacing: number = 4 // 块引用子模块上下间距

  public set blockQuoteBackgroundColor(value: number | undefined) {
    this._blockQuoteBackgroundColor = value
  }

  public set blockQuoteMarginTop(value: number) {
    this._blockQuoteMarginTop = value
  }

  public set blockQuoteMarginRight(value: number) {
    this._blockQuoteMarginRight = value
  }

  public set blockQuoteMarginBottom(value: number) {
    this._blockQuoteMarginBottom = value
  }

  public set blockQuoteMarginLeft(value: number) {
    this._blockQuoteMarginLeft = value
  }

  public set blockQuotePaddingTop(value: number) {
    this._blockQuotePaddingTop = value
  }

  public set blockQuotePaddingRight(value: number) {
    this._blockQuotePaddingRight = value
  }

  public set blockQuotePaddingBottom(value: number) {
    this._blockQuotePaddingBottom = value
  }

  public set blockQuotePaddingLeft(value: number) {
    this._blockQuotePaddingLeft = value
  }

  public set blockQuoteRadiusTopLeft(value: number) {
    this._blockQuoteRadiusTopLeft = value
  }

  public set blockQuoteRadiusTopRight(value: number) {
    this._blockQuoteRadiusTopRight = value
  }

  public set blockQuoteRadiusBottomLeft(value: number) {
    this._blockQuoteRadiusBottomLeft = value
  }

  public set blockQuoteRadiusBottomRight(value: number) {
    this._blockQuoteRadiusBottomRight = value
  }

  public set blockQuoteLeftBorderWidth(value: number) {
    this._blockQuoteLeftBorderWidth = value
  }

  public set blockQuoteLeftBorderColor(value: number | undefined) {
    this._blockQuoteLeftBorderColor = value
  }

  public set blockQuoteChildSpacing(value: number) {
    this._blockQuoteChildSpacing = value
  }

  constructor() {
    super()
  }
}