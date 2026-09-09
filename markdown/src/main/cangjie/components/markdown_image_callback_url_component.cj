package markdown.components

import ohos.state_macro_manage.*

/**
 * URL
 */
@Component
public class MarkdownImageCallbackUrlComponent {
    @Prop
    var urlCallbackMarkdownTheme: MarkdownTheme // markdown配置
    var urlCallbackDestination: String // 图片链接
    @Prop
    var urlCallbackComponentWidth: Float64 // 控件宽度 - 单位vp
    var urlCallbackImageReplaceCallback: (String) -> ?Array<UInt8> // 图片替换事件
    var urlCallbackImageDownloadCallback: ?(String) -> Unit // 图片下载的点击事件
    var urlCallbackImageCallback: (String) -> Unit // 图片点击事件
    var urlCallbackLinkCallback: ?(String) -> Unit // 链接点击事件
    var urlCallbackLink: Bool // 是否是链接
    var urlCallbackLinkUrl: Option<String> // 链接URL
    var urlCallbackImageWidth: Option<Length> // 图片宽度
    var urlCallbackImageHeight: Option<Length> // 图片高度
    var urlCallbackImageRadius: Option<Length> // 图片圆角
    var urlCallbackImageAlign: Option<HorizontalAlign> // 图片对齐方式
    var urlCallbackImageNode: NodeView // 图片节点（缓存原始尺寸与最终显示宽高，对齐ArkUI item引用）
    @State
    var urlCallbackImageType: Int64 = 0 // 图片加载 0：开始加载。1：加载成功完成。2：加载失败
    @State
    var urlCallbackHeight: Float64 = 0.0 // 图片最终高度 - 单位px
    @State
    var urlCallbackWidth: Float64 = 0.0 // 图片最终宽度 - 单位px
    @State
    var urlCallbackRadiusTopLeft: Float64 = 0.0 // 图片左上圆角 - 单位vp
    @State
    var urlCallbackRadiusTopRight: Float64 = 0.0 // 图片右上圆角 - 单位vp
    @State
    var urlCallbackRadiusBottomLeft: Float64 = 0.0 // 图片左下圆角 - 单位vp
    @State
    var urlCallbackRadiusBottomRight: Float64 = 0.0 // 图片右下圆角 - 单位vp
    @State
    var urlCallbackThemeHeight: Option<Float64> = Option<Float64>.None // 图片设置高度 - 单位px
    @State
    var urlCallbackThemeWidth: Option<Float64> = Option<Float64>.None // 图片设置宽度 - 单位px
    @State
    var urlCallbackPlaceholderHeight: Float64 = 0.0 // 占位图片高度 - 单位px
    @State
    var urlCallbackPlaceholderWidth: Float64 = 0.0 // 占位图片宽度 - 单位px
    @State
    var urlCallbackReplaceWidth: ?Float64 = Option<Float64>.None // 替换之后的图片宽度 - 单位px
    @State
    var urlCallbackReplaceHeight: ?Float64 = Option<Float64>.None // 替换之后的图片高度 - 单位px
    @State
    var urlCallbackReplaceImagePixelMap: Option<PixelMap> = Option<PixelMap>.None // 替换之后的图片数据
    @State
    var urlCallbackReplaceImageType: Int64 = 0 // 解析加载 0：开始解析。1：解析成功完成。2：解析失败
    var urlCallbackReplaceFut: ?Future<Unit> = Option<Future<Unit>>.None // 替换子线程
    @State
    var urlCallbackComponentImageWidth: Float64 = 0.0 // 图片最大宽度 - 单位px
    @State
    var urlCallbackHorizontalAlign: HorizontalAlign = HorizontalAlign.Start // 图片对齐

