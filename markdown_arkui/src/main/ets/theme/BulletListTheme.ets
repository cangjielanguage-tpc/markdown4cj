import { MarkdownBaseTheme } from './MarkdownBaseTheme'
import { COLOR_FF191919, COLOR_GRAY, isMargin, isPadding } from "../base/Constants"

/**
 * 无序/任务列表样式配置
 */
@Observed
export class BulletListTheme implements MarkdownBaseTheme {
  bulletListBackgroundColor: ResourceColor | undefined = undefined // 无序/任务列表背景颜色
  bulletListMarginTop: Length = 0.0 // 无序/任务列表外边距上
  bulletListMarginRight: Length = 0.0 // 无序/任务列表外边距右
  bulletListMarginBottom: Length = 0.0 // 无序/任务列表外边距下
  bulletListMarginLeft: Length = 8.0 // 无序/任务列表外边距左
  bulletListPaddingTop: Length = 0.0 // 无序/任务列表内边距上
  bulletListPaddingRight: Length = 0.0 // 无序/任务列表内边距右
  bulletListPaddingBottom: Length = 0.0 // 无序/任务列表内边距下
  bulletListPaddingLeft: Length = 0.0 // 无序/任务列表内边距左
  bulletListChildSpacing: number = 8 // 无序/任务列表子项间距
  bulletListChildChildSpacing: number = 8 // 无序/任务列表子子项间距
  bulletListBulletSpacing: number = 8.0 // 无序/任务列表标记间距
  bulletListBulletIsCircle: boolean = false // 无序/任务列表标记是否圆形
  bulletListBulletTextFontColor: ResourceColor = COLOR_FF191919 // 无序/任务列表标记文本字体颜色
  bulletListBulletTextFontSize: number | string | Resource = 4.0 // 无序/任务列表标记文本字体大小
  bulletListBulletTextFontStyle: FontStyle = FontStyle.Normal // 无序/任务列表标记文本字体样式
  bulletListBulletTextFontWeight: number | FontWeight = FontWeight.Normal // 无序/任务列表标记文本字体粗细
  bulletListBulletTextFontFamily: string | Resource = 'HarmonyOS Sans' // 无序/任务列表标记文本字体族
  bulletListBulletTextLineHeight: number | string | Resource = 18.0 // 无序/任务列表标记文本行高
  bulletListCheckboxSpacing: number = 8.0 // 无序/任务列表复选框间距
  bulletListCheckboxWidth: Length = 15.0 // 无序/任务列表复选框宽度
  bulletListCheckboxHeight: Length = 15.0 // 无序/任务列表复选框高度
  bulletListCheckboxSelectedColor: ResourceColor = COLOR_GRAY // 无序/任务列表复选框选中颜色
  bulletListCheckboxShape: CheckBoxShape = CheckBoxShape.ROUNDED_SQUARE // 无序/任务列表复选框形状

  /**
   * 设置无序/任务列表背景颜色
   *
   * @param color 无序/任务列表背景颜色
   * @return BulletListTheme
   */
  setBulletListBackgroundColor(color: ResourceColor): BulletListTheme {
    this.bulletListBackgroundColor = color
    return this
  }

