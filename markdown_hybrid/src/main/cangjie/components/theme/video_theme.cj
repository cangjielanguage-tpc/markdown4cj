package markdown.components.theme

/**
 * 视频样式
 */
public class VideoTheme <: MarkdownBaseTheme {
    public var videoBackgroundColor: Color = COLOR_TRANSPARENT // 视频背景颜色
    public var videoMarginTop: Float64 = 0.0 // 视频上外边距
    public var videoMarginRight: Float64 = 0.0 // 视频右外边距
    public var videoMarginBottom: Float64 = 0.0 // 视频下外边距
    public var videoMarginLeft: Float64 = 0.0 // 视频左外边距
    public var videoPaddingTop: Float64 = 0.0 // 视频上内边距
    public var videoPaddingRight: Float64 = 0.0 // 视频右内边距
    public var videoPaddingBottom: Float64 = 0.0 // 视频下内边距
    public var videoPaddingLeft: Float64 = 0.0 // 视频左内边距
    public var videoRadiusTopLeft: Float64 = 10.0 // 视频边框左上圆角
    public var videoRadiusTopRight: Float64 = 10.0 // 视频边框右上圆角
    public var videoRadiusBottomLeft: Float64 = 10.0 // 视频边框左下圆角
    public var videoRadiusBottomRight: Float64 = 10.0 // 视频边框右下圆角
    public var videoBorderStyle: BorderStyle = BorderStyle.Solid // 视频边框样式
    public var videoBorderWidth: Float64 = 0.0 // 视频边框宽度
    public var videoBorderColor: Color = COLOR_TRANSPARENT // 视频边框颜色
    public var videoPlaceholder: ?AppResource = None // 视频占位图
    public var videoImageFitType: ImageFit = ImageFit.Cover // 视频图片缩放类型
    public var videoPlayIcon: ?AppResource = None // 播放按钮默认图片
    public var videoPlayIconWidth: Float64 = 60.0 // 播放按钮图标宽度
    public var videoPlayIconHeight: Float64 = 60.0 // 播放按钮图标高度
    public var videoPlayIconFitType: ImageFit = ImageFit.Contain // 播放按钮图标缩放类型
    public var videoTimeTextFontColor: Color = COLOR_WHITE // 视频时间文本颜色
    public var videoTimeTextFontSize: Float64 = 14.0 // 视频时间文本尺寸
    public var videoTimeTextFontStyle: FontStyle = FontStyle.Normal // 视频时间文本字体样式
    public var videoTimeTextFontWeight: FontWeight = FontWeight.W400 // 视频时间文本字体粗细
    public var videoTimeTextFontFamily: String = "HarmonyOS Sans" // 视频时间文本字体
    public var videoTimeTextLineHeight: Float64 = 22.0 // 视频时间文本行高
    public var videoTimeTextMarginRight: Float64 = 10.0 // 视频时间文本居右边距
    public var videoTimeTextMarginBottom: Float64 = 10.0 // 视频时间文本居底边距
    public var videoBottomLayoutVisible: Bool = false // 底部布局是否显示（视频发布/下载按钮）
    public var videoBottomLayoutMarginTop: Float64 = 14.0 // 底部布局距离视频上边距
    public var videoReleaseButtonVisible: Bool = true // 视频发布按钮是否显示
    public var videoReleaseButtonBackgroundColor: Color = COLOR_FFF5F5F5 // 视频发布按钮背景颜色
    public var videoReleaseButtonWidth: Float64 = 144.0 // 视频发布按钮宽度
    public var videoReleaseButtonHeight: Float64 = 44.0 // 视频发布按钮高度
    public var videoReleaseButtonRadiusTopLeft: Float64 = 22.0 // 视频发布按钮左上圆角
    public var videoReleaseButtonRadiusTopRight: Float64 = 22.0 // 视频发布按钮右上圆角
    public var videoReleaseButtonRadiusBottomLeft: Float64 = 22.0 // 视频发布按钮左下圆角
    public var videoReleaseButtonRadiusBottomRight: Float64 = 22.0 // 视频发布按钮右下圆角
    public var videoReleaseButtonIconTextGap: Float64 = 6.0 // 视频发布按钮图标和文本间距
    public var videoReleaseButtonIcon: ?AppResource = None // 视频发布按钮图标
    public var videoReleaseButtonIconWidth: Float64 = 18.0 // 视频发布按钮图标宽度
    public var videoReleaseButtonIconHeight: Float64 = 18.0 // 视频发布按钮图标高度
    public var videoReleaseButtonText: String = "发布视频" // 视频发布按钮默认文本内容
    public var videoReleaseButtonTextFontColor: Color = COLOR_E6000000 // 视频发布按钮文本颜色
    public var videoReleaseButtonTextFontSize: Float64 = 16.0 // 视频发布按钮文本尺寸
    public var videoReleaseButtonTextFontStyle: FontStyle = FontStyle.Normal // 视频发布按钮文本字体样式
    public var videoReleaseButtonTextFontWeight: FontWeight = FontWeight.W500 // 视频发布按钮文本字体粗细
    public var videoReleaseButtonTextFontFamily: String = "HarmonyOS Sans" // 视频发布按钮文本字体
    public var videoReleaseButtonTextLineHeight: Float64 = 22.0 // 视频发布按钮文本行高
    public var videoDownloadButtonVisible: Bool = true // 视频下载按钮是否显示
    public var videoDownloadButtonBackgroundColor: Color = COLOR_FFF5F5F5 // 视频下载按钮背景颜色
    public var videoDownloadButtonWidth: Float64 = 144.0 // 视频下载按钮宽度
    public var videoDownloadButtonHeight: Float64 = 44.0 // 视频下载按钮高度
    public var videoDownloadButtonRadiusTopLeft: Float64 = 22.0 // 视频下载按钮左上圆角
    public var videoDownloadButtonRadiusTopRight: Float64 = 22.0 // 视频下载按钮右上圆角
    public var videoDownloadButtonRadiusBottomLeft: Float64 = 22.0 // 视频下载按钮左下圆角
    public var videoDownloadButtonRadiusBottomRight: Float64 = 22.0 // 视频下载按钮右下圆角
    public var videoDownloadButtonIconTextGap: Float64 = 6.0 // 视频下载按钮图标和文本间距
    public var videoDownloadButtonIcon: ?AppResource = None // 视频下载按钮图标
    public var videoDownloadButtonIconWidth: Float64 = 18.0 // 视频下载按钮图标宽度
    public var videoDownloadButtonIconHeight: Float64 = 18.0 // 视频下载按钮图标高度
    public var videoDownloadButtonText: String = "下载视频" // 视频下载按钮默认文本内容
    public var videoDownloadButtonTextFontColor: Color = COLOR_E6000000 // 视频下载按钮文本颜色
    public var videoDownloadButtonTextFontSize: Float64 = 16.0 // 视频下载按钮文本尺寸
    public var videoDownloadButtonTextFontStyle: FontStyle = FontStyle.Normal // 视频下载按钮文本字体样式
    public var videoDownloadButtonTextFontWeight: FontWeight = FontWeight.W500 // 视频下载按钮文本字体粗细
    public var videoDownloadButtonTextFontFamily: String = "HarmonyOS Sans" // 视频下载按钮文本字体
    public var videoDownloadButtonTextLineHeight: Float64 = 22.0 // 视频下载按钮文本行高

