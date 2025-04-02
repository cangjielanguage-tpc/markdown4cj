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
class MarkdownAITableBlockCell2Component {
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
     * 是否全量加载
     */
    var isFull: Bool

    /**
     *
     */
    var isHeader: Bool

    var alignment: ?TableAlignment

    /**
     * 控件宽度 - 单位px
     */
    var componentWidth: Float64

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

    var indexCell: Int64


    var tableCell2Components: ArrayList<MarkdownAITableBlockCell2Component>

    /**
     * 脚注点击事件
     */
    var fontCallback: (String) -> Unit

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>()

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeViews)
        // 缓存当前控件
        tableCell2Components.append(this)
        // 清除缓存数据
        nodeViews.clear()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        tableCell2Components
            .removeIf(
                {
                    predicate => if (predicate.index == index && predicate.indexRow == indexRow && predicate.index2 == index2
                    && predicate.indexItem == indexItem  &&
                        predicate.indexCell == indexCell && predicate.size == size) {
                        true
                    } else {
                        false
                    }
                })
    }

    func build() {
        Text() {
            ForEach(
                nodeViewList,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is CommonmarkText || item.node is Footnote) {
                        // 文本或者脚注
                        if (isHeader) {
                            tableComponentText(item, true, markdownAIConfiguration)
                        } else {
                            tableComponentText(item, false, markdownAIConfiguration)
                        }
                    } else if (item.node is Code) {
                        // 内联代码
                        if (isHeader) {
                            tableComponentCode(item, true, markdownAIConfiguration)
                        } else {
                            tableComponentCode(item, false, markdownAIConfiguration)
                        }
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        MarkdownAILatexImageSpanComponent(
                            markdownAIConfiguration: markdownAIConfiguration,
                            componentWidth: componentWidth,
                            strLatexMath: (item.node as LatexMathNode)().latex
                        )
                    } else {
                        // TODO 其他节点
                        Span("")
                    }
                }
            )
        }
        // 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
        .layoutWeight(1)
        // 设置父容器的剩余空间分配给此属性所在组件的比例
        .flexGrow(1)
        // Flex 容器压缩尺寸分配给此属性所在组件的比例
        .flexShrink(1)
        // 覆盖 Flex 布局容器中 alignItems 默认配置
        .alignSelf(ItemAlign.Stretch)
        // 设置行高
        .lineHeight(22.0)
        // 设置多行文本的文本对齐方式
        .textAlign(renderTableCellAlign(alignment))
        // 设置内边距属性
        .padding(markdownAIConfiguration.markdownAITheme.tableCellPadding)
        // 设置组件的背景色
        .backgroundColor(renderTableCellColor(isHeader, markdownAIConfiguration.markdownAITheme, indexRow))
        // 统一边框样式设置接口
        .border(width: (markdownAIConfiguration.markdownAITheme.tableBorderWidth / 2.0).vp, color: markdownAIConfiguration.markdownAITheme.tableBorderColor, style: BorderStyle.Solid)
    }

    /**
     * 数据刷新
     */
    public func refreshData(refreshNodeViews: ArrayList<NodeView>): Unit {
        let refreshNodeViewSize: Int64 = refreshNodeViews.size // 刷新进来的数据长度
        let nodeViewListSize: Int64 = nodeViewList.size // 页面缓存的数据长度
        if (isFull) {
            // 全量加载
            nodeViewList.clear()
            nodeViewList.appendAll(refreshNodeViews)
        } else {
            // 增量加载
            if (refreshNodeViewSize == 0) {
                return
            }
            if (refreshNodeViewSize > nodeViewListSize) {
                // 刷新数据的长度大于页面数据长度，需要添加数据
                if (nodeViewListSize != 0) {
                    // 更新页面最后一条数据
                    nodeViewList.remove(nodeViewListSize - 1)
                    nodeViewList.append(refreshNodeViews[nodeViewListSize - 1])
                }
                // 循环添加所有新增数据
                for (i in refreshNodeViewSize - nodeViewListSize..0 : -1) {
                    nodeViewList.append(refreshNodeViews[refreshNodeViewSize - i])
                }
            } else if (refreshNodeViewSize == nodeViewListSize) {
                // 刷新数据的长度等于页面数据长度，需要更新当前数据
                nodeViewList.remove(nodeViewListSize - 1)
                nodeViewList.append(refreshNodeViews[refreshNodeViewSize - 1])
            } else {
                // 刷新数据小于页面数据长度，需要删除数据
                // 更新页面中间一条数据 - 刷新数据长度的最后一条数据
                nodeViewList.remove(refreshNodeViewSize - 1)
                nodeViewList.append(refreshNodeViews[refreshNodeViewSize - 1])
                // 循环删除所有多余数据
                for (i in nodeViewListSize - refreshNodeViewSize..0 : -1) {
                    nodeViewList.remove(nodeViewListSize - i)
                }
            }
        }
        size = nodeViewList.size // 更新列表长度
    }
}
