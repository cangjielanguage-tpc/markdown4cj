import { MarkdownBaseTheme } from './MarkdownBaseTheme'
import { COLOR_RED, COLOR_TRANSPARENT, COLOR_BLACK, COLOR_WHITE, isBorderRadiuses } from "../base/Constants"

/**
 * 链接样式配置
 */
@Observed
export class LinkTheme implements MarkdownBaseTheme {
  linkIsIcon: boolean = false // 链接是否图标显示
  linkListIsIcon: boolean = false // 列表中链接是否图标显示
  linkTextFontColor: ResourceColor = COLOR_RED // 链接文本字体颜色
  linkTextFontSize: number | string | Resource | undefined = undefined // 链接文本字体大小
  linkTextFontStyle: FontStyle | undefined = undefined // 链接文本字体样式
  linkTextFontWeight: number | FontWeight | undefined = undefined // 链接文本字体粗细
  linkTextFontFamily: string | Resource | undefined = undefined // 链接文本字体族
  linkTextLineHeight: number | string | Resource | undefined = undefined // 链接文本行高
  linkTextLetterSpacing: number | undefined = undefined // 链接文本字间距
  linkTextDecorationType: TextDecorationType = TextDecorationType.Underline // 链接文本装饰类型
  linkTextDecorationColor: ResourceColor = COLOR_RED // 链接文本装饰颜色
  linkTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID // 链接文本装饰样式
  linkTextBackgroundColor: ResourceColor = COLOR_TRANSPARENT // 链接文本背景颜色
  linkTextBackgroundRadiusTopLeft: Length = 0.0 // 链接文本背景左上圆角
  linkTextBackgroundRadiusTopRight: Length = 0.0 // 链接文本背景右上圆角
  linkTextBackgroundRadiusBottomLeft: Length = 0.0 // 链接文本背景左下圆角
  linkTextBackgroundRadiusBottomRight: Length = 0.0 // 链接文本背景右下圆角
  linkCircleIconBackgroundColor: ResourceColor = COLOR_TRANSPARENT // 链接圆形图标背景颜色
  linkCircleIconButtonBackgroundColor: ResourceColor = COLOR_BLACK // 链接圆形图标按钮背景颜色
  linkCircleIconTextSize: number = 14.0 // 链接圆形图标文本大小
  linkCircleIconTextColor: ResourceColor = COLOR_WHITE // 链接圆形图标文本颜色
  linkCircleIconRadius: number = 20.0 // 链接圆形图标半径
  linkCircleIconMargin: number = 6.0 // 链接圆形图标外边距
  linkRectIconBackgroundColor: ResourceColor = COLOR_TRANSPARENT // 链接方形图标背景颜色
  linkRectIconButtonBackgroundColor: ResourceColor = COLOR_BLACK // 链接方形图标按钮背景颜色
  linkRectIconTextSize: number = 14.0 // 链接方形图标文本大小
  linkRectIconTextColor: ResourceColor = COLOR_WHITE // 链接方形图标文本颜色
  linkRectIconHeight: Length = 20.0 // 链接方形图标高度
  linkRectIconPadding: number = 6.0 // 链接方形图标内边距
  linkRectIconRadius: number = 6.0 // 链接方形图标圆角
  linkRectIconMargin: number = 6.0 // 链接方形图标外边距
  linkRectToolIconBackgroundColor: ResourceColor = COLOR_TRANSPARENT // 链接空心方形图标背景颜色
  linkRectToolIconButtonBackgroundColor: ResourceColor = COLOR_WHITE // 链接空心方形图标按钮背景颜色
  linkRectToolIconTextSize: number = 14.0 // 链接空心方形图标文本大小
  linkRectToolIconHeight: Length = 21.0 // 链接空心方形图标高度
  linkRectToolIconPadding: number = 6.0 // 链接空心方形图标内边距
  linkRectToolIconBorderWidth: Length = 1.0 // 链接空心方形图标边框宽度
  linkRectToolIconDividingLineWidth: Length = 1.0 // 链接空心方形图标分割线宽度
  linkRectToolIconMargin: number = 6.0 // 链接空心方形图标外边距
  linkRectToolIconLineLeftPadding: number = 3.0 // 链接空心方形图标分割线左内边距
  linkRectToolIconLineRightPadding: number = 3.0 // 链接空心方形图标分割线右内边距

