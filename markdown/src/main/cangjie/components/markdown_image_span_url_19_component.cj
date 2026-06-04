package markdown.components

import ohos.state_macro_manage.*

/**
 * URL入参API大于等于19的图片
 */
@Component
public class MarkdownSpanImageUrl19Component {
    var url19MarkdownTheme: MarkdownTheme // markdown配置
    var url19Destination: String // 图片链接
    @Prop var url19ComponentWidth: Float64 // 控件宽度 - 单位vp
    var url19ImageCallback: (String) -> Unit // 图片点击事件
    var url19LinkCallback: ?(String) -> Unit // 链接点击事件
    var url19Link: Bool // 是否是链接
    var url19LinkUrl: Option<String> // 链接URL
    var url19ImageWidth: Option<Length> // 图片宽度
    var url19ImageHeight: Option<Length> // 图片高度
    var url19ImageRadius: Option<Length> // 图片圆角
    var url19ImageAlign: Option<HorizontalAlign> // 图片对齐方式
    @State var url19ImageType: Int64 = 0 // 图片加载 0：开始加载。1：加载成功完成。2：加载失败
    @State var url19Height: Float64 = 0.0 // 图片最终高度 - 单位px
    @State var url19Width: Float64 = 0.0 // 图片最终宽度 - 单位px
    @State var url19RadiusTopLeft: Float64 = 0.0 // 图片左上圆角 - 单位vp
    @State var url19RadiusTopRight: Float64 = 0.0 // 图片右上圆角 - 单位vp
    @State var url19RadiusBottomLeft: Float64 = 0.0 // 图片左下圆角 - 单位vp
    @State var url19RadiusBottomRight: Float64 = 0.0 // 图片右下圆角 - 单位vp
    @State var url19ThemeHeight: Option<Float64> = Option<Float64>.None // 图片设置高度 - 单位px
    @State var url19ThemeWidth: Option<Float64> = Option<Float64>.None // 图片设置宽度 - 单位px
    @State var url19PlaceholderHeight: Float64 = 0.0 // 占位图片高度 - 单位px
    @State var url19PlaceholderWidth: Float64 = 0.0 // 占位图片宽度 - 单位px
    @State var url19ComponentImageWidth: Float64 = 0.0 // 图片最大宽度 - 单位px
    @State var url19ImageResPixelMap: Option<PixelMap> = Option<PixelMap>.None // 占位图图片数据
    var url19ResFut: ?Future<Unit> = Option<Future<Unit>>.None // 占位图解析子线程
    @State var url19ImageResType: Int64 = 0 // 占位图图片加载 0：开始加载。1：加载成功完成。2：加载失败

    protected override func aboutToAppear(): Unit {
        url19ComponentImageWidth = vp2px(url19ComponentWidth.vp)().value // 图片最大宽度单位转换
        // 图片圆角
        let radius = imageSpanBorderRadius(
            url19ImageRadius,
            url19MarkdownTheme.imageTheme.imageRadiusTopLeft,
            url19MarkdownTheme.imageTheme.imageRadiusTopRight,
            url19MarkdownTheme.imageTheme.imageRadiusBottomLeft,
            url19MarkdownTheme.imageTheme.imageRadiusBottomRight
        )
        url19RadiusTopLeft = radius[0] // 图片左上圆角
        url19RadiusTopRight = radius[1] // 图片右上圆角
        url19RadiusBottomLeft = radius[2] // 图片左下圆角
        url19RadiusBottomRight = radius[3] // 图片右下圆角
        // 图片设置宽度
        url19ThemeWidth = widthHeightLength2FloatPx(
            url19ImageWidth,
            url19MarkdownTheme.imageTheme.imageWidth,
            url19ComponentImageWidth
        )
        // 图片设置高度
        url19ThemeHeight = widthHeightLength2FloatPx(
            url19ImageHeight,
            url19MarkdownTheme.imageTheme.imageHeight,
            url19ComponentImageWidth
        )
        // 图片占位图宽度
        url19PlaceholderWidth = if (url19MarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            url19ComponentImageWidth * url19MarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            url19ComponentImageWidth * url19MarkdownTheme.imageTheme.imageMaximumWidth
        }
        // 图片占位图高度
        url19PlaceholderHeight = if (url19MarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            url19ComponentImageWidth * 9.0 / 16.0 * url19MarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            url19ComponentImageWidth * 9.0 / 16.0 * url19MarkdownTheme.imageTheme.imageMaximumWidth
        }
        if (url19MarkdownTheme.imageTheme.imagePlaceholder.isSome()) {
            imageResourcePixelMap()
        }
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        url19ImageResPixelMap?.Release()
        url19ImageResPixelMap = Option<PixelMap>.None
        url19ResFut?.cancel()
    }

