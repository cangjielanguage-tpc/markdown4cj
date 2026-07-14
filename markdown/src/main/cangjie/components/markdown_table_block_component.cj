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

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(tableBlockNodeView.nodeHash, refreshTableBlockData)
        refreshTableBlockData(tableBlockNodeView)
    }

    protected override func aboutToDisappear(): Unit {
        MarkdownRefreshRegistry.unregister(tableBlockNodeView.nodeHash)
    }

    func build() {
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

    /**
     * 表格控件数据刷新
     *
     * @param tableBlockRowNodeView 刷新的新数据
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
        // 增量对比hash更新数据源
        tableBlockNodeViewDataSource.smartUpdateDataArray(refreshNodeViewChildren)
    }

    /**
     * 创建表格格子最小宽度的最大值列表
     */
    func createListCellWidth() {
        for (i in 0..tableBlockCellSize) {
            cellWidthArrayIndexed.append(CellWidthArrayIndexedClass(minWidth: tableBlockMarkdownConfiguration.markdownTheme.tableTheme.tableMinCellWidth, index: i))
        }
    }
}
