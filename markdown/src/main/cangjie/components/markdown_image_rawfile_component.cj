package markdown.components

import ohos.state_macro_manage.*

/**
 * RawFile入参的图片
 */
@Component
public class MarkdownImageRawFileComponent {
    var rawFileMarkdownTheme: MarkdownTheme // markdown配置
    var rawFileDestination: String // 图片链接
    @Prop
    var rawFileComponentWidth: Float64 // 控件宽度 - 单位vp
    var rawFileImageDownloadCallback: ?(String) -> Unit // 图片下载的点击事件
    var rawFileImageCallback: (String) -> Unit // 图片点击事件
    var rawFileLinkCallback: ?(String) -> Unit // 链接点击事件
    var rawFileLink: Bool // 是否是链接
    var rawFileLinkUrl: Option<String> // 链接URL
    var rawFileImageWidth: Option<Length> // 图片宽度
    var rawFileImageHeight: Option<Length> // 图片高度
    var rawFileImageRadius: Option<Length> // 图片圆角
    var rawFileImageAlign: Option<HorizontalAlign> // 图片对齐方式
    @State
    var rawFileImageType: Int64 = 0 // 图片加载 0：开始加载。1：加载成功完成。2：加载失败
    @State
    var rawFileImagePixelMap: Option<PixelMap> = Option<PixelMap>.None // 图片数据
    @State
    var rawFileHeight: Float64 = 0.0 // 图片最终高度 - 单位px
    @State
    var rawFileWidth: Float64 = 0.0 // 图片最终宽度 - 单位px
    @State
    var rawFileRadiusTopLeft: Float64 = 0.0 // 图片左上圆角 - 单位vp
    @State
    var rawFileRadiusTopRight: Float64 = 0.0 // 图片右上圆角 - 单位vp
    @State
    var rawFileRadiusBottomLeft: Float64 = 0.0 // 图片左下圆角 - 单位vp
    @State
    var rawFileRadiusBottomRight: Float64 = 0.0 // 图片右下圆角 - 单位vp
    @State
    var rawFileThemeHeight: Option<Float64> = Option<Float64>.None // 图片设置高度 - 单位px
    @State
    var rawFileThemeWidth: Option<Float64> = Option<Float64>.None // 图片设置宽度 - 单位px
    @State
    var rawFilePlaceholderHeight: Float64 = 0.0 // 占位图片高度 - 单位px
    @State
    var rawFilePlaceholderWidth: Float64 = 0.0 // 占位图片宽度 - 单位px
    @State
    var rawFileComponentImageWidth: Float64 = 0.0 // 图片最大宽度 - 单位px
    @State
    var rawFileHorizontalAlign: HorizontalAlign = HorizontalAlign.Start // 图片对齐
    var rawFileFut: ?Future<Unit> = Option<Future<Unit>>.None // 解析子线程

    protected override func aboutToAppear(): Unit {
        rawFileComponentImageWidth = vp2px(rawFileComponentWidth.vp)().value // 图片最大宽度单位转换
        // 图片圆角
        let radius = imageSpanBorderRadius(rawFileImageRadius, rawFileMarkdownTheme.imageTheme.imageRadiusTopLeft, rawFileMarkdownTheme.imageTheme.imageRadiusTopRight, rawFileMarkdownTheme.imageTheme.imageRadiusBottomLeft, rawFileMarkdownTheme.imageTheme.imageRadiusBottomRight)
        rawFileRadiusTopLeft =  radius[0] // 图片左上圆角
        rawFileRadiusTopRight =  radius[1] // 图片右上圆角
        rawFileRadiusBottomLeft =  radius[2] // 图片左下圆角
        rawFileRadiusBottomRight =  radius[3] // 图片右下圆角
        rawFileThemeWidth = widthHeightLength2FloatPx(rawFileImageWidth, rawFileMarkdownTheme.imageTheme.imageWidth, rawFileComponentImageWidth) // 图片设置宽度
        rawFileThemeHeight = widthHeightLength2FloatPx(rawFileImageHeight, rawFileMarkdownTheme.imageTheme.imageHeight, rawFileComponentImageWidth) // 图片设置高度
        // 图片占位图宽度
        rawFilePlaceholderWidth = if (rawFileMarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            rawFileComponentImageWidth * rawFileMarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            rawFileComponentImageWidth * rawFileMarkdownTheme.imageTheme.imageMaximumWidth
        }
        // 图片占位图高度
        rawFilePlaceholderHeight = if (rawFileMarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            rawFileComponentImageWidth * 9.0 / 16.0 * rawFileMarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            rawFileComponentImageWidth * 9.0 / 16.0 * rawFileMarkdownTheme.imageTheme.imageMaximumWidth
        }
        // 图片对齐
        rawFileHorizontalAlign = if (rawFileImageAlign.isSome()) {
            rawFileImageAlign()
        } else {
            HorizontalAlign.Start
        }
        imageRawFilePixelMap()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        rawFileImagePixelMap?.Release()
        rawFileImagePixelMap = Option<PixelMap>.None
        rawFileFut?.cancel()
    }

