/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 单独代码块自定义控件
 */
@Component
class MarkdownCodeTextComponent {
    /**
     * markdown配置
     */
    var markdownTheme: MarkdownTheme

    /**
     * 代码内容
     */
    @State
    var codeText: String = ""

    /**
     * 代码类型
     */
    @State
    var info: Option<String> = Option<String>.None

    /**
     * 缓存的单独代码块文本列表控件
     */
    var codeTextComponents: HashMap<Int64, MarkdownCodeTextComponent>

    /**
     * hash
     */
    @State
    var index: Int64 = -1

    /**
     * 高亮代码列表
     */
    @State
    var arrayList: ObservedArrayList<PrismNodesParseResUI> = ObservedArrayList<PrismNodesParseResUI>()

    /**
     * 代码高亮
     */
    var psh: ?PrismSyntaxHighlight = Option<PrismSyntaxHighlight>.None

    /**
     * 子线程
     */
    var future: ?Future<Unit> = Option<Future<Unit>>.None

    /**
     * 最后一条数据的位置
     */
    @State
    var lastViewIndex: Int64 = 0

    /**
     * 上一层级传递过来的，是否是最后一条数据
     */
    @State
    var isEndByParent: Bool = false

    protected override func aboutToAppear(): Unit {
        psh = PrismSyntaxHighlight.create(prism, markdownTheme.prismTheme)
        refreshData(codeText, info, isEndByParent) // 初始化刷新数据
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
                    item: PrismNodesParseResUI, idx: Int64 =>
                        if (item.isCloseTypewriter()) {
                            Span(item.getText())
                                .fontColor(codeTextColor(item, markdownTheme, markdownTheme.prismTheme))
                                .letterSpacing(markdownTheme.paragraphTextWordSpace)
                         } else {
                            Span(spanEndText(item.getText())[0])
                                .fontColor(codeTextColor(item, markdownTheme, markdownTheme.prismTheme))
                                .letterSpacing(markdownTheme.paragraphTextWordSpace)
                            // 最后一个字符
                            Span(spanEndText(item.getText())[1])
                                .letterSpacing(markdownTheme.paragraphTextWordSpace)
                                .fontColor(markdownTheme.typeWriterColor)
                         }
                },
                keyGeneratorFunc: {
                    item: PrismNodesParseResUI, idx: Int64 => "${idx}-${item.getText()}"
                }
            )
        }
        .fontSize(markdownTheme.codeBlockTextSize)
        .fontFamily(markdownTheme.codeBlockTypeface)
        .textAlign(TextAlign.Start)
        .maxLines(1)
        .textOverflow(TextOverflow.Ellipsis)
        .padding(left: markdownTheme.codeMultilineMargin, right: markdownTheme.codeMultilineMargin + markdownTheme.separateCodeBlockWidth)
        .lineHeight(markdownTheme.codeBlockLineHeight)
    }

    /**
     * 数据刷新
     *
     * @param codeText 代码文本
     * @param info 代码类型
     */
    public func refreshData(codeText: String, info: Option<String>, isEnd: Bool): Unit {
        if (codeText.size == 0) {
            // 空行数据需要空格文本填充Text控件使其在布局上占位
            arrayList.append(PrismNodesParseResUI(types: "", text: " ", alias: Option<String>.None, color: Option<Color>.None))
            return
        }
        this.codeText = codeText
        this.info = info
        if (markdownTheme.isCodeBlockParserSync) {
            stringCodeToResListSync(isEnd)
        } else {
            stringCodeToResList(isEnd)
        }
    }

    /**
     * 同步代码高亮解析
     */
    func stringCodeToResListSync(isEnd: Bool) {
        var prismNodesParseResLists: ArrayList<PrismNodesParseResUI> = ArrayList<PrismNodesParseResUI>()
        try {
            prismNodesParseResLists = psh().highlight(info, codeText)
        } catch (e: Exception) {
            let prismNodesParseResUI: PrismNodesParseResUI = PrismNodesParseResUI(types: "", text: codeText, alias: Option<String>.None, color: Option<Color>.None)
            prismNodesParseResLists.add(prismNodesParseResUI)
        }
        refreshCodeDatas(prismNodesParseResLists, isEnd)
    }

    /**
     * 异步代码高亮解析
     */
    func stringCodeToResList(isEnd: Bool) {
        let callback: (ArrayList<PrismNodesParseResUI>) -> Unit = {
            prismNodesParseResLists => launch {
                refreshCodeDatas(prismNodesParseResLists, isEnd)
            }
        }
        future = stringToResList(this.codeText, this.info, callback)
    }

    /**
     * 列表新老数据对比
     */
    func refreshCodeDatas(prismNodesParseResLists: ArrayList<PrismNodesParseResUI>, isEnd: Bool): Unit {
        let newSize = prismNodesParseResLists.size
        let oldSize = arrayList.size
        if (newSize == oldSize) {
            // 新数据等于页面数据
            for (i in 0..oldSize) {
                if (arrayList[i].getText() != prismNodesParseResLists[i].getText()) {
                    if (isEnd && (i == lastViewIndex)) {
                        prismNodesParseResLists[i].setCloseTypewriter(false)
                    }
                    arrayList[i] = prismNodesParseResLists[i]
                } else if (!arrayList[i].isCloseTypewriter()) {
                    arrayList[i] = prismNodesParseResLists[i]
                }
            }
        } else if (newSize > oldSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..oldSize) {
                arrayList[i].setCloseTypewriter(true) // 已有数据都设置成显示高亮
                if (arrayList[i].getText() != prismNodesParseResLists[i].getText()) {
                    arrayList[i] = prismNodesParseResLists[i]
                }
            }
            for (i in oldSize..newSize) {
                if ((i == newSize -1) && isEnd) {
                    prismNodesParseResLists[i].setCloseTypewriter(false)
                } else {
                    prismNodesParseResLists[i].setCloseTypewriter(true)
                }
                arrayList.append(prismNodesParseResLists[i])
            }
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..newSize) {
                arrayList[i].setCloseTypewriter(true) // 已有数据都设置成显示高亮
                if (arrayList[i].getText() != prismNodesParseResLists[i].getText()) {
                    arrayList[i] = prismNodesParseResLists[i]
                }
            }
            // 循环删除多余的旧数据
            for (i in oldSize - 1..=newSize : -1) {
                arrayList.remove(i)
            }
        }
        lastViewIndex = arrayList.size - 1
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
