package markdown.components

import ohos.state_macro_manage.*

/**
 * RawFile入参的图片
 */
@Component
public class MarkdownSpanImageCallbackRawFileComponent {
    var rawFileCallbackMarkdownTheme: MarkdownTheme // markdown配置
    var rawFileCallbackDestination: String // 图片链接
    @Prop
    var rawFileCallbackComponentWidth: Float64 // 控件宽度 - 单位vp
    var rawFileCallbackImageReplaceCallback: (String) -> ?Array<UInt8> // 图片替换事件
    var rawFileCallbackImageCallback: (String) -> Unit // 图片点击事件
    var rawFileCallbackLinkCallback: ?(String) -> Unit // 链接点击事件
    var rawFileCallbackLink: Bool // 是否是链接
    var rawFileCallbackLinkUrl: Option<String> // 链接URL
    var rawFileCallbackImageWidth: Option<Length> // 图片宽度
    var rawFileCallbackImageHeight: Option<Length> // 图片高度
    var rawFileCallbackImageRadius: Option<Length> // 图片圆角
    var rawFileCallbackImageAlign: Option<HorizontalAlign> // 图片对齐方式
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
                    .interopBorderRadius(rawFileCallbackRadiusTopLeft, rawFileCallbackRadiusTopRight, rawFileCallbackRadiusBottomLeft, rawFileCallbackRadiusBottomRight)
                    .borderWidth(rawFileCallbackMarkdownTheme.imageTheme.imageBorderWidth)
                    .borderColor(rawFileCallbackMarkdownTheme.imageTheme.imageBorderColor)
                    .borderStyle(rawFileCallbackMarkdownTheme.imageTheme.imageBorderStyle)
                    .width(rawFileCallbackReplaceWidth().px)
                    .height(rawFileCallbackReplaceHeight().px)
                    .objectFit(rawFileCallbackMarkdownTheme.imageTheme.imageFitType)
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    .constraintSize(maxWidth: 100.percent)
                    .onClick {
                        evt => imageSpanOnClick(rawFileCallbackLink, rawFileCallbackImageCallback, rawFileCallbackLinkCallback, rawFileCallbackLinkUrl, rawFileCallbackDestination)
                    }
            } else {
                if (rawFileCallbackImageType == 1) {
                    // 加载图片
                    ImageSpan(rawFileCallbackImagePixelMap())
                        .margin(top: rawFileCallbackMarkdownTheme.imageTheme.imageMarginTop, right: rawFileCallbackMarkdownTheme.imageTheme.imageMarginRight, bottom: rawFileCallbackMarkdownTheme.imageTheme.imageMarginBottom, left: rawFileCallbackMarkdownTheme.imageTheme.imageMarginLeft)
                        .interopBorderRadius(rawFileCallbackRadiusTopLeft, rawFileCallbackRadiusTopRight, rawFileCallbackRadiusBottomLeft, rawFileCallbackRadiusBottomRight)
                        .borderWidth(rawFileCallbackMarkdownTheme.imageTheme.imageBorderWidth)
                        .borderColor(rawFileCallbackMarkdownTheme.imageTheme.imageBorderColor)
                        .borderStyle(rawFileCallbackMarkdownTheme.imageTheme.imageBorderStyle)
                        .width(rawFileCallbackWidth.px)
                        .height(rawFileCallbackHeight.px)
                        .objectFit(rawFileCallbackMarkdownTheme.imageTheme.imageFitType)
                        .verticalAlign(ImageSpanAlignment.CENTER)
                        .constraintSize(maxWidth: 100.percent)
                        .onClick {
                            evt => imageSpanOnClick(rawFileCallbackLink, rawFileCallbackImageCallback, rawFileCallbackLinkCallback, rawFileCallbackLinkUrl, rawFileCallbackDestination)
                        }
                }
                if (rawFileCallbackMarkdownTheme.imageTheme.imagePlaceholder.isSome() && rawFileCallbackImageType != 1) {
                    // 图片占位图
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
                    let res = imageWidthAndHeight(
                        rawFileCallbackComponentImageWidth,
                        imageResWidth(),
                        imageResHeight(),
                        rawFileCallbackThemeWidth,
                        rawFileCallbackThemeHeight,
                        rawFileCallbackMarkdownTheme.imageTheme.imageMaxWidth,
                        rawFileCallbackMarkdownTheme.imageTheme.imageMaxHeight,
                        rawFileCallbackMarkdownTheme.imageTheme.imageFixedRatioWidth,
                        rawFileCallbackMarkdownTheme.imageTheme.imageMaximumWidth
                    )
                    rawFileCallbackReplaceWidth = res[0]
                    rawFileCallbackReplaceHeight = res[1]
                    rawFileCallbackReplaceImageType = 1
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
                    let res = imageWidthAndHeight(
                        rawFileCallbackComponentImageWidth,
                        imageResWidth(),
                        imageResHeight(),
                        rawFileCallbackThemeWidth,
                        rawFileCallbackThemeHeight,
                        rawFileCallbackMarkdownTheme.imageTheme.imageMaxWidth,
                        rawFileCallbackMarkdownTheme.imageTheme.imageMaxHeight,
                        rawFileCallbackMarkdownTheme.imageTheme.imageFixedRatioWidth,
                        rawFileCallbackMarkdownTheme.imageTheme.imageMaximumWidth
                    )
                    rawFileCallbackWidth = res[0]
                    rawFileCallbackHeight = res[1]
                    rawFileCallbackImageType = 1
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
}
