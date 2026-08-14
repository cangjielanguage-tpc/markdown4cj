import { MarkdownBaseTheme } from './MarkdownBaseTheme'
import { COLOR_FFFFF59D, isBorderRadiuses } from "../base/Constants"

/**
 * 高亮样式配置
 */
@Observed
export class HighlightTheme implements MarkdownBaseTheme {
  highlightTextFontColor: ResourceColor | undefined = undefined // 字体颜色
  highlightTextFontSize: number | string | Resource | undefined = undefined // 字体大小
  highlightTextFontStyle: FontStyle | undefined = undefined // 字体样式
  highlightTextFontWeight: number | FontWeight | undefined = undefined // 字体粗细
  highlightTextFontFamily: string | Resource | undefined = undefined // 字体族
  highlightTextLineHeight: number | string | Resource | undefined = undefined // 行高
  highlightTextLetterSpacing: number | undefined = undefined // 字间距
  highlightTextBackgroundColor: ResourceColor = COLOR_FFFFF59D // 背景颜色
  highlightTextBackgroundRadiusTopLeft: Length = 0.0 // 左上圆角
  highlightTextBackgroundRadiusTopRight: Length = 0.0 // 右上圆角
  highlightTextBackgroundRadiusBottomLeft: Length = 0.0 // 左下圆角
  highlightTextBackgroundRadiusBottomRight: Length = 0.0 // 右下圆角

  /**
   * 设置字体颜色
   *
   * @param color 字体颜色
   * @return HighlightTheme
   */
  setHighlightTextFontColor(color: ResourceColor): HighlightTheme {
    this.highlightTextFontColor = color
    return this
  }

  /**
   * 设置字体大小
   *
   * @param size 字体大小
   * @return HighlightTheme
   */
  setHighlightTextFontSize(size: number | string | Resource): HighlightTheme {
    this.highlightTextFontSize = size
    return this
  }

  /**
   * 设置字体样式
   *
   * @param style 字体样式
   * @return HighlightTheme
   */
  setHighlightTextFontStyle(style: FontStyle): HighlightTheme {
    this.highlightTextFontStyle = style
    return this
  }

  /**
   * 设置字体粗细
   *
   * @param weight 字体粗细
   * @return HighlightTheme
   */
  setHighlightTextFontWeight(weight: number | FontWeight): HighlightTheme {
    this.highlightTextFontWeight = weight
    return this
  }

  /**
   * 设置字体族
   *
   * @param family 字体族
   * @return HighlightTheme
   */
  setHighlightTextFontFamily(family: string | Resource): HighlightTheme {
    this.highlightTextFontFamily = family
    return this
  }

  /**
   * 设置行高
   *
   * @param lineHeight 行高
   * @return HighlightTheme
   */
  setHighlightTextLineHeight(lineHeight: number | string | Resource): HighlightTheme {
    this.highlightTextLineHeight = lineHeight
    return this
  }

  /**
   * 设置字间距
   *
   * @param spacing 字间距
   * @return HighlightTheme
   */
  setHighlightTextLetterSpacing(spacing: number): HighlightTheme {
    this.highlightTextLetterSpacing = spacing
    return this
  }

  /**
   * 设置背景颜色
   *
   * @param color 背景颜色
   * @return HighlightTheme
   */
  setHighlightTextBackgroundColor(color: ResourceColor): HighlightTheme {
    this.highlightTextBackgroundColor = color
    return this
  }

  /**
   * 设置背景圆角
   *
   * @param options 圆角选项
   * @return HighlightTheme
   */
  setHighlightTextBackgroundRadius(options: BorderRadiuses | Length): HighlightTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.highlightTextBackgroundRadiusTopLeft = options
      this.highlightTextBackgroundRadiusTopRight = options
      this.highlightTextBackgroundRadiusBottomLeft = options
      this.highlightTextBackgroundRadiusBottomRight = options
    }
    // 2. 如果是 object，它要么是 BorderRadiuses，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 BorderRadiuses 的专属属性来区分
      // 如果包含 topLeft/topRight/bottomLeft/bottomRight 任意一个，就当作 BorderRadiuses 处理
      if (isBorderRadiuses(options)) {
        // 这里通过类型守卫，编译器已经知道它是 BorderRadiuses 了
        const radius = options as BorderRadiuses
        if (radius.topLeft !== undefined) {
          this.highlightTextBackgroundRadiusTopLeft = radius.topLeft
        }
        if (radius.topRight !== undefined) {
          this.highlightTextBackgroundRadiusTopRight = radius.topRight
        }
        if (radius.bottomLeft !== undefined) {
          this.highlightTextBackgroundRadiusBottomLeft = radius.bottomLeft
        }
        if (radius.bottomRight !== undefined) {
          this.highlightTextBackgroundRadiusBottomRight = radius.bottomRight
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.highlightTextBackgroundRadiusTopLeft = options as Length
        this.highlightTextBackgroundRadiusTopRight = options as Length
        this.highlightTextBackgroundRadiusBottomLeft = options as Length
        this.highlightTextBackgroundRadiusBottomRight = options as Length
      }
    }
    return this
  }
}
