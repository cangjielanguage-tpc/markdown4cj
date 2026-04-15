package markdown.components

import ohos.state_macro_manage.*

/**
 * URL入参API小于15的图片
 */
@Component
public class MarkdownSpanImageUrl14Component {
    var url14MarkdownTheme: MarkdownTheme // markdown配置
    var url14Destination: String // 图片链接
    @Prop
    var url14ComponentWidth: Float64 // 控件宽度 - 单位vp
    var url14ImageCallback: (String) -> Unit // 图片点击事件
    var url14LinkCallback: ?(String) -> Unit // 链接点击事件
    var url14Link: Bool // 是否是链接
    var url14LinkUrl: Option<String> // 链接URL
    var url14ImageWidth: Option<Length> // 图片宽度
    var url14ImageHeight: Option<Length> // 图片高度
    var url14ImageRadius: Option<Length> // 图片圆角
    var url14ImageAlign: Option<HorizontalAlign> // 图片对齐方式
    @State
    var url14ImageType: Int64 = 0 // 图片加载 0：开始加载。1：加载成功完成。2：加载失败
    @State
    var url14Height: Float64 = 0.0 // 图片最终高度 - 单位px
    @State
    var url14Width: Float64 = 0.0 // 图片最终宽度 - 单位px
    @State
    var url14RadiusTopLeft: Float64 = 0.0 // 图片左上圆角 - 单位vp
    @State
    var url14RadiusTopRight: Float64 = 0.0 // 图片右上圆角 - 单位vp
    @State
    var url14RadiusBottomLeft: Float64 = 0.0 // 图片左下圆角 - 单位vp
    @State
    var url14RadiusBottomRight: Float64 = 0.0 // 图片右下圆角 - 单位vp
    @State
    var url14ThemeHeight: Option<Float64> = Option<Float64>.None // 图片设置高度 - 单位px
    @State
    var url14ThemeWidth: Option<Float64> = Option<Float64>.None // 图片设置宽度 - 单位px
    @State
    var url14PlaceholderHeight: Float64 = 0.0 // 占位图片高度 - 单位px
    @State
    var url14PlaceholderWidth: Float64 = 0.0 // 占位图片宽度 - 单位px
    @State
    var url14ComponentImageWidth: Float64 = 0.0 // 图片最大宽度 - 单位px

    protected override func aboutToAppear(): Unit {
        url14ComponentImageWidth = vp2px(url14ComponentWidth.vp)().value // 图片最大宽度单位转换
        // 图片圆角
        let radius = imageSpanBorderRadius(url14ImageRadius, url14MarkdownTheme.imageTheme.imageRadiusTopLeft, url14MarkdownTheme.imageTheme.imageRadiusTopRight, url14MarkdownTheme.imageTheme.imageRadiusBottomLeft, url14MarkdownTheme.imageTheme.imageRadiusBottomRight)
        url14RadiusTopLeft =  radius[0] // 图片左上圆角
        url14RadiusTopRight =  radius[1] // 图片右上圆角
        url14RadiusBottomLeft =  radius[2] // 图片左下圆角
        url14RadiusBottomRight =  radius[3] // 图片右下圆角
        url14ThemeWidth = widthHeightLength2FloatPx(url14ImageWidth, url14MarkdownTheme.imageTheme.imageWidth, url14ComponentImageWidth) // 图片设置宽度
        url14ThemeHeight = widthHeightLength2FloatPx(url14ImageHeight, url14MarkdownTheme.imageTheme.imageHeight, url14ComponentImageWidth) // 图片设置高度
        // 图片占位图宽度
        url14PlaceholderWidth = if (url14MarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            url14ComponentImageWidth * url14MarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            url14ComponentImageWidth * url14MarkdownTheme.imageTheme.imageMaximumWidth
        }
        // 图片占位图高度
        url14PlaceholderHeight = if (url14MarkdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            url14ComponentImageWidth * 9.0 / 16.0 * url14MarkdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            url14ComponentImageWidth * 9.0 / 16.0 * url14MarkdownTheme.imageTheme.imageMaximumWidth
        }
    }

    func build() {
        if (true) {
            if (url14ImageType != 2) {
                // 加载图片
                ImageSpan(url14Destination)
                    .margin(top: url14MarkdownTheme.imageTheme.imageMarginTop, right: url14MarkdownTheme.imageTheme.imageMarginRight, bottom: url14MarkdownTheme.imageTheme.imageMarginBottom, left: url14MarkdownTheme.imageTheme.imageMarginLeft)
                    .interopBorderRadius(url14RadiusTopLeft, url14RadiusTopRight, url14RadiusBottomLeft, url14RadiusBottomRight)
                    .borderWidth(url14MarkdownTheme.imageTheme.imageBorderWidth)
                    .borderColor(url14MarkdownTheme.imageTheme.imageBorderColor)
                    .borderStyle(url14MarkdownTheme.imageTheme.imageBorderStyle)
                    .width(url14Width.px)
                    .height(url14Height.px)
                    .objectFit(url14MarkdownTheme.imageTheme.imageFitType)
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    .constraintSize(maxWidth: 100.percent)
                    .onClick {
                        evt => imageSpanOnClick(url14Link, url14ImageCallback, url14LinkCallback, url14LinkUrl, url14Destination)
                    }
                    .interopOnComplete {
                        imageLoadResult =>
                            let res = imageWidthAndHeight(
                                url14ComponentImageWidth,
                                imageLoadResult.width,
                                imageLoadResult.height,
                                url14ThemeWidth,
                                url14ThemeHeight,
                                url14MarkdownTheme.imageTheme.imageMaxWidth,
                                url14MarkdownTheme.imageTheme.imageMaxHeight,
                                url14MarkdownTheme.imageTheme.imageFixedRatioWidth,
                                url14MarkdownTheme.imageTheme.imageMaximumWidth
                            )
                            url14Width = res[0]
                            url14Height = res[1]
                            url14ImageType = 1
                    }
                    .interopOnError {
                        imageError => url14ImageType = 2
                    }
            }
            if (url14MarkdownTheme.imageTheme.imagePlaceholder.isSome() && url14ImageType != 1) {
                // 图片占位图
                imageSpanPlaceholderComponent(
                    url14MarkdownTheme.imageTheme.imagePlaceholder(),
                    url14MarkdownTheme.imageTheme.imageMarginTop,
                    url14MarkdownTheme.imageTheme.imageMarginRight,
                    url14MarkdownTheme.imageTheme.imageMarginBottom,
                    url14MarkdownTheme.imageTheme.imageMarginLeft,
                    url14PlaceholderWidth,
                    url14PlaceholderHeight,
                    url14RadiusTopLeft,
                    url14RadiusTopRight,
                    url14RadiusBottomLeft,
                    url14RadiusBottomRight,
                    url14MarkdownTheme.imageTheme.imageBorderWidth,
                    url14MarkdownTheme.imageTheme.imageBorderColor,
                    url14MarkdownTheme.imageTheme.imageBorderStyle
                )
            }
        }
    }
}
