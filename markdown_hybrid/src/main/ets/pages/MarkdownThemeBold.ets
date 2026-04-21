/**
 * Markdown用户可设置的样式-加粗文本样式
 */
export class MarkdownThemeBold {
  /**
   * 加粗文本颜色
   */
  boldTextFontColor?: number = undefined

  /**
   * 加粗文本尺寸
   */
  boldTextFontSize?: number = undefined

  /**
   * 加粗文本字体样式
   */
  boldTextFontStyle?: FontStyle = undefined

  /**
   * 加粗文本字体粗细
   */
  boldTextFontWeight?: FontWeight = undefined

  /**
   * 加粗文本字体
   */
  boldTextFontFamily?: string = undefined

  /**
   * 加粗文本行高
   */
  boldTextLineHeight?: number = undefined

  /**
   * 加粗文本字符间距
   */
  boldTextLetterSpacing?: number = undefined

  /**
   * 设置加粗文本颜色
   *
   * @param color 加粗文本颜色
   */
  setBoldTextFontColor(color: number): void {
    this.boldTextFontColor = color
  }

  /**
   * 设置加粗文本尺寸
   *
   * @param size 加粗文本尺寸
   */
  setBoldTextFontSize(size: number): void {
    this.boldTextFontSize = size
  }

  /**
   * 设置加粗文本字体样式
   *
   * @param style 加粗文本字体样式
   */
  setBoldTextFontStyle(style: FontStyle): void {
    this.boldTextFontStyle = style
  }

  /**
   * 设置加粗文本字体粗细
   *
   * @param weight 加粗文本字体粗细
   */
  setBoldTextFontWeight(weight: FontWeight): void {
    this.boldTextFontWeight = weight
  }

  /**
   * 设置加粗文本字体
   *
   * @param family 加粗文本字体
   */
  setBoldTextFontFamily(family: string): void {
    this.boldTextFontFamily = family
  }

  /**
   * 设置加粗文本行高
   *
   * @param lineHeight 加粗文本行高
   */
  setBoldTextLineHeight(lineHeight: number): void {
    this.boldTextLineHeight = lineHeight
  }

  /**
   * 设置加粗文本字符间距
   *
   * @param spacing 加粗文本字符间距
   */
  setBoldTextLetterSpacing(spacing: number): void {
    this.boldTextLetterSpacing = spacing
  }
}
