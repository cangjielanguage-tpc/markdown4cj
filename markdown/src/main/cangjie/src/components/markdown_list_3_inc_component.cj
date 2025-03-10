/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.eventhub.*

class List3IncData {
    var component: MarkdownList3INCComponent
    var index: Int64
    var index2: Int64
    var index3: Int64
    var indexItem: Int64
    var indexItem2: Int64

    init(component: MarkdownList3INCComponent, index: Int64, index2: Int64, index3: Int64, indexItem: Int64,
        indexItem2: Int64) {
        this.component = component
        this.index = index
        this.index2 = index2
        this.index3 = index3
        this.indexItem = indexItem
        this.indexItem2 = indexItem2
    }
}

/**
 * Markdown无序列表(任务列表)、有序列表(TOC列表)、块引用自定义控件
 */
@Component
class MarkdownList3INCComponent {
    /**
     * markdown配置
     */
    @Prop
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 列表listNodeView
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
     * 标识符，第几条块引用
     */
    @Prop
    var index: Int64

    /**
     * 标识符，第几条块引用
     */
    @Prop
    var index2: Int64

    /**
     * 标识符，第几条块引用
     */
    @Prop
    var index3: Int64

    /**
     * 标识符，第几条块引用
     */
    @Prop
    var indexItem: Int64

    /**
     * 标识符，第几条块引用
     */
    @Prop
    var indexItem2: Int64

    @Prop
    var markdownListConfiguration: MarkdownListConfiguration

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewDataSource: NodeViewDataSourceINC = NodeViewDataSourceINC(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        refreshData(nodeView)
        markdownListConfiguration.list3Components.append(List3IncData(this, index, index2, index3, indexItem, indexItem2
        ))
    }

    protected override func aboutToDisappear(): Unit {
        markdownListConfiguration
            .list3Components
            .removeIf(
                {
                    predicate => if (predicate.index == index && predicate.index2 == index2
                        && predicate.index3 == index3 && predicate.indexItem == indexItem
                        && predicate.indexItem2 == indexItem2 && predicate.component.nodeView.children.size == nodeView
                        .children
                        .size) {
                        true
                    } else {
                        false
                    }
                })
    }

    func build() {
        if (nodeView.node is BulletList) {
            // 无序列表
            bulletListComponent()
        } else if (nodeView.node is OrderedList) {
            // 有序列表
            orderedListComponent()
        } else {
            // 其他节点
        }
    }

    @Builder
    func bulletListComponent() {
        List() {
            LazyForEach(
                nodeViewDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Row() {
                            if (item.node is TaskListItem) {
                                // 任务列表
                                listPrefixCheckboxINCComponent(item, markdownConfiguration)
                            } else if (item.node is CommonmarkListItem) {
                                // 普通无序列表
                                listPrefixTextINCComponent(item, false, markdownConfiguration)
                            }
                            MarkdownListItem3INCComponent(
                                nodeView: item,
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                index: index,
                                index2: index2,
                                index3: index3,
                                indexItem: indexItem,
                                indexItem2: indexItem2,
                                indexItem3: idx,
                                markdownListConfiguration: markdownListConfiguration
                            )
                        }
                            // 在垂直方向上子组件的对齐格式。
                            .alignItems(VerticalAlign.Top)
                            // 设置子组件在水平方向上的对齐格式。
                            .justifyContent(FlexAlign.Start)
                    }
                        // 对子组件进行重新布局
                        .layoutWeight(1)
                }
            )
        }
            // 块内容前的起始边距
            .margin(top: marginTop, bottom: marginBottom)
            // 设置组件自身的宽度
            .width(100.percent)
            // 设置List组件排列方向
            .listDirection(Axis.Vertical)
            // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
            .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func orderedListComponent() {
        List() {
            LazyForEach(
                nodeViewDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Row() {
                            if (item.node is CommonmarkListItem) {
                                // 普通有序列表
                                listPrefixTextINCComponent(item, true, markdownConfiguration)
                            }
                            MarkdownListItem3INCComponent(
                                nodeView: item,
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                index: index,
                                index2: index2,
                                index3: index3,
                                indexItem: indexItem,
                                indexItem2: indexItem2,
                                indexItem3: idx,
                                markdownListConfiguration: markdownListConfiguration
                            )
                        }
                            // 在垂直方向上子组件的对齐格式。
                            .alignItems(VerticalAlign.Top)
                            // 设置子组件在水平方向上的对齐格式。
                            .justifyContent(FlexAlign.Start)
                    }
                        // 对子组件进行重新布局
                        .layoutWeight(1)
                }
            )
        }
            // 块内容前的起始边距
            .margin(top: marginTop, bottom: marginBottom)
            // 设置组件自身的宽度
            .width(100.percent)
            // 设置List组件排列方向
            .listDirection(Axis.Vertical)
            // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
            .alignListItem(ListItemAlign.Start)
    }

    public func refreshData(nodeView: NodeView): Unit {
        let nodeViews = nodeView.children
        if (isFull) {
            nodeViewDataSource.clear()
            nodeViewDataSource.addDatas(nodeViews)
        } else {
            if (nodeViews.size == 0) {
                return
            }
            if (nodeViews.size > nodeViewDataSource.totalCount()) {
                if (nodeViewDataSource.totalCount() != 0) {
                    nodeViewDataSource.replaceDate(nodeViewDataSource.totalCount() - 1,
                        nodeViews[nodeViewDataSource.totalCount() - 1])
                }
                for (i in nodeViews.size - nodeViewDataSource.totalCount()..0 : -1) {
                    nodeViewDataSource.addData(nodeViews[nodeViews.size - i])
                }
            } else if (nodeViews.size == nodeViewDataSource.totalCount()) {
                let indexItem3: Int64 = nodeViewDataSource.totalCount() - 1
                for (data in markdownListConfiguration.listItem3Components) {
                    if (data.index == index && data.index2 == index2 && data.index3 == index3 && data.indexItem ==
                        indexItem && data.indexItem2 == indexItem2 && data.indexItem3 == indexItem3) {
                        data.component.refreshData(nodeViews[nodeViews.size - 1])
                    }
                }
            } else {
                nodeViewDataSource.replaceDate(nodeViews.size - 1, nodeViews[nodeViews.size - 1])
                for (i in nodeViewDataSource.totalCount() - nodeViews.size..0 : -1) {
                    nodeViewDataSource.deleteData(nodeViewDataSource.totalCount() - i)
                }
            }
        }
    }
}
