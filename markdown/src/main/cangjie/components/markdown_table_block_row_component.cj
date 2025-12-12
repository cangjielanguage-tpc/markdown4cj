/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown表格自定义控件
 */
@Component
class MarkdownTableBlockRowComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 表格内容数据
     */
    var nodeView: NodeView

    /**
     * 控件宽度 - 单位px
     */
    @Prop
    var componentWidth: Float64

    /**
     * 内容第几条
     */
    var idRow: Int64

    /**
     * 表格有几行
     */
    var dataRowSize: Int64

    /**
     * 缓存的表格行
     */
    var tableRowComponents: HashMap<Int64, MarkdownTableBlockRowComponent>

    /**
     * 缓存的表格行内格子
     */
    var tableCellComponents: HashMap<Int64, MarkdownTableBlockCellComponent>

    /**
     * 脚注点击事件
     */
    var fontCallback: (String) -> Unit

    /**
     * 图片点击事件
     */
    var imageCallback: (String) -> Unit

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>()

    /**
     * 宽度列表
     */
    @Prop
    var cellWidthArrayIndexed: ObservedArrayList<CellWidthArrayIndexedClass>

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeView)
        // 缓存当前控件
        tableRowComponents.add(this.nodeView.nodeHash, this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = tableRowComponents.get(this.nodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                tableRowComponents.remove(this.nodeView.nodeHash)
            }
        } else {
            tableRowComponents.remove(this.nodeView.nodeHash)
        }
    }

    func build() {
        Row() {
            ForEach(
                nodeViewList,
                itemGeneratorFunc: {
                    item: NodeView, idxItem: Int64 => if (item.node is TableCell) {
                        MarkdownTableBlockCellComponent(
                            markdownConfiguration: markdownConfiguration,
                            nodeView: item,
                            fontCallback: fontCallback,
                            imageCallback: imageCallback,
                            isHeader: (item.node as TableCell)().isHeader(),
                            alignment: (item.node as TableCell)().getAlignment(),
                            componentWidth: componentWidth,
                            idRow: idRow,
                            tableCellComponents: tableCellComponents,
                            dataRowSize: dataRowSize,
                            idxItem: idxItem,
                            dataCellSize: nodeViewList.size,
                            cellWidthArrayIndexed: cellWidthArrayIndexed
                        )
                    }
                },
                keyGeneratorFunc: {
                    item: NodeView, idx: Int64 => return "${idx}-${item.nodeHash}-${item.contentHash}"
                }
            )
        }
    }

    /**
     * 数据刷新
     */
    public func refreshData(nodeView: NodeView): Unit {
        this.nodeView = nodeView
        let refreshNodeViews: ArrayList<NodeView> = nodeView.children
        let refreshNodeViewSize: Int64 = refreshNodeViews.size // 刷新进来的数据长度
        let nodeViewListSize: Int64 = nodeViewList.size // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        refreshnodeViewList(this.nodeView, nodeViewList, tableCellComponents)
    }
}
