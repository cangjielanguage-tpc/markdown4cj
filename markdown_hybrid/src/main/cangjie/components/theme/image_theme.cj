package markdown.components.theme

/**
 * 图片样式
 */
public class ImageTheme <: MarkdownBaseTheme {
    public var imageMarginTop: Float64 = 0.0 // 图片上外边距
    public var imageMarginRight: Float64 = 0.0 // 图片右外边距
    public var imageMarginBottom: Float64 = 0.0 // 图片下外边距
    public var imageMarginLeft: Float64 = 0.0 // 图片左外边距
    public var imageRadiusTopLeft: Float64 = 0.0 // 图片边框左上圆角
    public var imageRadiusTopRight: Float64 = 0.0 // 图片边框右上圆角
    public var imageRadiusBottomLeft: Float64 = 0.0 // 图片边框左下圆角
    public var imageRadiusBottomRight: Float64 = 0.0 // 图片边框右下圆角
    public var imageBorderStyle: BorderStyle = BorderStyle.Solid // 图片边框样式
    public var imageBorderWidth: Float64 = 0.0 // 图片边框宽度
    public var imageBorderColor: Color = COLOR_BLACK // 图片边框颜色
    public var imagePlaceholder: ?AppResource = None // 图片默认占位图
    public var imageAutoResize: Bool = true // 网络图片是否压缩
    public var isImageMixedLayout: Bool = true // 是否图文混排
    public var imageMaximumWidth: Float64 = 1.0 // 图片基于自身宽度缩放百分比
    public var imageFixedRatioWidth: ?Float64 = None // 图片基于父布局宽度缩放百分比
    public var imageMaxHeight: ?Float64 = None // 图片最大高度
    public var imageHeight: ?Float64 = None // 图片高度
    public var imageMaxWidth: ?Float64 = None // 图片最大宽度
    public var imageWidth: ?Float64 = None // 图片宽度
    public var imageFitType: ImageFit = ImageFit.Contain // 图片缩放类型
    public var imageBottomLayoutMarginTop: Float64 = 14.0 // 底部布局距离图片上边距
    public var imageDownloadButtonVisible: Bool = false // 图片下载按钮是否显示
    public var imageDownloadButtonWidth: Float64 = 296.0 // 图片下载按钮宽度
    public var imageDownloadButtonHeight: Float64 = 44.0 // 图片下载按钮高度
    public var imageDownloadButtonRadiusTopLeft: Float64 = 22.0 // 图片下载按钮左上圆角
    public var imageDownloadButtonRadiusTopRight: Float64 = 22.0 // 图片下载按钮右上圆角
    public var imageDownloadButtonRadiusBottomLeft: Float64 = 22.0 // 图片下载按钮左下圆角
    public var imageDownloadButtonRadiusBottomRight: Float64 = 22.0 // 图片下载按钮右下圆角
    public var imageDownloadButtonIconTextGap: Float64 = 6.0 // 图片下载按钮图标和文本间距
    public var imageDownloadButtonIcon: ?AppResource = None // 图片下载按钮图标
    public var imageDownloadButtonIconWidth: Float64 = 18.0 // 图片下载按钮图标宽度
    public var imageDownloadButtonIconHeight: Float64 = 18.0 // 图片下载按钮图标高度
    public var imageDownloadButtonBackgroundColor: Color = COLOR_FFF5F5F5 // 图片下载按钮背景颜色
    public var imageDownloadButtonText: String = "下载图片" // 图片下载按钮默认文本内容
    public var imageDownloadButtonTextFontColor: Color = COLOR_E6000000 // 图片下载按钮文本颜色
    public var imageDownloadButtonTextFontSize: Float64 = 16.0 // 图片下载按钮文本尺寸
    public var imageDownloadButtonTextFontStyle: FontStyle = FontStyle.Normal // 图片下载按钮文本字体样式
    public var imageDownloadButtonTextFontWeight: FontWeight = FontWeight.W500 // 图片下载按钮文本字体粗细
    public var imageDownloadButtonTextFontFamily: String = "HarmonyOS Sans" // 图片下载按钮文本字体
    public var imageDownloadButtonTextLineHeight: Float64 = 22.0 // 图片下载按钮文本行高

