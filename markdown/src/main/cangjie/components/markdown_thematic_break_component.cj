/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown分割线自定义控件
 */
@Component
class MarkdownThematicBreakComponent {
    /**
     * 分割线样式
     */
    var markdownConfiguration: MarkdownConfiguration

    func build() {
        Column() {
            if (markdownConfiguration.markdownTheme.thematicBreakHeight > 0.0) {
                Divider()
                    // 设置分割线颜色
                    .color(markdownConfiguration.markdownTheme.thematicBreakColor)
                    // 设置分割线宽度
                    .strokeWidth(markdownConfiguration.markdownTheme.thematicBreakHeight)
            }
        }
    }
}
