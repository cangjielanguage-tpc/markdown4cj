import { MarkdownMarginOptions, MarkdownPaddingOptions } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-段落样式
 */
export class ParagraphTheme {
  /**
   * 段落背景颜色
   */
  private paragraphBackgroundColor?: number = undefined

  /**
   * 段落上外边距
   */
  private paragraphMarginTop?: number = undefined

  /**
   * 段落右外边距
   */
  private paragraphMarginRight?: number = undefined

  /**
   * 段落下外边距
   */
  private paragraphMarginBottom?: number = undefined

  /**
   * 段落左外边距
   */
  private paragraphMarginLeft?: number = undefined

  /**
   * 段落上内边距
   */
  private paragraphPaddingTop?: number = undefined

  /**
   * 段落右内边距
   */
  private paragraphPaddingRight?: number = undefined

  /**
   * 段落下内边距
   */
  private paragraphPaddingBottom?: number = undefined

  /**
   * 段落左内边距
   */
  private paragraphPaddingLeft?: number = undefined

  /**
   * 段落文本颜色
   */
  private paragraphTextFontColor?: number = undefined

  /**
   * 段落文本尺寸
   */
  private paragraphTextFontSize?: number = undefined

  /**
   * 段落文本字体样式
   */
  private paragraphTextFontStyle?: FontStyle = undefined

  /**
   * 段落文本字体粗细
   */
  private paragraphTextFontWeight?: FontWeight = undefined

  /**
   * 段落文本字体
   */
  private paragraphTextFontFamily?: string = undefined

  /**
   * 段落文本行高
   */
  private paragraphTextLineHeight?: number = undefined

  /**
   * 段落文本字符间距
   */
  private paragraphTextLetterSpacing?: number = undefined

  /**
   * 设置段落背景颜色
   *
   * @param color 段落背景颜色
   */
  setParagraphBackgroundColor(color: number): ParagraphTheme {
    this.paragraphBackgroundColor = color
    return this
  }

  /**
   * 设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setParagraphMargin(options: MarkdownMarginOptions | number): ParagraphTheme {
    if (typeof options === "number") {
      this.paragraphMarginTop = options
      this.paragraphMarginRight = options
      this.paragraphMarginBottom = options
      this.paragraphMarginLeft = options
    } else {
      if (options.top !== undefined) {
        this.paragraphMarginTop = options.top
      }
      if (options.right !== undefined) {
        this.paragraphMarginRight = options.right
      }
      if (options.bottom !== undefined) {
        this.paragraphMarginBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.paragraphMarginLeft = options.left
      }
    }
    return this
  }

  /**
   * 设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setParagraphPadding(options: MarkdownPaddingOptions | number): ParagraphTheme {
    if (typeof options === "number") {
      this.paragraphPaddingTop = options
      this.paragraphPaddingRight = options
      this.paragraphPaddingBottom = options
      this.paragraphPaddingLeft = options
    } else {
      if (options.top !== undefined) {
        this.paragraphPaddingTop = options.top
      }
      if (options.right !== undefined) {
        this.paragraphPaddingRight = options.right
      }
      if (options.bottom !== undefined) {
        this.paragraphPaddingBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.paragraphPaddingLeft = options.left
      }
    }
    return this
  }

  /**
   * 设置段落文本颜色
   *
   * @param color 段落文本颜色
   */
  setParagraphTextFontColor(color: number): ParagraphTheme {
    this.paragraphTextFontColor = color
    return this
  }

  /**
   * 设置段落文本尺寸
   *
   * @param size 段落文本尺寸
   */
  setParagraphTextFontSize(size: number): ParagraphTheme {
    this.paragraphTextFontSize = size
    return this
  }

  /**
   * 设置段落文本字体样式
   *
   * @param style 段落文本字体样式
   */
  setParagraphTextFontStyle(style: FontStyle): ParagraphTheme {
    this.paragraphTextFontStyle = style
    return this
  }

  /**
   * 设置段落文本字体粗细
   *
   * @param weight 段落文本字体粗细
   */
  setParagraphTextFontWeight(weight: FontWeight): ParagraphTheme {
    this.paragraphTextFontWeight = weight
    return this
  }

