package markdown.components

import ohos.state_macro_manage.*

/**
 * 行内链接
 */
@Component
public class MarkdownLinkCircleImageComponent {
    var markdownConfiguration: MarkdownConfiguration // markdown配置
    var strUrl: String // 链接
    var strText: String // 链接内容
    @State
    var imageHeight: ?Float64 = Option<Float64>.None // 链接高度
    @State
    var imageWidth: ?Float64 = Option<Float64>.None // 链接宽度
    @State
    var imagePixelMap: ?PixelMap = Option<PixelMap>.None // 链接图片信息
    var arrayUint8: ?Array<UInt8> = Option<Array<UInt8>>.None // 链接数组信息
    var maxWidth: Length = 100.percent // 图片最大宽度
    var linkCircleIconTextSize: Float64 = 0.0 // 圆形图片格式链接文字大小 - 单位px
    var linkCircleIconRadius: Float64 = 0.0 // 圆形图片格式链接半径 - 单位px

    protected override func aboutToAppear(): Unit {
        linkCircleIconTextSize = vp2px(markdownConfiguration.markdownTheme.linkTheme.linkCircleIconTextSize.vp)().value
        linkCircleIconRadius = vp2px(markdownConfiguration.markdownTheme.linkTheme.linkCircleIconRadius.vp)().value
        linkImagePixelmap() // 链接解析
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存
        imagePixelMap?.Release()
        imagePixelMap = Option<PixelMap>.None
        arrayUint8 = Option<Array<UInt8>>.None
    }

    func build() {
        if (imagePixelMap.isSome() && imageHeight.isSome() && imageWidth.isSome()) {
            ImageSpan(imagePixelMap())
                .width(imageWidth().px)
                .height(imageHeight().px)
                .objectFit(ImageFit.Contain)
                .constraintSize(maxWidth: maxWidth)
                .verticalAlign(ImageSpanAlignment.CENTER)
                .margin(right: markdownConfiguration.markdownTheme.linkTheme.linkCircleIconMargin, left: markdownConfiguration.markdownTheme.linkTheme.linkCircleIconMargin)
                .onClick {
                    evt => if (markdownConfiguration.linkCallback.isSome()) {
                        markdownConfiguration.linkCallback()(strUrl)
                    }
                }
        }
    }

    /**
     * 链接数据处理
     */
    func linkImagePixelmap(): Unit {
        let callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit = {
            pixelMap, height, width, arr => launch {
                imageHeight = height
                imageWidth = width
                imagePixelMap = pixelMap
                arrayUint8 = arr
            }
        }
        // 解析链接
        MarkdownParseLinkUtil.linkStrToCirclePixelMap(strText, linkCircleIconTextSize, linkCircleIconRadius, markdownConfiguration, callback)
    }
}
