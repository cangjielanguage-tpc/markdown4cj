package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownImageTheme {
    /**
     * 图片上外边距
     */
    var imageMarginTop: ?Float64 = None

    /**
     * 图片右外边距
     */
    var imageMarginRight: ?Float64 = None

    /**
     * 图片下外边距
     */
    var imageMarginBottom: ?Float64 = None

    /**
     * 图片左外边距
     */
    var imageMarginLeft: ?Float64 = None

    /**
     * 图片边框左上圆角
     */
    var imageRadiusTopLeft: ?Float64 = None

    /**
     * 图片边框右上圆角
     */
    var imageRadiusTopRight: ?Float64 = None

    /**
     * 图片边框左下圆角
     */
    var imageRadiusBottomLeft: ?Float64 = None

    /**
     * 图片边框右下圆角
     */
    var imageRadiusBottomRight: ?Float64 = None

    /**
     * 图片边框样式
     */
    var imageBorderStyle: ?BorderStyle = None

    /**
     * 图片边框宽度
     */
    var imageBorderWidth: ?Float64 = None

    /**
     * 图片边框颜色
     */
    var imageBorderColor: ?Color = None

    /**
     * 是否图文混排
     */
    var isImageMixedLayout: ?Bool = None

    /**
     * 网络图片是否压缩
     */
    var imageAutoResize: ?Bool = None

    /**
     * 图片基于自身宽度缩放百分比
     */
    var imageMaximumWidth: ?Float64 = None

    /**
     * 图片基于父布局宽度缩放百分比
     */
    var imageFixedRatioWidth: ?Float64 = None

    /**
     * 图片最大高度
     */
    var imageMaxHeight: ?Float64 = None

    /**
     * 图片高度
     */
    var imageHeight: ?Float64 = None

    /**
     * 图片最大宽度
     */
    var imageMaxWidth: ?Float64 = None

    /**
     * 图片宽度
     */
    var imageWidth: ?Float64 = None

    /**
     * 图片缩放类型
     */
    var imageFitType: ?ImageFit = Option<ImageFit>.None

    /**
     * 底部布局距离图片上边距
     */
    var imageBottomLayoutMarginTop: ?Float64 = None

    /**
     * 图片下载按钮是否显示
     */
    var imageDownloadButtonVisible: ?Bool = None

    /**
     * 图片下载按钮宽度
     */
    var imageDownloadButtonWidth: ?Float64 = None

    /**
     * 图片下载按钮高度
     */
    var imageDownloadButtonHeight: ?Float64 = None

    /**
     * 图片下载按钮左上圆角
     */
    var imageDownloadButtonRadiusTopLeft: ?Float64 = None

    /**
     * 图片下载按钮右上圆角
     */
    var imageDownloadButtonRadiusTopRight: ?Float64 = None

    /**
     * 图片下载按钮左下圆角
     */
    var imageDownloadButtonRadiusBottomLeft: ?Float64 = None

    /**
     * 图片下载按钮右下圆角
     */
    var imageDownloadButtonRadiusBottomRight: ?Float64 = None

    /**
     * 图片下载按钮图标宽度
     */
    var imageDownloadButtonIconWidth: ?Float64 = None

    /**
     * 图片下载按钮图标高度
     */
    var imageDownloadButtonIconHeight: ?Float64 = None

    /**
     * 图片下载按钮背景颜色
     */
    var imageDownloadButtonBackgroundColor: ?Color = None

    /**
     * 图片下载按钮默认文本内容
     */
    var imageDownloadButtonText: ?String = None

    /**
     * 图片下载按钮文本颜色
     */
    var imageDownloadButtonTextFontColor: ?Color = None

    /**
     * 图片下载按钮文本尺寸
     */
    var imageDownloadButtonTextFontSize: ?Float64 = None

    /**
     * 图片下载按钮文本字体样式
     */
    var imageDownloadButtonTextFontStyle: ?FontStyle = None

    /**
     * 图片下载按钮文本字体粗细
     */
    var imageDownloadButtonTextFontWeight: ?FontWeight = None

    /**
     * 图片下载按钮文本字体
     */
    var imageDownloadButtonTextFontFamily: ?String = None

    /**
     * 图片下载按钮文本行高
     */
    var imageDownloadButtonTextLineHeight: ?Float64 = None

    /**
     * 图片下载按钮图标和文本间距
     */
    var imageDownloadButtonIconTextGap: ?Float64 = None

    public init() {}

    /**
     * 设置4个外边距为统一值
     *
     * @param margin 外边距
     */
    public func setImageAllMargin(margin: Float64): Unit {
        imageMarginTop = margin
        imageMarginRight = margin
        imageMarginBottom = margin
        imageMarginLeft = margin
    }

    /**
     * 分别设置4个外边距
     *
     * @param top-上外边距 命名参数
     * @param right-右外边距 命名参数
     * @param bottom-下外边距 命名参数
     * @param left-左外边距 命名参数
     */
    public func setImageMargin(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        imageMarginTop = top
        imageMarginRight = right
        imageMarginBottom = bottom
        imageMarginLeft = left
    }

    /**
     * 设置图片边框4个圆角为统一值
     *
     * @param radius 圆角
     */
    public func setImageBorderAllRadius(radius: Float64): Unit {
        imageRadiusTopLeft = radius
        imageRadiusTopRight = radius
        imageRadiusBottomLeft = radius
        imageRadiusBottomRight = radius
    }

    /**
     * 分别设置图片边框4个圆角
     *
     * @param topLeft-左上圆角 命名参数
     * @param topRight-右上圆角 命名参数
     * @param bottomLeft-左下圆角 命名参数
     * @param bottomRight-右下圆角 命名参数
     */
    public func setImageBorderRadius(topLeft!: Float64, topRight!: Float64, bottomLeft!: Float64, bottomRight!: Float64): Unit {
        imageRadiusTopLeft = topLeft
        imageRadiusTopRight = topRight
        imageRadiusBottomLeft = bottomLeft
        imageRadiusBottomRight = bottomRight
    }

    /**
     * 设置图片边框样式
     *
     * @param style 边框样式
     */
    public func setImageBorderStyle(style: Int64): Unit {
        imageBorderStyle = convertBorderStyle(style)
    }

    /**
     * 设置图片边框宽度
     *
     * @param width 边框宽度
     */
    public func setImageBorderWidth(width: Float64): Unit {
        imageBorderWidth = width
    }

    /**
     * 设置图片边框颜色
     *
     * @param color 边框颜色
     */
    public func setImageBorderColor(color: UInt32): Unit {
        imageBorderColor = transColorForTransparent(color)
    }

    /**
     * 设置是否图文混排
     *
     * @param mixedLayout 是否图文混排
     */
    public func setIsImageMixedLayout(mixedLayout: Bool): Unit {
        isImageMixedLayout = mixedLayout
    }

    /**
     * 设置网络图片是否压缩
     *
     * @param autoResize 网络图片是否压缩
     */
    public func setImageAutoResize(autoResize: Bool): Unit {
        imageAutoResize = autoResize
    }

    /**
     * 设置图片基于自身宽度缩放百分比
     *
     * @param maximumWidth 缩放百分比
     */
    public func setImageMaximumWidth(maximumWidth: Float64): Unit {
        imageMaximumWidth = maximumWidth
    }

    /**
     * 设置图片基于父布局宽度缩放百分比
     *
     * @param fixedRatioWidth 缩放百分比
     */
    public func setImageFixedRatioWidth(fixedRatioWidth: Float64): Unit {
        imageFixedRatioWidth = fixedRatioWidth
    }

    /**
     * 设置图片最大高度
     *
     * @param maxHeight 最大高度
     */
    public func setImageMaxHeight(maxHeight: Float64): Unit {
        imageMaxHeight = maxHeight
    }

    /**
     * 设置图片高度
     *
     * @param height 高度
     */
    public func setImageHeight(height: Float64): Unit {
        imageHeight = height
    }

    /**
     * 设置图片最大宽度
     *
     * @param maxWidth 最大宽度
     */
    public func setImageMaxWidth(maxWidth: Float64): Unit {
        imageMaxWidth = maxWidth
    }

    /**
     * 设置图片宽度
     *
     * @param width 宽度
     */
    public func setImageWidth(width: Float64): Unit {
        imageWidth = width
    }

    /**
     * 设置图片缩放类型
     *
     * @param fitType 缩放类型
     */
    public func setImageFitType(fitType: Int64): Unit {
        imageFitType = match (fitType) {
            case 0 => ImageFit.Contain
            case 1 => ImageFit.Cover
            case 2 => ImageFit.Fill
            case _ => ImageFit.Contain
        }
    }

    /**
     * 设置底部布局距离图片上边距
     *
     * @param marginTop 上边距
     */
    public func setImageBottomLayoutMarginTop(marginTop: Float64): Unit {
        imageBottomLayoutMarginTop = marginTop
    }

    /**
     * 设置图片下载按钮是否显示
     *
     * @param visible 是否显示
     */
    public func setImageDownloadButtonVisible(visible: Bool): Unit {
        imageDownloadButtonVisible = visible
    }

    /**
     * 设置图片下载按钮宽度
     *
     * @param width 按钮宽度
     */
    public func setImageDownloadButtonWidth(width: Float64): Unit {
        imageDownloadButtonWidth = width
    }

    /**
     * 设置图片下载按钮高度
     *
     * @param height 按钮高度
     */
    public func setImageDownloadButtonHeight(height: Float64): Unit {
        imageDownloadButtonHeight = height
    }

    /**
     * 设置图片下载按钮4个圆角为统一值
     *
     * @param radius 圆角
     */
    public func setImageDownloadButtonAllRadius(radius: Float64): Unit {
        imageDownloadButtonRadiusTopLeft = radius
        imageDownloadButtonRadiusTopRight = radius
        imageDownloadButtonRadiusBottomLeft = radius
        imageDownloadButtonRadiusBottomRight = radius
    }

    /**
     * 分别设置图片下载按钮4个圆角
     *
     * @param topLeft-左上圆角 命名参数
     * @param topRight-右上圆角 命名参数
     * @param bottomLeft-左下圆角 命名参数
     * @param bottomRight-右下圆角 命名参数
     */
    public func setImageDownloadButtonRadius(topLeft!: Float64, topRight!: Float64, bottomLeft!: Float64, bottomRight!: Float64): Unit {
        imageDownloadButtonRadiusTopLeft = topLeft
        imageDownloadButtonRadiusTopRight = topRight
        imageDownloadButtonRadiusBottomLeft = bottomLeft
        imageDownloadButtonRadiusBottomRight = bottomRight
    }

    /**
     * 设置图片下载按钮图标宽度
     *
     * @param width 图标宽度
     */
    public func setImageDownloadButtonIconWidth(width: Float64): Unit {
        imageDownloadButtonIconWidth = width
    }

    /**
     * 设置图片下载按钮图标高度
     *
     * @param height 图标高度
     */
    public func setImageDownloadButtonIconHeight(height: Float64): Unit {
        imageDownloadButtonIconHeight = height
    }

    /**
     * 设置图片下载按钮背景颜色
     *
     * @param color 背景颜色
     */
    public func setImageDownloadButtonBackgroundColor(color: UInt32): Unit {
        imageDownloadButtonBackgroundColor = transColorForTransparent(color)
    }

    /**
     * 设置图片下载按钮默认文本内容
     *
     * @param text 文本内容
     */
    public func setImageDownloadButtonText(text: String): Unit {
        imageDownloadButtonText = text
    }

    /**
     * 设置图片下载按钮文本颜色
     *
     * @param color 文本颜色
     */
    public func setImageDownloadButtonTextFontColor(color: UInt32): Unit {
        imageDownloadButtonTextFontColor = transColorForTransparent(color)
    }

    /**
     * 设置图片下载按钮文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setImageDownloadButtonTextFontSize(size: Float64): Unit {
        imageDownloadButtonTextFontSize = size
    }

    /**
     * 设置图片下载按钮文本字体样式
     *
     * @param style 文本字体样式
     */
    public func setImageDownloadButtonTextFontStyle(style: Int64): Unit {
        imageDownloadButtonTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置图片下载按钮文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setImageDownloadButtonTextFontWeight(weight: Int64): Unit {
        imageDownloadButtonTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置图片下载按钮文本字体
     *
     * @param family 文本字体
     */
    public func setImageDownloadButtonTextFontFamily(family: String): Unit {
        imageDownloadButtonTextFontFamily = family
    }

    /**
     * 设置图片下载按钮文本行高
     *
     * @param lineHeight 文本行高
     */
    public func setImageDownloadButtonTextLineHeight(lineHeight: Float64): Unit {
        imageDownloadButtonTextLineHeight = lineHeight
    }

    /**
     * 设置图片下载按钮图标和文本间距
     *
     * @param iconTextGap 文本字符间距
     */
    public func setImageDownloadButtonIconTextGap(iconTextGap: Float64): Unit {
        imageDownloadButtonIconTextGap = iconTextGap
    }
}
