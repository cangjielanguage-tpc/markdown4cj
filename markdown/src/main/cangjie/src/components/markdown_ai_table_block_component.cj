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
class MarkdownAITableBlockComponent {
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
     * 脚注点击事件
     */
    var fontCallback: (String) -> Unit

    /**
     * 表格
     */
    var tableComponents: ArrayList<MarkdownAITableBlockComponent>

    /**
     * 表格行
     */
    var tableRowComponents: ArrayList<MarkdownAITableBlockRowComponent>

    /**
     * 表格行内格子
     */
    var tableCellComponents: ArrayList<MarkdownAITableBlockCellComponent>

    /**
     * 懒加载数据源
     */
    var nodeViewAIDataSource: NodeViewAIDataSource = NodeViewAIDataSource(ArrayList<NodeView>())

    @State
    var cellWidthArrayIndexed: ObservedArrayList<CellWidthArrayIndexedClass> = ObservedArrayList<CellWidthArrayIndexedClass>()

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeViews)
        // 缓存当前控件
        tableComponents.append(this)
        // 清除缓存数据
        nodeViews.clear()
        var cellSize: Int64 = 0
        if (nodeViewAIDataSource.totalCount() > 0) {
            cellSize = nodeViewAIDataSource.getData(0).children.size
        }
        for (i in 0..cellSize) {
            cellWidthArrayIndexed.append(CellWidthArrayIndexedClass(minWidth: markdownAIConfiguration.markdownAITheme.tableMinTextWidth, index: i))
        }
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        tableComponents.removeIf(
            {
                predicate => if (predicate.indexList == indexList && predicate.size == size) {
                    true
                } else {
                    false
                }
            })
    }

    func build() {
        Scroll() {
            List() {
                LazyForEach(
                    nodeViewAIDataSource,
                    itemGeneratorFunc: {
                        tableHeaderOrBody: NodeView, idRow: Int64 => ListItem() {
                            // 行信息
                            MarkdownAITableBlockRowComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                nodeViews: tableHeaderOrBody.children,
                                fontCallback: fontCallback,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                idRow: idRow,
                                indexList: indexAdd(indexList, idRow),
                                tableRowComponents: tableRowComponents,
                                tableCellComponents: tableCellComponents,
                                dataRowSize: nodeViewAIDataSource.totalCount(),
                                cellWidthArrayIndexed: cellWidthArrayIndexed
                            )
                        }
                    }
                )
            }
            // 统一边框样式设置接口
            .border(width: markdownAIConfiguration.markdownAITheme.tableBorderWidth.vp, color: markdownAIConfiguration.markdownAITheme.tableBorderColor, style: BorderStyle.Solid, radius: markdownAIConfiguration.markdownAITheme.tableRadius.vp)
            // 设置元素内容的对齐方式
            .align(Alignment.Start)
            // 设置元素水平方向的布局
            .direction(Direction.Ltr)
            // 设置外边距属性
            .margin(top: marginTop, bottom: marginBottom)
        }
        // 设置滚动方向
        .scrollable(ScrollDirection.Horizontal)
        // 设置滚动条状态
        .scrollBar(BarState.Off)
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
                for (data in tableRowComponents) {
                    if (isListItem(indexList, data.indexList, indexRow)) {
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
