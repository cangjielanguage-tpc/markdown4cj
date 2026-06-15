package markdown.components

import ohos.state_macro_manage.*

/**
 * URL入参API小于15的图片
 */
@Component
public class MarkdownSpanImageCallbackUrl14Component {
    var url14CallbackMarkdownTheme: MarkdownTheme // markdown配置
    var url14CallbackDestination: String // 图片链接
    @Prop
    var url14CallbackComponentWidth: Float64 // 控件宽度 - 单位vp
    var url14CallbackImageReplaceCallback: (String) -> ?Array<UInt8> // 图片替换事件
    var url14CallbackImageCallback: (String) -> Unit // 图片点击事件
    var url14CallbackLinkCallback: ?(String) -> Unit // 链接点击事件
    var url14CallbackLink: Bool // 是否是链接
    var url14CallbackLinkUrl: Option<String> // 链接URL
    var url14CallbackImageWidth: Option<Length> // 图片宽度
    var url14CallbackImageHeight: Option<Length> // 图片高度
    var url14CallbackImageRadius: Option<Length> // 图片圆角
    var url14CallbackImageAlign: Option<HorizontalAlign> // 图片对齐方式
    @State
    var url14CallbackImageType: Int64 = 0 // 图片加载 0：开始加载。1：加载成功完成。2：加载失败
    @State
    var url14CallbackHeight: Float64 = 0.0 // 图片最终高度 - 单位px
    @State
    var url14CallbackWidth: Float64 = 0.0 // 图片最终宽度 - 单位px
    @State
    var url14CallbackRadiusTopLeft: Float64 = 0.0 // 图片左上圆角 - 单位vp
    @State
    var url14CallbackRadiusTopRight: Float64 = 0.0 // 图片右上圆角 - 单位vp
    @State
    var url14CallbackRadiusBottomLeft: Float64 = 0.0 // 图片左下圆角 - 单位vp
    @State
    var url14CallbackRadiusBottomRight: Float64 = 0.0 // 图片右下圆角 - 单位vp
    @State
    var url14CallbackThemeHeight: Option<Float64> = Option<Float64>.None // 图片设置高度 - 单位px
    @State
    var url14CallbackThemeWidth: Option<Float64> = Option<Float64>.None // 图片设置宽度 - 单位px
    @State
    var url14CallbackPlaceholderHeight: Float64 = 0.0 // 占位图片高度 - 单位px
    @State
    var url14CallbackPlaceholderWidth: Float64 = 0.0 // 占位图片宽度 - 单位px
    @State
    var url14CallbackReplaceWidth: ?Float64 = Option<Float64>.None // 替换之后的图片宽度 - 单位px
    @State
    var url14CallbackReplaceHeight: ?Float64 = Option<Float64>.None // 替换之后的图片高度 - 单位px
    @State
    var url14CallbackReplaceImagePixelMap: Option<PixelMap> = Option<PixelMap>.None // 替换之后的图片数据
    @State
    var url14CallbackReplaceImageType: Int64 = 0 // 解析加载 0：开始解析。1：解析成功完成。2：解析失败
    var url14CallbackReplaceFut: ?Future<Unit> = Option<Future<Unit>>.None // 替换子线程
    @State
    var url14CallbackComponentImageWidth: Float64 = 0.0 // 图片最大宽度 - 单位px`

