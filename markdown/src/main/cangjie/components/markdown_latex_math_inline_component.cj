package markdown.components

import ohos.state_macro_manage.*

/**
 * 行内数学公式控件
 */
@Component
public class MarkdownLatexMathInLineComponent {
    @Prop
    var markdownTheme: MarkdownTheme // markdown样式
    @State
    var latexMathInLineStr: String = "" // 数学公式文本
    var nodeHash: Int64 = 0
    @Prop
    var latexMathInLineComponentWidth: Float64 // 控件宽度 - 单位vp
    var latexImageCallback: ?(Array<UInt8>, Length, Length) -> Unit // 数学公式图片点击事件
    var latexStrCallback: (String) -> String // 数学公式数据处理事件
    var latexMathInLineLinkCallback: ?(String) -> Unit // 链接点击事件
    var latexMathInLineIsLink: Bool = false // 是否是链接
    var latexMathInLineLinkUrl: ?String = Option<String>.None // 链接url
    var latexMathInLineWidthCallback: ?(Float64) -> Unit = Option<(Float64) -> Unit>.None // 数学公式图片解析完成后最终显示宽度回调 - 单位vp（表格列宽跟踪用）
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
        MarkdownRefreshRegistry.register(nodeHash, refreshData)
        latexMathInLineParser()
    }

    protected override func aboutToDisappear(): Unit {
        MarkdownRefreshRegistry.unregister(nodeHash)
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
                notifyLatexWidth()
            }
        }
        latexMathInLineFut = MarkdownParseLatexUtil.latexMathStrToPixelMapRow(latexMathInLineStr, markdownTheme, latexMathTextSize, componentWidth, latexStrCallback, callback)
    }

    /**
     * 数学公式图片解析完成后，回调实际显示宽度（vp），供表格列宽跟踪使用
     * 宽度上限受tableMaxCellWidth约束，与cell的maxWidth约束一致
     */
    func notifyLatexWidth(): Unit {
        if (latexMathInLineWidth.isNone()) {
            return
        }
        if (let Some(cb) <- latexMathInLineWidthCallback) {
            var wVp = px2vp(latexMathInLineWidth().px).getOrThrow().value
            let maxW = markdownTheme.tableTheme.tableMaxCellWidth
            if (wVp > maxW) {
                wVp = maxW
            }
            cb(wVp)
        }
    }

    public func refreshData(newNodeView: NodeView): Unit {
        this.latexMathInLineStr = newNodeView.nodeText
        this.nodeHash = newNodeView.nodeHash
        latexMathInLineFut?.cancel()
        latexMathInLinePixelMap?.Release()
        latexMathInLinePixelMap = Option<PixelMap>.None
        latexMathInLineData = Option<Array<UInt8>>.None
        isLatexMathInLineParserEnd = false
        latexMathInLineParser()
    }
}
