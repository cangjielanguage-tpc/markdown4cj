/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.components

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*

/**
 * Markdown HTML自定义控件
 */
@Component
class MarkdownHtmlBlockComponent {
    /**
     * HTML HtmlBlockView
     */
    var htmlBlockView: HtmlBlock

    func build() {
        // 文本内容
        if (htmlBlockView.getLiteral().toAsciiLower().replace(" ", "") == "<br>" ||
            htmlBlockView.getLiteral().toAsciiLower().replace(" ", "") == "</br>" ||
            htmlBlockView.getLiteral().toAsciiLower().replace(" ", "") == "<br/>") {
            // 设置文本内容
            Text("\n")
        } else {
            // TODO 其他内容，暂时只支持br标签
        }
    }
}
