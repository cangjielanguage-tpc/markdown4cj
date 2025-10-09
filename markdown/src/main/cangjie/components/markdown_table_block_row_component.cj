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
     * 内容第几条
     */
    var idRow: Int64

    /**
     * 表格有几行
     */
    var dataRowSize: Int64

    var tableRowComponents: ArrayList<MarkdownTableBlockRowComponent>

    var tableCellComponents: ArrayList<MarkdownTableBlockCellComponent>

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

    @State
    var maxHeight: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeViews)
        // 缓存当前控件
        tableRowComponents.add(this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        tableRowComponents.removeIf({
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
                        MarkdownTableBlockCellComponent(
                            markdownConfiguration: markdownConfiguration,
                            nodeViews: item.children,
                            fontCallback: fontCallback,
                            imageCallback: imageCallback,
                            isHeader: (item.node as TableCell)().isHeader(),
                            alignment: (item.node as TableCell)().getAlignment(),
                            componentWidth: componentWidth,
                            indexList: indexAdd(indexList, idxItem),
                            idRow: idRow,
                            tableCellComponents: tableCellComponents,
                            dataRowSize: dataRowSize,
                            idxItem: idxItem,
                            dataCellSize: nodeViewList.size,
                            cellWidthArrayIndexed: cellWidthArrayIndexed,
                            maxHeight: maxHeight
                        )
                    }
                },
                keyGeneratorFunc: {
                    item: NodeView, idx: Int64 => return "${idx}-${getProp<Int64>(item, "nodeid", 0)}"
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
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > nodeViewListSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..nodeViewListSize) {
                if (getProp<Int64>(refreshNodeViews[i], "nodeid", 0) != getProp<Int64>(nodeViewList[i], "nodeid", 0)) {
                    nodeViewList[i] = refreshNodeViews[i]
                }
            }
            // 循环添加新数据
            for (i in nodeViewListSize..refreshNodeViewSize) {
                nodeViewList.append(refreshNodeViews[i])
            }
        } else if (refreshNodeViewSize == nodeViewListSize) {
            // 刷新数据的长度等于页面数据长度，需要更新当前数据
            var indexCell: Int64 = 0
            for (i in 0..refreshNodeViewSize) {
                if (refreshNodeViews[i].children.size != 0) {
                    indexCell = i
                }
            }
            for (i in 0..indexCell) {
                if (getProp<Int64>(refreshNodeViews[i], "nodeid", 0) != getProp<Int64>(nodeViewList[i], "nodeid", 0)) {
                    nodeViewList[i] = refreshNodeViews[i]
                }
            }
            for (data in tableCellComponents) {
                if (isListItem(indexList, data.indexList, indexCell)) {
                    data.refreshData(refreshNodeViews[indexCell].children)
                }
            }
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..refreshNodeViewSize) {
                if (getProp<Int64>(refreshNodeViews[i], "nodeid", 0) != getProp<Int64>(nodeViewList[i], "nodeid", 0)) {
                    nodeViewList[i] = refreshNodeViews[i]
                }
            }
            // 循环删除多余的旧数据
            for (i in nodeViewListSize - 1..=refreshNodeViewSize : -1) {
                nodeViewList.remove(i)
            }
        }
        size = nodeViewList.size // 更新列表长度
    }
}
