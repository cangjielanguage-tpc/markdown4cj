import { MarkdownTextDecorationStyle } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-脚注引用样式
 */
export class MarkdownThemeFootnoteRef {
  /**
   * 脚注引用文本颜色
   */
  private footnoteRefTextFontColor?: number = undefined

  /**
   * 脚注引用文本尺寸
   */
  private footnoteRefTextFontSize?: number = undefined

  /**
   * 脚注引用文本字体样式
   */
  private footnoteRefTextFontStyle?: FontStyle = undefined

  /**
   * 脚注引用文本字体粗细
   */
  private footnoteRefTextFontWeight?: FontWeight = undefined

  /**
   * 脚注引用文本字体
   */
  private footnoteRefTextFontFamily?: string = undefined

  /**
   * 脚注引用文本行高
   */
  private footnoteRefTextLineHeight?: number = undefined

  /**
   * 脚注引用文本字符间距
   */
  private footnoteRefTextLetterSpacing?: number = undefined

  /**
   * 脚注引用文本装饰线类型
   */
  private footnoteRefTextDecorationType?: TextDecorationType = undefined

  /**
   * 脚注引用文本装饰线颜色
   */
  private footnoteRefTextDecorationColor?: number = undefined

  /**
   * 脚注引用文本装饰线样式
   */
  private footnoteRefTextDecorationStyle?: MarkdownTextDecorationStyle = undefined

  /**
   * 脚注引用文本背景颜色
   */
  private footnoteRefTextBackgroundColor?: number = undefined

  /**
   * 脚注引用文本背景左上圆角
   */
  private footnoteRefTextBackgroundRadiusTopLeft?: number = undefined

  /**
   * 脚注引用文本背景右上圆角
   */
  private footnoteRefTextBackgroundRadiusTopRight?: number = undefined

  /**
   * 脚注引用文本背景左下圆角
   */
  private footnoteRefTextBackgroundRadiusBottomLeft?: number = undefined

  /**
   * 脚注引用文本背景右下圆角
   */
  private footnoteRefTextBackgroundRadiusBottomRight?: number = undefined

  /**
   * 设置脚注引用文本颜色
   *
   * @param color 脚注引用文本颜色
   */
  setFootnoteRefTextFontColor(color: number): void {
    this.footnoteRefTextFontColor = color
  }

  /**
   * 设置脚注引用文本尺寸
   *
   * @param size 脚注引用文本尺寸
   */
  setFootnoteRefTextFontSize(size: number): void {
    this.footnoteRefTextFontSize = size
  }

  /**
   * 设置脚注引用文本字体样式
   *
   * @param style 脚注引用文本字体样式
   */
  setFootnoteRefTextFontStyle(style: FontStyle): void {
    this.footnoteRefTextFontStyle = style
  }

  /**
   * 设置脚注引用文本字体粗细
   *
   * @param weight 脚注引用文本字体粗细
   */
  setFootnoteRefTextFontWeight(weight: FontWeight): void {
    this.footnoteRefTextFontWeight = weight
  }

  /**
   * 设置脚注引用文本字体
   *
   * @param family 脚注引用文本字体
   */
  setFootnoteRefTextFontFamily(family: string): void {
    this.footnoteRefTextFontFamily = family
  }

  /**
   * 设置脚注引用文本行高
   *
   * @param lineHeight 脚注引用文本行高
   */
  setFootnoteRefTextLineHeight(lineHeight: number): void {
    this.footnoteRefTextLineHeight = lineHeight
  }

  /**
   * 设置脚注引用文本字符间距
   *
   * @param spacing 脚注引用文本字符间距
   */
  setFootnoteRefTextLetterSpacing(spacing: number): void {
    this.footnoteRefTextLetterSpacing = spacing
  }

  /**
   * 设置脚注引用文本装饰线类型
   *
   * @param decorationType 脚注引用文本装饰线类型
   */
  setFootnoteRefTextDecorationType(decorationType: TextDecorationType): void {
    this.footnoteRefTextDecorationType = decorationType
  }

  /**
   * 设置脚注引用文本装饰线颜色
   *
   * @param color 脚注引用文本装饰线颜色
   */
  setFootnoteRefTextDecorationColor(color: number): void {
    this.footnoteRefTextDecorationColor = color
  }

  /**
   * 设置脚注引用文本装饰线样式
   *
   * @param style 脚注引用文本装饰线样式
   */
  setFootnoteRefTextDecorationStyle(style: MarkdownTextDecorationStyle): void {
    this.footnoteRefTextDecorationStyle = style
  }

  /**
   * 设置脚注引用文本背景颜色
   *
   * @param color 脚注引用文本背景颜色
   */
  setFootnoteRefTextBackgroundColor(color: number): void {
    this.footnoteRefTextBackgroundColor = color
  }

