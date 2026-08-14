import { MarkdownBaseTheme } from './MarkdownBaseTheme'
import {
  COLOR_TRANSPARENT,
  COLOR_WHITE,
  COLOR_FFF5F5F5,
  COLOR_E6000000,
  isMargin,
  isBorderRadiuses,
  isPadding
} from "../base/Constants"

/**
 * 视频样式配置
 */
@Observed
export class VideoTheme implements MarkdownBaseTheme {
  videoBackgroundColor: ResourceColor = COLOR_TRANSPARENT // 视频块背景颜色
  videoMarginTop: Length = 0.0 // 视频块上外边距
  videoMarginRight: Length = 0.0 // 视频块右外边距
  videoMarginBottom: Length = 0.0 // 视频块下外边距
  videoMarginLeft: Length = 0.0 // 视频块左外边距
  videoPaddingTop: Length = 0.0 // 视频块上内边距
  videoPaddingRight: Length = 0.0 // 视频块右内边距
  videoPaddingBottom: Length = 0.0 // 视频块下内边距
  videoPaddingLeft: Length = 0.0 // 视频块左内边距
  videoRadiusTopLeft: Length = 10.0 // 视频块左上圆角
  videoRadiusTopRight: Length = 10.0 // 视频块右上圆角
  videoRadiusBottomLeft: Length = 10.0 // 视频块左下圆角
  videoRadiusBottomRight: Length = 10.0 // 视频块右下圆角
  videoBorderStyle: BorderStyle = BorderStyle.Solid // 视频块边框样式
  videoBorderWidth: Length = 0.0 // 视频块边框宽度
  videoBorderColor: ResourceColor = COLOR_TRANSPARENT // 视频块边框颜色
  videoPlaceholder: Resource | undefined = undefined // 视频占位图资源
  videoImageFitType: ImageFit = ImageFit.Cover // 视频适应类型
  videoPlayIcon: Resource | undefined = undefined // 视频播放图标资源
  videoPlayIconWidth: Length = 60.0 // 视频播放图标宽度
  videoPlayIconHeight: Length = 60.0 // 视频播放图标高度
  videoPlayIconFitType: ImageFit = ImageFit.Contain // 视频播放图标适应类型
  videoTimeTextFontColor: ResourceColor = COLOR_WHITE // 视频时间文本字体颜色
  videoTimeTextFontSize: number | string | Resource = 14.0 // 视频时间文本字体大小
  videoTimeTextFontStyle: FontStyle = FontStyle.Normal // 视频时间文本字体样式
  videoTimeTextFontWeight: number | FontWeight = FontWeight.Normal // 视频时间文本字体粗细
  videoTimeTextFontFamily: string | Resource = 'HarmonyOS Sans' // 视频时间文本字体族
  videoTimeTextLineHeight: number | string | Resource = 22.0 // 视频时间文本行高
  videoTimeTextMarginRight: Length = 10.0 // 视频时间文本右外边距
  videoTimeTextMarginBottom: Length = 10.0 // 视频时间文本下外边距
  videoBottomLayoutVisible: boolean = false // 是否视频底部布局可见
  videoBottomLayoutMarginTop: Length = 14.0 // 视频底部布局上外边距
  videoReleaseButtonVisible: boolean = true // 是否视频发布按钮可见
  videoReleaseButtonBackgroundColor: ResourceColor = COLOR_FFF5F5F5 // 视频发布按钮背景颜色
  videoReleaseButtonWidth: Length = 144.0 // 视频发布按钮宽度
  videoReleaseButtonHeight: Length = 44.0 // 视频发布按钮高度
  videoReleaseButtonRadiusTopLeft: Length = 22.0 // 视频发布按钮左上圆角
  videoReleaseButtonRadiusTopRight: Length = 22.0 // 视频发布按钮右上圆角
  videoReleaseButtonRadiusBottomLeft: Length = 22.0 // 视频发布按钮左下圆角
  videoReleaseButtonRadiusBottomRight: Length = 22.0 // 视频发布按钮右下圆角
  videoReleaseButtonIconTextGap: number = 6.0 // 视频发布按钮图标与文本间距
  videoReleaseButtonIcon: Resource | undefined = undefined // 视频发布按钮图标资源
  videoReleaseButtonIconWidth: Length = 18.0 // 视频发布按钮图标宽度
  videoReleaseButtonIconHeight: Length = 18.0 // 视频发布按钮图标高度
  videoReleaseButtonText: string = '发布视频' // 视频发布按钮文本
  videoReleaseButtonTextFontColor: ResourceColor = COLOR_E6000000 // 视频发布按钮文本字体颜色
  videoReleaseButtonTextFontSize: number | string | Resource = 16.0 // 视频发布按钮文本字体大小
  videoReleaseButtonTextFontStyle: FontStyle = FontStyle.Normal // 视频发布按钮文本字体样式
  videoReleaseButtonTextFontWeight: number | FontWeight = FontWeight.Medium // 视频发布按钮文本字体粗细
  videoReleaseButtonTextFontFamily: string | Resource = 'HarmonyOS Sans' // 视频发布按钮文本字体族
  videoReleaseButtonTextLineHeight: number | string | Resource = 22.0 // 视频发布按钮文本行高
  videoDownloadButtonVisible: boolean = true // 是否视频下载按钮可见
  videoDownloadButtonBackgroundColor: ResourceColor = COLOR_FFF5F5F5 // 视频下载按钮背景颜色
  videoDownloadButtonWidth: Length = 144.0 // 视频下载按钮宽度
  videoDownloadButtonHeight: Length = 44.0 // 视频下载按钮高度
  videoDownloadButtonRadiusTopLeft: Length = 22.0 // 视频下载按钮左上圆角
  videoDownloadButtonRadiusTopRight: Length = 22.0 // 视频下载按钮右上圆角
  videoDownloadButtonRadiusBottomLeft: Length = 22.0 // 视频下载按钮左下圆角
  videoDownloadButtonRadiusBottomRight: Length = 22.0 // 视频下载按钮右下圆角
  videoDownloadButtonIconTextGap: number = 6.0 // 视频下载按钮图标与文本间距
  videoDownloadButtonIcon: Resource | undefined = undefined // 视频下载按钮图标资源
  videoDownloadButtonIconWidth: Length = 18.0 // 视频下载按钮图标宽度
  videoDownloadButtonIconHeight: Length = 18.0 // 视频下载按钮图标高度
  videoDownloadButtonText: string = '下载视频' // 视频下载按钮文本
  videoDownloadButtonTextFontColor: ResourceColor = COLOR_E6000000 // 视频下载按钮文本字体颜色
  videoDownloadButtonTextFontSize: number | string | Resource = 16.0 // 视频下载按钮文本字体大小
  videoDownloadButtonTextFontStyle: FontStyle = FontStyle.Normal // 视频下载按钮文本字体样式
  videoDownloadButtonTextFontWeight: number | FontWeight = FontWeight.Medium // 视频下载按钮文本字体粗细
  videoDownloadButtonTextFontFamily: string | Resource = 'HarmonyOS Sans' // 视频下载按钮文本字体族
  videoDownloadButtonTextLineHeight: number | string | Resource = 22.0 // 视频下载按钮文本行高

