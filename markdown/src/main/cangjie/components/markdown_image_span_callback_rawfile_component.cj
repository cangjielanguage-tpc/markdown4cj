package markdown.components

import ohos.state_macro_manage.*

/**
 * RawFile入参的图片
 */
@Component
public class MarkdownSpanImageCallbackRawFileComponent {
    @Prop
    var rawFileCallbackMarkdownTheme: MarkdownTheme // markdown配置
    var rawFileCallbackDestination: String // 图片链接
    @Prop
    var rawFileCallbackComponentWidth: Float64 // 控件宽度 - 单位vp
    var rawFileCallbackImageReplaceCallback: (String) -> ?Array<UInt8> // 图片替换事件
    var rawFileCallbackImageCallback: (String) -> Unit // 图片点击事件
    var rawFileCallbackLinkCallback: ?(String) -> Unit // 链接点击事件
    var rawFileCallbackLink: Bool // 是否是链接
    var rawFileCallbackLinkUrl: Option<String> // 链接URL
    var rawFileCallbackImageWidthCallback: ?(Float64) -> Unit = Option<(Float64) -> Unit>.None // 图片加载完成后实际显示宽度回调 - 单位vp（表格列宽跟踪用）
    var rawFileCallbackImageCellMaxWidth: ?Float64 = Option<Float64>.None // 表格单元格最大宽度 - 单位vp（表格场景传入，作为图片宽度计算基准与约束宽度）
    var rawFileCallbackImageWidth: Option<Length> // 图片宽度
    var rawFileCallbackImageHeight: Option<Length> // 图片高度
    var rawFileCallbackImageRadius: Option<Length> // 图片圆角
    var rawFileCallbackImageAlign: Option<HorizontalAlign> // 图片对齐方式
    var rawFileCallbackImageNode: NodeView // 图片节点（缓存原始尺寸与最终显示宽高，对齐ArkUI item引用）
    @State
    var rawFileCallbackImageType: Int64 = 0 // 图片加载 0：开始加载。1：加载成功完成。2：加载失败
    @State
    var rawFileCallbackImagePixelMap: Option<PixelMap> = Option<PixelMap>.None // 图片数据
    @State
    var rawFileCallbackHeight: Float64 = 0.0 // 图片最终高度 - 单位px
    @State
    var rawFileCallbackWidth: Float64 = 0.0 // 图片最终宽度 - 单位px
    @State
    var rawFileCallbackRadiusTopLeft: Float64 = 0.0 // 图片左上圆角 - 单位vp
    @State
    var rawFileCallbackRadiusTopRight: Float64 = 0.0 // 图片右上圆角 - 单位vp
    @State
    var rawFileCallbackRadiusBottomLeft: Float64 = 0.0 // 图片左下圆角 - 单位vp
    @State
    var rawFileCallbackRadiusBottomRight: Float64 = 0.0 // 图片右下圆角 - 单位vp
    @State
    var rawFileCallbackThemeHeight: Option<Float64> = Option<Float64>.None // 图片设置高度 - 单位px
    @State
    var rawFileCallbackThemeWidth: Option<Float64> = Option<Float64>.None // 图片设置宽度 - 单位px
    @State
    var rawFileCallbackPlaceholderHeight: Float64 = 0.0 // 占位图片高度 - 单位px
    @State
    var rawFileCallbackPlaceholderWidth: Float64 = 0.0 // 占位图片宽度 - 单位px
    @State
    var rawFileCallbackReplaceWidth: ?Float64 = Option<Float64>.None // 替换之后的图片宽度 - 单位px
    @State
    var rawFileCallbackReplaceHeight: ?Float64 = Option<Float64>.None // 替换之后的图片高度 - 单位px
    @State
    var rawFileCallbackReplaceImagePixelMap: Option<PixelMap> = Option<PixelMap>.None // 替换之后的图片数据
    @State
    var rawFileCallbackReplaceImageType: Int64 = 0 // 解析加载 0：开始解析。1：解析成功完成。2：解析失败
    var rawFileCallbackReplaceFut: ?Future<Unit> = Option<Future<Unit>>.None // 替换子线程
    @State
    var rawFileCallbackComponentImageWidth: Float64 = 0.0 // 图片最大宽度 - 单位px
    var rawFileCallbackFut: ?Future<Unit> = Option<Future<Unit>>.None // 解析子线程

