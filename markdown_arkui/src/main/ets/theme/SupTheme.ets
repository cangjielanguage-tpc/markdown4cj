import { MarkdownBaseTheme } from './MarkdownBaseTheme'

/**
 * 上标样式配置
 */
@Observed
export class SupTheme implements MarkdownBaseTheme {
  supTextFontColor: ResourceColor | undefined = undefined // 字体颜色
  supTextFontSize: number | string | Resource = 8.0 // 字体大小
  supTextFontStyle: FontStyle | undefined = undefined // 字体样式
  supTextFontWeight: number | FontWeight | undefined = undefined // 字体粗细
  supTextFontFamily: string | Resource | undefined = undefined // 字体族
  supTextLetterSpacing: number | undefined = undefined // 字符间距
  supTextBaselineOffset: number = 6.0 // 基线偏移

  /**
   * 设置字体颜色
   *
   * @param color 字体颜色
   * @return SupTheme
   */
  setSupTextFontColor(color: ResourceColor): SupTheme {
    this.supTextFontColor = color
    return this
  }

  /**
   * 设置字体大小
   *
   * @param size 字体大小
   * @return SupTheme
   */
  setSupTextFontSize(size: number | string | Resource): SupTheme {
    this.supTextFontSize = size
    return this
  }

  /**
   * 设置字体样式
   *
   * @param style 字体样式
   * @return SupTheme
   */
  setSupTextFontStyle(style: FontStyle): SupTheme {
    this.supTextFontStyle = style
    return this
  }

  /**
   * 设置字体粗细
   *
   * @param weight 字体粗细
   * @return SupTheme
   */
  setSupTextFontWeight(weight: number | FontWeight): SupTheme {
    this.supTextFontWeight = weight
    return this
  }

  /**
   * 设置字体族
   *
   * @param family 字体族
   * @return SupTheme
   */
  setSupTextFontFamily(family: string | Resource): SupTheme {
    this.supTextFontFamily = family
    return this
  }

  /**
   * 设置字符间距
   *
   * @param spacing 字符间距
   * @return SupTheme
   */
  setSupTextLetterSpacing(spacing: number): SupTheme {
    this.supTextLetterSpacing = spacing
    return this
  }

  /**
   * 设置基线偏移
   *
   * @param offset 基线偏移
   * @return SupTheme
   */
  setSupTextBaselineOffset(offset: number): SupTheme {
    this.supTextBaselineOffset = offset
    return this
  }

  /**
   * 原地合并另一实例的字段到当前实例（动态换肤通道）。
   *
   * MarkdownTheme.applyFrom 逐子主题调用本方法完成样式合并；字段逐一显式赋值，
   * ArkTS 限制使用 Object.assign 等受限标准库 API；新增字段时需同步维护本方法。
   *
   * @param other 来源实例
   * @return SupTheme
   */
  applyFrom(other: SupTheme): SupTheme {
    this.supTextFontColor = other.supTextFontColor
    this.supTextFontSize = other.supTextFontSize
    this.supTextFontStyle = other.supTextFontStyle
    this.supTextFontWeight = other.supTextFontWeight
    this.supTextFontFamily = other.supTextFontFamily
    this.supTextLetterSpacing = other.supTextLetterSpacing
    this.supTextBaselineOffset = other.supTextBaselineOffset
    return this
  }
}
