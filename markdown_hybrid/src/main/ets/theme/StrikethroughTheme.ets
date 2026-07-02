import { MarkdownBaseTheme } from './MarkdownBaseTheme'
import { COLOR_FF191919 } from "../base/Constants"

/**
 * 删除线样式配置
 */
@Observed
export class StrikethroughTheme implements MarkdownBaseTheme {
  strikethroughTextFontColor: ResourceColor | undefined = undefined // 字体颜色
  strikethroughTextFontSize: number | string | Resource | undefined = undefined // 字体大小
  strikethroughTextFontStyle: FontStyle | undefined = undefined // 字体样式
  strikethroughTextFontWeight: number | FontWeight | undefined = undefined // 字体粗细
  strikethroughTextFontFamily: string | Resource | undefined = undefined // 字体族
  strikethroughTextLineHeight: number | string | Resource | undefined = undefined // 行高
  strikethroughTextLetterSpacing: number | undefined = undefined // 字间距
  strikethroughTextDecorationColor: ResourceColor = COLOR_FF191919 // 装饰颜色
  strikethroughTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID // 装饰样式

  /**
   * 设置字体颜色
   *
   * @param color 字体颜色
   * @return StrikethroughTheme
   */
  setStrikethroughTextFontColor(color: ResourceColor): StrikethroughTheme {
    this.strikethroughTextFontColor = color
    return this
  }

  /**
   * 设置字体大小
   *
   * @param size 字体大小
   * @return StrikethroughTheme
   */
  setStrikethroughTextFontSize(size: number | string | Resource): StrikethroughTheme {
    this.strikethroughTextFontSize = size
    return this
  }

  /**
   * 设置字体样式
   *
   * @param style 字体样式
   * @return StrikethroughTheme
   */
  setStrikethroughTextFontStyle(style: FontStyle): StrikethroughTheme {
    this.strikethroughTextFontStyle = style
    return this
  }

  /**
   * 设置字体粗细
   *
   * @param weight 字体粗细
   * @return StrikethroughTheme
   */
  setStrikethroughTextFontWeight(weight: number | FontWeight): StrikethroughTheme {
    this.strikethroughTextFontWeight = weight
    return this
  }

  /**
   * 设置字体族
   *
   * @param family 字体族
   * @return StrikethroughTheme
   */
  setStrikethroughTextFontFamily(family: string | Resource): StrikethroughTheme {
    this.strikethroughTextFontFamily = family
    return this
  }

  /**
   * 设置行高
   *
   * @param lineHeight 行高
   * @return StrikethroughTheme
   */
  setStrikethroughTextLineHeight(lineHeight: number | string | Resource): StrikethroughTheme {
    this.strikethroughTextLineHeight = lineHeight
    return this
  }

  /**
   * 设置字间距
   *
   * @param spacing 字间距
   * @return StrikethroughTheme
   */
  setStrikethroughTextLetterSpacing(spacing: number): StrikethroughTheme {
    this.strikethroughTextLetterSpacing = spacing
    return this
  }

  /**
   * 设置装饰颜色
   *
   * @param color 装饰颜色
   * @return StrikethroughTheme
   */
  setStrikethroughTextDecorationColor(color: ResourceColor): StrikethroughTheme {
    this.strikethroughTextDecorationColor = color
    return this
  }

  /**
   * 设置装饰样式
   *
   * @param style 装饰样式
   * @return StrikethroughTheme
   */
  setStrikethroughTextDecorationStyle(style: TextDecorationStyle): StrikethroughTheme {
    this.strikethroughTextDecorationStyle = style
    return this
  }
}
