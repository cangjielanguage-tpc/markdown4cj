package markdown.components.theme

/**
 * 音频样式
 */
public class AudioTheme <: MarkdownBaseTheme {
    public var audioBackgroundColor: Color = COLOR_TRANSPARENT // 音频背景颜色
    public var audioMarginTop: Float64 = 0.0 // 音频上外边距
    public var audioMarginRight: Float64 = 0.0 // 音频右外边距
    public var audioMarginBottom: Float64 = 0.0 // 音频下外边距
    public var audioMarginLeft: Float64 = 0.0 // 音频左外边距
    public var audioPaddingTop: Float64 = 12.0 // 音频上内边距
    public var audioPaddingRight: Float64 = 16.0 // 音频右内边距
    public var audioPaddingBottom: Float64 = 12.0 // 音频下内边距
    public var audioPaddingLeft: Float64 = 12.0 // 音频左内边距
    public var audioBorderStyle: BorderStyle = BorderStyle.Solid // 音频边框样式
    public var audioBorderWidth: Float64 = 0.5 // 音频边框宽度
    public var audioBorderColor: Color = COLOR_33000000 // 音频边框颜色
    public var audioRadiusTopLeft: Float64 = 12.0 // 音频边框左上圆角
    public var audioRadiusTopRight: Float64 = 12.0 // 音频边框右上圆角
    public var audioRadiusBottomLeft: Float64 = 12.0 // 音频边框左下圆角
    public var audioRadiusBottomRight: Float64 = 12.0 // 音频边框右下圆角
    public var audioShadowRadius: Float64 = 12.0 // 音频阴影模糊半径
    public var audioShadowColor: Color = COLOR_1A000000 // 音频阴影颜色值
    public var audioShadowOffsetX: Float64 = 0.0 // 音频阴影X轴偏移量
    public var audioShadowOffsetY: Float64 = 2.0 // 音频阴影Y轴偏移量
    public var audioIcon: ?AppResource = None // 音频图标
    public var audioIconWidth: Float64 = 40.0 // 音频图标宽度
    public var audioIconHeight: Float64 = 40.0 // 音频图标高度
    public var audioIconRadiusTopLeft: Float64 = 8.0 // 音频图标左上圆角
    public var audioIconRadiusTopRight: Float64 = 8.0 // 音频图标右上圆角
    public var audioIconRadiusBottomLeft: Float64 = 8.0 // 音频图标左下圆角
    public var audioIconRadiusBottomRight: Float64 = 8.0 // 音频图标右下圆角
    public var audioIconFitType: ImageFit = ImageFit.Cover // 音频图标缩放类型
    public var audioTitleToTypeSpacing: Float64 = 2.0 // 音频标题文本和类型文本间距
    public var audioTitleTextFontColor: Color = COLOR_BLACK // 音频标题文本颜色
    public var audioTitleTextFontSize: Float64 = 15.0 // 音频标题文本尺寸
    public var audioTitleTextFontStyle: FontStyle = FontStyle.Normal // 音频标题文本字体样式
    public var audioTitleTextFontWeight: FontWeight = FontWeight.W700 // 音频标题文本字体粗细
    public var audioTitleTextFontFamily: String = "HarmonyOS Sans" // 音频标题文本字体
    public var audioTitleTextLineHeight: Float64 = 20.0 // 音频标题文本行高
    public var audioTypeTextFontColor: Color = COLOR_80000000 // 音频类型文本颜色
    public var audioTypeTextFontSize: Float64 = 11.0 // 音频类型文本尺寸
    public var audioTypeTextFontStyle: FontStyle = FontStyle.Normal // 音频类型文本字体样式
    public var audioTypeTextFontWeight: FontWeight = FontWeight.W400 // 音频类型文本字体粗细
    public var audioTypeTextFontFamily: String = "HarmonyOS Sans" // 音频类型文本字体
    public var audioTypeTextLineHeight: Float64 = 15.0 // 音频类型文本行高
    public var audioButtonBackgroundColor: Color = COLOR_BLACK // 音频按钮背景颜色
    public var audioButtonWidth: Float64 = 84.0 // 音频按钮宽度
    public var audioButtonHeight: Float64 = 32.0 // 音频按钮高度
    public var audioButtonBorderStyle: BorderStyle = BorderStyle.Solid // 音频按钮边框样式
    public var audioButtonBorderWidth: Float64 = 0.0 // 音频按钮边框宽度
    public var audioButtonBorderColor: Color = COLOR_TRANSPARENT // 音频按钮边框颜色
    public var audioButtonRadiusTopLeft: Float64 = 16.0 // 音频按钮边框左上圆角
    public var audioButtonRadiusTopRight: Float64 = 16.0 // 音频按钮边框右上圆角
    public var audioButtonRadiusBottomLeft: Float64 = 16.0 // 音频按钮边框左下圆角
    public var audioButtonRadiusBottomRight: Float64 = 16.0 // 音频按钮边框右下圆角
    public var audioButtonText: String = "立即播放" // 音频按钮默认文本内容
    public var audioButtonTextFontColor: Color = COLOR_WHITE // 音频按钮文本颜色
    public var audioButtonTextFontSize: Float64 = 14.0 // 音频按钮文本尺寸
    public var audioButtonTextFontStyle: FontStyle = FontStyle.Normal // 音频按钮文本字体样式
    public var audioButtonTextFontWeight: FontWeight = FontWeight.W500 // 音频按钮文本字体粗细
    public var audioButtonTextFontFamily: String = "HarmonyOS Sans" // 音频按钮文本字体
    public var audioButtonTextLineHeight: Float64 = 22.0 // 音频按钮文本行高

