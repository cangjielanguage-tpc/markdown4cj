/**
 * Markdown用户可设置的样式-脚注定义样式
 */
export class MarkdownThemeFootnoteDef {
  /**
   * 脚注定义背景颜色
   */
  private footnoteDefBackgroundColor?: number = undefined

  /**
   * 脚注定义上外边距
   */
  private footnoteDefMarginTop?: number = undefined

  /**
   * 脚注定义右外边距
   */
  private footnoteDefMarginRight?: number = undefined

  /**
   * 脚注定义下外边距
   */
  private footnoteDefMarginBottom?: number = undefined

  /**
   * 脚注定义左外边距
   */
  private footnoteDefMarginLeft?: number = undefined

  /**
   * 脚注定义上内边距
   */
  private footnoteDefPaddingTop?: number = undefined

  /**
   * 脚注定义右内边距
   */
  private footnoteDefPaddingRight?: number = undefined

  /**
   * 脚注定义下内边距
   */
  private footnoteDefPaddingBottom?: number = undefined

  /**
   * 脚注定义左内边距
   */
  private footnoteDefPaddingLeft?: number = undefined

  /**
   * 设置脚注定义背景颜色
   *
   * @param color 脚注定义背景颜色
   */
  setFootnoteDefBackgroundColor(color: number): void {
    this.footnoteDefBackgroundColor = color
  }

  /**
   * 设置4个外边距为统一值
   *
   * @param margin 外边距
   */
  setFootnoteDefAllMargin(margin: number): void {
    this.footnoteDefMarginTop = margin
    this.footnoteDefMarginRight = margin
    this.footnoteDefMarginBottom = margin
    this.footnoteDefMarginLeft = margin
  }

  /**
   * 分别设置4个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setFootnoteDefMargin(top?: number, right?: number, bottom?: number, left?: number): void {
    this.footnoteDefMarginTop = top
    this.footnoteDefMarginRight = right
    this.footnoteDefMarginBottom = bottom
    this.footnoteDefMarginLeft = left
  }

  /**
   * 设置4个内边距为统一值
   *
   * @param padding 内边距
   */
  setFootnoteDefAllPadding(padding: number): void {
    this.footnoteDefPaddingTop = padding
    this.footnoteDefPaddingRight = padding
    this.footnoteDefPaddingBottom = padding
    this.footnoteDefPaddingLeft = padding
  }

  /**
   * 分别设置4个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setFootnoteDefPadding(top?: number, right?: number, bottom?: number, left?: number): void {
    this.footnoteDefPaddingTop = top
    this.footnoteDefPaddingRight = right
    this.footnoteDefPaddingBottom = bottom
    this.footnoteDefPaddingLeft = left
  }

  /**
   * 获取footnoteDefBackgroundColor
   *
   * @returns footnoteDefBackgroundColor
   */
  getFootnoteDefBackgroundColor(): number | undefined {
    return this.footnoteDefBackgroundColor
  }

  /**
   * 获取footnoteDefMarginTop
   *
   * @returns footnoteDefMarginTop
   */
  getFootnoteDefMarginTop(): number | undefined {
    return this.footnoteDefMarginTop
  }

  /**
   * 获取footnoteDefMarginRight
   *
   * @returns footnoteDefMarginRight
   */
  getFootnoteDefMarginRight(): number | undefined {
    return this.footnoteDefMarginRight
  }

  /**
   * 获取footnoteDefMarginBottom
   *
   * @returns footnoteDefMarginBottom
   */
  getFootnoteDefMarginBottom(): number | undefined {
    return this.footnoteDefMarginBottom
  }

  /**
   * 获取footnoteDefMarginLeft
   *
   * @returns footnoteDefMarginLeft
   */
  getFootnoteDefMarginLeft(): number | undefined {
    return this.footnoteDefMarginLeft
  }

  /**
   * 获取footnoteDefPaddingTop
   *
   * @returns footnoteDefPaddingTop
   */
  getFootnoteDefPaddingTop(): number | undefined {
    return this.footnoteDefPaddingTop
  }

  /**
   * 获取footnoteDefPaddingRight
   *
   * @returns footnoteDefPaddingRight
   */
  getFootnoteDefPaddingRight(): number | undefined {
    return this.footnoteDefPaddingRight
  }

  /**
   * 获取footnoteDefPaddingBottom
   *
   * @returns footnoteDefPaddingBottom
   */
  getFootnoteDefPaddingBottom(): number | undefined {
    return this.footnoteDefPaddingBottom
  }

  /**
   * 获取footnoteDefPaddingLeft
   *
   * @returns footnoteDefPaddingLeft
   */
  getFootnoteDefPaddingLeft(): number | undefined {
    return this.footnoteDefPaddingLeft
  }
}
