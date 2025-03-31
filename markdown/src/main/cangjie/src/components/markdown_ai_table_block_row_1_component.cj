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
class MarkdownAITableBlockRow1Component {
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

    var indexRow: Int64


    var tableRow1Components: ArrayList<MarkdownAITableBlockRow1Component>

    var tableCell1Components: ArrayList<MarkdownAITableBlockCell1Component>

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>()

    protected override func aboutToAppear(): Unit {
        size = nodeViews.size
        refreshData(nodeViews)
        tableRow1Components.append(this)
    }

    protected override func aboutToDisappear(): Unit {
        tableRow1Components
            .removeIf(
                {
                    predicate => if (predicate.index == index && predicate.indexRow == indexRow &&
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
                        MarkdownAITableBlockCell1Component(
                            markdownAIConfiguration: markdownAIConfiguration,
                            nodeViews: item.children,
                            isFull: isFull,
                            isHeader:(item.node as TableCell)().isHeader(),
                            alignment:(item.node as TableCell)().getAlignment(),
                            componentWidth: componentWidth,
                            indexRow: indexRow,
                            index: index,
                            indexCell: indexCell,
                            tableCell1Components: tableCell1Components
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
                for (data in tableCell1Components) {
                    if (data.index == index && data.indexRow == indexRow && data.indexCell == indexCell) {
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
