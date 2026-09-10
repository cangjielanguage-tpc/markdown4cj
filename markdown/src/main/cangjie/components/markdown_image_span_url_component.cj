package markdown.components

import ohos.state_macro_manage.*

/**
 * URL
 */
@Component
public class MarkdownSpanImageUrlComponent {
    @Prop
    var urlMarkdownTheme: MarkdownTheme // markdown配置
    var urlDestination: String // 图片链接
    @Prop var urlComponentWidth: Float64 // 控件宽度 - 单位vp
    var urlImageCallback: (String) -> Unit // 图片点击事件
    var urlLinkCallback: ?(String) -> Unit // 链接点击事件
    var urlLink: Bool // 是否是链接
    var urlLinkUrl: Option<String> // 链接URL
    var urlImageWidthCallback: ?(Float64) -> Unit = Option<(Float64) -> Unit>.None // 图片加载完成后实际显示宽度回调 - 单位vp（表格列宽跟踪用）
    var urlImageCellMaxWidth: ?Float64 = Option<Float64>.None // 表格单元格最大宽度 - 单位vp（表格场景传入，作为图片宽度计算基准与约束宽度）
    var urlImageWidth: Option<Length> // 图片宽度
    var urlImageHeight: Option<Length> // 图片高度
    var urlImageRadius: Option<Length> // 图片圆角
    var urlImageAlign: Option<HorizontalAlign> // 图片对齐方式
    var urlImageNode: NodeView // 图片节点（缓存原始尺寸与最终显示宽高，对齐ArkUI item引用）
    @State var urlHeight: Float64 = 0.0 // 图片最终高度 - 单位px
    @State var urlWidth: Float64 = 0.0 // 图片最终宽度 - 单位px
    @State var urlImageType: Int64 = 0 // 图片加载 0：开始加载。1：加载成功完成。2：加载失败
    @State var urlRadiusTopLeft: Float64 = 0.0 // 图片左上圆角 - 单位vp
    @State var urlRadiusTopRight: Float64 = 0.0 // 图片右上圆角 - 单位vp
    @State var urlRadiusBottomLeft: Float64 = 0.0 // 图片左下圆角 - 单位vp
    @State var urlRadiusBottomRight: Float64 = 0.0 // 图片右下圆角 - 单位vp
    @State var urlThemeHeight: Option<Float64> = Option<Float64>.None // 图片设置高度 - 单位px
    @State var urlThemeWidth: Option<Float64> = Option<Float64>.None // 图片设置宽度 - 单位px
    @State var urlPlaceholderHeight: Float64 = 0.0 // 占位图片高度 - 单位px
    @State var urlPlaceholderWidth: Float64 = 0.0 // 占位图片宽度 - 单位px
    @State var urlComponentImageWidth: Float64 = 0.0 // 图片最大宽度 - 单位px
    @State var urlImageResPixelMap: Option<PixelMap> = Option<PixelMap>.None // 占位图图片数据
    var urlResFut: ?Future<Unit> = Option<Future<Unit>>.None // 占位图解析子线程
    @State var urlImageResType: Int64 = 0 // 占位图图片加载 0：开始加载。1：加载成功完成。2：加载失败

    protected override func aboutToAppear(): Unit {
        urlComponentImageWidth = vp2px(urlComponentWidth.vp)().value // 图片最大宽度单位转换
        // 表格单元格场景：以单元格最大宽度为图片宽度计算基准（对齐ArkUI tableMaxCellWidth优先逻辑）
        if (let Some(cellMaxWidth) <- urlImageCellMaxWidth) {
            if (cellMaxWidth > 0.0) {
                urlComponentImageWidth = vp2px(cellMaxWidth.vp)().value
            }
        }
        // 图片圆角
        let radius = imageSpanBorderRadius(
            urlImageRadius,
            urlMarkdownTheme.imageTheme.imageRadiusTopLeft,
            urlMarkdownTheme.imageTheme.imageRadiusTopRight,
            urlMarkdownTheme.imageTheme.imageRadiusBottomLeft,
            urlMarkdownTheme.imageTheme.imageRadiusBottomRight
        )
        urlRadiusTopLeft = radius[0] // 图片左上圆角
        urlRadiusTopRight = radius[1] // 图片右上圆角
        urlRadiusBottomLeft = radius[2] // 图片左下圆角
        urlRadiusBottomRight = radius[3] // 图片右下圆角
        // 图片设置宽度
        urlThemeWidth = widthHeightLength2FloatPx(
            urlImageWidth,
            urlMarkdownTheme.imageTheme.imageWidth,
            urlComponentImageWidth
        )
        // 图片设置高度
        urlThemeHeight = widthHeightLength2FloatPx(
            urlImageHeight,
            urlMarkdownTheme.imageTheme.imageHeight,
            urlComponentImageWidth
        )
        // 图片占位图宽度
        urlPlaceholderWidth = if (urlMarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            urlComponentImageWidth * urlMarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            urlComponentImageWidth * urlMarkdownTheme.imageTheme.imageMaximumWidth
        }
        // 图片占位图高度
        urlPlaceholderHeight = if (urlMarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            urlComponentImageWidth * 9.0 / 16.0 * urlMarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            urlComponentImageWidth * 9.0 / 16.0 * urlMarkdownTheme.imageTheme.imageMaximumWidth
        }
        // 对齐ArkUI：用节点缓存重算/复用最终显示宽高（增量刷新时onComplete不回调）
        let urlCachedSize = recalcImageSizeFromCache(urlComponentImageWidth, urlImageNode, urlThemeWidth, urlThemeHeight, urlMarkdownTheme)
        if (urlCachedSize.size == 2) {
            urlWidth = urlCachedSize[0]
            urlHeight = urlCachedSize[1]
        } else {
            // 兜底：直接复用节点缓存的最终显示宽高
            if (let Some(cacheWidth) <- urlImageNode.imageDisplayWidth) {
                urlWidth = cacheWidth
            }
            if (let Some(cacheHeight) <- urlImageNode.imageDisplayHeight) {
                urlHeight = cacheHeight
            }
        }
        if (urlMarkdownTheme.imageTheme.imagePlaceholder.isSome()) {
            imageResourcePixelMap()
        }
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        urlImageResPixelMap?.Release()
        urlImageResPixelMap = Option<PixelMap>.None
        urlResFut?.cancel()
    }

