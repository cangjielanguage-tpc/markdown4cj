/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2026. All rights reserved.
 */
package markdown.components

import ohos.state_macro_manage.*

/**
 * 分割线控件
 */
@Component
class MarkdownThematicBreakComponent {
    /**
     * markdown样式
     */
    var markdownTheme: MarkdownTheme

    func build() {
        Column() {
            if (markdownTheme.thematicBreakHeight > 0.0) {
                Divider()
                    .color(markdownTheme.thematicBreakColor)
                    .strokeWidth(markdownTheme.thematicBreakHeight)
            }
        }
    }
}
