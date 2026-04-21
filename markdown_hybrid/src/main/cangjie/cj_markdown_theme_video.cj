/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownVideoTheme {
    /**
     * 视频背景颜色
     */
    var videoBackgroundColor: ?Color = None

    /**
     * 视频上外边距
     */
    var videoMarginTop: ?Float64 = None

    /**
     * 视频右外边距
     */
    var videoMarginRight: ?Float64 = None

    /**
     * 视频下外边距
     */
    var videoMarginBottom: ?Float64 = None

    /**
     * 视频左外边距
     */
    var videoMarginLeft: ?Float64 = None

    /**
     * 视频上内边距
     */
    var videoPaddingTop: ?Float64 = None

    /**
     * 视频右内边距
     */
    var videoPaddingRight: ?Float64 = None

    /**
     * 视频下内边距
     */
    var videoPaddingBottom: ?Float64 = None

    /**
     * 视频左内边距
     */
    var videoPaddingLeft: ?Float64 = None

    /**
     * 视频边框样式
     */
    var videoBorderStyle: ?BorderStyle = None

    /**
     * 视频边框宽度
     */
    var videoBorderWidth: ?Float64 = None

    /**
     * 视频边框颜色
     */
    var videoBorderColor: ?Color = None

    /**
     * 视频图片缩放类型
     */
    var videoImageFitType: ?ImageFit = Option<ImageFit>.None

    /**
     * 视频边框左上圆角
     */
    var videoRadiusTopLeft: ?Float64 = None

    /**
     * 视频边框右上圆角
     */
    var videoRadiusTopRight: ?Float64 = None

    /**
     * 视频边框左下圆角
     */
    var videoRadiusBottomLeft: ?Float64 = None

    /**
     * 视频边框右下圆角
     */
    var videoRadiusBottomRight: ?Float64 = None

    /**
     * 播放按钮图标宽度
     */
    var videoPlayIconWidth: ?Float64 = None

    /**
     * 播放按钮图标高度
     */
    var videoPlayIconHeight: ?Float64 = None

    /**
     * 播放按钮图标缩放类型
     */
    var videoPlayIconFitType: ?ImageFit = Option<ImageFit>.None

    /**
     * 视频时间文本颜色
     */
    var videoTimeTextFontColor: ?Color = None

    /**
     * 视频时间文本尺寸
     */
    var videoTimeTextFontSize: ?Float64 = None

    /**
     * 视频时间文本字体样式
     */
    var videoTimeTextFontStyle: ?FontStyle = None

    /**
     * 视频时间文本字体粗细
     */
    var videoTimeTextFontWeight: ?FontWeight = None

    /**
     * 视频时间文本字体
     */
    var videoTimeTextFontFamily: ?String = None

    /**
     * 视频时间文本行高
     */
    var videoTimeTextLineHeight: ?Float64 = None

    /**
     * 视频时间文本居右边距
     */
    var videoTimeTextMarginRight: ?Float64 = None

    /**
     * 视频时间文本居底边距
     */
    var videoTimeTextMarginBottom: ?Float64 = None

    /**
     * 底部布局是否显示（视频发布/下载按钮）
     */
    var videoBottomLayoutVisible: ?Bool = None

    /**
     * 底部布局距离视频上边距
     */
    var videoBottomLayoutMarginTop: ?Float64 = None

    /**
     * 视频发布按钮是否显示
     */
    var videoReleaseButtonVisible: ?Bool = None

    /**
     * 视频发布按钮背景颜色
     */
    var videoReleaseButtonBackgroundColor: ?Color = None

    /**
     * 视频发布按钮宽度
     */
    var videoReleaseButtonWidth: ?Float64 = None

    /**
     * 视频发布按钮高度
     */
    var videoReleaseButtonHeight: ?Float64 = None

    /**
     * 视频发布按钮左上圆角
     */
    var videoReleaseButtonRadiusTopLeft: ?Float64 = None

    /**
     * 视频发布按钮右上圆角
     */
    var videoReleaseButtonRadiusTopRight: ?Float64 = None

    /**
     * 视频发布按钮左下圆角
     */
    var videoReleaseButtonRadiusBottomLeft: ?Float64 = None

    /**
     * 视频发布按钮右下圆角
     */
    var videoReleaseButtonRadiusBottomRight: ?Float64 = None

    /**
     * 视频发布按钮图标和文本间距
     */
    var videoReleaseButtonIconTextGap: ?Float64 = None

    /**
     * 视频发布按钮图标宽度
     */
    var videoReleaseButtonIconWidth: ?Float64 = None

    /**
     * 视频发布按钮图标高度
     */
    var videoReleaseButtonIconHeight: ?Float64 = None

    /**
     * 视频发布按钮默认文本内容
     */
    var videoReleaseButtonText: ?String = None

    /**
     * 视频发布按钮文本颜色
     */
    var videoReleaseButtonTextFontColor: ?Color = None

    /**
     * 视频发布按钮文本尺寸
     */
    var videoReleaseButtonTextFontSize: ?Float64 = None

    /**
     * 视频发布按钮文本字体样式
     */
    var videoReleaseButtonTextFontStyle: ?FontStyle = None

    /**
     * 视频发布按钮文本字体粗细
     */
    var videoReleaseButtonTextFontWeight: ?FontWeight = None

    /**
     * 视频发布按钮文本字体
     */
    var videoReleaseButtonTextFontFamily: ?String = None

    /**
     * 视频发布按钮文本行高
     */
    var videoReleaseButtonTextLineHeight: ?Float64 = None

    /**
     * 视频下载按钮是否显示
     */
    var videoDownloadButtonVisible: ?Bool = None

    /**
     * 视频下载按钮背景颜色
     */
    var videoDownloadButtonBackgroundColor: ?Color = None

    /**
     * 视频下载按钮宽度
     */
    var videoDownloadButtonWidth: ?Float64 = None

    /**
     * 视频下载按钮高度
     */
    var videoDownloadButtonHeight: ?Float64 = None

    /**
     * 视频下载按钮左上圆角
     */
    var videoDownloadButtonRadiusTopLeft: ?Float64 = None

    /**
     * 视频下载按钮右上圆角
     */
    var videoDownloadButtonRadiusTopRight: ?Float64 = None

    /**
     * 视频下载按钮左下圆角
     */
    var videoDownloadButtonRadiusBottomLeft: ?Float64 = None

    /**
     * 视频下载按钮右下圆角
     */
    var videoDownloadButtonRadiusBottomRight: ?Float64 = None

    /**
     * 视频下载按钮图标和文本间距
     */
    var videoDownloadButtonIconTextGap: ?Float64 = None

    /**
     * 视频下载按钮图标宽度
     */
    var videoDownloadButtonIconWidth: ?Float64 = None

    /**
     * 视频下载按钮图标高度
     */
    var videoDownloadButtonIconHeight: ?Float64 = None

    /**
     * 视频下载按钮默认文本内容
     */
    var videoDownloadButtonText: ?String = None

    /**
     * 视频下载按钮文本颜色
     */
    var videoDownloadButtonTextFontColor: ?Color = None

    /**
     * 视频下载按钮文本尺寸
     */
    var videoDownloadButtonTextFontSize: ?Float64 = None

    /**
     * 视频下载按钮文本字体样式
     */
    var videoDownloadButtonTextFontStyle: ?FontStyle = None

    /**
     * 视频下载按钮文本字体粗细
     */
    var videoDownloadButtonTextFontWeight: ?FontWeight = None

    /**
     * 视频下载按钮文本字体
     */
    var videoDownloadButtonTextFontFamily: ?String = None

    /**
     * 视频下载按钮文本行高
     */
    var videoDownloadButtonTextLineHeight: ?Float64 = None

    public init() {}

    /**
     * 设置视频背景颜色
     *
     * @param color 背景颜色
     */
    public func setVideoBackgroundColor(color: UInt32): Unit {
        videoBackgroundColor = transColorForTrasparent(color)
    }

    /**
     * 设置4个外边距为统一值
     *
     * @param margin 外边距
     */
    public func setVideoAllMargin(margin: Float64): Unit {
        videoMarginTop = margin
        videoMarginRight = margin
        videoMarginBottom = margin
        videoMarginLeft = margin
    }

    /**
     * 分别设置4个外边距
     *
     * @param top-上外边距 命名参数
     * @param right-右外边距 命名参数
     * @param bottom-下外边距 命名参数
     * @param left-左外边距 命名参数
     */
    public func setVideoMargin(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        videoMarginTop = top
        videoMarginRight = right
        videoMarginBottom = bottom
        videoMarginLeft = left
    }

    /**
     * 设置4个内边距为统一值
     *
     * @param padding 内边距
     */
    public func setVideoAllPadding(padding: Float64): Unit {
        videoPaddingTop = padding
        videoPaddingRight = padding
        videoPaddingBottom = padding
        videoPaddingLeft = padding
    }

    /**
     * 分别设置4个内边距
     *
     * @param top-上内边距 命名参数
     * @param right-右内边距 命名参数
     * @param bottom-下内边距 命名参数
     * @param left-左内边距 命名参数
     */
    public func setVideoPadding(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        videoPaddingTop = top
        videoPaddingRight = right
        videoPaddingBottom = bottom
        videoPaddingLeft = left
    }

    /**
     * 设置视频边框4个圆角为统一值
     *
     * @param radius 圆角
     */
    public func setVideoBorderAllRadius(radius: Float64): Unit {
        videoRadiusTopLeft = radius
        videoRadiusTopRight = radius
        videoRadiusBottomLeft = radius
        videoRadiusBottomRight = radius
    }

    /**
     * 分别设置视频边框4个圆角
     *
     * @param topLeft-左上圆角 命名参数
     * @param topRight-右上圆角 命名参数
     * @param bottomLeft-左下圆角 命名参数
     * @param bottomRight-右下圆角 命名参数
     */
    public func setVideoBorderRadius(topLeft!: Float64, topRight!: Float64, bottomLeft!: Float64, bottomRight!: Float64): Unit {
        videoRadiusTopLeft = topLeft
        videoRadiusTopRight = topRight
        videoRadiusBottomLeft = bottomLeft
        videoRadiusBottomRight = bottomRight
    }

    /**
     * 设置视频边框样式
     *
     * @param style 边框样式
     */
    public func setVideoBorderStyle(style: Int64): Unit {
        videoBorderStyle = convertBorderStyle(style)
    }

    /**
     * 设置视频边框宽度
     *
     * @param width 边框宽度
     */
    public func setVideoBorderWidth(width: Float64): Unit {
        videoBorderWidth = width
    }

    /**
     * 设置视频边框颜色
     *
     * @param color 边框颜色
     */
    public func setVideoBorderColor(color: UInt32): Unit {
        videoBorderColor = transColorForTrasparent(color)
    }

    /**
     * 设置视频图片缩放类型
     *
     * @param fitType 视频图片缩放类型
     */
    public func setVideoImageFitType(fitType: Int64): Unit {
        videoImageFitType = convertImageFitType(fitType)
    }

    /**
     * 设置播放按钮图标宽度
     *
     * @param width 播放按钮图标宽度
     */
    public func setVideoPlayIconWidth(width: Float64): Unit {
        videoPlayIconWidth = width
    }

    /**
     * 设置播放按钮图标高度
     *
     * @param height 播放按钮图标高度
     */
    public func setVideoPlayIconHeight(height: Float64): Unit {
        videoPlayIconHeight = height
    }

    /**
     * 设置播放按钮图标缩放类型
     *
     * @param fitType 播放按钮图标缩放类型
     */
    public func setVideoPlayIconFitType(fitType: Int64): Unit {
        videoPlayIconFitType = convertImageFitType(fitType)
    }

    /**
     * 设置视频时间文本颜色
     *
     * @param color 文本颜色
     */
    public func setVideoTimeTextFontColor(color: UInt32): Unit {
        videoTimeTextFontColor = transColorForTrasparent(color)
    }

    /**
     * 设置视频时间文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setVideoTimeTextFontSize(size: Float64): Unit {
        videoTimeTextFontSize = size
    }

    /**
     * 设置视频时间文本字体样式
     *
     * @param style 文本字体样式
     */
    public func setVideoTimeTextFontStyle(style: Int64): Unit {
        videoTimeTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置视频时间文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setVideoTimeTextFontWeight(weight: Int64): Unit {
        videoTimeTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置视频时间文本字体
     *
     * @param family 文本字体
     */
    public func setVideoTimeTextFontFamily(family: String): Unit {
        videoTimeTextFontFamily = family
    }

    /**
     * 设置视频时间文本行高
     *
     * @param lineHeight 文本行高
     */
    public func setVideoTimeTextLineHeight(lineHeight: Float64): Unit {
        videoTimeTextLineHeight = lineHeight
    }

    /**
     * 设置视频时间文本居右边距
     *
     * @param margin 居右边距
     */
    public func setVideoTimeTextMarginRight(margin: Float64): Unit {
        videoTimeTextMarginRight = margin
    }

    /**
     * 设置视频时间文本居底边距
     *
     * @param margin 居底边距
     */
    public func setVideoTimeTextMarginBottom(margin: Float64): Unit {
        videoTimeTextMarginBottom = margin
    }

    /**
     * 设置底部布局是否显示
     *
     * @param visible 是否显示
     */
    public func setVideoBottomLayoutVisible(visible: Bool): Unit {
        videoBottomLayoutVisible = visible
    }

    /**
     * 设置底部布局距离视频上边距
     *
     * @param margin 上边距
     */
    public func setVideoBottomLayoutMarginTop(margin: Float64): Unit {
        videoBottomLayoutMarginTop = margin
    }

    /**
     * 设置视频发布按钮是否显示
     *
     * @param visible 是否显示
     */
    public func setVideoReleaseButtonVisible(visible: Bool): Unit {
        videoReleaseButtonVisible = visible
    }

    /**
     * 设置视频发布按钮背景颜色
     *
     * @param color 背景颜色
     */
    public func setVideoReleaseButtonBackgroundColor(color: UInt32): Unit {
        videoReleaseButtonBackgroundColor = transColorForTrasparent(color)
    }

    /**
     * 设置视频发布按钮宽度
     *
     * @param width 按钮宽度
     */
    public func setVideoReleaseButtonWidth(width: Float64): Unit {
        videoReleaseButtonWidth = width
    }

    /**
     * 设置视频发布按钮高度
     *
     * @param height 按钮高度
     */
    public func setVideoReleaseButtonHeight(height: Float64): Unit {
        videoReleaseButtonHeight = height
    }

    /**
     * 设置视频发布按钮4个圆角为统一值
     *
     * @param radius 圆角
     */
    public func setVideoReleaseButtonAllRadius(radius: Float64): Unit {
        videoReleaseButtonRadiusTopLeft = radius
        videoReleaseButtonRadiusTopRight = radius
        videoReleaseButtonRadiusBottomLeft = radius
        videoReleaseButtonRadiusBottomRight = radius
    }

    /**
     * 分别设置视频发布按钮4个圆角
     *
     * @param topLeft-左上圆角 命名参数
     * @param topRight-右上圆角 命名参数
     * @param bottomLeft-左下圆角 命名参数
     * @param bottomRight-右下圆角 命名参数
     */
    public func setVideoReleaseButtonRadius(topLeft!: Float64, topRight!: Float64, bottomLeft!: Float64, bottomRight!: Float64): Unit {
        videoReleaseButtonRadiusTopLeft = topLeft
        videoReleaseButtonRadiusTopRight = topRight
        videoReleaseButtonRadiusBottomLeft = bottomLeft
        videoReleaseButtonRadiusBottomRight = bottomRight
    }

    /**
     * 设置视频发布按钮图标和文本间距
     *
     * @param gap 视频发布按钮图标和文本间距
     */
    public func setVideoReleaseButtonIconTextGap(gap: Float64): Unit {
        videoReleaseButtonIconTextGap = gap
    }

    /**
     * 设置视频发布按钮图标宽度
     *
     * @param width 图标宽度
     */
    public func setVideoReleaseButtonIconWidth(width: Float64): Unit {
        videoReleaseButtonIconWidth = width
    }

    /**
     * 设置视频发布按钮图标高度
     *
     * @param height 图标高度
     */
    public func setVideoReleaseButtonIconHeight(height: Float64): Unit {
        videoReleaseButtonIconHeight = height
    }

    /**
     * 设置视频发布按钮默认文本内容
     *
     * @param text 文本内容
     */
    public func setVideoReleaseButtonText(text: String): Unit {
        videoReleaseButtonText = text
    }

    /**
     * 设置视频发布按钮文本颜色
     *
     * @param color 文本颜色
     */
    public func setVideoReleaseButtonTextFontColor(color: UInt32): Unit {
        videoReleaseButtonTextFontColor = transColorForTrasparent(color)
    }

    /**
     * 设置视频发布按钮文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setVideoReleaseButtonTextFontSize(size: Float64): Unit {
        videoReleaseButtonTextFontSize = size
    }

    /**
     * 设置视频发布按钮文本字体样式
     *
     * @param style 文本字体样式
     */
    public func setVideoReleaseButtonTextFontStyle(style: Int64): Unit {
        videoReleaseButtonTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置视频发布按钮文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setVideoReleaseButtonTextFontWeight(weight: Int64): Unit {
        videoReleaseButtonTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置视频发布按钮文本字体
     *
     * @param family 文本字体
     */
    public func setVideoReleaseButtonTextFontFamily(family: String): Unit {
        videoReleaseButtonTextFontFamily = family
    }

    /**
     * 设置视频发布按钮文本行高
     *
     * @param lineHeight 文本行高
     */
    public func setVideoReleaseButtonTextLineHeight(lineHeight: Float64): Unit {
        videoReleaseButtonTextLineHeight = lineHeight
    }

    /**
     * 设置视频下载按钮是否显示
     *
     * @param visible 是否显示
     */
    public func setVideoDownloadButtonVisible(visible: Bool): Unit {
        videoDownloadButtonVisible = visible
    }

    /**
     * 设置视频下载按钮背景颜色
     *
     * @param color 背景颜色
     */
    public func setVideoDownloadButtonBackgroundColor(color: UInt32): Unit {
        videoDownloadButtonBackgroundColor = transColorForTrasparent(color)
    }

    /**
     * 设置视频下载按钮宽度
     *
     * @param width 按钮宽度
     */
    public func setVideoDownloadButtonWidth(width: Float64): Unit {
        videoDownloadButtonWidth = width
    }

    /**
     * 设置视频下载按钮高度
     *
     * @param height 按钮高度
     */
    public func setVideoDownloadButtonHeight(height: Float64): Unit {
        videoDownloadButtonHeight = height
    }

    /**
     * 设置视频发布按钮4个圆角为统一值
     *
     * @param radius 圆角
     */
    public func setVideoDownloadButtonAllRadius(radius: Float64): Unit {
        videoDownloadButtonRadiusTopLeft = radius
        videoDownloadButtonRadiusTopRight = radius
        videoDownloadButtonRadiusBottomLeft = radius
        videoDownloadButtonRadiusBottomRight = radius
    }

    /**
     * 分别设置视频发布按钮4个圆角
     *
     * @param topLeft-左上圆角 命名参数
     * @param topRight-右上圆角 命名参数
     * @param bottomLeft-左下圆角 命名参数
     * @param bottomRight-右下圆角 命名参数
     */
    public func setVideoDownloadButtonRadius(topLeft!: Float64, topRight!: Float64, bottomLeft!: Float64, bottomRight!: Float64): Unit {
        videoDownloadButtonRadiusTopLeft = topLeft
        videoDownloadButtonRadiusTopRight = topRight
        videoDownloadButtonRadiusBottomLeft = bottomLeft
        videoDownloadButtonRadiusBottomRight = bottomRight
    }

    /**
     * 设置视频下载按钮图标和文本间距
     *
     * @param iconTextGap 间距
     */
    public func setVideoDownloadButtonIconTextGap(iconTextGap: Float64): Unit {
        videoDownloadButtonIconTextGap = iconTextGap
    }

    /**
     * 设置视频下载按钮图标宽度
     *
     * @param width 图标宽度
     */
    public func setVideoDownloadButtonIconWidth(width: Float64): Unit {
        videoDownloadButtonIconWidth = width
    }

    /**
     * 设置视频下载按钮图标高度
     *
     * @param height 图标高度
     */
    public func setVideoDownloadButtonIconHeight(height: Float64): Unit {
        videoDownloadButtonIconHeight = height
    }

    /**
     * 设置视频下载按钮默认文本内容
     *
     * @param text 文本内容
     */
    public func setVideoDownloadButtonText(text: String): Unit {
        videoDownloadButtonText = text
    }

    /**
     * 设置视频下载按钮文本颜色
     *
     * @param color 文本颜色
     */
    public func setVideoDownloadButtonTextFontColor(color: UInt32): Unit {
        videoDownloadButtonTextFontColor = transColorForTrasparent(color)
    }

    /**
     * 设置视频下载按钮文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setVideoDownloadButtonTextFontSize(size: Float64): Unit {
        videoDownloadButtonTextFontSize = size
    }

    /**
     * 设置视频下载按钮文本字体样式
     *
     * @param style 文本字体样式
     */
    public func setVideoDownloadButtonTextFontStyle(style: Int64): Unit {
        videoDownloadButtonTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置视频下载按钮文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setVideoDownloadButtonTextFontWeight(weight: Int64): Unit {
        videoDownloadButtonTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置视频下载按钮文本字体
     *
     * @param family 文本字体
     */
    public func setVideoDownloadButtonTextFontFamily(family: String): Unit {
        videoDownloadButtonTextFontFamily = family
    }

    /**
     * 设置视频下载按钮文本行高
     *
     * @param lineHeight 文本行高
     */
    public func setVideoDownloadButtonTextLineHeight(lineHeight: Float64): Unit {
        videoDownloadButtonTextLineHeight = lineHeight
    }
}
