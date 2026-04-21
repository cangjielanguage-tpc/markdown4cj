/**
 * Markdown用户可设置的样式-内联代码样式
 */
export class MarkdownThemeInlineCode {
  /**
   * 内联代码文本颜色
   */
  inlineCodeTextFontColor?: number = undefined

  /**
   * 内联代码文本尺寸
   */
  inlineCodeTextFontSize?: number = undefined

  /**
   * 内联代码文本字体样式
   */
  inlineCodeTextFontStyle?: FontStyle = undefined

  /**
   * 内联代码文本字体粗细
   */
  inlineCodeTextFontWeight?: FontWeight = undefined

  /**
   * 内联代码文本字体
   */
  inlineCodeTextFontFamily?: string = undefined

  /**
   * 内联代码文本行高
   */
  inlineCodeTextLineHeight?: number = undefined

  /**
   * 内联代码文本字符间距
   */
  inlineCodeTextLetterSpacing?: number = undefined

  /**
   * 内联代码文本背景颜色
   */
  inlineCodeTextBackgroundColor?: number = undefined

  /**
   * 内联代码文本背景左上圆角
   */
  inlineCodeTextBackgroundRadiusTopLeft?: number = undefined

  /**
   * 内联代码文本背景右上圆角
   */
  inlineCodeTextBackgroundRadiusTopRight?: number = undefined

  /**
   * 内联代码文本背景左下圆角
   */
  inlineCodeTextBackgroundRadiusBottomLeft?: number = undefined

  /**
   * 内联代码文本背景右下圆角
   */
  inlineCodeTextBackgroundRadiusBottomRight?: number = undefined

  /**
   * 设置内联代码文本颜色
   *
   * @param color 内联代码文本颜色
   */
  setInlineCodeTextFontColor(color: number): void {
    this.inlineCodeTextFontColor = color
  }

  /**
   * 设置内联代码文本尺寸
   *
   * @param size 内联代码文本尺寸
   */
  setInlineCodeTextFontSize(size: number): void {
    this.inlineCodeTextFontSize = size
  }

  /**
   * 设置内联代码文本字体样式
   *
   * @param style 内联代码文本字体样式
   */
  setInlineCodeTextFontStyle(style: FontStyle): void {
    this.inlineCodeTextFontStyle = style
  }

  /**
   * 设置内联代码文本字体粗细
   *
   * @param weight 内联代码文本字体粗细
   */
  setInlineCodeTextFontWeight(weight: FontWeight): void {
    this.inlineCodeTextFontWeight = weight
  }

  /**
   * 设置内联代码文本字体
   *
   * @param family 内联代码文本字体
   */
  setInlineCodeTextFontFamily(family: string): void {
    this.inlineCodeTextFontFamily = family
  }

  /**
   * 设置内联代码文本行高
   *
   * @param lineHeight 内联代码文本行高
   */
  setInlineCodeTextLineHeight(lineHeight: number): void {
    this.inlineCodeTextLineHeight = lineHeight
  }

  /**
   * 设置内联代码文本字符间距
   *
   * @param spacing 内联代码文本字符间距
   */
  setInlineCodeTextLetterSpacing(spacing: number): void {
    this.inlineCodeTextLetterSpacing = spacing
  }

  /**
   * 设置内联代码文本背景颜色
   *
   * @param color 内联代码文本背景颜色
   */
  setInlineCodeTextBackgroundColor(color: number): void {
    this.inlineCodeTextBackgroundColor = color
  }

  /**
   * 统一设置内联代码文本背景四个圆角
   *
   * @param radius 统一圆角半径，同时赋值给四个角
   */
  setInlineCodeTextBackgroundAllRadius(radius: number): void {
    this.inlineCodeTextBackgroundRadiusTopLeft = radius
    this.inlineCodeTextBackgroundRadiusTopRight = radius
    this.inlineCodeTextBackgroundRadiusBottomLeft = radius
    this.inlineCodeTextBackgroundRadiusBottomRight = radius
  }

  /**
   * 分别设置4个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setInlineCodeTextBackgroundRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void {
    this.inlineCodeTextBackgroundRadiusTopLeft = topLeft
    this.inlineCodeTextBackgroundRadiusTopRight = topRight
    this.inlineCodeTextBackgroundRadiusBottomLeft = bottomLeft
    this.inlineCodeTextBackgroundRadiusBottomRight = bottomRight
  }
}
