/**
 * Markdown用户可设置的样式-上标文本样式
 */
export class MarkdownThemeSup {
  /**
   * 上标文本颜色
   */
  supTextFontColor?: number = undefined

  /**
   * 上标文本尺寸
   */
  supTextFontSize?: number = undefined

  /**
   * 上标文本字体样式
   */
  supTextFontStyle?: FontStyle = undefined

  /**
   * 上标文本字体粗细
   */
  supTextFontWeight?: FontWeight = undefined

  /**
   * 上标文本字体
   */
  supTextFontFamily?: string = undefined

  /**
   * 上标文本字符间距
   */
  supTextLetterSpacing?: number = undefined

  /**
   * 上标文本基线的偏移量
   */
  supTextBaselineOffset?: number = undefined

  /**
   * 设置上标文本颜色
   *
   * @param color 上标文本颜色
   */
  setSupTextFontColor(color: number): void {
    this.supTextFontColor = color
  }

  /**
   * 设置上标文本尺寸
   *
   * @param size 上标文本尺寸
   */
  setSupTextFontSize(size: number): void {
    this.supTextFontSize = size
  }

  /**
   * 设置上标文本字体样式
   *
   * @param style 上标文本字体样式
   */
  setSupTextFontStyle(style: FontStyle): void {
    this.supTextFontStyle = style
  }

  /**
   * 设置上标文本字体粗细
   *
   * @param weight 上标文本字体粗细
   */
  setSupTextFontWeight(weight: FontWeight): void {
    this.supTextFontWeight = weight
  }

  /**
   * 设置上标文本字体
   *
   * @param family 上标文本字体
   */
  setSupTextFontFamily(family: string): void {
    this.supTextFontFamily = family
  }

  /**
   * 设置上标文本字符间距
   *
   * @param spacing 上标文本字符间距
   */
  setSupTextLetterSpacing(spacing: number): void {
    this.supTextLetterSpacing = spacing
  }

  /**
   * 设置上标文本基线的偏移量
   *
   * @param offset 上标文本基线的偏移量
   */
  setSupTextBaselineOffset(offset: number): void {
    this.supTextBaselineOffset = offset
  }
}
