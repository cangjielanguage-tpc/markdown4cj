package markdown.components

import ohos.state_macro_manage.*

/**
 * 缩进代码块
 */
@Component
class MarkdownCodeIndentedBlockComponent {
    var markdownConfiguration: MarkdownConfiguration // markdown配置
    @State
    var codeText: String = "" // 代码内容
    @State
    var info: Option<String> = Option<String>.None // 代码类型
    @State
    var nodeHash: Int64 = 0 // hash
    var indentedCodeComponents: HashMap<Int64, MarkdownCodeIndentedBlockComponent> // 缓存的缩进代码块控件列表
    @State
    var lines: Int64 = 0 // 代码行数
    @State
    var lineArray: ObservedArrayList<Int64> = ObservedArrayList<Int64>() // 代码行数显示数据列表

    protected override func aboutToAppear(): Unit {
        refreshData(codeText, info, nodeHash) // 初始化刷新数据
        indentedCodeComponents.add(nodeHash, this) // 缓存当前控件
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = indentedCodeComponents.get(nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                indentedCodeComponents.remove(nodeHash)
            }
        } else {
            indentedCodeComponents.remove(nodeHash)
        }
    }

    func build() {
        Column() {
            codeBlockButtonComponent()
            Row() {
                Column() {
                    ForEach(
                        lineArray,
                        itemGeneratorFunc: {
                            item: Int64, idx: Int64 => Text((idx + 1).toString())
                                .fontFamily(codeLineNumberTextFontFamily(markdownConfiguration.markdownTheme))
                                .fontSize(codeLineNumberTextSize(markdownConfiguration.markdownTheme))
                                .fontWeight(codeLineNumberTextFontWeight(markdownConfiguration.markdownTheme))
                                .fontStyle(codeLineNumberTextFontStyle(markdownConfiguration.markdownTheme))
                                .fontColor(codeLineNumberTextColor(markdownConfiguration.markdownTheme))
                                .lineHeight(codeLineNumberTextLineHeight(markdownConfiguration.markdownTheme))
                                .maxLines(1)
                                .textOverflow(TextOverflow.Ellipsis)
                        },
                        keyGeneratorFunc: {
                            item: Int64, idx: Int64 => return "${idx}-${item}"
                        }
                    )
                }
                .visibility(isVisibility(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberIsShow))
                .padding(right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberDividerSpacing, left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberTextPaddingLeft)
                .borderWidth(EdgeWidths(right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockDividerStrokeWidth.vp))
                .borderColor(codeDividerColor(markdownConfiguration.markdownTheme))
                .borderStyle(BorderStyle.Solid)
                .alignItems(HorizontalAlign.End)
                codeBlockComponent()
            }
        }
        .width(100.percent)
        .borderRadius(topLeft: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockRadiusTopLeft, topRight: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockRadiusTopRight, bottomLeft: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockRadiusBottomLeft, bottomRight: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockRadiusBottomRight)
        .borderColor(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockBorderColor)
        .borderWidth(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockBorderWidth)
        .borderStyle(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockBorderStyle)
        .backgroundColor(codeBackgroundColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
        .padding(
            top: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockPaddingTop,
            right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockPaddingRight,
            bottom: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockPaddingBottom,
            left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockPaddingLeft
        )
    }

    /**
     * 代码块部分
     */
    @Builder
    func codeBlockComponent() {
        Scroll() {
            // 代码文本内容
            Text(codeText)
                .fontFamily(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontFamily)
                .fontSize(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontSize)
                .fontWeight(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontWeight)
                .fontStyle(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontStyle)
                .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme))
                .lineHeight(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextLineHeight)
                .textAlign(TextAlign.Start)
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .align(Alignment.Start)
        .layoutWeight(1)
        .margin(left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextMarginLeft, right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextMarginRight)
    }

    /**
     * 复制按钮和全屏按钮部分
     */
    @Builder
    func codeBlockButtonComponent() {
        Row() {
            if (codeText.trimAscii().size > 0) {
                codeBlockTextComponent(if (info.isSome()) { info() } else { markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTypeText }, markdownConfiguration)
                Row() {
                    if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyButtonIsShow) {
                        Row() {
                            if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyIcon.isSome()) {
                                Image(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyIcon())
                                    .width(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyIconWidth)
                                    .height(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyIconHeight)
                                    .objectFit(ImageFit.Contain)
                            }

                            Blank()
                                .width(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyIconTextSpacing)

                            if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyTextIsShow) {
                                Text(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyText)
                                    .fontFamily(codeCopyTextFontFamily(markdownConfiguration.markdownTheme))
                                    .fontSize(codeCopyTextFontSize(markdownConfiguration.markdownTheme))
                                    .fontWeight(codeCopyTextFontWeight(markdownConfiguration.markdownTheme))
                                    .fontStyle(codeCopyTextFontStyle(markdownConfiguration.markdownTheme))
                                    .fontColor(codeCopyTextFontColor(markdownConfiguration.markdownTheme))
                                    .lineHeight(codeCopyTextLineHeight(markdownConfiguration.markdownTheme))
                                    .align(Alignment.End)
                                    .maxLines(1)
                                    .textOverflow(TextOverflow.Ellipsis)
                            }
                        }
                        .justifyContent(FlexAlign.End)
                        .onClick {evt => codeCopyOnClick(codeText, markdownConfiguration.codeCopyCallback)}
                    }

                    Blank()
                        .width(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyFullScreenSpacing)

                    if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenButtonIsShow) {
                        Row() {
                            if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenIcon.isSome()) {
                                Image(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenIcon())
                                    .width(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenIconWidth)
                                    .height(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenIconHeight)
                                    .objectFit(ImageFit.Contain)
                            }

                            Blank()
                                .width(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenIconTextSpacing)

                            if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenTextIsShow) {
                                Text(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenText)
                                    .fontFamily(codeFullScreenTextFontFamily(markdownConfiguration.markdownTheme))
                                    .fontSize(codeFullScreenTextFontSize(markdownConfiguration.markdownTheme))
                                    .fontWeight(codeFullScreenTextFontWeight(markdownConfiguration.markdownTheme))
                                    .fontStyle(codeFullScreenTextFontStyle(markdownConfiguration.markdownTheme))
                                    .fontColor(codeFullScreenTextFontColor(markdownConfiguration.markdownTheme))
                                    .lineHeight(codeFullScreenTextLineHeight(markdownConfiguration.markdownTheme))
                                    .align(Alignment.End)
                                    .maxLines(1)
                                    .textOverflow(TextOverflow.Ellipsis)
                            }
                        }
                        .justifyContent(FlexAlign.End)
                        .onClick {
                            evt => codeFullScreenOnClick(codeText, info, markdownConfiguration.codeFullScreenCallback)
                        }
                    }
                }
                .width(70.percent)
                .justifyContent(FlexAlign.End)
            } else {
                Row()
                    .width(70.percent)
                    .justifyContent(FlexAlign.Start)
            }
        }
        .margin(top: 8.0, right: 8.0, bottom: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTitleLayoutMarginBottom)
        .alignItems(VerticalAlign.Center)
    }

    /**
     * 数据刷新
     */
    public func refreshData(codeText: String, info: Option<String>, nodeHash: Int64): Unit {
        this.info = info
        this.codeText = codeText
        this.nodeHash = nodeHash
        let arr = this.codeText.split("\n") // 代码块数据分割
        lines = arr.size
        lineArray.set(Array<Int64>(lines, repeat: 0))
    }
}

func copyTextFontSize(config: MarkdownConfiguration): Float64{
    if (let Some(v) <- config.markdownTheme.codeBlockTheme.codeBlockCopyTextFontSize) {
        return v
    }
    return config.markdownTheme.codeBlockTheme.codeBlockTextFontSize
}

func fullScreenTextFontSize(config: MarkdownConfiguration): Float64{
    if (let Some(v) <- config.markdownTheme.codeBlockTheme.codeBlockFullScreenTextFontSize) {
        return v
    }
    return config.markdownTheme.codeBlockTheme.codeBlockTextFontSize
}
