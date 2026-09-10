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
    var lineStrArray: StringDataSource = StringDataSource(ArrayList<String>()) // 代码列表
    let scroller1: Scroller = Scroller() // list控制器
    let scroller2: Scroller = Scroller() // list控制器
    @State
    var reachBottom: Bool = true // 是否在布局末尾
    var chatTouch: Bool = false // 手指是否触摸

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(this.nodeHash, refreshData)
        refreshDataInternal()
    }

    protected override func aboutToDisappear(): Unit {
        MarkdownRefreshRegistry.unregister(this.nodeHash)
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
                                LazyForEach(
                                    lineStrArray,
                                    itemGeneratorFunc: {
                                        item: String, idx: Int64 => ListItem() {
                                            MarkdownCodeTextComponent(
                                                markdownTheme: markdownConfiguration.markdownTheme,
                                                codeText: item,
                                                info: info,
                                                index: idx
                                            )
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
     * 由条目 onAppear 事件驱动：LazyForEach 每批新条目挂载后触发一次滚动，
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
        let arr = this.codeText.split("\n") // 代码块数据分割
        let refreshNodeViewSize = arr.size // 刷新进来的数据长度
        let dataSourceSize = lineStrArray.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            lineStrArray.clear()
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
}
