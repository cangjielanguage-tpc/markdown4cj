package markdown.components

import ohos.state_macro_manage.*

/**
 * 数学公式块级别控件
 */
@Component
class MarkdownLatexMathBlockComponent {
    var markdownTheme: MarkdownTheme // markdown样式
    var latexMathBlockStr: String // 数学公式文本
    var latexImageCallback: ?(Array<UInt8>, Length, Length) -> Unit // 数学公式图片点击事件
    var latexStrCallback: (String) -> String // 数学公式数据处理事件
    var latexMathBlockData: ?Array<UInt8> = Option<Array<UInt8>>.None // 数学公式列表数据
    @State
    var latexMathBlockPixelMap: ?PixelMap = Option<PixelMap>.None // 数学公式PixelMap
    @State
    var latexMathBlockHeight: ?Float64 = Option<Float64>.None // 数学公式高度 - 单位px
    @State
    var latexMathBlockWidth: ?Float64 = Option<Float64>.None // 数学公式宽度 - 单位px
    @State
    var isLatexMathBlockParserEnd: Bool = false // 解析是否结束
    var latexMathBlockFut: ?Future<Unit> = Option<Future<Unit>>.None // 解析子线程
    var latexMathTextSize: Float64 = 0.0 // 数学公式文本大小 - 单位px

    protected override func aboutToAppear(): Unit {
        latexMathTextSize = fp2px(markdownTheme.latexMathTheme.latexMathTextSize.fp)().value
        latexMathBlockParser()
    }

    protected override func aboutToDisappear(): Unit {
        latexMathBlockPixelMap?.Release()
        latexMathBlockPixelMap = Option<PixelMap>.None
        latexMathBlockData = Option<Array<UInt8>>.None
        latexMathBlockFut?.cancel()
    }

    func build() {
        if (isLatexMathBlockParserEnd) {
            if (latexMathBlockPixelMap.isSome() && latexMathBlockHeight.isSome() && latexMathBlockWidth.isSome() && latexMathBlockData.isSome()) {
                Scroll() {
                    Image(latexMathBlockPixelMap())
                        .height(latexMathBlockHeight().px)
                        .width(latexMathBlockWidth().px)
                        .objectFit(ImageFit.Contain)
                        .onClick {
                            evt => latexImageOnClick(latexMathBlockData(), latexMathBlockHeight().px, latexMathBlockWidth().px, latexImageCallback)
                        }
                }
                .scrollable(ScrollDirection.Horizontal)
                .width(100.percent)
                .scrollBar(BarState.Off)
                .align(isAlignItems(markdownTheme.latexMathTheme.latexMathBlockCenter))
                .padding(
                    top: markdownTheme.latexMathTheme.latexMathPaddingTop,
                    right: markdownTheme.latexMathTheme.latexMathPaddingRight,
                    bottom: markdownTheme.latexMathTheme.latexMathPaddingBottom,
                    left: markdownTheme.latexMathTheme.latexMathPaddingLeft
                )
            } else {
                Text(latexMathBlockStr)
                    .fontFamily(markdownTheme.latexMathTheme.latexMathDefaultTextFontFamily)
                    .fontSize(markdownTheme.latexMathTheme.latexMathDefaultTextFontSize)
                    .fontWeight(markdownTheme.latexMathTheme.latexMathDefaultTextFontWeight)
                    .fontStyle(markdownTheme.latexMathTheme.latexMathDefaultTextFontStyle)
                    .fontColor(markdownTheme.latexMathTheme.latexMathDefaultTextFontColor)
                    .padding(
                        top: markdownTheme.latexMathTheme.latexMathPaddingTop,
                        right: markdownTheme.latexMathTheme.latexMathPaddingRight,
                        bottom: markdownTheme.latexMathTheme.latexMathPaddingBottom,
                        left: markdownTheme.latexMathTheme.latexMathPaddingLeft
                    )
            }
        } else {
            if (markdownTheme.latexMathTheme.latexMathDefaultText) {
                Text(latexMathBlockStr)
                    .fontFamily(markdownTheme.latexMathTheme.latexMathDefaultTextFontFamily)
                    .fontSize(markdownTheme.latexMathTheme.latexMathDefaultTextFontSize)
                    .fontWeight(markdownTheme.latexMathTheme.latexMathDefaultTextFontWeight)
                    .fontStyle(markdownTheme.latexMathTheme.latexMathDefaultTextFontStyle)
                    .fontColor(markdownTheme.latexMathTheme.latexMathDefaultTextFontColor)
                    .padding(
                        top: markdownTheme.latexMathTheme.latexMathPaddingTop,
                        right: markdownTheme.latexMathTheme.latexMathPaddingRight,
                        bottom: markdownTheme.latexMathTheme.latexMathPaddingBottom,
                        left: markdownTheme.latexMathTheme.latexMathPaddingLeft
                    )
            }
        }
    }

    /**
     * 将数学公式文本解析成图片
     */
    func latexMathBlockParser(): Unit {
        let callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit = {
            pixelMap, height, width, arr => launch {
                latexMathBlockPixelMap = pixelMap
                latexMathBlockHeight = height
                latexMathBlockWidth = width
                latexMathBlockData = arr
                isLatexMathBlockParserEnd = true
            }
        }
        latexMathBlockFut = MarkdownParseLatexUtil.latexMathStrToPixelMap(latexMathBlockStr, markdownTheme, latexMathTextSize, latexStrCallback, callback)
    }
}
