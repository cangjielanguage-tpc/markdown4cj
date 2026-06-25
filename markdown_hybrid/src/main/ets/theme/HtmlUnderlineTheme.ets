import { MarkdownBaseTheme } from './MarkdownBaseTheme';
import { COLOR_FF191919 } from "../base/Constants";

/**
 * HTML下划线样式配置
 */
@Observed
export class HtmlUnderlineTheme implements MarkdownBaseTheme {
  htmlUnderlineTextFontColor: ResourceColor | undefined = undefined // 字体颜色
  htmlUnderlineTextFontSize: number | string | Resource | undefined = undefined // 字体大小
  htmlUnderlineTextFontStyle: FontStyle | undefined = undefined // 字体样式
  htmlUnderlineTextFontWeight: number | FontWeight | undefined = undefined // 字体粗细
  htmlUnderlineTextFontFamily: string | Resource | undefined = undefined // 字体族
  htmlUnderlineTextLineHeight: number | string | Resource | undefined = undefined // 行高
  htmlUnderlineTextLetterSpacing: number | undefined = undefined // 字间距
  htmlUnderlineTextDecorationColor: ResourceColor = COLOR_FF191919 // 装饰颜色
  htmlUnderlineTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID // 装饰样式

  /**
   * 设置字体颜色
   *
   * @param color 字体颜色
   * @return HtmlUnderlineTheme
   */
  setHtmlUnderlineTextFontColor(color: ResourceColor): HtmlUnderlineTheme {
    this.htmlUnderlineTextFontColor = color;
    return this;
  }

  /**
   * 设置字体大小
   *
   * @param size 字体大小
   * @return HtmlUnderlineTheme
   */
  setHtmlUnderlineTextFontSize(size: number | string | Resource): HtmlUnderlineTheme {
    this.htmlUnderlineTextFontSize = size;
    return this;
  }

  /**
   * 设置字体样式
   *
   * @param style 字体样式
   * @return HtmlUnderlineTheme
   */
  setHtmlUnderlineTextFontStyle(style: FontStyle): HtmlUnderlineTheme {
    this.htmlUnderlineTextFontStyle = style;
    return this;
  }

  /**
   * 设置字体粗细
   *
   * @param weight 字体粗细
   * @return HtmlUnderlineTheme
   */
  setHtmlUnderlineTextFontWeight(weight: number | FontWeight): HtmlUnderlineTheme {
    this.htmlUnderlineTextFontWeight = weight;
    return this;
  }

  /**
   * 设置字体族
   *
   * @param family 字体族
   * @return HtmlUnderlineTheme
   */
  setHtmlUnderlineTextFontFamily(family: string | Resource): HtmlUnderlineTheme {
    this.htmlUnderlineTextFontFamily = family;
    return this;
  }

  /**
   * 设置行高
   *
   * @param lineHeight 行高
   * @return HtmlUnderlineTheme
   */
  setHtmlUnderlineTextLineHeight(lineHeight: number | string | Resource): HtmlUnderlineTheme {
    this.htmlUnderlineTextLineHeight = lineHeight;
    return this;
  }

  /**
   * 设置字间距
   *
   * @param spacing 字间距
   * @return HtmlUnderlineTheme
   */
  setHtmlUnderlineTextLetterSpacing(spacing: number): HtmlUnderlineTheme {
    this.htmlUnderlineTextLetterSpacing = spacing;
    return this;
  }

  /**
   * 设置装饰颜色
   *
   * @param color 装饰颜色
   * @return HtmlUnderlineTheme
   */
  setHtmlUnderlineTextDecorationColor(color: ResourceColor): HtmlUnderlineTheme {
    this.htmlUnderlineTextDecorationColor = color;
    return this;
  }

  /**
   * 设置装饰样式
   *
   * @param style 装饰样式
   * @return HtmlUnderlineTheme
   */
  setHtmlUnderlineTextDecorationStyle(style: TextDecorationStyle): HtmlUnderlineTheme {
    this.htmlUnderlineTextDecorationStyle = style;
    return this;
  }
}