package markdown.components

import ohos.state_macro_manage.*

/**
 * 圆角图片链接
 */
@Component
public class MarkdownLinkRectImageComponent {
    var markdownConfiguration: MarkdownConfiguration // markdown配置
    var strUrl: String // 链接
    var strText: String // 链接内容
    @State
    var imageHeight: ?Float64 = Option<Float64>.None // 链接高度
    @State
    var imageWidth: ?Float64 = Option<Float64>.None // 链接宽度
    @State
    var imagePixelMap: ?PixelMap = Option<PixelMap>.None // 链接图片信息
    var maxWidth: Length = 100.percent // 图片最大宽度
    var linkRectIconTextSize: Float64 = 0.0 // 圆角矩形图片格式链接文字大小 - 单位px
    var linkRectIconHeight: Float64 = 0.0 // 圆角矩形图片格式链接控件高度 - 单位px
    var linkRectIconPadding: Float64 = 0.0 // 圆角矩形图片格式链接左右内边距 - 单位px
    var linkRectIconRadius: Float64 = 0.0 // 圆角矩形图片格式链接圆角半径 - 单位px
    var fut: ?Future<Unit> = Option<Future<Unit>>.None // 解析子线程

    protected override func aboutToAppear(): Unit {
        linkRectIconTextSize = vp2px(markdownConfiguration.markdownTheme.linkTheme.linkRectIconTextSize.vp)().value
        linkRectIconHeight = vp2px(markdownConfiguration.markdownTheme.linkTheme.linkRectIconHeight.vp)().value
        linkRectIconPadding = vp2px(markdownConfiguration.markdownTheme.linkTheme.linkRectIconPadding.vp)().value
        linkRectIconRadius = vp2px(markdownConfiguration.markdownTheme.linkTheme.linkRectIconRadius.vp)().value
        linkImagePixelmap() // 链接解析
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存
        imagePixelMap?.Release()
        imagePixelMap = Option<PixelMap>.None
        fut?.cancel()
    }

    func build() {
        if (imagePixelMap.isSome() && imageHeight.isSome() && imageWidth.isSome()) {
            ImageSpan(imagePixelMap())
                .width(imageWidth().px)
                .height(imageHeight().px)
                .objectFit(ImageFit.Contain)
                .constraintSize(maxWidth: maxWidth)
                .verticalAlign(ImageSpanAlignment.CENTER)
                .margin(right: markdownConfiguration.markdownTheme.linkTheme.linkRectIconMargin, left: markdownConfiguration.markdownTheme.linkTheme.linkRectIconMargin)
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
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            pixelMap, height, width => launch {
                imageHeight = height
                imageWidth = width
                imagePixelMap = pixelMap
            }
        }
        // 解析链接
        fut = MarkdownParseLinkUtil.linkStrToRectPixelMap(strText, linkRectIconTextSize, linkRectIconHeight, linkRectIconPadding, linkRectIconRadius, markdownConfiguration, callback)
    }
}
