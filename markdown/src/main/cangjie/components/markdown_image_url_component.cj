package markdown.components

import ohos.state_macro_manage.*

/**
 * URL入参API大于等于15的图片
 */
@Component
public class MarkdownImageUrlComponent {
    var urlMarkdownTheme: MarkdownTheme // markdown配置
    var urlDestination: String // 图片链接
    @Prop
    var urlComponentWidth: Float64 // 控件宽度 - 单位vp
    var urlImageDownloadCallback: ?(String) -> Unit // 图片下载的点击事件
    var urlImageCallback: (String) -> Unit // 图片点击事件
    var urlLinkCallback: ?(String) -> Unit // 链接点击事件
    var urlLink: Bool // 是否是链接
    var urlLinkUrl: Option<String> // 链接URL
    var urlImageWidth: Option<Length> // 图片宽度
    var urlImageHeight: Option<Length> // 图片高度
    var urlImageRadius: Option<Length> // 图片圆角
    var urlImageAlign: Option<HorizontalAlign> // 图片对齐方式
    @State
    var urlImageType: Int64 = 0 // 图片加载 0：开始加载。1：加载成功完成。2：加载失败
    @State
    var urlHeight: Float64 = 0.0 // 图片最终高度 - 单位px
    @State
    var urlWidth: Float64 = 0.0 // 图片最终宽度 - 单位px
    @State
    var urlRadiusTopLeft: Float64 = 0.0 // 图片左上圆角 - 单位vp
    @State
    var urlRadiusTopRight: Float64 = 0.0 // 图片右上圆角 - 单位vp
    @State
    var urlRadiusBottomLeft: Float64 = 0.0 // 图片左下圆角 - 单位vp
    @State
    var urlRadiusBottomRight: Float64 = 0.0 // 图片右下圆角 - 单位vp
    @State
    var urlThemeHeight: Option<Float64> = Option<Float64>.None // 图片设置高度 - 单位px
    @State
    var urlThemeWidth: Option<Float64> = Option<Float64>.None // 图片设置宽度 - 单位px
    @State
    var urlPlaceholderHeight: Float64 = 0.0 // 占位图片高度 - 单位px
    @State
    var urlPlaceholderWidth: Float64 = 0.0 // 占位图片宽度 - 单位px
    @State
    var urlComponentImageWidth: Float64 = 0.0 // 图片最大宽度 - 单位px
    @State
    var urlHorizontalAlign: HorizontalAlign = HorizontalAlign.Start // 图片对齐

    protected override func aboutToAppear(): Unit {
        urlComponentImageWidth = vp2px(urlComponentWidth.vp)().value // 图片最大宽度单位转换
        // 图片圆角
        let radius = imageSpanBorderRadius(urlImageRadius, urlMarkdownTheme.imageTheme.imageRadiusTopLeft, urlMarkdownTheme.imageTheme.imageRadiusTopRight, urlMarkdownTheme.imageTheme.imageRadiusBottomLeft, urlMarkdownTheme.imageTheme.imageRadiusBottomRight)
        urlRadiusTopLeft =  radius[0] // 图片左上圆角
        urlRadiusTopRight =  radius[1] // 图片右上圆角
        urlRadiusBottomLeft =  radius[2] // 图片左下圆角
        urlRadiusBottomRight =  radius[3] // 图片右下圆角
        urlThemeWidth = widthHeightLength2FloatPx(urlImageWidth, urlMarkdownTheme.imageTheme.imageWidth, urlComponentImageWidth) // 图片设置宽度
        urlThemeHeight = widthHeightLength2FloatPx(urlImageHeight, urlMarkdownTheme.imageTheme.imageHeight, urlComponentImageWidth) // 图片设置高度
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
        // 图片对齐
        urlHorizontalAlign = if(urlImageAlign.isSome()){
            urlImageAlign()
        } else {
            HorizontalAlign.Start
        }
    }

    func build() {
        Column(){
            Column(){
                if (urlImageType != 2) {
                    // 加载图片
                    Image(urlDestination)
                        .borderRadius(topLeft: urlRadiusTopLeft, topRight: urlRadiusTopRight, bottomLeft: urlRadiusBottomRight, bottomRight: urlRadiusBottomLeft)
                        .borderWidth(urlMarkdownTheme.imageTheme.imageBorderWidth)
                        .borderColor(urlMarkdownTheme.imageTheme.imageBorderColor)
                        .borderStyle(urlMarkdownTheme.imageTheme.imageBorderStyle)
                        .width(urlWidth.px)
                        .height(urlHeight.px)
                        .objectFit(urlMarkdownTheme.imageTheme.imageFitType)
                        .constraintSize(maxWidth: 100.percent)
                        .onClick {
                            evt => imageSpanOnClick(urlLink, urlImageCallback, urlLinkCallback, urlLinkUrl, urlDestination)
                        }
                        .onComplete {
                            imageLoadResult =>
                                let res = imageWidthAndHeight(
                                    urlComponentImageWidth,
                                    imageLoadResult.width,
                                    imageLoadResult.height,
                                    urlThemeWidth,
                                    urlThemeHeight,
                                    urlMarkdownTheme.imageTheme.imageMaxWidth,
                                    urlMarkdownTheme.imageTheme.imageMaxHeight,
                                    urlMarkdownTheme.imageTheme.imageFixedRatioWidth,
                                    urlMarkdownTheme.imageTheme.imageMaximumWidth
                                )
                                urlWidth = res[0]
                                urlHeight = res[1]
                                urlImageType = 1
                        }
                        .onError {
                            imageError => urlImageType = 2
                        }
                }
                if (urlMarkdownTheme.imageTheme.imagePlaceholder.isSome() && urlImageType != 1) {
                    // 图片占位图
                    imagePlaceholderComponent(
                        urlMarkdownTheme.imageTheme.imagePlaceholder(),
                        urlPlaceholderWidth,
                        urlPlaceholderHeight,
                        urlRadiusTopLeft,
                        urlRadiusTopRight,
                        urlRadiusBottomLeft,
                        urlRadiusBottomRight,
                        urlMarkdownTheme.imageTheme.imageBorderWidth,
                        urlMarkdownTheme.imageTheme.imageBorderColor,
                        urlMarkdownTheme.imageTheme.imageBorderStyle
                    )
                }
            }
            .alignItems(urlHorizontalAlign)
            if(urlMarkdownTheme.imageTheme.imageDownloadButtonVisible){
                MarkdownImageDownloadComponent(
                    markdownTheme: urlMarkdownTheme,
                    destination: urlDestination,
                    imageDownloadCallback: urlImageDownloadCallback
                )
            }
        }
        .margin(top: urlMarkdownTheme.imageTheme.imageMarginTop, right: urlMarkdownTheme.imageTheme.imageMarginRight, bottom: urlMarkdownTheme.imageTheme.imageMarginBottom, left: urlMarkdownTheme.imageTheme.imageMarginLeft)
    }
}
