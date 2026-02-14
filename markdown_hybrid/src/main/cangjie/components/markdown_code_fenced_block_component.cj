/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 围栏代码块
 */
@Component
class MarkdownCodeFencedBlockComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 代码内容
     */
    @State
    var codeText: String = ""

    /**
     * 代码类型
     */
    @State
    var info: String = ""

    /**
     * hash
     */
    @State
    var nodeHash: Int64 = 0

    /**
     *
     */
    @State
    var isCodeNone: Bool = false

    /**
     * 高亮代码列表
     */
    @State
    var arrayList: ObservedArrayList<PrismNodesParseResUI> = ObservedArrayList<PrismNodesParseResUI>()

    /**
     * 缓存的围栏代码块控件列表
     */
    var fencedCodeComponents: HashMap<Int64, MarkdownCodeFencedBlockComponent>

    /**
     * 代码行数显示数据列表
     */
    @State
    var lineArray: ObservedArrayList<Int64> = ObservedArrayList<Int64>()

    /**
     * 代码高亮
     */
    var psh: ?PrismSyntaxHighlight = Option<PrismSyntaxHighlight>.None

    protected override func aboutToAppear(): Unit {
        psh = PrismSyntaxHighlight.create(prism, markdownConfiguration.markdownTheme.prismTheme)
        refreshData(codeText, info, nodeHash) // 初始化刷新数据
        fencedCodeComponents.add(nodeHash, this) // 缓存当前控件
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = fencedCodeComponents.get(nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                fencedCodeComponents.remove(nodeHash)
            }
        } else {
            fencedCodeComponents.remove(nodeHash)
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
                                .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                                .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                                .lineHeight(markdownConfiguration.markdownTheme.codeBlockLineHeight)
                                .maxLines(1)
                                .textOverflow(TextOverflow.Ellipsis)
                        },
                        keyGeneratorFunc: {
                            item: Int64, idx: Int64 => return "${idx}-${item}"
                        }
                    )
                }
                .margin(bottom: 10)
                .padding(left: 8, right: 8)
                .alignItems(HorizontalAlign.End)
                .borderWidth(EdgeWidths(right: markdownConfiguration.markdownTheme.thematicBreakHeight.vp))
                .borderStyle(BorderStyle.Solid)
                .borderColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                .visibility(isVisibility(markdownConfiguration.markdownTheme.codeBlockLineNumberHide))
                Scroll() {
                    Column() {
                        Text() {
                            ForEach(
                                arrayList,
                                itemGeneratorFunc: {
                                    item: PrismNodesParseResUI, idx: Int64 => Span(item.getText())
                                        .fontColor(codeTextColor(item, markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                                        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
                                },
                                keyGeneratorFunc: {
                                    item: PrismNodesParseResUI, idx: Int64 => return "${idx}-${item.getText()}"
                                }
                            )
                        }
                        .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                        .fontFamily(markdownConfiguration.markdownTheme.codeBlockTypeface)
                        .textAlign(TextAlign.Start)
                        .padding(left: markdownConfiguration.markdownTheme.codeMultilineMargin, right: markdownConfiguration.markdownTheme.codeMultilineRightMargin)
                        .lineHeight(markdownConfiguration.markdownTheme.codeBlockLineHeight)
                    }
                }
                .scrollable(ScrollDirection.Horizontal)
                .scrollBar(BarState.Off)
                .layoutWeight(1)
                .align(Alignment.Start)
                .padding(bottom: 10)
            }
        }
        .width(100.percent)
        .borderRadius(markdownConfiguration.markdownTheme.codeBlockRadius)
        .backgroundColor(codeBackgroundColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
    }

    /**
     * 复制按钮和全屏按钮部分
     */
    @Builder
    func codeBlockButtonComponent() {
        Row() {
            if (isCodeNone) {
                codeBlockTextComponent(if (info != "") {
                    info
                } else {
                    markdownConfiguration.markdownTheme.codeBlockTypeTextStr
                }, markdownConfiguration)
                Row() {
                    if (markdownConfiguration.markdownTheme.codeCopyIcon.isSome()) {
                        Row() {
                            Image(markdownConfiguration.markdownTheme.codeCopyIcon())
                                .width(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                                .height(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                                .objectFit(ImageFit.Contain)

                            Row()
                                .width(5)

                            if (markdownConfiguration.markdownTheme.codeBlockIconTextHide) {
                                Text("复制代码")
                                    .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                                    .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                                    .align(Alignment.End)
                                    .maxLines(1)
                                    .textOverflow(TextOverflow.Ellipsis)
                                    .margin(right: 4)
                            }
                        }
                        .justifyContent(FlexAlign.End)
                        .onClick {evt => codeCopyOnClick(codeText, markdownConfiguration.codeCopyCallback)}
                    }

                    if (markdownConfiguration.markdownTheme.codeFullScreenIcon.isSome()) {
                        Row() {
                            Image(markdownConfiguration.markdownTheme.codeFullScreenIcon())
                                .width(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                                .height(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                                .margin(left: 4)
                                .objectFit(ImageFit.Contain)

                            Row()
                                .width(5)

                            if (markdownConfiguration.markdownTheme.codeBlockIconTextHide) {
                                Text("全屏代码")
                                    .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                                    .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                                    .align(Alignment.End)
                                    .maxLines(1)
                                    .textOverflow(TextOverflow.Ellipsis)
                                    .margin(right: 4)
                            }
                        }
                        .justifyContent(FlexAlign.End)
                        .visibility(isVisibility(markdownConfiguration.markdownTheme.isCodeFullScreen))
                        .onClick {
                            evt => codeFullScreenOnClick(codeText, info, markdownConfiguration.codeFullScreenCallback)
                        }
                    }
                }
                .width(70.percent)
                .justifyContent(FlexAlign.End)
            }
        }
        .margin(top: 8.0, right: 8.0, bottom: markdownConfiguration.markdownTheme.codeBlockTypeTextPadding)
        .alignItems(VerticalAlign.Center)
    }

    /**
     * 数据刷新
     */
    public func refreshData(codeText: String, info: String, nodeHash: Int64): Unit {
        this.codeText = codeText
        this.isCodeNone = this.codeText.trimAscii().size > 0
        this.info = info
        this.nodeHash = nodeHash
        if (markdownConfiguration.markdownTheme.isCodeBlockParserSync) {
            stringCodeToResListSync(this.codeText)
        } else {
            stringCodeToResList(this.codeText)
        }
    }

    /**
     * 代码数据高亮解析
     */
    func stringCodeToResListSync(code: String) {
        let codeText = if (markdownConfiguration.markdownTheme.isCodeFormat) {
            codeFormat(info, code, FormatConfig())
        } else {
            code
        }
        let lines = codeText.lines().count()
        refreshLines(lines)
        var prismNodesParseResUIList: ArrayList<PrismNodesParseResUI> = ArrayList<PrismNodesParseResUI>()
        try {
            prismNodesParseResUIList = psh().highlight(info, codeText.trimEnd("\n"))
        } catch (e: Exception) {
            let prismNodesParseResUI: PrismNodesParseResUI = PrismNodesParseResUI(types: "", text: codeText, alias: Option<String>.None, color: Option<Color>.None)
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
    }

    /**
     * 行号刷新
     */
    func refreshLines(lines: Int64): Unit {
        let newSize = lines
        let oldSize = lineArray.size
        if (newSize == oldSize) {
        } else if (newSize > oldSize) {
            // 循环添加新数据
            for (i in oldSize..newSize) {
                lineArray.append(oldSize + i)
            }
        } else {
            // 循环删除多余的旧数据
            for (i in oldSize - 1..=newSize : -1) {
                lineArray.remove(i)
            }
        }
    }

    /**
     * 代码数据高亮解析
     */
    func stringCodeToResList(str: String) {
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
            }
        }
        stringToResList(str, info, callback)
    }

    /**
     * 通过异步的方式将代码转换成带有颜色的列表 - 围栏代码、缩进代码
     *
     * @param code 传入代码内容
     * @param info 传入代码类型
     * @param callback PrismNodesParseRes列表回调接口
     */
    func stringToResList(code: String, info: ?String, callback: (ArrayList<PrismNodesParseResUI>, Int64) -> Unit): Future<Unit> {
        let fut: Future<Unit> = spawn {
            let codeText = if (markdownConfiguration.markdownTheme.isCodeFormat) {
                codeFormat(info, code, FormatConfig())
            } else {
                code
            }
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            let lines = codeText.lines().count()
            var prismNodesParseResUIList: ArrayList<PrismNodesParseResUI> = ArrayList<PrismNodesParseResUI>()
            try {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                prismNodesParseResUIList = psh().highlight(info, codeText.trimEnd("\n"))
                callback(prismNodesParseResUIList, lines)
            } catch (e: Exception) {
                let prismNodesParseResUI: PrismNodesParseResUI = PrismNodesParseResUI(types: "", text: codeText, alias: Option<String>.None, color: Option<Color>.None)
                prismNodesParseResUIList.add(prismNodesParseResUI)
                callback(prismNodesParseResUIList, lines)
            }
        }
        return fut
    }
}
