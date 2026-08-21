import { MarkdownBaseTheme } from './MarkdownBaseTheme'
import { COLOR_BLACK, COLOR_FFF5F5F5, COLOR_E6000000, isMargin, isBorderRadiuses } from "../base/Constants"

/**
 * 图片样式配置
 */
@Observed
export class ImageTheme implements MarkdownBaseTheme {
  imageMarginTop: Length = 0.0 // 图片上外边距
  imageMarginRight: Length = 0.0 // 图片右外边距
  imageMarginBottom: Length = 0.0 // 图片下外边距
  imageMarginLeft: Length = 0.0 // 图片左外边距
  imageRadiusTopLeft: Length = 0.0 // 图片左上圆角
  imageRadiusTopRight: Length = 0.0 // 图片右上圆角
  imageRadiusBottomLeft: Length = 0.0 // 图片左下圆角
  imageRadiusBottomRight: Length = 0.0 // 图片右下圆角
  imageBorderStyle: BorderStyle = BorderStyle.Solid // 图片边框样式
  imageBorderWidth: Length = 0.0 // 图片边框宽度
  imageBorderColor: ResourceColor = COLOR_BLACK // 图片边框颜色
  imagePlaceholder: Resource | undefined = undefined // 图片占位图
  imageAutoResize: boolean = true // 图片是否自动调整大小
  isImageMixedLayout: boolean = true // 图片是否混合布局
  imageMaximumWidth: number = 1.0 // 图片基于自身宽度缩放百分比
  imageFixedRatioWidth: number | undefined = undefined // 图片基于父布局宽度缩放百分比
  imageMaxHeight: number | undefined = undefined // 图片最大高度（vp）
  imageHeight: number | undefined = undefined // 图片高度（vp）
  imageMaxWidth: number | undefined = undefined // 图片最大宽度（vp）
  imageWidth: number | undefined = undefined // 图片宽度（vp）
  imageFitType: ImageFit = ImageFit.Contain // 图片适应类型
  imageBottomLayoutMarginTop: Length = 14.0 // 图片底部布局上外边距
  imageDownloadButtonVisible: boolean = false // 是否图片下载按钮可见
  imageDownloadButtonWidth: Length = 296.0 // 图片下载按钮宽度
  imageDownloadButtonHeight: Length = 44.0 // 图片下载按钮高度
  imageDownloadButtonRadiusTopLeft: Length = 22.0 // 图片下载按钮左上圆角
  imageDownloadButtonRadiusTopRight: Length = 22.0 // 图片下载按钮右上圆角
  imageDownloadButtonRadiusBottomLeft: Length = 22.0 // 图片下载按钮左下圆角
  imageDownloadButtonRadiusBottomRight: Length = 22.0 // 图片下载按钮右下圆角
  imageDownloadButtonIconTextGap: number = 6.0 // 图片下载按钮图标与文本间距
  imageDownloadButtonIcon: Resource | undefined = undefined // 图片下载按钮图标资源
  imageDownloadButtonIconWidth: Length = 18.0 // 图片下载按钮图标宽度
  imageDownloadButtonIconHeight: Length = 18.0 // 图片下载按钮图标高度
  imageDownloadButtonBackgroundColor: ResourceColor = COLOR_FFF5F5F5 // 图片下载按钮背景颜色
  imageDownloadButtonText: string = '下载图片' // 图片下载按钮文本
  imageDownloadButtonTextFontColor: ResourceColor = COLOR_E6000000 // 图片下载按钮文本字体颜色
  imageDownloadButtonTextFontSize: number | string | Resource = 16.0 // 图片下载按钮文本字体大小
  imageDownloadButtonTextFontStyle: FontStyle = FontStyle.Normal // 图片下载按钮文本字体样式
  imageDownloadButtonTextFontWeight: number | FontWeight = FontWeight.Medium // 图片下载按钮文本字体粗细
  imageDownloadButtonTextFontFamily: string | Resource = 'HarmonyOS Sans' // 图片下载按钮文本字体族
  imageDownloadButtonTextLineHeight: number | string | Resource = 22.0 // 图片下载按钮文本行高

