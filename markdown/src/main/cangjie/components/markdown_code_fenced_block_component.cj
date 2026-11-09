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
    var rowBlocks: ObservedArrayList<ArrayList<PrismNodesParseResUI>> = ObservedArrayList<ArrayList<PrismNodesParseResUI>>() // 高亮代码按行分块列表（对齐ArkUI prism_hybrid按行返回，每行一个独立Text）
    @State
    var lineArray: Array<Int64> = Array<Int64>() // 代码行数显示数据列表（存1..N，行号列整体渲染为单个多行Text）
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
                    if (lineArray.size > 0) {
                        // 行号列合并为单个多行Text（对齐ArkUI CodeLineComponent：逐行独立Text的逐子组件布局取整与块级多行文本取整存在亚像素差异，导致行号位置偏差）
                        Text(joinLineNumbers(lineArray))
                            .fontFamily(codeLineNumberTextFontFamily(markdownConfiguration.markdownTheme))
                            .fontSize(codeLineNumberTextSize(markdownConfiguration.markdownTheme))
                            .fontWeight(codeLineNumberTextFontWeight(markdownConfiguration.markdownTheme))
                            .fontStyle(codeLineNumberTextFontStyle(markdownConfiguration.markdownTheme))
                            .fontColor(codeLineNumberTextColor(markdownConfiguration.markdownTheme))
                            .lineHeight(codeLineNumberTextLineHeight(markdownConfiguration.markdownTheme))
                            .textAlign(TextAlign.End)
                    }
                }
                .visibility(isVisibility(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberIsShow))
                .padding(right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberDividerSpacing, left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberTextPaddingLeft)
                .borderWidth(EdgeWidths(right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockDividerStrokeWidth.vp))
                .borderColor(codeDividerColor(markdownConfiguration.markdownTheme))
                .borderStyle(BorderStyle.Solid)
                .alignItems(HorizontalAlign.End)
                Scroll() {
                    Column() {
                        // 代码区按行分块渲染（对齐ArkUI ForEach(prismBlocks)：每行一个独立Text，横向Scroll内不折行）
                        ForEach(
                            rowBlocks,
                            itemGeneratorFunc: {
                                items: ArrayList<PrismNodesParseResUI>, idx: Int64 =>
                                Text() {
                                    ForEach(
                                        items,
                                        itemGeneratorFunc: {
                                            item: PrismNodesParseResUI, idx1: Int64 => Span(item.getText())
                                                .fontColor(codeTextColor(item, markdownConfiguration.markdownTheme))
                                                .letterSpacing(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextLetterSpacing)
                                        },
                                        keyGeneratorFunc: {
                                            item: PrismNodesParseResUI, idx1: Int64 => return "${idx1}-${item.getText()}"
                                        }
                                    )
                                }
                                .fontFamily(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontFamily)
                                .fontSize(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontSize)
                                .fontWeight(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontWeight)
                                .fontStyle(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontStyle)
                                .lineHeight(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextLineHeight)
                                .textAlign(TextAlign.Start)
                            },
                            keyGeneratorFunc: {
                                items: ArrayList<PrismNodesParseResUI>, idx: Int64 => return "${idx}-${MarkdownParseCodeUtil.rowText(items)}"
                            }
                        )

                        // rawText fallback：高亮未完成时显示原始文本，避免初始空白（与ArkUI一致）
                        Text(codeText)
                            .fontFamily(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontFamily)
                            .fontSize(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontSize)
                            .fontWeight(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontWeight)
                            .fontStyle(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontStyle)
                            // issue #730：rawText 兜底样式与高亮路径保持一致，补挂 letterSpacing
                            .letterSpacing(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextLetterSpacing)
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
        // 平铺token按\n切行后按行块对比更新（对齐ArkUI每行一个Text结构）
        refreshRowBlocks(prismNodesParseResUIList)
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
                // 平铺token按\n切行后按行块对比更新（对齐ArkUI每行一个Text结构）
                refreshRowBlocks(prismNodesParseResLists)
            }
        }
        future = MarkdownParseCodeUtil.stringToResList(str, info, markdownConfiguration, formatConfig, psh, callback)
    }

    /**
     * 高亮结果按行块更新
     * 平铺token先按\n切行，再对rowBlocks做三段式对比更新：
     * 行数一致时逐行内容对比原地替换，行数变化时增删行块（避免clear导致全量刷新）
     */
    func refreshRowBlocks(tokens: ArrayList<PrismNodesParseResUI>): Unit {
        let newRows = MarkdownParseCodeUtil.splitTokensByLines(tokens)
        let newSize = newRows.size
        let oldSize = rowBlocks.size
        if (newSize > oldSize) {
            for (i in oldSize..newSize) {
                rowBlocks.append(ArrayList<PrismNodesParseResUI>())
            }
        } else if (newSize < oldSize) {
            // 循环删除多余的旧数据
            for (i in oldSize - 1..=newSize : -1) {
                rowBlocks.remove(i)
            }
        }
        for (i in 0..newSize) {
            if (!rowEquals(rowBlocks[i], newRows[i])) {
                rowBlocks[i] = newRows[i]
            }
        }
        hasHighlightResult = rowBlocks.size > 0
    }

    /**
     * 单行块内容对比（只按token文本对比，与既有token级对比口径一致）
     */
    func rowEquals(a: ArrayList<PrismNodesParseResUI>, b: ArrayList<PrismNodesParseResUI>): Bool {
        if (a.size != b.size) {
            return false
        }
        for (i in 0..a.size) {
            if (a[i].getText() != b[i].getText()) {
                return false
            }
        }
        return true
    }

    /**
     * 行号刷新（与ArkUI一致全量重建1..N行号数组）
     */
    func refreshLines(lines: Int64): Unit {
        lineArray = Array<Int64>(lines, {i: Int64 => i + 1})
    }
}
