package markdown.components

import ohos.state_macro_manage.*

/**
 * 围栏代码块
 */
@Component
class MarkdownCodeFencedBlockComponent {
    @Prop
    var markdownConfiguration: MarkdownConfiguration // markdown配置
    @State
    var codeText: String = "" // 代码内容
    @State
    var info: String = "" // 代码类型
    @State
    var nodeHash: Int64 = 0 // hash
    @State
    var hasHighlightResult: Bool = false // 是否已有高亮结果（@State标志位驱动代码内容/rawText兜底切换显示）
    @State
    var arrayList: ObservedArrayList<PrismNodesParseResUI> = ObservedArrayList<PrismNodesParseResUI>() // 高亮代码列表
    @State
    var lineArray: ObservedArrayList<Int64> = ObservedArrayList<Int64>() // 代码行数显示数据列表
    var psh: ?PrismSyntaxHighlight = Option<PrismSyntaxHighlight>.None // 代码高亮
    var future: ?Future<Unit> = Option<Future<Unit>>.None // 子线程
    @State
    var formatConfig: FormatConfig = FormatConfig() // codeformat配置

    protected override func aboutToAppear(): Unit {
        psh = PrismSyntaxHighlight.create(prism, markdownConfiguration.markdownTheme.prismTheme)
        formatConfig = FormatConfig(useTab: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockUseTab, indentWidth: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockIndentWidth)
        MarkdownRefreshRegistry.register(this.nodeHash, refreshData)
        refreshDataInternal()
    }

    protected override func aboutToDisappear(): Unit {
        MarkdownRefreshRegistry.unregister(this.nodeHash)
        future?.cancel()
    }

