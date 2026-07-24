package markdown.components

import ohos.state_macro_manage.*

/**
 * 表格控件
 * 对齐ArkUI MarkdownTable.ets：@Provide cellWidthTracker/columnWidths，@Consume mdStickyHolder
 */
@Component
class MarkdownTableBlockComponent {
    @Prop
    var tableBlockMarkdownConfiguration: MarkdownConfiguration // markdown配置
    @Prop
    var tableBlockNodeView: NodeView // 表格控件自身节点
    @Prop
    @Watch[onComponentWidthChanged]
    var tableBlockComponentWidth: Float64 // 控件宽度 - 单位vp
    @BuilderParam
    var tableBlockCustomTableLineBuilder: (NodeView, Int64) -> Unit // 自定义行内表格Cell控件
    var tableBlockImageCallback: (String) -> Unit // 图片点击事件
    var tableBlockFootnoteCallback: (String) -> Unit // 脚注点击事件
    var tableBlockListItemIndex: Int32 = -1 // 当前表格所在外层List的ListItem索引（用于scroller.getItemRect查询视口位置）
    @Consume["mdStickyHolder"]
    var stickyHolder: StickyScrollYHolder // 吸顶滚动Y持有者（@Consume从MarkdownComponent同步）
    @Provide
    var cellWidthTracker: CellWidthTracker = CellWidthTracker() // 列宽跟踪器（非@Observed，onAreaChange只写不触发重渲染）
    @Provide["tableColumnWidths"]
    var columnWidths: Array<Float64> = Array<Float64>(0, repeat: 0.0) // 列宽快照（@Provide让TableCell通过@Consume直接读取）
    @BuilderParam
    var inlineImageCardComponent: (?String,?String, ?String) -> Unit  //自定义卡片布局行内图片
    @BuilderParam
    var inlineLinkCardComponent: (?String, ?String) -> Unit  //自定义卡片布局行内链接
    @State
    var tableBlockCellSize: Int64 = 0 // 表格总共有几列
    @State
    var tableBlockBodyRows: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>() // 表格body行数据（ForEach用）
    @State
    var tableBlockHeaderNodeView: NodeView = NodeView() // 吸顶模式下的标题行数据
    @State
    var tableBlockFullText: String = "" // 表格序列化的纯文本（用于复制按钮）
    @State
    var useOffsetSticky: Bool = false // 是否使用 offset sticky 模式（aboutToAppear时确定）
    @State
    var tableY: Float64 = 999999.0 // 表格在父容器中的Y位置（onAreaChange获取）
    @State
    var tableHeight: Float64 = 0.0 // 表格总高度（onAreaChange获取）
    @State
    var stickyContentHeight: Float64 = 0.0 // 吸顶内容总高度（header高度，onAreaChange获取）
    @State
    var stickyOffset: Float64 = 0.0 // 吸顶偏移量
    var tablePaddingTopNum: Float64 = 0.0 // tablePaddingTop的数值
    var tableBorderTopNum: Float64 = 0.0 // tableBorderWidth的数值
    var blockMarginTopNum: Float64 = 0.0 // globalTheme.blockMarginTop的数值
    var stickyListenerId: Int64 = -1 // 吸顶监听器ID（用于removeListener）
    let headerScroller: Scroller = Scroller() // 吸顶模式header横向Scroll控制器
    let bodyScroller: Scroller = Scroller() // 吸顶模式body横向Scroll控制器
    let syncManager: TableHorizontalScrollSync = TableHorizontalScrollSync() // header/body横向滚动同步器
    var oldStickyRowCount: Int64 = 0 // sticky模式上一次的总行数（含标题行），用于行减少时清理列宽记录

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(tableBlockNodeView.nodeHash, refreshTableBlockData)
        cellWidthTracker.onWidthUpdated = { => this.applyColumnWidths() }
        useOffsetSticky = stickyHolder.getEnabled()
        if (tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableStickyHeader && useOffsetSticky) {
            syncManager.registerHeader(headerScroller)
            syncManager.registerBody(bodyScroller)
            stickyListenerId = stickyHolder.addListener(onStickyYChanged)
        }
        refreshTableBlockData(tableBlockNodeView)
    }

    protected override func aboutToDisappear(): Unit {
        MarkdownRefreshRegistry.unregister(tableBlockNodeView.nodeHash)
        cellWidthTracker.onWidthUpdated = None
        if (tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableStickyHeader && useOffsetSticky) {
            syncManager.unregisterHeader()
            syncManager.unregisterBody()
            syncManager.reset()
            stickyHolder.removeListener(stickyListenerId)
        }
    }

    func build() {
        if (tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableStickyHeader && useOffsetSticky) {
            // offset sticky 模式：Column 包裹整个表格（外层已有 ListItem）
            Column {
                    // 吸顶header（用 offset 钉在视口顶部）
                    if (tableBlockNodeView.children.size > 0) {
                        Column {
                            if (tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableHeadIsShow) {
                                MarkdownTableTitleComponent(
                                    tableTitleMarkdownConfiguration: tableBlockMarkdownConfiguration,
                                    tableTitleFullText: tableBlockFullText
                                )
                            }
                            Scroll(headerScroller) {
                                MarkdownTableBlockRowComponent(
                                    tableBlockRowMarkdownConfiguration: tableBlockMarkdownConfiguration,
                                    tableBlockRowNodeView: tableBlockNodeView.children[0],
                                    tableBlockRowComponentWidth: tableBlockComponentWidth,
                                    tableBlockRowCustomTableLineBuilder: tableBlockCustomTableLineBuilder,
                                    tableBlockRowImageCallback: tableBlockImageCallback,
                                    tableBlockRowFootnoteCallback: tableBlockFootnoteCallback,
                                    tableBlockRowRow: 0,
                                    tableBlockRowCellSize: tableBlockCellSize,
                                    tableBlockRowRowSize: tableBlockNodeView.children.size,
                                    inlineImageCardComponent: inlineImageCardComponent,
                                    inlineLinkCardComponent: inlineLinkCardComponent
                                )
                            }
                            .scrollable(ScrollDirection.Horizontal)
                            .scrollBar(BarState.Off)
                            .onScrollFrameBegin({
                                offset: Float64, state: ScrollState =>
                                    match (state) {
                                        case ScrollState.Idle => ()
                                        case _ =>
                                            syncManager.onHeaderScrolled(headerScroller.currentOffset().xOffset + offset)
                                    }
                                    return offset
                            })
                        }
                        .backgroundColor(tableBlockMarkdownConfiguration.markdownTheme.globalTheme.backgroundColor)
                        .offset(x: 0.0, y: stickyOffset)
                        .zIndex(1)
                        .interopOnSizeChange({
                            old, new =>
                                stickyContentHeight = new.height
                                onTableAreaChanged()
                        })
                    }
                    // body（Scroll > Column > ForEach）
                    Scroll(bodyScroller) {
                        Column {
                            ForEach(
                                tableBlockBodyRows,
                                itemGeneratorFunc: {
                                    nodeView: NodeView, idRow: Int64 => if (nodeView.nodeType == "TableRow") {
                                        MarkdownTableBlockRowComponent(
                                            tableBlockRowMarkdownConfiguration: tableBlockMarkdownConfiguration,
                                            tableBlockRowNodeView: nodeView,
                                            tableBlockRowComponentWidth: tableBlockComponentWidth,
                                            tableBlockRowCustomTableLineBuilder: tableBlockCustomTableLineBuilder,
                                            tableBlockRowImageCallback: tableBlockImageCallback,
                                            tableBlockRowFootnoteCallback: tableBlockFootnoteCallback,
                                            tableBlockRowRow: idRow + 1,
                                            tableBlockRowCellSize: tableBlockCellSize,
                                            tableBlockRowRowSize: tableBlockNodeView.children.size,
                                            inlineImageCardComponent: inlineImageCardComponent,
                                            inlineLinkCardComponent: inlineLinkCardComponent
                                        )
                                    } else {
                                        Text("")
                                    }
                                },
                                keyGeneratorFunc: {
                                    tableHeaderOrBody: NodeView, idx: Int64 => return "${idx}-${tableHeaderOrBody.nodeHash}-${tableHeaderOrBody.contentHash}"
                                }
                            )
                        }
                        .alignItems(HorizontalAlign.Start)
                    }
                    .scrollable(ScrollDirection.Horizontal)
                    .scrollBar(tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableScrollBarState)
                    .scrollBarColor(tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableScrollBarColor)
                    .onScrollFrameBegin({
                        offset: Float64, state: ScrollState =>
                            match (state) {
                                case ScrollState.Idle => ()
                                case _ =>
                                    syncManager.onBodyScrolled(bodyScroller.currentOffset().xOffset + offset)
                            }
                            return offset
                    })
            }
            .backgroundColor(tableBlockMarkdownConfiguration.markdownTheme.globalTheme.backgroundColor)
            .borderStyle(tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableBorderStyle)
            .borderWidth(tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableBorderWidth)
            .borderColor(tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableBorderColor)
            .borderRadius(topLeft: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableRadiusTopLeft.vp, topRight: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableRadiusTopRight.vp, bottomLeft: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableRadiusBottomLeft.vp, bottomRight: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableRadiusBottomRight.vp)
            .padding(
                top: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tablePaddingTop,
                right: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tablePaddingRight,
                bottom: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tablePaddingBottom,
                left: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tablePaddingLeft
            )
            .margin(
                top: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableMarginTop,
                right: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableMarginRight,
                bottom: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableMarginBottom,
                left: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableMarginLeft
            )
            .clip(true)
            .onAreaChange({
                old, new =>
                    tablePaddingTopNum = tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tablePaddingTop
                    tableBorderTopNum = tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableBorderWidth
                    blockMarginTopNum = tableBlockMarkdownConfiguration.markdownTheme.globalTheme.blockMarginTop
                    tableY = new.position.y
                    tableHeight = new.height
                    println("[STICKY-TABLE-AREA] idx=${tableBlockListItemIndex} position.y=${new.position.y} height=${new.height}")
                    onTableAreaChanged()
            })
        } else {
            // 非吸顶模式：Column(标题 + Scroll > Column > ForEach)
            Column {
                if (tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableHeadIsShow) {
                    MarkdownTableTitleComponent(
                        tableTitleMarkdownConfiguration: tableBlockMarkdownConfiguration,
                        tableTitleFullText: tableBlockFullText
                    )
                }
                Scroll() {
                    Column {
                        ForEach(
                            tableBlockBodyRows,
                            itemGeneratorFunc: {
                                nodeView: NodeView, idRow: Int64 => if (nodeView.nodeType == "TableRow") {
                                    MarkdownTableBlockRowComponent(
                                        tableBlockRowMarkdownConfiguration: tableBlockMarkdownConfiguration,
                                        tableBlockRowNodeView: nodeView,
                                        tableBlockRowComponentWidth: tableBlockComponentWidth,
                                        tableBlockRowCustomTableLineBuilder: tableBlockCustomTableLineBuilder,
                                        tableBlockRowImageCallback: tableBlockImageCallback,
                                        tableBlockRowFootnoteCallback: tableBlockFootnoteCallback,
                                        tableBlockRowRow: idRow,
                                        tableBlockRowCellSize: tableBlockCellSize,
                                        tableBlockRowRowSize: tableBlockNodeView.children.size,
                                        inlineImageCardComponent: inlineImageCardComponent,
                                        inlineLinkCardComponent: inlineLinkCardComponent
                                    )
                                } else {
                                    Text("")
                                }
                            },
                            keyGeneratorFunc: {
                                tableHeaderOrBody: NodeView, idx: Int64 => return "${idx}-${tableHeaderOrBody.nodeHash}-${tableHeaderOrBody.contentHash}"
                            }
                        )
                    }
                    .alignItems(HorizontalAlign.Start)
                }
                .scrollable(ScrollDirection.Horizontal)
                .scrollBar(tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableScrollBarState)
                .scrollBarColor(tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableScrollBarColor)
            }
            .backgroundColor(tableBlockMarkdownConfiguration.markdownTheme.globalTheme.backgroundColor)
            .borderStyle(tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableBorderStyle)
            .borderWidth(tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableBorderWidth)
            .borderColor(tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableBorderColor)
            .borderRadius(topLeft: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableRadiusTopLeft.vp, topRight: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableRadiusTopRight.vp, bottomLeft: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableRadiusBottomLeft.vp, bottomRight: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableRadiusBottomRight.vp)
            .padding(
                top: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tablePaddingTop,
                right: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tablePaddingRight,
                bottom: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tablePaddingBottom,
                left: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tablePaddingLeft
            )
            .margin(
                top: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableMarginTop,
                right: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableMarginRight,
                bottom: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableMarginBottom,
                left: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableMarginLeft
            )
            .clip(true)
        }
    }

    /**
     * 表格控件数据刷新
     * 吸顶模式下：header=children[0], body=children[1:]
     * 非吸顶模式下：全部行在数据源中
     */
    func refreshTableBlockData(newNodeView: NodeView): Unit {
        this.tableBlockNodeView = newNodeView
        let refreshNodeViewChildren = tableBlockNodeView.children
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size
        if (refreshNodeViewSize == 0) {
            tableBlockBodyRows.clear()
            tableBlockCellSize = 0
            cellWidthTracker.resize(0)
            columnWidths = Array<Float64>(0, repeat: 0.0)
            oldStickyRowCount = 0
            return
        }
        var cellSize = 0
        if (refreshNodeViewSize > 0) {
            cellSize = refreshNodeViewChildren[0].children.size
        }
        if (cellSize != tableBlockCellSize) {
            tableBlockCellSize = cellSize
            cellWidthTracker.resize(cellSize)
        }
        if (tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableStickyHeader && useOffsetSticky) {
            tableBlockHeaderNodeView = refreshNodeViewChildren[0]
            let newRowCount = refreshNodeViewSize
            if (newRowCount < oldStickyRowCount) {
                for (i in newRowCount..oldStickyRowCount) {
                    cellWidthTracker.clearRow(i)
                }
            }
            oldStickyRowCount = newRowCount
            updateBodyRows(refreshNodeViewChildren, 1, refreshNodeViewSize)
        } else {
            updateBodyRows(refreshNodeViewChildren, 0, refreshNodeViewSize)
        }
        tableBlockFullText = getFullTableText()
        applyColumnWidths()
    }

    /**
     * 增量更新body行数据
     */
    func updateBodyRows(children: ArrayList<NodeView>, start: Int64, end: Int64): Unit {
        let newLen = end - start
        let oldLen = tableBlockBodyRows.size
        let minLen = if (newLen < oldLen) { newLen } else { oldLen }
        for (i in 0..minLen) {
            let oldNode = tableBlockBodyRows[i]
            let newNode = children[start + i]
            if (oldNode.nodeHash != newNode.nodeHash || oldNode.contentHash != newNode.contentHash) {
                tableBlockBodyRows[i] = newNode
            }
        }
        if (newLen > oldLen) {
            for (i in oldLen..newLen) {
                tableBlockBodyRows.append(children[start + i])
            }
        } else if (oldLen > newLen) {
            for (i in oldLen - 1..=newLen : -1) {
                tableBlockBodyRows.remove(i)
            }
        }
    }

    /**
     * 对比tracker中的列宽与当前@State，仅在变化时更新以避免不必要重渲染
     * 每列宽度 = max(tracker测量值, componentWidth均分值)
     * - tracker有数据时：列宽≥内容最大宽度（列对齐）且≥evenWidth（充满屏幕）
     * - tracker无数据时：列宽=evenWidth（充满屏幕，待cell渲染后tracker更新）
     * - tracker宽度>evenWidth时：列宽=tracker宽度（内容超宽，横向滚动）
     */
    func applyColumnWidths(): Unit {
        let trackerWidths = cellWidthTracker.getWidths()
        let size = trackerWidths.size
        if (size == 0) {
            if (columnWidths.size > 0) {
                columnWidths = Array<Float64>(0, repeat: 0.0)
            }
            return
        }
        let newWidths = Array<Float64>(size, repeat: 0.0)
        for (i in 0..size) {
            newWidths[i] = trackerWidths[i]
        }
        if (tableBlockComponentWidth > 0.0 && size > 0) {
            let evenWidth = tableBlockComponentWidth / Float64(size)
            for (i in 0..size) {
                if (newWidths[i] < evenWidth) {
                    newWidths[i] = evenWidth
                }
            }
        }
        var changed = newWidths.size != columnWidths.size
        var i = 0
        while (!changed && i < size) {
            if (newWidths[i] != columnWidths[i]) {
                changed = true
            }
            i += 1
        }
        if (changed) {
            columnWidths = newWidths
        }
    }

    /**
     * 外层滚动Y变化回调
     */
    func onStickyYChanged(y: Float64): Unit {
        recalculateOffset(y)
    }

    /**
     * 表格位置/高度变化时重新计算偏移
     */
    func onTableAreaChanged(): Unit {
        applyColumnWidths()
        recalculateOffset(stickyHolder.getY())
    }

    /**
     * 控件宽度变化时重新应用列宽
     */
    func onComponentWidthChanged(): Unit {
        applyColumnWidths()
    }

    /**
     * 计算 header 吸顶偏移量并更新 stickyOffset（统一公式，对齐ArkUI MarkdownTable.ets）
     *
     * offset = scrollY - tableYTotal
     *   scrollY < 0：markdown起点尚未到达视口顶部，不吸顶
     *   offset <= 0：表格顶部未滚出视口顶部，不吸顶
     *   upperBound <= 0：表格比吸顶内容短，不吸顶
     *   offset >= upperBound：吸顶内容底部到达表格底部，锁定在upperBound
     *   0 < offset < upperBound：正常吸顶，钉在视口顶部
     *
     * tableYTotal = listItemPositionInList + position.y + blockMarginTop + borderTop + paddingTop
     *   listItemPositionInList = getListItemY(idx) + getListScrollY()（layout-time常量，ListItem在List内容中的绝对位置）
     *   position.y = 表格border box顶在ListItem中的Y（Cangjie onAreaChange，layout-time常量，与ArkUI一致）
     *   blockMarginTop = List的margin（markdown整体上边距）
     *   borderTop + paddingTop = 从border box顶到header所在的content box顶的距离
     *
     * scrollY语义：
     *   外层Scroll模式：页面传递relativeScrollY = scrollY - markdownStartY
     *   内层List模式：onScroll传递List内部scrollY = scroller.currentOffset().yOffset
     */
    func recalculateOffset(scrollY: Float64): Unit {
        if (scrollY < 0.0) {
            stickyOffset = 0.0
            return
        }
        if (tableY == 999999.0 || tableBlockListItemIndex < 0) {
            stickyOffset = 0.0
            return
        }
        let itemY = stickyHolder.getListItemY(tableBlockListItemIndex)
        let listScrollY = stickyHolder.getListScrollY()
        let listItemPositionInList = itemY + listScrollY
        // position.y是border box顶（与ArkUI一致），需加borderTop + paddingTop到content box顶
        let tableYTotal = listItemPositionInList + tableY + blockMarginTopNum + tableBorderTopNum + tablePaddingTopNum
        let offset = scrollY - tableYTotal
        // 上界 = 表格总高度 - borderTop - paddingTop - 吸顶内容高度
        let upperBound = tableHeight - tableBorderTopNum - tablePaddingTopNum - stickyContentHeight
        if (offset <= 0.0 || upperBound <= 0.0) {
            stickyOffset = 0.0
        } else if (offset >= upperBound) {
            stickyOffset = upperBound
        } else {
            stickyOffset = offset
        }
        // [DEBUG] 吸顶调试日志（吸顶激活时输出，便于定位间隙来源）
        if (stickyOffset > 0.0) {
            println("[STICKY-DEBUG] idx=${tableBlockListItemIndex} scrollY=${scrollY} itemY=${itemY} listScrollY=${listScrollY} tableY(position.y)=${tableY} blockMarginTop=${blockMarginTopNum} tableBorderTop=${tableBorderTopNum} tablePaddingTop=${tablePaddingTopNum} tableYTotal=${tableYTotal} offset=${offset} upperBound=${upperBound} stickyOffset=${stickyOffset} tableHeight=${tableHeight} stickyContentHeight=${stickyContentHeight}")
        }
    }

    /**
     * 序列化表格为纯文本
     */
    func getFullTableText(): String {
        let children = tableBlockNodeView.children
        if (children.size == 0) {
            return ""
        }
        var result = ""
        for (i in 0..children.size) {
            let row = children[i]
            for (j in 0..row.children.size) {
                result = result + extractNodeText(row.children[j]) + " "
            }
            result = result + "\n"
        }
        return result
    }

    /**
     * 递归提取NodeView的纯文本
     */
    func extractNodeText(node: NodeView): String {
        var text = node.nodeText
        for (child in node.children) {
            text = text + extractNodeText(child)
        }
        return text
    }
}
