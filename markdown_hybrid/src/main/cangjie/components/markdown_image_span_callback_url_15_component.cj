package markdown.components

import ohos.state_macro_manage.*

/**
 * URL入参API大于等于15的图片
 */
@Component
public class MarkdownSpanImageCallbackUrl15Component {
    var url15CallbackMarkdownTheme: MarkdownTheme // markdown配置
    var url15CallbackDestination: String // 图片链接
    @Prop
    var url15CallbackComponentWidth: Float64 // 控件宽度 - 单位vp
    var url15CallbackImageCallbackCallback: (String) -> ?Array<UInt8> // 图片替换事件
    var url15CallbackImageCallback: (String) -> Unit // 图片点击事件
    var url15CallbackLinkCallback: ?(String) -> Unit // 链接点击事件
    var url15CallbackLink: Bool // 是否是链接
    var url15CallbackLinkUrl: Option<String> // 链接URL
    var url15CallbackImageWidth: Option<Length> // 图片宽度
    var url15CallbackImageHeight: Option<Length> // 图片高度
    var url15CallbackImageRadius: Option<Length> // 图片圆角
    var url15CallbackImageAlign: Option<HorizontalAlign> // 图片对齐方式
    @State
    var url15CallbackImageType: Int64 = 0 // 图片加载 0：开始加载。1：加载成功完成。2：加载失败
    @State
    var url15CallbackHeight: Float64 = 0.0 // 图片最终高度 - 单位px
    @State
    var url15CallbackWidth: Float64 = 0.0 // 图片最终宽度 - 单位px
    @State
    var url15CallbackRadiusTopLeft: Float64 = 0.0 // 图片左上圆角 - 单位vp
    @State
    var url15CallbackRadiusTopRight: Float64 = 0.0 // 图片右上圆角 - 单位vp
    @State
    var url15CallbackRadiusBottomLeft: Float64 = 0.0 // 图片左下圆角 - 单位vp
    @State
    var url15CallbackRadiusBottomRight: Float64 = 0.0 // 图片右下圆角 - 单位vp
    @State
    var url15CallbackThemeHeight: Option<Float64> = Option<Float64>.None // 图片设置高度 - 单位px
    @State
    var url15CallbackThemeWidth: Option<Float64> = Option<Float64>.None // 图片设置宽度 - 单位px
    @State
    var url15CallbackPlaceholderHeight: Float64 = 0.0 // 占位图片高度 - 单位px
    @State
    var url15CallbackPlaceholderWidth: Float64 = 0.0 // 占位图片宽度 - 单位px
    @State
    var url15CallbackReplaceWidth: ?Float64 = Option<Float64>.None // 替换之后的图片宽度 - 单位px
    @State
    var url15CallbackReplaceHeight: ?Float64 = Option<Float64>.None // 替换之后的图片高度 - 单位px
    @State
    var url15CallbackReplaceImagePixelMap: Option<PixelMap> = Option<PixelMap>.None // 替换之后的图片数据
    @State
    var url15CallbackReplaceImageType: Int64 = 0 // 解析加载 0：开始解析。1：解析成功完成。2：解析失败
    var url15CallbackReplaceFut: ?Future<Unit> = Option<Future<Unit>>.None // 替换子线程
    @State
    var url15CallbackComponentImageWidth: Float64 = 0.0 // 图片最大宽度 - 单位px