  /**
   * 设置视频背景颜色
   *
   * @param color 背景颜色
   * @return VideoTheme
   */
  setVideoBackgroundColor(color: ResourceColor): VideoTheme {
    this.videoBackgroundColor = color
    return this
  }

  /**
   * 设置视频边距
   *
   * @param options 边距选项
   * @return VideoTheme
   */
  setVideoMargin(options: Margin | Length): VideoTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.videoMarginTop = options
      this.videoMarginRight = options
      this.videoMarginBottom = options
      this.videoMarginLeft = options
    }
    // 2. 如果是 object，它要么是 Margin，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Margin 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Margin 处理
      if (isMargin(options)) {
        // 这里通过类型守卫，编译器已经知道它是 Margin 了
        const margin = options as Margin
        if (margin.top !== undefined) {
          this.videoMarginTop = margin.top
        }
        if (margin.right !== undefined) {
          this.videoMarginRight = margin.right
        }
        if (margin.bottom !== undefined) {
          this.videoMarginBottom = margin.bottom
        }
        if (margin.left !== undefined) {
          this.videoMarginLeft = margin.left
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.videoMarginTop = options as Length
        this.videoMarginRight = options as Length
        this.videoMarginBottom = options as Length
        this.videoMarginLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置视频内边距
   *
   * @param options 内边距选项
   * @return VideoTheme
   */
  setVideoPadding(options: Padding | Length): VideoTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.videoPaddingTop = options
      this.videoPaddingRight = options
      this.videoPaddingBottom = options
      this.videoPaddingLeft = options
    }
    // 2. 如果是 object，它要么是 Padding，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Padding 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Padding 处理
      if (isPadding(options)) {
        // 这里通过类型守卫，编译器已经知道它是 Padding 了
        const padding = options as Padding
        if (padding.top !== undefined) {
          this.videoPaddingTop = padding.top
        }
        if (padding.right !== undefined) {
          this.videoPaddingRight = padding.right
        }
        if (padding.bottom !== undefined) {
          this.videoPaddingBottom = padding.bottom
        }
        if (padding.left !== undefined) {
          this.videoPaddingLeft = padding.left
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.videoPaddingTop = options as Length
        this.videoPaddingRight = options as Length
        this.videoPaddingBottom = options as Length
        this.videoPaddingLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置视频圆角
   *
   * @param options 圆角选项
   * @return VideoTheme
   */
  setVideoBorderRadius(options: BorderRadiuses | Length): VideoTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.videoRadiusTopLeft = options
      this.videoRadiusTopRight = options
      this.videoRadiusBottomLeft = options
      this.videoRadiusBottomRight = options
    }
    // 2. 如果是 object，它要么是 BorderRadiuses，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 BorderRadiuses 的专属属性来区分
      // 如果包含 topLeft/topRight/bottomLeft/bottomRight 任意一个，就当作 BorderRadiuses 处理
      if (isBorderRadiuses(options)) {
        // 这里通过类型守卫，编译器已经知道它是 BorderRadiuses 了
        const radius = options as BorderRadiuses
        if (radius.topLeft !== undefined) {
          this.videoRadiusTopLeft = radius.topLeft
        }
        if (radius.topRight !== undefined) {
          this.videoRadiusTopRight = radius.topRight
        }
        if (radius.bottomLeft !== undefined) {
          this.videoRadiusBottomLeft = radius.bottomLeft
        }
        if (radius.bottomRight !== undefined) {
          this.videoRadiusBottomRight = radius.bottomRight
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.videoRadiusTopLeft = options as Length
        this.videoRadiusTopRight = options as Length
        this.videoRadiusBottomLeft = options as Length
        this.videoRadiusBottomRight = options as Length
      }
    }
    return this
  }

  /**
   * 设置视频边框样式
   *
   * @param borderStyle 边框样式
   * @return VideoTheme
   */
  setVideoBorderStyle(borderStyle: BorderStyle): VideoTheme {
    this.videoBorderStyle = borderStyle
    return this
  }

  /**
   * 设置视频边框宽度
   *
   * @param borderWidth 边框宽度
   * @return VideoTheme
   */
  setVideoBorderWidth(borderWidth: Length): VideoTheme {
    this.videoBorderWidth = borderWidth
    return this
  }

  /**
   * 设置视频边框颜色
   *
   * @param borderColor 边框颜色
   * @return VideoTheme
   */
  setVideoBorderColor(borderColor: ResourceColor): VideoTheme {
    this.videoBorderColor = borderColor
    return this
  }

  /**
   * 设置视频占位图
   *
   * @param resource 资源
   * @return VideoTheme
   */
  setVideoPlaceholder(resource: Resource): VideoTheme {
    this.videoPlaceholder = resource
    return this
  }

  /**
   * 设置视频图片填充类型
   *
   * @param fitType 填充类型
   * @return VideoTheme
   */
  setVideoImageFitType(fitType: ImageFit): VideoTheme {
    this.videoImageFitType = fitType
    return this
  }

  /**
   * 设置视频播放图标
   *
   * @param icon 图标资源
   * @return VideoTheme
   */
  setVideoPlayIcon(icon: Resource): VideoTheme {
    this.videoPlayIcon = icon
    return this
  }

  /**
   * 设置视频播放图标宽度
   *
   * @param width 宽度
   * @return VideoTheme
   */
  setVideoPlayIconWidth(width: Length): VideoTheme {
    this.videoPlayIconWidth = width
    return this
  }

  /**
   * 设置视频播放图标高度
   *
   * @param height 高度
   * @return VideoTheme
   */
  setVideoPlayIconHeight(height: Length): VideoTheme {
    this.videoPlayIconHeight = height
    return this
  }

  /**
   * 设置视频播放图标填充类型
   *
   * @param fitType 填充类型
   * @return VideoTheme
   */
  setVideoPlayIconFitType(fitType: ImageFit): VideoTheme {
    this.videoPlayIconFitType = fitType
    return this
  }

  /**
   * 设置视频时间文本字体颜色
   *
   * @param color 字体颜色
   * @return VideoTheme
   */
  setVideoTimeTextFontColor(color: ResourceColor): VideoTheme {
    this.videoTimeTextFontColor = color
    return this
  }

  /**
   * 设置视频时间文本字体大小
   *
   * @param size 字体大小
   * @return VideoTheme
   */
  setVideoTimeTextFontSize(size: number | string | Resource): VideoTheme {
    this.videoTimeTextFontSize = size
    return this
  }

  /**
   * 设置视频时间文本字体样式
   *
   * @param style 字体样式
   * @return VideoTheme
   */
  setVideoTimeTextFontStyle(style: FontStyle): VideoTheme {
    this.videoTimeTextFontStyle = style
    return this
  }

  /**
   * 设置视频时间文本字体粗细
   *
   * @param weight 字体粗细
   * @return VideoTheme
   */
  setVideoTimeTextFontWeight(weight: number | FontWeight): VideoTheme {
    this.videoTimeTextFontWeight = weight
    return this
  }

  /**
   * 设置视频时间文本字体族
   *
   * @param family 字体族
   * @return VideoTheme
   */
  setVideoTimeTextFontFamily(family: string | Resource): VideoTheme {
    this.videoTimeTextFontFamily = family
    return this
  }

  /**
   * 设置视频时间文本行高
   *
   * @param height 行高
   * @return VideoTheme
   */
  setVideoTimeTextLineHeight(height: number | string | Resource): VideoTheme {
    this.videoTimeTextLineHeight = height
    return this
  }

  /**
   * 设置视频时间文本右边距
   *
   * @param margin 右边距
   * @return VideoTheme
   */
  setVideoTimeTextMarginRight(margin: Length): VideoTheme {
    this.videoTimeTextMarginRight = margin
    return this
  }

  /**
   * 设置视频时间文本下边距
   *
   * @param margin 下边距
   * @return VideoTheme
   */
  setVideoTimeTextMarginBottom(margin: Length): VideoTheme {
    this.videoTimeTextMarginBottom = margin
    return this
  }

  /**
   * 设置视频底部布局可见性
   *
   * @param visible 是否可见
   * @return VideoTheme
   */
  setVideoBottomLayoutVisible(visible: boolean): VideoTheme {
    this.videoBottomLayoutVisible = visible
    return this
  }

  /**
   * 设置视频底部布局上边距
   *
   * @param marginTop 上边距
   * @return VideoTheme
   */
  setVideoBottomLayoutMarginTop(marginTop: Length): VideoTheme {
    this.videoBottomLayoutMarginTop = marginTop
    return this
  }

  /**
   * 设置视频发布按钮可见性
   *
   * @param visible 是否可见
   * @return VideoTheme
   */
  setVideoReleaseButtonVisible(visible: boolean): VideoTheme {
    this.videoReleaseButtonVisible = visible
    return this
  }

  /**
   * 设置视频发布按钮背景颜色
   *
   * @param color 背景颜色
   * @return VideoTheme
   */
  setVideoReleaseButtonBackgroundColor(color: ResourceColor): VideoTheme {
    this.videoReleaseButtonBackgroundColor = color
    return this
  }

  /**
   * 设置视频发布按钮宽度
   *
   * @param width 宽度
   * @return VideoTheme
   */
  setVideoReleaseButtonWidth(width: Length): VideoTheme {
    this.videoReleaseButtonWidth = width
    return this
  }

  /**
   * 设置视频发布按钮高度
   *
   * @param height 高度
   * @return VideoTheme
   */
  setVideoReleaseButtonHeight(height: Length): VideoTheme {
    this.videoReleaseButtonHeight = height
    return this
  }

  /**
   * 设置视频发布按钮圆角
   *
   * @param options 圆角选项
   * @return VideoTheme
   */
  setVideoReleaseButtonRadius(options: BorderRadiuses | Length): VideoTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.videoReleaseButtonRadiusTopLeft = options
      this.videoReleaseButtonRadiusTopRight = options
      this.videoReleaseButtonRadiusBottomLeft = options
      this.videoReleaseButtonRadiusBottomRight = options
    }
    // 2. 如果是 object，它要么是 BorderRadiuses，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 BorderRadiuses 的专属属性来区分
      // 如果包含 topLeft/topRight/bottomLeft/bottomRight 任意一个，就当作 BorderRadiuses 处理
      if (isBorderRadiuses(options)) {
        // 这里通过类型守卫，编译器已经知道它是 BorderRadiuses 了
        const radius = options as BorderRadiuses
        if (radius.topLeft !== undefined) {
          this.videoReleaseButtonRadiusTopLeft = radius.topLeft
        }
        if (radius.topRight !== undefined) {
          this.videoReleaseButtonRadiusTopRight = radius.topRight
        }
        if (radius.bottomLeft !== undefined) {
          this.videoReleaseButtonRadiusBottomLeft = radius.bottomLeft
        }
        if (radius.bottomRight !== undefined) {
          this.videoReleaseButtonRadiusBottomRight = radius.bottomRight
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.videoReleaseButtonRadiusTopLeft = options as Length
        this.videoReleaseButtonRadiusTopRight = options as Length
        this.videoReleaseButtonRadiusBottomLeft = options as Length
        this.videoReleaseButtonRadiusBottomRight = options as Length
      }
    }
    return this
  }

  /**
   * 设置视频发布按钮图标文本间距
   *
   * @param gap 间距
   * @return VideoTheme
   */
  setVideoReleaseButtonIconTextGap(gap: number): VideoTheme {
    this.videoReleaseButtonIconTextGap = gap
    return this
  }

  /**
   * 设置视频发布按钮图标
   *
   * @param icon 图标资源
   * @return VideoTheme
   */
  setVideoReleaseButtonIcon(icon: Resource): VideoTheme {
    this.videoReleaseButtonIcon = icon
    return this
  }

  /**
   * 设置视频发布按钮图标宽度
   *
   * @param width 宽度
   * @return VideoTheme
   */
  setVideoReleaseButtonIconWidth(width: Length): VideoTheme {
    this.videoReleaseButtonIconWidth = width
    return this
  }

  /**
   * 设置视频发布按钮图标高度
   *
   * @param height 高度
   * @return VideoTheme
   */
  setVideoReleaseButtonIconHeight(height: Length): VideoTheme {
    this.videoReleaseButtonIconHeight = height
    return this
  }

  /**
   * 设置视频发布按钮文本
   *
   * @param text 文本
   * @return VideoTheme
   */
  setVideoReleaseButtonText(text: string): VideoTheme {
    this.videoReleaseButtonText = text
    return this
  }

  /**
   * 设置视频发布按钮文本字体颜色
   *
   * @param color 字体颜色
   * @return VideoTheme
   */
  setVideoReleaseButtonTextFontColor(color: ResourceColor): VideoTheme {
    this.videoReleaseButtonTextFontColor = color
    return this
  }

  /**
   * 设置视频发布按钮文本字体大小
   *
   * @param size 字体大小
   * @return VideoTheme
   */
  setVideoReleaseButtonTextFontSize(size: number | string | Resource): VideoTheme {
    this.videoReleaseButtonTextFontSize = size
    return this
  }

  /**
   * 设置视频发布按钮文本字体样式
   *
   * @param style 字体样式
   * @return VideoTheme
   */
  setVideoReleaseButtonTextFontStyle(style: FontStyle): VideoTheme {
    this.videoReleaseButtonTextFontStyle = style
    return this
  }

  /**
   * 设置视频发布按钮文本字体粗细
   *
   * @param weight 字体粗细
   * @return VideoTheme
   */
  setVideoReleaseButtonTextFontWeight(weight: number | FontWeight): VideoTheme {
    this.videoReleaseButtonTextFontWeight = weight
    return this
  }

  /**
   * 设置视频发布按钮文本字体族
   *
   * @param family 字体族
   * @return VideoTheme
   */
  setVideoReleaseButtonTextFontFamily(family: string | Resource): VideoTheme {
    this.videoReleaseButtonTextFontFamily = family
    return this
  }

  /**
   * 设置视频发布按钮文本行高
   *
   * @param height 行高
   * @return VideoTheme
   */
  setVideoReleaseButtonTextLineHeight(height: number | string | Resource): VideoTheme {
    this.videoReleaseButtonTextLineHeight = height
    return this
  }

  /**
   * 设置视频下载按钮可见性
   *
   * @param visible 是否可见
   * @return VideoTheme
   */
  setVideoDownloadButtonVisible(visible: boolean): VideoTheme {
    this.videoDownloadButtonVisible = visible
    return this
  }

  /**
   * 设置视频下载按钮背景颜色
   *
   * @param color 背景颜色
   * @return VideoTheme
   */
  setVideoDownloadButtonBackgroundColor(color: ResourceColor): VideoTheme {
    this.videoDownloadButtonBackgroundColor = color
    return this
  }

  /**
   * 设置视频下载按钮宽度
   *
   * @param width 宽度
   * @return VideoTheme
   */
  setVideoDownloadButtonWidth(width: Length): VideoTheme {
    this.videoDownloadButtonWidth = width
    return this
  }

  /**
   * 设置视频下载按钮高度
   *
   * @param height 高度
   * @return VideoTheme
   */
  setVideoDownloadButtonHeight(height: Length): VideoTheme {
    this.videoDownloadButtonHeight = height
    return this
  }

  /**
   * 设置视频下载按钮圆角
   *
   * @param options 圆角选项
   * @return VideoTheme
   */
  setVideoDownloadButtonRadius(options: BorderRadiuses | Length): VideoTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.videoDownloadButtonRadiusTopLeft = options
      this.videoDownloadButtonRadiusTopRight = options
      this.videoDownloadButtonRadiusBottomLeft = options
      this.videoDownloadButtonRadiusBottomRight = options
    }
    // 2. 如果是 object，它要么是 BorderRadiuses，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 BorderRadiuses 的专属属性来区分
      // 如果包含 topLeft/topRight/bottomLeft/bottomRight 任意一个，就当作 BorderRadiuses 处理
      if (isBorderRadiuses(options)) {
        // 这里通过类型守卫，编译器已经知道它是 BorderRadiuses 了
        const radius = options as BorderRadiuses
        if (radius.topLeft !== undefined) {
          this.videoDownloadButtonRadiusTopLeft = radius.topLeft
        }
        if (radius.topRight !== undefined) {
          this.videoDownloadButtonRadiusTopRight = radius.topRight
        }
        if (radius.bottomLeft !== undefined) {
          this.videoDownloadButtonRadiusBottomLeft = radius.bottomLeft
        }
        if (radius.bottomRight !== undefined) {
          this.videoDownloadButtonRadiusBottomRight = radius.bottomRight
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.videoDownloadButtonRadiusTopLeft = options as Length
        this.videoDownloadButtonRadiusTopRight = options as Length
        this.videoDownloadButtonRadiusBottomLeft = options as Length
        this.videoDownloadButtonRadiusBottomRight = options as Length
      }
    }
    return this
  }

  /**
   * 设置视频下载按钮图标文本间距
   *
   * @param gap 间距
   * @return VideoTheme
   */
  setVideoDownloadButtonIconTextGap(gap: number): VideoTheme {
    this.videoDownloadButtonIconTextGap = gap
    return this
  }

  /**
   * 设置视频下载按钮图标
   *
   * @param icon 图标资源
   * @return VideoTheme
   */
  setVideoDownloadButtonIcon(icon: Resource): VideoTheme {
    this.videoDownloadButtonIcon = icon
    return this
  }

  /**
   * 设置视频下载按钮图标宽度
   *
   * @param width 宽度
   * @return VideoTheme
   */
  setVideoDownloadButtonIconWidth(width: Length): VideoTheme {
    this.videoDownloadButtonIconWidth = width
    return this
  }

  /**
   * 设置视频下载按钮图标高度
   *
   * @param height 高度
   * @return VideoTheme
   */
  setVideoDownloadButtonIconHeight(height: Length): VideoTheme {
    this.videoDownloadButtonIconHeight = height
    return this
  }

  /**
   * 设置视频下载按钮文本
   *
   * @param text 文本
   * @return VideoTheme
   */
  setVideoDownloadButtonText(text: string): VideoTheme {
    this.videoDownloadButtonText = text
    return this
  }

  /**
   * 设置视频下载按钮文本字体颜色
   *
   * @param color 字体颜色
   * @return VideoTheme
   */
  setVideoDownloadButtonTextFontColor(color: ResourceColor): VideoTheme {
    this.videoDownloadButtonTextFontColor = color
    return this
  }

  /**
   * 设置视频下载按钮文本字体大小
   *
   * @param size 字体大小
   * @return VideoTheme
   */
  setVideoDownloadButtonTextFontSize(size: number | string | Resource): VideoTheme {
    this.videoDownloadButtonTextFontSize = size
    return this
  }

  /**
   * 设置视频下载按钮文本字体样式
   *
   * @param style 字体样式
   * @return VideoTheme
   */
  setVideoDownloadButtonTextFontStyle(style: FontStyle): VideoTheme {
    this.videoDownloadButtonTextFontStyle = style
    return this
  }

  /**
   * 设置视频下载按钮文本字体粗细
   *
   * @param weight 字体粗细
   * @return VideoTheme
   */
  setVideoDownloadButtonTextFontWeight(weight: number | FontWeight): VideoTheme {
    this.videoDownloadButtonTextFontWeight = weight
    return this
  }

  /**
   * 设置视频下载按钮文本字体族
   *
   * @param family 字体族
   * @return VideoTheme
   */
  setVideoDownloadButtonTextFontFamily(family: string | Resource): VideoTheme {
    this.videoDownloadButtonTextFontFamily = family
    return this
  }

  /**
   * 设置视频下载按钮文本行高
   *
   * @param height 行高
   * @return VideoTheme
   */
  setVideoDownloadButtonTextLineHeight(height: number | string | Resource): VideoTheme {
    this.videoDownloadButtonTextLineHeight = height
    return this
  }
}
