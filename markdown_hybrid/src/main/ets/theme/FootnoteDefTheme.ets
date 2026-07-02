import { isMargin, isPadding } from "../base/Constants"
import { MarkdownBaseTheme } from './MarkdownBaseTheme'

/**
 * 脚注定义样式配置
 */
@Observed
export class FootnoteDefTheme implements MarkdownBaseTheme {
  footnoteDefBackgroundColor: ResourceColor | undefined = undefined // 脚注定义背景颜色
  footnoteDefMarginTop: Length = 0.0 // 脚注定义外边距上
  footnoteDefMarginRight: Length = 0.0 // 脚注定义外边距右
  footnoteDefMarginBottom: Length = 0.0 // 脚注定义外边距下
  footnoteDefMarginLeft: Length = 0.0 // 脚注定义外边距左
  footnoteDefPaddingTop: Length = 0.0 // 脚注定义内边距上
  footnoteDefPaddingRight: Length = 0.0 // 脚注定义内边距右
  footnoteDefPaddingBottom: Length = 0.0 // 脚注定义内边距下
  footnoteDefPaddingLeft: Length = 0.0 // 脚注定义内边距左

  /**
   * 设置脚注定义背景颜色
   *
   * @param color 脚注定义背景颜色
   * @return FootnoteDefTheme
   */
  setFootnoteDefBackgroundColor(color: ResourceColor): FootnoteDefTheme {
    this.footnoteDefBackgroundColor = color
    return this
  }

  /**
   * 设置脚注定义外边距
   *
   * @param options 脚注定义外边距选项或统一数值
   * @return FootnoteDefTheme
   */
  setFootnoteDefMargin(options: Margin | Length): FootnoteDefTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.footnoteDefMarginTop = options
      this.footnoteDefMarginRight = options
      this.footnoteDefMarginBottom = options
      this.footnoteDefMarginLeft = options
    }
    // 2. 如果是 object，它要么是 Margin，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Margin 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Margin 处理
      if (isMargin(options)) {
        const margin = options as Margin
        if (margin.top !== undefined) {
          this.footnoteDefMarginTop = margin.top
        }
        if (margin.right !== undefined) {
          this.footnoteDefMarginRight = margin.right
        }
        if (margin.bottom !== undefined) {
          this.footnoteDefMarginBottom = margin.bottom
        }
        if (margin.left !== undefined) {
          this.footnoteDefMarginLeft = margin.left
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.footnoteDefMarginTop = options as Length
        this.footnoteDefMarginRight = options as Length
        this.footnoteDefMarginBottom = options as Length
        this.footnoteDefMarginLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置脚注定义内边距
   *
   * @param options 脚注定义内边距选项或统一数值
   * @return FootnoteDefTheme
   */
  setFootnoteDefPadding(options: Padding | Length): FootnoteDefTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.footnoteDefPaddingTop = options
      this.footnoteDefPaddingRight = options
      this.footnoteDefPaddingBottom = options
      this.footnoteDefPaddingLeft = options
    }
    // 2. 如果是 object，它要么是 Padding，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Padding 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Padding 处理
      if (isPadding(options)) {
        const padding = options as Padding
        if (padding.top !== undefined) {
          this.footnoteDefPaddingTop = padding.top
        }
        if (padding.right !== undefined) {
          this.footnoteDefPaddingRight = padding.right
        }
        if (padding.bottom !== undefined) {
          this.footnoteDefPaddingBottom = padding.bottom
        }
        if (padding.left !== undefined) {
          this.footnoteDefPaddingLeft = padding.left
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.footnoteDefPaddingTop = options as Length
        this.footnoteDefPaddingRight = options as Length
        this.footnoteDefPaddingBottom = options as Length
        this.footnoteDefPaddingLeft = options as Length
      }
    }
    return this
  }
}
