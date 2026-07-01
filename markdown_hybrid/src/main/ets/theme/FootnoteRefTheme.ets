import { MarkdownBaseTheme } from './MarkdownBaseTheme';
import { COLOR_RED, COLOR_TRANSPARENT, isBorderRadiuses } from "../base/Constants";

/**
 * 脚注引用样式配置
 */
@Observed
export class FootnoteRefTheme implements MarkdownBaseTheme {
  footnoteRefTextFontColor: ResourceColor = COLOR_RED // 脚注引用文本字体颜色
  footnoteRefTextFontSize: number | string | Resource | undefined = undefined // 脚注引用文本字体大小
  footnoteRefTextFontStyle: FontStyle | undefined = undefined // 脚注引用文本字体样式
  footnoteRefTextFontWeight: number | FontWeight | undefined = undefined // 脚注引用文本字体粗细
  footnoteRefTextFontFamily: string | Resource | undefined = undefined // 脚注引用文本字体族
  footnoteRefTextLineHeight: number | string | Resource | undefined = undefined // 脚注引用文本行高
  footnoteRefTextLetterSpacing: number | undefined = undefined // 脚注引用文本字间距
  footnoteRefTextDecorationType: TextDecorationType = TextDecorationType.Underline // 脚注引用文本装饰类型
  footnoteRefTextDecorationColor: ResourceColor = COLOR_RED // 脚注引用文本装饰颜色
  footnoteRefTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID // 脚注引用文本装饰样式
  footnoteRefTextBackgroundColor: ResourceColor = COLOR_TRANSPARENT // 脚注引用文本背景颜色
  footnoteRefTextBackgroundRadiusTopLeft: Length = 0.0 // 脚注引用文本背景圆角左上
  footnoteRefTextBackgroundRadiusTopRight: Length = 0.0 // 脚注引用文本背景圆角右上
  footnoteRefTextBackgroundRadiusBottomLeft: Length = 0.0 // 脚注引用文本背景圆角左下
  footnoteRefTextBackgroundRadiusBottomRight: Length = 0.0 // 脚注引用文本背景圆角右下

  /**
   * 设置脚注引用文本字体颜色
   *
   * @param color 脚注引用文本字体颜色
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextFontColor(color: ResourceColor): FootnoteRefTheme {
    this.footnoteRefTextFontColor = color;
    return this;
  }

  /**
   * 设置脚注引用文本字体大小
   *
   * @param size 脚注引用文本字体大小
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextFontSize(size: number | string | Resource): FootnoteRefTheme {
    this.footnoteRefTextFontSize = size;
    return this;
  }

  /**
   * 设置脚注引用文本字体样式
   *
   * @param style 脚注引用文本字体样式
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextFontStyle(style: FontStyle): FootnoteRefTheme {
    this.footnoteRefTextFontStyle = style;
    return this;
  }

  /**
   * 设置脚注引用文本字体粗细
   *
   * @param weight 脚注引用文本字体粗细
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextFontWeight(weight: number | FontWeight): FootnoteRefTheme {
    this.footnoteRefTextFontWeight = weight;
    return this;
  }

  /**
   * 设置脚注引用文本字体族
   *
   * @param family 脚注引用文本字体族
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextFontFamily(family: string | Resource): FootnoteRefTheme {
    this.footnoteRefTextFontFamily = family;
    return this;
  }

  /**
   * 设置脚注引用文本行高
   *
   * @param lineHeight 脚注引用文本行高
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextLineHeight(lineHeight: number | string | Resource): FootnoteRefTheme {
    this.footnoteRefTextLineHeight = lineHeight;
    return this;
  }

  /**
   * 设置脚注引用文本字间距
   *
   * @param spacing 脚注引用文本字间距
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextLetterSpacing(spacing: number): FootnoteRefTheme {
    this.footnoteRefTextLetterSpacing = spacing;
    return this;
  }

  /**
   * 设置脚注引用文本装饰类型
   *
   * @param decorationType 脚注引用文本装饰类型
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextDecorationType(decorationType: TextDecorationType): FootnoteRefTheme {
    this.footnoteRefTextDecorationType = decorationType;
    return this;
  }

  /**
   * 设置脚注引用文本装饰颜色
   *
   * @param color 脚注引用文本装饰颜色
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextDecorationColor(color: ResourceColor): FootnoteRefTheme {
    this.footnoteRefTextDecorationColor = color;
    return this;
  }

  /**
   * 设置脚注引用文本装饰样式
   *
   * @param style 脚注引用文本装饰样式
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextDecorationStyle(style: TextDecorationStyle): FootnoteRefTheme {
    this.footnoteRefTextDecorationStyle = style;
    return this;
  }

  /**
   * 设置脚注引用文本背景颜色
   *
   * @param color 脚注引用文本背景颜色
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextBackgroundColor(color: ResourceColor): FootnoteRefTheme {
    this.footnoteRefTextBackgroundColor = color;
    return this;
  }

  /**
   * 设置脚注引用文本背景圆角
   *
   * @param options 脚注引用文本背景圆角选项或统一数值
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextBackgroundRadius(options: BorderRadiuses | Length): FootnoteRefTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.footnoteRefTextBackgroundRadiusTopLeft = options;
      this.footnoteRefTextBackgroundRadiusTopRight = options;
      this.footnoteRefTextBackgroundRadiusBottomLeft = options;
      this.footnoteRefTextBackgroundRadiusBottomRight = options;
    }
    // 2. 如果是 object，它要么是 BorderRadiuses，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 BorderRadiuses 的专属属性来区分
      // 如果包含 topLeft/topRight/bottomLeft/bottomRight 任意一个，就当作 BorderRadiuses 处理
      if (isBorderRadiuses(options)) {
        const radius = options as BorderRadiuses;
        if (radius.topLeft !== undefined) {
          this.footnoteRefTextBackgroundRadiusTopLeft = radius.topLeft;
        }
        if (radius.topRight !== undefined) {
          this.footnoteRefTextBackgroundRadiusTopRight = radius.topRight;
        }
        if (radius.bottomLeft !== undefined) {
          this.footnoteRefTextBackgroundRadiusBottomLeft = radius.bottomLeft;
        }
        if (radius.bottomRight !== undefined) {
          this.footnoteRefTextBackgroundRadiusBottomRight = radius.bottomRight;
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.footnoteRefTextBackgroundRadiusTopLeft = options as Length;
        this.footnoteRefTextBackgroundRadiusTopRight = options as Length;
        this.footnoteRefTextBackgroundRadiusBottomLeft = options as Length;
        this.footnoteRefTextBackgroundRadiusBottomRight = options as Length;
      }
    }
    return this;
  }
}