    protected override func aboutToAppear(): Unit {
        url14CallbackComponentImageWidth = vp2px(url14CallbackComponentWidth.vp)().value // 图片最大宽度单位转换
        // 图片圆角
        let radius = imageSpanBorderRadius(url14CallbackImageRadius, url14CallbackMarkdownTheme.imageTheme.imageRadiusTopLeft, url14CallbackMarkdownTheme.imageTheme.imageRadiusTopRight, url14CallbackMarkdownTheme.imageTheme.imageRadiusBottomLeft, url14CallbackMarkdownTheme.imageTheme.imageRadiusBottomRight)
        url14CallbackRadiusTopLeft =  radius[0] // 图片左上圆角
        url14CallbackRadiusTopRight =  radius[1] // 图片右上圆角
        url14CallbackRadiusBottomLeft =  radius[2] // 图片左下圆角
        url14CallbackRadiusBottomRight =  radius[3] // 图片右下圆角
        url14CallbackThemeWidth = widthHeightLength2FloatPx(url14CallbackImageWidth, url14CallbackMarkdownTheme.imageTheme.imageWidth, url14CallbackComponentImageWidth) // 图片设置宽度
        url14CallbackThemeHeight = widthHeightLength2FloatPx(url14CallbackImageHeight, url14CallbackMarkdownTheme.imageTheme.imageHeight, url14CallbackComponentImageWidth) // 图片设置高度
        // 图片占位图宽度
        url14CallbackPlaceholderWidth = if (url14CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            url14CallbackComponentImageWidth * url14CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            url14CallbackComponentImageWidth * url14CallbackMarkdownTheme.imageTheme.imageMaximumWidth
        }
        // 图片占位图高度
        url14CallbackPlaceholderHeight = if (url14CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            url14CallbackComponentImageWidth * 9.0 / 16.0 * url14CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            url14CallbackComponentImageWidth * 9.0 / 16.0 * url14CallbackMarkdownTheme.imageTheme.imageMaximumWidth
        }
        imageCallbackPixelmap()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        url14CallbackReplaceImagePixelMap?.Release()
        url14CallbackReplaceImagePixelMap = Option<PixelMap>.None
        url14CallbackReplaceFut?.cancel()
    }