    protected override func aboutToAppear(): Unit {
        url15CallbackComponentImageWidth = vp2px(url15CallbackComponentWidth.vp)().value // 图片最大宽度单位转换
        // 图片圆角
        let radius = imageSpanBorderRadius(url15CallbackImageRadius, url15CallbackMarkdownTheme.imageTheme.imageRadiusTopLeft, url15CallbackMarkdownTheme.imageTheme.imageRadiusTopRight, url15CallbackMarkdownTheme.imageTheme.imageRadiusBottomLeft, url15CallbackMarkdownTheme.imageTheme.imageRadiusBottomRight)
        url15CallbackRadiusTopLeft =  radius[0] // 图片左上圆角
        url15CallbackRadiusTopRight =  radius[1] // 图片右上圆角
        url15CallbackRadiusBottomLeft =  radius[2] // 图片左下圆角
        url15CallbackRadiusBottomRight =  radius[3] // 图片右下圆角
        url15CallbackThemeWidth = widthHeightLength2FloatPx(url15CallbackImageWidth, url15CallbackMarkdownTheme.imageTheme.imageWidth, url15CallbackComponentImageWidth) // 图片设置宽度
        url15CallbackThemeHeight = widthHeightLength2FloatPx(url15CallbackImageHeight, url15CallbackMarkdownTheme.imageTheme.imageHeight, url15CallbackComponentImageWidth) // 图片设置高度
        // 图片占位图宽度
        url15CallbackPlaceholderWidth = if (url15CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            url15CallbackComponentImageWidth * url15CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            url15CallbackComponentImageWidth * url15CallbackMarkdownTheme.imageTheme.imageMaximumWidth
        }
        // 图片占位图高度
        url15CallbackPlaceholderHeight = if (url15CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            url15CallbackComponentImageWidth * 9.0 / 16.0 * url15CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            url15CallbackComponentImageWidth * 9.0 / 16.0 * url15CallbackMarkdownTheme.imageTheme.imageMaximumWidth
        }
        imageCallbackPixelmap()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        url15CallbackReplaceImagePixelMap?.Release()
        url15CallbackReplaceImagePixelMap = Option<PixelMap>.None
        url15CallbackReplaceFut?.cancel()
    }