    func build() {
        if (url19MarkdownTheme.imageTheme.imagePlaceholder.isSome() && url19ImageResType == 1) {
            ImageSpan(url19Destination)
                .alt(url19ImageResPixelMap())
                .margin(
                    top: url19MarkdownTheme.imageTheme.imageMarginTop,
                    right: url19MarkdownTheme.imageTheme.imageMarginRight,
                    bottom: url19MarkdownTheme.imageTheme.imageMarginBottom,
                    left: url19MarkdownTheme.imageTheme.imageMarginLeft
                )
                .interopBorderRadius(
                    url19RadiusTopLeft,
                    url19RadiusTopRight,
                    url19RadiusBottomLeft,
                    url19RadiusBottomRight
                )
                .borderWidth(url19MarkdownTheme.imageTheme.imageBorderWidth)
                .borderColor(url19MarkdownTheme.imageTheme.imageBorderColor)
                .borderStyle(url19MarkdownTheme.imageTheme.imageBorderStyle)
                .width(url19PlaceholderWidth.px)
                .height(url19PlaceholderHeight.px)
                .objectFit(url19MarkdownTheme.imageTheme.imageFitType)
                .verticalAlign(ImageSpanAlignment.CENTER)
                .constraintSize(maxWidth: 100.percent)
                .onClick {
                    evt => imageSpanOnClick(url19Link, url19ImageCallback, url19LinkCallback, url19LinkUrl, url19Destination)
                }
                .onComplete {
                    imageLoadResult =>
                        let res = imageWidthAndHeight(
                            url19ComponentImageWidth,
                            imageLoadResult.width,
                            imageLoadResult.height,
                            url19ThemeWidth,
                            url19ThemeHeight,
                            url19MarkdownTheme.imageTheme.imageMaxWidth,
                            url19MarkdownTheme.imageTheme.imageMaxHeight,
                            url19MarkdownTheme.imageTheme.imageFixedRatioWidth,
                            url19MarkdownTheme.imageTheme.imageMaximumWidth
                        )
                        url19PlaceholderWidth = res[0]
                        url19PlaceholderHeight = res[1]
                        url19ImageType = 1
                }
                .onError {
                    imageError => url19ImageType = 2
                }
        } else {
            ImageSpan(url19Destination)
                .margin(
                    top: url19MarkdownTheme.imageTheme.imageMarginTop,
                    right: url19MarkdownTheme.imageTheme.imageMarginRight,
                    bottom: url19MarkdownTheme.imageTheme.imageMarginBottom,
                    left: url19MarkdownTheme.imageTheme.imageMarginLeft
                )
                .interopBorderRadius(
                    url19RadiusTopLeft,
                    url19RadiusTopRight,
                    url19RadiusBottomLeft,
                    url19RadiusBottomRight
                )
                .borderWidth(url19MarkdownTheme.imageTheme.imageBorderWidth)
                .borderColor(url19MarkdownTheme.imageTheme.imageBorderColor)
                .borderStyle(url19MarkdownTheme.imageTheme.imageBorderStyle)
                .width(url19Width.px)
                .height(url19Height.px)
                .objectFit(url19MarkdownTheme.imageTheme.imageFitType)
                .verticalAlign(ImageSpanAlignment.CENTER)
                .constraintSize(maxWidth: 100.percent)
                .onClick {
                    evt => imageSpanOnClick(url19Link, url19ImageCallback, url19LinkCallback, url19LinkUrl, url19Destination)
                }
                .onComplete {
                    imageLoadResult =>
                        let res = imageWidthAndHeight(
                            url19ComponentImageWidth,
                            imageLoadResult.width,
                            imageLoadResult.height,
                            url19ThemeWidth,
                            url19ThemeHeight,
                            url19MarkdownTheme.imageTheme.imageMaxWidth,
                            url19MarkdownTheme.imageTheme.imageMaxHeight,
                            url19MarkdownTheme.imageTheme.imageFixedRatioWidth,
                            url19MarkdownTheme.imageTheme.imageMaximumWidth
                        )
                        url19Width = res[0]
                        url19Height = res[1]
                        url19ImageType = 1
                }
                .onError {
                    imageError => url19ImageType = 2
                }
        }
    }

    /**
     * 占位图图片加载
     */
    func imageResourcePixelMap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            url19ImageResPixelMap, imageResWidth, imageResHeight => launch {
                if (url19ImageResPixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    let res = imageWidthAndHeight(
                        url19ComponentImageWidth,
                        imageResWidth(),
                        imageResHeight(),
                        url19ThemeWidth,
                        url19ThemeHeight,
                        url19MarkdownTheme.imageTheme.imageMaxWidth,
                        url19MarkdownTheme.imageTheme.imageMaxHeight,
                        url19MarkdownTheme.imageTheme.imageFixedRatioWidth,
                        url19MarkdownTheme.imageTheme.imageMaximumWidth
                    )
                    if (url19ImageType != 1) {
                        this.url19ImageResPixelMap = url19ImageResPixelMap
                        url19PlaceholderWidth = res[0]
                        url19PlaceholderHeight = res[1]
                        url19ImageResType = 1
                    }
                } else {
                    url19ImageResType = 2
                }
            }
        }
        url19ResFut = MarkdownParseImageUtil.resourceToPixelmap(
            url19MarkdownTheme.imageTheme.imagePlaceholder(),
            url19MarkdownTheme.globalTheme.uiAbilityContext,
            url19MarkdownTheme.globalTheme.stageContext,
            callback
        )
    }
}