    func build() {
        Column() {
            Column() {
                if (rawFileImageType == 1) {
                    // 加载图片
                    Image(rawFileImagePixelMap())
                        .borderRadius(topLeft: rawFileRadiusTopLeft, topRight: rawFileRadiusTopRight, bottomLeft: rawFileRadiusBottomRight, bottomRight: rawFileRadiusBottomLeft)
                        .borderWidth(rawFileMarkdownTheme.imageTheme.imageBorderWidth)
                        .borderColor(rawFileMarkdownTheme.imageTheme.imageBorderColor)
                        .borderStyle(rawFileMarkdownTheme.imageTheme.imageBorderStyle)
                        .width(rawFileWidth.px)
                        .height(rawFileHeight.px)
                        .objectFit(rawFileMarkdownTheme.imageTheme.imageFitType)
                        .constraintSize(maxWidth: 100.percent)
                        .onClick {
                            evt => imageSpanOnClick(rawFileLink, rawFileImageCallback, rawFileLinkCallback, rawFileLinkUrl, rawFileDestination)
                        }
                }
                if (rawFileMarkdownTheme.imageTheme.imagePlaceholder.isSome() && rawFileImageType != 1) {
                    // 图片占位图
                    imagePlaceholderComponent(
                        rawFileMarkdownTheme.imageTheme.imagePlaceholder(),
                        rawFilePlaceholderWidth,
                        rawFilePlaceholderHeight,
                        rawFileRadiusTopLeft,
                        rawFileRadiusTopRight,
                        rawFileRadiusBottomLeft,
                        rawFileRadiusBottomRight,
                        rawFileMarkdownTheme.imageTheme.imageBorderWidth,
                        rawFileMarkdownTheme.imageTheme.imageBorderColor,
                        rawFileMarkdownTheme.imageTheme.imageBorderStyle
                    )
                }
            }
            .alignItems(rawFileHorizontalAlign)
            if (rawFileMarkdownTheme.imageTheme.imageDownloadButtonVisible) {
                MarkdownImageDownloadComponent(
                    markdownTheme: rawFileMarkdownTheme,
                    destination: rawFileDestination,
                    imageDownloadCallback: rawFileImageDownloadCallback
                )
            }
        }
        .margin(top: rawFileMarkdownTheme.imageTheme.imageMarginTop, right: rawFileMarkdownTheme.imageTheme.imageMarginRight, bottom: rawFileMarkdownTheme.imageTheme.imageMarginBottom, left: rawFileMarkdownTheme.imageTheme.imageMarginLeft)
    }

    /**
     * 本地图片加载
     */
    func imageRawFilePixelMap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            rawFileImagePixelMap, imageResWidth, imageResHeight => launch {
                if (rawFileImagePixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    this.rawFileImagePixelMap = rawFileImagePixelMap
                    let res = imageWidthAndHeight(
                        rawFileComponentImageWidth,
                        imageResWidth(),
                        imageResHeight(),
                        rawFileThemeWidth,
                        rawFileThemeHeight,
                        rawFileMarkdownTheme.imageTheme.imageMaxWidth,
                        rawFileMarkdownTheme.imageTheme.imageMaxHeight,
                        rawFileMarkdownTheme.imageTheme.imageFixedRatioWidth,
                        rawFileMarkdownTheme.imageTheme.imageMaximumWidth
                    )
                    rawFileWidth = res[0]
                    rawFileHeight = res[1]
                    rawFileImageType = 1
                } else {
                    rawFileImageType = 2
                }
            }
        }
        rawFileFut = rawfileToPixelmap1(
            rawFileDestination,
            rawFileMarkdownTheme.globalTheme.uiAbilityContext,
            rawFileMarkdownTheme.globalTheme.stageContext,
            callback
        )
    }
}
