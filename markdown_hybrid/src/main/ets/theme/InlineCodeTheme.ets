import { MarkdownBaseTheme } from './MarkdownBaseTheme'
import { COLOR_FFEAEAEA, isBorderRadiuses } from "../base/Constants"

/**
 * 内联代码样式配置
 */
@Observed
export class InlineCodeTheme implements MarkdownBaseTheme {
  inlineCodeTextFontColor: ResourceColor | undefined = undefined // 字体颜色
  inlineCodeTextFontSize: number | string | Resource | undefined = undefined // 字体大小
  inlineCodeTextFontStyle: FontStyle | undefined = undefined // 字体样式
  inlineCodeTextFontWeight: number | FontWeight | undefined = undefined // 字体粗细
  inlineCodeTextFontFamily: string | Resource | undefined = undefined // 字体族
  inlineCodeTextLineHeight: number | string | Resource | undefined = undefined // 行高
  inlineCodeTextLetterSpacing: number | undefined = undefined // 字间距
  inlineCodeTextBackgroundColor: ResourceColor = COLOR_FFEAEAEA // 背景颜色
  inlineCodeTextBackgroundRadiusTopLeft: Length = 0.0 // 左上圆角
  inlineCodeTextBackgroundRadiusTopRight: Length = 0.0 // 右上圆角
  inlineCodeTextBackgroundRadiusBottomLeft: Length = 0.0 // 左下圆角
  inlineCodeTextBackgroundRadiusBottomRight: Length = 0.0 // 右下圆角

  /**
   * 设置字体颜色
   *
   * @param color 字体颜色
   * @return InlineCodeTheme
   */
  setInlineCodeTextFontColor(color: ResourceColor): InlineCodeTheme {
    this.inlineCodeTextFontColor = color
    return this
  }

  /**
   * 设置字体大小
   *
   * @param size 字体大小
   * @return InlineCodeTheme
   */
  setInlineCodeTextFontSize(size: number | string | Resource): InlineCodeTheme {
    this.inlineCodeTextFontSize = size
    return this
  }

  /**
   * 设置字体样式
   *
   * @param style 字体样式
   * @return InlineCodeTheme
   */
  setInlineCodeTextFontStyle(style: FontStyle): InlineCodeTheme {
    this.inlineCodeTextFontStyle = style
    return this
  }

  /**
   * 设置字体粗细
   *
   * @param weight 字体粗细
   * @return InlineCodeTheme
   */
  setInlineCodeTextFontWeight(weight: number | FontWeight): InlineCodeTheme {
    this.inlineCodeTextFontWeight = weight
    return this
  }

  /**
   * 设置字体族
   *
   * @param family 字体族
   * @return InlineCodeTheme
   */
  setInlineCodeTextFontFamily(family: string | Resource): InlineCodeTheme {
    this.inlineCodeTextFontFamily = family
    return this
  }

  /**
   * 设置行高
   *
   * @param lineHeight 行高
   * @return InlineCodeTheme
   */
  setInlineCodeTextLineHeight(lineHeight: number | string | Resource): InlineCodeTheme {
    this.inlineCodeTextLineHeight = lineHeight
    return this
  }

  /**
   * 设置字间距
   *
   * @param spacing 字间距
   * @return InlineCodeTheme
   */
  setInlineCodeTextLetterSpacing(spacing: number): InlineCodeTheme {
    this.inlineCodeTextLetterSpacing = spacing
    return this
  }

  /**
   * 设置背景颜色
   *
   * @param color 背景颜色
   * @return InlineCodeTheme
   */
  setInlineCodeTextBackgroundColor(color: ResourceColor): InlineCodeTheme {
    this.inlineCodeTextBackgroundColor = color
    return this
  }

  /**
   * 设置背景圆角
   *
   * @param options 圆角选项
   * @return InlineCodeTheme
   */
  setInlineCodeTextBackgroundRadius(options: BorderRadiuses | Length): InlineCodeTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.inlineCodeTextBackgroundRadiusTopLeft = options
      this.inlineCodeTextBackgroundRadiusTopRight = options
      this.inlineCodeTextBackgroundRadiusBottomLeft = options
      this.inlineCodeTextBackgroundRadiusBottomRight = options
    }
    // 2. 如果是 object，它要么是 BorderRadiuses，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 BorderRadiuses 的专属属性来区分
      // 如果包含 topLeft/topRight/bottomLeft/bottomRight 任意一个，就当作 BorderRadiuses 处理
      if (isBorderRadiuses(options)) {
        // 这里通过类型守卫，编译器已经知道它是 BorderRadiuses 了
        const radius = options as BorderRadiuses
        if (radius.topLeft !== undefined) {
          this.inlineCodeTextBackgroundRadiusTopLeft = radius.topLeft
        }
        if (radius.topRight !== undefined) {
          this.inlineCodeTextBackgroundRadiusTopRight = radius.topRight
        }
        if (radius.bottomLeft !== undefined) {
          this.inlineCodeTextBackgroundRadiusBottomLeft = radius.bottomLeft
        }
        if (radius.bottomRight !== undefined) {
          this.inlineCodeTextBackgroundRadiusBottomRight = radius.bottomRight
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.inlineCodeTextBackgroundRadiusTopLeft = options as Length
        this.inlineCodeTextBackgroundRadiusTopRight = options as Length
        this.inlineCodeTextBackgroundRadiusBottomLeft = options as Length
        this.inlineCodeTextBackgroundRadiusBottomRight = options as Length
      }
    }
    return this
  }
}
