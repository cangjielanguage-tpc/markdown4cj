package markdown.components

import ohos.state_macro_manage.*

/**
 * 单独代码块自定义控件
 */
@Component
class MarkdownCodeTextComponent {
    var markdownTheme: MarkdownTheme // markdown配置
    @State
    var codeText: String = "" // 代码内容
    @State
    var info: Option<String> = Option<String>.None // 代码类型
    var codeTextComponents: HashMap<Int64, MarkdownCodeTextComponent> // 缓存的单独代码块文本列表控件
    @State
    var index: Int64 = -1 // hash
    @State
    var arrayList: ObservedArrayList<PrismNodesParseResUI> = ObservedArrayList<PrismNodesParseResUI>() // 高亮代码列表
    var psh: ?PrismSyntaxHighlight = Option<PrismSyntaxHighlight>.None // 代码高亮
    var future: ?Future<Unit> = Option<Future<Unit>>.None // 子线程

    protected override func aboutToAppear(): Unit {
        psh = PrismSyntaxHighlight.create(prism, markdownTheme.prismTheme)
        refreshData(codeText, info) // 初始化刷新数据
        codeTextComponents.add(index, this) // 缓存当前控件
    }

    protected override func aboutToDisappear(): Unit {
        // 删除缓存控件
        let value = codeTextComponents.get(index)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                codeTextComponents.remove(index)
            }
        } else {
            codeTextComponents.remove(index)
        }
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
        .maxLines(1)
        .textOverflow(TextOverflow.Ellipsis)
    }

    /**
     * 数据刷新
     *
     * @param codeText 代码文本
     * @param info 代码类型
     */
    public func refreshData(codeText: String, info: Option<String>): Unit {
        if (codeText.size == 0) {
            // 空行数据需要空格文本填充Text控件使其在布局上占位
            arrayList.append(PrismNodesParseResUI(types: "", text: " ", alias: Option<String>.None, color: Option<Color>.None))
            return
        }
        this.codeText = codeText
        this.info = info
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
        refreshCodeDatas(prismNodesParseResLists)
    }

    /**
     * 异步代码高亮解析
     */
    func stringCodeToResList() {
        let callback: (ArrayList<PrismNodesParseResUI>) -> Unit = {
            prismNodesParseResLists => launch {
                refreshCodeDatas(prismNodesParseResLists)
            }
        }
        future = stringToResList(this.codeText, this.info, callback)
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

    /**
     * 异步解析
     */
    func stringToResList(codeText: String, info: ?String, callback: (ArrayList<PrismNodesParseResUI>) -> Unit): Future<Unit> {
        let fut: Future<Unit> = spawn {
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            var prismNodesParseResUIList: ArrayList<PrismNodesParseResUI> = ArrayList<PrismNodesParseResUI>()
            try {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                prismNodesParseResUIList = psh().highlight(info, codeText)
                callback(prismNodesParseResUIList)
            } catch (e: Exception) {
                let prismNodesParseResUI: PrismNodesParseResUI = PrismNodesParseResUI(types: "", text: codeText, alias: Option<String>.None, color: Option<Color>.None)
                prismNodesParseResUIList.add(prismNodesParseResUI)
                callback(prismNodesParseResUIList)
            }
        }
        return fut
    }
}
