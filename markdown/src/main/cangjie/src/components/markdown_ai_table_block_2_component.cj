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
class MarkdownAITableBlock2Component {
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
     * 外边距 - 上面
     */
    var marginTop: Float64

    /**
     * 外边距 - 下面
     */
    var marginBottom: Float64

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

    var table2Components: ArrayList<MarkdownAITableBlock2Component>

    var tableRow2Components: ArrayList<MarkdownAITableBlockRow2Component>

    var tableCell2Components: ArrayList<MarkdownAITableBlockCell2Component>

    /**
     * 脚注点击事件
     */
    var fontCallback: (String) -> Unit

    /**
     * 懒加载数据源
     */
    var nodeViewAIDataSource: NodeViewAIDataSource = NodeViewAIDataSource(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeViews)
        // 缓存当前控件
        table2Components.append(this)
        // 清除缓存数据
        nodeViews.clear()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        table2Components
            .removeIf(
                {
                    predicate => if (predicate.index == index && predicate.index2 == index2
                    && predicate.indexItem == indexItem   && predicate.size == size) {
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
                    tableNodeView: NodeView, indexRow: Int64 => ListItem() {
                        // 行信息
                        MarkdownAITableBlockRow2Component(
                            markdownAIConfiguration: markdownAIConfiguration,
                            nodeViews: tableNodeView.children,
                            fontCallback: fontCallback,
                            isFull: isFull,
                            componentWidth: componentWidth,
                            indexRow: indexRow,
                            index: index,
                            index2: index2,
                            indexItem: indexItem,
                            tableRow2Components: tableRow2Components,
                            tableCell2Components: tableCell2Components
                        )
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
        .border(width: (markdownAIConfiguration.markdownAITheme.tableBorderWidth / 2.0).vp, color: markdownAIConfiguration.markdownAITheme.tableBorderColor, style: BorderStyle.Solid)
    }

    /**
     * 数据刷新
     */
    public func refreshData(refreshNodeViews: ArrayList<NodeView>): Unit {
        let refreshNodeViewSize = refreshNodeViews.size // 刷新进来的数据长度
        let dataSourceSize = nodeViewAIDataSource.totalCount() // 页面缓存的数据长度
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
                let indexRow: Int64 = dataSourceSize - 1
                for (data in tableRow2Components) {
                    if (data.index == index && data.index2 == index2 && data.indexItem == indexItem && data.indexRow == indexRow) {
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
