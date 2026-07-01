import { MarkdownBaseTheme } from './MarkdownBaseTheme';
import { COLOR_FF191919, isMargin, isPadding } from "../base/Constants";

/**
 * 段落样式配置
 */
@Observed
export class ParagraphTheme implements MarkdownBaseTheme {
  paragraphBackgroundColor: ResourceColor | undefined = undefined // 段落背景颜色
  paragraphMarginTop: Length = 0.0 // 段落外边距上
  paragraphMarginRight: Length = 0.0 // 段落外边距右
  paragraphMarginBottom: Length = 0.0 // 段落外边距下
  paragraphMarginLeft: Length = 0.0 // 段落外边距左
  paragraphPaddingTop: Length = 0.0 // 段落内边距上
  paragraphPaddingRight: Length = 0.0 // 段落内边距右
  paragraphPaddingBottom: Length = 0.0 // 段落内边距下
  paragraphPaddingLeft: Length = 0.0 // 段落内边距左
  paragraphTextFontColor: ResourceColor = COLOR_FF191919 // 段落文本字体颜色
  paragraphTextFontSize: number | string | Resource = 14.0 // 段落文本字体大小
  paragraphTextFontStyle: FontStyle = FontStyle.Normal // 段落文本字体样式
  paragraphTextFontWeight: number | FontWeight = FontWeight.Normal // 段落文本字体粗细
  paragraphTextFontFamily: string | Resource = 'HarmonyOS Sans' // 段落文本字体族
  paragraphTextLineHeight: number | string | Resource = 22.0 // 段落文本行高
  paragraphTextLetterSpacing: number = 0.0 // 段落文本字间距

  /**
   * 设置段落背景颜色
   *
   * @param color 段落背景颜色
   * @return ParagraphTheme
   */
  setParagraphBackgroundColor(color: ResourceColor): ParagraphTheme {
    this.paragraphBackgroundColor = color;
    return this;
  }

  /**
   * 设置段落外边距
   *
   * @param options 段落外边距选项或统一数值
   * @return ParagraphTheme
   */
  setParagraphMargin(options: Margin | Length): ParagraphTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.paragraphMarginTop = options;
      this.paragraphMarginRight = options;
      this.paragraphMarginBottom = options;
      this.paragraphMarginLeft = options;
    }
    // 2. 如果是 object，它要么是 Margin，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Margin 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Margin 处理
      if (isMargin(options)) {
        const margin = options as Margin;
        if (margin.top !== undefined) {
          this.paragraphMarginTop = margin.top;
        }
        if (margin.right !== undefined) {
          this.paragraphMarginRight = margin.right;
        }
        if (margin.bottom !== undefined) {
          this.paragraphMarginBottom = margin.bottom;
        }
        if (margin.left !== undefined) {
          this.paragraphMarginLeft = margin.left;
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.paragraphMarginTop = options as Length;
        this.paragraphMarginRight = options as Length;
        this.paragraphMarginBottom = options as Length;
        this.paragraphMarginLeft = options as Length;
      }
    }
    return this;
  }

  /**
   * 设置段落内边距
   *
   * @param options 段落内边距选项或统一数值
   * @return ParagraphTheme
   */
  setParagraphPadding(options: Padding | Length): ParagraphTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.paragraphPaddingTop = options;
      this.paragraphPaddingRight = options;
      this.paragraphPaddingBottom = options;
      this.paragraphPaddingLeft = options;
    }
    // 2. 如果是 object，它要么是 Padding，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Padding 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Padding 处理
      if (isPadding(options)) {
        const padding = options as Padding;
        if (padding.top !== undefined) {
          this.paragraphPaddingTop = padding.top;
        }
        if (padding.right !== undefined) {
          this.paragraphPaddingRight = padding.right;
        }
        if (padding.bottom !== undefined) {
          this.paragraphPaddingBottom = padding.bottom;
        }
        if (padding.left !== undefined) {
          this.paragraphPaddingLeft = padding.left;
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.paragraphPaddingTop = options as Length;
        this.paragraphPaddingRight = options as Length;
        this.paragraphPaddingBottom = options as Length;
        this.paragraphPaddingLeft = options as Length;
      }
    }
    return this;
  }

  /**
   * 设置段落文本字体颜色
   *
   * @param color 段落文本字体颜色
   * @return ParagraphTheme
   */
  setParagraphTextFontColor(color: ResourceColor): ParagraphTheme {
    this.paragraphTextFontColor = color;
    return this;
  }

  /**
   * 设置段落文本字体大小
   *
   * @param size 段落文本字体大小
   * @return ParagraphTheme
   */
  setParagraphTextFontSize(size: number | string | Resource): ParagraphTheme {
    this.paragraphTextFontSize = size;
    return this;
  }

  /**
   * 设置段落文本字体样式
   *
   * @param style 段落文本字体样式
   * @return ParagraphTheme
   */
  setParagraphTextFontStyle(style: FontStyle): ParagraphTheme {
    this.paragraphTextFontStyle = style;
    return this;
  }

  /**
   * 设置段落文本字体粗细
   *
   * @param weight 段落文本字体粗细
   * @return ParagraphTheme
   */
  setParagraphTextFontWeight(weight: number | FontWeight): ParagraphTheme {
    this.paragraphTextFontWeight = weight;
    return this;
  }

  /**
   * 设置段落文本字体族
   *
   * @param family 段落文本字体族
   * @return ParagraphTheme
   */
  setParagraphTextFontFamily(family: string | Resource): ParagraphTheme {
    this.paragraphTextFontFamily = family;
    return this;
  }

  /**
   * 设置段落文本行高
   *
   * @param lineHeight 段落文本行高
   * @return ParagraphTheme
   */
  setParagraphTextLineHeight(lineHeight: number | string | Resource): ParagraphTheme {
    this.paragraphTextLineHeight = lineHeight;
    return this;
  }

  /**
   * 设置段落文本字间距
   *
   * @param spacing 段落文本字间距
   * @return ParagraphTheme
   */
  setParagraphTextLetterSpacing(spacing: number): ParagraphTheme {
    this.paragraphTextLetterSpacing = spacing;
    return this;
  }
}