    protected override func aboutToAppear(): Unit {
        rawFileCallbackComponentImageWidth = vp2px(rawFileCallbackComponentWidth.vp)().value // 图片最大宽度单位转换
        // 表格单元格场景：以单元格最大宽度为图片宽度计算基准（对齐ArkUI tableMaxCellWidth优先逻辑）
        if (let Some(cellMaxWidth) <- rawFileCallbackImageCellMaxWidth) {
            if (cellMaxWidth > 0.0) {
                rawFileCallbackComponentImageWidth = vp2px(cellMaxWidth.vp)().value
            }
        }
        // 图片圆角
        let radius = imageSpanBorderRadius(rawFileCallbackImageRadius, rawFileCallbackMarkdownTheme.imageTheme.imageRadiusTopLeft, rawFileCallbackMarkdownTheme.imageTheme.imageRadiusTopRight, rawFileCallbackMarkdownTheme.imageTheme.imageRadiusBottomLeft, rawFileCallbackMarkdownTheme.imageTheme.imageRadiusBottomRight)
        rawFileCallbackRadiusTopLeft =  radius[0] // 图片左上圆角
        rawFileCallbackRadiusTopRight =  radius[1] // 图片右上圆角
        rawFileCallbackRadiusBottomLeft =  radius[2] // 图片左下圆角
        rawFileCallbackRadiusBottomRight =  radius[3] // 图片右下圆角
        rawFileCallbackThemeWidth = widthHeightLength2FloatPx(rawFileCallbackImageWidth, rawFileCallbackMarkdownTheme.imageTheme.imageWidth, rawFileCallbackComponentImageWidth) // 图片设置宽度
        rawFileCallbackThemeHeight = widthHeightLength2FloatPx(rawFileCallbackImageHeight, rawFileCallbackMarkdownTheme.imageTheme.imageHeight, rawFileCallbackComponentImageWidth) // 图片设置高度
        // 图片占位图宽度
        rawFileCallbackPlaceholderWidth = if (rawFileCallbackMarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            rawFileCallbackComponentImageWidth * rawFileCallbackMarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            rawFileCallbackComponentImageWidth * rawFileCallbackMarkdownTheme.imageTheme.imageMaximumWidth
        }
        // 图片占位图高度
        rawFileCallbackPlaceholderHeight = if (rawFileCallbackMarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            rawFileCallbackComponentImageWidth * 9.0 / 16.0 * rawFileCallbackMarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            rawFileCallbackComponentImageWidth * 9.0 / 16.0 * rawFileCallbackMarkdownTheme.imageTheme.imageMaximumWidth
        }
        // 读取缓存：优先用缓存原始尺寸重算宽高（对齐ArkUI item.imageNaturalWidth复用）
        let rawFileCallbackCachedSize = recalcImageSizeFromCache(rawFileCallbackComponentImageWidth, rawFileCallbackImageNode, rawFileCallbackThemeWidth, rawFileCallbackThemeHeight, rawFileCallbackMarkdownTheme)
        if (rawFileCallbackCachedSize.size == 2) {
            rawFileCallbackWidth = rawFileCallbackCachedSize[0]
            rawFileCallbackHeight = rawFileCallbackCachedSize[1]
        } else {
            if (let Some(cacheWidth) <- rawFileCallbackImageNode.imageDisplayWidth) {
                rawFileCallbackWidth = cacheWidth
            }
            if (let Some(cacheHeight) <- rawFileCallbackImageNode.imageDisplayHeight) {
                rawFileCallbackHeight = cacheHeight
            }
        }
        imageCallbackPixelmap()
        localRowImageToPixelMap()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        rawFileCallbackReplaceImagePixelMap?.Release()
        rawFileCallbackReplaceImagePixelMap = Option<PixelMap>.None
        rawFileCallbackReplaceFut?.cancel()
        rawFileCallbackImagePixelMap?.Release()
        rawFileCallbackImagePixelMap = Option<PixelMap>.None
        rawFileCallbackFut?.cancel()
    }

