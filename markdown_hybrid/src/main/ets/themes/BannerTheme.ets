import { MarkdownMarginOptions, MarkdownPaddingOptions } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-Banner样式
 */
export class BannerTheme {
  /**
   * banner上外边距
   */
  private bannerMarginTop?: number = undefined

  /**
   * banner右外边距
   */
  private bannerMarginRight?: number = undefined

  /**
   * banner下外边距
   */
  private bannerMarginBottom?: number = undefined

  /**
   * banner左外边距
   */
  private bannerMarginLeft?: number = undefined

  /**
   * banner上内边距
   */
  private bannerPaddingTop?: number = undefined

  /**
   * banner右内边距
   */
  private bannerPaddingRight?: number = undefined

  /**
   * banner下内边距
   */
  private bannerPaddingBottom?: number = undefined

  /**
   * banner左内边距
   */
  private bannerPaddingLeft?: number = undefined

  /**
   * banner占位图
   */
  private bannerPlaceholder?: Resource = undefined

  /**
   * banner设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setBannerMargin(options: MarkdownMarginOptions | number): void {
    if (typeof options === "number") {
      this.bannerMarginTop = options
      this.bannerMarginRight = options
      this.bannerMarginBottom = options
      this.bannerMarginLeft = options
    } else {
      if (options.top !== undefined) {
        this.bannerMarginTop = options.top
      }
      if (options.right !== undefined) {
        this.bannerMarginRight = options.right
      }
      if (options.bottom !== undefined) {
        this.bannerMarginBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.bannerMarginLeft = options.left
      }
    }
  }

  /**
   * banner设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setBannerPadding(options: MarkdownPaddingOptions | number): void {
    if (typeof options === 'number') {
      this.bannerPaddingTop = options
      this.bannerPaddingRight = options
      this.bannerPaddingBottom = options
      this.bannerPaddingLeft = options
    } else {
      if (options.top !== undefined) {
        this.bannerPaddingTop = options.top
      }
      if (options.right !== undefined) {
        this.bannerPaddingRight = options.right
      }
      if (options.bottom !== undefined) {
        this.bannerPaddingBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.bannerPaddingLeft = options.left
      }
    }
  }

  /**
   * 设置banner占位图
   *
   * @param resource banner占位图
   */
  setBannerPlaceholder(resource: Resource): void {
    this.bannerPlaceholder = resource
  }

  /**
   * 获取bannerMarginTop
   *
   * @returns bannerMarginTop
   */
  getBannerMarginTop(): number | undefined {
    return this.bannerMarginTop
  }

  /**
   * 获取bannerMarginRight
   *
   * @returns bannerMarginRight
   */
  getBannerMarginRight(): number | undefined {
    return this.bannerMarginRight
  }

  /**
   * 获取bannerMarginBottom
   *
   * @returns bannerMarginBottom
   */
  getBannerMarginBottom(): number | undefined {
    return this.bannerMarginBottom
  }

  /**
   * 获取bannerMarginLeft
   *
   * @returns bannerMarginLeft
   */
  getBannerMarginLeft(): number | undefined {
    return this.bannerMarginLeft
  }

  /**
   * 获取bannerPaddingTop
   *
   * @returns bannerPaddingTop
   */
  getBannerPaddingTop(): number | undefined {
    return this.bannerPaddingTop
  }

  /**
   * 获取bannerPaddingRight
   *
   * @returns bannerPaddingRight
   */
  getBannerPaddingRight(): number | undefined {
    return this.bannerPaddingRight
  }

  /**
   * 获取bannerPaddingBottom
   *
   * @returns bannerPaddingBottom
   */
  getBannerPaddingBottom(): number | undefined {
    return this.bannerPaddingBottom
  }

  /**
   * 获取bannerPaddingLeft
   *
   * @returns bannerPaddingLeft
   */
  getBannerPaddingLeft(): number | undefined {
    return this.bannerPaddingLeft
  }

  /**
   * 获取bannerPlaceholder
   *
   * @returns bannerPlaceholder
   */
  getBannerPlaceholder(): Resource | undefined {
    return this.bannerPlaceholder
  }
}
