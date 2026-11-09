package markdown.components

import ohos.state_macro_manage.*

/**
 * 单独代码块自定义控件
 */
@Component
class MarkdownCodeComponent {
    @Prop
    var markdownConfiguration: MarkdownConfiguration // markdown配置
    @State
    var codeText: String = "" // 代码内容
    @State
    var info: Option<String> = Option<String>.None // 代码类型
    @State
    var nodeHash: Int64 = 0 // hash
    @State
    var lineStrArray: StringDataSource = StringDataSource(ArrayList<String>()) // 原始代码行列表（行号列与rawText兜底共用数据源，对齐ArkUI rawLines/lineArray）
    @State
    var rowBlocks: ObservedArrayList<ArrayList<PrismNodesParseResUI>> = ObservedArrayList<ArrayList<PrismNodesParseResUI>>() // 高亮代码按行分块列表（整段解析后按\n切行，跨行注释/字符串着色正确，对齐ArkUI prismBlocks；为空时显示rawText兜底）
    let scroller1: Scroller = Scroller() // list控制器
    let scroller2: Scroller = Scroller() // list控制器
    @State
    var reachBottom: Bool = true // 是否在布局末尾
    var chatTouch: Bool = false // 手指是否触摸
    var psh: ?PrismSyntaxHighlight = Option<PrismSyntaxHighlight>.None // 代码高亮
    var future: ?Future<Unit> = Option<Future<Unit>>.None // 子线程
    var isAlive: Bool = false // 组件是否存活
    var parseVersion: Int64 = 0 // 解析版本号，每次解析递增
    var appliedVersion: Int64 = 0 // 已应用的版本号，用于丢弃过期的异步解析结果
    var parseTimer: ?Timer = Option<Timer>.None // 定时器调度（清旧调度新，避免重复解析）
    var appliedText: Option<String> = Option<String>.None // 已处理代码原文快照（None=尚未处理，首次必执行；原文与语言未变则整体跳过）
    var appliedInfo: Option<String> = Option<String>.None // 已处理代码类型快照

    protected override func aboutToAppear(): Unit {
        isAlive = true
        psh = PrismSyntaxHighlight.create(prism, markdownConfiguration.markdownTheme.prismTheme)
        MarkdownRefreshRegistry.register(this.nodeHash, refreshData)
        refreshDataInternal()
    }

    protected override func aboutToDisappear(): Unit {
        isAlive = false
        MarkdownRefreshRegistry.unregister(this.nodeHash)
        parseTimer?.cancel()
        parseTimer = None
        future?.cancel()
    }

