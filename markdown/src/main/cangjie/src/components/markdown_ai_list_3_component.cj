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
class MarkdownAIList3Component {
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
    var index3: Int64

    /**
     * 标识符，第几条块引用
     */
    var indexItem: Int64

    /**
     * 标识符，第几条块引用
     */
    var indexItem2: Int64

    /**
     * 缓存的数据
     */
    var markdownAICacheConfiguration: MarkdownAICacheConfiguration

    /**
     * 懒加载数据源
     */
    var nodeViewAIDataSource: NodeViewAIDataSource = NodeViewAIDataSource(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeViews)
        // 缓存当前控件
        markdownAICacheConfiguration.list3Components.append(this)
        // 清除缓存数据
        nodeViews.clear()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        markdownAICacheConfiguration
            .list3Components
            .removeIf(
                {
                    predicate => if (predicate.index == index && predicate.index2 == index2
                        && predicate.index3 == index3 && predicate.indexItem == indexItem
                        && predicate.indexItem2 == indexItem2 && predicate.size == size) {
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
                    item: NodeView, idx: Int64 => ListItem() {
                        Row() {
                            if (isOrdered) {
                                if (item.node is CommonmarkListItem) {
                                    // 普通有序列表
                                    listPrefixTextINCComponent(item, true, markdownAIConfiguration)
                                }
                            } else {
                                if (item.node is TaskListItem) {
                                    // 任务列表
                                    listPrefixCheckboxINCComponent(item, markdownAIConfiguration)
                                } else if (item.node is CommonmarkListItem) {
                                    // 普通无序列表
                                    listPrefixTextINCComponent(item, false, markdownAIConfiguration)
                                }
                            }
                            MarkdownAIListItem3Component(
                                markdownAIConfiguration: markdownAIConfiguration,
                                nodeViews: item.children,
                                marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                index: index,
                                index2: index2,
                                index3: index3,
                                indexItem: indexItem,
                                indexItem2: indexItem2,
                                indexItem3: idx,
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

    /**
     * 数据刷新
     */
    public func refreshData(refreshNodeViews: ArrayList<NodeView>): Unit {
        let refreshNodeViewSize: Int64 = refreshNodeViews.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = nodeViewAIDataSource.totalCount() // 页面缓存的数据长度
        if (isFull) {
            // 全量加载
            nodeViewAIDataSource.clear()
            nodeViewAIDataSource.addDatas(refreshNodeViews)
        } else {
            // 增量加载
            if (refreshNodeViewSize == 0) {
                return
            }
            if (refreshNodeViewSize > dataSourceSize) {
                // 刷新数据的长度大于页面数据长度，需要添加数据
                if (dataSourceSize != 0) {
                    // 更新页面最后一条数据
                    nodeViewAIDataSource.replaceData(dataSourceSize - 1, refreshNodeViews[dataSourceSize - 1])
                }
                // 循环添加所有新增数据
                for (i in refreshNodeViewSize - dataSourceSize..0 : -1) {
                    nodeViewAIDataSource.addData(refreshNodeViews[refreshNodeViewSize - i])
                }
            } else if (refreshNodeViewSize == dataSourceSize) {
                // 刷新数据的长度等于页面数据长度，需要更新当前数据
                let indexItem3: Int64 = dataSourceSize - 1
                for (data in markdownAICacheConfiguration.listItem3Components) {
                    if (data.index == index && data.index2 == index2 && data.index3 == index3 && data.indexItem == indexItem && data.indexItem2 == indexItem2 && data.indexItem3 == indexItem3) {
                        data.refreshData(refreshNodeViews[refreshNodeViewSize - 1].children)
                    }
                }
            } else {
                // 刷新数据小于页面数据长度，需要删除数据
                // 更新页面中间一条数据 - 刷新数据长度的最后一条数据
                nodeViewAIDataSource.replaceData(refreshNodeViewSize - 1, refreshNodeViews[refreshNodeViewSize - 1])
                // 循环删除所有多余数据
                for (i in dataSourceSize - refreshNodeViewSize..0 : -1) {
                    nodeViewAIDataSource.deleteData(dataSourceSize - i)
                }
            }
        }
        size = nodeViewAIDataSource.totalCount() // 更新列表长度
    }
}
