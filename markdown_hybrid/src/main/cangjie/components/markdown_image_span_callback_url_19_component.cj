package markdown.components

import ohos.state_macro_manage.*

/**
* URL入参API大于等于19的图片
 */
@Component
public class MarkdownSpanImageCallbackUrl19Component {
    var url19CallbackMarkdownTheme: MarkdownTheme // markdown配置
    var url19CallbackDestination: String // 图片链接
    @Prop var url19CallbackComponentWidth: Float64 // 控件宽度 - 单位vp
    var url19CallbackImageCallbackCallback: (String) -> ?Array<UInt8> // 图片替换事件
    var url19CallbackImageCallback: (String) -> Unit // 图片点击事件
    var url19CallbackLinkCallback: ?(String) -> Unit // 链接点击事件
    var url19CallbackLink: Bool // 是否是链接
    var url19CallbackLinkUrl: Option<String> // 链接URL
    var url19CallbackImageWidth: Option<Length> // 图片宽度
    var url19CallbackImageHeight: Option<Length> // 图片高度
    var url19CallbackImageRadius: Option<Length> // 图片圆角
    var url19CallbackImageAlign: Option<HorizontalAlign> // 图片对齐方式
    @State var url19CallbackImageType: Int64 = 0 // 图片加载 0：开始加载。1：加载成功完成。2：加载失败
    @State var url19CallbackHeight: Float64 = 0.0 // 图片最终高度 - 单位px
    @State var url19CallbackWidth: Float64 = 0.0 // 图片最终宽度 - 单位px
    @State var url19CallbackRadiusTopLeft: Float64 = 0.0 // 图片左上圆角 - 单位vp
    @State var url19CallbackRadiusTopRight: Float64 = 0.0 // 图片右上圆角 - 单位vp
    @State var url19CallbackRadiusBottomLeft: Float64 = 0.0 // 图片左下圆角 - 单位vp
    @State var url19CallbackRadiusBottomRight: Float64 = 0.0 // 图片右下圆角 - 单位vp
    @State var url19CallbackThemeHeight: Option<Float64> = Option<Float64>.None // 图片设置高度 - 单位px
    @State var url19CallbackThemeWidth: Option<Float64> = Option<Float64>.None // 图片设置宽度 - 单位px
    @State var url19CallbackPlaceholderHeight: Float64 = 0.0 // 占位图片高度 - 单位px
    @State var url19CallbackPlaceholderWidth: Float64 = 0.0 // 占位图片宽度 - 单位px
    @State var url19CallbackReplaceWidth: ?Float64 = Option<Float64>.None // 替换之后的图片宽度 - 单位px
    @State var url19CallbackReplaceHeight: ?Float64 = Option<Float64>.None // 替换之后的图片高度 - 单位px
    @State var url19CallbackReplaceImagePixelMap: Option<PixelMap> = Option<PixelMap>.None // 替换之后的图片数据
    @State var url19CallbackReplaceImageType: Int64 = 0 // 解析加载 0：开始解析。1：解析成功完成。2：解析失败
    var url19CallbackReplaceFut: ?Future<Unit> = Option<Future<Unit>>.None // 替换子线程
    @State var url19CallbackComponentImageWidth: Float64 = 0.0 // 图片最大宽度 - 单位px
    @State var url19CallbackImageResPixelMap: Option<PixelMap> = Option<PixelMap>.None // 占位图图片数据
    var url19CallbackResFut: ?Future<Unit> = Option<Future<Unit>>.None // 占位图解析子线程
    @State var url19CallbackImageResType: Int64 = 0 // 占位图图片加载 0：开始加载。1：加载成功完成。2：加载失败

