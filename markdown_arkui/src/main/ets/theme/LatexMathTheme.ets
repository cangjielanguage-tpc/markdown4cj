import { LatexMathColorFormat } from '@cangjie-tpc/formula_hybrid'
import { COLOR_FF191919, COLOR_BLACK, COLOR_TRANSPARENT_SCB, isMargin, isPadding } from '../base/Constants'
import { MarkdownBaseTheme } from './MarkdownBaseTheme'

/**
 * 数学公式样式配置
 */
@Observed
export class LatexMathTheme implements MarkdownBaseTheme {
  latexMathMarginTop: Length = 0.0 // 上外边距
  latexMathMarginRight: Length = 0.0 // 右外边距
  latexMathMarginBottom: Length = 0.0 // 下外边距
  latexMathMarginLeft: Length = 0.0 // 左外边距
  latexMathPaddingTop: Length = 0.0 // 上内边距
  latexMathPaddingRight: Length = 0.0 // 右内边距
  latexMathPaddingBottom: Length = 0.0 // 下内边距
  latexMathPaddingLeft: Length = 0.0 // 左内边距
  latexMathDefaultText: boolean = true // 未加载状态是否显示文字
  latexMathDefaultTextFontColor: ResourceColor = COLOR_FF191919 // 未加载状态文本颜色
  latexMathDefaultTextFontSize: number | string | Resource = 14.0 // 未加载状态文本尺寸
  latexMathDefaultTextFontStyle: FontStyle = FontStyle.Normal // 未加载状态文本字体样式
  latexMathDefaultTextFontWeight: number | FontWeight = FontWeight.Normal // 未加载状态文本字体粗细
  latexMathDefaultTextFontFamily: string | Resource | undefined = undefined // 未加载状态文本字体
  latexMathTextSize: number = 14.0 // 数学公式文本大小 - 单位fp
  latexMathBackgroundColor: ResourceColor = COLOR_TRANSPARENT_SCB // 数学公式背景颜色
  latexMathTextColor: ResourceColor = COLOR_BLACK // 数学公式文本颜色
  latexMathColorFormat: number = 1 // 数学公式生成图片格式 - 0:RGB_565, 1:BGRA_8888
  latexMathBlockCenter: boolean = true // 块结构的数学公式是否居中
  latexMathResPath: string | undefined = undefined // 数学公式资源路径