  /**
   * 设置无序/任务列表外边距
   *
   * @param options 无序/任务列表外边距选项或统一数值
   * @return BulletListTheme
   */
  setBulletListMargin(options: Margin | Length): BulletListTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.bulletListMarginTop = options
      this.bulletListMarginRight = options
      this.bulletListMarginBottom = options
      this.bulletListMarginLeft = options
    }
    // 2. 如果是 object，它要么是 Margin，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Margin 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Margin 处理
      if (isMargin(options)) {
        const margin = options as Margin
        if (margin.top !== undefined) {
          this.bulletListMarginTop = margin.top
        }
        if (margin.right !== undefined) {
          this.bulletListMarginRight = margin.right
        }
        if (margin.bottom !== undefined) {
          this.bulletListMarginBottom = margin.bottom
        }
        if (margin.left !== undefined) {
          this.bulletListMarginLeft = margin.left
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.bulletListMarginTop = options as Length
        this.bulletListMarginRight = options as Length
        this.bulletListMarginBottom = options as Length
        this.bulletListMarginLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置无序/任务列表内边距
   *
   * @param options 无序/任务列表内边距选项或统一数值
   * @return BulletListTheme
   */
  setBulletListPadding(options: Padding | Length): BulletListTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.bulletListPaddingTop = options
      this.bulletListPaddingRight = options
      this.bulletListPaddingBottom = options
      this.bulletListPaddingLeft = options
    }
    // 2. 如果是 object，它要么是 Padding，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Padding 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Padding 处理
      if (isPadding(options)) {
        const padding = options as Padding
        if (padding.top !== undefined) {
          this.bulletListPaddingTop = padding.top
        }
        if (padding.right !== undefined) {
          this.bulletListPaddingRight = padding.right
        }
        if (padding.bottom !== undefined) {
          this.bulletListPaddingBottom = padding.bottom
        }
        if (padding.left !== undefined) {
          this.bulletListPaddingLeft = padding.left
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.bulletListPaddingTop = options as Length
        this.bulletListPaddingRight = options as Length
        this.bulletListPaddingBottom = options as Length
        this.bulletListPaddingLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置无序/任务列表子项间距
   *
   * @param spacing 无序/任务列表子项间距
   * @return BulletListTheme
   */
  setBulletListChildSpacing(spacing: number): BulletListTheme {
    this.bulletListChildSpacing = spacing
    return this
  }

  /**
   * 设置无序/任务列表子子项间距
   *
   * @param spacing 无序/任务列表子子项间距
   * @return BulletListTheme
   */
  setBulletListChildChildSpacing(spacing: number): BulletListTheme {
    this.bulletListChildChildSpacing = spacing
    return this
  }

  /**
   * 设置无序/任务列表标记间距
   *
   * @param spacing 无序/任务列表标记间距
   * @return BulletListTheme
   */
  setBulletListBulletSpacing(spacing: number): BulletListTheme {
    this.bulletListBulletSpacing = spacing
    return this
  }

  /**
   * 设置无序/任务列表标记是否圆形
   *
   * @param isCircle 无序/任务列表标记是否圆形
   * @return BulletListTheme
   */
  setBulletListBulletIsCircle(isCircle: boolean): BulletListTheme {
    this.bulletListBulletIsCircle = isCircle
    return this
  }

  /**
   * 设置无序/任务列表标记文本字体颜色
   *
   * @param color 无序/任务列表标记文本字体颜色
   * @return BulletListTheme
   */
  setBulletListBulletTextFontColor(color: ResourceColor): BulletListTheme {
    this.bulletListBulletTextFontColor = color
    return this
  }

  /**
   * 设置无序/任务列表标记文本字体大小
   *
   * @param size 无序/任务列表标记文本字体大小
   * @return BulletListTheme
   */
  setBulletListBulletTextFontSize(size: number | string | Resource): BulletListTheme {
    this.bulletListBulletTextFontSize = size
    return this
  }

  /**
   * 设置无序/任务列表标记文本字体样式
   *
   * @param style 无序/任务列表标记文本字体样式
   * @return BulletListTheme
   */
  setBulletListBulletTextFontStyle(style: FontStyle): BulletListTheme {
    this.bulletListBulletTextFontStyle = style
    return this
  }

  /**
   * 设置无序/任务列表标记文本字体粗细
   *
   * @param weight 无序/任务列表标记文本字体粗细
   * @return BulletListTheme
   */
  setBulletListBulletTextFontWeight(weight: number | FontWeight): BulletListTheme {
    this.bulletListBulletTextFontWeight = weight
    return this
  }

  /**
   * 设置无序/任务列表标记文本字体族
   *
   * @param family 无序/任务列表标记文本字体族
   * @return BulletListTheme
   */
  setBulletListBulletTextFontFamily(family: string | Resource): BulletListTheme {
    this.bulletListBulletTextFontFamily = family
    return this
  }

  /**
   * 设置无序/任务列表标记文本行高
   *
   * @param lineHeight 无序/任务列表标记文本行高
   * @return BulletListTheme
   */
  setBulletListBulletTextLineHeight(lineHeight: number | string | Resource): BulletListTheme {
    this.bulletListBulletTextLineHeight = lineHeight
    return this
  }

  /**
   * 设置无序/任务列表复选框间距
   *
   * @param spacing 无序/任务列表复选框间距
   * @return BulletListTheme
   */
  setBulletListCheckboxSpacing(spacing: number): BulletListTheme {
    this.bulletListCheckboxSpacing = spacing
    return this
  }

  /**
   * 设置无序/任务列表复选框宽度
   *
   * @param width 无序/任务列表复选框宽度
   * @return BulletListTheme
   */
  setBulletListCheckboxWidth(width: Length): BulletListTheme {
    this.bulletListCheckboxWidth = width
    return this
  }

  /**
   * 设置无序/任务列表复选框高度
   *
   * @param height 无序/任务列表复选框高度
   * @return BulletListTheme
   */
  setBulletListCheckboxHeight(height: Length): BulletListTheme {
    this.bulletListCheckboxHeight = height
    return this
  }

  /**
   * 设置无序/任务列表复选框选中颜色
   *
   * @param color 无序/任务列表复选框选中颜色
   * @return BulletListTheme
   */
  setBulletListCheckboxSelectedColor(color: ResourceColor): BulletListTheme {
    this.bulletListCheckboxSelectedColor = color
    return this
  }

  /**
   * 设置无序/任务列表复选框形状
   *
   * @param shape 无序/任务列表复选框形状
   * @return BulletListTheme
   */
  setBulletListCheckboxShape(shape: CheckBoxShape): BulletListTheme {
    this.bulletListCheckboxShape = shape
    return this
  }
}
