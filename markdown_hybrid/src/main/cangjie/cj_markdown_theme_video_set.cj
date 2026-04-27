/**
 * Created on 2026/4/20
 */
package markdown

func setVideoTheme(videoTheme: CJMarkdownVideoTheme): VideoTheme {
    let theme: VideoTheme = VideoTheme()
    if (let Some(v) <- videoImage) {
        theme.setVideoPlaceholder(v) // 设置视频默认占位图
    }
    if (let Some(v) <- playCircleFillIcon) {
        theme.setVideoPlayIcon(v) // 设置视频播放按钮默认图标
    }
    if (let Some(v) <- videoReleaseImage) {
        theme.setVideoReleaseButtonIcon(v) // 视频发布按钮默认图标
    }
    if (let Some(v) <- videoDownloadImage) {
        theme.setVideoDownloadButtonIcon(v) // 视频下载按钮默认图标
    }
    if (let Some(v) <- videoTheme.videoBackgroundColor) {
        theme.setVideoBackgroundColor(v)
    }
    var videoMarginTop: Float64 = 0.0 // 视频上外边距
    var videoMarginRight: Float64 = 0.0 // 视频右外边距
    var videoMarginBottom: Float64 = 0.0 // 视频下外边距
    var videoMarginLeft: Float64 = 0.0 // 视频左外边距
    if (let Some(v) <- videoTheme.videoMarginTop) {
        videoMarginTop = v
    }
    if (let Some(v) <- videoTheme.videoMarginRight) {
        videoMarginRight = v
    }
    if (let Some(v) <- videoTheme.videoMarginBottom) {
        videoMarginBottom = v
    }
    if (let Some(v) <- videoTheme.videoMarginLeft) {
        videoMarginLeft = v
    }
    theme.setVideoMargin(top: videoMarginTop, right: videoMarginRight, bottom: videoMarginBottom, left: videoMarginLeft)

    var videoPaddingTop: Float64 = 0.0 // 视频上内边距
    var videoPaddingRight: Float64 = 0.0 // 视频右内边距
    var videoPaddingBottom: Float64 = 0.0 // 视频下内边距
    var videoPaddingLeft: Float64 = 0.0 // 视频左内边距
    if (let Some(v) <- videoTheme.videoPaddingTop) {
        videoPaddingTop = v
    }
    if (let Some(v) <- videoTheme.videoPaddingRight) {
        videoPaddingRight = v
    }
    if (let Some(v) <- videoTheme.videoPaddingBottom) {
        videoPaddingBottom = v
    }
    if (let Some(v) <- videoTheme.videoPaddingLeft) {
        videoPaddingLeft = v
    }
    theme.setVideoPadding(top: videoPaddingTop, right: videoPaddingRight, bottom: videoPaddingBottom, left: videoPaddingLeft)

    var videoRadiusTopLeft: Float64 = 10.0 // 视频边框左上圆角
    var videoRadiusTopRight: Float64 = 10.0 // 视频边框右上圆角
    var videoRadiusBottomLeft: Float64 = 10.0 // 视频边框左下圆角
    var videoRadiusBottomRight: Float64 = 10.0 // 视频边框右下圆角
    if (let Some(v) <- videoTheme.videoRadiusTopLeft) {
        videoRadiusTopLeft = v
    }
    if (let Some(v) <- videoTheme.videoRadiusTopRight) {
        videoRadiusTopRight = v
    }
    if (let Some(v) <- videoTheme.videoRadiusBottomLeft) {
        videoRadiusBottomLeft = v
    }
    if (let Some(v) <- videoTheme.videoRadiusBottomRight) {
        videoRadiusBottomRight = v
    }
    theme.setVideoRadius(topLeft: videoRadiusTopLeft, topRight: videoRadiusTopRight, bottomLeft: videoRadiusBottomLeft, bottomRight: videoRadiusBottomRight)

    if (let Some(v) <- videoTheme.videoBorderStyle) {
        theme.setVideoBorderStyle(v)
    }
    if (let Some(v) <- videoTheme.videoBorderWidth) {
        theme.setVideoBorderWidth(v)
    }
    if (let Some(v) <- videoTheme.videoBorderColor) {
        theme.setVideoBorderColor(v)
    }
    if (let Some(v) <- videoTheme.videoImageFitType) {
        theme.setVideoImageFitType(v)
    }
    if (let Some(v) <- videoTheme.videoPlayIconWidth) {
        theme.setVideoPlayIconWidth(v)
    }
    if (let Some(v) <- videoTheme.videoPlayIconHeight) {
        theme.setVideoPlayIconHeight(v)
    }
    if (let Some(v) <- videoTheme.videoPlayIconFitType) {
        theme.setVideoPlayIconFitType(v)
    }
    if (let Some(v) <- videoTheme.videoTimeTextFontColor) {
        theme.setVideoTimeTextFontColor(v)
    }
    if (let Some(v) <- videoTheme.videoTimeTextFontSize) {
        theme.setVideoTimeTextFontSize(v)
    }
    if (let Some(v) <- videoTheme.videoTimeTextFontStyle) {
        theme.setVideoTimeTextFontStyle(v)
    }
    if (let Some(v) <- videoTheme.videoTimeTextFontWeight) {
        theme.setVideoTimeTextFontWeight(v)
    }
    if (let Some(v) <- videoTheme.videoTimeTextFontFamily) {
        theme.setVideoTimeTextFontFamily(v)
    }
    if (let Some(v) <- videoTheme.videoTimeTextLineHeight) {
        theme.setVideoTimeTextLineHeight(v)
    }
    if (let Some(v) <- videoTheme.videoTimeTextMarginRight) {
        theme.setVideoTimeTextMarginRight(v)
    }
    if (let Some(v) <- videoTheme.videoTimeTextMarginBottom) {
        theme.setVideoTimeTextMarginBottom(v)
    }
    if (let Some(v) <- videoTheme.videoBottomLayoutVisible) {
        theme.setVideoBottomLayoutVisible(v)
    }
    if (let Some(v) <- videoTheme.videoBottomLayoutMarginTop) {
        theme.setVideoBottomLayoutMarginTop(v)
    }
    if (let Some(v) <- videoTheme.videoReleaseButtonVisible) {
        theme.setVideoReleaseButtonVisible(v)
    }
    if (let Some(v) <- videoTheme.videoReleaseButtonBackgroundColor) {
        theme.setVideoReleaseButtonBackgroundColor(v)
    }
    if (let Some(v) <- videoTheme.videoReleaseButtonWidth) {
        theme.setVideoReleaseButtonWidth(v)
    }
    if (let Some(v) <- videoTheme.videoReleaseButtonHeight) {
        theme.setVideoReleaseButtonHeight(v)
    }

    var videoReleaseButtonRadiusTopLeft: Float64 = 22.0 // 视频发布按钮左上圆角
    var videoReleaseButtonRadiusTopRight: Float64 = 22.0 // 视频发布按钮右上圆角
    var videoReleaseButtonRadiusBottomLeft: Float64 = 22.0 // 视频发布按钮左下圆角
    var videoReleaseButtonRadiusBottomRight: Float64 = 22.0 // 视频发布按钮右下圆角
    if (let Some(v) <- videoTheme.videoReleaseButtonRadiusTopLeft) {
        videoReleaseButtonRadiusTopLeft = v
    }
    if (let Some(v) <- videoTheme.videoReleaseButtonRadiusTopRight) {
        videoReleaseButtonRadiusTopRight = v
    }
    if (let Some(v) <- videoTheme.videoReleaseButtonRadiusBottomLeft) {
        videoReleaseButtonRadiusBottomLeft = v
    }
    if (let Some(v) <- videoTheme.videoReleaseButtonRadiusBottomRight) {
        videoReleaseButtonRadiusBottomRight = v
    }
    theme.setVideoReleaseButtonRadius(topLeft: videoReleaseButtonRadiusTopLeft, topRight: videoReleaseButtonRadiusTopRight, bottomLeft: videoReleaseButtonRadiusBottomLeft, bottomRight: videoReleaseButtonRadiusBottomRight)

    if (let Some(v) <- videoTheme.videoReleaseButtonIconTextGap) {
        theme.setVideoReleaseButtonIconTextGap(v)
    }
    if (let Some(v) <- videoTheme.videoReleaseButtonIconWidth) {
        theme.setVideoReleaseButtonIconWidth(v)
    }
    if (let Some(v) <- videoTheme.videoReleaseButtonIconHeight) {
        theme.setVideoReleaseButtonIconHeight(v)
    }
    if (let Some(v) <- videoTheme.videoReleaseButtonText) {
        theme.setVideoReleaseButtonText(v)
    }
    if (let Some(v) <- videoTheme.videoReleaseButtonTextFontColor) {
        theme.setVideoReleaseButtonTextFontColor(v)
    }
    if (let Some(v) <- videoTheme.videoReleaseButtonTextFontSize) {
        theme.setVideoReleaseButtonTextFontSize(v)
    }
    if (let Some(v) <- videoTheme.videoReleaseButtonTextFontStyle) {
        theme.setVideoReleaseButtonTextFontStyle(v)
    }
    if (let Some(v) <- videoTheme.videoReleaseButtonTextFontWeight) {
        theme.setVideoReleaseButtonTextFontWeight(v)
    }
    if (let Some(v) <- videoTheme.videoReleaseButtonTextFontFamily) {
        theme.setVideoReleaseButtonTextFontFamily(v)
    }
    if (let Some(v) <- videoTheme.videoReleaseButtonTextLineHeight) {
        theme.setVideoReleaseButtonTextLineHeight(v)
    }
    if (let Some(v) <- videoTheme.videoDownloadButtonVisible) {
        theme.setVideoDownloadButtonVisible(v)
    }
    if (let Some(v) <- videoTheme.videoDownloadButtonBackgroundColor) {
        theme.setVideoDownloadButtonBackgroundColor(v)
    }
    if (let Some(v) <- videoTheme.videoDownloadButtonWidth) {
        theme.setVideoDownloadButtonWidth(v)
    }
    if (let Some(v) <- videoTheme.videoDownloadButtonHeight) {
        theme.setVideoDownloadButtonHeight(v)
    }

    var videoDownloadButtonRadiusTopLeft: Float64 = 22.0 // 视频下载按钮左上圆角
    var videoDownloadButtonRadiusTopRight: Float64 = 22.0 // 视频下载按钮右上圆角
    var videoDownloadButtonRadiusBottomLeft: Float64 = 22.0 // 视频下载按钮左下圆角
    var videoDownloadButtonRadiusBottomRight: Float64 = 22.0 // 视频下载按钮右下圆角
    if (let Some(v) <- videoTheme.videoDownloadButtonRadiusTopLeft) {
        videoDownloadButtonRadiusTopLeft = v
    }
    if (let Some(v) <- videoTheme.videoDownloadButtonRadiusTopRight) {
        videoDownloadButtonRadiusTopRight = v
    }
    if (let Some(v) <- videoTheme.videoDownloadButtonRadiusBottomLeft) {
        videoDownloadButtonRadiusBottomLeft = v
    }
    if (let Some(v) <- videoTheme.videoDownloadButtonRadiusBottomRight) {
        videoDownloadButtonRadiusBottomRight = v
    }
    theme.setVideoDownloadButtonRadius(
        topLeft: videoDownloadButtonRadiusTopLeft,
        topRight: videoDownloadButtonRadiusTopRight,
        bottomLeft: videoDownloadButtonRadiusBottomLeft,
        bottomRight: videoDownloadButtonRadiusBottomRight
    )

    if (let Some(v) <- videoTheme.videoDownloadButtonIconTextGap) {
        theme.setVideoDownloadButtonIconTextGap(v)
    }
    if (let Some(v) <- videoTheme.videoDownloadButtonIconWidth) {
        theme.setVideoDownloadButtonIconWidth(v)
    }
    if (let Some(v) <- videoTheme.videoDownloadButtonIconHeight) {
        theme.setVideoDownloadButtonIconHeight(v)
    }
    if (let Some(v) <- videoTheme.videoDownloadButtonText) {
        theme.setVideoDownloadButtonText(v)
    }
    if (let Some(v) <- videoTheme.videoDownloadButtonTextFontColor) {
        theme.setVideoDownloadButtonTextFontColor(v)
    }
    if (let Some(v) <- videoTheme.videoDownloadButtonTextFontSize) {
        theme.setVideoDownloadButtonTextFontSize(v)
    }
    if (let Some(v) <- videoTheme.videoDownloadButtonTextFontStyle) {
        theme.setVideoDownloadButtonTextFontStyle(v)
    }
    if (let Some(v) <- videoTheme.videoDownloadButtonTextFontWeight) {
        theme.setVideoDownloadButtonTextFontWeight(v)
    }
    if (let Some(v) <- videoTheme.videoDownloadButtonTextFontFamily) {
        theme.setVideoDownloadButtonTextFontFamily(v)
    }
    if (let Some(v) <- videoTheme.videoDownloadButtonTextLineHeight) {
        theme.setVideoDownloadButtonTextLineHeight(v)
    }
    return theme
}
