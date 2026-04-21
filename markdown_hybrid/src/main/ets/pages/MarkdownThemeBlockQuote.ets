/**
 * Markdown用户可设置的样式-块引用样式
 */
export class MarkdownThemeBlockQuote {
  /**
   * 块引用背景颜色
   */
  blockQuoteBackgroundColor?: number = undefined

  /**
   * 块引用上外边距
   */
  blockQuoteMarginTop?: number = undefined

  /**
   * 块引用右外边距
   */
  blockQuoteMarginRight?: number = undefined

  /**
   * 块引用下外边距
   */
  blockQuoteMarginBottom?: number = undefined

  /**
   * 块引用左外边距
   */
  blockQuoteMarginLeft?: number = undefined

  /**
   * 块引用上内边距
   */
  blockQuotePaddingTop?: number = undefined

  /**
   * 块引用右内边距
   */
  blockQuotePaddingRight?: number = undefined

  /**
   * 块引用下内边距
   */
  blockQuotePaddingBottom?: number = undefined

  /**
   * 块引用左内边距
   */
  blockQuotePaddingLeft?: number = undefined

  /**
   * 块引用边框左上圆角
   */
  blockQuoteRadiusTopLeft?: number = undefined

  /**
   * 块引用边框右上圆角
   */
  blockQuoteRadiusTopRight?: number = undefined

  /**
   * 块引用边框左下圆角
   */
  blockQuoteRadiusBottomLeft?: number = undefined

  /**
   * 块引用边框右下圆角
   */
  blockQuoteRadiusBottomRight?: number = undefined

  /**
   * 块引用左侧边框宽度
   */
  blockQuoteLeftBorderWidth?: number = undefined

  /**
   * 块引用左侧边框颜色
   */
  blockQuoteLeftBorderColor?: number = undefined

  /**
   * 块引用左侧线条和内容的间距
   */
  blockQuoteBorderContentSpacing?: number = undefined

  /**
   * 块引用子模块上下间距
   */
  blockQuoteChildSpacing?: number = undefined

  /**
   * 设置块引用背景颜色
   *
   * @param color 块引用背景颜色
   */
  setBlockQuoteBackgroundColor(color: number): void {
    this.blockQuoteBackgroundColor = color
  }

  /**
   * 块引用整体外边距
   *
   * @param margin 外边距
   */
  setBlockQuoteAllMargin(margin: number): void {
    this.blockQuoteMarginTop = margin
    this.blockQuoteMarginRight = margin
    this.blockQuoteMarginBottom = margin
    this.blockQuoteMarginLeft = margin
  }

  /**
   * 块引用分别设置四个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setBlockQuoteMargin(top?: number, right?: number, bottom?: number, left?: number): void {
    this.blockQuoteMarginTop = top
    this.blockQuoteMarginRight = right
    this.blockQuoteMarginBottom = bottom
    this.blockQuoteMarginLeft = left
  }

  /**
   * 块引用整体内边距
   *
   * @param padding 内边距
   */
  setBlockQuoteAllPadding(padding: number): void {
    this.blockQuotePaddingTop = padding
    this.blockQuotePaddingRight = padding
    this.blockQuotePaddingBottom = padding
    this.blockQuotePaddingLeft = padding
  }

  /**
   * 块引用分别设置四个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setBlockQuotePadding(top?: number, right?: number, bottom?: number, left?: number): void {
    this.blockQuotePaddingTop = top
    this.blockQuotePaddingRight = right
    this.blockQuotePaddingBottom = bottom
    this.blockQuotePaddingLeft = left
  }

  /**
   * 块引用整体圆角
   *
   * @param radius 圆角
   */
  setBlockQuoteAllRadius(radius: number): void {
    this.blockQuoteRadiusTopLeft = radius
    this.blockQuoteRadiusTopRight = radius
    this.blockQuoteRadiusBottomLeft = radius
    this.blockQuoteRadiusBottomRight = radius
  }

  /**
   * 块引用分别设置四个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setBlockQuoteRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void {
    this.blockQuoteRadiusTopLeft = topLeft
    this.blockQuoteRadiusTopRight = topRight
    this.blockQuoteRadiusBottomLeft = bottomLeft
    this.blockQuoteRadiusBottomRight = bottomRight
  }

  /**
   * 设置块引用左侧边框宽度
   *
   * @param width 块引用左侧边框宽度
   */
  setBlockQuoteLeftBorderWidth(width: number): void {
    this.blockQuoteLeftBorderWidth = width
  }

  /**
   * 设置块引用左侧边框颜色
   *
   * @param color 块引用左侧边框颜色
   */
  setBlockQuoteLeftBorderColor(color: number): void {
    this.blockQuoteLeftBorderColor = color
  }

  /**
   * 设置块引用左侧线条和内容的间距
   *
   * @param spacing 块引用左侧线条和内容的间距
   */
  setBlockQuoteBorderContentSpacing(spacing: number): void {
    this.blockQuoteBorderContentSpacing = spacing
  }

  /**
   * 设置块引用子模块上下间距
   *
   * @param spacing 块引用子模块上下间距
   */
  setBlockQuoteChildSpacing(spacing: number): void {
    this.blockQuoteChildSpacing = spacing
  }
}
