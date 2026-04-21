/**
 * Markdown用户可设置的样式-Banner样式
 */
export class MarkdownThemeBanner {
  /**
   * banner上外边距
   */
  bannerMarginTop?: number = undefined

  /**
   * banner右外边距
   */
  bannerMarginRight?: number = undefined

  /**
   * banner下外边距
   */
  bannerMarginBottom?: number = undefined

  /**
   * banner左外边距
   */
  bannerMarginLeft?: number = undefined

  /**
   * banner上内边距
   */
  bannerPaddingTop?: number = undefined

  /**
   * banner右内边距
   */
  bannerPaddingRight?: number = undefined

  /**
   * banner下内边距
   */
  bannerPaddingBottom?: number = undefined

  /**
   * banner左内边距
   */
  bannerPaddingLeft?: number = undefined

  /**
   * banner占位图
   */
  bannerPlaceholder?: Resource = undefined

  /**
   * banner整体外边距
   *
   * @param margin 外边距
   */
  setBannerAllMargin(margin: number): void {
    this.bannerMarginTop = margin
    this.bannerMarginRight = margin
    this.bannerMarginBottom = margin
    this.bannerMarginLeft = margin
  }

  /**
   * banner分别设置四个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setBannerMargin(top?: number, right?: number, bottom?: number, left?: number): void {
    this.bannerMarginTop = top
    this.bannerMarginRight = right
    this.bannerMarginBottom = bottom
    this.bannerMarginLeft = left
  }

  /**
   * banner整体内边距
   *
   * @param padding 内边距
   */
  setBannerAllPadding(padding: number): void {
    this.bannerPaddingTop = padding
    this.bannerPaddingRight = padding
    this.bannerPaddingBottom = padding
    this.bannerPaddingLeft = padding
  }

  /**
   * banner分别设置四个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setBannerPadding(top?: number, right?: number, bottom?: number, left?: number): void {
    this.bannerPaddingTop = top
    this.bannerPaddingRight = right
    this.bannerPaddingBottom = bottom
    this.bannerPaddingLeft = left
  }

  /**
   * 设置banner占位图
   *
   * @param resource banner占位图
   */
  setBannerPlaceholder(resource: Resource): void {
    this.bannerPlaceholder = resource
  }
}