    protected override func aboutToAppear(): Unit {
        url19CallbackComponentImageWidth = vp2px(url19CallbackComponentWidth.vp)().value // 图片最大宽度单位转换
        // 图片圆角
        let radius = imageSpanBorderRadius(
            url19CallbackImageRadius,
            url19CallbackMarkdownTheme.imageTheme.imageRadiusTopLeft,
            url19CallbackMarkdownTheme.imageTheme.imageRadiusTopRight,
            url19CallbackMarkdownTheme.imageTheme.imageRadiusBottomLeft,
            url19CallbackMarkdownTheme.imageTheme.imageRadiusBottomRight
        )
        url19CallbackRadiusTopLeft =  radius[0] // 图片左上圆角
        url19CallbackRadiusTopRight =  radius[1] // 图片右上圆角
        url19CallbackRadiusBottomLeft =  radius[2] // 图片左下圆角
        url19CallbackRadiusBottomRight =  radius[3] // 图片右下圆角
        // 图片设置宽度
        url19CallbackThemeWidth = widthHeightLength2FloatPx(
            url19CallbackImageWidth,
            url19CallbackMarkdownTheme.imageTheme.imageWidth,
            url19CallbackComponentImageWidth
        )
        // 图片设置高度
        url19CallbackThemeHeight = widthHeightLength2FloatPx(
            url19CallbackImageHeight,
            url19CallbackMarkdownTheme.imageTheme.imageHeight,
            url19CallbackComponentImageWidth
        )
        // 图片占位图宽度
        url19CallbackPlaceholderWidth = if (url19CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            url19CallbackComponentImageWidth * url19CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            url19CallbackComponentImageWidth * url19CallbackMarkdownTheme.imageTheme.imageMaximumWidth
        }
        // 图片占位图高度
        url19CallbackPlaceholderHeight = if (url19CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            url19CallbackComponentImageWidth * 9.0 / 16.0 * url19CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            url19CallbackComponentImageWidth * 9.0 / 16.0 * url19CallbackMarkdownTheme.imageTheme.imageMaximumWidth
        }
        imageCallbackPixelmap()
        if (url19CallbackMarkdownTheme.imageTheme.imagePlaceholder.isSome()) {
            imageResourcePixelMap()
        }
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        url19CallbackReplaceImagePixelMap?.Release()
        url19CallbackReplaceImagePixelMap = Option<PixelMap>.None
        url19CallbackReplaceFut?.cancel()
        url19CallbackImageResPixelMap?.Release()
        url19CallbackImageResPixelMap = Option<PixelMap>.None
        url19CallbackResFut?.cancel()
    }

