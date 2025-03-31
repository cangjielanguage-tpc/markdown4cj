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
class MarkdownAITableBlockRow2Component {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 表格内容数据
     */
    var nodeViews: ArrayList<NodeView>

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
     * 标识符，第几条表格
     */
    var index: Int64

    /**
     * 第二层的定位标识
     */
    var index2: Int64

    /**
     * 列表第一层定位
     */
    var indexItem: Int64

    var indexRow: Int64


    var tableRow2Components: ArrayList<MarkdownAITableBlockRow2Component>

    var tableCell2Components: ArrayList<MarkdownAITableBlockCell2Component>

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>()

    protected override func aboutToAppear(): Unit {
        size = nodeViews.size
        refreshData(nodeViews)
        tableRow2Components.append(this)
    }

    protected override func aboutToDisappear(): Unit {
        tableRow2Components
            .removeIf(
                {
                    predicate => if (predicate.index == index && predicate.indexRow == indexRow && predicate.index2 == index2
                    && predicate.indexItem == indexItem   &&
                        predicate.size == size) {
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
                    item: NodeView, indexCell: Int64 => if (item.node is TableCell) {
                        MarkdownAITableBlockCell2Component(
                            markdownAIConfiguration: markdownAIConfiguration,
                            nodeViews: item.children,
                            isFull: isFull,
                            isHeader:(item.node as TableCell)().isHeader(),
                            alignment:(item.node as TableCell)().getAlignment(),
                            componentWidth: componentWidth,
                            indexRow: indexRow,
                            index: index,
                            index2: index2,
                            indexItem: indexItem,
                            indexCell: indexCell,
                            tableCell2Components: tableCell2Components
                        )
                    }
                }
            )
        }
        // 设置组件自身的宽度
        .width(100.percent)
    }

    public func refreshData(nodeViews: ArrayList<NodeView>): Unit {
        if (isFull) {
            nodeViewList.clear()
            nodeViewList.appendAll(nodeViews)
        } else {
            if (nodeViews.size == 0) {
                return
            }
            let size = nodeViewList.size
            if (nodeViews.size > size) {
                if (size != 0) {
                    nodeViewList.remove(size - 1)
                    nodeViewList.append(nodeViews[size - 1])
                }
                for (i in nodeViews.size - size..0 : -1) {
                    nodeViewList.append(nodeViews[nodeViews.size - i])
                }
            } else if (nodeViews.size == size) {
                var indexCell: Int64 = 0
                for (i in 0..nodeViews.size) {
                    if (nodeViews[i].children.size != 0) {
                        indexCell = i
                    }
                }
                for (data in tableCell2Components) {
                    if (data.index == index && data.index2 == index2 && data.indexItem == indexItem && data.indexRow == indexRow && data.indexCell == indexCell) {
                        data.refreshData(nodeViews[indexCell].children)
                    }
                }
            } else {
                nodeViewList.remove(nodeViews.size - 1)
                nodeViewList.append(nodeViews[nodeViews.size - 1])
                for (i in size - nodeViews.size..0 : -1) {
                    nodeViewList.remove(size - i)
                }
            }
        }
    }
}
