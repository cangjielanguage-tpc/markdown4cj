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
class MarkdownAITableBlockRowComponent {
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
        Row() {
            ForEach(
                nodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idxItem: Int64 => if (item.node is TableCell) {
                        MarkdownAITableBlockCellComponent(
                            nodeView: item,
                            idRow: idRow,
                            markdownAIConfiguration: markdownAIConfiguration,
                            componentWidth: componentWidth
                        )
                    }
                }
            )
        }
        // 设置组件自身的宽度
        .width(100.percent)
    }
}