    func build() {
        if (true) {
            if (rawFileCallbackReplaceImageType == 1) {
                // 替换之后的图片
                ImageSpan(rawFileCallbackReplaceImagePixelMap())
                    .margin(top: rawFileCallbackMarkdownTheme.imageTheme.imageMarginTop, right: rawFileCallbackMarkdownTheme.imageTheme.imageMarginRight, bottom: rawFileCallbackMarkdownTheme.imageTheme.imageMarginBottom, left: rawFileCallbackMarkdownTheme.imageTheme.imageMarginLeft)
                    .borderRadius(
                        topLeft: rawFileCallbackRadiusTopLeft,
                        topRight: rawFileCallbackRadiusTopRight,
                        bottomLeft: rawFileCallbackRadiusBottomLeft,
                        bottomRight: rawFileCallbackRadiusBottomRight
                    )
                    .borderWidth(rawFileCallbackMarkdownTheme.imageTheme.imageBorderWidth)
                    .borderColor(rawFileCallbackMarkdownTheme.imageTheme.imageBorderColor)
                    .borderStyle(rawFileCallbackMarkdownTheme.imageTheme.imageBorderStyle)
                    .width(rawFileCallbackReplaceWidth().px)
                    .height(rawFileCallbackReplaceHeight().px)
                    .objectFit(rawFileCallbackMarkdownTheme.imageTheme.imageFitType)
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    .constraintSize(maxWidth: imageSpanConstraintMaxWidth(rawFileCallbackImageCellMaxWidth, rawFileCallbackMarkdownTheme.imageTheme.imageMaxWidth), maxHeight: imageMaxHeightLength(rawFileCallbackMarkdownTheme.imageTheme.imageMaxHeight))
                    .onClick {
                        evt => imageSpanOnClick(rawFileCallbackLink, rawFileCallbackImageCallback, rawFileCallbackLinkCallback, rawFileCallbackLinkUrl, rawFileCallbackDestination)
                    }
            } else {
                if (rawFileCallbackImageType == 1) {
                    // 加载图片
                    ImageSpan(rawFileCallbackImagePixelMap())
                        .margin(top: rawFileCallbackMarkdownTheme.imageTheme.imageMarginTop, right: rawFileCallbackMarkdownTheme.imageTheme.imageMarginRight, bottom: rawFileCallbackMarkdownTheme.imageTheme.imageMarginBottom, left: rawFileCallbackMarkdownTheme.imageTheme.imageMarginLeft)
                        .borderRadius(
                            topLeft: rawFileCallbackRadiusTopLeft,
                            topRight: rawFileCallbackRadiusTopRight,
                            bottomLeft: rawFileCallbackRadiusBottomLeft,
                            bottomRight: rawFileCallbackRadiusBottomRight
                        )
                        .borderWidth(rawFileCallbackMarkdownTheme.imageTheme.imageBorderWidth)
                        .borderColor(rawFileCallbackMarkdownTheme.imageTheme.imageBorderColor)
                        .borderStyle(rawFileCallbackMarkdownTheme.imageTheme.imageBorderStyle)
                        .width(rawFileCallbackWidth.px)
                        .height(rawFileCallbackHeight.px)
                        .objectFit(rawFileCallbackMarkdownTheme.imageTheme.imageFitType)
                        .verticalAlign(ImageSpanAlignment.CENTER)
                        .constraintSize(maxWidth: imageSpanConstraintMaxWidth(rawFileCallbackImageCellMaxWidth, rawFileCallbackMarkdownTheme.imageTheme.imageMaxWidth), maxHeight: imageMaxHeightLength(rawFileCallbackMarkdownTheme.imageTheme.imageMaxHeight))
                        .onClick {
                            evt => imageSpanOnClick(rawFileCallbackLink, rawFileCallbackImageCallback, rawFileCallbackLinkCallback, rawFileCallbackLinkUrl, rawFileCallbackDestination)
                        }
                }
                if (rawFileCallbackMarkdownTheme.imageTheme.imagePlaceholder.isSome() && rawFileCallbackImageType != 1 && !isInTableCell()) {
                    // 图片占位图（表格单元格场景不渲染：对齐ArkUI图片加载前宽度为0、占位图不撑宽单元格的语义）
                    imageSpanPlaceholderComponent(
                        rawFileCallbackMarkdownTheme.imageTheme.imagePlaceholder(),
                        rawFileCallbackMarkdownTheme.imageTheme.imageMarginTop,
                        rawFileCallbackMarkdownTheme.imageTheme.imageMarginRight,
                        rawFileCallbackMarkdownTheme.imageTheme.imageMarginBottom,
                        rawFileCallbackMarkdownTheme.imageTheme.imageMarginLeft,
                        rawFileCallbackPlaceholderWidth,
                        rawFileCallbackPlaceholderHeight,
                        rawFileCallbackRadiusTopLeft,
                        rawFileCallbackRadiusTopRight,
                        rawFileCallbackRadiusBottomLeft,
                        rawFileCallbackRadiusBottomRight,
                        rawFileCallbackMarkdownTheme.imageTheme.imageBorderWidth,
                        rawFileCallbackMarkdownTheme.imageTheme.imageBorderColor,
                        rawFileCallbackMarkdownTheme.imageTheme.imageBorderStyle
                    )
                }
            }
        }
    }