  /**
   * 设置链接是否图标显示
   *
   * @param isIcon 链接是否图标显示
   * @return LinkTheme
   */
  setLinkIsIcon(isIcon: boolean): LinkTheme {
    this.linkIsIcon = isIcon
    return this
  }

  /**
   * 设置列表中链接是否图标显示
   *
   * @param isIcon 列表中链接是否图标显示
   * @return LinkTheme
   */
  setLinkListIsIcon(isIcon: boolean): LinkTheme {
    this.linkListIsIcon = isIcon
    return this
  }

  /**
   * 设置链接文本字体颜色
   *
   * @param color 链接文本字体颜色
   * @return LinkTheme
   */
  setLinkTextFontColor(color: ResourceColor): LinkTheme {
    this.linkTextFontColor = color
    return this
  }

  /**
   * 设置链接文本字体大小
   *
   * @param size 链接文本字体大小
   * @return LinkTheme
   */
  setLinkTextFontSize(size: number | string | Resource | undefined): LinkTheme {
    this.linkTextFontSize = size
    return this
  }

  /**
   * 设置链接文本字体样式
   *
   * @param style 链接文本字体样式
   * @return LinkTheme
   */
  setLinkTextFontStyle(style: FontStyle): LinkTheme {
    this.linkTextFontStyle = style
    return this
  }

  /**
   * 设置链接文本字体粗细
   *
   * @param weight 链接文本字体粗细
   * @return LinkTheme
   */
  setLinkTextFontWeight(weight: number | FontWeight): LinkTheme {
    this.linkTextFontWeight = weight
    return this
  }

  /**
   * 设置链接文本字体族
   *
   * @param family 链接文本字体族
   * @return LinkTheme
   */
  setLinkTextFontFamily(family: string | Resource): LinkTheme {
    this.linkTextFontFamily = family
    return this
  }

  /**
   * 设置链接文本行高
   *
   * @param lineHeight 链接文本行高
   * @return LinkTheme
   */
  setLinkTextLineHeight(lineHeight: number | string | Resource): LinkTheme {
    this.linkTextLineHeight = lineHeight
    return this
  }

  /**
   * 设置链接文本字间距
   *
   * @param spacing 链接文本字间距
   * @return LinkTheme
   */
  setLinkTextLetterSpacing(spacing: number): LinkTheme {
    this.linkTextLetterSpacing = spacing
    return this
  }

  /**
   * 设置链接文本装饰类型
   *
   * @param decorationType 链接文本装饰类型
   * @return LinkTheme
   */
  setLinkTextDecorationType(decorationType: TextDecorationType): LinkTheme {
    this.linkTextDecorationType = decorationType
    return this
  }

  /**
   * 设置链接文本装饰颜色
   *
   * @param color 链接文本装饰颜色
   * @return LinkTheme
   */
  setLinkTextDecorationColor(color: ResourceColor): LinkTheme {
    this.linkTextDecorationColor = color
    return this
  }

  /**
   * 设置链接文本装饰样式
   *
   * @param style 链接文本装饰样式
   * @return LinkTheme
   */
  setLinkTextDecorationStyle(style: TextDecorationStyle): LinkTheme {
    this.linkTextDecorationStyle = style
    return this
  }

  /**
   * 设置链接文本背景颜色
   *
   * @param color 链接文本背景颜色
   * @return LinkTheme
   */
  setLinkTextBackgroundColor(color: ResourceColor): LinkTheme {
    this.linkTextBackgroundColor = color
    return this
  }

