import { COLOR_FF191919, COLOR_BLACK, COLOR_TRANSPARENT_SCB } from '../base/Constants'
import { MarkdownBaseTheme } from './MarkdownBaseTheme'

/**
 * 数学公式样式配置
 */
@Observed
export class LatexMathTheme implements MarkdownBaseTheme {
  latexMathMarginTop: number = 0.0 // 上外边距
  latexMathMarginRight: number = 0.0 // 右外边距
  latexMathMarginBottom: number = 0.0 // 下外边距
  latexMathMarginLeft: number = 0.0 // 左外边距
  latexMathPaddingTop: number = 0.0 // 上内边距
  latexMathPaddingRight: number = 0.0 // 右内边距
  latexMathPaddingBottom: number = 0.0 // 下内边距
  latexMathPaddingLeft: number = 0.0 // 左内边距
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
   * 设置4个外边距为统一值
   *
   * @param margin 外边距
   * @return LatexMathTheme
   */
  setLatexMathAllMargin(margin: number): LatexMathTheme {
    this.latexMathMarginTop = margin
    this.latexMathMarginRight = margin
    this.latexMathMarginBottom = margin
    this.latexMathMarginLeft = margin
    return this
  }

  /**
   * 分别设置4个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   * @return LatexMathTheme
   */
  setLatexMathMargin(top: number, right: number, bottom: number, left: number): LatexMathTheme {
    this.latexMathMarginTop = top
    this.latexMathMarginRight = right
    this.latexMathMarginBottom = bottom
    this.latexMathMarginLeft = left
    return this
  }

  /**
   * 设置4个内边距为统一值
   *
   * @param padding 内边距
   * @return LatexMathTheme
   */
  setLatexMathAllPadding(padding: number): LatexMathTheme {
    this.latexMathPaddingTop = padding
    this.latexMathPaddingRight = padding
    this.latexMathPaddingBottom = padding
    this.latexMathPaddingLeft = padding
    return this
  }

  /**
   * 分别设置4个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   * @return LatexMathTheme
   */
  setLatexMathPadding(top: number, right: number, bottom: number, left: number): LatexMathTheme {
    this.latexMathPaddingTop = top
    this.latexMathPaddingRight = right
    this.latexMathPaddingBottom = bottom
    this.latexMathPaddingLeft = left
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
  setLatexMathColorFormat(colorFormat: number): LatexMathTheme {
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
