package markdown.components

import ohos.state_macro_manage.*

/**
 * URL入参API大于等于15的图片
 */
@Component
public class MarkdownSpanImageUrl15Component {
    var url15MarkdownTheme: MarkdownTheme // markdown配置
    var url15Destination: String // 图片链接
    @Prop
    var url15ComponentWidth: Float64 // 控件宽度 - 单位vp
    var url15ImageCallback: (String) -> Unit // 图片点击事件
    var url15LinkCallback: ?(String) -> Unit // 链接点击事件
    var url15Link: Bool // 是否是链接
    var url15LinkUrl: Option<String> // 链接URL
    var url15ImageWidth: Option<Length> // 图片宽度
    var url15ImageHeight: Option<Length> // 图片高度
    var url15ImageRadius: Option<Length> // 图片圆角
    var url15ImageAlign: Option<HorizontalAlign> // 图片对齐方式
    @State
    var url15ImageType: Int64 = 0 // 图片加载 0：开始加载。1：加载成功完成。2：加载失败
    @State
    var url15Height: Float64 = 0.0 // 图片最终高度 - 单位px
    @State
    var url15Width: Float64 = 0.0 // 图片最终宽度 - 单位px
    @State
    var url15RadiusTopLeft: Float64 = 0.0 // 图片左上圆角 - 单位vp
    @State
    var url15RadiusTopRight: Float64 = 0.0 // 图片右上圆角 - 单位vp
    @State
    var url15RadiusBottomLeft: Float64 = 0.0 // 图片左下圆角 - 单位vp
    @State
    var url15RadiusBottomRight: Float64 = 0.0 // 图片右下圆角 - 单位vp
    @State
    var url15ThemeHeight: Option<Float64> = Option<Float64>.None // 图片设置高度 - 单位px
    @State
    var url15ThemeWidth: Option<Float64> = Option<Float64>.None // 图片设置宽度 - 单位px
    @State
    var url15PlaceholderHeight: Float64 = 0.0 // 占位图片高度 - 单位px
    @State
    var url15PlaceholderWidth: Float64 = 0.0 // 占位图片宽度 - 单位px
    @State
    var url15ComponentImageWidth: Float64 = 0.0 // 图片最大宽度 - 单位px

    protected override func aboutToAppear(): Unit {
        url15ComponentImageWidth = vp2px(url15ComponentWidth.vp)().value // 图片最大宽度单位转换
        // 图片圆角
        let radius = imageSpanBorderRadius(url15ImageRadius, url15MarkdownTheme.imageTheme.imageRadiusTopLeft, url15MarkdownTheme.imageTheme.imageRadiusTopRight, url15MarkdownTheme.imageTheme.imageRadiusBottomLeft, url15MarkdownTheme.imageTheme.imageRadiusBottomRight)
        url15RadiusTopLeft =  radius[0] // 图片左上圆角
        url15RadiusTopRight =  radius[1] // 图片右上圆角
        url15RadiusBottomLeft =  radius[2] // 图片左下圆角
        url15RadiusBottomRight =  radius[3] // 图片右下圆角
        url15ThemeWidth = widthHeightLength2FloatPx(url15ImageWidth, url15MarkdownTheme.imageTheme.imageWidth, url15ComponentImageWidth) // 图片设置宽度
        url15ThemeHeight = widthHeightLength2FloatPx(url15ImageHeight, url15MarkdownTheme.imageTheme.imageHeight, url15ComponentImageWidth) // 图片设置高度
        // 图片占位图宽度
        url15PlaceholderWidth = if (url15MarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            url15ComponentImageWidth * url15MarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            url15ComponentImageWidth * url15MarkdownTheme.imageTheme.imageMaximumWidth
        }
        // 图片占位图高度
        url15PlaceholderHeight = if (url15MarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            url15ComponentImageWidth * 9.0 / 16.0 * url15MarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            url15ComponentImageWidth * 9.0 / 16.0 * url15MarkdownTheme.imageTheme.imageMaximumWidth
        }
    }

    func build() {
        if (true) {
            if (url15ImageType != 2) {
                // 加载图片
                ImageSpan(url15Destination)
                    .margin(top: url15MarkdownTheme.imageTheme.imageMarginTop, right: url15MarkdownTheme.imageTheme.imageMarginRight, bottom: url15MarkdownTheme.imageTheme.imageMarginBottom, left: url15MarkdownTheme.imageTheme.imageMarginLeft)
                    .interopBorderRadius(url15RadiusTopLeft, url15RadiusTopRight, url15RadiusBottomLeft, url15RadiusBottomRight)
                    .borderWidth(url15MarkdownTheme.imageTheme.imageBorderWidth)
                    .borderColor(url15MarkdownTheme.imageTheme.imageBorderColor)
                    .borderStyle(url15MarkdownTheme.imageTheme.imageBorderStyle)
                    .width(url15Width.px)
                    .height(url15Height.px)
                    .objectFit(url15MarkdownTheme.imageTheme.imageFitType)
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    .constraintSize(maxWidth: 100.percent)
                    .onClick {
                        evt => imageSpanOnClick(url15Link, url15ImageCallback, url15LinkCallback, url15LinkUrl, url15Destination)
                    }
                    .onComplete {
                        imageLoadResult =>
                            let res = imageWidthAndHeight(
                                url15ComponentImageWidth,
                                imageLoadResult.width,
                                imageLoadResult.height,
                                url15ThemeWidth,
                                url15ThemeHeight,
                                url15MarkdownTheme.imageTheme.imageMaxWidth,
                                url15MarkdownTheme.imageTheme.imageMaxHeight,
                                url15MarkdownTheme.imageTheme.imageFixedRatioWidth,
                                url15MarkdownTheme.imageTheme.imageMaximumWidth
                            )
                            url15Width = res[0]
                            url15Height = res[1]
                            url15ImageType = 1
                    }
                    .onError {
                        imageError => url15ImageType = 2
                    }
            }
            if (url15MarkdownTheme.imageTheme.imagePlaceholder.isSome() && url15ImageType != 1) {
                // 图片占位图
                imageSpanPlaceholderComponent(
                    url15MarkdownTheme.imageTheme.imagePlaceholder(),
                    url15MarkdownTheme.imageTheme.imageMarginTop,
                    url15MarkdownTheme.imageTheme.imageMarginRight,
                    url15MarkdownTheme.imageTheme.imageMarginBottom,
                    url15MarkdownTheme.imageTheme.imageMarginLeft,
                    url15PlaceholderWidth,
                    url15PlaceholderHeight,
                    url15RadiusTopLeft,
                    url15RadiusTopRight,
                    url15RadiusBottomLeft,
                    url15RadiusBottomRight,
                    url15MarkdownTheme.imageTheme.imageBorderWidth,
                    url15MarkdownTheme.imageTheme.imageBorderColor,
                    url15MarkdownTheme.imageTheme.imageBorderStyle
                )
            }
        }
    }
}
