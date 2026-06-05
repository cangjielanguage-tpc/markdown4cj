import { MarkdownTextDecorationStyle } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-HTML下划线文本样式
 */
export class HtmlUnderlineTheme {
  /**
   * HTML下划线文本颜色
   */
  private htmlUnderlineTextFontColor?: number = undefined

  /**
   * HTML下划线文本尺寸
   */
  private htmlUnderlineTextFontSize?: number = undefined

  /**
   * HTML下划线文本字体样式
   */
  private htmlUnderlineTextFontStyle?: FontStyle = undefined

  /**
   * HTML下划线文本字体粗细
   */
  private htmlUnderlineTextFontWeight?: FontWeight = undefined

  /**
   * HTML下划线文本字体
   */
  private htmlUnderlineTextFontFamily?: string = undefined

  /**
   * HTML下划线文本行高
   */
  private htmlUnderlineTextLineHeight?: number = undefined

  /**
   * HTML下划线文本字符间距
   */
  private htmlUnderlineTextLetterSpacing?: number = undefined

  /**
   * HTML下划线文本装饰线颜色
   */
  private htmlUnderlineTextDecorationColor?: number = undefined

  /**
   * HTML下划线文本装饰线样式
   */
  private htmlUnderlineTextDecorationStyle?: MarkdownTextDecorationStyle = undefined

  /**
   * 设置HTML下划线文本颜色
   *
   * @param color HTML下划线文本颜色
   */
  setHtmlUnderlineTextFontColor(color: number): void {
    this.htmlUnderlineTextFontColor = color
  }

  /**
   * 设置HTML下划线文本尺寸
   *
   * @param size HTML下划线文本尺寸
   */
  setHtmlUnderlineTextFontSize(size: number): void {
    this.htmlUnderlineTextFontSize = size
  }

  /**
   * 设置HTML下划线文本字体样式
   *
   * @param style HTML下划线文本字体样式
   */
  setHtmlUnderlineTextFontStyle(style: FontStyle): void {
    this.htmlUnderlineTextFontStyle = style
  }

  /**
   * 设置HTML下划线文本字体粗细
   *
   * @param weight HTML下划线文本字体粗细
   */
  setHtmlUnderlineTextFontWeight(weight: FontWeight): void {
    this.htmlUnderlineTextFontWeight = weight
  }

  /**
   * 设置HTML下划线文本字体
   *
   * @param family HTML下划线文本字体
   */
  setHtmlUnderlineTextFontFamily(family: string): void {
    this.htmlUnderlineTextFontFamily = family
  }

  /**
   * 设置HTML下划线文本行高
   *
   * @param lineHeight HTML下划线文本行高
   */
  setHtmlUnderlineTextLineHeight(lineHeight: number): void {
    this.htmlUnderlineTextLineHeight = lineHeight
  }

  /**
   * 设置HTML下划线文本字符间距
   *
   * @param spacing HTML下划线文本字符间距
   */
  setHtmlUnderlineTextLetterSpacing(spacing: number): void {
    this.htmlUnderlineTextLetterSpacing = spacing
  }

  /**
   * 设置HTML下划线文本装饰线颜色
   *
   * @param color HTML下划线文本装饰线颜色
   */
  setHtmlUnderlineTextDecorationColor(color: number): void {
    this.htmlUnderlineTextDecorationColor = color
  }

  /**
   * 设置HTML下划线文本装饰线样式
   *
   * @param style HTML下划线文本装饰线样式
   */
  setHtmlUnderlineTextDecorationStyle(style: MarkdownTextDecorationStyle): void {
    this.htmlUnderlineTextDecorationStyle = style
  }

  /**
   * 获取htmlUnderlineTextFontColor
   *
   * @returns htmlUnderlineTextFontColor
   */
  getHtmlUnderlineTextFontColor(): number | undefined {
    return this.htmlUnderlineTextFontColor
  }

  /**
   * 获取htmlUnderlineTextFontSize
   *
   * @returns htmlUnderlineTextFontSize
   */
  getHtmlUnderlineTextFontSize(): number | undefined {
    return this.htmlUnderlineTextFontSize
  }

  /**
   * 获取htmlUnderlineTextFontStyle
   *
   * @returns htmlUnderlineTextFontStyle
   */
  getHtmlUnderlineTextFontStyle(): FontStyle | undefined {
    return this.htmlUnderlineTextFontStyle
  }

  /**
   * 获取htmlUnderlineTextFontWeight
   *
   * @returns htmlUnderlineTextFontWeight
   */
  getHtmlUnderlineTextFontWeight(): FontWeight | undefined {
    return this.htmlUnderlineTextFontWeight
  }

  /**
   * 获取htmlUnderlineTextFontFamily
   *
   * @returns htmlUnderlineTextFontFamily
   */
  getHtmlUnderlineTextFontFamily(): string | undefined {
    return this.htmlUnderlineTextFontFamily
  }

  /**
   * 获取htmlUnderlineTextLineHeight
   *
   * @returns htmlUnderlineTextLineHeight
   */
  getHtmlUnderlineTextLineHeight(): number | undefined {
    return this.htmlUnderlineTextLineHeight
  }

  /**
   * 获取htmlUnderlineTextLetterSpacing
   *
   * @returns htmlUnderlineTextLetterSpacing
   */
  getHtmlUnderlineTextLetterSpacing(): number | undefined {
    return this.htmlUnderlineTextLetterSpacing
  }

  /**
   * 获取htmlUnderlineTextDecorationColor
   *
   * @returns htmlUnderlineTextDecorationColor
   */
  getHtmlUnderlineTextDecorationColor(): number | undefined {
    return this.htmlUnderlineTextDecorationColor
  }

  /**
   * 获取htmlUnderlineTextDecorationStyle
   *
   * @returns htmlUnderlineTextDecorationStyle
   */
  getHtmlUnderlineTextDecorationStyle(): MarkdownTextDecorationStyle | undefined {
    return this.htmlUnderlineTextDecorationStyle
  }
}
