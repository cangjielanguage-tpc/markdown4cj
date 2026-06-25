import { MarkdownBaseTheme } from './MarkdownBaseTheme';
import { COLOR_FFEAEAEA, COLOR_FF191919, isMargin, isPadding, isBorderRadiuses } from "../base/Constants";

/**
 * 块引用样式配置
 */
@Observed
export class BlockQuoteTheme implements MarkdownBaseTheme {
  blockQuoteBackgroundColor: ResourceColor = COLOR_FFEAEAEA // 块引用背景颜色
  blockQuoteMarginTop: Length = 0.0 // 块引用上外边距
  blockQuoteMarginRight: Length = 0.0 // 块引用右外边距
  blockQuoteMarginBottom: Length = 0.0 // 块引用下外边距
  blockQuoteMarginLeft: Length = 8.0 // 块引用左外边距
  blockQuotePaddingTop: Length = 0.0 // 块引用上内边距
  blockQuotePaddingRight: Length = 0.0 // 块引用右内边距
  blockQuotePaddingBottom: Length = 0.0 // 块引用下内边距
  blockQuotePaddingLeft: Length = 8.0 // 块引用左内边距
  blockQuoteRadiusTopLeft: Length = 0.0 // 块引用左上圆角
  blockQuoteRadiusTopRight: Length = 0.0 // 块引用右上圆角
  blockQuoteRadiusBottomLeft: Length = 0.0 // 块引用左下圆角
  blockQuoteRadiusBottomRight: Length = 0.0 // 块引用右下圆角
  blockQuoteLeftBorderWidth: Length = 1.0 // 块引用左边框宽度
  blockQuoteLeftBorderColor: ResourceColor = COLOR_FF191919 // 块引用左边框颜色
  blockQuoteChildSpacing: number = 8 // 块引用子项间距
  /**
   * 设置块引用背景颜色
   *
   * @param color 块引用背景颜色
   * @return BlockQuoteTheme
   */
  setBlockQuoteBackgroundColor(color: ResourceColor): BlockQuoteTheme {
    this.blockQuoteBackgroundColor = color;
    return this;
  }

  /**
   * 设置块引用外边距
   *
   * @param options 块引用外边距选项或统一数值
   * @return BlockQuoteTheme
   */
  setBlockQuoteMargin(options: Margin | Length): BlockQuoteTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.blockQuoteMarginTop = options;
      this.blockQuoteMarginRight = options;
      this.blockQuoteMarginBottom = options;
      this.blockQuoteMarginLeft = options;
    }
    // 2. 如果是 object，它要么是 Margin，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Margin 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Margin 处理
      if (isMargin(options)) {
        const margin = options as Margin;
        if (margin.top !== undefined) {
          this.blockQuoteMarginTop = margin.top;
        }
        if (margin.right !== undefined) {
          this.blockQuoteMarginRight = margin.right;
        }
        if (margin.bottom !== undefined) {
          this.blockQuoteMarginBottom = margin.bottom;
        }
        if (margin.left !== undefined) {
          this.blockQuoteMarginLeft = margin.left;
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.blockQuoteMarginTop = options as Length;
        this.blockQuoteMarginRight = options as Length;
        this.blockQuoteMarginBottom = options as Length;
        this.blockQuoteMarginLeft = options as Length;
      }
    }
    return this;
  }

  /**
   * 设置块引用内边距
   *
   * @param options 块引用内边距选项或统一数值
   * @return BlockQuoteTheme
   */
  setBlockQuotePadding(options: Padding | Length): BlockQuoteTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.blockQuotePaddingTop = options;
      this.blockQuotePaddingRight = options;
      this.blockQuotePaddingBottom = options;
      this.blockQuotePaddingLeft = options;
    }
    // 2. 如果是 object，它要么是 Padding，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Padding 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Padding 处理
      if (isPadding(options)) {
        const padding = options as Padding;
        if (padding.top !== undefined) {
          this.blockQuotePaddingTop = padding.top;
        }
        if (padding.right !== undefined) {
          this.blockQuotePaddingRight = padding.right;
        }
        if (padding.bottom !== undefined) {
          this.blockQuotePaddingBottom = padding.bottom;
        }
        if (padding.left !== undefined) {
          this.blockQuotePaddingLeft = padding.left;
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.blockQuotePaddingTop = options as Length;
        this.blockQuotePaddingRight = options as Length;
        this.blockQuotePaddingBottom = options as Length;
        this.blockQuotePaddingLeft = options as Length;
      }
    }
    return this;
  }

  /**
   * 设置块引用圆角
   *
   * @param options 块引用圆角选项或统一数值
   * @return BlockQuoteTheme
   */
  setBlockQuoteRadius(options: BorderRadiuses | Length): BlockQuoteTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.blockQuoteRadiusTopLeft = options;
      this.blockQuoteRadiusTopRight = options;
      this.blockQuoteRadiusBottomLeft = options;
      this.blockQuoteRadiusBottomRight = options;
    }
    // 2. 如果是 object，它要么是 BorderRadiuses，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 BorderRadiuses 的专属属性来区分
      // 如果包含 topLeft/topRight/bottomLeft/bottomRight 任意一个，就当作 BorderRadiuses 处理
      if (isBorderRadiuses(options)) {
        const radius = options as BorderRadiuses;
        if (radius.topLeft !== undefined) {
          this.blockQuoteRadiusTopLeft = radius.topLeft;
        }
        if (radius.topRight !== undefined) {
          this.blockQuoteRadiusTopRight = radius.topRight;
        }
        if (radius.bottomLeft !== undefined) {
          this.blockQuoteRadiusBottomLeft = radius.bottomLeft;
        }
        if (radius.bottomRight !== undefined) {
          this.blockQuoteRadiusBottomRight = radius.bottomRight;
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.blockQuoteRadiusTopLeft = options as Length;
        this.blockQuoteRadiusTopRight = options as Length;
        this.blockQuoteRadiusBottomLeft = options as Length;
        this.blockQuoteRadiusBottomRight = options as Length;
      }
    }
    return this;
  }

  /**
   * 设置块引用左边框宽度
   *
   * @param width 块引用左边框宽度
   * @return BlockQuoteTheme
   */
  setBlockQuoteLeftBorderWidth(width: Length): BlockQuoteTheme {
    this.blockQuoteLeftBorderWidth = width;
    return this;
  }

  /**
   * 设置块引用左边框颜色
   *
   * @param color 块引用左边框颜色
   * @return BlockQuoteTheme
   */
  setBlockQuoteLeftBorderColor(color: ResourceColor): BlockQuoteTheme {
    this.blockQuoteLeftBorderColor = color;
    return this;
  }

  /**
   * 设置块引用子项间距
   *
   * @param space 块引用子项间距
   * @return BlockQuoteTheme
   */
  setBlockQuoteChildSpacing(space: number): BlockQuoteTheme {
    this.blockQuoteChildSpacing = space;
    return this;
  }
}