    protected override func aboutToAppear(): Unit {
        urlCallbackComponentImageWidth = vp2px(urlCallbackComponentWidth.vp)().value // 图片最大宽度单位转换
        // 图片圆角
        let radius = imageSpanBorderRadius(urlCallbackImageRadius, urlCallbackMarkdownTheme.imageTheme.imageRadiusTopLeft, urlCallbackMarkdownTheme.imageTheme.imageRadiusTopRight, urlCallbackMarkdownTheme.imageTheme.imageRadiusBottomLeft, urlCallbackMarkdownTheme.imageTheme.imageRadiusBottomRight)
        urlCallbackRadiusTopLeft =  radius[0] // 图片左上圆角
        urlCallbackRadiusTopRight =  radius[1] // 图片右上圆角
        urlCallbackRadiusBottomLeft =  radius[2] // 图片左下圆角
        urlCallbackRadiusBottomRight =  radius[3] // 图片右下圆角
        urlCallbackThemeWidth = widthHeightLength2FloatPx(urlCallbackImageWidth, urlCallbackMarkdownTheme.imageTheme.imageWidth, urlCallbackComponentImageWidth) // 图片设置宽度
        urlCallbackThemeHeight = widthHeightLength2FloatPx(urlCallbackImageHeight, urlCallbackMarkdownTheme.imageTheme.imageHeight, urlCallbackComponentImageWidth) // 图片设置高度
        // 图片占位图宽度
        urlCallbackPlaceholderWidth = if (urlCallbackMarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            urlCallbackComponentImageWidth * urlCallbackMarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            urlCallbackComponentImageWidth * urlCallbackMarkdownTheme.imageTheme.imageMaximumWidth
        }
        // 图片占位图高度
        urlCallbackPlaceholderHeight = if (urlCallbackMarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            urlCallbackComponentImageWidth * 9.0 / 16.0 * urlCallbackMarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            urlCallbackComponentImageWidth * 9.0 / 16.0 * urlCallbackMarkdownTheme.imageTheme.imageMaximumWidth
        }
        // 图片对齐
        urlCallbackHorizontalAlign = if (urlCallbackImageAlign.isSome()) {
            urlCallbackImageAlign()
        } else {
            HorizontalAlign.Start
        }
        // 对齐ArkUI recalculateImageDimensions：用节点缓存的原始尺寸重算最终宽高（增量刷新时onComplete不回调）
        let urlCallbackCachedSize = recalcImageSizeFromCache(urlCallbackComponentImageWidth, urlCallbackImageNode, urlCallbackThemeWidth, urlCallbackThemeHeight, urlCallbackMarkdownTheme)
        if (urlCallbackCachedSize.size == 2) {
            urlCallbackWidth = urlCallbackCachedSize[0]
            urlCallbackHeight = urlCallbackCachedSize[1]
        } else {
            // 兜底1：直接复用节点缓存的最终显示宽高
            if (let Some(cacheWidth) <- urlCallbackImageNode.imageDisplayWidth) {
                urlCallbackWidth = cacheWidth
            } else if (urlCallbackComponentImageWidth > 0.0) {
                // 兜底2：控件宽度*图片缩放百分比（对齐ArkUI .width兜底链）
                urlCallbackWidth = urlCallbackComponentImageWidth * urlCallbackMarkdownTheme.imageTheme.imageMaximumWidth
            }
            if (let Some(cacheHeight) <- urlCallbackImageNode.imageDisplayHeight) {
                urlCallbackHeight = cacheHeight
            }
        }
        imageCallbackPixelmap()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        urlCallbackReplaceImagePixelMap?.Release()
        urlCallbackReplaceImagePixelMap = Option<PixelMap>.None
        urlCallbackReplaceFut?.cancel()
    }

