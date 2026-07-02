import { MarkdownBaseTheme } from './MarkdownBaseTheme'

/**
 * 下标样式配置
 */
@Observed
export class SubTheme implements MarkdownBaseTheme {
  subTextFontColor: ResourceColor | undefined = undefined // 字体颜色
  subTextFontSize: number | string | Resource = 8.0 // 字体大小
  subTextFontStyle: FontStyle | undefined = undefined // 字体样式
  subTextFontWeight: number | FontWeight | undefined = undefined // 字体粗细
  subTextFontFamily: string | Resource | undefined = undefined // 字体族
  subTextLetterSpacing: number | undefined = undefined // 字符间距
  subTextBaselineOffset: number = 0.0 // 基线偏移

  /**
   * 设置字体颜色
   *
   * @param color 字体颜色
   * @return SubTheme
   */
  setSubTextFontColor(color: ResourceColor): SubTheme {
    this.subTextFontColor = color
    return this
  }

  /**
   * 设置字体大小
   *
   * @param size 字体大小
   * @return SubTheme
   */
  setSubTextFontSize(size: number | string | Resource): SubTheme {
    this.subTextFontSize = size
    return this
  }

  /**
   * 设置字体样式
   *
   * @param style 字体样式
   * @return SubTheme
   */
  setSubTextFontStyle(style: FontStyle): SubTheme {
    this.subTextFontStyle = style
    return this
  }

  /**
   * 设置字体粗细
   *
   * @param weight 字体粗细
   * @return SubTheme
   */
  setSubTextFontWeight(weight: number | FontWeight): SubTheme {
    this.subTextFontWeight = weight
    return this
  }

  /**
   * 设置字体族
   *
   * @param family 字体族
   * @return SubTheme
   */
  setSubTextFontFamily(family: string | Resource): SubTheme {
    this.subTextFontFamily = family
    return this
  }

  /**
   * 设置字符间距
   *
   * @param spacing 字符间距
   * @return SubTheme
   */
  setSubTextLetterSpacing(spacing: number): SubTheme {
    this.subTextLetterSpacing = spacing
    return this
  }

  /**
   * 设置基线偏移
   *
   * @param offset 基线偏移
   * @return SubTheme
   */
  setSubTextBaselineOffset(offset: number): SubTheme {
    this.subTextBaselineOffset = offset
    return this
  }
}
