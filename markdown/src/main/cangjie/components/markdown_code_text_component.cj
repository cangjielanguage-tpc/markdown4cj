package markdown.components

import ohos.state_macro_manage.*

/**
 * 单独代码块自定义控件
 */
@Component
class MarkdownCodeTextComponent {
    @Prop
    var markdownTheme: MarkdownTheme // markdown配置
    @State
    var codeText: String = "" // 代码内容
    @State
    var info: Option<String> = Option<String>.None // 代码类型
    @State
    var index: Int64 = -1 // hash
    @State
    var rowBlocks: ObservedArrayList<ArrayList<PrismNodesParseResUI>> = ObservedArrayList<ArrayList<PrismNodesParseResUI>>() // 高亮代码按行分块列表（对齐ArkUI prism_hybrid按行返回，每行一个独立Text）
    @State
    var hasHighlightResult: Bool = false // 是否已有高亮结果（@State标志位驱动代码内容/rawText兜底切换显示）
    var psh: ?PrismSyntaxHighlight = Option<PrismSyntaxHighlight>.None // 代码高亮
    var future: ?Future<Unit> = Option<Future<Unit>>.None // 子线程
    var isAlive: Bool = false // 组件是否存活
    var parseVersion: Int64 = 0 // 解析版本号，每次解析递增
    var appliedVersion: Int64 = 0 // 已应用的版本号，用于丢弃过期的异步解析结果
    var parseTimer: ?Timer = Option<Timer>.None // 定时器调度（清旧调度新，避免重复解析）

    protected override func aboutToAppear(): Unit {
        isAlive = true
        psh = PrismSyntaxHighlight.create(prism, markdownTheme.prismTheme)
        refreshData() // 初始化刷新数据
    }

    protected override func aboutToDisappear(): Unit {
        isAlive = false
        parseTimer?.cancel()
        parseTimer = Option<Timer>.None
        future?.cancel()
    }

    func build() {
        Column() {
            // 代码区按行分块渲染（对齐ArkUI MarkdownCodeSeparate：每行一个独立Text，横向Scroll内不折行）
            ForEach(
                rowBlocks,
                itemGeneratorFunc: {
                    items: ArrayList<PrismNodesParseResUI>, idx: Int64 =>
                    Text() {
                        ForEach(
                            items,
                            itemGeneratorFunc: {
                                item: PrismNodesParseResUI, idx1: Int64 => Span(item.getText())
                                    .fontColor(codeTextColor(item, markdownTheme))
                                    .letterSpacing(markdownTheme.codeBlockTheme.codeBlockTextLetterSpacing)
                            },
                            keyGeneratorFunc: {
                                item: PrismNodesParseResUI, idx1: Int64 => return "${idx1}-${item.getText()}"
                            }
                        )
                    }
                    .fontFamily(markdownTheme.codeBlockTheme.codeBlockTextFontFamily)
                    .fontSize(markdownTheme.codeBlockTheme.codeBlockTextFontSize)
                    .fontWeight(markdownTheme.codeBlockTheme.codeBlockTextFontWeight)
                    .fontStyle(markdownTheme.codeBlockTheme.codeBlockTextFontStyle)
                    .lineHeight(markdownTheme.codeBlockTheme.codeBlockTextLineHeight)
                    .textAlign(TextAlign.Start)
                },
                keyGeneratorFunc: {
                    items: ArrayList<PrismNodesParseResUI>, idx: Int64 => return "${idx}-${MarkdownParseCodeUtil.rowText(items)}"
                }
            )
            // rawText fallback：高亮未完成时显示原始文本，避免行高塌陷与行号错位（与ArkUI一致）
            Text(codeText)
                .fontFamily(markdownTheme.codeBlockTheme.codeBlockTextFontFamily)
                .fontSize(markdownTheme.codeBlockTheme.codeBlockTextFontSize)
                .fontWeight(markdownTheme.codeBlockTheme.codeBlockTextFontWeight)
                .fontStyle(markdownTheme.codeBlockTheme.codeBlockTextFontStyle)
                // issue #730：rawText 兜底样式与高亮路径保持一致，补挂 letterSpacing
                .letterSpacing(markdownTheme.codeBlockTheme.codeBlockTextLetterSpacing)
                .fontColor(indentedCodeTextColor(markdownTheme))
                .lineHeight(markdownTheme.codeBlockTheme.codeBlockTextLineHeight)
                .textAlign(TextAlign.Start)
                .visibility(isVisibility(!hasHighlightResult))
        }
        .alignItems(HorizontalAlign.Start)
    }

    /**
     * 数据刷新
     *
     * @param codeText 代码文本
     * @param info 代码类型
     */
    public func refreshData(): Unit {
        if (this.codeText.size == 0) {
            // 空行数据需要空格文本填充Text控件使其在布局上占位
            rowBlocks.append(ArrayList<PrismNodesParseResUI>([PrismNodesParseResUI(types: "", text: " ", alias: Option<String>.None, color: Option<Color>.None)]))
            hasHighlightResult = true
            return
        }
        if (markdownTheme.codeBlockTheme.codeBlockParserSync) {
            stringCodeToResListSync()
        } else {
            stringCodeToResList()
        }
    }

    /**
     * 同步代码高亮解析
     */
    func stringCodeToResListSync() {
        var prismNodesParseResLists: ArrayList<PrismNodesParseResUI> = ArrayList<PrismNodesParseResUI>()
        try {
            prismNodesParseResLists = psh().highlight(info, codeText)
        } catch (e: Exception) {
            let prismNodesParseResUI: PrismNodesParseResUI = PrismNodesParseResUI(types: "", text: codeText, alias: Option<String>.None, color: Option<Color>.None)
            prismNodesParseResLists.add(prismNodesParseResUI)
        }
        if (prismNodesParseResLists.size == 0) {
            prismNodesParseResLists.add(PrismNodesParseResUI(types: "", text: codeText, alias: Option<String>.None, color: Option<Color>.None))
        }
        refreshRowBlocks(prismNodesParseResLists)
    }

    /**
     * 异步代码高亮解析（单定时器调度 + 版本号防过期结果应用）
     * 流式增量期间该行文本高频变化时，清旧调度新仅保留最新一次解析，
     * 解析完成后比对版本号，过期结果丢弃，防止旧结果覆盖新结果。
     */
    func stringCodeToResList() {
        parseVersion++ // 版本号递增
        let currentVersion = parseVersion
        // 快照当前源文本
        let snapshot = codeText
        // 单定时器：清旧调度新
        parseTimer?.cancel()
        parseTimer = Timer.once(0 * Duration.millisecond) {
            =>
                parseTimer = None
                if (!isAlive || currentVersion <= appliedVersion) {
                    return
                }
                future?.cancel()
                let callback: (ArrayList<PrismNodesParseResUI>) -> Unit = {
                    prismNodesParseResLists => launch {
                        if (!isAlive || currentVersion <= appliedVersion) {
                            return
                        }
                        // 源文本比对：文本已变化则丢弃过期解析结果
                        if (this.codeText != snapshot) {
                            return
                        }
                        appliedVersion = currentVersion
                        refreshRowBlocks(prismNodesParseResLists)
                    }
                }
                future = MarkdownParseCodeUtil.stringToResList(snapshot, this.info, psh, callback)
        }
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
}
