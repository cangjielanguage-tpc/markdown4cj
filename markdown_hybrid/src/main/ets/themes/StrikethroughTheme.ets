import { MarkdownTextDecorationStyle } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-删除线文本样式
 */
export class StrikethroughTheme {
  /**
   * 删除线文本颜色
   */
  private strikethroughTextFontColor?: number = undefined

  /**
   * 删除线文本尺寸
   */
  private strikethroughTextFontSize?: number = undefined

  /**
   * 删除线文本字体样式
   */
  private strikethroughTextFontStyle?: FontStyle = undefined

  /**
   * 删除线文本字体粗细
   */
  private strikethroughTextFontWeight?: FontWeight = undefined

  /**
   * 删除线文本字体
   */
  private strikethroughTextFontFamily?: string = undefined

  /**
   * 删除线文本行高
   */
  private strikethroughTextLineHeight?: number = undefined

  /**
   * 删除线文本字符间距
   */
  private strikethroughTextLetterSpacing?: number = undefined

  /**
   * 删除线文本装饰线颜色
   */
  private strikethroughTextDecorationColor?: number = undefined

  /**
   * 删除线文本装饰线样式
   */
  private strikethroughTextDecorationStyle?: TextDecorationStyle = undefined

  /**
   * 设置删除线文本颜色
   *
   * @param color 删除线文本颜色
   */
  setStrikethroughTextFontColor(color: number): StrikethroughTheme {
    this.strikethroughTextFontColor = color
    return this
  }

  /**
   * 设置删除线文本尺寸
   *
   * @param size 删除线文本字号
   */
  setStrikethroughTextFontSize(size: number): StrikethroughTheme {
    this.strikethroughTextFontSize = size
    return this
  }

  /**
   * 设置删除线文本字体样式
   *
   * @param style 删除线文本字体样式
   */
  setStrikethroughTextFontStyle(style: FontStyle): StrikethroughTheme {
    this.strikethroughTextFontStyle = style
    return this
  }

  /**
   * 设置删除线文本字体粗细
   *
   * @param weight 删除线文本字体粗细
   */
  setStrikethroughTextFontWeight(weight: FontWeight): StrikethroughTheme {
    this.strikethroughTextFontWeight = weight
    return this
  }

  /**
   * 设置删除线文本字体
   *
   * @param family 删除线文本字体
   */
  setStrikethroughTextFontFamily(family: string): StrikethroughTheme {
    this.strikethroughTextFontFamily = family
    return this
  }

  /**
   * 设置删除线文本行高
   *
   * @param lineHeight 删除线文本行高
   */
  setStrikethroughTextLineHeight(lineHeight: number): StrikethroughTheme {
    this.strikethroughTextLineHeight = lineHeight
    return this
  }

  /**
   * 设置删除线文本字符间距
   *
   * @param spacing 删除线文本字符间距
   */
  setStrikethroughTextLetterSpacing(spacing: number): StrikethroughTheme {
    this.strikethroughTextLetterSpacing = spacing
    return this
  }

  /**
   * 设置删除线文本装饰线颜色
   *
   * @param color 删除线文本装饰线颜色
   */
  setStrikethroughTextDecorationColor(color: number): StrikethroughTheme {
    this.strikethroughTextDecorationColor = color
    return this
  }

  /**
   * 设置删除线文本装饰线样式
   *
   * @param style 删除线文本装饰线样式
   */
  setStrikethroughTextDecorationStyle(style: TextDecorationStyle): StrikethroughTheme {
    this.strikethroughTextDecorationStyle = style
    return this
  }

  /**
   * 获取strikethroughTextFontColor
   *
   * @returns strikethroughTextFontColor
   */
  getStrikethroughTextFontColor(): number | undefined {
    return this.strikethroughTextFontColor
  }

  /**
   * 获取strikethroughTextFontSize
   *
   * @returns strikethroughTextFontSize
   */
  getStrikethroughTextFontSize(): number | undefined {
    return this.strikethroughTextFontSize
  }

  /**
   * 获取strikethroughTextFontStyle
   *
   * @returns strikethroughTextFontStyle
   */
  getStrikethroughTextFontStyle(): FontStyle | undefined {
    return this.strikethroughTextFontStyle
  }

  /**
   * 获取strikethroughTextFontWeight
   *
   * @returns strikethroughTextFontWeight
   */
  getStrikethroughTextFontWeight(): FontWeight | undefined {
    return this.strikethroughTextFontWeight
  }

  /**
   * 获取strikethroughTextFontFamily
   *
   * @returns strikethroughTextFontFamily
   */
  getStrikethroughTextFontFamily(): string | undefined {
    return this.strikethroughTextFontFamily
  }

  /**
   * 获取strikethroughTextLineHeight
   *
   * @returns strikethroughTextLineHeight
   */
  getStrikethroughTextLineHeight(): number | undefined {
    return this.strikethroughTextLineHeight
  }

  /**
   * 获取strikethroughTextLetterSpacing
   *
   * @returns strikethroughTextLetterSpacing
   */
  getStrikethroughTextLetterSpacing(): number | undefined {
    return this.strikethroughTextLetterSpacing
  }

  /**
   * 获取strikethroughTextDecorationColor
   *
   * @returns strikethroughTextDecorationColor
   */
  getStrikethroughTextDecorationColor(): number | undefined {
    return this.strikethroughTextDecorationColor
  }

  /**
   * 获取strikethroughTextDecorationStyle
   *
   * @returns strikethroughTextDecorationStyle
   */
  getStrikethroughTextDecorationStyle(): TextDecorationStyle | undefined {
    return this.strikethroughTextDecorationStyle
  }
}