  /**
   * 设置段落文本字体
   *
   * @param family 段落文本字体
   */
  setParagraphTextFontFamily(family: string): ParagraphTheme {
    this.paragraphTextFontFamily = family
    return this
  }

  /**
   * 设置段落文本行高
   *
   * @param lineHeight 段落文本行高
   */
  setParagraphTextLineHeight(lineHeight: number): ParagraphTheme {
    this.paragraphTextLineHeight = lineHeight
    return this
  }

  /**
   * 设置段落文本字符间距
   *
   * @param spacing 段落文本字符间距
   */
  setParagraphTextLetterSpacing(spacing: number): ParagraphTheme {
    this.paragraphTextLetterSpacing = spacing
    return this
  }

  /**
   * 获取paragraphBackgroundColor
   *
   * @returns paragraphBackgroundColor
   */
  getParagraphBackgroundColor(): number | undefined {
    return this.paragraphBackgroundColor
  }

  /**
   * 获取paragraphMarginTop
   *
   * @returns paragraphMarginTop
   */
  getParagraphMarginTop(): number | undefined {
    return this.paragraphMarginTop
  }

  /**
   * 获取paragraphMarginRight
   *
   * @returns paragraphMarginRight
   */
  getParagraphMarginRight(): number | undefined {
    return this.paragraphMarginRight
  }

  /**
   * 获取paragraphMarginBottom
   *
   * @returns paragraphMarginBottom
   */
  getParagraphMarginBottom(): number | undefined {
    return this.paragraphMarginBottom
  }

  /**
   * 获取paragraphMarginLeft
   *
   * @returns paragraphMarginLeft
   */
  getParagraphMarginLeft(): number | undefined {
    return this.paragraphMarginLeft
  }

  /**
   * 获取paragraphPaddingTop
   *
   * @returns paragraphPaddingTop
   */
  getParagraphPaddingTop(): number | undefined {
    return this.paragraphPaddingTop
  }

  /**
   * 获取paragraphPaddingRight
   *
   * @returns paragraphPaddingRight
   */
  getParagraphPaddingRight(): number | undefined {
    return this.paragraphPaddingRight
  }

  /**
   * 获取paragraphPaddingBottom
   *
   * @returns paragraphPaddingBottom
   */
  getParagraphPaddingBottom(): number | undefined {
    return this.paragraphPaddingBottom
  }

  /**
   * 获取paragraphPaddingLeft
   *
   * @returns paragraphPaddingLeft
   */
  getParagraphPaddingLeft(): number | undefined {
    return this.paragraphPaddingLeft
  }

  /**
   * 获取paragraphTextFontColor
   *
   * @returns paragraphTextFontColor
   */
  getParagraphTextFontColor(): number | undefined {
    return this.paragraphTextFontColor
  }

  /**
   * 获取paragraphTextFontSize
   *
   * @returns paragraphTextFontSize
   */
  getParagraphTextFontSize(): number | undefined {
    return this.paragraphTextFontSize
  }

  /**
   * 获取paragraphTextFontStyle
   *
   * @returns paragraphTextFontStyle
   */
  getParagraphTextFontStyle(): FontStyle | undefined {
    return this.paragraphTextFontStyle
  }

  /**
   * 获取paragraphTextFontWeight
   *
   * @returns paragraphTextFontWeight
   */
  getParagraphTextFontWeight(): FontWeight | undefined {
    return this.paragraphTextFontWeight
  }

  /**
   * 获取paragraphTextFontFamily
   *
   * @returns paragraphTextFontFamily
   */
  getParagraphTextFontFamily(): string | undefined {
    return this.paragraphTextFontFamily
  }

  /**
   * 获取paragraphTextLineHeight
   *
   * @returns paragraphTextLineHeight
   */
  getParagraphTextLineHeight(): number | undefined {
    return this.paragraphTextLineHeight
  }

  /**
   * 获取paragraphTextLetterSpacing
   *
   * @returns paragraphTextLetterSpacing
   */
  getParagraphTextLetterSpacing(): number | undefined {
    return this.paragraphTextLetterSpacing
  }
}
