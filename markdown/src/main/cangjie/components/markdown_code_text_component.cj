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
    var arrayList: ObservedArrayList<PrismNodesParseResUI> = ObservedArrayList<PrismNodesParseResUI>() // 高亮代码列表
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
        Text() {
            ForEach(
                arrayList,
                itemGeneratorFunc: {
                    item: PrismNodesParseResUI, idx: Int64 => Span(item.getText())
                        .fontColor(codeTextColor(item, markdownTheme))
                        .letterSpacing(markdownTheme.codeBlockTheme.codeBlockTextLetterSpacing)
                },
                keyGeneratorFunc: {
                    item: PrismNodesParseResUI, idx: Int64 => "${idx}-${item.getText()}"
                }
            )
        }
        .fontFamily(markdownTheme.codeBlockTheme.codeBlockTextFontFamily)
        .fontSize(markdownTheme.codeBlockTheme.codeBlockTextFontSize)
        .fontWeight(markdownTheme.codeBlockTheme.codeBlockTextFontWeight)
        .fontStyle(markdownTheme.codeBlockTheme.codeBlockTextFontStyle)
        .lineHeight(markdownTheme.codeBlockTheme.codeBlockTextLineHeight)
        .textAlign(TextAlign.Start)
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
            arrayList.append(PrismNodesParseResUI(types: "", text: " ", alias: Option<String>.None, color: Option<Color>.None))
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
        refreshCodeDatas(prismNodesParseResLists)
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
                        refreshCodeDatas(prismNodesParseResLists)
                    }
                }
                future = MarkdownParseCodeUtil.stringToResList(snapshot, this.info, psh, callback)
        }
    }

    /**
     * 列表新老数据对比
     */
    func refreshCodeDatas(prismNodesParseResLists: ArrayList<PrismNodesParseResUI>): Unit {
        let newSize = prismNodesParseResLists.size
        let oldSize = arrayList.size
        if (newSize == oldSize) {
            // 新数据等于页面数据
            for (i in 0..oldSize) {
                if (arrayList[i].getText() != prismNodesParseResLists[i].getText()) {
                    arrayList[i] = prismNodesParseResLists[i]
                }
            }
        } else if (newSize > oldSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..oldSize) {
                if (arrayList[i].getText() != prismNodesParseResLists[i].getText()) {
                    arrayList[i] = prismNodesParseResLists[i]
                }
            }
            for (i in oldSize..newSize) {
                arrayList.append(prismNodesParseResLists[i])
            }
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
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
    }
}
