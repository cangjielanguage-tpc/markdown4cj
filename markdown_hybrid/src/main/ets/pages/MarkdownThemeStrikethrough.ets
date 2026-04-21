import { MarkdownTextDecorationStyle } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-删除线文本样式
 */
export class MarkdownThemeStrikethrough {
  /**
   * 删除线文本颜色
   */
  strikethroughTextFontColor?: number = undefined

  /**
   * 删除线文本尺寸
   */
  strikethroughTextFontSize?: number = undefined

  /**
   * 删除线文本字体样式
   */
  strikethroughTextFontStyle?: FontStyle = undefined

  /**
   * 删除线文本字体粗细
   */
  strikethroughTextFontWeight?: FontWeight = undefined

  /**
   * 删除线文本字体
   */
  strikethroughTextFontFamily?: string = undefined

  /**
   * 删除线文本行高
   */
  strikethroughTextLineHeight?: number = undefined

  /**
   * 删除线文本字符间距
   */
  strikethroughTextLetterSpacing?: number = undefined

  /**
   * 删除线文本装饰线颜色
   */
  strikethroughTextDecorationColor?: number = undefined

  /**
   * 删除线文本装饰线样式
   */
  strikethroughTextDecorationStyle?: MarkdownTextDecorationStyle = undefined

  /**
   * 设置删除线文本颜色
   *
   * @param color 删除线文本颜色
   */
  setStrikethroughTextFontColor(color: number): void {
    this.strikethroughTextFontColor = color
  }

  /**
   * 设置删除线文本尺寸
   *
   * @param size 删除线文本字号
   */
  setStrikethroughTextFontSize(size: number): void {
    this.strikethroughTextFontSize = size
  }

  /**
   * 设置删除线文本字体样式
   *
   * @param style 删除线文本字体样式
   */
  setStrikethroughTextFontStyle(style: FontStyle): void {
    this.strikethroughTextFontStyle = style
  }

  /**
   * 设置删除线文本字体粗细
   *
   * @param weight 删除线文本字体粗细
   */
  setStrikethroughTextFontWeight(weight: FontWeight): void {
    this.strikethroughTextFontWeight = weight
  }

  /**
   * 设置删除线文本字体
   *
   * @param family 删除线文本字体
   */
  setStrikethroughTextFontFamily(family: string): void {
    this.strikethroughTextFontFamily = family
  }

  /**
   * 设置删除线文本行高
   *
   * @param lineHeight 删除线文本行高
   */
  setStrikethroughTextLineHeight(lineHeight: number): void {
    this.strikethroughTextLineHeight = lineHeight
  }

  /**
   * 设置删除线文本字符间距
   *
   * @param spacing 删除线文本字符间距
   */
  setStrikethroughTextLetterSpacing(spacing: number): void {
    this.strikethroughTextLetterSpacing = spacing
  }

  /**
   * 设置删除线文本装饰线颜色
   *
   * @param color 删除线文本装饰线颜色
   */
  setStrikethroughTextDecorationColor(color: number): void {
    this.strikethroughTextDecorationColor = color
  }

  /**
   * 设置删除线文本装饰线样式
   *
   * @param style 删除线文本装饰线样式
   */
  setStrikethroughTextDecorationStyle(style: MarkdownTextDecorationStyle): void {
    this.strikethroughTextDecorationStyle = style
  }
}