    func build() {
        if (url19CallbackMarkdownTheme.imageTheme.imagePlaceholder.isSome() && url19CallbackImageResType == 1) {
            if (url19CallbackReplaceImageType == 1) {
                // 替换之后的图片
                ImageSpan(url19CallbackReplaceImagePixelMap())
                    .margin(
                        top: url19CallbackMarkdownTheme.imageTheme.imageMarginTop,
                        right: url19CallbackMarkdownTheme.imageTheme.imageMarginRight,
                        bottom: url19CallbackMarkdownTheme.imageTheme.imageMarginBottom,
                        left: url19CallbackMarkdownTheme.imageTheme.imageMarginLeft
                    )
                    .interopBorderRadius(
                        url19CallbackRadiusTopLeft,
                        url19CallbackRadiusTopRight,
                        url19CallbackRadiusBottomLeft,
                        url19CallbackRadiusBottomRight
                    )
                    .borderWidth(url19CallbackMarkdownTheme.imageTheme.imageBorderWidth)
                    .borderColor(url19CallbackMarkdownTheme.imageTheme.imageBorderColor)
                    .borderStyle(url19CallbackMarkdownTheme.imageTheme.imageBorderStyle)
                    .width(url19CallbackPlaceholderWidth.px)
                    .height(url19CallbackPlaceholderHeight.px)
                    .objectFit(url19CallbackMarkdownTheme.imageTheme.imageFitType)
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    .constraintSize(maxWidth: 100.percent)
                    .onClick {
                        evt => imageSpanOnClick(url19CallbackLink, url19CallbackImageCallback, url19CallbackLinkCallback, url19CallbackLinkUrl, url19CallbackDestination)
                    }
            } else {
                // 加载图片
                ImageSpan(url19CallbackDestination)
                    .alt(url19CallbackImageResPixelMap())
                    .margin(
                        top: url19CallbackMarkdownTheme.imageTheme.imageMarginTop,
                        right: url19CallbackMarkdownTheme.imageTheme.imageMarginRight,
                        bottom: url19CallbackMarkdownTheme.imageTheme.imageMarginBottom,
                        left: url19CallbackMarkdownTheme.imageTheme.imageMarginLeft
                    )
                    .interopBorderRadius(
                        url19CallbackRadiusTopLeft,
                        url19CallbackRadiusTopRight,
                        url19CallbackRadiusBottomLeft,
                        url19CallbackRadiusBottomRight
                    )
                    .borderWidth(url19CallbackMarkdownTheme.imageTheme.imageBorderWidth)
                    .borderColor(url19CallbackMarkdownTheme.imageTheme.imageBorderColor)
                    .borderStyle(url19CallbackMarkdownTheme.imageTheme.imageBorderStyle)
                    .width(url19CallbackPlaceholderWidth.px)
                    .height(url19CallbackPlaceholderHeight.px)
                    .objectFit(url19CallbackMarkdownTheme.imageTheme.imageFitType)
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    .constraintSize(maxWidth: 100.percent)
                    .onClick {
                        evt => imageSpanOnClick(url19CallbackLink, url19CallbackImageCallback, url19CallbackLinkCallback, url19CallbackLinkUrl, url19CallbackDestination)
                    }
                    .onComplete {
                        imageLoadResult =>
                            let res = imageWidthAndHeight(
                                url19CallbackComponentImageWidth,
                                imageLoadResult.width,
                                imageLoadResult.height,
                                url19CallbackThemeWidth,
                                url19CallbackThemeHeight,
                                url19CallbackMarkdownTheme.imageTheme.imageMaxWidth,
                                url19CallbackMarkdownTheme.imageTheme.imageMaxHeight,
                                url19CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth,
                                url19CallbackMarkdownTheme.imageTheme.imageMaximumWidth
                            )
                            url19CallbackPlaceholderWidth = res[0]
                            url19CallbackPlaceholderHeight = res[1]
                            url19CallbackImageType = 1
                    }
                    .onError {
                        imageError => url19CallbackImageType = 2
                    }
            }
        } else {
            if (url19CallbackReplaceImageType == 1) {
                // 替换之后的图片
                ImageSpan(url19CallbackReplaceImagePixelMap())
                    .margin(
                        top: url19CallbackMarkdownTheme.imageTheme.imageMarginTop,
                        right: url19CallbackMarkdownTheme.imageTheme.imageMarginRight,
                        bottom: url19CallbackMarkdownTheme.imageTheme.imageMarginBottom,
                        left: url19CallbackMarkdownTheme.imageTheme.imageMarginLeft
                    )
                    .interopBorderRadius(
                        url19CallbackRadiusTopLeft,
                        url19CallbackRadiusTopRight,
                        url19CallbackRadiusBottomLeft,
                        url19CallbackRadiusBottomRight
                    )
                    .borderWidth(url19CallbackMarkdownTheme.imageTheme.imageBorderWidth)
                    .borderColor(url19CallbackMarkdownTheme.imageTheme.imageBorderColor)
                    .borderStyle(url19CallbackMarkdownTheme.imageTheme.imageBorderStyle)
                    .width(url19CallbackPlaceholderWidth.px)
                    .height(url19CallbackPlaceholderHeight.px)
                    .objectFit(url19CallbackMarkdownTheme.imageTheme.imageFitType)
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    .constraintSize(maxWidth: 100.percent)
                    .onClick {
                        evt => imageSpanOnClick(url19CallbackLink, url19CallbackImageCallback, url19CallbackLinkCallback, url19CallbackLinkUrl, url19CallbackDestination)
                    }
            } else {
                // 加载图片
                ImageSpan(url19CallbackDestination)
                    .margin(
                        top: url19CallbackMarkdownTheme.imageTheme.imageMarginTop,
                        right: url19CallbackMarkdownTheme.imageTheme.imageMarginRight,
                        bottom: url19CallbackMarkdownTheme.imageTheme.imageMarginBottom,
                        left: url19CallbackMarkdownTheme.imageTheme.imageMarginLeft
                    )
                    .interopBorderRadius(
                        url19CallbackRadiusTopLeft,
                        url19CallbackRadiusTopRight,
                        url19CallbackRadiusBottomLeft,
                        url19CallbackRadiusBottomRight
                    )
                    .borderWidth(url19CallbackMarkdownTheme.imageTheme.imageBorderWidth)
                    .borderColor(url19CallbackMarkdownTheme.imageTheme.imageBorderColor)
                    .borderStyle(url19CallbackMarkdownTheme.imageTheme.imageBorderStyle)
                    .width(url19CallbackPlaceholderWidth.px)
                    .height(url19CallbackPlaceholderHeight.px)
                    .objectFit(url19CallbackMarkdownTheme.imageTheme.imageFitType)
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    .constraintSize(maxWidth: 100.percent)
                    .onClick {
                        evt => imageSpanOnClick(url19CallbackLink, url19CallbackImageCallback, url19CallbackLinkCallback, url19CallbackLinkUrl, url19CallbackDestination)
                    }
                    .onComplete {
                        imageLoadResult =>
                            let res = imageWidthAndHeight(
                                url19CallbackComponentImageWidth,
                                imageLoadResult.width,
                                imageLoadResult.height,
                                url19CallbackThemeWidth,
                                url19CallbackThemeHeight,
                                url19CallbackMarkdownTheme.imageTheme.imageMaxWidth,
                                url19CallbackMarkdownTheme.imageTheme.imageMaxHeight,
                                url19CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth,
                                url19CallbackMarkdownTheme.imageTheme.imageMaximumWidth
                            )
                            if (url19CallbackReplaceImageType != 1) {
                                url19CallbackPlaceholderWidth = res[0]
                                url19CallbackPlaceholderHeight = res[1]
                                url19CallbackImageType = 1
                            }
                    }
                    .onError {
                        imageError => url19CallbackImageType = 2
                    }
            }
        }
    }

