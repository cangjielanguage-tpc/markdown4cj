import { LatexMathColorFormat, MarkdownMarginOptions, MarkdownPaddingOptions } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-数学公式样式
 */
export class LatexMathTheme {
  /**
   * LaTeX数学公式上外边距
   */
  private latexMathMarginTop?: number = undefined

  /**
   * LaTeX数学公式右外边距
   */
  private latexMathMarginRight?: number = undefined

  /**
   * LaTeX数学公式下外边距
   */
  private latexMathMarginBottom?: number = undefined

  /**
   * LaTeX数学公式左外边距
   */
  private latexMathMarginLeft?: number = undefined

  /**
   * LaTeX数学公式上内边距
   */
  private latexMathPaddingTop?: number = undefined

  /**
   * LaTeX数学公式右内边距
   */
  private latexMathPaddingRight?: number = undefined

  /**
   * LaTeX数学公式下内边距
   */
  private latexMathPaddingBottom?: number = undefined

  /**
   * LaTeX数学公式左内边距
   */
  private latexMathPaddingLeft?: number = undefined

  /**
   * 数学公式未加载状态是否显示文字
   */
  private latexMathDefaultText?: boolean = undefined

  /**
   * 数学公式未加载状态文本颜色
   */
  private latexMathDefaultTextFontColor?: number = undefined

  /**
   * 数学公式未加载状态文本尺寸
   */
  private latexMathDefaultTextFontSize?: number = undefined

  /**
   * 数学公式未加载状态文本字体样式
   */
  private latexMathDefaultTextFontStyle?: FontStyle = undefined

  /**
   * 数学公式未加载状态文本字体粗细
   */
  private latexMathDefaultTextFontWeight?: FontWeight = undefined

  /**
   * 数学公式未加载状态文本字体
   */
  private latexMathDefaultTextFontFamily?: string = undefined

  /**
   * 数学公式文本大小 - 实际使用要转换
   */
  private latexMathTextSize?: number = undefined

  /**
   * 数学公式背景色
   */
  private latexMathBackgroundColor?: number = undefined

  /**
   * 数学公式文本颜色
   */
  private latexMathTextColor?: number = undefined

  /**
   * 数学公式生成图片格式
   */
  private latexMathColorFormat?: LatexMathColorFormat = undefined

  /**
   * 块结构的数学公式是否居中
   */
  private latexMathBlockCenter?: boolean = undefined

  /**
   * 数学公式字体路径
   */
  private latexMathResPath?: string = undefined

  /**
   * 设置数学公式未加载状态是否显示文字
   *
   * @param showDefaultText 是否显示文字
   */
  setLatexMathDefaultText(showDefaultText: boolean): LatexMathTheme {
    this.latexMathDefaultText = showDefaultText
    return this
  }

  /**
   * 设置数学公式未加载状态文本颜色
   *
   * @param color 文本颜色
   */
  setLatexMathDefaultTextFontColor(color: number): LatexMathTheme {
    this.latexMathDefaultTextFontColor = color
    return this
  }

  /**
   * 设置数学公式未加载状态文本尺寸
   *
   * @param size 文本尺寸
   */
  setLatexMathDefaultTextFontSize(size: number): LatexMathTheme {
    this.latexMathDefaultTextFontSize = size
    return this
  }

  /**
   * 设置数学公式未加载状态文本字体样式
   *
   * @param style 字体样式
   */
  setLatexMathDefaultTextFontStyle(style: FontStyle): LatexMathTheme {
    this.latexMathDefaultTextFontStyle = style
    return this
  }

  /**
   * 设置数学公式未加载状态文本字体粗细
   *
   * @param weight 字体粗细
   */
  setLatexMathDefaultTextFontWeight(weight: FontWeight): LatexMathTheme {
    this.latexMathDefaultTextFontWeight = weight
    return this
  }

  /**
   * 设置数学公式未加载状态文本字体
   *
   * @param family 字体
   */
  setLatexMathDefaultTextFontFamily(family: string): LatexMathTheme {
    this.latexMathDefaultTextFontFamily = family
    return this
  }

  /**
   * 设置数学公式文本大小
   *
   * @param size 文本大小
   */
  setLatexMathTextSize(size: number): LatexMathTheme {
    this.latexMathTextSize = size
    return this
  }

  /**
   * 设置数学公式背景色
   *
   * @param color 背景色
   */
  setLatexMathBackgroundColor(color: number): LatexMathTheme {
    this.latexMathBackgroundColor = color
    return this
  }

  /**
   * 设置数学公式文本颜色
   *
   * @param color 文本颜色
   */
  setLatexMathTextColor(color: number): LatexMathTheme {
    this.latexMathTextColor = color
    return this
  }

  /**
   * 设置数学公式生成图片格式
   *
   * @param format 生成图片格式
   */
  setLatexMathColorFormat(format: LatexMathColorFormat): LatexMathTheme {
    this.latexMathColorFormat = format
    return this
  }

  /**
   * 设置块结构的数学公式是否居中
   *
   * @param center 是否居中
   */
  setLatexMathBlockCenter(center: boolean): LatexMathTheme {
    this.latexMathBlockCenter = center
    return this
  }

  /**
   * 设置数学公式字体路径
   *
   * @param path 字体路径
   */
  setLatexMathResPath(path: string): LatexMathTheme {
    this.latexMathResPath = path
    return this
  }

