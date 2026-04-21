import { LatexMathColorFormat } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-数学公式样式
 */
export class MarkdownThemeLatexMath {
  /**
   * LaTeX数学公式上外边距
   */
  latexMathMarginTop?: number = undefined

  /**
   * LaTeX数学公式右外边距
   */
  latexMathMarginRight?: number = undefined

  /**
   * LaTeX数学公式下外边距
   */
  latexMathMarginBottom?: number = undefined

  /**
   * LaTeX数学公式左外边距
   */
  latexMathMarginLeft?: number = undefined

  /**
   * LaTeX数学公式上内边距
   */
  latexMathPaddingTop?: number = undefined

  /**
   * LaTeX数学公式右内边距
   */
  latexMathPaddingRight?: number = undefined

  /**
   * LaTeX数学公式下内边距
   */
  latexMathPaddingBottom?: number = undefined

  /**
   * LaTeX数学公式左内边距
   */
  latexMathPaddingLeft?: number = undefined

  /**
   * 数学公式未加载状态是否显示文字
   */
  latexMathDefaultText?: boolean = undefined

  /**
   * 数学公式未加载状态文本颜色
   */
  latexMathDefaultTextFontColor?: number = undefined

  /**
   * 数学公式未加载状态文本尺寸
   */
  latexMathDefaultTextFontSize?: number = undefined

  /**
   * 数学公式未加载状态文本字体样式
   */
  latexMathDefaultTextFontStyle?: FontStyle = undefined

  /**
   * 数学公式未加载状态文本字体粗细
   */
  latexMathDefaultTextFontWeight?: FontWeight = undefined

  /**
   * 数学公式未加载状态文本字体
   */
  latexMathDefaultTextFontFamily?: string = undefined

  /**
   * 数学公式文本大小 - 实际使用要转换
   */
  latexMathTextSize?: number = undefined

  /**
   * 数学公式背景色
   */
  latexMathBackgroundColor?: number = undefined

  /**
   * 数学公式文本颜色
   */
  latexMathTextColor?: number = undefined

  /**
   * 数学公式生成图片格式
   */
  latexMathColorFormat?: LatexMathColorFormat = undefined

  /**
   * 块结构的数学公式是否居中
   */
  latexMathBlockCenter?: boolean = undefined

  /**
   * 数学公式字体路径
   */
  latexMathResPath?: string = undefined

  /**
   * 设置数学公式未加载状态是否显示文字
   *
   * @param showDefaultText 是否显示文字
   */
  setLatexMathDefaultText(showDefaultText: boolean): void {
    this.latexMathDefaultText = showDefaultText
  }

  /**
   * 设置数学公式未加载状态文本颜色
   *
   * @param color 文本颜色
   */
  setLatexMathDefaultTextFontColor(color: number): void {
    this.latexMathDefaultTextFontColor = color
  }

  /**
   * 设置数学公式未加载状态文本尺寸
   *
   * @param size 文本尺寸
   */
  setLatexMathDefaultTextFontSize(size: number): void {
    this.latexMathDefaultTextFontSize = size
  }

  /**
   * 设置数学公式未加载状态文本字体样式
   *
   * @param style 字体样式
   */
  setLatexMathDefaultTextFontStyle(style: FontStyle): void {
    this.latexMathDefaultTextFontStyle = style
  }

  /**
   * 设置数学公式未加载状态文本字体粗细
   *
   * @param weight 字体粗细
   */
  setLatexMathDefaultTextFontWeight(weight: FontWeight): void {
    this.latexMathDefaultTextFontWeight = weight
  }

  /**
   * 设置数学公式未加载状态文本字体
   *
   * @param family 字体
   */
  setLatexMathDefaultTextFontFamily(family: string): void {
    this.latexMathDefaultTextFontFamily = family
  }

  /**
   * 设置数学公式文本大小
   *
   * @param size 文本大小
   */
  setLatexMathTextSize(size: number): void {
    this.latexMathTextSize = size
  }

  /**
   * 设置数学公式背景色
   *
   * @param color 背景色
   */
  setLatexMathBackgroundColor(color: number): void {
    this.latexMathBackgroundColor = color
  }

  /**
   * 设置数学公式文本颜色
   *
   * @param color 文本颜色
   */
  setLatexMathTextColor(color: number): void {
    this.latexMathTextColor = color
  }

  /**
   * 设置数学公式生成图片格式
   *
   * @param format 生成图片格式
   */
  setLatexMathColorFormat(format: LatexMathColorFormat): void {
    this.latexMathColorFormat = format
  }

  /**
   * 设置块结构的数学公式是否居中
   *
   * @param center 是否居中
   */
  setLatexMathBlockCenter(center: boolean): void {
    this.latexMathBlockCenter = center
  }

  /**
   * 设置数学公式字体路径
   *
   * @param path 字体路径
   */
  setLatexMathResPath(path: string): void {
    this.latexMathResPath = path
  }

  /**
   * 统一设置LaTeX数学公式外边距
   *
   * @param margin 外边距
   */
  setLatexMathAllMargin(margin: number): void {
    this.latexMathMarginTop = margin
    this.latexMathMarginRight = margin
    this.latexMathMarginBottom = margin
    this.latexMathMarginLeft = margin
  }

  /**
   * 分别设置LaTeX数学公式四个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setLatexMathMargin(top?: number, right?: number, bottom?: number, left?: number): void {
    this.latexMathMarginTop = top
    this.latexMathMarginRight = right
    this.latexMathMarginBottom = bottom
    this.latexMathMarginLeft = left
  }

  /**
   * 统一设置LaTeX数学公式内边距
   *
   * @param padding 内边距
   */
  setLatexMathAllPadding(padding: number): void {
    this.latexMathPaddingTop = padding
    this.latexMathPaddingRight = padding
    this.latexMathPaddingBottom = padding
    this.latexMathPaddingLeft = padding
  }

  /**
   * 分别设置LaTeX数学公式四个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setLatexMathPadding(top?: number, right?: number, bottom?: number, left?: number): void {
    this.latexMathPaddingTop = top
    this.latexMathPaddingRight = right
    this.latexMathPaddingBottom = bottom
    this.latexMathPaddingLeft = left
  }
}
