package markdown.components

import ohos.state_macro_manage.*

/**
 * Markdown围栏代码列表切换自定义控件
 *
 * 参考 ArkUI MarkdownCodeBlockList.ets 的设计：
 * - 外层 ForEach 使用稳定 key=${idx}，新增代码块时不重建已有项
 * - blocks 为空时显示 rawText fallback，避免初始无内容闪烁
 * - 流式期间所有代码块都解析，源文本比对防止过期结果应用
 */
@Component
class MarkdownCodeBlockListComponent {
    @Prop
    var markdownConfiguration: MarkdownConfiguration // markdown配置
    @Prop
    var nodeView: NodeView // Node
    @State
    var strInfos: ObservedArrayList<String> = ObservedArrayList<String>() // 代码类型列表标题（Tab）
    @State
    var strText: ObservedArrayList<String> = ObservedArrayList<String>() // 代码内容列表（@State 触发 codeBlockButtonComponent 刷新）
    @State
    var strInfoText: ObservedArrayList<String> = ObservedArrayList<String>() // 代码真实类型列表
    @State
    var idxSelect: Int64 = 0 // 选中Index
    @State
    var lines: Int64 = 0 // 代码行数
    @State
    var lineArray: ObservedArrayList<Int64> = ObservedArrayList<Int64>() // 代码行数显示数据列表
    @State
    var arrayLists: ObservedArrayList<ArrayList<PrismNodesParseResUI>> = ObservedArrayList<ArrayList<PrismNodesParseResUI>>() // 所有代码块高亮数据
    @State
    var highlightVersion: Int64 = 0 // 高亮结果版本号（参与ForEach key，替换arrayLists元素后递增以触发重建）
    var future: ?Future<Unit> = Option<Future<Unit>>.None // 子线程
    var psh: ?PrismSyntaxHighlight = Option<PrismSyntaxHighlight>.None // 代码高亮
    var isAlive: Bool = false // 组件是否存活
    var parseTimer: ?Timer = Option<Timer>.None // 单个定时器调度（清旧调度新，避免重复解析）

    protected override func aboutToAppear(): Unit {
        isAlive = true
        psh = PrismSyntaxHighlight.create(prism, markdownConfiguration.markdownTheme.prismTheme)
        MarkdownRefreshRegistry.register(nodeView.nodeHash, refreshData)
        refreshData(nodeView)
    }

    protected override func aboutToDisappear(): Unit {
        isAlive = false
        parseTimer?.cancel()
        parseTimer = Option<Timer>.None
        future?.cancel()
        MarkdownRefreshRegistry.unregister(nodeView.nodeHash)
    }

    func build() {
        Row() {
            Column() {
                codeBlockTitleComponent()
                codeBlockComponent()
            }
            .layoutWeight(1)
        }
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
     * 组合代码标题部分（Tab切换栏）
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
                            .backgroundColor(listCodeBackgroundColor(idxSelect, idx, markdownConfiguration))
                            .maxLines(1)
                            .fontSize(if (idxSelect == idx) { markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockListTitleSelectTextSize } else { markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockListTitleTextSize })
                            .padding(left: 14, right: 14, top: 5, bottom: 5)
                            .onClick {evt =>
                                idxSelect = idx
                                updateLineArray()
                            }
                    },
                    keyGeneratorFunc: {
                        item: String, idx: Int64 => return "${idx}-${item}"
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
                        },
                        keyGeneratorFunc: {
                            num: Int64, idx: Int64 => return "${idx}-${num}"
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
    }