    func build() {
         Column() {
             Column() {
                if (urlCallbackReplaceImageType == 1) {
                    // 替换之后的图片
                    Image(urlCallbackReplaceImagePixelMap())
                        .borderRadius(topLeft: urlCallbackRadiusTopLeft, topRight: urlCallbackRadiusTopRight, bottomLeft: urlCallbackRadiusBottomLeft, bottomRight: urlCallbackRadiusBottomRight)
                        .borderWidth(urlCallbackMarkdownTheme.imageTheme.imageBorderWidth)
                        .borderColor(urlCallbackMarkdownTheme.imageTheme.imageBorderColor)
                        .borderStyle(urlCallbackMarkdownTheme.imageTheme.imageBorderStyle)
                        .width(imageBlockDisplayWidth(urlCallbackReplaceWidth(), urlCallbackComponentWidth, urlCallbackMarkdownTheme.imageTheme.imageMaximumWidth))
                        .height(urlCallbackReplaceHeight().px)
                        .objectFit(urlCallbackMarkdownTheme.imageTheme.imageFitType)
                        .autoResize(urlCallbackMarkdownTheme.imageTheme.imageAutoResize)
                        .constraintSize(maxWidth: imageSpanConstraintMaxWidth(Option<Float64>.None, urlCallbackMarkdownTheme.imageTheme.imageMaxWidth), maxHeight: imageMaxHeightLength(urlCallbackMarkdownTheme.imageTheme.imageMaxHeight))
                        .onClick {
                            evt => imageSpanOnClick(urlCallbackLink, urlCallbackImageCallback, urlCallbackLinkCallback, urlCallbackLinkUrl, urlCallbackDestination)
                        }
                } else {
                    if (urlCallbackImageType != 2) {
                        // 加载图片
                        Image(urlCallbackDestination)
                            .borderRadius(topLeft: urlCallbackRadiusTopLeft, topRight: urlCallbackRadiusTopRight, bottomLeft: urlCallbackRadiusBottomLeft, bottomRight: urlCallbackRadiusBottomRight)
                            .borderWidth(urlCallbackMarkdownTheme.imageTheme.imageBorderWidth)
                            .borderColor(urlCallbackMarkdownTheme.imageTheme.imageBorderColor)
                            .borderStyle(urlCallbackMarkdownTheme.imageTheme.imageBorderStyle)
                            .width(imageBlockDisplayWidth(urlCallbackWidth, urlCallbackComponentWidth, urlCallbackMarkdownTheme.imageTheme.imageMaximumWidth))
                            .height(urlCallbackHeight.px)
                            .objectFit(urlCallbackMarkdownTheme.imageTheme.imageFitType)
                            .autoResize(urlCallbackMarkdownTheme.imageTheme.imageAutoResize)
                            .constraintSize(maxWidth: imageSpanConstraintMaxWidth(Option<Float64>.None, urlCallbackMarkdownTheme.imageTheme.imageMaxWidth), maxHeight: imageMaxHeightLength(urlCallbackMarkdownTheme.imageTheme.imageMaxHeight))
                            .onClick {
                                evt => imageSpanOnClick(urlCallbackLink, urlCallbackImageCallback, urlCallbackLinkCallback, urlCallbackLinkUrl, urlCallbackDestination)
                            }
                            .onComplete {
                                imageLoadResult =>
                                    // 对齐ArkUI：控件宽度未测量时兜底用图片自身渲染宽度（px，函数内部按px处理）
                                    let urlCallbackBaseWidth = if (urlCallbackComponentWidth > 0.0) {
                                        urlCallbackComponentImageWidth
                                    } else {
                                        imageLoadResult.componentWidth
                                    }
                                    let res = imageWidthAndHeight(
                                        urlCallbackBaseWidth,
                                        imageLoadResult.width,
                                        imageLoadResult.height,
                                        urlCallbackThemeWidth,
                                        urlCallbackThemeHeight,
                                        urlCallbackMarkdownTheme.imageTheme.imageMaxWidth,
                                        urlCallbackMarkdownTheme.imageTheme.imageMaxHeight,
                                        urlCallbackMarkdownTheme.imageTheme.imageFixedRatioWidth,
                                        urlCallbackMarkdownTheme.imageTheme.imageMaximumWidth
                                    )
                                    // 对齐ArkUI：仅计算结果有效时写回，避免异常结果覆盖已有宽高
                                    if (res[0] > 0.0 && res[1] > 0.0) {
                                        urlCallbackWidth = res[0]
                                        urlCallbackHeight = res[1]
                                        // 对齐ArkUI：原始尺寸与最终显示宽高写回节点缓存，供增量刷新复用
                                        cacheImageSizeToNode(urlCallbackImageNode, imageLoadResult.width, imageLoadResult.height, res[0], res[1])
                                        urlCallbackImageType = 1
                                    }
                            }
                            .onError {
                                imageError => urlCallbackImageType = 2
                            }
                    }
                    if (urlCallbackMarkdownTheme.imageTheme.imagePlaceholder.isSome() && urlCallbackImageType != 1) {
                        // 图片占位图
                        imagePlaceholderComponent(
                            urlCallbackMarkdownTheme.imageTheme.imagePlaceholder(),
                            urlCallbackPlaceholderWidth,
                            urlCallbackPlaceholderHeight,
                            urlCallbackRadiusTopLeft,
                            urlCallbackRadiusTopRight,
                            urlCallbackRadiusBottomLeft,
                            urlCallbackRadiusBottomRight,
                            urlCallbackMarkdownTheme.imageTheme.imageBorderWidth,
                            urlCallbackMarkdownTheme.imageTheme.imageBorderColor,
                            urlCallbackMarkdownTheme.imageTheme.imageBorderStyle
                        )
                    }
                }
            }
            .alignItems(urlCallbackHorizontalAlign)
            // 边距挂在图片容器上（对齐ArkUI：下载按钮在图片下边距之外）
            .margin(top: urlCallbackMarkdownTheme.imageTheme.imageMarginTop, right: urlCallbackMarkdownTheme.imageTheme.imageMarginRight, bottom: urlCallbackMarkdownTheme.imageTheme.imageMarginBottom, left: urlCallbackMarkdownTheme.imageTheme.imageMarginLeft)
            if (urlCallbackMarkdownTheme.imageTheme.imageDownloadButtonVisible) {
                MarkdownImageDownloadComponent(
                    markdownTheme: urlCallbackMarkdownTheme,
                    destination: urlCallbackDestination,
                    imageDownloadCallback: urlCallbackImageDownloadCallback
                )
            }
        }
    }