    func build() {
        Row() {
            Column() {
                codeTitleComponent(codeText, if (info.isSome()) { info() } else { "" }, markdownConfiguration, true)
                Row() {
                    List(scroller: scroller1) {
                        LazyForEach(
                            lineStrArray,
                            itemGeneratorFunc: {
                                item: String, idx: Int64 => ListItem() {
                                    Text((idx + 1).toString())
                                        .fontFamily(codeLineNumberTextFontFamily(markdownConfiguration.markdownTheme))
                                        .fontSize(codeLineNumberTextSize(markdownConfiguration.markdownTheme))
                                        .fontWeight(codeLineNumberTextFontWeight(markdownConfiguration.markdownTheme))
                                        .fontStyle(codeLineNumberTextFontStyle(markdownConfiguration.markdownTheme))
                                        .fontColor(codeLineNumberTextColor(markdownConfiguration.markdownTheme))
                                        .lineHeight(codeLineNumberTextLineHeight(markdownConfiguration.markdownTheme))
                                        .maxLines(1)
                                        .textOverflow(TextOverflow.Ellipsis)
                                        .textAlign(TextAlign.End)
                                }
                            },
                            keyGeneratorFunc: {
                                item: String, idx: Int64 => "${idx}"
                            }
                        )
                    }
                    .width(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockSeparateWidth)
                    .padding(right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberDividerSpacing, left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberTextPaddingLeft)
                    .borderWidth(EdgeWidths(right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockDividerStrokeWidth.vp))
                    .borderColor(codeDividerColor(markdownConfiguration.markdownTheme))
                    .height(100.percent)
                    .borderStyle(BorderStyle.Solid)
                    .scrollBar(BarState.Off)
                    .alignListItem(ListItemAlign.End)
                    .enabled(false)
                    .nestedScroll(NestedScrollOptions(NestedScrollMode.SELF_FIRST, NestedScrollMode.SELF_FIRST))

                    Scroll() {
                        Column() {
                            List(scroller: scroller2) {
                                if (rowBlocks.size > 0) {
                                    // 高亮行块（对齐ArkUI prismBlocks分支）：整段解析后按\n切行，每行独立Text横向不折行
                                    ForEach(
                                        rowBlocks,
                                        itemGeneratorFunc: {
                                            items: ArrayList<PrismNodesParseResUI>, idx: Int64 => ListItem() {
                                                Text() {
                                                    ForEach(
                                                        items,
                                                        itemGeneratorFunc: {
                                                            item: PrismNodesParseResUI, idx1: Int64 => Span(item.getText())
                                                                .fontColor(codeTextColor(item, markdownConfiguration.markdownTheme))
                                                                .letterSpacing(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextLetterSpacing)
                                                        },
                                                        keyGeneratorFunc: {
                                                            item: PrismNodesParseResUI, idx1: Int64 => "${idx1}-${item.getText()}"
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
                                            // 事件驱动置底：条目挂载（首次布局/流式新增/滚动后重建）时若处于置底模式且在末尾，则滚动到底
                                            .onAppear({ =>
                                                scrollChatIfAtBottom()
                                            })
                                        },
                                        keyGeneratorFunc: {
                                            items: ArrayList<PrismNodesParseResUI>, idx: Int64 => "${idx}-${MarkdownParseCodeUtil.rowText(items)}"
                                        }
                                    )
                                } else {
                                    // rawText兜底（对齐ArkUI rawLines分支）：高亮未完成/解析失败时显示原始文本，空行补空格防行高塌陷
                                    LazyForEach(
                                        lineStrArray,
                                        itemGeneratorFunc: {
                                            item: String, idx: Int64 => ListItem() {
                                                Text(if (item.size > 0) { item } else { " " })
                                                    .fontFamily(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontFamily)
                                                    .fontSize(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontSize)
                                                    .fontWeight(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontWeight)
                                                    .fontStyle(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontStyle)
                                                    // issue #730：rawText 兜底样式与高亮路径保持一致，补挂 letterSpacing
                                                    .letterSpacing(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextLetterSpacing)
                                                    .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme))
                                                    .lineHeight(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextLineHeight)
                                                    .textAlign(TextAlign.Start)
                                            }
                                            // 事件驱动置底：条目挂载（首次布局/流式新增/滚动后重建）时若处于置底模式且在末尾，则滚动到底
                                            .onAppear({ =>
                                                scrollChatIfAtBottom()
                                            })
                                        },
                                        keyGeneratorFunc: {
                                            item: String, idx: Int64 => "${idx}-${item}"
                                        }
                                    )
                                }
                            }
                            .height(100.percent)
                            .scrollBar(BarState.Off)
                            .edgeEffect(EdgeEffect.None)
                            .onReachEnd {
                                => reachBottom = true
                            }
                            .onScroll {
                                offset, _ =>
                                    scroller1.scrollTo(xOffset: 0.0, yOffset: scroller2.currentOffset().yOffset)
                                    checkScroll(offset)
                            }
                            .onTouch {
                                evt => chatOnTouch(evt)
                            }
                            .nestedScroll(NestedScrollOptions(NestedScrollMode.SELF_FIRST, NestedScrollMode.SELF_FIRST))
                        }
                        .alignItems(HorizontalAlign.Start) // 与ArkUI一致：代码文本左对齐（Column默认居中会导致内容偏右）
                        .layoutWeight(1)
                    }
                    .layoutWeight(1)
                    .scrollable(ScrollDirection.Horizontal)
                    .scrollBar(BarState.Off)
                    .align(Alignment.Start)
                    .height(100.percent)
                    .nestedScroll(NestedScrollOptions(NestedScrollMode.PARENT_FIRST, NestedScrollMode.PARENT_FIRST))
                    .margin(left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextMarginLeft, right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextMarginRight)
                }
                .layoutWeight(1)
            }
            .layoutWeight(1)
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
     * 是否滑动到底部
     * 置底模式开启且用户未上滑离开末尾时才滚动
     */
    func scrollChatIfAtBottom() {
        if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockSeparateIsBottom && reachBottom) {
            scroll2Bottom()
        }
    }

    /**
     * 滑动到底部
     * 由条目 onAppear 事件驱动：新条目挂载后触发一次滚动，
     * 滚动又使后续条目挂载，循环收敛到真实底部，无需定时器
     */
    func scroll2Bottom() {
        scroller2.scrollEdge(Edge.Bottom)
    }

    /**
     * 判断滑动距离和是否手指触摸
     */
    func checkScroll(offset: Float64) {
        if (offset < -0.5 && chatTouch) {
            reachBottom = false
        }
    }

    /**
     * 手指触摸判断
     */
    func chatOnTouch(evt: TouchEvent) {
        if (let TouchType.Down <- evt.eventType) {
            chatTouch = true
        } else if (let TouchType.Up <- evt.eventType) {
            chatTouch = false
        }
    }

    /**
     * 数据刷新
     */
    public func refreshData(newNodeView: NodeView): Unit {
        this.codeText = newNodeView.nodeText
        this.info = newNodeView.codeInfo
        this.nodeHash = newNodeView.nodeHash
        refreshDataInternal()
    }

    public func refreshDataInternal(): Unit {
        // 内容签名检查（对齐ArkUI signedCodeText/signedCodeInfo）：代码原文与语言未变则行数据与高亮结果恒相同，整体跳过
        if (appliedText.isSome() && appliedText() == this.codeText && appliedInfo == this.info) {
            return
        }
        appliedText = Some(this.codeText)
        appliedInfo = this.info
        updateLineStrArray() // 行号列与rawText兜底数据源刷新
        if (this.codeText.size == 0) {
            // 空代码内容清空高亮行块，显示rawText兜底（对齐ArkUI prismBlocks=[]）
            refreshRowBlocks(ArrayList<PrismNodesParseResUI>())
            return
        }
        if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockParserSync) {
            stringCodeToResListSync()
        } else {
            stringCodeToResList()
        }
    }

    /**
     * 原始行数据源刷新（保留原逐行diff逻辑：行号列与rawText兜底共用）
     */
    func updateLineStrArray(): Unit {
        let arr = this.codeText.split("\n") // 代码块数据分割
        let refreshNodeViewSize = arr.size // 刷新进来的数据长度
        let dataSourceSize = lineStrArray.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            // 空文本保留1行占位（对齐ArkUI空文本split结果为1行）
            lineStrArray.clear()
            lineStrArray.addData("")
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..dataSourceSize) {
                if (lineStrArray.getData(i) != arr[i]) {
                    // 数据变化时直接替换数据源
                    lineStrArray.replaceData(i, arr[i])
                }
            }
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                lineStrArray.addData(arr[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            let indexItem: Int64 = dataSourceSize
            for (i in 0..indexItem) {
                if (lineStrArray.getData(i) != arr[i]) {
                    // 数据变化时直接替换数据源
                    lineStrArray.replaceData(i, arr[i])
                }
            }
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..refreshNodeViewSize) {
                if (lineStrArray.getData(i) != arr[i]) {
                    // 数据变化时直接替换数据源
                    lineStrArray.replaceData(i, arr[i])
                }
            }
            // 循环删除多余的旧数据
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                lineStrArray.deleteData(i)
            }
        }
    }

