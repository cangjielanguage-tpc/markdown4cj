import { BaseMDData } from "./BaseMDData"

export class QuoteData extends BaseMDData {
  _blockQuoteBackgroundColor: ResourceColor | undefined = undefined // 块引用背景颜色
  _blockQuoteMarginTop: Length = 0.0 // 块引用上外边距
  _blockQuoteMarginRight: Length = 0.0 // 块引用右外边距
  _blockQuoteMarginBottom: Length = 0.0 // 块引用下外边距
  _blockQuoteMarginLeft: Length = 8.0 // 块引用左外边距
  _blockQuotePaddingTop: Length = 0.0 // 块引用上内边距
  _blockQuotePaddingRight: Length = 0.0 // 块引用右内边距
  _blockQuotePaddingBottom: Length = 0.0 // 块引用下内边距
  _blockQuotePaddingLeft: Length = 8.0 // 块引用左内边距
  _blockQuoteRadiusTopLeft: Length = 0.0 // 块引用左上圆角
  _blockQuoteRadiusTopRight: Length = 0.0 // 块引用右上圆角
  _blockQuoteRadiusBottomLeft: Length = 0.0 // 块引用左下圆角
  _blockQuoteRadiusBottomRight: Length = 0.0 // 块引用右下圆角
  _blockQuoteLeftBorderWidth: Length = 1.0 // 块引用左边框宽度
  _blockQuoteLeftBorderColor: ResourceColor | undefined = undefined // 块引用左边框颜色
  _blockQuoteChildSpacing: number = 8 // 块引用子项间距

  constructor() {
    super()
  }
}