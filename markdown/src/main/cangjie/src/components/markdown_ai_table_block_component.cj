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
     * 表格tableNodeView
     */
    var tableNodeView: NodeView

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
     * 懒加载数据源
     */
    var nodeViewAIDataSource: NodeViewAIDataSource = NodeViewAIDataSource(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData()
    }

    func build() {
        List() {
            LazyForEach(
                nodeViewAIDataSource,
                itemGeneratorFunc: {
                    tableHeaderOrBody: NodeView, idRow: Int64 => ListItem() {
                        // 行信息
                        MarkdownAITableBlockRowComponent(
                            nodeView: tableHeaderOrBody,
                            idRow: idRow,
                            markdownAIConfiguration: markdownAIConfiguration,
                            componentWidth: componentWidth
                        )
                    }
                }
            )
        }
        // 统一边框样式设置接口
        .border(width: (markdownAIConfiguration.markdownAITheme.tableBorderWidth / 2.0).vp, color: markdownAIConfiguration.markdownAITheme.tableBorderColor, style: BorderStyle.Solid)
        // 设置元素内容的对齐方式
        .align(Alignment.Start)
        // 设置元素水平方向的布局
        .direction(Direction.Ltr)
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
        // 设置组件自身的宽度
        .width(100.percent)
    }

    /**
     * 数据刷新
     */
    func refreshData() {
        let nodeViews: ArrayList<NodeView> = tableList(tableNodeView.children)
        let nodeViewsSize = nodeViews.size // 刷新进来的数据长度
        let dataSourceSize = nodeViewAIDataSource.totalCount() // 页面缓存的数据长度
        if (isFull) {
            // 增量加载
            nodeViewAIDataSource.clear()
            nodeViewAIDataSource.addDatas(nodeViews)
        } else {
            // 刷新数据的长度大于页面数据长度，需要添加数据
            if (nodeViewsSize== 0) {
                return
            }
            if (nodeViewsSize> dataSourceSize) {
                // 刷新数据的长度大于页面数据长度，需要添加数据
                if (dataSourceSize != 0) {
                    // 更新页面最后一条数据
                    nodeViewAIDataSource.replaceData(dataSourceSize - 1, nodeViews[dataSourceSize - 1])
                }
                // 循环添加所有新增数据
                for (i in nodeViewsSize- dataSourceSize..0 : -1) {
                    nodeViewAIDataSource.addData(nodeViews[nodeViewsSize- i])
                }
            } else if (nodeViewsSize== dataSourceSize) {
                // 刷新数据的长度等于页面数据长度，需要更新当前数据
                nodeViewAIDataSource.replaceData(dataSourceSize - 1, nodeViews[nodeViewsSize- 1])
            } else {
                // 刷新数据小于页面数据长度，需要删除数据
                // 更新页面中间一条数据 - 刷新数据长度的最后一条数据
                nodeViewAIDataSource.replaceData(nodeViewsSize- 1, nodeViews[nodeViewsSize- 1])
                // 循环删除所有多余数据
                for (i in dataSourceSize - nodeViews.size..0 : -1) {
                    nodeViewAIDataSource.deleteData(dataSourceSize - i)
                }
            }
        }
    }
}
