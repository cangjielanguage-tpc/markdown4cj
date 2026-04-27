package markdown

func setImageTheme(imageTheme: CJMarkdownImageTheme): ImageTheme {
    let theme: ImageTheme = ImageTheme()
    if (let Some(v) <- imageResource) {
        theme.setImagePlaceholder(v) // 设置图片默认占位图
    }
    if (let Some(v) <- imageDownloadImage) {
        theme.setImageDownloadButtonIcon(v) // 设置图片下载默认图标
    }
    var imageMarginTop: Float64 = 0.0
    var imageMarginRight: Float64 = 0.0
    var imageMarginBottom: Float64 = 0.0
    var imageMarginLeft: Float64 = 0.0
    if (let Some(v) <- imageTheme.imageMarginTop) { imageMarginTop = v }
    if (let Some(v) <- imageTheme.imageMarginRight) { imageMarginRight = v }
    if (let Some(v) <- imageTheme.imageMarginBottom) { imageMarginBottom = v }
    if (let Some(v) <- imageTheme.imageMarginLeft) { imageMarginLeft = v }
    theme.setMargin(top: imageMarginTop, right: imageMarginRight, bottom: imageMarginBottom, left: imageMarginLeft)

    var imageRadiusTopLeft: Float64 = 0.0
    var imageRadiusTopRight: Float64 = 0.0
    var imageRadiusBottomLeft: Float64 = 0.0
    var imageRadiusBottomRight: Float64 = 0.0
    if (let Some(v) <- imageTheme.imageRadiusTopLeft) { imageRadiusTopLeft = v }
    if (let Some(v) <- imageTheme.imageRadiusTopRight) { imageRadiusTopRight = v }
    if (let Some(v) <- imageTheme.imageRadiusBottomLeft) { imageRadiusBottomLeft = v }
    if (let Some(v) <- imageTheme.imageRadiusBottomRight) { imageRadiusBottomRight = v }
    theme.setRadius(topLeft: imageRadiusTopLeft, topRight: imageRadiusTopRight, bottomLeft: imageRadiusBottomLeft, bottomRight: imageRadiusBottomRight)

    if (let Some(v) <- imageTheme.imageBorderStyle) {
        theme.setImageBorderStyle(v)
    }
    if (let Some(v) <- imageTheme.imageBorderWidth) {
        theme.setImageBorderWidth(v)
    }
    if (let Some(v) <- imageTheme.imageBorderColor) {
        theme.setImageBorderColor(v)
    }
    if (let Some(v) <- imageTheme.isImageMixedLayout) {
        theme.setIsImageMixedLayout(v)
    }
    if (let Some(v) <- imageTheme.imageAutoResize) {
        theme.setImageAutoResize(v)
    }
    if (let Some(v) <- imageTheme.imageMaximumWidth) {
        theme.setImageMaximumWidth(v)
    }
    if (let Some(v) <- imageTheme.imageFixedRatioWidth) {
        theme.setImageFixedRatioWidth(v)
    }
    if (let Some(v) <- imageTheme.imageMaxHeight) {
        theme.setImageMaxHeight(v)
    }
    if (let Some(v) <- imageTheme.imageHeight) {
        theme.setImageHeight(v)
    }
    if (let Some(v) <- imageTheme.imageMaxWidth) {
        theme.setImageMaxWidth(v)
    }
    if (let Some(v) <- imageTheme.imageWidth) {
        theme.setImageWidth(v)
    }
    if (let Some(v) <- imageTheme.imageFitType) {
        theme.setImageFitType(v)
    }
    if (let Some(v) <- imageTheme.imageBottomLayoutMarginTop) {
        theme.setImageBottomLayoutMarginTop(v)
    }
    if (let Some(v) <- imageTheme.imageDownloadButtonVisible) {
        theme.setImageDownloadButtonVisible(v)
    }
    if (let Some(v) <- imageTheme.imageDownloadButtonWidth) {
        theme.setImageDownloadButtonWidth(v)
    }
    if (let Some(v) <- imageTheme.imageDownloadButtonHeight) {
        theme.setImageDownloadButtonHeight(v)
    }
    var imageDownloadButtonRadiusTopLeft: Float64 = 22.0
    var imageDownloadButtonRadiusTopRight: Float64 = 22.0
    var imageDownloadButtonRadiusBottomLeft: Float64 = 22.0
    var imageDownloadButtonRadiusBottomRight: Float64 = 22.0
    if (let Some(v) <- imageTheme.imageDownloadButtonRadiusTopLeft) { imageDownloadButtonRadiusTopLeft = v }
    if (let Some(v) <- imageTheme.imageDownloadButtonRadiusTopRight) { imageDownloadButtonRadiusTopRight = v }
    if (let Some(v) <- imageTheme.imageDownloadButtonRadiusBottomLeft) { imageDownloadButtonRadiusBottomLeft = v }
    if (let Some(v) <- imageTheme.imageDownloadButtonRadiusBottomRight) { imageDownloadButtonRadiusBottomRight = v }
    theme.setImageDownloadButtonRadius(topLeft: imageDownloadButtonRadiusTopLeft, topRight: imageDownloadButtonRadiusTopRight, bottomLeft: imageDownloadButtonRadiusBottomLeft, bottomRight: imageDownloadButtonRadiusBottomRight)

    if (let Some(v) <- imageTheme.imageDownloadButtonIconTextGap) {
        theme.setImageDownloadButtonIconTextGap(v)
    }
    if (let Some(v) <- imageTheme.imageDownloadButtonIconWidth) {
        theme.setImageDownloadButtonIconWidth(v)
    }
    if (let Some(v) <- imageTheme.imageDownloadButtonIconHeight) {
        theme.setImageDownloadButtonIconHeight(v)
    }
    if (let Some(v) <- imageTheme.imageDownloadButtonBackgroundColor) {
        theme.setImageDownloadButtonBackgroundColor(v)
    }
    if (let Some(v) <- imageTheme.imageDownloadButtonText) {
        theme.setImageDownloadButtonText(v)
    }
    if (let Some(v) <- imageTheme.imageDownloadButtonTextFontColor) {
        theme.setImageDownloadButtonTextFontColor(v)
    }
    if (let Some(v) <- imageTheme.imageDownloadButtonTextFontSize) {
        theme.setImageDownloadButtonTextFontSize(v)
    }
    if (let Some(v) <- imageTheme.imageDownloadButtonTextFontStyle) {
        theme.setImageDownloadButtonTextFontStyle(v)
    }
    if (let Some(v) <- imageTheme.imageDownloadButtonTextFontWeight) {
        theme.setImageDownloadButtonTextFontWeight(v)
    }
    if (let Some(v) <- imageTheme.imageDownloadButtonTextFontFamily) {
        theme.setImageDownloadButtonTextFontFamily(v)
    }
    if (let Some(v) <- imageTheme.imageDownloadButtonTextLineHeight) {
        theme.setImageDownloadButtonTextLineHeight(v)
    }
    return theme
}
