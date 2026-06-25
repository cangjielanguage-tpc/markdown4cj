import { MarkdownBaseTheme } from './MarkdownBaseTheme';

/**
 * 加粗文本样式配置
 */
@Observed
export class BoldTheme implements MarkdownBaseTheme {
  boldTextFontColor: ResourceColor | undefined = undefined // 字体颜色
  boldTextFontSize: number | string | Resource | undefined = undefined // 字体大小
  boldTextFontStyle: FontStyle | undefined = undefined // 字体样式
  boldTextFontWeight: number | FontWeight = FontWeight.Bold // 字体粗细
  boldTextFontFamily: string | Resource | undefined = undefined // 字体族
  boldTextLineHeight: number | string | Resource | undefined = undefined // 行高
  boldTextLetterSpacing: number | undefined = undefined // 字间距

  /**
   * 设置粗体字体颜色
   *
   * @param color 字体颜色
   * @return BoldTheme
   */
  setBoldTextFontColor(color: ResourceColor): BoldTheme {
    this.boldTextFontColor = color;
    return this;
  }

  /**
   * 设置粗体字体大小
   *
   * @param size 字体大小
   * @return BoldTheme
   */
  setBoldTextFontSize(size: number | string | Resource): BoldTheme {
    this.boldTextFontSize = size;
    return this;
  }

  /**
   * 设置粗体字体样式
   *
   * @param style 字体样式
   * @return BoldTheme
   */
  setBoldTextFontStyle(style: FontStyle): BoldTheme {
    this.boldTextFontStyle = style;
    return this;
  }

  /**
   * 设置粗体字体粗细
   *
   * @param weight 字体粗细
   * @return BoldTheme
   */
  setBoldTextFontWeight(weight: number | FontWeight): BoldTheme {
    this.boldTextFontWeight = weight;
    return this;
  }

  /**
   * 设置粗体字体族
   *
   * @param family 字体族
   * @return BoldTheme
   */
  setBoldTextFontFamily(family: string | Resource): BoldTheme {
    this.boldTextFontFamily = family;
    return this;
  }

  /**
   * 设置粗体行高
   *
   * @param lineHeight 行高
   * @return BoldTheme
   */
  setBoldTextLineHeight(lineHeight: number | string | Resource): BoldTheme {
    this.boldTextLineHeight = lineHeight;
    return this;
  }

  /**
   * 设置粗体字间距
   *
   * @param spacing 字间距
   * @return BoldTheme
   */
  setBoldTextLetterSpacing(spacing: number): BoldTheme {
    this.boldTextLetterSpacing = spacing;
    return this;
  }
}