    func build() {
        if (true) {
            if (url14CallbackReplaceImageType == 1) {
                // 替换之后的图片
                ImageSpan(url14CallbackReplaceImagePixelMap())
                    .margin(top: url14CallbackMarkdownTheme.imageTheme.imageMarginTop, right: url14CallbackMarkdownTheme.imageTheme.imageMarginRight, bottom: url14CallbackMarkdownTheme.imageTheme.imageMarginBottom, left: url14CallbackMarkdownTheme.imageTheme.imageMarginLeft)
                    .interopBorderRadius(url14CallbackRadiusTopLeft, url14CallbackRadiusTopRight, url14CallbackRadiusBottomLeft, url14CallbackRadiusBottomRight)
                    .borderWidth(url14CallbackMarkdownTheme.imageTheme.imageBorderWidth)
                    .borderColor(url14CallbackMarkdownTheme.imageTheme.imageBorderColor)
                    .borderStyle(url14CallbackMarkdownTheme.imageTheme.imageBorderStyle)
                    .width(url14CallbackReplaceWidth().px)
                    .height(url14CallbackReplaceHeight().px)
                    .objectFit(url14CallbackMarkdownTheme.imageTheme.imageFitType)
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    .constraintSize(maxWidth: 100.percent)
                    .onClick {
                        evt => imageSpanOnClick(url14CallbackLink, url14CallbackImageCallback, url14CallbackLinkCallback, url14CallbackLinkUrl, url14CallbackDestination)
                    }
            } else {
                if (url14CallbackImageType != 2) {
                    // 加载图片
                    ImageSpan(url14CallbackDestination)
                        .margin(top: url14CallbackMarkdownTheme.imageTheme.imageMarginTop, right: url14CallbackMarkdownTheme.imageTheme.imageMarginRight, bottom: url14CallbackMarkdownTheme.imageTheme.imageMarginBottom, left: url14CallbackMarkdownTheme.imageTheme.imageMarginLeft)
                        .interopBorderRadius(url14CallbackRadiusTopLeft, url14CallbackRadiusTopRight, url14CallbackRadiusBottomLeft, url14CallbackRadiusBottomRight)
                        .borderWidth(url14CallbackMarkdownTheme.imageTheme.imageBorderWidth)
                        .borderColor(url14CallbackMarkdownTheme.imageTheme.imageBorderColor)
                        .borderStyle(url14CallbackMarkdownTheme.imageTheme.imageBorderStyle)
                        .width(url14CallbackWidth.px)
                        .height(url14CallbackHeight.px)
                        .objectFit(url14CallbackMarkdownTheme.imageTheme.imageFitType)
                        .verticalAlign(ImageSpanAlignment.CENTER)
                        .constraintSize(maxWidth: 100.percent)
                        .onClick {
                            evt => imageSpanOnClick(url14CallbackLink, url14CallbackImageCallback, url14CallbackLinkCallback, url14CallbackLinkUrl, url14CallbackDestination)
                        }
                        .interopOnComplete {
                            imageLoadResult =>
                                let res = imageWidthAndHeight(
                                    url14CallbackComponentImageWidth,
                                    imageLoadResult.width,
                                    imageLoadResult.height,
                                    url14CallbackThemeWidth,
                                    url14CallbackThemeHeight,
                                    url14CallbackMarkdownTheme.imageTheme.imageMaxWidth,
                                    url14CallbackMarkdownTheme.imageTheme.imageMaxHeight,
                                    url14CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth,
                                    url14CallbackMarkdownTheme.imageTheme.imageMaximumWidth
                                )
                                url14CallbackWidth = res[0]
                                url14CallbackHeight = res[1]
                                url14CallbackImageType = 1
                        }
                        .interopOnError {
                            imageError => url14CallbackImageType = 2
                        }
                }
                if (url14CallbackMarkdownTheme.imageTheme.imagePlaceholder.isSome() && url14CallbackImageType != 1) {
                    // 图片占位图
                    imageSpanPlaceholderComponent(
                        url14CallbackMarkdownTheme.imageTheme.imagePlaceholder(),
                        url14CallbackMarkdownTheme.imageTheme.imageMarginTop,
                        url14CallbackMarkdownTheme.imageTheme.imageMarginRight,
                        url14CallbackMarkdownTheme.imageTheme.imageMarginBottom,
                        url14CallbackMarkdownTheme.imageTheme.imageMarginLeft,
                        url14CallbackPlaceholderWidth,
                        url14CallbackPlaceholderHeight,
                        url14CallbackRadiusTopLeft,
                        url14CallbackRadiusTopRight,
                        url14CallbackRadiusBottomLeft,
                        url14CallbackRadiusBottomRight,
                        url14CallbackMarkdownTheme.imageTheme.imageBorderWidth,
                        url14CallbackMarkdownTheme.imageTheme.imageBorderColor,
                        url14CallbackMarkdownTheme.imageTheme.imageBorderStyle
                    )
                }
            }
        }
    }

    func imageCallbackPixelmap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            imagePixelMap, imageResWidth, imageResHeight => launch {
                if (imagePixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    this.url14CallbackReplaceImagePixelMap = imagePixelMap
                    let res = imageWidthAndHeight(
                        url14CallbackComponentImageWidth,
                        imageResWidth(),
                        imageResHeight(),
                        url14CallbackThemeWidth,
                        url14CallbackThemeHeight,
                        url14CallbackMarkdownTheme.imageTheme.imageMaxWidth,
                        url14CallbackMarkdownTheme.imageTheme.imageMaxHeight,
                        url14CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth,
                        url14CallbackMarkdownTheme.imageTheme.imageMaximumWidth
                    )
                    url14CallbackReplaceWidth = res[0]
                    url14CallbackReplaceHeight = res[1]
                    url14CallbackReplaceImageType = 1
                } else {
                    url14CallbackReplaceImageType = 2
                }
            }
        }
        url14CallbackReplaceFut = MarkdownParseImageUtil.callbackToPixelmap(
            url14CallbackDestination,
            url14CallbackImageReplaceCallback,
            callback
        )
    }
}
