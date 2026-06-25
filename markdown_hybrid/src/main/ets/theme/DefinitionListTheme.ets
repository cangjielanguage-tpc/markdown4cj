import { isMargin, isPadding } from "../base/Constants";
import { MarkdownBaseTheme } from './MarkdownBaseTheme';

/**
 * 定义列表样式配置
 */
@Observed
export class DefinitionListTheme implements MarkdownBaseTheme {
  definitionListBackgroundColor: ResourceColor | undefined = undefined // 定义列表背景颜色
  definitionListMarginTop: Length = 0.0 // 定义列表外边距上
  definitionListMarginRight: Length = 0.0 // 定义列表外边距右
  definitionListMarginBottom: Length = 0.0 // 定义列表外边距下
  definitionListMarginLeft: Length = 0.0 // 定义列表外边距左
  definitionListPaddingTop: Length = 0.0 // 定义列表内边距上
  definitionListPaddingRight: Length = 0.0 // 定义列表内边距右
  definitionListPaddingBottom: Length = 0.0 // 定义列表内边距下
  definitionListPaddingLeft: Length = 0.0 // 定义列表内边距左
  definitionListTermToDescriptionSpacing: number = 8.0 // 定义列表术语到描述间距
  definitionListTermTextFontWeight: number | FontWeight = FontWeight.Bold // 定义列表术语文本字体粗细
  definitionListTermTextFontStyle: FontStyle = FontStyle.Italic // 定义列表术语文本字体样式
  definitionListDescriptionItemSpacing: number = 8.0 // 定义列表描述项间距
  definitionListDescriptionIndent: number = 8.0 // 定义列表描述缩进

  /**
   * 设置定义列表背景颜色
   *
   * @param color 定义列表背景颜色
   * @return DefinitionListTheme
   */
  setDefinitionListBackgroundColor(color: ResourceColor): DefinitionListTheme {
    this.definitionListBackgroundColor = color;
    return this;
  }

  /**
   * 设置定义列表外边距
   *
   * @param options 定义列表外边距选项或统一数值
   * @return DefinitionListTheme
   */
  setDefinitionListMargin(options: Margin | Length): DefinitionListTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.definitionListMarginTop = options;
      this.definitionListMarginRight = options;
      this.definitionListMarginBottom = options;
      this.definitionListMarginLeft = options;
    }
    // 2. 如果是 object，它要么是 Margin，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Margin 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Margin 处理
      if (isMargin(options)) {
        const margin = options as Margin;
        if (margin.top !== undefined) {
          this.definitionListMarginTop = margin.top;
        }
        if (margin.right !== undefined) {
          this.definitionListMarginRight = margin.right;
        }
        if (margin.bottom !== undefined) {
          this.definitionListMarginBottom = margin.bottom;
        }
        if (margin.left !== undefined) {
          this.definitionListMarginLeft = margin.left;
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.definitionListMarginTop = options as Length;
        this.definitionListMarginRight = options as Length;
        this.definitionListMarginBottom = options as Length;
        this.definitionListMarginLeft = options as Length;
      }
    }
    return this;
  }

  /**
   * 设置定义列表内边距
   *
   * @param options 定义列表内边距选项或统一数值
   * @return DefinitionListTheme
   */
  setDefinitionListPadding(options: Padding | Length): DefinitionListTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.definitionListPaddingTop = options;
      this.definitionListPaddingRight = options;
      this.definitionListPaddingBottom = options;
      this.definitionListPaddingLeft = options;
    }
    // 2. 如果是 object，它要么是 Padding，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Padding 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Padding 处理
      if (isPadding(options)) {
        const padding = options as Padding;
        if (padding.top !== undefined) {
          this.definitionListPaddingTop = padding.top;
        }
        if (padding.right !== undefined) {
          this.definitionListPaddingRight = padding.right;
        }
        if (padding.bottom !== undefined) {
          this.definitionListPaddingBottom = padding.bottom;
        }
        if (padding.left !== undefined) {
          this.definitionListPaddingLeft = padding.left;
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.definitionListPaddingTop = options as Length;
        this.definitionListPaddingRight = options as Length;
        this.definitionListPaddingBottom = options as Length;
        this.definitionListPaddingLeft = options as Length;
      }
    }
    return this;
  }

  /**
   * 设置定义列表术语到描述间距
   *
   * @param spacing 定义列表术语到描述间距
   * @return DefinitionListTheme
   */
  setDefinitionListTermToDescriptionSpacing(spacing: number): DefinitionListTheme {
    this.definitionListTermToDescriptionSpacing = spacing;
    return this;
  }

  /**
   * 设置定义列表术语文本字体粗细
   *
   * @param weight 定义列表术语文本字体粗细
   * @return DefinitionListTheme
   */
  setDefinitionListTermTextFontWeight(weight: number | FontWeight): DefinitionListTheme {
    this.definitionListTermTextFontWeight = weight;
    return this;
  }

  /**
   * 设置定义列表术语文本字体样式
   *
   * @param style 定义列表术语文本字体样式
   * @return DefinitionListTheme
   */
  setDefinitionListTermTextFontStyle(style: FontStyle): DefinitionListTheme {
    this.definitionListTermTextFontStyle = style;
    return this;
  }

  /**
   * 设置定义列表描述项间距
   *
   * @param spacing 定义列表描述项间距
   * @return DefinitionListTheme
   */
  setDefinitionListDescriptionItemSpacing(spacing: number): DefinitionListTheme {
    this.definitionListDescriptionItemSpacing = spacing;
    return this;
  }

  /**
   * 设置定义列表描述缩进
   *
   * @param indent 定义列表描述缩进
   * @return DefinitionListTheme
   */
  setDefinitionListDescriptionIndent(indent: number): DefinitionListTheme {
    this.definitionListDescriptionIndent = indent;
    return this;
  }
}