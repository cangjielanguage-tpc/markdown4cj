import { MarkdownTextDecorationStyle } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-HTML下划线文本样式
 */
export class MarkdownThemeHtmlUnderline {
  /**
   * HTML下划线文本颜色
   */
  htmlUnderlineTextFontColor?: number = undefined

  /**
   * HTML下划线文本尺寸
   */
  htmlUnderlineTextFontSize?: number = undefined

  /**
   * HTML下划线文本字体样式
   */
  htmlUnderlineTextFontStyle?: FontStyle = undefined

  /**
   * HTML下划线文本字体粗细
   */
  htmlUnderlineTextFontWeight?: FontWeight = undefined

  /**
   * HTML下划线文本字体
   */
  htmlUnderlineTextFontFamily?: string = undefined

  /**
   * HTML下划线文本行高
   */
  htmlUnderlineTextLineHeight?: number = undefined

  /**
   * HTML下划线文本字符间距
   */
  htmlUnderlineTextLetterSpacing?: number = undefined

  /**
   * HTML下划线文本装饰线颜色
   */
  htmlUnderlineTextDecorationColor?: number = undefined

  /**
   * HTML下划线文本装饰线样式
   */
  htmlUnderlineTextDecorationStyle?: MarkdownTextDecorationStyle = undefined

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
}
