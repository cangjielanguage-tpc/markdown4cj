package markdown.components

import ohos.state_macro_manage.*

/**
 * 表格控件
 */
@Component
class MarkdownTableBlockComponent {
    /**
     * markdown配置
     */
    var tableBlockMarkdownConfiguration: MarkdownConfiguration

    /**
     * 表格控件自身节点
     */
    @Prop
    var tableBlockNodeView: NodeView

    /**
     * 控件宽度 - 单位vp
     */
    @State
    var tableBlockComponentWidth: Float64 = 0.0

    /**
     * 缓存的表格控件数据
     */
    var tableComponents: HashMap<Int64, MarkdownTableBlockComponent>

    /**
     * 缓存的表格Row控件数据
     */
    var tableRowComponents: HashMap<Int64, MarkdownTableBlockRowComponent>

    /**
     * 缓存的表格Cell控件数据
     */
    var tableCellComponents: HashMap<Int64, MarkdownTableBlockCellComponent>

    /**
     * 自定义行内表格Cell控件
     */
    @BuilderParam
    var tableBlockCustomTableLineBuilder: (NodeView, Int64) -> Unit

    /**
     * 图片点击事件
     */
    var tableBlockImageCallback: (String) -> Unit

    /**
     * 脚注点击事件
     */
    var tableBlockFootnoteCallback: (String) -> Unit

    /**
     * 表格总共有几列
     */
    @State
    var tableBlockCellSize: Int64 = 0

    /**
     * 表格宽度列表
     */
    @State
    var cellWidthArrayIndexed: ObservedArrayList<CellWidthArrayIndexedClass> = ObservedArrayList<CellWidthArrayIndexedClass>()

    /**
     * 懒加载数据源
     */
    var tableBlockNodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        refreshTableBlockData(tableBlockNodeView) // 初始化刷新数据
        tableComponents.add(tableBlockNodeView.nodeHash, this) // 缓存当前控件
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = tableComponents.get(tableBlockNodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                tableComponents.remove(tableBlockNodeView.nodeHash)
            }
        } else {
            tableComponents.remove(tableBlockNodeView.nodeHash)
        }
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
                                    tableBlockRowComponents: tableRowComponents,
                                    tableBlockCellComponents: tableCellComponents,
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
            .border(width: tableBlockMarkdownConfiguration.markdownTheme.tableBorderWidth.vp, color: tableBlockMarkdownConfiguration.markdownTheme.tableBorderColor, style: BorderStyle.Solid, radius: tableBlockMarkdownConfiguration.markdownTheme.tableRadius.vp)
            .alignListItem(ListItemAlign.Start)
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(if (tableBlockMarkdownConfiguration.markdownTheme.tableScrollBarShow) { BarState.Auto } else { BarState.Off })
        .scrollBarColor(tableBlockMarkdownConfiguration.markdownTheme.tableScrollBarColor)
        .padding(left: tableBlockMarkdownConfiguration.markdownTheme.tableBorderWidth, right: tableBlockMarkdownConfiguration.markdownTheme.tableBorderWidth)
    }

    /**
     * 表格控件数据刷新
     *
     * @param tableBlockRowNodeView 刷新的新数据
     */
    func refreshTableBlockData(tableBlockNodeView: NodeView): Unit {
        this.tableBlockNodeView = tableBlockNodeView
        let refreshNodeViewChildren = tableBlockNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = tableBlockNodeViewDataSource.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
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
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            refreshTableBlockDatas(dataSourceSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                tableBlockNodeViewDataSource.addData(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            refreshTableBlockDatas(dataSourceSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
        } else {
            // 新数据小于页面数据
            refreshTableBlockDatas(refreshNodeViewSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
            // 循环删除多余的旧数据
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                tableBlockNodeViewDataSource.deleteData(i)
            }
        }
    }

    /**
     * 循环判断历史数据有没有做过修改
     *
     * @param size 长度
     * @param refreshNodeViews 刷新的数据
     */
    func refreshTableBlockDatas(size: Int64, refreshNodeViews: ArrayList<NodeView>): Unit {
        for (i in 0..size) {
            let refreshNodeView = refreshNodeViews[i]
            let dataSourceNode = tableBlockNodeViewDataSource.getData(i)
            let newNodeHash = refreshNodeView.nodeHash
            let oldNodeHash = dataSourceNode.nodeHash
            if (newNodeHash != oldNodeHash) {
                // 自身节点唯一ID不相同需要刷新数据
                tableBlockNodeViewDataSource.replaceData(i, refreshNodeView)
                continue
            }
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            if (newContentHash != oldContentHash) {
                // 子节点唯一ID不相同需要刷新子节点数据
                if (refreshNodeView.nodeType == "TableRow") {
                    // 表格Row节点
                    let cache = tableRowComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshTableBlockRowData(refreshNodeView)
                        tableBlockNodeViewDataSource.update(i, refreshNodeView)
                    } else {
                        tableBlockNodeViewDataSource.replaceData(i, refreshNodeView)
                    }
                    continue
                }
                // 其他节点
                tableBlockNodeViewDataSource.replaceData(i, refreshNodeView)
            }
        }
    }

    /**
     * 创建表格格子最小宽度的最大值列表
     */
    func createListCellWidth() {
        for (i in 0..tableBlockCellSize) {
            cellWidthArrayIndexed.append(CellWidthArrayIndexedClass(minWidth: tableBlockMarkdownConfiguration.markdownTheme.tableMinTextWidth, index: i))
        }
    }
}