  /**
   * 设置图片边距
   *
   * @param options 边距选项
   * @return ImageTheme
   */
  setImageMargin(options: Margin | Length): ImageTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.imageMarginTop = options
      this.imageMarginRight = options
      this.imageMarginBottom = options
      this.imageMarginLeft = options
    }
    // 2. 如果是 object，它要么是 Margin，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Margin 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Margin 处理
      if (isMargin(options)) {
        const margin = options as Margin
        if (margin.top !== undefined) {
          this.imageMarginTop = margin.top
        }
        if (margin.right !== undefined) {
          this.imageMarginRight = margin.right
        }
        if (margin.bottom !== undefined) {
          this.imageMarginBottom = margin.bottom
        }
        if (margin.left !== undefined) {
          this.imageMarginLeft = margin.left
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.imageMarginTop = options as Length
        this.imageMarginRight = options as Length
        this.imageMarginBottom = options as Length
        this.imageMarginLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置图片圆角
   *
   * @param options 圆角选项
   * @return ImageTheme
   */
  setImageBorderRadius(options: BorderRadiuses | Length): ImageTheme {
    // 1. 如果是 number 或 string，直接四角统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.imageRadiusTopLeft = options
      this.imageRadiusTopRight = options
      this.imageRadiusBottomLeft = options
      this.imageRadiusBottomRight = options
    }
    // 2. 如果是 object，它要么是 BorderRadiuses，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 BorderRadiuses 的专属属性来区分
      // 如果包含 topLeft/topRight/bottomLeft/bottomRight 任意一个，就当作 BorderRadiuses 处理
      if (isBorderRadiuses(options)) {
        const radius = options as BorderRadiuses
        if (radius.topLeft !== undefined) {
          this.imageRadiusTopLeft = radius.topLeft
        }
        if (radius.topRight !== undefined) {
          this.imageRadiusTopRight = radius.topRight
        }
        if (radius.bottomLeft !== undefined) {
          this.imageRadiusBottomLeft = radius.bottomLeft
        }
        if (radius.bottomRight !== undefined) {
          this.imageRadiusBottomRight = radius.bottomRight
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.imageRadiusTopLeft = options as Length
        this.imageRadiusTopRight = options as Length
        this.imageRadiusBottomLeft = options as Length
        this.imageRadiusBottomRight = options as Length
      }
    }
    return this
  }

  /**
   * 设置图片边框样式
   *
   * @param borderStyle 边框样式
   * @return ImageTheme
   */
  setImageBorderStyle(borderStyle: BorderStyle): ImageTheme {
    this.imageBorderStyle = borderStyle
    return this
  }

  /**
   * 设置图片边框宽度
   *
   * @param borderWidth 边框宽度
   * @return ImageTheme
   */
  setImageBorderWidth(borderWidth: Length): ImageTheme {
    this.imageBorderWidth = borderWidth
    return this
  }

  /**
   * 设置图片边框颜色
   *
   * @param borderColor 边框颜色
   * @return ImageTheme
   */
  setImageBorderColor(borderColor: ResourceColor): ImageTheme {
    this.imageBorderColor = borderColor
    return this
  }

  /**
   * 设置图片占位图
   *
   * @param placeholder 占位图资源
   * @return ImageTheme
   */
  setImagePlaceholder(placeholder: Resource): ImageTheme {
    this.imagePlaceholder = placeholder
    return this
  }

  /**
   * 设置图片自动调整大小
   *
   * @param imageAutoResize 是否自动调整大小
   * @return ImageTheme
   */
  setImageAutoResize(imageAutoResize: boolean): ImageTheme {
    this.imageAutoResize = imageAutoResize
    return this
  }

  /**
   * 设置图片混合布局
   *
   * @param mixedLayout 是否混合布局
   * @return ImageTheme
   */
  setIsImageMixedLayout(mixedLayout: boolean): ImageTheme {
    this.isImageMixedLayout = mixedLayout
    return this
  }

  /**
   * 设置图片最大宽度比例
   *
   * @param maximumWidth 最大宽度比例
   * @return ImageTheme
   */
  setImageMaximumWidth(maximumWidth: number): ImageTheme {
    this.imageMaximumWidth = maximumWidth
    return this
  }

  /**
   * 设置图片固定比例宽度
   *
   * @param fixedRatioWidth 固定比例宽度
   * @return ImageTheme
   */
  setImageFixedRatioWidth(fixedRatioWidth: number): ImageTheme {
    this.imageFixedRatioWidth = fixedRatioWidth
    return this
  }

  /**
   * 设置图片最大高度
   *
   * @param maxHeight 最大高度
   * @return ImageTheme
   */
  setImageMaxHeight(maxHeight: number): ImageTheme {
    this.imageMaxHeight = maxHeight
    return this
  }

  /**
   * 设置图片高度
   *
   * @param height 高度
   * @return ImageTheme
   */
  setImageHeight(height: number): ImageTheme {
    this.imageHeight = height
    return this
  }

  /**
   * 设置图片最大宽度
   *
   * @param maxWidth 最大宽度
   * @return ImageTheme
   */
  setImageMaxWidth(maxWidth: number): ImageTheme {
    this.imageMaxWidth = maxWidth
    return this
  }

  /**
   * 设置图片宽度
   *
   * @param width 宽度
   * @return ImageTheme
   */
  setImageWidth(width: number): ImageTheme {
    this.imageWidth = width
    return this
  }

  /**
   * 设置图片填充类型
   *
   * @param fitType 填充类型
   * @return ImageTheme
   */
  setImageFitType(fitType: ImageFit): ImageTheme {
    this.imageFitType = fitType
    return this
  }

  /**
   * 设置图片底部布局上边距
   *
   * @param marginTop 上边距
   * @return ImageTheme
   */
  setImageBottomLayoutMarginTop(marginTop: Length): ImageTheme {
    this.imageBottomLayoutMarginTop = marginTop
    return this
  }

  /**
   * 设置图片下载按钮可见性
   *
   * @param visible 是否可见
   * @return ImageTheme
   */
  setImageDownloadButtonVisible(visible: boolean): ImageTheme {
    this.imageDownloadButtonVisible = visible
    return this
  }

  /**
   * 设置图片下载按钮宽度
   *
   * @param width 宽度
   * @return ImageTheme
   */
  setImageDownloadButtonWidth(width: Length): ImageTheme {
    this.imageDownloadButtonWidth = width
    return this
  }

  /**
   * 设置图片下载按钮高度
   *
   * @param height 高度
   * @return ImageTheme
   */
  setImageDownloadButtonHeight(height: Length): ImageTheme {
    this.imageDownloadButtonHeight = height
    return this
  }

  /**
   * 设置图片下载按钮圆角
   *
   * @param options 圆角选项
   * @return ImageTheme
   */
  setImageDownloadButtonRadius(options: BorderRadiuses | Length): ImageTheme {
    // 1. 如果是 number 或 string，直接四角统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.imageDownloadButtonRadiusTopLeft = options
      this.imageDownloadButtonRadiusTopRight = options
      this.imageDownloadButtonRadiusBottomLeft = options
      this.imageDownloadButtonRadiusBottomRight = options
    }
    // 2. 如果是 object，它要么是 BorderRadiuses，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 BorderRadiuses 的专属属性来区分
      // 如果包含 topLeft/topRight/bottomLeft/bottomRight 任意一个，就当作 BorderRadiuses 处理
      if (isBorderRadiuses(options)) {
        const radius = options as BorderRadiuses
        if (radius.topLeft !== undefined) {
          this.imageDownloadButtonRadiusTopLeft = radius.topLeft
        }
        if (radius.topRight !== undefined) {
          this.imageDownloadButtonRadiusTopRight = radius.topRight
        }
        if (radius.bottomLeft !== undefined) {
          this.imageDownloadButtonRadiusBottomLeft = radius.bottomLeft
        }
        if (radius.bottomRight !== undefined) {
          this.imageDownloadButtonRadiusBottomRight = radius.bottomRight
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.imageDownloadButtonRadiusTopLeft = options as Length
        this.imageDownloadButtonRadiusTopRight = options as Length
        this.imageDownloadButtonRadiusBottomLeft = options as Length
        this.imageDownloadButtonRadiusBottomRight = options as Length
      }
    }
    return this
  }

  /**
   * 设置图片下载按钮图标文本间距
   *
   * @param iconTextGap 图标文本间距
   * @return ImageTheme
   */
  setImageDownloadButtonIconTextGap(iconTextGap: number): ImageTheme {
    this.imageDownloadButtonIconTextGap = iconTextGap
    return this
  }

  /**
   * 设置图片下载按钮图标
   *
   * @param icon 图标资源
   * @return ImageTheme
   */
  setImageDownloadButtonIcon(icon: Resource): ImageTheme {
    this.imageDownloadButtonIcon = icon
    return this
  }

  /**
   * 设置图片下载按钮图标宽度
   *
   * @param width 宽度
   * @return ImageTheme
   */
  setImageDownloadButtonIconWidth(width: Length): ImageTheme {
    this.imageDownloadButtonIconWidth = width
    return this
  }

  /**
   * 设置图片下载按钮图标高度
   *
   * @param height 高度
   * @return ImageTheme
   */
  setImageDownloadButtonIconHeight(height: Length): ImageTheme {
    this.imageDownloadButtonIconHeight = height
    return this
  }

  /**
   * 设置图片下载按钮背景颜色
   *
   * @param color 背景颜色
   * @return ImageTheme
   */
  setImageDownloadButtonBackgroundColor(color: ResourceColor): ImageTheme {
    this.imageDownloadButtonBackgroundColor = color
    return this
  }

  /**
   * 设置图片下载按钮文本
   *
   * @param text 文本
   * @return ImageTheme
   */
  setImageDownloadButtonText(text: string): ImageTheme {
    this.imageDownloadButtonText = text
    return this
  }

  /**
   * 设置图片下载按钮文本字体颜色
   *
   * @param color 字体颜色
   * @return ImageTheme
   */
  setImageDownloadButtonTextFontColor(color: ResourceColor): ImageTheme {
    this.imageDownloadButtonTextFontColor = color
    return this
  }

  /**
   * 设置图片下载按钮文本字体大小
   *
   * @param size 字体大小
   * @return ImageTheme
   */
  setImageDownloadButtonTextFontSize(size: number | string | Resource): ImageTheme {
    this.imageDownloadButtonTextFontSize = size
    return this
  }

  /**
   * 设置图片下载按钮文本字体样式
   *
   * @param style 字体样式
   * @return ImageTheme
   */
  setImageDownloadButtonTextFontStyle(style: FontStyle): ImageTheme {
    this.imageDownloadButtonTextFontStyle = style
    return this
  }

  /**
   * 设置图片下载按钮文本字体粗细
   *
   * @param weight 字体粗细
   * @return ImageTheme
   */
  setImageDownloadButtonTextFontWeight(weight: number | FontWeight): ImageTheme {
    this.imageDownloadButtonTextFontWeight = weight
    return this
  }

  /**
   * 设置图片下载按钮文本字体族
   *
   * @param family 字体族
   * @return ImageTheme
   */
  setImageDownloadButtonTextFontFamily(family: string | Resource): ImageTheme {
    this.imageDownloadButtonTextFontFamily = family
    return this
  }

  /**
   * 设置图片下载按钮文本行高
   *
   * @param lineHeight 行高
   * @return ImageTheme
   */
  setImageDownloadButtonTextLineHeight(lineHeight: number | string | Resource): ImageTheme {
    this.imageDownloadButtonTextLineHeight = lineHeight
    return this
  }
}
