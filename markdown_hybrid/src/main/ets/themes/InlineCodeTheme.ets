import { MarkdownRadiusOptions } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-内联代码样式
 */
export class InlineCodeTheme {
  /**
   * 内联代码文本颜色
   */
  private inlineCodeTextFontColor?: number = undefined

  /**
   * 内联代码文本尺寸
   */
  private inlineCodeTextFontSize?: number = undefined

  /**
   * 内联代码文本字体样式
   */
  private inlineCodeTextFontStyle?: FontStyle = undefined

  /**
   * 内联代码文本字体粗细
   */
  private inlineCodeTextFontWeight?: FontWeight = undefined

  /**
   * 内联代码文本字体
   */
  private inlineCodeTextFontFamily?: string = undefined

  /**
   * 内联代码文本行高
   */
  private inlineCodeTextLineHeight?: number = undefined

  /**
   * 内联代码文本字符间距
   */
  private inlineCodeTextLetterSpacing?: number = undefined

  /**
   * 内联代码文本背景颜色
   */
  private inlineCodeTextBackgroundColor?: number = undefined

  /**
   * 内联代码文本背景左上圆角
   */
  private inlineCodeTextBackgroundRadiusTopLeft?: number = undefined

  /**
   * 内联代码文本背景右上圆角
   */
  private inlineCodeTextBackgroundRadiusTopRight?: number = undefined

  /**
   * 内联代码文本背景左下圆角
   */
  private inlineCodeTextBackgroundRadiusBottomLeft?: number = undefined

  /**
   * 内联代码文本背景右下圆角
   */
  private inlineCodeTextBackgroundRadiusBottomRight?: number = undefined

  /**
   * 设置内联代码文本颜色
   *
   * @param color 内联代码文本颜色
   */
  setInlineCodeTextFontColor(color: number): InlineCodeTheme {
    this.inlineCodeTextFontColor = color
    return this
  }

  /**
   * 设置内联代码文本尺寸
   *
   * @param size 内联代码文本尺寸
   */
  setInlineCodeTextFontSize(size: number): InlineCodeTheme {
    this.inlineCodeTextFontSize = size
    return this
  }

  /**
   * 设置内联代码文本字体样式
   *
   * @param style 内联代码文本字体样式
   */
  setInlineCodeTextFontStyle(style: FontStyle): InlineCodeTheme {
    this.inlineCodeTextFontStyle = style
    return this
  }

  /**
   * 设置内联代码文本字体粗细
   *
   * @param weight 内联代码文本字体粗细
   */
  setInlineCodeTextFontWeight(weight: FontWeight): InlineCodeTheme {
    this.inlineCodeTextFontWeight = weight
    return this
  }

  /**
   * 设置内联代码文本字体
   *
   * @param family 内联代码文本字体
   */
  setInlineCodeTextFontFamily(family: string): InlineCodeTheme {
    this.inlineCodeTextFontFamily = family
    return this
  }

  /**
   * 设置内联代码文本行高
   *
   * @param lineHeight 内联代码文本行高
   */
  setInlineCodeTextLineHeight(lineHeight: number): InlineCodeTheme {
    this.inlineCodeTextLineHeight = lineHeight
    return this
  }

  /**
   * 设置内联代码文本字符间距
   *
   * @param spacing 内联代码文本字符间距
   */
  setInlineCodeTextLetterSpacing(spacing: number): InlineCodeTheme {
    this.inlineCodeTextLetterSpacing = spacing
    return this
  }

  /**
   * 设置内联代码文本背景颜色
   *
   * @param color 内联代码文本背景颜色
   */
  setInlineCodeTextBackgroundColor(color: number): InlineCodeTheme {
    this.inlineCodeTextBackgroundColor = color
    return this
  }