    func imageCallbackPixelmap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            imagePixelMap, imageResWidth, imageResHeight => launch {
                if (imagePixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    this.urlCallbackReplaceImagePixelMap = imagePixelMap
                    let res = imageWidthAndHeight(
                        urlCallbackComponentImageWidth,
                        imageResWidth(),
                        imageResHeight(),
                        urlCallbackThemeWidth,
                        urlCallbackThemeHeight,
                        urlCallbackMarkdownTheme.imageTheme.imageMaxWidth,
                        urlCallbackMarkdownTheme.imageTheme.imageMaxHeight,
                        urlCallbackMarkdownTheme.imageTheme.imageFixedRatioWidth,
                        urlCallbackMarkdownTheme.imageTheme.imageMaximumWidth
                    )
                    // 对齐ArkUI：仅计算结果有效时写回，避免异常结果覆盖已有宽高
                    if (res[0] > 0.0 && res[1] > 0.0) {
                        urlCallbackReplaceWidth = res[0]
                        urlCallbackReplaceHeight = res[1]
                        // 写回尺寸缓存（对齐ArkUI oldImageSizes保留逻辑）
                        cacheImageSizeToNode(urlCallbackImageNode, imageResWidth(), imageResHeight(), res[0], res[1])
                        urlCallbackReplaceImageType = 1
                    } else {
                        urlCallbackReplaceImageType = 2
                    }
                }
            }
        }
        urlCallbackReplaceFut = MarkdownParseImageUtil.callbackToPixelmap(
            urlCallbackDestination,
            urlCallbackImageReplaceCallback,
            callback
        )
    }
}
