/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
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
class MarkdownAITableBlockRowComponent {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 表格内容数据
     */
    var nodeViews: ArrayList<NodeView>

    /**
     * 定位需要的数组
     */
    var indexList: ArrayList<Int64> = ArrayList<Int64>()

    /**
     * 长度
     */
    var size: Int64 = -1

    /**
     * 控件宽度 - 单位px
     */
    var componentWidth: Float64

    /**
     * 是否全量加载
     */
    var isFull: Bool

    /**
     * 内容第几条
     */
    var idRow: Int64

    /**
     * 表格有几行
     */
    var dataRowSize: Int64

    var tableRowComponents: ArrayList<MarkdownAITableBlockRowComponent>

    var tableCellComponents: ArrayList<MarkdownAITableBlockCellComponent>

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

    @Prop
    var cellWidthArrayIndexed: ObservedArrayList<CellWidthArrayIndexedClass>

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeViews)
        // 缓存当前控件
        tableRowComponents.append(this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        tableRowComponents.removeIf(
            {
                predicate => if (predicate.indexList == indexList && predicate.size == size) {
                    true
                } else {
                    false
                }
            })
    }

    func build() {
        Row() {
            ForEach(
                nodeViewList,
                itemGeneratorFunc: {
                    item: NodeView, idxItem: Int64 => if (item.node is TableCell) {
                        MarkdownAITableBlockCellComponent(
                            markdownAIConfiguration: markdownAIConfiguration,
                            nodeViews: item.children,
                            fontCallback: fontCallback,
                            imageCallback: imageCallback,
                            isFull: isFull,
                            isHeader: (item.node as TableCell)().isHeader(),
                            alignment: (item.node as TableCell)().getAlignment(),
                            componentWidth: componentWidth,
                            indexList: indexAdd(indexList, idxItem),
                            idRow: idRow,
                            tableCellComponents: tableCellComponents,
                            dataRowSize: dataRowSize,
                            idxItem: idxItem,
                            dataCellSize: nodeViewList.size,
                            cellWidthArrayIndexed: cellWidthArrayIndexed
                        )
                    }
                }
            )
        }
    }

    /**
     * 数据刷新
     */
    public func refreshData(refreshNodeViews: ArrayList<NodeView>): Unit {
        let refreshNodeViewSize: Int64 = refreshNodeViews.size // 刷新进来的数据长度
        let nodeViewListSize: Int64 = nodeViewList.size // 页面缓存的数据长度
        if (isFull) {
            // 全量加载
            nodeViewList.clear()
            nodeViewList.appendAll(refreshNodeViews)
        } else {
            // 增量加载
            if (refreshNodeViewSize == 0) {
                return
            }
            if (refreshNodeViewSize > nodeViewListSize) {
                // 刷新数据的长度大于页面数据长度，需要添加数据
                if (nodeViewListSize != 0) {
                    // 更新页面最后一条数据
                    nodeViewList.remove(nodeViewListSize - 1)
                    nodeViewList.append(refreshNodeViews[nodeViewListSize - 1])
                }
                // 循环添加所有新增数据
                for (i in refreshNodeViewSize - nodeViewListSize..0 : -1) {
                    nodeViewList.append(refreshNodeViews[refreshNodeViewSize - i])
                }
            } else if (refreshNodeViewSize == nodeViewListSize) {
                // 刷新数据的长度等于页面数据长度，需要更新当前数据
                var indexCell: Int64 = 0
                for (i in 0..refreshNodeViewSize) {
                    if (refreshNodeViews[i].children.size != 0) {
                        indexCell = i
                    }
                }
                for (data in tableCellComponents) {
                    if (isListItem(indexList, data.indexList, indexCell)) {
                        data.refreshData(refreshNodeViews[indexCell].children)
                    }
                }
            } else {
                // 刷新数据小于页面数据长度，需要删除数据
                // 更新页面中间一条数据 - 刷新数据长度的最后一条数据
                nodeViewList.remove(refreshNodeViewSize - 1)
                nodeViewList.append(refreshNodeViews[refreshNodeViewSize - 1])
                // 循环删除所有多余数据
                for (i in nodeViewListSize - refreshNodeViewSize..0 : -1) {
                    nodeViewList.remove(nodeViewListSize - i)
                }
            }
        }
        size = nodeViewList.size // 更新列表长度
    }
}