    func imageCallbackPixelmap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            imagePixelMap, imageResWidth, imageResHeight => launch {
                if (imagePixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    this.url19CallbackReplaceImagePixelMap = imagePixelMap
                    let res = imageWidthAndHeight(
                        url19CallbackComponentImageWidth,
                        imageResWidth(),
                        imageResHeight(),
                        url19CallbackThemeWidth,
                        url19CallbackThemeHeight,
                        url19CallbackMarkdownTheme.imageTheme.imageMaxWidth,
                        url19CallbackMarkdownTheme.imageTheme.imageMaxHeight,
                        url19CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth,
                        url19CallbackMarkdownTheme.imageTheme.imageMaximumWidth
                    )
                    url19CallbackPlaceholderWidth = res[0]
                    url19CallbackPlaceholderHeight = res[1]
                    url19CallbackReplaceImageType = 1
                } else {
                    url19CallbackReplaceImageType = 2
                }
            }
        }
        url19CallbackReplaceFut = MarkdownParseImageUtil.callbackToPixelmap(
            url19CallbackDestination,
            url19CallbackImageCallbackCallback,
            callback
        )
    }

    /**
     * 占位图图片加载
     */
    func imageResourcePixelMap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            url19CallbackImageResPixelMap, imageResWidth, imageResHeight => launch {
                if (url19CallbackImageResPixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    let res = imageWidthAndHeight(
                        url19CallbackComponentImageWidth,
                        imageResWidth(),
                        imageResHeight(),
                        url19CallbackThemeWidth,
                        url19CallbackThemeHeight,
                        url19CallbackMarkdownTheme.imageTheme.imageMaxWidth,
                        url19CallbackMarkdownTheme.imageTheme.imageMaxHeight,
                        url19CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth,
                        url19CallbackMarkdownTheme.imageTheme.imageMaximumWidth
                    )
                    if (url19CallbackImageType != 1 && url19CallbackReplaceImageType != 1) {
                        this.url19CallbackImageResPixelMap = url19CallbackImageResPixelMap
                        url19CallbackPlaceholderWidth = res[0]
                        url19CallbackPlaceholderHeight = res[1]
                        url19CallbackImageResType = 1
                    }
                } else {
                    url19CallbackImageResType = 2
                }
            }
        }
        url19CallbackResFut = MarkdownParseImageUtil.resourceToPixelmap(
            url19CallbackMarkdownTheme.imageTheme.imagePlaceholder(),
            url19CallbackMarkdownTheme.globalTheme.uiAbilityContext,
            url19CallbackMarkdownTheme.globalTheme.stageContext,
            callback
        )
    }
}
