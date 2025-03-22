/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown无序列表(任务列表)、有序列表(TOC列表)、块引用自定义控件
 */
@Component
class MarkdownAIList2Component {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 列表内容数据
     */
    var nodeViews: ArrayList<NodeView>

    /**
     * 长度
     */
    var size: Int64 = -1

    /**
     * 是无序列表还是有序列表 - true：无序列表，fasle：有序列表
     */
    var isOrdered: Bool

    /**
     * 上边距 - 单位vp
     */
    var marginTop: Float64

    /**
     * 下边距 - 单位vp
     */
    var marginBottom: Float64

    /**
     * 控件宽度 - 单位px
     */
    var componentWidth: Float64

    /**
     * 是否全量加载 - true：全量加载，fasle：增量加载
     */
    var isFull: Bool

    /**
     * 标识符，第几条块引用
     */
    var index: Int64

    /**
     * 标识符，第几条块引用
     */
    var index2: Int64

    /**
     * 标识符，第几条块引用
     */
    var indexItem: Int64

    /**
     * 缓存的数据
     */
    var markdownAICacheConfiguration: MarkdownAICacheConfiguration

    /**
     * 懒加载数据源
     */
    var nodeViewAIDataSource: NodeViewAIDataSource = NodeViewAIDataSource(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        size = nodeViews.size
        refreshData(nodeViews)
        markdownAICacheConfiguration.list2Components.append(this)
    }

    protected override func aboutToDisappear(): Unit {
        markdownAICacheConfiguration
            .list2Components
            .removeIf(
                {
                    predicate => if (predicate.index == index && predicate.index2 == index2
                        && predicate.indexItem == indexItem && predicate.size == size) {
                        true
                    } else {
                        false
                    }
                })
    }

    func build() {
        if (isOrdered) {
            // 有序列表
            orderedListComponent()
        } else  {
            // 无序列表
            bulletListComponent()
        }
    }

    @Builder
    func bulletListComponent() {
        List() {
            LazyForEach(
                nodeViewAIDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Row() {
                            if (item.node is TaskListItem) {
                                // 任务列表
                                listPrefixCheckboxINCComponent(item, markdownAIConfiguration)
                            } else if (item.node is CommonmarkListItem) {
                                // 普通无序列表
                                listPrefixTextINCComponent(item, false, markdownAIConfiguration)
                            }
                            MarkdownAIListItem2Component(
                                markdownAIConfiguration: markdownAIConfiguration,
                                nodeViews: item.children,
                                marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                index: index,
                                index2: index2,
                                indexItem: indexItem,
                                indexItem2: idx,
                                markdownAICacheConfiguration: markdownAICacheConfiguration
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
                nodeViewAIDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Row() {
                            if (item.node is CommonmarkListItem) {
                                // 普通有序列表
                                listPrefixTextINCComponent(item, true, markdownAIConfiguration)
                            }
                            MarkdownAIListItem2Component(
                                markdownAIConfiguration: markdownAIConfiguration,
                                nodeViews: item.children,
                                marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                index: index,
                                index2: index2,
                                indexItem: indexItem,
                                indexItem2: idx,
                                markdownAICacheConfiguration: markdownAICacheConfiguration
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

    public func refreshData(nodeViews: ArrayList<NodeView>): Unit {
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
                let indexItem2: Int64 = nodeViewAIDataSource.totalCount() - 1
                for (data in markdownAICacheConfiguration.listItem2Components) {
                    if (data.index == index && data.index2 == index2 && data.indexItem == indexItem &&
                        data.indexItem2 == indexItem2) {
                        data.refreshData(nodeViews[nodeViews.size - 1].children)
                    }
                }
            } else {
                nodeViewAIDataSource.replaceDate(nodeViews.size - 1, nodeViews[nodeViews.size - 1])
                for (i in nodeViewAIDataSource.totalCount() - nodeViews.size..0 : -1) {
                    nodeViewAIDataSource.deleteData(nodeViewAIDataSource.totalCount() - i)
                }
            }
        }
    }
}