    /**
     * 设置4个外边距为统一值
     *
     * @param margin 外边距
     * @return 当前ImageTheme对象
     */
    public func setMargin(margin: Float64): ImageTheme {
        this.imageMarginTop = margin
        this.imageMarginRight = margin
        this.imageMarginBottom = margin
        this.imageMarginLeft = margin
        return this
    }

    /**
     * 分别设置4个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前ImageTheme对象
     */
    public func setMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): ImageTheme {
        this.imageMarginTop = top
        this.imageMarginRight = right
        this.imageMarginBottom = bottom
        this.imageMarginLeft = left
        return this
    }

    /**
     * 设置4个圆角为统一值
     *
     * @param radius 圆角
     * @return 当前ImageTheme对象
     */
    public func setRadius(radius: Float64): ImageTheme {
        this.imageRadiusTopLeft = radius
        this.imageRadiusTopRight = radius
        this.imageRadiusBottomLeft = radius
        this.imageRadiusBottomRight = radius
        return this
    }

    /**
     * 分别设置4个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前ImageTheme对象
     */
    public func setRadius(topLeft!: Float64 = 0.0, topRight!: Float64 = 0.0, bottomLeft!: Float64 = 0.0, bottomRight!: Float64 = 0.0): ImageTheme {
        this.imageRadiusTopLeft = topLeft
        this.imageRadiusTopRight = topRight
        this.imageRadiusBottomLeft = bottomLeft
        this.imageRadiusBottomRight = bottomRight
        return this
    }

    /**
     * 设置图片边框样式
     *
     * @param borderStyle 图片边框样式
     * @return 当前ImageTheme对象
     */
    public func setImageBorderStyle(borderStyle: BorderStyle): ImageTheme {
        this.imageBorderStyle = borderStyle
        return this
    }

    /**
     * 设置图片边框宽度
     *
     * @param borderWidth 图片边框宽度
     * @return 当前ImageTheme对象
     */
    public func setImageBorderWidth(borderWidth: Float64): ImageTheme {
        this.imageBorderWidth = borderWidth
        return this
    }

    /**
     * 设置图片边框颜色
     *
     * @param borderColor 图片边框颜色
     * @return 当前ImageTheme对象
     */
    public func setImageBorderColor(borderColor: Color): ImageTheme {
        this.imageBorderColor = borderColor
        return this
    }

    /**
     * 设置图片默认占位图
     *
     * @param placeholder 图片默认占位图
     * @return 当前ImageTheme对象
     */
    public func setImagePlaceholder(placeholder: AppResource): ImageTheme {
        this.imagePlaceholder = placeholder
        return this
    }

    /**
     * 设置网络图片是否压缩
     *
     * @param imageAutoResize 网络图片是否压缩
     * @return 当前ImageTheme对象
     */
    public func setImageAutoResize(imageAutoResize: Bool): ImageTheme {
        this.imageAutoResize = imageAutoResize
        return this
    }

    /**
     * 设置是否图文混排
     *
     * @param mixedLayout 是否图文混排
     * @return 当前ImageTheme对象
     */
    public func setIsImageMixedLayout(mixedLayout: Bool): ImageTheme {
        this.isImageMixedLayout = mixedLayout
        return this
    }

    /**
     * 设置图片基于自身宽度缩放百分比
     *
     * @param maximumWidth 图片基于自身宽度缩放百分比
     * @return 当前ImageTheme对象
     */
    public func setImageMaximumWidth(maximumWidth: Float64): ImageTheme {
        this.imageMaximumWidth = maximumWidth
        return this
    }

    /**
     * 设置图片基于父布局宽度缩放百分比
     *
     * @param fixedRatioWidth 图片基于父布局宽度缩放百分比
     * @return 当前ImageTheme对象
     */
    public func setImageFixedRatioWidth(fixedRatioWidth: Float64): ImageTheme {
        this.imageFixedRatioWidth = fixedRatioWidth
        return this
    }

    /**
     * 设置图片最大高度
     *
     * @param maxHeight 图片最大高度
     * @return 当前ImageTheme对象
     */
    public func setImageMaxHeight(maxHeight: Float64): ImageTheme {
        this.imageMaxHeight = maxHeight
        return this
    }

    /**
     * 设置图片高度
     *
     * @param height 图片高度
     * @return 当前ImageTheme对象
     */
    public func setImageHeight(height: Float64): ImageTheme {
        this.imageHeight = height
        return this
    }

    /**
     * 设置图片最大宽度
     *
     * @param maxWidth 图片最大宽度
     * @return 当前ImageTheme对象
     */
    public func setImageMaxWidth(maxWidth: Float64): ImageTheme {
        this.imageMaxWidth = maxWidth
        return this
    }

    /**
     * 设置图片宽度
     *
     * @param width 图片宽度
     * @return 当前ImageTheme对象
     */
    public func setImageWidth(width: Float64): ImageTheme {
        this.imageWidth = width
        return this
    }

    /**
     * 设置图片缩放类型
     *
     * @param fitType 图片缩放类型
     * @return 当前ImageTheme对象
     */
    public func setImageFitType(fitType: ImageFit): ImageTheme {
        this.imageFitType = fitType
        return this
    }

    /**
     * 设置底部布局距离图片上边距
     *
     * @param marginTop 底部布局距离图片上边距
     * @return 当前ImageTheme对象
     */
    public func setImageBottomLayoutMarginTop(marginTop: Float64): ImageTheme {
        this.imageBottomLayoutMarginTop = marginTop
        return this
    }

    /**
     * 设置图片下载按钮是否显示
     *
     * @param visible 图片下载按钮是否显示
     * @return 当前ImageTheme对象
     */
    public func setImageDownloadButtonVisible(visible: Bool): ImageTheme {
        this.imageDownloadButtonVisible = visible
        return this
    }

    /**
     * 设置图片下载按钮宽度
     *
     * @param width 图片下载按钮宽度
     * @return 当前ImageTheme对象
     */
    public func setImageDownloadButtonWidth(width: Float64): ImageTheme {
        this.imageDownloadButtonWidth = width
        return this
    }

    /**
     * 设置图片下载按钮高度
     *
     * @param height 图片下载按钮高度
     * @return 当前ImageTheme对象
     */
    public func setImageDownloadButtonHeight(height: Float64): ImageTheme {
        this.imageDownloadButtonHeight = height
        return this
    }

    /**
     * 设置图片下载按钮4个圆角为统一值
     *
     * @param radius 圆角
     * @return 当前ImageTheme对象
     */
    public func setImageDownloadButtonRadius(radius: Float64): ImageTheme {
        this.imageDownloadButtonRadiusTopLeft = radius
        this.imageDownloadButtonRadiusTopRight = radius
        this.imageDownloadButtonRadiusBottomLeft = radius
        this.imageDownloadButtonRadiusBottomRight = radius
        return this
    }

    /**
     * 分别设置图片下载按钮4个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前ImageTheme对象
     */
    public func setImageDownloadButtonRadius(topLeft!: Float64 = 22.0, topRight!: Float64 = 22.0, bottomLeft!: Float64 = 22.0, bottomRight!: Float64 = 22.0): ImageTheme {
        this.imageDownloadButtonRadiusTopLeft = topLeft
        this.imageDownloadButtonRadiusTopRight = topRight
        this.imageDownloadButtonRadiusBottomLeft = bottomLeft
        this.imageDownloadButtonRadiusBottomRight = bottomRight
        return this
    }

    /**
     * 设置图片下载按钮图标和文本间距
     *
     * @param iconTextGap 图标和文本间距
     * @return 当前ImageTheme对象
     */
    public func setImageDownloadButtonIconTextGap(iconTextGap: Float64): ImageTheme {
        this.imageDownloadButtonIconTextGap = iconTextGap
        return this
    }

    /**
     * 设置图片下载按钮图标
     *
     * @param icon 图片下载按钮图标
     * @return 当前ImageTheme对象
     */
    public func setImageDownloadButtonIcon(icon: AppResource): ImageTheme {
        this.imageDownloadButtonIcon = icon
        return this
    }

    /**
     * 设置图片下载按钮图标宽度
     *
     * @param width 图片下载按钮图标宽度
     * @return 当前ImageTheme对象
     */
    public func setImageDownloadButtonIconWidth(width: Float64): ImageTheme {
        this.imageDownloadButtonIconWidth = width
        return this
    }

    /**
     * 设置图片下载按钮图标高度
     *
     * @param height 图片下载按钮图标高度
     * @return 当前ImageTheme对象
     */
    public func setImageDownloadButtonIconHeight(height: Float64): ImageTheme {
        this.imageDownloadButtonIconHeight = height
        return this
    }

    /**
     * 设置图片下载按钮背景颜色
     *
     * @param color 图片下载按钮背景颜色
     * @return 当前ImageTheme对象
     */
    public func setImageDownloadButtonBackgroundColor(color: Color): ImageTheme {
        this.imageDownloadButtonBackgroundColor = color
        return this
    }

    /**
     * 设置图片下载按钮默认文本内容
     *
     * @param text 图片下载按钮默认文本内容
     * @return 当前ImageTheme对象
     */
    public func setImageDownloadButtonText(text: String): ImageTheme {
        this.imageDownloadButtonText = text
        return this
    }

    /**
     * 设置图片下载按钮文本颜色
     *
     * @param color 图片下载按钮文本颜色
     * @return 当前ImageTheme对象
     */
    public func setImageDownloadButtonTextFontColor(color: Color): ImageTheme {
        this.imageDownloadButtonTextFontColor = color
        return this
    }

    /**
     * 设置图片下载按钮文本尺寸
     *
     * @param size 图片下载按钮文本尺寸
     * @return 当前ImageTheme对象
     */
    public func setImageDownloadButtonTextFontSize(size: Float64): ImageTheme {
        this.imageDownloadButtonTextFontSize = size
        return this
    }

    /**
     * 设置图片下载按钮文本字体样式
     *
     * @param style 图片下载按钮文本字体样式
     * @return 当前ImageTheme对象
     */
    public func setImageDownloadButtonTextFontStyle(style: FontStyle): ImageTheme {
        this.imageDownloadButtonTextFontStyle = style
        return this
    }

    /**
     * 设置图片下载按钮文本字体粗细
     *
     * @param weight 图片下载按钮文本字体粗细
     * @return 当前ImageTheme对象
     */
    public func setImageDownloadButtonTextFontWeight(weight: FontWeight): ImageTheme {
        this.imageDownloadButtonTextFontWeight = weight
        return this
    }

    /**
     * 设置图片下载按钮文本字体
     *
     * @param family 图片下载按钮文本字体
     * @return 当前ImageTheme对象
     */
    public func setImageDownloadButtonTextFontFamily(family: String): ImageTheme {
        this.imageDownloadButtonTextFontFamily = family
        return this
    }

    /**
     * 设置图片下载按钮文本行高
     *
     * @param lineHeight 图片下载按钮文本行高
     * @return 当前ImageTheme对象
     */
    public func setImageDownloadButtonTextLineHeight(lineHeight: Float64): ImageTheme {
        this.imageDownloadButtonTextLineHeight = lineHeight
        return this
    }
}