    /**
     * 同步代码高亮解析（codeBlockParserSync=true时使用）
     */
    func stringCodeToResListSync(): Unit {
        parseVersion++ // 版本号递增
        appliedVersion = parseVersion // 同步结果即时生效，推进已应用版本使在途异步结果全部过期
        var prismNodesParseResLists: ArrayList<PrismNodesParseResUI> = ArrayList<PrismNodesParseResUI>()
        try {
            prismNodesParseResLists = psh().highlight(info, this.codeText)
        } catch (e: Exception) {
            // 解析异常清空高亮行块，回落rawText兜底（对齐ArkUI catch→prismBlocks=[]）
            refreshRowBlocks(ArrayList<PrismNodesParseResUI>())
            return
        }
        refreshRowBlocks(prismNodesParseResLists) // 空结果同样清空→回落rawText兜底
    }

    /**
     * 异步代码高亮解析（codeBlockParserSync=false时使用）
     * 单定时器调度+版本号防过期：流式增量期间清旧调度新仅保留最新一次解析，
     * 回调中比对版本号与源文本快照，过期结果丢弃，防止旧结果覆盖新结果；
     * 解析期间rowBlocks保留旧高亮，新结果应用时整体替换（对齐ArkUI prismBlocks更新时机）
     */
    func stringCodeToResList(): Unit {
        parseVersion++ // 版本号递增
        let currentVersion = parseVersion
        // 快照当前源文本
        let snapshot = this.codeText
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