    func imageCallbackPixelmap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            imagePixelMap, imageResWidth, imageResHeight => launch {
                if (imagePixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    this.rawFileCallbackReplaceImagePixelMap = imagePixelMap
                    // 对齐ArkUI：优先单元格最大宽度，其次控件宽度，兜底图片自然宽度
                    var rawFileCallbackBaseWidth = 0.0
                    if (let Some(cellMaxWidth) <- rawFileCallbackImageCellMaxWidth) {
                        if (cellMaxWidth > 0.0) {
                            rawFileCallbackBaseWidth = vp2px(cellMaxWidth.vp)().value
                        }
                    }
                    if (rawFileCallbackBaseWidth <= 0.0 && rawFileCallbackComponentWidth > 0.0) {
                        rawFileCallbackBaseWidth = vp2px(rawFileCallbackComponentWidth.vp)().value
                    }
                    if (rawFileCallbackBaseWidth <= 0.0) {
                        rawFileCallbackBaseWidth = imageResWidth()
                    }
                    if (rawFileCallbackBaseWidth > 0.0) {
                        let res = imageWidthAndHeight(
                            rawFileCallbackBaseWidth,
                            imageResWidth(),
                            imageResHeight(),
                            rawFileCallbackThemeWidth,
                            rawFileCallbackThemeHeight,
                            rawFileCallbackMarkdownTheme.imageTheme.imageMaxWidth,
                            rawFileCallbackMarkdownTheme.imageTheme.imageMaxHeight,
                            rawFileCallbackMarkdownTheme.imageTheme.imageFixedRatioWidth,
                            rawFileCallbackMarkdownTheme.imageTheme.imageMaximumWidth
                        )
                        // 对齐ArkUI：仅计算结果有效时写回，避免异常结果覆盖已有宽高
                        if (res[0] > 0.0 && res[1] > 0.0) {
                            rawFileCallbackReplaceWidth = res[0]
                            rawFileCallbackReplaceHeight = res[1]
                            rawFileCallbackReplaceImageType = 1
                            if (let Some(rw) <- rawFileCallbackReplaceWidth) {
                                notifyImageWidthByPx(rw)
                            }
                        }
                    }
                } else {
                    rawFileCallbackReplaceImageType = 2
                }
            }
        }
        rawFileCallbackReplaceFut = MarkdownParseImageUtil.callbackToPixelmap(
            rawFileCallbackDestination,
            rawFileCallbackImageReplaceCallback,
            callback
        )
    }

    /**
     * 本地图片加载
     */
    func localRowImageToPixelMap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            rawFileCallbackImagePixelMap, imageResWidth, imageResHeight => launch {
                if (rawFileCallbackImagePixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    this.rawFileCallbackImagePixelMap = rawFileCallbackImagePixelMap
                    // 对齐ArkUI：优先单元格最大宽度，其次控件宽度，兜底图片自然宽度
                    var rawFileCallbackBaseWidth = 0.0
                    if (let Some(cellMaxWidth) <- rawFileCallbackImageCellMaxWidth) {
                        if (cellMaxWidth > 0.0) {
                            rawFileCallbackBaseWidth = vp2px(cellMaxWidth.vp)().value
                        }
                    }
                    if (rawFileCallbackBaseWidth <= 0.0 && rawFileCallbackComponentWidth > 0.0) {
                        rawFileCallbackBaseWidth = vp2px(rawFileCallbackComponentWidth.vp)().value
                    }
                    if (rawFileCallbackBaseWidth <= 0.0) {
                        rawFileCallbackBaseWidth = imageResWidth()
                    }
                    if (rawFileCallbackBaseWidth > 0.0) {
                        let res = imageWidthAndHeight(
                            rawFileCallbackBaseWidth,
                            imageResWidth(),
                            imageResHeight(),
                            rawFileCallbackThemeWidth,
                            rawFileCallbackThemeHeight,
                            rawFileCallbackMarkdownTheme.imageTheme.imageMaxWidth,
                            rawFileCallbackMarkdownTheme.imageTheme.imageMaxHeight,
                            rawFileCallbackMarkdownTheme.imageTheme.imageFixedRatioWidth,
                            rawFileCallbackMarkdownTheme.imageTheme.imageMaximumWidth
                        )
                        // 对齐ArkUI：仅计算结果有效时写回，避免异常结果覆盖已有宽高
                        if (res[0] > 0.0 && res[1] > 0.0) {
                            rawFileCallbackWidth = res[0]
                            rawFileCallbackHeight = res[1]
                            // 对齐ArkUI：原始尺寸与最终显示宽高写回节点缓存，供增量刷新复用
                            cacheImageSizeToNode(rawFileCallbackImageNode, imageResWidth(), imageResHeight(), res[0], res[1])
                            rawFileCallbackImageType = 1
                            notifyImageWidth()
                        }
                    }
                } else {
                    rawFileCallbackImageType = 2
                }
            }
        }
        rawFileCallbackFut = MarkdownParseImageUtil.rawfileToPixelmap(
            rawFileCallbackDestination,
            rawFileCallbackMarkdownTheme.globalTheme.uiAbilityContext,
            rawFileCallbackMarkdownTheme.globalTheme.stageContext,
            callback
        )
    }

    /**
     * 图片加载完成后，回调实际显示宽度（vp），供表格列宽跟踪使用
     */
    func notifyImageWidthByPx(widthPx: Float64): Unit {
        if (widthPx > 0.0) {
            if (let Some(cb) <- rawFileCallbackImageWidthCallback) {
                cb(px2vp(widthPx.px).getOrThrow().value)
            }
        }
    }

    func notifyImageWidth(): Unit {
        notifyImageWidthByPx(rawFileCallbackWidth)
    }

    /**
     * 是否处于表格单元格场景（单元格最大宽度已传入且有效）
     */
    func isInTableCell(): Bool {
        if (let Some(cellMaxWidth) <- rawFileCallbackImageCellMaxWidth) {
            return cellMaxWidth > 0.0
        }
        return false
    }
}
