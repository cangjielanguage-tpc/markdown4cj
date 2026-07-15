package markdown.components

import ohos.state_macro_manage.*

/**
 * 表格控件
 */
@Component
class MarkdownTableBlockComponent {
    var tableBlockMarkdownConfiguration: MarkdownConfiguration // markdown配置
    @Prop
    var tableBlockNodeView: NodeView // 表格控件自身节点
    @State
    var tableBlockComponentWidth: Float64 = 0.0 // 控件宽度 - 单位vp
    @BuilderParam
    var tableBlockCustomTableLineBuilder: (NodeView, Int64) -> Unit // 自定义行内表格Cell控件
    var tableBlockImageCallback: (String) -> Unit // 图片点击事件
    var tableBlockFootnoteCallback: (String) -> Unit // 脚注点击事件
    @State
    var tableBlockCellSize: Int64 = 0 // 表格总共有几列
    @State
    var cellWidthArrayIndexed: ObservedArrayList<CellWidthArrayIndexedClass> = ObservedArrayList<CellWidthArrayIndexedClass>() // 表格宽度列表
    var tableBlockNodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>()) // 懒加载数据源
    var tableBlockStickyHolder: ?StickyScrollYHolder = None // 吸顶滚动Y持有者
    var stickyListenerId: Int64 = -1 // 吸顶监听器ID（用于removeListener）
    @State
    var tableBlockHeaderNodeView: NodeView = NodeView() // 吸顶模式下的标题行数据
    @State
    var tableBlockFullText: String = "" // 表格序列化的纯文本（用于复制按钮）
    let headerScroller: Scroller = Scroller() // 吸顶模式header横向Scroll控制器
    let bodyScroller: Scroller = Scroller() // 吸顶模式body横向Scroll控制器
    let syncManager: TableHorizontalScrollSync = TableHorizontalScrollSync() // header/body横向滚动同步器
    var tableY: Float64 = 999999.0 // 表格在父容器中的Y位置（onAreaChange获取）
    var tableHeight: Float64 = 0.0 // 表格总高度（onAreaChange获取）
    var stickyContentHeight: Float64 = 0.0 // 吸顶内容总高度（header高度，onAreaChange获取）
    var tablePaddingTopNum: Float64 = 0.0 // tablePaddingTop的数值
    var tableBorderTopNum: Float64 = 0.0 // tableBorderWidth的数值
    @State
    var stickyOffset: Float64 = 0.0 // 吸顶偏移量

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(tableBlockNodeView.nodeHash, refreshTableBlockData)
        let isSticky = tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableStickyHeader && tableBlockStickyHolder.isSome()
        if (isSticky) {
            syncManager.registerHeader(headerScroller)
            syncManager.registerBody(bodyScroller)
            if (let Some(holder) <- tableBlockStickyHolder) {
                stickyListenerId = holder.addListener(onStickyYChanged)
            }
        }
        refreshTableBlockData(tableBlockNodeView)
    }

    protected override func aboutToDisappear(): Unit {
        MarkdownRefreshRegistry.unregister(tableBlockNodeView.nodeHash)
        let isSticky = tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableStickyHeader && tableBlockStickyHolder.isSome()
        if (isSticky) {
            syncManager.unregisterHeader()
            syncManager.unregisterBody()
            syncManager.reset()
            if (let Some(holder) <- tableBlockStickyHolder) {
                holder.removeListener(stickyListenerId)
            }
        }
    }

    func build() {
        if (tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableStickyHeader && tableBlockStickyHolder.isSome()) {
            // 吸顶模式：Column(header offset吸顶 + body)
            Column {
                // 吸顶header
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
                            tableBlockRowNodeView: tableBlockHeaderNodeView,
                            tableBlockRowComponentWidth: tableBlockComponentWidth,
                            tableBlockRowCustomTableLineBuilder: tableBlockCustomTableLineBuilder,
                            tableBlockRowImageCallback: tableBlockImageCallback,
                            tableBlockRowFootnoteCallback: tableBlockFootnoteCallback,
                            tableBlockRowRow: 0,
                            tableBlockRowCellSize: tableBlockCellSize,
                            cellWidthArrayIndexed: cellWidthArrayIndexed
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
                .interopOnSizeChange({
                    old, new =>
                        this.stickyContentHeight = new.height
                        onTableAreaChanged()
                })
                // body
                Scroll(bodyScroller) {
                    List() {
                        LazyForEach(
                            tableBlockNodeViewDataSource,
                            itemGeneratorFunc: {
                                nodeView: NodeView, idRow: Int64 => if (nodeView.nodeType == "TableRow") {
                                    // 表格Row
                                    ListItem() {
                                        MarkdownTableBlockRowComponent(
                                            tableBlockRowMarkdownConfiguration: tableBlockMarkdownConfiguration,
                                            tableBlockRowNodeView: nodeView,
                                            tableBlockRowComponentWidth: tableBlockComponentWidth,
                                            tableBlockRowCustomTableLineBuilder: tableBlockCustomTableLineBuilder,
                                            tableBlockRowImageCallback: tableBlockImageCallback,
                                            tableBlockRowFootnoteCallback: tableBlockFootnoteCallback,
                                            tableBlockRowRow: idRow + 1,
                                            tableBlockRowCellSize: tableBlockCellSize,
                                            cellWidthArrayIndexed: cellWidthArrayIndexed
                                        )
                                    }
                                } else {
                                    ListItem() {
                                        Text("")
                                    }
                                }
                            },
                            keyGeneratorFunc: {
                                tableHeaderOrBody: NodeView, idx: Int64 => return "${idx}-${tableHeaderOrBody.nodeHash}-${tableHeaderOrBody.contentHash}"
                            }
                        )
                    }
                    .borderStyle(tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableBorderStyle)
                    .borderWidth(tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableBorderWidth)
                    .borderColor(tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableBorderColor)
                    .borderRadius(topLeft: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableRadiusTopLeft.vp, topRight: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableRadiusTopRight.vp, bottomLeft: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableRadiusBottomLeft.vp, bottomRight: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableRadiusBottomRight.vp)
                    .alignListItem(ListItemAlign.Start)
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
            .onAreaChange({
                old, new =>
                    this.tablePaddingTopNum = tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tablePaddingTop
                    this.tableBorderTopNum = tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableBorderWidth
                    this.tableY = new.position.y
                    this.tableHeight = new.height
                    onTableAreaChanged()
            })
        } else {
            // 非吸顶模式：Column(标题 + Scroll > List > LazyForEach)
            Column {
                if (tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableHeadIsShow) {
                    MarkdownTableTitleComponent(
                        tableTitleMarkdownConfiguration: tableBlockMarkdownConfiguration,
                        tableTitleFullText: tableBlockFullText
                    )
                }
                Scroll() {
                    List() {
                        LazyForEach(
                            tableBlockNodeViewDataSource,
                            itemGeneratorFunc: {
                                nodeView: NodeView, idRow: Int64 => if (nodeView.nodeType == "TableRow") {
                                    // 表格Row
                                    ListItem() {
                                        MarkdownTableBlockRowComponent(
                                            tableBlockRowMarkdownConfiguration: tableBlockMarkdownConfiguration,
                                            tableBlockRowNodeView: nodeView,
                                            tableBlockRowComponentWidth: tableBlockComponentWidth,
                                            tableBlockRowCustomTableLineBuilder: tableBlockCustomTableLineBuilder,
                                            tableBlockRowImageCallback: tableBlockImageCallback,
                                            tableBlockRowFootnoteCallback: tableBlockFootnoteCallback,
                                            tableBlockRowRow: idRow,
                                            tableBlockRowCellSize: tableBlockCellSize,
                                            cellWidthArrayIndexed: cellWidthArrayIndexed
                                        )
                                    }
                                } else {
                                    ListItem() {
                                        Text("")
                                    }
                                }
                            },
                            keyGeneratorFunc: {
                                tableHeaderOrBody: NodeView, idx: Int64 => return "${idx}-${tableHeaderOrBody.nodeHash}-${tableHeaderOrBody.contentHash}"
                            }
                        )
                    }
                    .borderStyle(tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableBorderStyle)
                    .borderWidth(tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableBorderWidth)
                    .borderColor(tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableBorderColor)
                    .borderRadius(topLeft: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableRadiusTopLeft.vp, topRight: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableRadiusTopRight.vp, bottomLeft: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableRadiusBottomLeft.vp, bottomRight: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableRadiusBottomRight.vp)
                    .alignListItem(ListItemAlign.Start)
                }
                .scrollable(ScrollDirection.Horizontal)
                .scrollBar(tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableScrollBarState)
                .scrollBarColor(tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableScrollBarColor)
            }
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
        }
    }

    /**
     * 表格控件数据刷新
     * 吸顶模式下：header=children[0], body=children[1:]
     * 非吸顶模式下：全部行在数据源中
     *
     * @param newNodeView 刷新的新数据
     */
    func refreshTableBlockData(newNodeView: NodeView): Unit {
        this.tableBlockNodeView = newNodeView
        let refreshNodeViewChildren = tableBlockNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        if (refreshNodeViewSize == 0) {
            tableBlockNodeViewDataSource.clear()
            return
        }
        var cellSize = 0 // 表格总共有几列
        if (refreshNodeViewSize > 0) {
            cellSize = refreshNodeViewChildren[0].children.size
        }
        if (cellSize != tableBlockCellSize) {
            cellWidthArrayIndexed.clear()
            tableBlockCellSize = cellSize
            createListCellWidth()
        }
        let isSticky = tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableStickyHeader && tableBlockStickyHolder.isSome()
        if (isSticky) {
            // 吸顶模式：header = children[0], body = children[1:]
            tableBlockHeaderNodeView = refreshNodeViewChildren[0]
            let bodyRows = ArrayList<NodeView>()
            for (i in 1..refreshNodeViewSize) {
                bodyRows.add(refreshNodeViewChildren[i])
            }
            // 增量对比hash更新body数据源
            tableBlockNodeViewDataSource.smartUpdateDataArray(bodyRows)
        } else {
            // 非吸顶模式：全部行
            tableBlockNodeViewDataSource.smartUpdateDataArray(refreshNodeViewChildren)
        }
        tableBlockFullText = getFullTableText()
    }

    /**
     * 创建表格格子最小宽度的最大值列表
     */
    func createListCellWidth() {
        for (i in 0..tableBlockCellSize) {
            cellWidthArrayIndexed.append(CellWidthArrayIndexedClass(minWidth: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableMinCellWidth, index: i))
        }
    }

    /**
     * 外层滚动Y变化回调
     * 由StickyScrollYHolder调用，计算吸顶偏移量并更新stickyOffset
     *
     * @param y 当前滚动Y值
     */
    func onStickyYChanged(y: Float64): Unit {
        recalculateOffset(y)
    }

    /**
     * 表格位置/高度变化时重新计算偏移
     */
    func onTableAreaChanged(): Unit {
        if (let Some(holder) <- tableBlockStickyHolder) {
            recalculateOffset(holder.getY())
        }
    }

    /**
     * 计算header吸顶偏移量并更新stickyOffset
     * - offset <= 0：表格未滚出视口，不吸顶
     * - upperBound <= 0：表格比吸顶内容短，不吸顶
     * - offset >= upperBound：吸顶内容底部到达表格底部，锁定在upperBound
     * - 0 < offset < upperBound：正常吸顶，钉在视口顶部
     *
     * @param scrollY 当前外层滚动Y值
     */
    func recalculateOffset(scrollY: Float64): Unit {
        if (scrollY < 0.0 || tableY == 999999.0) {
            stickyOffset = 0.0
            return
        }
        let offset = scrollY - tableY
        let upperBound = tableHeight - tableBorderTopNum - tablePaddingTopNum - stickyContentHeight
        if (offset <= 0.0 || upperBound <= 0.0) {
            stickyOffset = 0.0
        } else if (offset >= upperBound) {
            stickyOffset = upperBound
        } else {
            stickyOffset = offset
        }
    }

    /**
     * 序列化表格为纯文本
     * 每行的单元格用制表符(\t)分隔，行与行用换行符(\n)分隔
     *
     * @return 表格纯文本
     */
    func getFullTableText(): String {
        let children = tableBlockNodeView.children
        if (children.size == 0) {
            return ""
        }
        var result = ""
        for (i in 0..children.size) {
            if (i > 0) {
                result = result + "\n"
            }
            let row = children[i]
            for (j in 0..row.children.size) {
                if (j > 0) {
                    result = result + "\t"
                }
                result = result + extractNodeText(row.children[j])
            }
        }
        return result
    }

    /**
     * 递归提取NodeView的纯文本
     *
     * @param node 节点
     * @return 节点及其所有子节点的文本拼接
     */
    func extractNodeText(node: NodeView): String {
        var text = node.nodeText
        for (child in node.children) {
            text = text + extractNodeText(child)
        }
        return text
    }
}
