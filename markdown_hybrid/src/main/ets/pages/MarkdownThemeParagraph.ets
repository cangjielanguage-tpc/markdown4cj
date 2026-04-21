/**
 * Markdown用户可设置的样式-段落样式
 */
export class MarkdownThemeParagraph {
  /**
   * 段落背景颜色
   */
  paragraphBackgroundColor?: number = undefined

  /**
   * 段落上外边距
   */
  paragraphMarginTop?: number = undefined

  /**
   * 段落右外边距
   */
  paragraphMarginRight?: number = undefined

  /**
   * 段落下外边距
   */
  paragraphMarginBottom?: number = undefined

  /**
   * 段落左外边距
   */
  paragraphMarginLeft?: number = undefined

  /**
   * 段落上内边距
   */
  paragraphPaddingTop?: number = undefined

  /**
   * 段落右内边距
   */
  paragraphPaddingRight?: number = undefined

  /**
   * 段落下内边距
   */
  paragraphPaddingBottom?: number = undefined

  /**
   * 段落左内边距
   */
  paragraphPaddingLeft?: number = undefined

  /**
   * 段落文本颜色
   */
  paragraphTextFontColor?: number = undefined

  /**
   * 段落文本尺寸
   */
  paragraphTextFontSize?: number = undefined

  /**
   * 段落文本字体样式
   */
  paragraphTextFontStyle?: FontStyle = undefined

  /**
   * 段落文本字体粗细
   */
  paragraphTextFontWeight?: FontWeight = undefined

  /**
   * 段落文本字体
   */
  paragraphTextFontFamily?: string = undefined

  /**
   * 段落文本行高
   */
  paragraphTextLineHeight?: number = undefined

  /**
   * 段落文本字符间距
   */
  paragraphTextLetterSpacing?: number = undefined

  /**
   * 设置段落背景颜色
   *
   * @param color 段落背景颜色
   */
  setParagraphBackgroundColor(color: number): void {
    this.paragraphBackgroundColor = color
  }

  /**
   * 设置4个外边距为统一值
   *
   * @param margin 外边距
   */
  setParagraphAllMargin(margin: number): void {
    this.paragraphMarginTop = margin
    this.paragraphMarginRight = margin
    this.paragraphMarginBottom = margin
    this.paragraphMarginLeft = margin
  }

  /**
   * 分别设置4个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setParagraphMargin(top?: number, right?: number, bottom?: number, left?: number): void {
    this.paragraphMarginTop = top
    this.paragraphMarginRight = right
    this.paragraphMarginBottom = bottom
    this.paragraphMarginLeft = left
  }

  /**
   * 设置4个内边距为统一值
   *
   * @param padding 内边距
   */
  setParagraphAllPadding(padding: number): void {
    this.paragraphPaddingTop = padding
    this.paragraphPaddingRight = padding
    this.paragraphPaddingBottom = padding
    this.paragraphPaddingLeft = padding
  }

  /**
   * 分别设置4个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setParagraphPadding(top?: number, right?: number, bottom?: number, left?: number): void {
    this.paragraphPaddingTop = top
    this.paragraphPaddingRight = right
    this.paragraphPaddingBottom = bottom
    this.paragraphPaddingLeft = left
  }

  /**
   * 设置段落文本颜色
   *
   * @param color 段落文本颜色
   */
  setParagraphTextFontColor(color: number): void {
    this.paragraphTextFontColor = color
  }

  /**
   * 设置段落文本尺寸
   *
   * @param size 段落文本尺寸
   */
  setParagraphTextFontSize(size: number): void {
    this.paragraphTextFontSize = size
  }

  /**
   * 设置段落文本字体样式
   *
   * @param style 段落文本字体样式
   */
  setParagraphTextFontStyle(style: FontStyle): void {
    this.paragraphTextFontStyle = style
  }

  /**
   * 设置段落文本字体粗细
   *
   * @param weight 段落文本字体粗细
   */
  setParagraphTextFontWeight(weight: FontWeight): void {
    this.paragraphTextFontWeight = weight
  }

  /**
   * 设置段落文本字体
   *
   * @param family 段落文本字体
   */
  setParagraphTextFontFamily(family: string): void {
    this.paragraphTextFontFamily = family
  }

  /**
   * 设置段落文本行高
   *
   * @param lineHeight 段落文本行高
   */
  setParagraphTextLineHeight(lineHeight: number): void {
    this.paragraphTextLineHeight = lineHeight
  }

  /**
   * 设置段落文本字符间距
   *
   * @param spacing 段落文本字符间距
   */
  setParagraphTextLetterSpacing(spacing: number): void {
    this.paragraphTextLetterSpacing = spacing
  }
}
