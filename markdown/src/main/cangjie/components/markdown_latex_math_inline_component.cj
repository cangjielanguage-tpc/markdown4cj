package markdown.components

import ohos.state_macro_manage.*

/**
 * 行内数学公式控件
 */
@Component
public class MarkdownLatexMathInLineComponent {
    var markdownTheme: MarkdownTheme // markdown样式
    var latexMathInLineStr: String // 数学公式文本
    @Prop
    var latexMathInLineComponentWidth: Float64 // 控件宽度 - 单位vp
    var latexImageCallback: ?(Array<UInt8>, Length, Length) -> Unit // 数学公式图片点击事件
    var latexStrCallback: (String) -> String // 数学公式数据处理事件
    var latexMathInLineLinkCallback: ?(String) -> Unit // 链接点击事件
    var latexMathInLineIsLink: Bool = false // 是否是链接
    var latexMathInLineLinkUrl: ?String = Option<String>.None // 链接url
    var latexMathInLineData: ?Array<UInt8> = Option<Array<UInt8>>.None // 数学公式列表数据
    @State
    var latexMathInLinePixelMap: ?PixelMap = Option<PixelMap>.None // 数学公式PixelMap
    @State
    var latexMathInLineHeight: ?Float64 = Option<Float64>.None // 数学公式高度 - 单位px
    @State
    var latexMathInLineWidth: ?Float64 = Option<Float64>.None // 数学公式宽度 - 单位px
    @State
    var isLatexMathInLineParserEnd: Bool = false // 解析是否结束
    var latexMathInLineFut: ?Future<Unit> = Option<Future<Unit>>.None // 解析子线程
    var latexMathTextSize: Float64 = 0.0 // 数学公式文本大小 - 单位px
    var componentWidth: Float64 = 0.0 // 控件宽度 - 单位px

    protected override func aboutToAppear(): Unit {
        latexMathTextSize = fp2px(markdownTheme.latexMathTheme.latexMathTextSize.fp)().value
        componentWidth = vp2px(latexMathInLineComponentWidth.vp)().value
        latexMathInLineParser()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存
        latexMathInLinePixelMap?.Release()
        latexMathInLinePixelMap = Option<PixelMap>.None
        latexMathInLineData = Option<Array<UInt8>>.None
        latexMathInLineFut?.cancel()
    }

    func build() {
        if (isLatexMathInLineParserEnd) {
            if (latexMathInLinePixelMap.isSome() && latexMathInLineHeight.isSome() && latexMathInLineWidth.isSome() && latexMathInLineData.isSome()) {
                ImageSpan(latexMathInLinePixelMap())
                    .width(latexMathInLineWidth().px)
                    .height(latexMathInLineHeight().px)
                    .objectFit(ImageFit.Contain)
                    .constraintSize(maxWidth: 100.percent)
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    .onClick {
                        evt => if (latexMathInLineIsLink) {
                            if (latexMathInLineLinkCallback.isSome() && latexMathInLineLinkUrl.isSome()) {
                                latexMathInLineLinkCallback()(latexMathInLineLinkUrl())
                            }
                        } else {
                            latexImageOnClick(latexMathInLineData(), latexMathInLineHeight().px, latexMathInLineWidth().px, latexImageCallback)
                        }
                    }
            } else {
                Span(latexMathInLineStr)
                    .fontFamily(markdownTheme.latexMathTheme.latexMathDefaultTextFontFamily)
                    .fontSize(markdownTheme.latexMathTheme.latexMathDefaultTextFontSize)
                    .fontWeight(markdownTheme.latexMathTheme.latexMathDefaultTextFontWeight)
                    .fontStyle(markdownTheme.latexMathTheme.latexMathDefaultTextFontStyle)
                    .fontColor(markdownTheme.latexMathTheme.latexMathDefaultTextFontColor)
            }
        } else {
            if (markdownTheme.latexMathTheme.latexMathDefaultText) {
                Span(latexMathInLineStr)
                    .fontFamily(markdownTheme.latexMathTheme.latexMathDefaultTextFontFamily)
                    .fontSize(markdownTheme.latexMathTheme.latexMathDefaultTextFontSize)
                    .fontWeight(markdownTheme.latexMathTheme.latexMathDefaultTextFontWeight)
                    .fontStyle(markdownTheme.latexMathTheme.latexMathDefaultTextFontStyle)
                    .fontColor(markdownTheme.latexMathTheme.latexMathDefaultTextFontColor)
            }
        }
    }

    /**
     * 将数学公式文本解析成图片
     */
    func latexMathInLineParser(): Unit {
        let callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit = {
            pixelMap, height, width, arr => launch {
                latexMathInLineHeight = height
                latexMathInLineWidth = width
                latexMathInLinePixelMap = pixelMap
                latexMathInLineData = arr
                isLatexMathInLineParserEnd = true
            }
        }
        latexMathInLineFut = MarkdownParseLatexUtil.latexMathStrToPixelMapRow(latexMathInLineStr, markdownTheme, latexMathTextSize, componentWidth, latexStrCallback, callback)
    }
}
