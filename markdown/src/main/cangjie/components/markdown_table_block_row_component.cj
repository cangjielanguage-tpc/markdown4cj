package markdown.components

import ohos.state_macro_manage.*

/**
 * 表格Row控件
 * 对齐ArkUI MarkdownTableRow.ets：Cell通过@Consume获取columnWidths/cellWidthTracker，无需Row透传
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
    @BuilderParam
    var inlineImageCardComponent: (?String,?String, ?String) -> Unit  //自定义卡片布局行内图片
    @BuilderParam
    var inlineLinkCardComponent: (?String, ?String) -> Unit  //自定义卡片布局行内链接
    var tableBlockRowRow: Int64 // 表格的第几行
    var tableBlockRowCellSize: Int64 // 表格总共有几列
    var tableBlockRowRowSize: Int64 // 表格总共有几行
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
                            tableBlockCellRowSize: tableBlockRowRowSize,
                            inlineImageCardComponent: inlineImageCardComponent,
                            inlineLinkCardComponent: inlineLinkCardComponent
                        )
                    } else {
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
     * @param newNodeView 刷新的新数据
     */
    public func refreshTableBlockRowData(newNodeView: NodeView): Unit {
        this.tableBlockRowNodeView = newNodeView
        let refreshNodeViewChildren = tableBlockRowNodeView.children
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size
        let dataSourceSize: Int64 = tableBlockRowNodeViewList.size
        if (refreshNodeViewSize == 0) {
            tableBlockRowNodeViewList.clear()
            return
        }
        let minLen = if (refreshNodeViewSize < dataSourceSize) { refreshNodeViewSize } else { dataSourceSize }
        for (i in 0..minLen) {
            let oldNode = tableBlockRowNodeViewList[i]
            let newNode = refreshNodeViewChildren[i]
            if (oldNode.nodeHash != newNode.nodeHash || oldNode.contentHash != newNode.contentHash) {
                tableBlockRowNodeViewList[i] = newNode
            }
        }
        if (refreshNodeViewSize > dataSourceSize) {
            for (i in dataSourceSize..refreshNodeViewSize) {
                tableBlockRowNodeViewList.append(refreshNodeViewChildren[i])
            }
        } else if (dataSourceSize > refreshNodeViewSize) {
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                tableBlockRowNodeViewList.remove(i)
            }
        }
    }
}
