/**
 * Markdown用户可设置的样式-斜体文本样式
 */
export class MarkdownThemeItalic {
  /**
   * 斜体文本颜色
   */
  private italicTextFontColor?: number = undefined

  /**
   * 斜体文本尺寸
   */
  private italicTextFontSize?: number = undefined

  /**
   * 斜体文本字体粗细
   */
  private italicTextFontWeight?: FontWeight = undefined

  /**
   * 斜体文本字体
   */
  private italicTextFontFamily?: string = undefined

  /**
   * 斜体文本行高
   */
  private italicTextLineHeight?: number = undefined

  /**
   * 斜体文本字符间距
   */
  private italicTextLetterSpacing?: number = undefined

  /**
   * 设置斜体文本颜色
   *
   * @param color 斜体文本颜色
   */
  setItalicTextFontColor(color: number): void {
    this.italicTextFontColor = color
  }

  /**
   * 设置斜体文本尺寸
   *
   * @param size 斜体文本尺寸
   */
  setItalicTextFontSize(size: number): void {
    this.italicTextFontSize = size
  }

  /**
   * 设置斜体文本字体粗细
   *
   * @param weight 斜体文本字体粗细
   */
  setItalicTextFontWeight(weight: FontWeight): void {
    this.italicTextFontWeight = weight
  }

  /**
   * 设置斜体文本字体
   *
   * @param family 斜体文本字体
   */
  setItalicTextFontFamily(family: string): void {
    this.italicTextFontFamily = family
  }

  /**
   * 设置斜体文本行高
   *
   * @param lineHeight 斜体文本行高
   */
  setItalicTextLineHeight(lineHeight: number): void {
    this.italicTextLineHeight = lineHeight
  }

  /**
   * 设置斜体文本字符间距
   *
   * @param spacing 斜体文本字符间距
   */
  setItalicTextLetterSpacing(spacing: number): void {
    this.italicTextLetterSpacing = spacing
  }

  /**
   * 获取italicTextFontColor
   *
   * @returns italicTextFontColor
   */
  getItalicTextFontColor(): number | undefined {
    return this.italicTextFontColor
  }

  /**
   * 获取italicTextFontSize
   *
   * @returns italicTextFontSize
   */
  getItalicTextFontSize(): number | undefined {
    return this.italicTextFontSize
  }

  /**
   * 获取italicTextFontWeight
   *
   * @returns italicTextFontWeight
   */
  getItalicTextFontWeight(): FontWeight | undefined {
    return this.italicTextFontWeight
  }

  /**
   * 获取italicTextFontFamily
   *
   * @returns italicTextFontFamily
   */
  getItalicTextFontFamily(): string | undefined {
    return this.italicTextFontFamily
  }

  /**
   * 获取italicTextLineHeight
   *
   * @returns italicTextLineHeight
   */
  getItalicTextLineHeight(): number | undefined {
    return this.italicTextLineHeight
  }

  /**
   * 获取italicTextLetterSpacing
   *
   * @returns italicTextLetterSpacing
   */
  getItalicTextLetterSpacing(): number | undefined {
    return this.italicTextLetterSpacing
  }
}
