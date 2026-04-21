package markdown.components

import ohos.state_macro_manage.*

/**
 * 围栏代码块
 */
@Component
class MarkdownCodeFencedBlockComponent {
    var markdownConfiguration: MarkdownConfiguration // markdown配置
    @State
    var codeText: String = "" // 代码内容
    @State
    var info: String = "" // 代码类型
    @State
    var nodeHash: Int64 = 0 // hash
    @State
    var isCodeNone: Bool = false
    @State
    var arrayList: ObservedArrayList<PrismNodesParseResUI> = ObservedArrayList<PrismNodesParseResUI>() // 高亮代码列表
    var fencedCodeComponents: HashMap<Int64, MarkdownCodeFencedBlockComponent> // 缓存的围栏代码块控件列表
    @State
    var lineArray: ObservedArrayList<Int64> = ObservedArrayList<Int64>() // 代码行数显示数据列表
    var psh: ?PrismSyntaxHighlight = Option<PrismSyntaxHighlight>.None // 代码高亮
    var future: ?Future<Unit> = Option<Future<Unit>>.None // 子线程
    @State
    var formatConfig: FormatConfig = FormatConfig() // codeformat配置

    protected override func aboutToAppear(): Unit {
        psh = PrismSyntaxHighlight.create(prism, markdownConfiguration.markdownTheme.prismTheme)
        formatConfig = FormatConfig(useTab: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockUseTab, indentWidth: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockIndentWidth)
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
        future?.cancel()
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
                    }
                }
                .scrollable(ScrollDirection.Horizontal)
                .scrollBar(BarState.Off)
                .align(Alignment.Start)
                .layoutWeight(1)
                .margin(left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextMarginLeft, right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextMarginRight)
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
     * 复制按钮和全屏按钮部分
     */
    @Builder
    func codeBlockButtonComponent() {
        Row() {
            if (isCodeNone) {
                codeBlockTextComponent(if (info != "") {
                    info
                } else {
                    markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTypeText
                }, markdownConfiguration)
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
            }
        }
        .margin(top: 8.0, right: 8.0, bottom: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTitleLayoutMarginBottom)
        .alignItems(VerticalAlign.Center)
    }

    /**
     * 数据刷新
     */
    public func refreshData(codeTextStr: String, info: String, nodeHash: Int64): Unit {
        this.codeText = codeTextStr
        this.isCodeNone = this.codeText.trimAscii().size > 0
        this.info = info
        this.nodeHash = nodeHash
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
        let codeTextStr = if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockIsCodeFormat) {
            codeFormat(info, code, formatConfig)
        } else {
            code
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

        future = stringToResList(str, info, callback)
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
     * 通过异步的方式将代码转换成带有颜色的列表 - 围栏代码、缩进代码
     *
     * @param code 传入代码内容
     * @param info 传入代码类型
     * @param callback PrismNodesParseRes列表回调接口
     */
    func stringToResList(code: String, info: ?String, callback: (ArrayList<PrismNodesParseResUI>, Int64) -> Unit): Future<Unit> {
        let fut: Future<Unit> = spawn {
            let codeTextStr = if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockIsCodeFormat) {
                codeFormat(info, code, formatConfig)
            } else {
                code
            }
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }

            let arr = codeTextStr.split("\n") // 代码块数据分割
            let lines = arr.size
            var prismNodesParseResUIList: ArrayList<PrismNodesParseResUI> = ArrayList<PrismNodesParseResUI>()
            try {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                prismNodesParseResUIList = psh().highlight(info, codeTextStr)
                callback(prismNodesParseResUIList, lines)
            } catch (e: Exception) {
                let prismNodesParseResUI: PrismNodesParseResUI = PrismNodesParseResUI(types: "", text: codeTextStr, alias: Option<String>.None, color: Option<Color>.None)
                prismNodesParseResUIList.add(prismNodesParseResUI)
                callback(prismNodesParseResUIList, lines)
            }
        }
        return fut
    }
}
