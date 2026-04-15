package markdown.components

import ohos.state_macro_manage.*

/**
 * 行内链接
 */
@Component
public class MarkdownLinkRectToolImageComponent {
    var markdownConfiguration: MarkdownConfiguration // markdown配置
    var strUrl: String // 链接
    var strText: String // 链接内容
    var strType: String // 链接类型
    @State
    var imageHeight: ?Float64 = Option<Float64>.None // 链接高度
    @State
    var imageWidth: ?Float64 = Option<Float64>.None // 链接宽度
    @State
    var imagePixelMap: ?PixelMap = Option<PixelMap>.None // 链接图片信息
    var arrayUint8: ?Array<UInt8> = Option<Array<UInt8>>.None // 链接数组信息
    var maxWidth: Length = 100.percent // 图片最大宽度
    var linkRectToolIconTextSize: Float64 = 0.0 // 空心圆角矩形图片格式链接文字大小 - 单位px
    var linkRectToolIconHeight: Float64 = 0.0 // 空心圆角矩形图片格式链接控件高度 - 单位px
    var linkRectToolIconPadding: Float64 = 0.0 // 空心圆角矩形图片格式链接左右内边距 - 单位px
    var linkRectToolIconBorderWidth: Float64 = 0.0 // 空心圆角矩形图片格式链接边框宽度 - 单位px
    var linkRectToolIconDividingLineWidth: Float64 = 0.0 // 空心圆角矩形图片格式链接分割线宽度 - 单位px
    var linkRectToolIconLineLeftPadding: Float64 = 0.0 // 空心圆角矩形图片格式分割线和文本左边距 - 单位px
    var linkRectToolIconLineRightPadding: Float64 = 0.0 // 空心圆角矩形图片格式分割线和文本右边距 - 单位px

    protected override func aboutToAppear(): Unit {
        linkRectToolIconTextSize = vp2px(markdownConfiguration.markdownTheme.linkTheme.linkRectToolIconTextSize.vp)().value
        linkRectToolIconHeight = vp2px(markdownConfiguration.markdownTheme.linkTheme.linkRectToolIconHeight.vp)().value
        linkRectToolIconPadding = vp2px(markdownConfiguration.markdownTheme.linkTheme.linkRectToolIconPadding.vp)().value
        linkRectToolIconBorderWidth = vp2px(markdownConfiguration.markdownTheme.linkTheme.linkRectToolIconBorderWidth.vp)().value
        linkRectToolIconDividingLineWidth = vp2px(markdownConfiguration.markdownTheme.linkTheme.linkRectToolIconDividingLineWidth.vp)().value
        linkRectToolIconLineLeftPadding = vp2px(markdownConfiguration.markdownTheme.linkTheme.linkRectToolIconLineLeftPadding.vp)().value
        linkRectToolIconLineRightPadding = vp2px(markdownConfiguration.markdownTheme.linkTheme.linkRectToolIconLineRightPadding.vp)().value
        latexMathImagePixelmap() // 链接解析
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
                .visibility(isVisibility(strType != ""))
                .margin(right: markdownConfiguration.markdownTheme.linkTheme.linkRectToolIconMargin, left: markdownConfiguration.markdownTheme.linkTheme.linkRectToolIconMargin)
                .onClick {
                    evt => if (markdownConfiguration.linkCallback.isSome()) {
                        markdownConfiguration.linkCallback()(strUrl)
                    }
                }
        }
    }

    /**
     * 链接数据处理 - 行内链接
     */
    func latexMathImagePixelmap(): Unit {
        let callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit = {
            pixelMap, height, width, arr => launch {
                imageHeight = height
                imageWidth = width
                imagePixelMap = pixelMap
                arrayUint8 = arr
            }
        }
        // 解析链接
        MarkdownParseLinkUtil.linkStrToRectToolPixelMap(strText, strType, linkRectToolIconTextSize, linkRectToolIconHeight, linkRectToolIconPadding, linkRectToolIconBorderWidth, linkRectToolIconDividingLineWidth, linkRectToolIconLineLeftPadding, linkRectToolIconLineRightPadding, markdownConfiguration, callback)
    }
}

func typeStringColor(str: String): (Color, Color) {
    match (str) {
        case "PDF" => return (Color(0xFFB41700), Color(180, 23, 0, alpha: 0.2))
        case "DOC" => return (Color(0xFF3D73CF), Color(61, 115, 207, alpha: 0.2))
        case "DOCX" => return (Color(0xFF3D73CF), Color(61, 115, 207, alpha: 0.2))
        case "TXT" => return (Color(0xFF000000), Color(0, 0, 0, alpha: 0.2))
        case "DEFAULT" => return (Color(0xFF000000), Color(0, 0, 0, alpha: 0.2))
        case _ => return (Color(0xFF000000), Color(0, 0, 0, alpha: 0.2))
    }
}
