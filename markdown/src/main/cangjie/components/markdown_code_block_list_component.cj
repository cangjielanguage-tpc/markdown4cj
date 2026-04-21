package markdown.components

import ohos.state_macro_manage.*

/**
 * Markdown围栏代码列表切换自定义控件
 */
@Component
class MarkdownCodeBlockListComponent {
    var markdownConfiguration: MarkdownConfiguration // markdown配置
    var nodeView: NodeView // Node
    var strInfos: ArrayList<String> // 代码类型列表标题
    var strText: ArrayList<String> // 代码内容列表
    var strInfoText: ArrayList<String> // 代码真实类型列表
    @State
    var idxSelect: Int64 = 0 // 选中Index
    @State
    var lines: Int64 = 0 // 代码行数
    @State
    var lineArray: ObservedArrayList<Int64> = ObservedArrayList<Int64>() // 代码行数显示数据列表
    @State
    var arrayLists: ArrayList<ArrayList<PrismNodesParseResUI>> = ArrayList<ArrayList<PrismNodesParseResUI>>() // 所有数据

    protected override func aboutToAppear(): Unit {
        stringCodeToResLists()
    }

    func build() {
        Column() {
            codeBlockTitleComponent()
            codeBlockComponent()
        }
        .width(100.percent)
    }

    /**
     * 组合代码标题部分
     */
    @Builder
    func codeBlockTitleComponent() {
        Scroll() {
            Row() {
                ForEach(
                    strInfos,
                    itemGeneratorFunc: {
                        item: String, idx: Int64 =>
                        Text(item)
                            .fontColor(listCodeTextColor(idxSelect, idx, markdownConfiguration))
                            .backgroundColor(listCodeBackgroupColor(idxSelect, idx, markdownConfiguration))
                            .maxLines(1)
                            .fontSize(if (idxSelect == idx) { markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockListTitleSelectTextSize } else { markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockListTitleTextSize })
                            .padding(left: 14, right: 14, top: 5, bottom: 5)
                            .onClick {evt =>
                                idxSelect = idx
                                lines = strText[idxSelect].lines().count()
                                lineArray.set(Array<Int64>(lines, repeat: 0))
                            }
                    }
                )
            }
        }
        .width(100.percent)
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .align(Alignment.Start)
        .margin(bottom: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTitleLayoutMarginBottom)
    }

    /**
     * 组合代码部分
     */
    @Builder
    func codeBlockComponent() {
        Column() {
            codeBlockButtonComponent()
            Row() {
                Column() {
                    ForEach(
                        lineArray,
                        itemGeneratorFunc: {
                            num: Int64, idx: Int64 => Text((idx + 1).toString())
                                .fontFamily(codeLineNumberTextFontFamily(markdownConfiguration.markdownTheme))
                                .fontSize(codeLineNumberTextSize(markdownConfiguration.markdownTheme))
                                .fontWeight(codeLineNumberTextFontWeight(markdownConfiguration.markdownTheme))
                                .fontStyle(codeLineNumberTextFontStyle(markdownConfiguration.markdownTheme))
                                .fontColor(codeLineNumberTextColor(markdownConfiguration.markdownTheme))
                                .lineHeight(codeLineNumberTextLineHeight(markdownConfiguration.markdownTheme))
                                .maxLines(1)
                                .textOverflow(TextOverflow.Ellipsis)
                        }
                    )
                }
                .visibility(isVisibility(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberIsShow))
                .padding(right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberDividerSpacing, left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberTextPaddingLeft)
                .borderWidth(EdgeWidths(right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockDividerStrokeWidth.vp))
                .borderColor(codeDividerColor(markdownConfiguration.markdownTheme))
                .borderStyle(BorderStyle.Solid)
                .alignItems(HorizontalAlign.End)
                codeBlockCodeComponent()
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
     * 组合代码代码部分
     */
    @Builder
    func codeBlockCodeComponent() {
        Scroll() {
            codeBlockTextListComponent()
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .align(Alignment.Start)
        .layoutWeight(1)
        .margin(left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextMarginLeft, right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextMarginRight)
    }

    /**
     * 组合代码代码文本列表内容
     */
    @Builder
    func codeBlockTextListComponent() {
        Column() {
            ForEach(
                arrayLists,
                itemGeneratorFunc: {
                    items: ArrayList<PrismNodesParseResUI>, idx: Int64 =>
                    codeBlockTextComponent(items, idx)
                }
            )
        }
    }

    /**
     * 组合代码代码文本内容
     */
    @Builder
    func codeBlockTextComponent(items: ArrayList<PrismNodesParseResUI>, idx: Int64) {
        Text() {
            ForEach(
                items,
                itemGeneratorFunc: {
                    item: PrismNodesParseResUI, idx1: Int64 =>
                    Span(item.getText())
                        .fontColor(codeTextColor(item, markdownConfiguration.markdownTheme))
                        .letterSpacing(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextLetterSpacing)
                }
            )
        }
        .fontFamily(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontFamily)
        .fontSize(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontSize)
        .fontWeight(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontWeight)
        .fontStyle(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontStyle)
        .lineHeight(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextLineHeight)
        .textAlign(TextAlign.Start)
        .visibility(listCodeTextBool(idx, idxSelect))
    }

    /**
     * 复制按钮和全屏按钮部分
     */
    @Builder
    func codeBlockButtonComponent() {
        Row() {
            if (strText[idxSelect].trimAscii().size > 0) {
                Row()
                    .width(30.percent)
                    .justifyContent(FlexAlign.Start)
                Row() {
                    if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyIcon.isSome()) {
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
                        .onClick {evt => codeCopyOnClick(strText[idxSelect], markdownConfiguration.codeCopyCallback)}
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
                            evt => codeFullScreenOnClick(strText[idxSelect], strInfoText[idxSelect], markdownConfiguration.codeFullScreenCallback)
                        }
                    }
                }
                .width(70.percent)
                .justifyContent(FlexAlign.End)
            }
        }
        .margin(top: 8.0, right: 8.0, bottom: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTitleLayoutMarginBottom)
        .alignItems(VerticalAlign.Center)
    }

    /**
     * 代码数据高亮解析
     */
    func stringCodeToResLists() {
        let callback: (ArrayList<ArrayList<PrismNodesParseResUI>>) -> Unit = {
            prismNodesParseResLists => launch {
                arrayLists = prismNodesParseResLists
            }
        }
        lines = strText[idxSelect].lines().count()
        lineArray.set(Array<Int64>(lines, repeat: 0))
        stringToResLists(nodeView, markdownConfiguration, strText, callback)
    }
}
