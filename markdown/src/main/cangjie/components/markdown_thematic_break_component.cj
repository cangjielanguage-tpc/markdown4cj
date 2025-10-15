/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
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

    /**
     * 外边距 - 上面
     */
    var marginTop: Float64

    /**
     * 外边距 - 下面
     */
    var marginBottom: Float64

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
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
    }
}
