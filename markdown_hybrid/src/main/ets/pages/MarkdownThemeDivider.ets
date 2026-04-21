/**
 * Markdown用户可设置的样式-分割线样式
 */
export class MarkdownThemeDivider {
  /**
   * 分割线上外边距
   */
  dividerMarginTop?: number = undefined

  /**
   * 分割线右外边距
   */
  dividerMarginRight?: number = undefined

  /**
   * 分割线下外边距
   */
  dividerMarginBottom?: number = undefined

  /**
   * 分割线左外边距
   */
  dividerMarginLeft?: number = undefined

  /**
   * 分割线上内边距
   */
  dividerPaddingTop?: number = undefined

  /**
   * 分割线右内边距
   */
  dividerPaddingRight?: number = undefined

  /**
   * 分割线下内边距
   */
  dividerPaddingBottom?: number = undefined

  /**
   * 分割线左内边距
   */
  dividerPaddingLeft?: number = undefined

  /**
   * 分割线颜色
   */
  dividerColor?: number = undefined

  /**
   * 分割线宽度
   */
  dividerStrokeWidth?: number = undefined

  /**
   * 分割线端点样式
   */
  dividerStyle?: LineCapStyle = undefined

  /**
   * 分割线整体外边距
   *
   * @param margin 外边距
   */
  setDividerAllMargin(margin: number): void {
    this.dividerMarginTop = margin
    this.dividerMarginRight = margin
    this.dividerMarginBottom = margin
    this.dividerMarginLeft = margin
  }

  /**
   * 分割线分别设置四个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setDividerMargin(top?: number, right?: number, bottom?: number, left?: number): void {
    this.dividerMarginTop = top
    this.dividerMarginRight = right
    this.dividerMarginBottom = bottom
    this.dividerMarginLeft = left
  }

  /**
   * 分割线整体内边距
   *
   * @param padding 内边距
   */
  setDividerAllPadding(padding: number): void {
    this.dividerPaddingTop = padding
    this.dividerPaddingRight = padding
    this.dividerPaddingBottom = padding
    this.dividerPaddingLeft = padding
  }

  /**
   * 分割线分别设置四个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setDividerPadding(top?: number, right?: number, bottom?: number, left?: number): void {
    this.dividerPaddingTop = top
    this.dividerPaddingRight = right
    this.dividerPaddingBottom = bottom
    this.dividerPaddingLeft = left
  }

  /**
   * 设置分割线颜色
   *
   * @param color 分割线颜色
   */
  setDividerColor(color: number): void {
    this.dividerColor = color
  }

  /**
   * 设置分割线宽度
   *
   * @param strokeWidth 分割线宽度
   */
  setDividerStrokeWidth(strokeWidth: number): void {
    this.dividerStrokeWidth = strokeWidth
  }

  /**
   * 设置分割线端点样式
   *
   * @param style 分割线端点样式
   */
  setDividerStyle(style: LineCapStyle): void {
    this.dividerStyle = style
  }
}