  /**
   * 设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setInlineCodeTextBackgroundRadius(options: MarkdownRadiusOptions | number): InlineCodeTheme {
    if (typeof options === "number") {
      this.inlineCodeTextBackgroundRadiusTopLeft = options
      this.inlineCodeTextBackgroundRadiusTopRight = options
      this.inlineCodeTextBackgroundRadiusBottomLeft = options
      this.inlineCodeTextBackgroundRadiusBottomRight = options
    } else {
      if (options.topLeft !== undefined) {
        this.inlineCodeTextBackgroundRadiusTopLeft = options.topLeft
      }
      if (options.topRight !== undefined) {
        this.inlineCodeTextBackgroundRadiusTopRight = options.topRight
      }
      if (options.bottomLeft !== undefined) {
        this.inlineCodeTextBackgroundRadiusBottomLeft = options.bottomLeft
      }
      if (options.bottomRight !== undefined) {
        this.inlineCodeTextBackgroundRadiusBottomRight = options.bottomRight
      }
    }
    return this
  }

  /**
   * 获取inlineCodeTextFontColor
   *
   * @returns inlineCodeTextFontColor
   */
  getInlineCodeTextFontColor(): number | undefined {
    return this.inlineCodeTextFontColor
  }

  /**
   * 获取inlineCodeTextFontSize
   *
   * @returns inlineCodeTextFontSize
   */
  getInlineCodeTextFontSize(): number | undefined {
    return this.inlineCodeTextFontSize
  }

  /**
   * 获取inlineCodeTextFontStyle
   *
   * @returns inlineCodeTextFontStyle
   */
  getInlineCodeTextFontStyle(): FontStyle | undefined {
    return this.inlineCodeTextFontStyle
  }

  /**
   * 获取inlineCodeTextFontWeight
   *
   * @returns inlineCodeTextFontWeight
   */
  getInlineCodeTextFontWeight(): FontWeight | undefined {
    return this.inlineCodeTextFontWeight
  }

  /**
   * 获取inlineCodeTextFontFamily
   *
   * @returns inlineCodeTextFontFamily
   */
  getInlineCodeTextFontFamily(): string | undefined {
    return this.inlineCodeTextFontFamily
  }

  /**
   * 获取inlineCodeTextLineHeight
   *
   * @returns inlineCodeTextLineHeight
   */
  getInlineCodeTextLineHeight(): number | undefined {
    return this.inlineCodeTextLineHeight
  }

  /**
   * 获取inlineCodeTextLetterSpacing
   *
   * @returns inlineCodeTextLetterSpacing
   */
  getInlineCodeTextLetterSpacing(): number | undefined {
    return this.inlineCodeTextLetterSpacing
  }

  /**
   * 获取inlineCodeTextBackgroundColor
   *
   * @returns inlineCodeTextBackgroundColor
   */
  getInlineCodeTextBackgroundColor(): number | undefined {
    return this.inlineCodeTextBackgroundColor
  }

  /**
   * 获取inlineCodeTextBackgroundRadiusTopLeft
   *
   * @returns inlineCodeTextBackgroundRadiusTopLeft
   */
  getInlineCodeTextBackgroundRadiusTopLeft(): number | undefined {
    return this.inlineCodeTextBackgroundRadiusTopLeft
  }

  /**
   * 获取inlineCodeTextBackgroundRadiusTopRight
   *
   * @returns inlineCodeTextBackgroundRadiusTopRight
   */
  getInlineCodeTextBackgroundRadiusTopRight(): number | undefined {
    return this.inlineCodeTextBackgroundRadiusTopRight
  }

  /**
   * 获取inlineCodeTextBackgroundRadiusBottomLeft
   *
   * @returns inlineCodeTextBackgroundRadiusBottomLeft
   */
  getInlineCodeTextBackgroundRadiusBottomLeft(): number | undefined {
    return this.inlineCodeTextBackgroundRadiusBottomLeft
  }

  /**
   * 获取inlineCodeTextBackgroundRadiusBottomRight
   *
   * @returns inlineCodeTextBackgroundRadiusBottomRight
   */
  getInlineCodeTextBackgroundRadiusBottomRight(): number | undefined {
    return this.inlineCodeTextBackgroundRadiusBottomRight
  }
}
