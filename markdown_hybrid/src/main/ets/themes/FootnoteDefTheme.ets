import { MarkdownMarginOptions, MarkdownPaddingOptions } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-脚注定义样式
 */
export class FootnoteDefTheme {
  /**
   * 脚注定义背景颜色
   */
  private footnoteDefBackgroundColor?: number = undefined

  /**
   * 脚注定义上外边距
   */
  private footnoteDefMarginTop?: number = undefined

  /**
   * 脚注定义右外边距
   */
  private footnoteDefMarginRight?: number = undefined

  /**
   * 脚注定义下外边距
   */
  private footnoteDefMarginBottom?: number = undefined

  /**
   * 脚注定义左外边距
   */
  private footnoteDefMarginLeft?: number = undefined

  /**
   * 脚注定义上内边距
   */
  private footnoteDefPaddingTop?: number = undefined

  /**
   * 脚注定义右内边距
   */
  private footnoteDefPaddingRight?: number = undefined

  /**
   * 脚注定义下内边距
   */
  private footnoteDefPaddingBottom?: number = undefined

  /**
   * 脚注定义左内边距
   */
  private footnoteDefPaddingLeft?: number = undefined

  /**
   * 设置脚注定义背景颜色
   *
   * @param color 脚注定义背景颜色
   */
  setFootnoteDefBackgroundColor(color: number): FootnoteDefTheme {
    this.footnoteDefBackgroundColor = color
    return this
  }

  /**
   * 设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setFootnoteDefMargin(options: MarkdownMarginOptions | number): FootnoteDefTheme {
    if (typeof options === "number") {
      this.footnoteDefMarginTop = options
      this.footnoteDefMarginRight = options
      this.footnoteDefMarginBottom = options
      this.footnoteDefMarginLeft = options
    } else {
      if (options.top !== undefined) {
        this.footnoteDefMarginTop = options.top
      }
      if (options.right !== undefined) {
        this.footnoteDefMarginRight = options.right
      }
      if (options.bottom !== undefined) {
        this.footnoteDefMarginBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.footnoteDefMarginLeft = options.left
      }
    }
    return this
  }

  /**
   * 设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setFootnoteDefPadding(options: MarkdownPaddingOptions | number): FootnoteDefTheme {
    if (typeof options === "number") {
      this.footnoteDefPaddingTop = options
      this.footnoteDefPaddingRight = options
      this.footnoteDefPaddingBottom = options
      this.footnoteDefPaddingLeft = options
    } else {
      if (options.top !== undefined) {
        this.footnoteDefPaddingTop = options.top
      }
      if (options.right !== undefined) {
        this.footnoteDefPaddingRight = options.right
      }
      if (options.bottom !== undefined) {
        this.footnoteDefPaddingBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.footnoteDefPaddingLeft = options.left
      }
    }
    return this
  }

  /**
   * 获取footnoteDefBackgroundColor
   *
   * @returns footnoteDefBackgroundColor
   */
  getFootnoteDefBackgroundColor(): number | undefined {
    return this.footnoteDefBackgroundColor
  }

  /**
   * 获取footnoteDefMarginTop
   *
   * @returns footnoteDefMarginTop
   */
  getFootnoteDefMarginTop(): number | undefined {
    return this.footnoteDefMarginTop
  }

  /**
   * 获取footnoteDefMarginRight
   *
   * @returns footnoteDefMarginRight
   */
  getFootnoteDefMarginRight(): number | undefined {
    return this.footnoteDefMarginRight
  }

  /**
   * 获取footnoteDefMarginBottom
   *
   * @returns footnoteDefMarginBottom
   */
  getFootnoteDefMarginBottom(): number | undefined {
    return this.footnoteDefMarginBottom
  }

  /**
   * 获取footnoteDefMarginLeft
   *
   * @returns footnoteDefMarginLeft
   */
  getFootnoteDefMarginLeft(): number | undefined {
    return this.footnoteDefMarginLeft
  }

  /**
   * 获取footnoteDefPaddingTop
   *
   * @returns footnoteDefPaddingTop
   */
  getFootnoteDefPaddingTop(): number | undefined {
    return this.footnoteDefPaddingTop
  }

  /**
   * 获取footnoteDefPaddingRight
   *
   * @returns footnoteDefPaddingRight
   */
  getFootnoteDefPaddingRight(): number | undefined {
    return this.footnoteDefPaddingRight
  }

  /**
   * 获取footnoteDefPaddingBottom
   *
   * @returns footnoteDefPaddingBottom
   */
  getFootnoteDefPaddingBottom(): number | undefined {
    return this.footnoteDefPaddingBottom
  }

  /**
   * 获取footnoteDefPaddingLeft
   *
   * @returns footnoteDefPaddingLeft
   */
  getFootnoteDefPaddingLeft(): number | undefined {
    return this.footnoteDefPaddingLeft
  }
}