    func build() {
        Column() {
            codeTitleComponent(codeText, info, markdownConfiguration, true)
            Row() {
                Column() {
                    ForEach(
                        lineArray,
                        itemGeneratorFunc: {
                            item: Int64, idx: Int64 => Text(item.toString())
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
                            item: Int64, idx: Int64 => return "${item}"
                        }
                    )
                }
                .visibility(isVisibility(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberIsShow))
                .padding(right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberDividerSpacing, left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberTextPaddingLeft)
                .borderWidth(EdgeWidths(right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockDividerStrokeWidth.vp))
                .borderColor(codeDividerColor(markdownConfiguration.markdownTheme))
                .borderStyle(BorderStyle.Solid)
                .alignItems(HorizontalAlign.End)
                Scroll() {
                    Column() {
                        Text() {
                            ForEach(
                                arrayList,
                                itemGeneratorFunc: {
                                    item: PrismNodesParseResUI, idx: Int64 => Span(item.getText())
                                        .fontColor(codeTextColor(item, markdownConfiguration.markdownTheme))
                                        .letterSpacing(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextLetterSpacing)
                                },
                                keyGeneratorFunc: {
                                    item: PrismNodesParseResUI, idx: Int64 => return "${idx}-${item.getText()}"
                                }
                            )
                        }
                        .fontFamily(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontFamily)
                        .fontSize(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontSize)
                        .fontWeight(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontWeight)
                        .fontStyle(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontStyle)
                        .lineHeight(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextLineHeight)
                        .textAlign(TextAlign.Start)
                        // 高亮结果显隐由@State标志位驱动，保证解析完成后可靠刷新
                        .visibility(isVisibility(hasHighlightResult))

                        // rawText fallback：高亮未完成时显示原始文本，避免初始空白（与ArkUI一致）
                        Text(codeText)
                            .fontFamily(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontFamily)
                            .fontSize(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontSize)
                            .fontWeight(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontWeight)
                            .fontStyle(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontStyle)
                            .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme))
                            .lineHeight(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextLineHeight)
                            .textAlign(TextAlign.Start)
                            .visibility(isVisibility(!hasHighlightResult))
                    }
                    .alignItems(HorizontalAlign.Start) // 与ArkUI一致：代码文本左对齐（Column默认居中会导致内容偏右）
                }
                .scrollable(ScrollDirection.Horizontal)
                .scrollBar(BarState.Off)
                .align(Alignment.Start)
                .layoutWeight(1)
                .margin(left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextMarginLeft, right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextMarginRight)
            }
            .alignItems(VerticalAlign.Top) // 与ArkUI一致：行号列与代码区顶部对齐
        }
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
        .margin(
            top: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginTop,
            right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginRight,
            bottom: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginBottom,
            left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginLeft
        )
    }

    /**
     * 数据刷新
     */
    public func refreshData(newNodeView: NodeView): Unit {
        this.codeText = newNodeView.nodeText
        this.info = newNodeView.codeInfo()
        this.nodeHash = newNodeView.nodeHash
        refreshDataInternal()
    }

    public func refreshDataInternal(): Unit {
        if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockParserSync) {
            stringCodeToResListSync(this.codeText)
        } else {
            stringCodeToResList(this.codeText)
        }
    }

    /**
     * 代码数据高亮解析
     */
    func stringCodeToResListSync(code: String) {
        var codeTextStr = code
        if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockIsCodeFormat) {
            try {
                codeTextStr = codeFormat(info, code, formatConfig)
            } catch (_: Exception) {
                codeTextStr = code
            }
        }
        let arr = codeTextStr.split("\n") // 代码块数据分割
        let lines = arr.size
        refreshLines(lines)
        var prismNodesParseResUIList: ArrayList<PrismNodesParseResUI> = ArrayList<PrismNodesParseResUI>()
        try {
            prismNodesParseResUIList = psh().highlight(info, codeTextStr)
        } catch (e: Exception) {
            let prismNodesParseResUI: PrismNodesParseResUI = PrismNodesParseResUI(types: "", text: codeTextStr, alias: Option<String>.None, color: Option<Color>.None)
            prismNodesParseResUIList.add(prismNodesParseResUI)
        }
        let newSize = prismNodesParseResUIList.size
        let oldSize = arrayList.size
        if (newSize == oldSize) {
            for (i in 0..oldSize) {
                if (arrayList[i].getText() != prismNodesParseResUIList[i].getText()) {
                    arrayList[i] = prismNodesParseResUIList[i]
                }
            }
        } else if (newSize > oldSize) {
            for (i in 0..oldSize) {
                if (arrayList[i].getText() != prismNodesParseResUIList[i].getText()) {
                    arrayList[i] = prismNodesParseResUIList[i]
                }
            }
            for (i in oldSize..newSize) {
                arrayList.append(prismNodesParseResUIList[i])
            }
        } else {
            for (i in 0..newSize) {
                if (arrayList[i].getText() != prismNodesParseResUIList[i].getText()) {
                    arrayList[i] = prismNodesParseResUIList[i]
                }
            }
            // 循环删除多余的旧数据
            for (i in oldSize - 1..=newSize : -1) {
                arrayList.remove(i)
            }
        }
        hasHighlightResult = arrayList.size > 0
    }

    /**
     * 代码数据高亮解析
     */
    func stringCodeToResList(str: String) {
        // 与ArkUI一致：行号随内容同步刷新，不等待异步高亮结果（回调中再按格式化后行数校正）
        refreshLines(str.split("\n").size)
        future?.cancel()
        let callback: (ArrayList<PrismNodesParseResUI>, Int64) -> Unit = {
            prismNodesParseResLists, lines => launch {
                refreshLines(lines)
                let newSize = prismNodesParseResLists.size
                let oldSize = arrayList.size
                if (newSize == oldSize) {
                    for (i in 0..oldSize) {
                        if (arrayList[i].getText() != prismNodesParseResLists[i].getText()) {
                            arrayList[i] = prismNodesParseResLists[i]
                        }
                    }
                } else if (newSize > oldSize) {
                    for (i in 0..oldSize) {
                        if (arrayList[i].getText() != prismNodesParseResLists[i].getText()) {
                            arrayList[i] = prismNodesParseResLists[i]
                        }
                    }
                    for (i in oldSize..newSize) {
                        arrayList.append(prismNodesParseResLists[i])
                    }
                } else {
                    for (i in 0..newSize) {
                        if (arrayList[i].getText() != prismNodesParseResLists[i].getText()) {
                            arrayList[i] = prismNodesParseResLists[i]
                        }
                    }
                    // 循环删除多余的旧数据
                    for (i in oldSize - 1..=newSize : -1) {
                        arrayList.remove(i)
                    }
                }
                hasHighlightResult = arrayList.size > 0
            }
        }
        future = MarkdownParseCodeUtil.stringToResList(str, info, markdownConfiguration, formatConfig, psh, callback)
    }

    /**
     * 行号刷新
     */
    func refreshLines(lines: Int64): Unit {
        let newSize = lines
        let oldSize = lineArray.size
        if (newSize == oldSize) {
        } else if (newSize > oldSize) {
            // 循环添加新数据（与ArkUI一致存储1..N行号）
            for (i in oldSize..newSize) {
                lineArray.append(i + 1)
            }
        } else {
            // 循环删除多余的旧数据
            for (i in oldSize - 1..=newSize : -1) {
                lineArray.remove(i)
            }
        }
    }
}