    /**
     * 设置音频背景颜色
     *
     * @param color 音频背景颜色
     * @return 当前AudioTheme对象
     */
    public func setAudioBackgroundColor(color: Color): AudioTheme {
        this.audioBackgroundColor = color
        return this
    }

    /**
     * 统一设置音频整体外边距
     *
     * @param margin 外边距
     * @return 当前AudioTheme对象
     */
    public func setAudioMargin(margin: Float64): AudioTheme {
        this.audioMarginTop = margin
        this.audioMarginRight = margin
        this.audioMarginBottom = margin
        this.audioMarginLeft = margin
        return this
    }

    /**
     * 分别设置音频四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前AudioTheme对象
     */
    public func setAudioMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): AudioTheme {
        this.audioMarginTop = top
        this.audioMarginRight = right
        this.audioMarginBottom = bottom
        this.audioMarginLeft = left
        return this
    }

    /**
     * 统一设置音频整体内边距
     *
     * @param padding 内边距
     * @return 当前AudioTheme对象
     */
    public func setAudioPadding(padding: Float64): AudioTheme {
        this.audioPaddingTop = padding
        this.audioPaddingRight = padding
        this.audioPaddingBottom = padding
        this.audioPaddingLeft = padding
        return this
    }

    /**
     * 分别设置音频四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前AudioTheme对象
     */
    public func setAudioPadding(top!: Float64 = 12.0, right!: Float64 = 16.0, bottom!: Float64 = 12.0, left!: Float64 = 12.0): AudioTheme {
        this.audioPaddingTop = top
        this.audioPaddingRight = right
        this.audioPaddingBottom = bottom
        this.audioPaddingLeft = left
        return this
    }

    /**
     * 设置音频边框样式
     *
     * @param borderStyle 音频边框样式
     * @return 当前AudioTheme对象
     */
    public func setAudioBorderStyle(borderStyle: BorderStyle): AudioTheme {
        this.audioBorderStyle = borderStyle
        return this
    }

    /**
     * 设置音频边框宽度
     *
     * @param borderWidth 音频边框宽度
     * @return 当前AudioTheme对象
     */
    public func setAudioBorderWidth(borderWidth: Float64): AudioTheme {
        this.audioBorderWidth = borderWidth
        return this
    }

    /**
     * 设置音频边框颜色
     *
     * @param borderColor 音频边框颜色
     * @return 当前AudioTheme对象
     */
    public func setAudioBorderColor(borderColor: Color): AudioTheme {
        this.audioBorderColor = borderColor
        return this
    }

    /**
     * 统一设置音频整体圆角
     *
     * @param radius 圆角
     * @return 当前AudioTheme对象
     */
    public func setAudioRadius(radius: Float64): AudioTheme {
        this.audioRadiusTopLeft = radius
        this.audioRadiusTopRight = radius
        this.audioRadiusBottomLeft = radius
        this.audioRadiusBottomRight = radius
        return this
    }

    /**
     * 分别设置音频四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前AudioTheme对象
     */
    public func setAudioRadius(topLeft!: Float64 = 12.0, topRight!: Float64 = 12.0, bottomLeft!: Float64 = 12.0, bottomRight!: Float64 = 12.0): AudioTheme {
        this.audioRadiusTopLeft = topLeft
        this.audioRadiusTopRight = topRight
        this.audioRadiusBottomLeft = bottomLeft
        this.audioRadiusBottomRight = bottomRight
        return this
    }

    /**
     * 设置音频阴影模糊半径
     *
     * @param radius 音频阴影模糊半径
     * @return 当前AudioTheme对象
     */
    public func setAudioShadowRadius(radius: Float64): AudioTheme {
        this.audioShadowRadius = radius
        return this
    }

    /**
     * 设置音频阴影颜色
     *
     * @param color 音频阴影颜色
     * @return 当前AudioTheme对象
     */
    public func setAudioShadowColor(color: Color): AudioTheme {
        this.audioShadowColor = color
        return this
    }

    /**
     * 设置音频阴影X轴偏移量
     *
     * @param offsetX 音频阴影X轴偏移量
     * @return 当前AudioTheme对象
     */
    public func setAudioShadowOffsetX(offsetX: Float64): AudioTheme {
        this.audioShadowOffsetX = offsetX
        return this
    }

    /**
     * 设置音频阴影Y轴偏移量
     *
     * @param offsetY 音频阴影Y轴偏移量
     * @return 当前AudioTheme对象
     */
    public func setAudioShadowOffsetY(offsetY: Float64): AudioTheme {
        this.audioShadowOffsetY = offsetY
        return this
    }

    /**
     * 设置音频图标
     *
     * @param icon 音频图标
     * @return 当前AudioTheme对象
     */
    public func setAudioIcon(icon: AppResource): AudioTheme {
        this.audioIcon = icon
        return this
    }

    /**
     * 设置音频图标宽度
     *
     * @param width 音频图标宽度
     * @return 当前AudioTheme对象
     */
    public func setAudioIconWidth(width: Float64): AudioTheme {
        this.audioIconWidth = width
        return this
    }

    /**
     * 设置音频图标高度
     *
     * @param height 音频图标高度
     * @return 当前AudioTheme对象
     */
    public func setAudioIconHeight(height: Float64): AudioTheme {
        this.audioIconHeight = height
        return this
    }

    /**
     * 统一设置音频图标整体圆角
     *
     * @param radius 圆角
     * @return 当前AudioTheme对象
     */
    public func setAudioIconRadius(radius: Float64): AudioTheme {
        this.audioIconRadiusTopLeft = radius
        this.audioIconRadiusTopRight = radius
        this.audioIconRadiusBottomLeft = radius
        this.audioIconRadiusBottomRight = radius
        return this
    }

    /**
     * 分别设置音频图标四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前AudioTheme对象
     */
    public func setAudioIconRadius(topLeft!: Float64 = 8.0, topRight!: Float64 = 8.0, bottomLeft!: Float64 = 8.0, bottomRight!: Float64 = 8.0): AudioTheme {
        this.audioIconRadiusTopLeft = topLeft
        this.audioIconRadiusTopRight = topRight
        this.audioIconRadiusBottomLeft = bottomLeft
        this.audioIconRadiusBottomRight = bottomRight
        return this
    }

    /**
     * 设置音频图标缩放类型
     *
     * @param fitType 音频图标缩放类型
     * @return 当前AudioTheme对象
     */
    public func setAudioIconFitType(fitType: ImageFit): AudioTheme {
        this.audioIconFitType = fitType
        return this
    }

    /**
     * 设置音频标题文本和类型文本间距
     *
     * @param spacing 音频标题文本和类型文本间距
     * @return 当前AudioTheme对象
     */
    public func setAudioTitleToTypeSpacing(spacing: Float64): AudioTheme {
        this.audioTitleToTypeSpacing = spacing
        return this
    }

    /**
     * 设置音频标题文本颜色
     *
     * @param color 音频标题文本颜色
     * @return 当前AudioTheme对象
     */
    public func setAudioTitleTextFontColor(color: Color): AudioTheme {
        this.audioTitleTextFontColor = color
        return this
    }

    /**
     * 设置音频标题文本尺寸
     *
     * @param size 音频标题文本尺寸
     * @return 当前AudioTheme对象
     */
    public func setAudioTitleTextFontSize(size: Float64): AudioTheme {
        this.audioTitleTextFontSize = size
        return this
    }

    /**
     * 设置音频标题文本字体样式
     *
     * @param style 音频标题文本字体样式
     * @return 当前AudioTheme对象
     */
    public func setAudioTitleTextFontStyle(style: FontStyle): AudioTheme {
        this.audioTitleTextFontStyle = style
        return this
    }

    /**
     * 设置音频标题文本字体粗细
     *
     * @param weight 音频标题文本字体粗细
     * @return 当前AudioTheme对象
     */
    public func setAudioTitleTextFontWeight(weight: FontWeight): AudioTheme {
        this.audioTitleTextFontWeight = weight
        return this
    }

    /**
     * 设置音频标题文本字体
     *
     * @param family 音频标题文本字体
     * @return 当前AudioTheme对象
     */
    public func setAudioTitleTextFontFamily(family: String): AudioTheme {
        this.audioTitleTextFontFamily = family
        return this
    }

    /**
     * 设置音频标题文本行高
     *
     * @param height 音频标题文本行高
     * @return 当前AudioTheme对象
     */
    public func setAudioTitleTextLineHeight(height: Float64): AudioTheme {
        this.audioTitleTextLineHeight = height
        return this
    }

    /**
     * 设置音频类型文本颜色
     *
     * @param color 音频类型文本颜色
     * @return 当前AudioTheme对象
     */
    public func setAudioTypeTextFontColor(color: Color): AudioTheme {
        this.audioTypeTextFontColor = color
        return this
    }

    /**
     * 设置音频类型文本尺寸
     *
     * @param size 音频类型文本尺寸
     * @return 当前AudioTheme对象
     */
    public func setAudioTypeTextFontSize(size: Float64): AudioTheme {
        this.audioTypeTextFontSize = size
        return this
    }

    /**
     * 设置音频类型文本字体样式
     *
     * @param style 音频类型文本字体样式
     * @return 当前AudioTheme对象
     */
    public func setAudioTypeTextFontStyle(style: FontStyle): AudioTheme {
        this.audioTypeTextFontStyle = style
        return this
    }

    /**
     * 设置音频类型文本字体粗细
     *
     * @param weight 音频类型文本字体粗细
     * @return 当前AudioTheme对象
     */
    public func setAudioTypeTextFontWeight(weight: FontWeight): AudioTheme {
        this.audioTypeTextFontWeight = weight
        return this
    }

    /**
     * 设置音频类型文本字体
     *
     * @param family 音频类型文本字体
     * @return 当前AudioTheme对象
     */
    public func setAudioTypeTextFontFamily(family: String): AudioTheme {
        this.audioTypeTextFontFamily = family
        return this
    }

    /**
     * 设置音频类型文本行高
     *
     * @param height 音频类型文本行高
     * @return 当前AudioTheme对象
     */
    public func setAudioTypeTextLineHeight(height: Float64): AudioTheme {
        this.audioTypeTextLineHeight = height
        return this
    }

    /**
     * 设置音频按钮背景颜色
     *
     * @param color 音频按钮背景颜色
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonBackgroundColor(color: Color): AudioTheme {
        this.audioButtonBackgroundColor = color
        return this
    }

    /**
     * 设置音频按钮宽度
     *
     * @param width 音频按钮宽度
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonWidth(width: Float64): AudioTheme {
        this.audioButtonWidth = width
        return this
    }

    /**
     * 设置音频按钮高度
     *
     * @param height 音频按钮高度
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonHeight(height: Float64): AudioTheme {
        this.audioButtonHeight = height
        return this
    }

    /**
     * 设置音频按钮边框样式
     *
     * @param borderStyle 音频按钮边框样式
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonBorderStyle(borderStyle: BorderStyle): AudioTheme {
        this.audioButtonBorderStyle = borderStyle
        return this
    }

    /**
     * 设置音频按钮边框宽度
     *
     * @param borderWidth 音频按钮边框宽度
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonBorderWidth(borderWidth: Float64): AudioTheme {
        this.audioButtonBorderWidth = borderWidth
        return this
    }

    /**
     * 设置音频按钮边框颜色
     *
     * @param borderColor 音频按钮边框颜色
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonBorderColor(borderColor: Color): AudioTheme {
        this.audioButtonBorderColor = borderColor
        return this
    }

    /**
     * 统一设置音频按钮整体圆角
     *
     * @param radius 圆角
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonRadius(radius: Float64): AudioTheme {
        this.audioButtonRadiusTopLeft = radius
        this.audioButtonRadiusTopRight = radius
        this.audioButtonRadiusBottomLeft = radius
        this.audioButtonRadiusBottomRight = radius
        return this
    }

    /**
     * 分别设置音频按钮四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonRadius(topLeft!: Float64 = 16.0, topRight!: Float64 = 16.0, bottomLeft!: Float64 = 16.0, bottomRight!: Float64 = 16.0): AudioTheme {
        this.audioButtonRadiusTopLeft = topLeft
        this.audioButtonRadiusTopRight = topRight
        this.audioButtonRadiusBottomLeft = bottomLeft
        this.audioButtonRadiusBottomRight = bottomRight
        return this
    }

    /**
     * 设置音频按钮默认文本内容
     *
     * @param text 音频按钮默认文本内容
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonText(text: String): AudioTheme {
        this.audioButtonText = text
        return this
    }

    /**
     * 设置音频按钮文本颜色
     *
     * @param color 音频按钮文本颜色
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonTextFontColor(color: Color): AudioTheme {
        this.audioButtonTextFontColor = color
        return this
    }

    /**
     * 设置音频按钮文本尺寸
     *
     * @param size 音频按钮文本尺寸
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonTextFontSize(size: Float64): AudioTheme {
        this.audioButtonTextFontSize = size
        return this
    }

    /**
     * 设置音频按钮文本字体样式
     *
     * @param style 音频按钮文本字体样式
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonTextFontStyle(style: FontStyle): AudioTheme {
        this.audioButtonTextFontStyle = style
        return this
    }

    /**
     * 设置音频按钮文本字体粗细
     *
     * @param weight 音频按钮文本字体粗细
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonTextFontWeight(weight: FontWeight): AudioTheme {
        this.audioButtonTextFontWeight = weight
        return this
    }

    /**
     * 设置音频按钮文本字体
     *
     * @param family 音频按钮文本字体
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonTextFontFamily(family: String): AudioTheme {
        this.audioButtonTextFontFamily = family
        return this
    }

    /**
     * 设置音频按钮文本行高
     *
     * @param height 音频按钮文本行高
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonTextLineHeight(height: Float64): AudioTheme {
        this.audioButtonTextLineHeight = height
        return this
    }
}