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
class MarkdownAITableBlockCellComponent {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 表格tableNodeView
     */
    var nodeView: NodeView

    /**
     * 控件宽度 - 单位px
     */
    var componentWidth: Float64

    var idRow: Int64

    func build() {
        Text() {
            ForEach(
                nodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is CommonmarkText) {
                        // 文本
                        if ((nodeView.node as TableCell)().isHeader()) {
                            tableComponentText(item, true, markdownAIConfiguration)
                        } else {
                            tableComponentText(item, false, markdownAIConfiguration)
                        }
                    } else if (item.node is Code) {
                        // 内联代码
                        if ((nodeView.node as TableCell)().isHeader()) {
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
        .textAlign(renderTableCellAlign((nodeView.node as TableCell)()))
        // 设置内边距属性
        .padding(markdownAIConfiguration.markdownAITheme.tableCellPadding)
        // 设置组件的背景色
        .backgroundColor(renderTableCellColor((nodeView.node as TableCell)(), markdownAIConfiguration.markdownAITheme, idRow))
        // 统一边框样式设置接口
        .border(width: (markdownAIConfiguration.markdownAITheme.tableBorderWidth / 2.0).vp, color: markdownAIConfiguration.markdownAITheme.tableBorderColor, style: BorderStyle.Solid)
    }
}