  /**
   * 统一设置脚注引用文本背景四个圆角
   *
   * @param radius 统一圆角半径，同时赋值给四个角
   */
  setFootnoteRefTextBackgroundAllRadius(radius: number): void {
    this.footnoteRefTextBackgroundRadiusTopLeft = radius
    this.footnoteRefTextBackgroundRadiusTopRight = radius
    this.footnoteRefTextBackgroundRadiusBottomLeft = radius
    this.footnoteRefTextBackgroundRadiusBottomRight = radius
  }

  /**
   * 分别设置4个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setFootnoteRefTextBackgroundRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void {
    this.footnoteRefTextBackgroundRadiusTopLeft = topLeft
    this.footnoteRefTextBackgroundRadiusTopRight = topRight
    this.footnoteRefTextBackgroundRadiusBottomLeft = bottomLeft
    this.footnoteRefTextBackgroundRadiusBottomRight = bottomRight
  }

  /**
   * 获取footnoteRefTextFontColor
   *
   * @returns footnoteRefTextFontColor
   */
  getFootnoteRefTextFontColor(): number | undefined {
    return this.footnoteRefTextFontColor
  }

  /**
   * 获取footnoteRefTextFontSize
   *
   * @returns footnoteRefTextFontSize
   */
  getFootnoteRefTextFontSize(): number | undefined {
    return this.footnoteRefTextFontSize
  }

  /**
   * 获取footnoteRefTextFontStyle
   *
   * @returns footnoteRefTextFontStyle
   */
  getFootnoteRefTextFontStyle(): FontStyle | undefined {
    return this.footnoteRefTextFontStyle
  }

  /**
   * 获取footnoteRefTextFontWeight
   *
   * @returns footnoteRefTextFontWeight
   */
  getFootnoteRefTextFontWeight(): FontWeight | undefined {
    return this.footnoteRefTextFontWeight
  }

  /**
   * 获取footnoteRefTextFontFamily
   *
   * @returns footnoteRefTextFontFamily
   */
  getFootnoteRefTextFontFamily(): string | undefined {
    return this.footnoteRefTextFontFamily
  }

  /**
   * 获取footnoteRefTextLineHeight
   *
   * @returns footnoteRefTextLineHeight
   */
  getFootnoteRefTextLineHeight(): number | undefined {
    return this.footnoteRefTextLineHeight
  }

  /**
   * 获取footnoteRefTextLetterSpacing
   *
   * @returns footnoteRefTextLetterSpacing
   */
  getFootnoteRefTextLetterSpacing(): number | undefined {
    return this.footnoteRefTextLetterSpacing
  }

  /**
   * 获取footnoteRefTextDecorationType
   *
   * @returns footnoteRefTextDecorationType
   */
  getFootnoteRefTextDecorationType(): TextDecorationType | undefined {
    return this.footnoteRefTextDecorationType
  }

  /**
   * 获取footnoteRefTextDecorationColor
   *
   * @returns footnoteRefTextDecorationColor
   */
  getFootnoteRefTextDecorationColor(): number | undefined {
    return this.footnoteRefTextDecorationColor
  }

  /**
   * 获取footnoteRefTextDecorationStyle
   *
   * @returns footnoteRefTextDecorationStyle
   */
  getFootnoteRefTextDecorationStyle(): MarkdownTextDecorationStyle | undefined {
    return this.footnoteRefTextDecorationStyle
  }

  /**
   * 获取footnoteRefTextBackgroundColor
   *
   * @returns footnoteRefTextBackgroundColor
   */
  getFootnoteRefTextBackgroundColor(): number | undefined {
    return this.footnoteRefTextBackgroundColor
  }

  /**
   * 获取footnoteRefTextBackgroundRadiusTopLeft
   *
   * @returns footnoteRefTextBackgroundRadiusTopLeft
   */
  getFootnoteRefTextBackgroundRadiusTopLeft(): number | undefined {
    return this.footnoteRefTextBackgroundRadiusTopLeft
  }

  /**
   * 获取footnoteRefTextBackgroundRadiusTopRight
   *
   * @returns footnoteRefTextBackgroundRadiusTopRight
   */
  getFootnoteRefTextBackgroundRadiusTopRight(): number | undefined {
    return this.footnoteRefTextBackgroundRadiusTopRight
  }

  /**
   * 获取footnoteRefTextBackgroundRadiusBottomLeft
   *
   * @returns footnoteRefTextBackgroundRadiusBottomLeft
   */
  getFootnoteRefTextBackgroundRadiusBottomLeft(): number | undefined {
    return this.footnoteRefTextBackgroundRadiusBottomLeft
  }

  /**
   * 获取footnoteRefTextBackgroundRadiusBottomRight
   *
   * @returns footnoteRefTextBackgroundRadiusBottomRight
   */
  getFootnoteRefTextBackgroundRadiusBottomRight(): number | undefined {
    return this.footnoteRefTextBackgroundRadiusBottomRight
  }
}
