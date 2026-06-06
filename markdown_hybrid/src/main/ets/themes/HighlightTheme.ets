import { MarkdownRadiusOptions } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-高亮文本样式
 */
export class HighlightTheme {
  /**
   * 高亮文本文本颜色
   */
  private highlightTextFontColor?: number = undefined

  /**
   * 高亮文本文本尺寸
   */
  private highlightTextFontSize?: number = undefined

  /**
   * 高亮文本文本字体样式
   */
  private highlightTextFontStyle?: FontStyle = undefined

  /**
   * 高亮文本文本字体粗细
   */
  private highlightTextFontWeight?: FontWeight = undefined

  /**
   * 高亮文本文本字体
   */
  private highlightTextFontFamily?: string = undefined

  /**
   * 高亮文本文本行高
   */
  private highlightTextLineHeight?: number = undefined

  /**
   * 高亮文本文本字符间距
   */
  private highlightTextLetterSpacing?: number = undefined

  /**
   * 高亮文本文本背景颜色
   */
  private highlightTextBackgroundColor?: number = undefined

  /**
   * 高亮文本文本背景左上圆角
   */
  private highlightTextBackgroundRadiusTopLeft?: number = undefined

  /**
   * 高亮文本文本背景右上圆角
   */
  private highlightTextBackgroundRadiusTopRight?: number = undefined

  /**
   * 高亮文本文本背景左下圆角
   */
  private highlightTextBackgroundRadiusBottomLeft?: number = undefined

  /**
   * 高亮文本文本背景右下圆角
   */
  private highlightTextBackgroundRadiusBottomRight?: number = undefined

  /**
   * 设置高亮文本颜色
   *
   * @param color 高亮文本颜色
   */
  setHighlightTextFontColor(color: number): void {
    this.highlightTextFontColor = color
  }

  /**
   * 设置高亮文本尺寸
   *
   * @param size 高亮文本尺寸
   */
  setHighlightTextFontSize(size: number): void {
    this.highlightTextFontSize = size
  }

  /**
   * 设置高亮文本字体样式
   *
   * @param style 高亮文本字体样式
   */
  setHighlightTextFontStyle(style: FontStyle): void {
    this.highlightTextFontStyle = style
  }

  /**
   * 设置高亮文本字体粗细
   *
   * @param weight 高亮文本字体粗细
   */
  setHighlightTextFontWeight(weight: FontWeight): void {
    this.highlightTextFontWeight = weight
  }

  /**
   * 设置高亮文本字体
   *
   * @param family 高亮文本字体
   */
  setHighlightTextFontFamily(family: string): void {
    this.highlightTextFontFamily = family
  }

  /**
   * 设置高亮文本行高
   *
   * @param lineHeight 高亮文本行高
   */
  setHighlightTextLineHeight(lineHeight: number): void {
    this.highlightTextLineHeight = lineHeight
  }

  /**
   * 设置高亮文本字符间距
   *
   * @param spacing 高亮文本字符间距
   */
  setHighlightTextLetterSpacing(spacing: number): void {
    this.highlightTextLetterSpacing = spacing
  }

  /**
   * 设置高亮文本背景颜色
   *
   * @param color 高亮文本背景颜色
   */
  setHighlightTextBackgroundColor(color: number): void {
    this.highlightTextBackgroundColor = color
  }

  /**
   * 高亮文本背景设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setHighlightTextBackgroundRadius(options: MarkdownRadiusOptions | number): void {
    if (typeof options === 'number') {
      this.highlightTextBackgroundRadiusTopLeft = options
      this.highlightTextBackgroundRadiusTopRight = options
      this.highlightTextBackgroundRadiusBottomLeft = options
      this.highlightTextBackgroundRadiusBottomRight = options
    } else {
      if (options.topLeft !== undefined) {
        this.highlightTextBackgroundRadiusTopLeft = options.topLeft
      }
      if (options.topRight !== undefined) {
        this.highlightTextBackgroundRadiusTopRight = options.topRight
      }
      if (options.bottomLeft !== undefined) {
        this.highlightTextBackgroundRadiusBottomLeft = options.bottomLeft
      }
      if (options.bottomRight !== undefined) {
        this.highlightTextBackgroundRadiusBottomRight = options.bottomRight
      }
    }
  }

  /**
   * 获取高亮文本文本颜色
   *
   * @returns 高亮文本文本颜色
   */
  getHighlightTextFontColor(): number | undefined {
    return this.highlightTextFontColor
  }

  /**
   * 获取高亮文本文本尺寸
   *
   * @returns 高亮文本文本尺寸
   */
  getHighlightTextFontSize(): number | undefined {
    return this.highlightTextFontSize
  }

  /**
   * 获取高亮文本文本字体样式
   *
   * @returns 高亮文本文本字体样式
   */
  getHighlightTextFontStyle(): FontStyle | undefined {
    return this.highlightTextFontStyle
  }

  /**
   * 获取高亮文本文本字体粗细
   *
   * @returns 高亮文本文本字体粗细
   */
  getHighlightTextFontWeight(): FontWeight | undefined {
    return this.highlightTextFontWeight
  }

  /**
   * 获取高亮文本文本字体
   *
   * @returns 高亮文本文本字体
   */
  getHighlightTextFontFamily(): string | undefined {
    return this.highlightTextFontFamily
  }

  /**
   * 获取高亮文本文本行高
   *
   * @returns 高亮文本文本行高
   */
  getHighlightTextLineHeight(): number | undefined {
    return this.highlightTextLineHeight
  }

  /**
   * 获取高亮文本文本字符间距
   *
   * @returns 高亮文本文本字符间距
   */
  getHighlightTextLetterSpacing(): number | undefined {
    return this.highlightTextLetterSpacing
  }

  /**
   * 获取高亮文本文本背景颜色
   *
   * @returns 高亮文本文本背景颜色
   */
  getHighlightTextBackgroundColor(): number | undefined {
    return this.highlightTextBackgroundColor
  }

  /**
   * 获取高亮文本文本背景左上圆角
   *
   * @returns 高亮文本文本背景左上圆角
   */
  getHighlightTextBackgroundRadiusTopLeft(): number | undefined {
    return this.highlightTextBackgroundRadiusTopLeft
  }

  /**
   * 获取高亮文本文本背景右上圆角
   *
   * @returns 高亮文本文本背景右上圆角
   */
  getHighlightTextBackgroundRadiusTopRight(): number | undefined {
    return this.highlightTextBackgroundRadiusTopRight
  }

  /**
   * 获取高亮文本文本背景左下圆角
   *
   * @returns 高亮文本文本背景左下圆角
   */
  getHighlightTextBackgroundRadiusBottomLeft(): number | undefined {
    return this.highlightTextBackgroundRadiusBottomLeft
  }

  /**
   * 获取高亮文本文本背景右下圆角
   *
   * @returns 高亮文本文本背景右下圆角
   */
  getHighlightTextBackgroundRadiusBottomRight(): number | undefined {
    return this.highlightTextBackgroundRadiusBottomRight
  }
}
