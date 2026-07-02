import { MarkdownBaseTheme } from './MarkdownBaseTheme'
import {
  COLOR_TRANSPARENT,
  COLOR_BLACK,
  COLOR_WHITE,
  COLOR_33000000,
  COLOR_1A000000,
  COLOR_80000000,
  isMargin,
  isPadding,
  isBorderRadiuses
} from "../base/Constants"

/**
 * 音频样式配置
 */
@Observed
export class AudioTheme implements MarkdownBaseTheme {
  audioBackgroundColor: ResourceColor = COLOR_TRANSPARENT // 音频块背景颜色
  audioMarginTop: Length = 0.0 // 音频块上外边距
  audioMarginRight: Length = 0.0 // 音频块右外边距
  audioMarginBottom: Length = 0.0 // 音频块下外边距
  audioMarginLeft: Length = 0.0 // 音频块左外边距
  audioPaddingTop: Length = 12.0 // 音频块上内边距
  audioPaddingRight: Length = 16.0 // 音频块右内边距
  audioPaddingBottom: Length = 12.0 // 音频块下内边距
  audioPaddingLeft: Length = 12.0 // 音频块左内边距
  audioBorderStyle: BorderStyle = BorderStyle.Solid // 音频块边框样式
  audioBorderWidth: Length = 0.5 // 音频块边框宽度
  audioBorderColor: ResourceColor = COLOR_33000000 // 音频块边框颜色
  audioRadiusTopLeft: Length = 12.0 // 音频块左上圆角
  audioRadiusTopRight: Length = 12.0 // 音频块右上圆角
  audioRadiusBottomLeft: Length = 12.0 // 音频块左下圆角
  audioRadiusBottomRight: Length = 12.0 // 音频块右下圆角
  audioShadowRadius: number = 12.0 // 音频块阴影半径
  audioShadowColor: ResourceColor = COLOR_1A000000 // 音频块阴影颜色
  audioShadowOffsetX: number = 0.0 // 音频块阴影X偏移
  audioShadowOffsetY: number = 2.0 // 音频块阴影Y偏移
  audioIcon: Resource | undefined = undefined // 音频图标资源
  audioIconWidth: Length = 40.0 // 音频图标宽度
  audioIconHeight: Length = 40.0 // 音频图标高度
  audioIconRadiusTopLeft: Length = 8.0 // 音频图标左上圆角
  audioIconRadiusTopRight: Length = 8.0 // 音频图标右上圆角
  audioIconRadiusBottomLeft: Length = 8.0 // 音频图标左下圆角
  audioIconRadiusBottomRight: Length = 8.0 // 音频图标右下圆角
  audioIconFitType: ImageFit = ImageFit.Cover // 音频图标图像适应类型
  audioTitleToTypeSpacing: number = 2.0 // 音频标题与类型间距
  audioTitleTextFontColor: ResourceColor = COLOR_BLACK // 音频标题文本字体颜色
  audioTitleTextFontSize: number | string | Resource = 15.0 // 音频标题文本字体大小
  audioTitleTextFontStyle: FontStyle = FontStyle.Normal // 音频标题文本字体样式
  audioTitleTextFontWeight: number | FontWeight = FontWeight.Bold // 音频标题文本字体粗细
  audioTitleTextFontFamily: string | Resource = 'HarmonyOS Sans' // 音频标题文本字体族
  audioTitleTextLineHeight: number | string | Resource = 20.0 // 音频标题文本行高
  audioTypeTextFontColor: ResourceColor = COLOR_80000000 // 音频类型文本字体颜色
  audioTypeTextFontSize: number | string | Resource = 11.0 // 音频类型文本字体大小
  audioTypeTextFontStyle: FontStyle = FontStyle.Normal // 音频类型文本字体样式
  audioTypeTextFontWeight: number | FontWeight = FontWeight.Normal // 音频类型文本字体粗细
  audioTypeTextFontFamily: string | Resource = 'HarmonyOS Sans' // 音频类型文本字体族
  audioTypeTextLineHeight: number | string | Resource = 15.0 // 音频类型文本行高
  audioButtonBackgroundColor: ResourceColor = COLOR_BLACK // 音频播放按钮背景颜色
  audioButtonWidth: Length = 84.0 // 音频播放按钮宽度
  audioButtonHeight: Length = 32.0 // 音频播放按钮高度
  audioButtonBorderStyle: BorderStyle = BorderStyle.Solid // 音频播放按钮边框样式
  audioButtonBorderWidth: Length = 0.0 // 音频播放按钮边框宽度
  audioButtonBorderColor: ResourceColor = COLOR_TRANSPARENT // 音频播放按钮边框颜色
  audioButtonRadiusTopLeft: Length = 16.0 // 音频播放按钮左上圆角
  audioButtonRadiusTopRight: Length = 16.0 // 音频播放按钮右上圆角
  audioButtonRadiusBottomLeft: Length = 16.0 // 音频播放按钮左下圆角
  audioButtonRadiusBottomRight: Length = 16.0 // 音频播放按钮右下圆角
  audioButtonText: string = '立即播放' // 音频播放按钮文本显示
  audioButtonTextFontColor: ResourceColor = COLOR_WHITE // 音频播放按钮文本字体颜色
  audioButtonTextFontSize: number | string | Resource = 14.0 // 音频播放按钮文本字体大小
  audioButtonTextFontStyle: FontStyle = FontStyle.Normal // 音频播放按钮文本字体样式
  audioButtonTextFontWeight: number | FontWeight = FontWeight.Medium // 音频播放按钮文本字体粗细
  audioButtonTextFontFamily: string | Resource = 'HarmonyOS Sans' // 音频播放按钮文本字体族
  audioButtonTextLineHeight: number | string | Resource = 22.0 // 音频播放按钮文本行高
  /**
   * 设置音频背景颜色
   *
   * @param color 背景颜色
   * @return AudioTheme
   */
  setAudioBackgroundColor(color: ResourceColor): AudioTheme {
    this.audioBackgroundColor = color
    return this
  }

