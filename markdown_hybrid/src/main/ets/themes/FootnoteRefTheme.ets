import { MarkdownRadiusOptions } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-脚注引用样式
 */
export class FootnoteRefTheme {
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
  private footnoteRefTextDecorationStyle?: TextDecorationStyle = undefined

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
  setFootnoteRefTextFontColor(color: number): FootnoteRefTheme {
    this.footnoteRefTextFontColor = color
    return this
  }

  /**
   * 设置脚注引用文本尺寸
   *
   * @param size 脚注引用文本尺寸
   */
  setFootnoteRefTextFontSize(size: number): FootnoteRefTheme {
    this.footnoteRefTextFontSize = size
    return this
  }

  /**
   * 设置脚注引用文本字体样式
   *
   * @param style 脚注引用文本字体样式
   */
  setFootnoteRefTextFontStyle(style: FontStyle): FootnoteRefTheme {
    this.footnoteRefTextFontStyle = style
    return this
  }

  /**
   * 设置脚注引用文本字体粗细
   *
   * @param weight 脚注引用文本字体粗细
   */
  setFootnoteRefTextFontWeight(weight: FontWeight): FootnoteRefTheme {
    this.footnoteRefTextFontWeight = weight
    return this
  }

  /**
   * 设置脚注引用文本字体
   *
   * @param family 脚注引用文本字体
   */
  setFootnoteRefTextFontFamily(family: string): FootnoteRefTheme {
    this.footnoteRefTextFontFamily = family
    return this
  }

  /**
   * 设置脚注引用文本行高
   *
   * @param lineHeight 脚注引用文本行高
   */
  setFootnoteRefTextLineHeight(lineHeight: number): FootnoteRefTheme {
    this.footnoteRefTextLineHeight = lineHeight
    return this
  }

  /**
   * 设置脚注引用文本字符间距
   *
   * @param spacing 脚注引用文本字符间距
   */
  setFootnoteRefTextLetterSpacing(spacing: number): FootnoteRefTheme {
    this.footnoteRefTextLetterSpacing = spacing
    return this
  }

  /**
   * 设置脚注引用文本装饰线类型
   *
   * @param decorationType 脚注引用文本装饰线类型
   */
  setFootnoteRefTextDecorationType(decorationType: TextDecorationType): FootnoteRefTheme {
    this.footnoteRefTextDecorationType = decorationType
    return this
  }

  /**
   * 设置脚注引用文本装饰线颜色
   *
   * @param color 脚注引用文本装饰线颜色
   */
  setFootnoteRefTextDecorationColor(color: number): FootnoteRefTheme {
    this.footnoteRefTextDecorationColor = color
    return this
  }

  /**
   * 设置脚注引用文本装饰线样式
   *
   * @param style 脚注引用文本装饰线样式
   */
  setFootnoteRefTextDecorationStyle(style: TextDecorationStyle): FootnoteRefTheme {
    this.footnoteRefTextDecorationStyle = style
    return this
  }

  /**
   * 设置脚注引用文本背景颜色
   *
   * @param color 脚注引用文本背景颜色
   */
  setFootnoteRefTextBackgroundColor(color: number): FootnoteRefTheme {
    this.footnoteRefTextBackgroundColor = color
    return this
  }

  /**
   * 设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setFootnoteRefTextBackgroundRadius(options: MarkdownRadiusOptions | number): FootnoteRefTheme {
    if (typeof options === "number") {
      this.footnoteRefTextBackgroundRadiusTopLeft = options
      this.footnoteRefTextBackgroundRadiusTopRight = options
      this.footnoteRefTextBackgroundRadiusBottomLeft = options
      this.footnoteRefTextBackgroundRadiusBottomRight = options
    } else {
      if (options.topLeft !== undefined) {
        this.footnoteRefTextBackgroundRadiusTopLeft = options.topLeft
      }
      if (options.topRight !== undefined) {
        this.footnoteRefTextBackgroundRadiusTopRight = options.topRight
      }
      if (options.bottomLeft !== undefined) {
        this.footnoteRefTextBackgroundRadiusBottomLeft = options.bottomLeft
      }
      if (options.bottomRight !== undefined) {
        this.footnoteRefTextBackgroundRadiusBottomRight = options.bottomRight
      }
    }
    return this
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
  getFootnoteRefTextDecorationStyle(): TextDecorationStyle | undefined {
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