  /**
   * 设置LaTeX数学公式外边距
   *
   * @param options Margin | Length 类型
   *                  入参 Length 类型时四个设为相同值
   *                  入参 Margin 类型时分别设置
   * @return LatexMathTheme
   */
  setLatexMathMargin(options: Margin | Length): LatexMathTheme {
    if (typeof options === "number" || typeof options === "string") {
      this.latexMathMarginTop = options
      this.latexMathMarginRight = options
      this.latexMathMarginBottom = options
      this.latexMathMarginLeft = options
    } else if (typeof options === "object" && options !== null) {
      if (isMargin(options)) {
        const margin = options as Margin
        if (margin.top !== undefined) {
          this.latexMathMarginTop = margin.top
        }
        if (margin.right !== undefined) {
          this.latexMathMarginRight = margin.right
        }
        if (margin.bottom !== undefined) {
          this.latexMathMarginBottom = margin.bottom
        }
        if (margin.left !== undefined) {
          this.latexMathMarginLeft = margin.left
        }
      } else {
        this.latexMathMarginTop = options as Length
        this.latexMathMarginRight = options as Length
        this.latexMathMarginBottom = options as Length
        this.latexMathMarginLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置LaTeX数学公式内边距
   *
   * @param options Padding | Length 类型
   *                  入参 Length 类型时四个设为相同值
   *                  入参 Padding 类型时分别设置
   * @return LatexMathTheme
   */
  setLatexMathPadding(options: Padding | Length): LatexMathTheme {
    if (typeof options === "number" || typeof options === "string") {
      this.latexMathPaddingTop = options
      this.latexMathPaddingRight = options
      this.latexMathPaddingBottom = options
      this.latexMathPaddingLeft = options
    } else if (typeof options === "object" && options !== null) {
      if (isPadding(options)) {
        const padding = options as Padding
        if (padding.top !== undefined) {
          this.latexMathPaddingTop = padding.top
        }
        if (padding.right !== undefined) {
          this.latexMathPaddingRight = padding.right
        }
        if (padding.bottom !== undefined) {
          this.latexMathPaddingBottom = padding.bottom
        }
        if (padding.left !== undefined) {
          this.latexMathPaddingLeft = padding.left
        }
      } else {
        this.latexMathPaddingTop = options as Length
        this.latexMathPaddingRight = options as Length
        this.latexMathPaddingBottom = options as Length
        this.latexMathPaddingLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置数学公式未加载状态是否显示文字
   *
   * @param defaultText 是否显示文字
   * @return LatexMathTheme
   */
  setLatexMathDefaultText(defaultText: boolean): LatexMathTheme {
    this.latexMathDefaultText = defaultText
    return this
  }

  /**
   * 设置数学公式未加载状态文本颜色
   *
   * @param color 文本颜色
   * @return LatexMathTheme
   */
  setLatexMathDefaultTextFontColor(color: ResourceColor): LatexMathTheme {
    this.latexMathDefaultTextFontColor = color
    return this
  }

  /**
   * 设置数学公式未加载状态文本尺寸
   *
   * @param size 文本尺寸
   * @return LatexMathTheme
   */
  setLatexMathDefaultTextFontSize(size: number | string | Resource): LatexMathTheme {
    this.latexMathDefaultTextFontSize = size
    return this
  }

  /**
   * 设置数学公式未加载状态文本字体样式
   *
   * @param style 文本字体样式
   * @return LatexMathTheme
   */
  setLatexMathDefaultTextFontStyle(style: FontStyle): LatexMathTheme {
    this.latexMathDefaultTextFontStyle = style
    return this
  }

  /**
   * 设置数学公式未加载状态文本字体粗细
   *
   * @param weight 文本字体粗细
   * @return LatexMathTheme
   */
  setLatexMathDefaultTextFontWeight(weight: number | FontWeight): LatexMathTheme {
    this.latexMathDefaultTextFontWeight = weight
    return this
  }

  /**
   * 设置数学公式未加载状态文本字体
   *
   * @param family 文本字体
   * @return LatexMathTheme
   */
  setLatexMathDefaultTextFontFamily(family: string | Resource): LatexMathTheme {
    this.latexMathDefaultTextFontFamily = family
    return this
  }

  /**
   * 设置数学公式文本大小
   *
   * @param size 文本大小 - 单位fp
   * @return LatexMathTheme
   */
  setLatexMathTextSize(size: number): LatexMathTheme {
    this.latexMathTextSize = size
    return this
  }

  /**
   * 设置数学公式背景颜色
   *
   * @param color 背景颜色
   * @return LatexMathTheme
   */
  setLatexMathBackgroundColor(color: ResourceColor): LatexMathTheme {
    this.latexMathBackgroundColor = color
    return this
  }

  /**
   * 设置数学公式文本颜色
   *
   * @param color 文本颜色
   * @return LatexMathTheme
   */
  setLatexMathTextColor(color: ResourceColor): LatexMathTheme {
    this.latexMathTextColor = color
    return this
  }

  /**
   * 设置数学公式生成图片格式
   *
   * @param colorFormat 图片格式 - 0:RGB_565, 1:BGRA_8888。默认1
   * @return LatexMathTheme
   */
  setLatexMathColorFormat(colorFormat: LatexMathColorFormat): LatexMathTheme {
    this.latexMathColorFormat = colorFormat
    return this
  }

  /**
   * 设置块结构的数学公式是否居中
   *
   * @param center 是否居中
   * @return LatexMathTheme
   */
  setLatexMathBlockCenter(center: boolean): LatexMathTheme {
    this.latexMathBlockCenter = center
    return this
  }

  /**
   * 设置数学公式资源路径
   *
   * @param path 资源路径
   * @return LatexMathTheme
   */
  setLatexMathResPath(path: string): LatexMathTheme {
    this.latexMathResPath = path
    return this
  }
}