  /**
   * 设置音频外边距
   *
   * @param options 外边距选项或统一数值
   * @return AudioTheme
   */
  setAudioMargin(options: Margin | Length): AudioTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.audioMarginTop = options
      this.audioMarginRight = options
      this.audioMarginBottom = options
      this.audioMarginLeft = options
    }
    // 2. 如果是 object，它要么是 Margin，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Margin 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Margin 处理
      if (isMargin(options)) {
        // 这里通过类型守卫，编译器已经知道它是 Margin 了
        const margin = options as Margin
        if (margin.top !== undefined) {
          this.audioMarginTop = margin.top
        }
        if (margin.right !== undefined) {
          this.audioMarginRight = margin.right
        }
        if (margin.bottom !== undefined) {
          this.audioMarginBottom = margin.bottom
        }
        if (margin.left !== undefined) {
          this.audioMarginLeft = margin.left
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.audioMarginTop = options as Length
        this.audioMarginRight = options as Length
        this.audioMarginBottom = options as Length
        this.audioMarginLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置音频内边距
   *
   * @param options 内边距选项或统一数值
   * @return AudioTheme
   */
  setAudioPadding(options: Padding | Length): AudioTheme {
    if (typeof options === 'number' || typeof options === 'string') {
      // 基础类型，统一赋值
      this.audioPaddingTop = options
      this.audioPaddingRight = options
      this.audioPaddingBottom = options
      this.audioPaddingLeft = options
    } else if (typeof options === 'object' && options !== null) {
      if (isPadding(options)) {
        // 此时 options 的类型仍是 Padding | Length，需要手动断言
        const padding = options as Padding
        if (padding.top !== undefined) {
          this.audioPaddingTop = padding.top
        }
        if (padding.right !== undefined) {
          this.audioPaddingRight = padding.right
        }
        if (padding.bottom !== undefined) {
          this.audioPaddingBottom = padding.bottom
        }
        if (padding.left !== undefined) {
          this.audioPaddingLeft = padding.left
        }
      } else {
        // 非 Padding 对象（如 Resource），统一赋值
        this.audioPaddingTop = options as Length
        this.audioPaddingRight = options as Length
        this.audioPaddingBottom = options as Length
        this.audioPaddingLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置音频边框样式
   *
   * @param borderStyle 边框样式
   * @return AudioTheme
   */
  setAudioBorderStyle(borderStyle: BorderStyle): AudioTheme {
    this.audioBorderStyle = borderStyle
    return this
  }

  /**
   * 设置音频边框宽度
   *
   * @param borderWidth 边框宽度
   * @return AudioTheme
   */
  setAudioBorderWidth(borderWidth: Length): AudioTheme {
    this.audioBorderWidth = borderWidth
    return this
  }

  /**
   * 设置音频边框颜色
   *
   * @param borderColor 边框颜色
   * @return AudioTheme
   */
  setAudioBorderColor(borderColor: ResourceColor): AudioTheme {
    this.audioBorderColor = borderColor
    return this
  }

  /**
   * 设置音频圆角
   *
   * @param options 圆角选项或统一数值
   * @return AudioTheme
   */
  setAudioRadius(options: BorderRadiuses | Length): AudioTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.audioRadiusTopLeft = options
      this.audioRadiusTopRight = options
      this.audioRadiusBottomLeft = options
      this.audioRadiusBottomRight = options
    }
    // 2. 如果是 object，它要么是 BorderRadiuses，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 BorderRadiuses 的专属属性来区分
      // 如果包含 topLeft/topRight/bottomLeft/bottomRight 任意一个，就当作 BorderRadiuses 处理
      if (isBorderRadiuses(options)) {
        // 这里通过类型守卫，编译器已经知道它是 BorderRadiuses 了
        const radius = options as BorderRadiuses
        if (radius.topLeft !== undefined) {
          this.audioRadiusTopLeft = radius.topLeft
        }
        if (radius.topRight !== undefined) {
          this.audioRadiusTopRight = radius.topRight
        }
        if (radius.bottomLeft !== undefined) {
          this.audioRadiusBottomLeft = radius.bottomLeft
        }
        if (radius.bottomRight !== undefined) {
          this.audioRadiusBottomRight = radius.bottomRight
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.audioRadiusTopLeft = options as Length
        this.audioRadiusTopRight = options as Length
        this.audioRadiusBottomLeft = options as Length
        this.audioRadiusBottomRight = options as Length
      }
    }
    return this
  }

  /**
   * 设置音频阴影半径
   *
   * @param radius 阴影半径
   * @return AudioTheme
   */
  setAudioShadowRadius(radius: number): AudioTheme {
    this.audioShadowRadius = radius
    return this
  }

  /**
   * 设置音频阴影颜色
   *
   * @param color 阴影颜色
   * @return AudioTheme
   */
  setAudioShadowColor(color: ResourceColor): AudioTheme {
    this.audioShadowColor = color
    return this
  }

  /**
   * 设置音频阴影X偏移
   *
   * @param offsetX X偏移
   * @return AudioTheme
   */
  setAudioShadowOffsetX(offsetX: number): AudioTheme {
    this.audioShadowOffsetX = offsetX
    return this
  }

  /**
   * 设置音频阴影Y偏移
   *
   * @param offsetY Y偏移
   * @return AudioTheme
   */
  setAudioShadowOffsetY(offsetY: number): AudioTheme {
    this.audioShadowOffsetY = offsetY
    return this
  }

  /**
   * 设置音频图标
   *
   * @param icon 图标资源
   * @return AudioTheme
   */
  setAudioIcon(icon: Resource): AudioTheme {
    this.audioIcon = icon
    return this
  }

  /**
   * 设置音频图标宽度
   *
   * @param width 图标宽度
   * @return AudioTheme
   */
  setAudioIconWidth(width: Length): AudioTheme {
    this.audioIconWidth = width
    return this
  }

  /**
   * 设置音频图标高度
   *
   * @param height 图标高度
   * @return AudioTheme
   */
  setAudioIconHeight(height: Length): AudioTheme {
    this.audioIconHeight = height
    return this
  }

  /**
   * 设置音频图标圆角
   *
   * @param options 圆角选项或统一数值
   * @return AudioTheme
   */
  setAudioIconRadius(options: BorderRadiuses | Length): AudioTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.audioIconRadiusTopLeft = options
      this.audioIconRadiusTopRight = options
      this.audioIconRadiusBottomLeft = options
      this.audioIconRadiusBottomRight = options
    }
    // 2. 如果是 object，它要么是 BorderRadiuses，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 BorderRadiuses 的专属属性来区分
      // 如果包含 topLeft/topRight/bottomLeft/bottomRight 任意一个，就当作 BorderRadiuses 处理
      if (isBorderRadiuses(options)) {
        // 这里通过类型守卫，编译器已经知道它是 BorderRadiuses 了
        const radius = options as BorderRadiuses
        if (radius.topLeft !== undefined) {
          this.audioIconRadiusTopLeft = radius.topLeft
        }
        if (radius.topRight !== undefined) {
          this.audioIconRadiusTopRight = radius.topRight
        }
        if (radius.bottomLeft !== undefined) {
          this.audioIconRadiusBottomLeft = radius.bottomLeft
        }
        if (radius.bottomRight !== undefined) {
          this.audioIconRadiusBottomRight = radius.bottomRight
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.audioIconRadiusTopLeft = options as Length
        this.audioIconRadiusTopRight = options as Length
        this.audioIconRadiusBottomLeft = options as Length
        this.audioIconRadiusBottomRight = options as Length
      }
    }
    return this
  }

  /**
   * 设置音频图标适应类型
   *
   * @param fitType 适应类型
   * @return AudioTheme
   */
  setAudioIconFitType(fitType: ImageFit): AudioTheme {
    this.audioIconFitType = fitType
    return this
  }

  /**
   * 设置音频标题与类型间距
   *
   * @param spacing 间距
   * @return AudioTheme
   */
  setAudioTitleToTypeSpacing(spacing: number): AudioTheme {
    this.audioTitleToTypeSpacing = spacing
    return this
  }

  /**
   * 设置音频标题文本字体颜色
   *
   * @param color 字体颜色
   * @return AudioTheme
   */
  setAudioTitleTextFontColor(color: ResourceColor): AudioTheme {
    this.audioTitleTextFontColor = color
    return this
  }

  /**
   * 设置音频标题文本字体大小
   *
   * @param size 字体大小
   * @return AudioTheme
   */
  setAudioTitleTextFontSize(size: number | string | Resource): AudioTheme {
    this.audioTitleTextFontSize = size
    return this
  }

  /**
   * 设置音频标题文本字体样式
   *
   * @param style 字体样式
   * @return AudioTheme
   */
  setAudioTitleTextFontStyle(style: FontStyle): AudioTheme {
    this.audioTitleTextFontStyle = style
    return this
  }

  /**
   * 设置音频标题文本字体粗细
   *
   * @param weight 字体粗细
   * @return AudioTheme
   */
  setAudioTitleTextFontWeight(weight: number | FontWeight): AudioTheme {
    this.audioTitleTextFontWeight = weight
    return this
  }

  /**
   * 设置音频标题文本字体族
   *
   * @param family 字体族
   * @return AudioTheme
   */
  setAudioTitleTextFontFamily(family: string | Resource): AudioTheme {
    this.audioTitleTextFontFamily = family
    return this
  }

  /**
   * 设置音频标题文本行高
   *
   * @param height 行高
   * @return AudioTheme
   */
  setAudioTitleTextLineHeight(height: number | string | Resource): AudioTheme {
    this.audioTitleTextLineHeight = height
    return this
  }

  /**
   * 设置音频类型文本字体颜色
   *
   * @param color 字体颜色
   * @return AudioTheme
   */
  setAudioTypeTextFontColor(color: ResourceColor): AudioTheme {
    this.audioTypeTextFontColor = color
    return this
  }

  /**
   * 设置音频类型文本字体大小
   *
   * @param size 字体大小
   * @return AudioTheme
   */
  setAudioTypeTextFontSize(size: number | string | Resource): AudioTheme {
    this.audioTypeTextFontSize = size
    return this
  }

  /**
   * 设置音频类型文本字体样式
   *
   * @param style 字体样式
   * @return AudioTheme
   */
  setAudioTypeTextFontStyle(style: FontStyle): AudioTheme {
    this.audioTypeTextFontStyle = style
    return this
  }

  /**
   * 设置音频类型文本字体粗细
   *
   * @param weight 字体粗细
   * @return AudioTheme
   */
  setAudioTypeTextFontWeight(weight: number | FontWeight): AudioTheme {
    this.audioTypeTextFontWeight = weight
    return this
  }

  /**
   * 设置音频类型文本字体族
   *
   * @param family 字体族
   * @return AudioTheme
   */
  setAudioTypeTextFontFamily(family: string | Resource): AudioTheme {
    this.audioTypeTextFontFamily = family
    return this
  }

  /**
   * 设置音频类型文本行高
   *
   * @param height 行高
   * @return AudioTheme
   */
  setAudioTypeTextLineHeight(height: number | string | Resource): AudioTheme {
    this.audioTypeTextLineHeight = height
    return this
  }

  /**
   * 设置音频按钮背景颜色
   *
   * @param color 背景颜色
   * @return AudioTheme
   */
  setAudioButtonBackgroundColor(color: ResourceColor): AudioTheme {
    this.audioButtonBackgroundColor = color
    return this
  }

  /**
   * 设置音频按钮宽度
   *
   * @param width 按钮宽度
   * @return AudioTheme
   */
  setAudioButtonWidth(width: Length): AudioTheme {
    this.audioButtonWidth = width
    return this
  }

  /**
   * 设置音频按钮高度
   *
   * @param height 按钮高度
   * @return AudioTheme
   */
  setAudioButtonHeight(height: Length): AudioTheme {
    this.audioButtonHeight = height
    return this
  }

  /**
   * 设置音频按钮边框样式
   *
   * @param borderStyle 边框样式
   * @return AudioTheme
   */
  setAudioButtonBorderStyle(borderStyle: BorderStyle): AudioTheme {
    this.audioButtonBorderStyle = borderStyle
    return this
  }

  /**
   * 设置音频按钮边框宽度
   *
   * @param borderWidth 边框宽度
   * @return AudioTheme
   */
  setAudioButtonBorderWidth(borderWidth: Length): AudioTheme {
    this.audioButtonBorderWidth = borderWidth
    return this
  }

  /**
   * 设置音频按钮边框颜色
   *
   * @param borderColor 边框颜色
   * @return AudioTheme
   */
  setAudioButtonBorderColor(borderColor: ResourceColor): AudioTheme {
    this.audioButtonBorderColor = borderColor
    return this
  }

  /**
   * 设置音频按钮圆角
   *
   * @param options 圆角选项或统一数值
   * @return AudioTheme
   */
  setAudioButtonRadius(options: BorderRadiuses | Length): AudioTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.audioButtonRadiusTopLeft = options
      this.audioButtonRadiusTopRight = options
      this.audioButtonRadiusBottomLeft = options
      this.audioButtonRadiusBottomRight = options
    }
    // 2. 如果是 object，它要么是 BorderRadiuses，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 BorderRadiuses 的专属属性来区分
      // 如果包含 topLeft/topRight/bottomLeft/bottomRight 任意一个，就当作 BorderRadiuses 处理
      if (isBorderRadiuses(options)) {
        // 这里通过类型守卫，编译器已经知道它是 BorderRadiuses 了
        const radius = options as BorderRadiuses
        if (radius.topLeft !== undefined) {
          this.audioButtonRadiusTopLeft = radius.topLeft
        }
        if (radius.topRight !== undefined) {
          this.audioButtonRadiusTopRight = radius.topRight
        }
        if (radius.bottomLeft !== undefined) {
          this.audioButtonRadiusBottomLeft = radius.bottomLeft
        }
        if (radius.bottomRight !== undefined) {
          this.audioButtonRadiusBottomRight = radius.bottomRight
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.audioButtonRadiusTopLeft = options as Length
        this.audioButtonRadiusTopRight = options as Length
        this.audioButtonRadiusBottomLeft = options as Length
        this.audioButtonRadiusBottomRight = options as Length
      }
    }
    return this
  }

  /**
   * 设置音频按钮文本
   *
   * @param text 按钮文本
   * @return AudioTheme
   */
  setAudioButtonText(text: string): AudioTheme {
    this.audioButtonText = text
    return this
  }

  /**
   * 设置音频按钮文本字体颜色
   *
   * @param color 字体颜色
   * @return AudioTheme
   */
  setAudioButtonTextFontColor(color: ResourceColor): AudioTheme {
    this.audioButtonTextFontColor = color
    return this
  }

  /**
   * 设置音频按钮文本字体大小
   *
   * @param size 字体大小
   * @return AudioTheme
   */
  setAudioButtonTextFontSize(size: number | string | Resource): AudioTheme {
    this.audioButtonTextFontSize = size
    return this
  }

  /**
   * 设置音频按钮文本字体样式
   *
   * @param style 字体样式
   * @return AudioTheme
   */
  setAudioButtonTextFontStyle(style: FontStyle): AudioTheme {
    this.audioButtonTextFontStyle = style
    return this
  }

  /**
   * 设置音频按钮文本字体粗细
   *
   * @param weight 字体粗细
   * @return AudioTheme
   */
  setAudioButtonTextFontWeight(weight: number | FontWeight): AudioTheme {
    this.audioButtonTextFontWeight = weight
    return this
  }

  /**
   * 设置音频按钮文本字体族
   *
   * @param family 字体族
   * @return AudioTheme
   */
  setAudioButtonTextFontFamily(family: string | Resource): AudioTheme {
    this.audioButtonTextFontFamily = family
    return this
  }

  /**
   * 设置音频按钮文本行高
   *
   * @param height 行高
   * @return AudioTheme
   */
  setAudioButtonTextLineHeight(height: number | string | Resource): AudioTheme {
    this.audioButtonTextLineHeight = height
    return this
  }
}
