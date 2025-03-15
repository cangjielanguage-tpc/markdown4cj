/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

class TableAIData {
    var component: MarkdownAITableBlock1Component
    var index: Int64

    init(component: MarkdownAITableBlock1Component, index: Int64) {
        this.component = component
        this.index = index
    }
}

/**
 * Markdown表格自定义控件
 */
@Component
class MarkdownAITableBlock1Component {
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
     * 外边距 - 上面
     */
    @Prop
    var marginTop: Float64

    /**
     * 外边距 - 下面
     */
    @Prop
    var marginBottom: Float64

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
    var markdownAICacheConfiguration: MarkdownAICacheConfiguration

    /**
     * 异步加载的图片数据
     */
    @State
    var arrayListPixelMap: ObservedArrayList<ImageData> = ObservedArrayList<ImageData>()

    /**
     * 缓存的图片列表
     */
    var listPixelMap: ArrayList<?PixelMap> = ArrayList<?PixelMap>()

    /**
     * 线程列表
     */
    var futs: ArrayList<?Future<Unit>> = ArrayList<?Future<Unit>>()

    /**
     * 懒加载数据源
     */
    var nodeViewAIDataSource: NodeViewAIDataSource = NodeViewAIDataSource(ArrayList<NodeView>())

    /**
     * 列表数据
     */
    let nodeViews: ArrayList<NodeView> = ArrayList<NodeView>()

    protected override func aboutToAppear(): Unit {
        refreshData(nodeView)
        markdownAICacheConfiguration.tableComponents.append(TableAIData(this, index))
    }

    protected override func aboutToDisappear(): Unit {
        markdownAICacheConfiguration
            .tableComponents
            .removeIf(
                {
                    predicate => if (predicate.index == index && predicate.component.nodeView.children.size == nodeView
                        .children
                        .size) {
                        true
                    } else {
                        false
                    }
                })
    }

    func build() {
        List() {
            LazyForEach(
                nodeViewAIDataSource,
                itemGeneratorFunc: {
                    tableNodeView: NodeView, idRow: Int64 => ListItem() {
                        // 行信息
                        MarkdownAITableBlockRow1Component(nodeView: tableNodeView, idRow: idRow,
                            markdownAIConfiguration: markdownAIConfiguration, componentWidth: componentWidth)
                    }
                }
            )
        }
            // 设置元素内容的对齐方式
            .align(Alignment.Start)
            // 设置元素水平方向的布局
            .direction(Direction.Ltr)
            // 设置外边距属性
            .margin(top: marginTop, bottom: marginBottom)
            // 设置组件自身的宽度
            .width(100.percent)
            // 统一边框样式设置接口
            .border(width: (markdownAIConfiguration.markdownAITheme.tableBorderWidth / 2.0).vp,
                color: markdownAIConfiguration.markdownAITheme.tableBorderColor, style: BorderStyle.Solid)
    }

    public func refreshData(nodeView: NodeView): Unit {
        let list = nodeView.children
        nodeViews.clear()
        for (nodeView in list) {
            if (nodeView.node is TableBody || nodeView.node is TableHead) {
                nodeViews.appendAll(nodeView.children)
            } else if (nodeView.node is TableRow) {
                nodeViews.append(nodeView)
            }
        }
        if (isFull) {
            nodeViewAIDataSource.clear()
            nodeViewAIDataSource.addDatas(nodeViews)
        } else {
            if (nodeViews.size == 0) {
                return
            }
            if (nodeViews.size > nodeViewAIDataSource.totalCount()) {
                if (nodeViewAIDataSource.totalCount() != 0) {
                    nodeViewAIDataSource.replaceDate(nodeViewAIDataSource.totalCount() - 1,
                        nodeViews[nodeViewAIDataSource.totalCount() - 1])
                }
                for (i in nodeViews.size - nodeViewAIDataSource.totalCount()..0 : -1) {
                    nodeViewAIDataSource.addData(nodeViews[nodeViews.size - i])
                }
            } else if (nodeViews.size == nodeViewAIDataSource.totalCount()) {
                nodeViewAIDataSource.replaceDate(nodeViewAIDataSource.totalCount() - 1, nodeViews[nodeViews.size - 1])
            } else {
                nodeViewAIDataSource.replaceDate(nodeViews.size - 1, nodeViews[nodeViews.size - 1])
                for (i in nodeViewAIDataSource.totalCount() - nodeViews.size..0 : -1) {
                    nodeViewAIDataSource.deleteData(nodeViewAIDataSource.totalCount() - i)
                }
            }
        }
    }
}
