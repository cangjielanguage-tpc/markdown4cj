import { MarkdownBaseTheme } from './MarkdownBaseTheme';

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
    this.supTextFontColor = color;
    return this;
  }

  /**
   * 设置字体大小
   *
   * @param size 字体大小
   * @return SupTheme
   */
  setSupTextFontSize(size: number | string | Resource): SupTheme {
    this.supTextFontSize = size;
    return this;
  }

  /**
   * 设置字体样式
   *
   * @param style 字体样式
   * @return SupTheme
   */
  setSupTextFontStyle(style: FontStyle): SupTheme {
    this.supTextFontStyle = style;
    return this;
  }

  /**
   * 设置字体粗细
   *
   * @param weight 字体粗细
   * @return SupTheme
   */
  setSupTextFontWeight(weight: number | FontWeight): SupTheme {
    this.supTextFontWeight = weight;
    return this;
  }

  /**
   * 设置字体族
   *
   * @param family 字体族
   * @return SupTheme
   */
  setSupTextFontFamily(family: string | Resource): SupTheme {
    this.supTextFontFamily = family;
    return this;
  }

  /**
   * 设置字符间距
   *
   * @param spacing 字符间距
   * @return SupTheme
   */
  setSupTextLetterSpacing(spacing: number): SupTheme {
    this.supTextLetterSpacing = spacing;
    return this;
  }

  /**
   * 设置基线偏移
   *
   * @param offset 基线偏移
   * @return SupTheme
   */
  setSupTextBaselineOffset(offset: number): SupTheme {
    this.supTextBaselineOffset = offset;
    return this;
  }
}