    /**
     * 设置视频背景颜色
     *
     * @param color 视频背景颜色
     * @return 当前VideoTheme对象
     */
    public func setVideoBackgroundColor(color: Color): VideoTheme {
        this.videoBackgroundColor = color
        return this
    }

    /**
     * 统一设置视频外边距
     *
     * @param margin 外边距
     * @return 当前VideoTheme对象
     */
    public func setVideoMargin(margin: Float64): VideoTheme {
        this.videoMarginTop = margin
        this.videoMarginRight = margin
        this.videoMarginBottom = margin
        this.videoMarginLeft = margin
        return this
    }

    /**
     * 分别设置视频四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前VideoTheme对象
     */
    public func setVideoMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): VideoTheme {
        this.videoMarginTop = top
        this.videoMarginRight = right
        this.videoMarginBottom = bottom
        this.videoMarginLeft = left
        return this
    }

    /**
     * 统一设置视频内边距
     *
     * @param padding 内边距
     * @return 当前VideoTheme对象
     */
    public func setVideoPadding(padding: Float64): VideoTheme {
        this.videoPaddingTop = padding
        this.videoPaddingRight = padding
        this.videoPaddingBottom = padding
        this.videoPaddingLeft = padding
        return this
    }

    /**
     * 分别设置视频四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前VideoTheme对象
     */
    public func setVideoPadding(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): VideoTheme {
        this.videoPaddingTop = top
        this.videoPaddingRight = right
        this.videoPaddingBottom = bottom
        this.videoPaddingLeft = left
        return this
    }

    /**
     * 统一设置视频整体圆角
     *
     * @param radius 圆角
     * @return 当前VideoTheme对象
     */
    public func setVideoRadius(radius: Float64): VideoTheme {
        this.videoRadiusTopLeft = radius
        this.videoRadiusTopRight = radius
        this.videoRadiusBottomLeft = radius
        this.videoRadiusBottomRight = radius
        return this
    }

    /**
     * 分别设置视频四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前VideoTheme对象
     */
    public func setVideoRadius(topLeft!: Float64 = 10.0, topRight!: Float64 = 10.0, bottomLeft!: Float64 = 10.0, bottomRight!: Float64 = 10.0): VideoTheme {
        this.videoRadiusTopLeft = topLeft
        this.videoRadiusTopRight = topRight
        this.videoRadiusBottomLeft = bottomLeft
        this.videoRadiusBottomRight = bottomRight
        return this
    }

    /**
     * 设置视频边框样式
     *
     * @param borderStyle 视频边框样式
     * @return 当前VideoTheme对象
     */
    public func setVideoBorderStyle(borderStyle: BorderStyle): VideoTheme {
        this.videoBorderStyle = borderStyle
        return this
    }

    /**
     * 设置视频边框宽度
     *
     * @param borderWidth 视频边框宽度
     * @return 当前VideoTheme对象
     */
    public func setVideoBorderWidth(borderWidth: Float64): VideoTheme {
        this.videoBorderWidth = borderWidth
        return this
    }

    /**
     * 设置视频边框颜色
     *
     * @param borderColor 视频边框颜色
     * @return 当前VideoTheme对象
     */
    public func setVideoBorderColor(borderColor: Color): VideoTheme {
        this.videoBorderColor = borderColor
        return this
    }

    /**
     * 设置视频占位图
     *
     * @param resource 视频占位图
     * @return 当前VideoTheme对象
     */
    public func setVideoPlaceholder(resource: AppResource): VideoTheme {
        this.videoPlaceholder = resource
        return this
    }

    /**
     * 设置视频图片缩放类型
     *
     * @param fitType 视频图片缩放类型
     * @return 当前VideoTheme对象
     */
    public func setVideoImageFitType(fitType: ImageFit): VideoTheme {
        this.videoImageFitType = fitType
        return this
    }

    /**
     * 设置播放按钮默认图片
     *
     * @param icon 播放按钮默认图片
     * @return 当前VideoTheme对象
     */
    public func setVideoPlayIcon(icon: AppResource): VideoTheme {
        this.videoPlayIcon = icon
        return this
    }

    /**
     * 设置播放按钮图标宽度
     *
     * @param width 播放按钮图标宽度
     * @return 当前VideoTheme对象
     */
    public func setVideoPlayIconWidth(width: Float64): VideoTheme {
        this.videoPlayIconWidth = width
        return this
    }

    /**
     * 设置播放按钮图标高度
     *
     * @param height 播放按钮图标高度
     * @return 当前VideoTheme对象
     */
    public func setVideoPlayIconHeight(height: Float64): VideoTheme {
        this.videoPlayIconHeight = height
        return this
    }

    /**
     * 设置播放按钮图标缩放类型
     *
     * @param fitType 播放按钮图标缩放类型
     * @return 当前VideoTheme对象
     */
    public func setVideoPlayIconFitType(fitType: ImageFit): VideoTheme {
        this.videoPlayIconFitType = fitType
        return this
    }

    /**
     * 设置视频时间文本颜色
     *
     * @param color 视频时间文本颜色
     * @return 当前VideoTheme对象
     */
    public func setVideoTimeTextFontColor(color: Color): VideoTheme {
        this.videoTimeTextFontColor = color
        return this
    }

    /**
     * 设置视频时间文本尺寸
     *
     * @param size 视频时间文本尺寸
     * @return 当前VideoTheme对象
     */
    public func setVideoTimeTextFontSize(size: Float64): VideoTheme {
        this.videoTimeTextFontSize = size
        return this
    }

    /**
     * 设置视频时间文本字体样式
     *
     * @param style 视频时间文本字体样式
     * @return 当前VideoTheme对象
     */
    public func setVideoTimeTextFontStyle(style: FontStyle): VideoTheme {
        this.videoTimeTextFontStyle = style
        return this
    }

    /**
     * 设置视频时间文本字体粗细
     *
     * @param weight 视频时间文本字体粗细
     * @return 当前VideoTheme对象
     */
    public func setVideoTimeTextFontWeight(weight: FontWeight): VideoTheme {
        this.videoTimeTextFontWeight = weight
        return this
    }

    /**
     * 设置视频时间文本字体
     *
     * @param family 视频时间文本字体
     * @return 当前VideoTheme对象
     */
    public func setVideoTimeTextFontFamily(family: String): VideoTheme {
        this.videoTimeTextFontFamily = family
        return this
    }

    /**
     * 设置视频时间文本行高
     *
     * @param height 视频时间文本行高
     * @return 当前VideoTheme对象
     */
    public func setVideoTimeTextLineHeight(height: Float64): VideoTheme {
        this.videoTimeTextLineHeight = height
        return this
    }

    /**
     * 设置视频时间文本居右边距
     *
     * @param margin 视频时间文本居右边距
     * @return 当前VideoTheme对象
     */
    public func setVideoTimeTextMarginRight(margin: Float64): VideoTheme {
        this.videoTimeTextMarginRight = margin
        return this
    }

    /**
     * 设置视频时间文本居底边距
     *
     * @param margin 视频时间文本居底边距
     * @return 当前VideoTheme对象
     */
    public func setVideoTimeTextMarginBottom(margin: Float64): VideoTheme {
        this.videoTimeTextMarginBottom = margin
        return this
    }

    /**
     * 设置底部布局是否显示
     *
     * @param visible 底部布局是否显示
     * @return 当前VideoTheme对象
     */
    public func setVideoBottomLayoutVisible(visible: Bool): VideoTheme {
        this.videoBottomLayoutVisible = visible
        return this
    }

    /**
     * 设置底部布局距离视频上边距
     *
     * @param marginTop 底部布局距离视频上边距
     * @return 当前VideoTheme对象
     */
    public func setVideoBottomLayoutMarginTop(marginTop: Float64): VideoTheme {
        this.videoBottomLayoutMarginTop = marginTop
        return this
    }

    /**
     * 设置视频发布按钮是否显示
     *
     * @param visible 视频发布按钮是否显示
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonVisible(visible: Bool): VideoTheme {
        this.videoReleaseButtonVisible = visible
        return this
    }

    /**
     * 设置视频发布按钮背景颜色
     *
     * @param color 视频发布按钮背景颜色
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonBackgroundColor(color: Color): VideoTheme {
        this.videoReleaseButtonBackgroundColor = color
        return this
    }

    /**
     * 设置视频发布按钮宽度
     *
     * @param width 视频发布按钮宽度
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonWidth(width: Float64): VideoTheme {
        this.videoReleaseButtonWidth = width
        return this
    }

    /**
     * 设置视频发布按钮高度
     *
     * @param height 视频发布按钮高度
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonHeight(height: Float64): VideoTheme {
        this.videoReleaseButtonHeight = height
        return this
    }

    /**
     * 统一设置视频发布按钮整体圆角
     *
     * @param radius 圆角
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonRadius(radius: Float64): VideoTheme {
        this.videoReleaseButtonRadiusTopLeft = radius
        this.videoReleaseButtonRadiusTopRight = radius
        this.videoReleaseButtonRadiusBottomLeft = radius
        this.videoReleaseButtonRadiusBottomRight = radius
        return this
    }

    /**
     * 分别设置视频发布按钮四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonRadius(topLeft!: Float64 = 22.0, topRight!: Float64 = 22.0, bottomLeft!: Float64 = 22.0, bottomRight!: Float64 = 22.0): VideoTheme {
        this.videoReleaseButtonRadiusTopLeft = topLeft
        this.videoReleaseButtonRadiusTopRight = topRight
        this.videoReleaseButtonRadiusBottomLeft = bottomLeft
        this.videoReleaseButtonRadiusBottomRight = bottomRight
        return this
    }

    /**
     * 设置视频发布按钮图标和文本间距
     *
     * @param gap 视频发布按钮图标和文本间距
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonIconTextGap(gap: Float64): VideoTheme {
        this.videoReleaseButtonIconTextGap = gap
        return this
    }

    /**
     * 设置视频发布按钮图标
     *
     * @param icon 视频发布按钮图标
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonIcon(icon: AppResource): VideoTheme {
        this.videoReleaseButtonIcon = icon
        return this
    }

    /**
     * 设置视频发布按钮图标宽度
     *
     * @param width 视频发布按钮图标宽度
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonIconWidth(width: Float64): VideoTheme {
        this.videoReleaseButtonIconWidth = width
        return this
    }

    /**
     * 设置视频发布按钮图标高度
     *
     * @param height 视频发布按钮图标高度
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonIconHeight(height: Float64): VideoTheme {
        this.videoReleaseButtonIconHeight = height
        return this
    }

    /**
     * 设置视频发布按钮默认文本内容
     *
     * @param text 视频发布按钮默认文本内容
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonText(text: String): VideoTheme {
        this.videoReleaseButtonText = text
        return this
    }

    /**
     * 设置视频发布按钮文本颜色
     *
     * @param color 视频发布按钮文本颜色
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonTextFontColor(color: Color): VideoTheme {
        this.videoReleaseButtonTextFontColor = color
        return this
    }

    /**
     * 设置视频发布按钮文本尺寸
     *
     * @param size 视频发布按钮文本尺寸
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonTextFontSize(size: Float64): VideoTheme {
        this.videoReleaseButtonTextFontSize = size
        return this
    }

    /**
     * 设置视频发布按钮文本字体样式
     *
     * @param style 视频发布按钮文本字体样式
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonTextFontStyle(style: FontStyle): VideoTheme {
        this.videoReleaseButtonTextFontStyle = style
        return this
    }

    /**
     * 设置视频发布按钮文本字体粗细
     *
     * @param weight 视频发布按钮文本字体粗细
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonTextFontWeight(weight: FontWeight): VideoTheme {
        this.videoReleaseButtonTextFontWeight = weight
        return this
    }

    /**
     * 设置视频发布按钮文本字体
     *
     * @param family 视频发布按钮文本字体
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonTextFontFamily(family: String): VideoTheme {
        this.videoReleaseButtonTextFontFamily = family
        return this
    }

    /**
     * 设置视频发布按钮文本行高
     *
     * @param height 视频发布按钮文本行高
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonTextLineHeight(height: Float64): VideoTheme {
        this.videoReleaseButtonTextLineHeight = height
        return this
    }

    /**
     * 设置视频下载按钮是否显示
     *
     * @param visible 视频下载按钮是否显示
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonVisible(visible: Bool): VideoTheme {
        this.videoDownloadButtonVisible = visible
        return this
    }

    /**
     * 设置视频下载按钮背景颜色
     *
     * @param color 视频下载按钮背景颜色
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonBackgroundColor(color: Color): VideoTheme {
        this.videoDownloadButtonBackgroundColor = color
        return this
    }

    /**
     * 设置视频下载按钮宽度
     *
     * @param width 视频下载按钮宽度
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonWidth(width: Float64): VideoTheme {
        this.videoDownloadButtonWidth = width
        return this
    }

    /**
     * 设置视频下载按钮高度
     *
     * @param height 视频下载按钮高度
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonHeight(height: Float64): VideoTheme {
        this.videoDownloadButtonHeight = height
        return this
    }

    /**
     * 统一设置视频下载按钮整体圆角
     *
     * @param radius 圆角
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonRadius(radius: Float64): VideoTheme {
        this.videoDownloadButtonRadiusTopLeft = radius
        this.videoDownloadButtonRadiusTopRight = radius
        this.videoDownloadButtonRadiusBottomLeft = radius
        this.videoDownloadButtonRadiusBottomRight = radius
        return this
    }

    /**
     * 分别设置视频下载按钮四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonRadius(topLeft!: Float64 = 22.0, topRight!: Float64 = 22.0, bottomLeft!: Float64 = 22.0, bottomRight!: Float64 = 22.0): VideoTheme {
        this.videoDownloadButtonRadiusTopLeft = topLeft
        this.videoDownloadButtonRadiusTopRight = topRight
        this.videoDownloadButtonRadiusBottomLeft = bottomLeft
        this.videoDownloadButtonRadiusBottomRight = bottomRight
        return this
    }

    /**
     * 设置视频下载按钮图标和文本间距
     *
     * @param gap 视频下载按钮图标和文本间距
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonIconTextGap(gap: Float64): VideoTheme {
        this.videoDownloadButtonIconTextGap = gap
        return this
    }

    /**
     * 设置视频下载按钮图标
     *
     * @param icon 视频下载按钮图标
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonIcon(icon: AppResource): VideoTheme {
        this.videoDownloadButtonIcon = icon
        return this
    }

    /**
     * 设置视频下载按钮图标宽度
     *
     * @param width 视频下载按钮图标宽度
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonIconWidth(width: Float64): VideoTheme {
        this.videoDownloadButtonIconWidth = width
        return this
    }

    /**
     * 设置视频下载按钮图标高度
     *
     * @param height 视频下载按钮图标高度
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonIconHeight(height: Float64): VideoTheme {
        this.videoDownloadButtonIconHeight = height
        return this
    }

    /**
     * 设置视频下载按钮默认文本内容
     *
     * @param text 视频下载按钮默认文本内容
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonText(text: String): VideoTheme {
        this.videoDownloadButtonText = text
        return this
    }

    /**
     * 设置视频下载按钮文本颜色
     *
     * @param color 视频下载按钮文本颜色
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonTextFontColor(color: Color): VideoTheme {
        this.videoDownloadButtonTextFontColor = color
        return this
    }

    /**
     * 设置视频下载按钮文本尺寸
     *
     * @param size 视频下载按钮文本尺寸
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonTextFontSize(size: Float64): VideoTheme {
        this.videoDownloadButtonTextFontSize = size
        return this
    }

    /**
     * 设置视频下载按钮文本字体样式
     *
     * @param style 视频下载按钮文本字体样式
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonTextFontStyle(style: FontStyle): VideoTheme {
        this.videoDownloadButtonTextFontStyle = style
        return this
    }

    /**
     * 设置视频下载按钮文本字体粗细
     *
     * @param weight 视频下载按钮文本字体粗细
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonTextFontWeight(weight: FontWeight): VideoTheme {
        this.videoDownloadButtonTextFontWeight = weight
        return this
    }

    /**
     * 设置视频下载按钮文本字体
     *
     * @param family 视频下载按钮文本字体
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonTextFontFamily(family: String): VideoTheme {
        this.videoDownloadButtonTextFontFamily = family
        return this
    }

    /**
     * 设置视频下载按钮文本行高
     *
     * @param height 视频下载按钮文本行高
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonTextLineHeight(height: Float64): VideoTheme {
        this.videoDownloadButtonTextLineHeight = height
        return this
    }
}