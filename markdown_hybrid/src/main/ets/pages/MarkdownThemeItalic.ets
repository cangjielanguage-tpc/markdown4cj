/**
 * Markdown用户可设置的样式-斜体文本样式
 */
export class MarkdownThemeItalic {
  /**
   * 斜体文本颜色
   */
  italicTextFontColor?: number = undefined

  /**
   * 斜体文本尺寸
   */
  italicTextFontSize?: number = undefined

  /**
   * 斜体文本字体粗细
   */
  italicTextFontWeight?: FontWeight = undefined

  /**
   * 斜体文本字体
   */
  italicTextFontFamily?: string = undefined

  /**
   * 斜体文本行高
   */
  italicTextLineHeight?: number = undefined

  /**
   * 斜体文本字符间距
   */
  italicTextLetterSpacing?: number = undefined

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
}