    func build() {
        if (urlMarkdownTheme.imageTheme.imagePlaceholder.isSome() && urlImageResType == 1) {
            ImageSpan(urlDestination)
                .alt(urlImageResPixelMap())
                .margin(
                    top: urlMarkdownTheme.imageTheme.imageMarginTop,
                    right: urlMarkdownTheme.imageTheme.imageMarginRight,
                    bottom: urlMarkdownTheme.imageTheme.imageMarginBottom,
                    left: urlMarkdownTheme.imageTheme.imageMarginLeft
                )
                .borderRadius(
                    topLeft: urlRadiusTopLeft,
                    topRight: urlRadiusTopRight,
                    bottomLeft: urlRadiusBottomLeft,
                    bottomRight: urlRadiusBottomRight
                )
                .borderWidth(urlMarkdownTheme.imageTheme.imageBorderWidth)
                .borderColor(urlMarkdownTheme.imageTheme.imageBorderColor)
                .borderStyle(urlMarkdownTheme.imageTheme.imageBorderStyle)
                .width(urlWidth.px)
                .height(urlHeight.px)
                .objectFit(urlMarkdownTheme.imageTheme.imageFitType)
                .verticalAlign(ImageSpanAlignment.CENTER)
                .constraintSize(maxWidth: imageSpanConstraintMaxWidth(urlImageCellMaxWidth, urlMarkdownTheme.imageTheme.imageMaxWidth), maxHeight: imageMaxHeightLength(urlMarkdownTheme.imageTheme.imageMaxHeight))
                .onClick {
                    evt => imageSpanOnClick(urlLink, urlImageCallback, urlLinkCallback, urlLinkUrl, urlDestination)
                }
                .onComplete {
                    imageLoadResult =>
                        // 对齐ArkUI：实时取宽度基准（单元格最大宽度 → 实时控件宽度 → 兜底图片自然宽度）
                        var urlBaseWidth = 0.0
                        if (let Some(cellMaxWidth) <- urlImageCellMaxWidth) {
                            if (cellMaxWidth > 0.0) {
                                urlBaseWidth = vp2px(cellMaxWidth.vp)().value
                            }
                        }
                        if (urlBaseWidth <= 0.0 && urlComponentWidth > 0.0) {
                            urlBaseWidth = vp2px(urlComponentWidth.vp)().value
                        }
                        if (urlBaseWidth <= 0.0) {
                            urlBaseWidth = imageLoadResult.width
                        }
                        if (urlBaseWidth > 0.0) {
                            let res = imageWidthAndHeight(
                                urlBaseWidth,
                                imageLoadResult.width,
                                imageLoadResult.height,
                                urlThemeWidth,
                                urlThemeHeight,
                                urlMarkdownTheme.imageTheme.imageMaxWidth,
                                urlMarkdownTheme.imageTheme.imageMaxHeight,
                                urlMarkdownTheme.imageTheme.imageFixedRatioWidth,
                                urlMarkdownTheme.imageTheme.imageMaximumWidth
                            )
                            // 对齐ArkUI：仅计算结果有效时写回，避免异常结果覆盖已有宽高
                            if (res[0] > 0.0 && res[1] > 0.0) {
                                urlWidth = res[0]
                                urlHeight = res[1]
                                // 对齐ArkUI：原始尺寸与最终显示宽高写回节点缓存，供增量刷新复用
                                cacheImageSizeToNode(urlImageNode, imageLoadResult.width, imageLoadResult.height, res[0], res[1])
                                urlImageType = 1
                                notifyImageWidth()
                            }
                        }
                }
                .onError {
                    imageError => urlImageType = 2
                }
        } else {
            ImageSpan(urlDestination)
                .margin(
                    top: urlMarkdownTheme.imageTheme.imageMarginTop,
                    right: urlMarkdownTheme.imageTheme.imageMarginRight,
                    bottom: urlMarkdownTheme.imageTheme.imageMarginBottom,
                    left: urlMarkdownTheme.imageTheme.imageMarginLeft
                )
                .borderRadius(
                    topLeft: urlRadiusTopLeft,
                    topRight: urlRadiusTopRight,
                    bottomLeft: urlRadiusBottomLeft,
                    bottomRight: urlRadiusBottomRight
                )
                .borderWidth(urlMarkdownTheme.imageTheme.imageBorderWidth)
                .borderColor(urlMarkdownTheme.imageTheme.imageBorderColor)
                .borderStyle(urlMarkdownTheme.imageTheme.imageBorderStyle)
                .width(urlWidth.px)
                .height(urlHeight.px)
                .objectFit(urlMarkdownTheme.imageTheme.imageFitType)
                .verticalAlign(ImageSpanAlignment.CENTER)
                .constraintSize(maxWidth: imageSpanConstraintMaxWidth(urlImageCellMaxWidth, urlMarkdownTheme.imageTheme.imageMaxWidth), maxHeight: imageMaxHeightLength(urlMarkdownTheme.imageTheme.imageMaxHeight))
                .onClick {
                    evt => imageSpanOnClick(urlLink, urlImageCallback, urlLinkCallback, urlLinkUrl, urlDestination)
                }
                .onComplete {
                    imageLoadResult =>
                        // 对齐ArkUI：实时取宽度基准（单元格最大宽度 → 实时控件宽度 → 兜底图片自然宽度）
                        var urlBaseWidth = 0.0
                        if (let Some(cellMaxWidth) <- urlImageCellMaxWidth) {
                            if (cellMaxWidth > 0.0) {
                                urlBaseWidth = vp2px(cellMaxWidth.vp)().value
                            }
                        }
                        if (urlBaseWidth <= 0.0 && urlComponentWidth > 0.0) {
                            urlBaseWidth = vp2px(urlComponentWidth.vp)().value
                        }
                        if (urlBaseWidth <= 0.0) {
                            urlBaseWidth = imageLoadResult.width
                        }
                        if (urlBaseWidth > 0.0) {
                            let res = imageWidthAndHeight(
                                urlBaseWidth,
                                imageLoadResult.width,
                                imageLoadResult.height,
                                urlThemeWidth,
                                urlThemeHeight,
                                urlMarkdownTheme.imageTheme.imageMaxWidth,
                                urlMarkdownTheme.imageTheme.imageMaxHeight,
                                urlMarkdownTheme.imageTheme.imageFixedRatioWidth,
                                urlMarkdownTheme.imageTheme.imageMaximumWidth
                            )
                            // 对齐ArkUI：仅计算结果有效时写回，避免异常结果覆盖已有宽高
                            if (res[0] > 0.0 && res[1] > 0.0) {
                                urlWidth = res[0]
                                urlHeight = res[1]
                                // 对齐ArkUI：原始尺寸与最终显示宽高写回节点缓存，供增量刷新复用
                                cacheImageSizeToNode(urlImageNode, imageLoadResult.width, imageLoadResult.height, res[0], res[1])
                                urlImageType = 1
                                notifyImageWidth()
                            }
                        }
                }
                .onError {
                    imageError => urlImageType = 2
                }
        }
    }

