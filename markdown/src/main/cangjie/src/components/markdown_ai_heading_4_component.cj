/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown标题自定义控件
 */
@Component
class MarkdownAIHeading4Component {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 标题内容数据
     */
    var nodeViews: ArrayList<NodeView>

    /**
     * 标题等级
     */
    @State
    var level: Int64 = 1

    /**
     * 长度
     */
    var size: Int64 = -1

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
     * 第一层的定位标识
     */
    var index: Int64

    /**
     * 第二层的定位标识
     */
    var index2: Int64

    /**
     * 第三层的定位标识
     */
    var index3: Int64

    /**
     * 第四层的定位标识
     */
    var index4: Int64

    /**
     * 列表第一层定位
     */
    var indexItem: Int64

    /**
     * 列表第二层定位
     */
    var indexItem2: Int64

    /**
     * 列表第三层定位
     */
    var indexItem3: Int64

    /**
     * 缓存的第四层标题控件列表
     */
    var heading4Components: ArrayList<MarkdownAIHeading4Component>

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>()

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeViews, level)
        // 缓存当前控件
        heading4Components.append(this)
        // 清除缓存数据
        nodeViews.clear()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        heading4Components.removeIf(
            {
                predicate => if (predicate.index == index && predicate.index2 == index2
                    && predicate.index3 == index3 && predicate.index4 == index4 && predicate.indexItem == indexItem
                    && predicate.indexItem2 == indexItem2 && predicate.indexItem3 == indexItem3 && predicate.size == size) {
                    true
                } else {
                    false
                }
            })
    }

    func build() {
        Column() {
            // 标题内容
            headingTitleComponent()

            // 一级二级标题是否显示下划线
            if ((level == 1 || level == 2) && markdownAIConfiguration.markdownAITheme.headingBreakHeight > 0.0) {
                headingDividerComponent(markdownAIConfiguration)
            }
        }
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
     * 标题文字内容
     */
    @Builder
    func headingTitleComponent() {
        Text() {
            ForEach(
                nodeViewList,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is CommonmarkText) {
                        // 文本
                        headingTextComponent(item, markdownAIConfiguration, level)
                    } else if (item.node is Code) {
                        // 内联代码
                        headingCodeComponent(item, markdownAIConfiguration)
                    } else if (item.node is HardLineBreak) {
                        // 硬换行
                        Span("\n")
                    } else if (item.node is SoftLineBreak) {
                        // 软换行
                        Span(spanSoftLineBreak(markdownAIConfiguration.markdownAITheme.isLineBreak))
                    } else if (item.node is CommonmarkImage) {
                        // 图片节点
                        MarkdownAIImageSpanComponent(
                            markdownAIConfiguration: markdownAIConfiguration,
                            destination: (item.node as CommonmarkImage)().getDestination()
                        )
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        MarkdownAILatexImageSpanComponent(
                            markdownAIConfiguration: markdownAIConfiguration,
                            componentWidth: componentWidth,
                            strLatexMath: (item.node as LatexMathNode)().latex
                        )
                    } else if (item.node is ImageHtmlNode) {
                        // HTML图片
                        MarkdownAIHtmlImageSpanComponent(
                            markdownAIConfiguration: markdownAIConfiguration,
                            destination: (item.node as ImageHtmlNode)().getDestination(),
                            strHeight: (item.node as ImageHtmlNode)().getHeight(),
                            strWidth: (item.node as ImageHtmlNode)().getWidth()
                        )
                    } else {
                        // TODO 其他节点
                        Span("")
                    }
                }
            )
        }
        // 设置多行文本的文本对齐方式
        .textAlign(TextAlign.Start)
        // 设置行高
        .lineHeight(22.0)
        // 设置组件自身的宽度
        .width(100.percent)
    }

    /**
     * 数据刷新
     */
    public func refreshData(refreshNodeViews: ArrayList<NodeView>, level: Int64): Unit {
        this.level = level // 等级
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
                // 有可能还需要刷新倒数第二条数据内容
                if (refreshNodeViewSize > 2) {
                    if (refreshNodeViews[refreshNodeViewSize - 2].node.getNodeType() != nodeViewList[nodeViewListSize - 2].node.getNodeType()) {
                        nodeViewList.remove(refreshNodeViewSize - 2)
                        nodeViewList.insert(refreshNodeViewSize - 2, refreshNodeViews[refreshNodeViewSize - 2])
                    }
                    if ((refreshNodeViews[refreshNodeViewSize - 2].node is CommonmarkText) && (nodeViewList[nodeViewListSize - 2].node is CommonmarkText)) {
                        if ((refreshNodeViews[refreshNodeViewSize - 2].node as CommonmarkText)().getLiteral() != (nodeViewList[nodeViewListSize - 2].node as CommonmarkText)().getLiteral()) {
                            nodeViewList.remove(refreshNodeViewSize - 2)
                            nodeViewList.insert(refreshNodeViewSize - 2, refreshNodeViews[refreshNodeViewSize - 2])
                        }
                    }
                }
                // 刷新最后一条数据
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
