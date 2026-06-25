import { isMargin, isPadding } from "../base/Constants";
import { MarkdownBaseTheme } from './MarkdownBaseTheme';

/**
 * Banner样式配置
 */
@Observed
export class BannerTheme implements MarkdownBaseTheme {
  bannerMarginTop: Length = 0.0 // Banner外边距上
  bannerMarginRight: Length = 0.0 // Banner外边距右
  bannerMarginBottom: Length = 0.0 // Banner外边距下
  bannerMarginLeft: Length = 0.0 // Banner外边距左
  bannerPaddingTop: Length = 0.0 // Banner内边距上
  bannerPaddingRight: Length = 0.0 // Banner内边距右
  bannerPaddingBottom: Length = 0.0 // Banner内边距下
  bannerPaddingLeft: Length = 0.0 // Banner内边距左
  bannerPlaceholder: Resource | undefined = undefined // Banner占位图资源
  /**
   * 设置Banner外边距
   *
   * @param options Banner外边距选项或统一数值
   * @return BannerTheme
   */
  setBannerMargin(options: Margin | Length): BannerTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.bannerMarginTop = options;
      this.bannerMarginRight = options;
      this.bannerMarginBottom = options;
      this.bannerMarginLeft = options;
    }
    // 2. 如果是 object，它要么是 Margin，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Margin 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Margin 处理
      if (isMargin(options)) {
        const margin = options as Margin;
        if (margin.top !== undefined) {
          this.bannerMarginTop = margin.top;
        }
        if (margin.right !== undefined) {
          this.bannerMarginRight = margin.right;
        }
        if (margin.bottom !== undefined) {
          this.bannerMarginBottom = margin.bottom;
        }
        if (margin.left !== undefined) {
          this.bannerMarginLeft = margin.left;
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.bannerMarginTop = options as Length;
        this.bannerMarginRight = options as Length;
        this.bannerMarginBottom = options as Length;
        this.bannerMarginLeft = options as Length;
      }
    }
    return this;
  }

  /**
   * 设置Banner内边距
   *
   * @param options Banner内边距选项或统一数值
   * @return BannerTheme
   */
  setBannerPadding(options: Padding | Length): BannerTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.bannerPaddingTop = options;
      this.bannerPaddingRight = options;
      this.bannerPaddingBottom = options;
      this.bannerPaddingLeft = options;
    }
    // 2. 如果是 object，它要么是 Padding，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Padding 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Padding 处理
      if (isPadding(options)) {
        const padding = options as Padding;
        if (padding.top !== undefined) {
          this.bannerPaddingTop = padding.top;
        }
        if (padding.right !== undefined) {
          this.bannerPaddingRight = padding.right;
        }
        if (padding.bottom !== undefined) {
          this.bannerPaddingBottom = padding.bottom;
        }
        if (padding.left !== undefined) {
          this.bannerPaddingLeft = padding.left;
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.bannerPaddingTop = options as Length;
        this.bannerPaddingRight = options as Length;
        this.bannerPaddingBottom = options as Length;
        this.bannerPaddingLeft = options as Length;
      }
    }
    return this;
  }

  /**
   * 设置Banner占位图资源
   *
   * @param resource Banner占位图资源
   * @return BannerTheme
   */
  setBannerPlaceholder(resource: Resource): BannerTheme {
    this.bannerPlaceholder = resource;
    return this;
  }
}