    /**
     * 组合代码代码部分（水平滚动）
     * 外层 ForEach key 含 highlightVersion：
     * - 新代码块追加时仅新增项，不重建已有项
     * - arrayLists[i] 原地替换后版本号递增，key 变化触发该项重建（否则高亮结果不渲染）
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
                },
                keyGeneratorFunc: {
                    items: ArrayList<PrismNodesParseResUI>, idx: Int64 => return "${idx}-${highlightVersion}"
                }
            )
        }
        .alignItems(HorizontalAlign.Start)
    }

    /**
     * 组合代码代码文本内容
     * 参考 ArkUI MarkdownCodeBlockTextItem：
     * - blocks 为空时显示 rawText fallback，避免初始无内容闪烁
     * - 通过 visibility 控制选中代码块显隐
     */
    @Builder
    func codeBlockTextComponent(items: ArrayList<PrismNodesParseResUI>, idx: Int64) {
        Column() {
            Text() {
                ForEach(
                    items,
                    itemGeneratorFunc: {
                        item: PrismNodesParseResUI, idx1: Int64 =>
                        Span(item.getText())
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
            .visibility(if (items.size == 0) { Visibility.None } else { Visibility.Visible })

            // rawText fallback：高亮未完成时显示原始文本，避免闪烁
            Text(getRawText(idx))
                .fontFamily(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontFamily)
                .fontSize(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontSize)
                .fontWeight(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontWeight)
                .fontStyle(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontStyle)
                .fontColor(rawTextFontColor(markdownConfiguration.markdownTheme))
                .lineHeight(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextLineHeight)
                .textAlign(TextAlign.Start)
                .visibility(if (items.size == 0) { Visibility.Visible } else { Visibility.None })
        }
        .alignItems(HorizontalAlign.Start)
        .visibility(listCodeTextBool(idxSelect, idx))
    }

    /**
     * 获取原始代码文本（安全访问，避免越界）
     */
    func getRawText(idx: Int64): String {
        if (idx < strText.size) {
            return strText[idx]
        }
        return ""
    }

    /**
     * 获取 rawText fallback 的字体颜色（参考 codeTextColor 的 fallback 逻辑）
     */
    func rawTextFontColor(markdownTheme: MarkdownTheme): Color {
        if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockTextFontColor) {
            return v
        }
        return markdownTheme.prismTheme.textColor()
    }

    /**
     * 复制按钮和全屏按钮部分
     */
    @Builder
    func codeBlockButtonComponent() {
        Row() {
            if (strText.size > 0 && idxSelect < strText.size && strText[idxSelect].trimAscii().size > 0) {
                Row()
                    .width(30.percent)
                    .justifyContent(FlexAlign.Start)
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
                        .onClick {evt => codeCopyOnClick(strText[idxSelect], markdownConfiguration.codeCopyCallback)}
                    }

                    Blank()
                        .width(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyFullScreenSpacing)
                        .visibility(if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyButtonIsShow && markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenButtonIsShow) {
                            Visibility.Visible
                        } else {
                            Visibility.None
                        })

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
     * 数据刷新：从node子节点提取代码块列表
     * 参考 ArkUI MarkdownCodeBlockList.refreshData：
     * - 检测哪些代码块内容变化（文本或语言）
     * - 调整 arrayLists 大小（保留已有 ArrayList 实例）
     * - 仅在选中索引越界时重置（避免流式输入时Tab频繁跳回第一个）
     */
    public func refreshData(newNodeView: NodeView): Unit {
        let res = toCodeList(newNodeView)
        let newInfos = res[0]
        let newText = res[1]
        let newInfoText = res[2]

        // 检测哪些代码块内容变化（文本或语言）
        var hasChange = false
        for (i in 0..newText.size) {
            let textChanged = i >= this.strText.size || this.strText[i] != newText[i]
            let infoChanged = i >= this.strInfoText.size || this.strInfoText[i] != newInfoText[i]
            if (textChanged || infoChanged) {
                hasChange = true
                break
            }
        }
        if (!hasChange && this.strText.size > 0 && newText.size == this.strText.size) {
            // 文本和语言都没变化，仅更新标题（如果有变化）
            updateStrInfos(newInfos)
            return
        }

        // 更新 strInfos（ObservedArrayList 逐个更新以触发 ForEach 刷新）
        updateStrInfos(newInfos)

        // 更新 strText / strInfoText（ObservedArrayList 逐个更新）
        updateStrList(this.strText, newText)
        updateStrList(this.strInfoText, newInfoText)

        // 调整 arrayLists 大小：保留已有 ArrayList 实例，新增空的
        let newSize = strText.size
        let oldSize = arrayLists.size
        if (newSize > oldSize) {
            for (i in oldSize..newSize) {
                arrayLists.append(ArrayList<PrismNodesParseResUI>())
            }
        } else if (newSize < oldSize) {
            for (i in oldSize - 1..=newSize : -1) {
                arrayLists.remove(i)
            }
        }

        // 仅在选中索引越界时重置（避免流式输入时Tab频繁跳回第一个）
        if (idxSelect >= strText.size) {
            idxSelect = 0
        }

        updateLineArray()

        // 单定时器调度：清除旧定时器，仅保留最新调度，避免重复解析
        parseTimer?.cancel()
        parseTimer = Timer.once(0 * Duration.millisecond) {
            =>
                parseTimer = None
                if (!isAlive) {
                    return
                }
                scheduleParse()
        }
    }

    /**
     * 更新 strInfos（复用 updateStrList 三段式更新以触发 ForEach 刷新）
     */
    func updateStrInfos(newInfos: ArrayList<String>): Unit {
        updateStrList(this.strInfos, newInfos)
    }

    /**
     * 更新字符串列表（ObservedArrayList 逐个更新以触发 ForEach 刷新）
     * 参考 markdown_code_text_component.refreshCodeDatas 的三段式处理：
     * 公共前缀逐项更新，新增追加，多余删除（避免clear导致全量刷新）
     */
    func updateStrList(list: ObservedArrayList<String>, newList: ArrayList<String>): Unit {
        let newSize = newList.size
        let oldSize = list.size
        if (newSize == oldSize) {
            for (i in 0..newSize) {
                if (list[i] != newList[i]) {
                    list[i] = newList[i]
                }
            }
        } else if (newSize > oldSize) {
            for (i in 0..oldSize) {
                if (list[i] != newList[i]) {
                    list[i] = newList[i]
                }
            }
            for (i in oldSize..newSize) {
                list.append(newList[i])
            }
        } else {
            for (i in 0..newSize) {
                if (list[i] != newList[i]) {
                    list[i] = newList[i]
                }
            }
            for (i in oldSize - 1..=newSize : -1) {
                list.remove(i)
            }
        }
    }

    /**
     * 更新当前选中代码块的行号显示数据
     */
    func updateLineArray(): Unit {
        if (strText.size == 0) {
            lines = 0
            lineArray.set(Array<Int64>(0, repeat: 0))
            return
        }
        if (idxSelect < 0 || idxSelect >= strText.size) {
            idxSelect = 0
        }
        lines = strText[idxSelect].lines().count()
        lineArray.set(Array<Int64>(lines, repeat: 0))
    }

    /**
     * 发起异步高亮解析，解析完成后比对源文本，过期结果丢弃
     * 参考 ArkUI MarkdownCodeBlockList.parseChangedCodeAsync：
     * - 源文本比对防止流式期间过期解析结果应用
     * - 原地替换 arrayLists[i] 触发 ForEach 刷新
     */
    func scheduleParse(): Unit {
        // 快照当前源文本与语言（同源同索引，保证解析时语言与文本对应）
        let snapshot: ArrayList<String> = ArrayList<String>()
        let infoSnapshot: ArrayList<String> = ArrayList<String>()
        for (i in 0..strText.size) {
            snapshot.add(strText[i])
            if (i < strInfoText.size) {
                infoSnapshot.add(strInfoText[i])
            } else {
                infoSnapshot.add("")
            }
        }
        future?.cancel()
        let callback: (ArrayList<ArrayList<PrismNodesParseResUI>>) -> Unit = {
            prismNodesParseResLists => launch {
                if (!isAlive) {
                    return
                }
                // 源文本/语言比对：已变化则丢弃过期解析结果
                if (!codeListEquals(snapshot, this.strText) || !codeListEquals(infoSnapshot, this.strInfoText)) {
                    return
                }
                // 原地替换每个代码块的高亮结果（ObservedArrayList 逐个替换触发 ForEach 刷新）
                let newSize = prismNodesParseResLists.size
                for (i in 0..newSize) {
                    if (i < arrayLists.size) {
                        arrayLists[i] = prismNodesParseResLists[i]
                    }
                }
                // 版本号递增：key 变化触发 ForEach 重建该项，否则替换元素后高亮不渲染
                this.highlightVersion = this.highlightVersion + 1
            }
        }
        future = MarkdownParseCodeUtil.stringToResLists(snapshot, infoSnapshot, psh, callback)
    }

    /**
     * 代码文本列表比较
     */
    func codeListEquals(a: ArrayList<String>, b: ObservedArrayList<String>): Bool {
        if (a.size != b.size) {
            return false
        }
        for (i in 0..a.size) {
            if (a[i] != b[i]) {
                return false
            }
        }
        return true
    }
}
