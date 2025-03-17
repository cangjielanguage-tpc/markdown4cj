/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

class TableRowAI1Data {
    var component: MarkdownAITableBlockRow1Component
    var index: Int64
    var indexRow: Int64

    init(component: MarkdownAITableBlockRow1Component, index: Int64,indexRow: Int64) {
        this.component = component
        this.index = index
        this.indexRow = indexRow
    }
}


/**
 * Markdown表格自定义控件
 */
@Component
class MarkdownAITableBlockRow1Component {
    /**
     * markdown配置
     */
    @Prop
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 表格tableNodeView
     */
    @Prop
    var nodeView: NodeView

    /**
     * 控件宽度 - 单位px
     */
    @Prop
    var componentWidth: Float64

    /**
     * 是否全量加载
     */
    @Prop
    var isFull: Bool

    /**
     * 标识符，第几条表格
     */
    @Prop
    var index: Int64

    @Prop
    var indexRow: Int64

    @Prop
    var markdownAICacheConfiguration: MarkdownAICacheConfiguration

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>()

    protected override func aboutToAppear(): Unit {
        refreshData(nodeView)
        markdownAICacheConfiguration.tableRow1Components.append(TableRowAI1Data(this, index,indexRow))
    }

    protected override func aboutToDisappear(): Unit {
        markdownAICacheConfiguration
            .tableRow1Components
            .removeIf(
                {
                    predicate => if (predicate.index == index && predicate.indexRow == indexRow && predicate.component.nodeView.children.size == nodeView
                        .children
                        .size) {
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
                        MarkdownAITableBlockCell1Component(nodeView: item, indexRow: indexRow, index: index,
                            indexCell: indexCell, isFull: isFull, markdownAIConfiguration: markdownAIConfiguration,
                            componentWidth: componentWidth, markdownAICacheConfiguration: markdownAICacheConfiguration)
                    }
                }
            )
        }
            // 设置组件自身的宽度
            .width(100.percent)
    }

    public func refreshData(nodeView: NodeView): Unit {
        let nodeViews = nodeView.children
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
                for(i in 0..nodeViews.size){
                    if(nodeViews[i].children.size != 0){
                        indexCell = i
                    }
                }
                for (data in markdownAICacheConfiguration.tableCell1Components) {
                    if (data.index == index && data.indexRow == indexRow && data.indexCell == indexCell) {
                        data.component.refreshData(nodeViews[indexCell])
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
