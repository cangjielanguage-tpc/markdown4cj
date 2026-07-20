package markdown.components

import ohos.state_macro_manage.*

/**
 * 表格Row控件
 */
@Component
class MarkdownTableBlockRowComponent {
    @Prop
    var tableBlockRowMarkdownConfiguration: MarkdownConfiguration // markdown配置
    @Prop
    var tableBlockRowNodeView: NodeView // 表格Row控件自身节点
    @Prop
    var tableBlockRowComponentWidth: Float64 // 控件宽度 - 单位vp
    @BuilderParam
    var tableBlockRowCustomTableLineBuilder: (NodeView, Int64) -> Unit // 自定义行内表格Cell控件
    var tableBlockRowImageCallback: (String) -> Unit // 图片点击事件
    var tableBlockRowFootnoteCallback: (String) -> Unit // 脚注点击事件
    var tableBlockRowRow: Int64 // 表格的第几行
    var tableBlockRowCellSize: Int64 // 表格总共有几列
    var cellWidthArrayIndexed: ObservedArrayList<CellWidthArrayIndexedClass> // 表格宽度列表（共享引用，传递给Cell）
    @State
    var tableBlockRowNodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>() // UI数据源

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(tableBlockRowNodeView.nodeHash, refreshTableBlockRowData)
        refreshTableBlockRowData(tableBlockRowNodeView)
    }

    protected override func aboutToDisappear(): Unit {
        MarkdownRefreshRegistry.unregister(tableBlockRowNodeView.nodeHash)
    }

    func build() {
        Row() {
            ForEach(
                tableBlockRowNodeViewList,
                itemGeneratorFunc: {
                    nodeview: NodeView, idx: Int64 => if (nodeview.nodeType == "TableCell") {
                        // 表格Cell节点
                        MarkdownTableBlockCellComponent(
                            tableBlockCellMarkdownConfiguration: tableBlockRowMarkdownConfiguration,
                            tableBlockCellNodeView: nodeview,
                            tableBlockCellComponentWidth: tableBlockRowComponentWidth,
                            tableBlockCellCustomTableLineBuilder: tableBlockRowCustomTableLineBuilder,
                            tableBlockCellImageCallback: tableBlockRowImageCallback,
                            tableBlockCellFootnoteCallback: tableBlockRowFootnoteCallback,
                            tableBlockCellRow: tableBlockRowRow,
                            tableBlockCellCell: idx,
                            tableBlockCellCellSize: tableBlockRowCellSize,
                            cellWidthArrayIndexed: cellWidthArrayIndexed,
                        )
                    } else {
                        // 其他节点
                        Text("")
                    }
                },
                keyGeneratorFunc: {
                    nodeview: NodeView, idx: Int64 => return "${idx}-${nodeview.nodeHash}-${nodeview.contentHash}"
                }
            )
        }
        .backgroundColor(tableBlockRowMarkdownConfiguration.markdownTheme.globalTheme.backgroundColor)
    }

    /**
     * 表格Row控件数据刷新
     *
     * @param tableBlockRowNodeView 刷新的新数据
     */
    public func refreshTableBlockRowData(newNodeView: NodeView): Unit {
        this.tableBlockRowNodeView = newNodeView
        let refreshNodeViewChildren = tableBlockRowNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = tableBlockRowNodeViewList.size // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            tableBlockRowNodeViewList.clear()
            return
        }
        // 对比重叠区间，hash变化时替换数据
        let minLen = if (refreshNodeViewSize < dataSourceSize) { refreshNodeViewSize } else { dataSourceSize }
        for (i in 0..minLen) {
            let oldNode = tableBlockRowNodeViewList[i]
            let newNode = refreshNodeViewChildren[i]
            if (oldNode.nodeHash != newNode.nodeHash || oldNode.contentHash != newNode.contentHash) {
                // 自身节点或子节点唯一ID不相同需要刷新数据
                tableBlockRowNodeViewList[i] = newNode
            }
        }
        // 新增部分
        if (refreshNodeViewSize > dataSourceSize) {
            for (i in dataSourceSize..refreshNodeViewSize) {
                tableBlockRowNodeViewList.append(refreshNodeViewChildren[i])
            }
        } else if (dataSourceSize > refreshNodeViewSize) {
            // 删除多余部分（从后往前删，避免索引移位）
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                tableBlockRowNodeViewList.remove(i)
            }
        }
    }
}