    func build() {
        if (true) {
            if (url15CallbackReplaceImageType == 1) {
                // 替换之后的图片
                ImageSpan(url15CallbackReplaceImagePixelMap())
                    .margin(top: url15CallbackMarkdownTheme.imageTheme.imageMarginTop, right: url15CallbackMarkdownTheme.imageTheme.imageMarginRight, bottom: url15CallbackMarkdownTheme.imageTheme.imageMarginBottom, left: url15CallbackMarkdownTheme.imageTheme.imageMarginLeft)
                    .interopBorderRadius(url15CallbackRadiusTopLeft, url15CallbackRadiusTopRight, url15CallbackRadiusBottomLeft, url15CallbackRadiusBottomRight)
                    .borderWidth(url15CallbackMarkdownTheme.imageTheme.imageBorderWidth)
                    .borderColor(url15CallbackMarkdownTheme.imageTheme.imageBorderColor)
                    .borderStyle(url15CallbackMarkdownTheme.imageTheme.imageBorderStyle)
                    .width(url15CallbackReplaceWidth().px)
                    .height(url15CallbackReplaceHeight().px)
                    .objectFit(url15CallbackMarkdownTheme.imageTheme.imageFitType)
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    .constraintSize(maxWidth: 100.percent)
                    .onClick {
                        evt => imageSpanOnClick(url15CallbackLink, url15CallbackImageCallback, url15CallbackLinkCallback, url15CallbackLinkUrl, url15CallbackDestination)
                    }
            } else {
                if (url15CallbackImageType != 2) {
                    // 加载图片
                    ImageSpan(url15CallbackDestination)
                        .margin(top: url15CallbackMarkdownTheme.imageTheme.imageMarginTop, right: url15CallbackMarkdownTheme.imageTheme.imageMarginRight, bottom: url15CallbackMarkdownTheme.imageTheme.imageMarginBottom, left: url15CallbackMarkdownTheme.imageTheme.imageMarginLeft)
                        .interopBorderRadius(url15CallbackRadiusTopLeft, url15CallbackRadiusTopRight, url15CallbackRadiusBottomLeft, url15CallbackRadiusBottomRight)
                        .borderWidth(url15CallbackMarkdownTheme.imageTheme.imageBorderWidth)
                        .borderColor(url15CallbackMarkdownTheme.imageTheme.imageBorderColor)
                        .borderStyle(url15CallbackMarkdownTheme.imageTheme.imageBorderStyle)
                        .width(url15CallbackWidth.px)
                        .height(url15CallbackHeight.px)
                        .objectFit(url15CallbackMarkdownTheme.imageTheme.imageFitType)
                        .verticalAlign(ImageSpanAlignment.CENTER)
                        .constraintSize(maxWidth: 100.percent)
                        .onClick {
                            evt => imageSpanOnClick(url15CallbackLink, url15CallbackImageCallback, url15CallbackLinkCallback, url15CallbackLinkUrl, url15CallbackDestination)
                        }
                        .onComplete {
                            imageLoadResult =>
                                let res = imageWidthAndHeight(
                                    url15CallbackComponentImageWidth,
                                    imageLoadResult.width,
                                    imageLoadResult.height,
                                    url15CallbackThemeWidth,
                                    url15CallbackThemeHeight,
                                    url15CallbackMarkdownTheme.imageTheme.imageMaxWidth,
                                    url15CallbackMarkdownTheme.imageTheme.imageMaxHeight,
                                    url15CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth,
                                    url15CallbackMarkdownTheme.imageTheme.imageMaximumWidth
                                )
                                url15CallbackWidth = res[0]
                                url15CallbackHeight = res[1]
                                url15CallbackImageType = 1
                        }
                        .onError {
                            imageError => url15CallbackImageType = 2
                        }
                }
                if (url15CallbackMarkdownTheme.imageTheme.imagePlaceholder.isSome() && url15CallbackImageType != 1) {
                    // 图片占位图
                    imageSpanPlaceholderComponent(
                        url15CallbackMarkdownTheme.imageTheme.imagePlaceholder(),
                        url15CallbackMarkdownTheme.imageTheme.imageMarginTop,
                        url15CallbackMarkdownTheme.imageTheme.imageMarginRight,
                        url15CallbackMarkdownTheme.imageTheme.imageMarginBottom,
                        url15CallbackMarkdownTheme.imageTheme.imageMarginLeft,
                        url15CallbackPlaceholderWidth,
                        url15CallbackPlaceholderHeight,
                        url15CallbackRadiusTopLeft,
                        url15CallbackRadiusTopRight,
                        url15CallbackRadiusBottomLeft,
                        url15CallbackRadiusBottomRight,
                        url15CallbackMarkdownTheme.imageTheme.imageBorderWidth,
                        url15CallbackMarkdownTheme.imageTheme.imageBorderColor,
                        url15CallbackMarkdownTheme.imageTheme.imageBorderStyle
                    )
                }
            }
        }
    }

    func imageCallbackPixelmap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            imagePixelMap, imageResWidth, imageResHeight => launch {
                if (imagePixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    this.url15CallbackReplaceImagePixelMap = imagePixelMap
                    let res = imageWidthAndHeight(
                        url15CallbackComponentImageWidth,
                        imageResWidth(),
                        imageResHeight(),
                        url15CallbackThemeWidth,
                        url15CallbackThemeHeight,
                        url15CallbackMarkdownTheme.imageTheme.imageMaxWidth,
                        url15CallbackMarkdownTheme.imageTheme.imageMaxHeight,
                        url15CallbackMarkdownTheme.imageTheme.imageFixedRatioWidth,
                        url15CallbackMarkdownTheme.imageTheme.imageMaximumWidth
                    )
                    url15CallbackReplaceWidth = res[0]
                    url15CallbackReplaceHeight = res[1]
                    url15CallbackReplaceImageType = 1
                } else {
                    url15CallbackReplaceImageType = 2
                }
            }
        }
        url15CallbackReplaceFut = callbackToPixelmap(
            url15CallbackDestination,
            url15CallbackImageCallbackCallback,
            callback
        )
    }
}
