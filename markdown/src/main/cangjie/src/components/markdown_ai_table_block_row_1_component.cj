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
class MarkdownAITableBlockRow1Component {
    /**
     * markdown配置
     */
    @Prop
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 表格tableNodeView
     */
    @Prop
    var nodeView: NodeView

    /**
     * 控件宽度 - 单位px
     */
    @Prop
    var componentWidth: Float64

    @Prop
    var idRow: Int64

    func build() {
        Row() {
            ForEach(
                nodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idxItem: Int64 => if (item.node is TableCell) {
                        MarkdownAITableBlockCell1Component(nodeView: item, idRow: idRow,
                            markdownAIConfiguration: markdownAIConfiguration, componentWidth: componentWidth)
                    }
                }
            )
        }
            // 设置组件自身的宽度
            .width(100.percent)
    }
}