  /**
   * 设置链接文本背景圆角
   *
   * @param options 链接文本背景圆角选项或统一数值
   * @return LinkTheme
   */
  setLinkTextBackgroundRadius(options: BorderRadiuses | Length): LinkTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.linkTextBackgroundRadiusTopLeft = options
      this.linkTextBackgroundRadiusTopRight = options
      this.linkTextBackgroundRadiusBottomLeft = options
      this.linkTextBackgroundRadiusBottomRight = options
    }
    // 2. 如果是 object，它要么是 BorderRadiuses，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 BorderRadiuses 的专属属性来区分
      // 如果包含 topLeft/topRight/bottomLeft/bottomRight 任意一个，就当作 BorderRadiuses 处理
      if (isBorderRadiuses(options)) {
        // 这里通过类型守卫，编译器已经知道它是 BorderRadiuses 了
        const radius = options as BorderRadiuses
        if (radius.topLeft !== undefined) {
          this.linkTextBackgroundRadiusTopLeft = radius.topLeft
        }
        if (radius.topRight !== undefined) {
          this.linkTextBackgroundRadiusTopRight = radius.topRight
        }
        if (radius.bottomLeft !== undefined) {
          this.linkTextBackgroundRadiusBottomLeft = radius.bottomLeft
        }
        if (radius.bottomRight !== undefined) {
          this.linkTextBackgroundRadiusBottomRight = radius.bottomRight
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.linkTextBackgroundRadiusTopLeft = options as Length
        this.linkTextBackgroundRadiusTopRight = options as Length
        this.linkTextBackgroundRadiusBottomLeft = options as Length
        this.linkTextBackgroundRadiusBottomRight = options as Length
      }
    }
    return this
  }

  /**
   * 设置链接圆形图标背景颜色
   *
   * @param color 链接圆形图标背景颜色
   * @return LinkTheme
   */
  setLinkCircleIconBackgroundColor(color: ResourceColor): LinkTheme {
    this.linkCircleIconBackgroundColor = color
    return this
  }

  /**
   * 设置链接圆形图标按钮背景颜色
   *
   * @param color 链接圆形图标按钮背景颜色
   * @return LinkTheme
   */
  setLinkCircleIconButtonBackgroundColor(color: ResourceColor): LinkTheme {
    this.linkCircleIconButtonBackgroundColor = color
    return this
  }

  /**
   * 设置链接圆形图标文本大小
   *
   * @param size 链接圆形图标文本大小
   * @return LinkTheme
   */
  setLinkCircleIconTextSize(size: number): LinkTheme {
    this.linkCircleIconTextSize = size
    return this
  }

  /**
   * 设置链接圆形图标文本颜色
   *
   * @param color 链接圆形图标文本颜色
   * @return LinkTheme
   */
  setLinkCircleIconTextColor(color: ResourceColor): LinkTheme {
    this.linkCircleIconTextColor = color
    return this
  }

  /**
   * 设置链接圆形图标半径
   *
   * @param radius 链接圆形图标半径
   * @return LinkTheme
   */
  setLinkCircleIconRadius(radius: number): LinkTheme {
    this.linkCircleIconRadius = radius
    return this
  }

  /**
   * 设置链接圆形图标外边距
   *
   * @param margin 链接圆形图标外边距
   * @return LinkTheme
   */
  setLinkCircleIconMargin(margin: number): LinkTheme {
    this.linkCircleIconMargin = margin
    return this
  }

  /**
   * 设置链接方形图标背景颜色
   *
   * @param color 链接方形图标背景颜色
   * @return LinkTheme
   */
  setLinkRectIconBackgroundColor(color: ResourceColor): LinkTheme {
    this.linkRectIconBackgroundColor = color
    return this
  }

  /**
   * 设置链接方形图标按钮背景颜色
   *
   * @param color 链接方形图标按钮背景颜色
   * @return LinkTheme
   */
  setLinkRectIconButtonBackgroundColor(color: ResourceColor): LinkTheme {
    this.linkRectIconButtonBackgroundColor = color
    return this
  }

  /**
   * 设置链接方形图标文本大小
   *
   * @param size 链接方形图标文本大小
   * @return LinkTheme
   */
  setLinkRectIconTextSize(size: number): LinkTheme {
    this.linkRectIconTextSize = size
    return this
  }

  /**
   * 设置链接方形图标文本颜色
   *
   * @param color 链接方形图标文本颜色
   * @return LinkTheme
   */
  setLinkRectIconTextColor(color: ResourceColor): LinkTheme {
    this.linkRectIconTextColor = color
    return this
  }

  /**
   * 设置链接方形图标高度
   *
   * @param height 链接方形图标高度
   * @return LinkTheme
   */
  setLinkRectIconHeight(height: Length): LinkTheme {
    this.linkRectIconHeight = height
    return this
  }

  /**
   * 设置链接方形图标内边距
   *
   * @param padding 链接方形图标内边距
   * @return LinkTheme
   */
  setLinkRectIconPadding(padding: number): LinkTheme {
    this.linkRectIconPadding = padding
    return this
  }

  /**
   * 设置链接方形图标圆角
   *
   * @param radius 链接方形图标圆角
   * @return LinkTheme
   */
  setLinkRectIconRadius(radius: number): LinkTheme {
    this.linkRectIconRadius = radius
    return this
  }

  /**
   * 设置链接方形图标外边距
   *
   * @param margin 链接方形图标外边距
   * @return LinkTheme
   */
  setLinkRectIconMargin(margin: number): LinkTheme {
    this.linkRectIconMargin = margin
    return this
  }

  /**
   * 设置链接空心方形图标背景颜色
   *
   * @param color 链接空心方形图标背景颜色
   * @return LinkTheme
   */
  setLinkRectToolIconBackgroundColor(color: ResourceColor): LinkTheme {
    this.linkRectToolIconBackgroundColor = color
    return this
  }

  /**
   * 设置链接空心方形图标按钮背景颜色
   *
   * @param color 链接空心方形图标按钮背景颜色
   * @return LinkTheme
   */
  setLinkRectToolIconButtonBackgroundColor(color: ResourceColor): LinkTheme {
    this.linkRectToolIconButtonBackgroundColor = color
    return this
  }

  /**
   * 设置链接空心方形图标文本大小
   *
   * @param size 链接空心方形图标文本大小
   * @return LinkTheme
   */
  setLinkRectToolIconTextSize(size: number): LinkTheme {
    this.linkRectToolIconTextSize = size
    return this
  }

  /**
   * 设置链接空心方形图标高度
   *
   * @param height 链接空心方形图标高度
   * @return LinkTheme
   */
  setLinkRectToolIconHeight(height: Length): LinkTheme {
    this.linkRectToolIconHeight = height
    return this
  }

  /**
   * 设置链接空心方形图标内边距
   *
   * @param padding 链接空心方形图标内边距
   * @return LinkTheme
   */
  setLinkRectToolIconPadding(padding: number): LinkTheme {
    this.linkRectToolIconPadding = padding
    return this
  }

  /**
   * 设置链接空心方形图标边框宽度
   *
   * @param width 链接空心方形图标边框宽度
   * @return LinkTheme
   */
  setLinkRectToolIconBorderWidth(width: Length): LinkTheme {
    this.linkRectToolIconBorderWidth = width
    return this
  }

  /**
   * 设置链接空心方形图标分割线宽度
   *
   * @param width 链接空心方形图标分割线宽度
   * @return LinkTheme
   */
  setLinkRectToolIconDividingLineWidth(width: Length): LinkTheme {
    this.linkRectToolIconDividingLineWidth = width
    return this
  }

  /**
   * 设置链接空心方形图标外边距
   *
   * @param margin 链接空心方形图标外边距
   * @return LinkTheme
   */
  setLinkRectToolIconMargin(margin: number): LinkTheme {
    this.linkRectToolIconMargin = margin
    return this
  }

  /**
   * 设置链接空心方形图标分割线左内边距
   *
   * @param padding 链接空心方形图标分割线左内边距
   * @return LinkTheme
   */
  setLinkRectToolIconLineLeftPadding(padding: number): LinkTheme {
    this.linkRectToolIconLineLeftPadding = padding
    return this
  }

  /**
   * 设置链接空心方形图标分割线右内边距
   *
   * @param padding 链接空心方形图标分割线右内边距
   * @return LinkTheme
   */
  setLinkRectToolIconLineRightPadding(padding: number): LinkTheme {
    this.linkRectToolIconLineRightPadding = padding
    return this
  }
}