    /**
     * 图片加载完成后，回调实际显示宽度（vp），供表格列宽跟踪使用
     */
    func notifyImageWidth(): Unit {
        if (urlWidth > 0.0) {
            if (let Some(cb) <- urlImageWidthCallback) {
                cb(px2vp(urlWidth.px).getOrThrow().value)
            }
        }
    }

    /**
     * 占位图图片加载
     */
    func imageResourcePixelMap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            urlImageResPixelMap, imageResWidth, imageResHeight => launch {
                if (urlImageResPixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    let res = imageWidthAndHeight(
                        urlComponentImageWidth,
                        imageResWidth(),
                        imageResHeight(),
                        urlThemeWidth,
                        urlThemeHeight,
                        urlMarkdownTheme.imageTheme.imageMaxWidth,
                        urlMarkdownTheme.imageTheme.imageMaxHeight,
                        urlMarkdownTheme.imageTheme.imageFixedRatioWidth,
                        urlMarkdownTheme.imageTheme.imageMaximumWidth
                    )
                    if (urlImageType != 1) {
                        this.urlImageResPixelMap = urlImageResPixelMap
                        urlPlaceholderWidth = res[0]
                        urlPlaceholderHeight = res[1]
                        urlImageResType = 1
                    }
                } else {
                    urlImageResType = 2
                }
            }
        }
        urlResFut = MarkdownParseImageUtil.resourceToPixelmap(
            urlMarkdownTheme.imageTheme.imagePlaceholder(),
            urlMarkdownTheme.globalTheme.uiAbilityContext,
            urlMarkdownTheme.globalTheme.stageContext,
            callback
        )
    }
}
