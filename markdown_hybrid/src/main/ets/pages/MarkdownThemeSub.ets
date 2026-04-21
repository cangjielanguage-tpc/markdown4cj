/**
 * Markdown用户可设置的样式-下标文本样式
 */
export class MarkdownThemeSub {
  /**
   * 下标文本颜色
   */
  subTextFontColor?: number = undefined

  /**
   * 下标文本尺寸
   */
  subTextFontSize?: number = undefined

  /**
   * 下标文本字体样式
   */
  subTextFontStyle?: FontStyle = undefined

  /**
   * 下标文本字体粗细
   */
  subTextFontWeight?: FontWeight = undefined

  /**
   * 下标文本字体
   */
  subTextFontFamily?: string = undefined

  /**
   * 下标文本字符间距
   */
  subTextLetterSpacing?: number = undefined

  /**
   * 下标文本基线的偏移量
   */
  subTextBaselineOffset?: number = undefined

  /**
   * 设置下标文本颜色
   *
   * @param color 下标文本颜色
   */
  setSubTextFontColor(color: number): void {
    this.subTextFontColor = color
  }

  /**
   * 设置下标文本尺寸
   *
   * @param size 下标文本尺寸
   */
  setSubTextFontSize(size: number): void {
    this.subTextFontSize = size
  }

  /**
   * 设置下标文本字体样式
   *
   * @param style 下标文本字体样式
   */
  setSubTextFontStyle(style: FontStyle): void {
    this.subTextFontStyle = style
  }

  /**
   * 设置下标文本字体粗细
   *
   * @param weight 下标文本字体粗细
   */
  setSubTextFontWeight(weight: FontWeight): void {
    this.subTextFontWeight = weight
  }

  /**
   * 设置下标文本字体
   *
   * @param family 下标文本字体
   */
  setSubTextFontFamily(family: string): void {
    this.subTextFontFamily = family
  }

  /**
   * 设置下标文本字符间距
   *
   * @param spacing 下标文本字符间距
   */
  setSubTextLetterSpacing(spacing: number): void {
    this.subTextLetterSpacing = spacing
  }

  /**
   * 设置下标文本基线的偏移量
   *
   * @param offset 下标文本基线的偏移量
   */
  setSubTextBaselineOffset(offset: number): void {
    this.subTextBaselineOffset = offset
  }
}