  /**
   * 设置LaTeX数学公式外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setLatexMathMargin(options: MarkdownMarginOptions | number): LatexMathTheme {
    if (typeof options === "number") {
      this.latexMathMarginTop = options
      this.latexMathMarginRight = options
      this.latexMathMarginBottom = options
      this.latexMathMarginLeft = options
    } else {
      if (options.top !== undefined) {
        this.latexMathMarginTop = options.top
      }
      if (options.right !== undefined) {
        this.latexMathMarginRight = options.right
      }
      if (options.bottom !== undefined) {
        this.latexMathMarginBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.latexMathMarginLeft = options.left
      }
    }
    return this
  }

  /**
   * 设置LaTeX数学公式内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setLatexMathPadding(options: MarkdownPaddingOptions | number): LatexMathTheme {
    if (typeof options === "number") {
      this.latexMathPaddingTop = options
      this.latexMathPaddingRight = options
      this.latexMathPaddingBottom = options
      this.latexMathPaddingLeft = options
    } else {
      if (options.top !== undefined) {
        this.latexMathPaddingTop = options.top
      }
      if (options.right !== undefined) {
        this.latexMathPaddingRight = options.right
      }
      if (options.bottom !== undefined) {
        this.latexMathPaddingBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.latexMathPaddingLeft = options.left
      }
    }
    return this
  }

  /**
   * 获取latexMathMarginTop
   *
   * @returns latexMathMarginTop
   */
  getLatexMathMarginTop(): number | undefined {
    return this.latexMathMarginTop
  }

  /**
   * 获取latexMathMarginRight
   *
   * @returns latexMathMarginRight
   */
  getLatexMathMarginRight(): number | undefined {
    return this.latexMathMarginRight
  }

  /**
   * 获取latexMathMarginBottom
   *
   * @returns latexMathMarginBottom
   */
  getLatexMathMarginBottom(): number | undefined {
    return this.latexMathMarginBottom
  }

  /**
   * 获取latexMathMarginLeft
   *
   * @returns latexMathMarginLeft
   */
  getLatexMathMarginLeft(): number | undefined {
    return this.latexMathMarginLeft
  }

  /**
   * 获取latexMathPaddingTop
   *
   * @returns latexMathPaddingTop
   */
  getLatexMathPaddingTop(): number | undefined {
    return this.latexMathPaddingTop
  }

  /**
   * 获取latexMathPaddingRight
   *
   * @returns latexMathPaddingRight
   */
  getLatexMathPaddingRight(): number | undefined {
    return this.latexMathPaddingRight
  }

  /**
   * 获取latexMathPaddingBottom
   *
   * @returns latexMathPaddingBottom
   */
  getLatexMathPaddingBottom(): number | undefined {
    return this.latexMathPaddingBottom
  }

  /**
   * 获取latexMathPaddingLeft
   *
   * @returns latexMathPaddingLeft
   */
  getLatexMathPaddingLeft(): number | undefined {
    return this.latexMathPaddingLeft
  }

  /**
   * 获取latexMathDefaultText
   *
   * @returns latexMathDefaultText
   */
  getLatexMathDefaultText(): boolean | undefined {
    return this.latexMathDefaultText
  }

  /**
   * 获取latexMathDefaultTextFontColor
   *
   * @returns latexMathDefaultTextFontColor
   */
  getLatexMathDefaultTextFontColor(): number | undefined {
    return this.latexMathDefaultTextFontColor
  }

  /**
   * 获取latexMathDefaultTextFontSize
   *
   * @returns latexMathDefaultTextFontSize
   */
  getLatexMathDefaultTextFontSize(): number | undefined {
    return this.latexMathDefaultTextFontSize
  }

  /**
   * 获取latexMathDefaultTextFontStyle
   *
   * @returns latexMathDefaultTextFontStyle
   */
  getLatexMathDefaultTextFontStyle(): FontStyle | undefined {
    return this.latexMathDefaultTextFontStyle
  }

  /**
   * 获取latexMathDefaultTextFontWeight
   *
   * @returns latexMathDefaultTextFontWeight
   */
  getLatexMathDefaultTextFontWeight(): FontWeight | undefined {
    return this.latexMathDefaultTextFontWeight
  }

  /**
   * 获取latexMathDefaultTextFontFamily
   *
   * @returns latexMathDefaultTextFontFamily
   */
  getLatexMathDefaultTextFontFamily(): string | undefined {
    return this.latexMathDefaultTextFontFamily
  }

  /**
   * 获取latexMathTextSize
   *
   * @returns latexMathTextSize
   */
  getLatexMathTextSize(): number | undefined {
    return this.latexMathTextSize
  }

  /**
   * 获取latexMathBackgroundColor
   *
   * @returns latexMathBackgroundColor
   */
  getLatexMathBackgroundColor(): number | undefined {
    return this.latexMathBackgroundColor
  }

  /**
   * 获取latexMathTextColor
   *
   * @returns latexMathTextColor
   */
  getLatexMathTextColor(): number | undefined {
    return this.latexMathTextColor
  }

  /**
   * 获取latexMathColorFormat
   *
   * @returns latexMathColorFormat
   */
  getLatexMathColorFormat(): LatexMathColorFormat | undefined {
    return this.latexMathColorFormat
  }

  /**
   * 获取latexMathBlockCenter
   *
   * @returns latexMathBlockCenter
   */
  getLatexMathBlockCenter(): boolean | undefined {
    return this.latexMathBlockCenter
  }

  /**
   * 获取latexMathResPath
   *
   * @returns latexMathResPath
   */
  getLatexMathResPath(): string | undefined {
    return this.latexMathResPath
  }
}
