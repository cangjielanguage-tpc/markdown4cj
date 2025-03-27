/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 网络图片和沙盒图片
 */
@Component
public class MarkdownAIImageSpanComponent {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 图片内容
     */
    var destination: String

    func build() {
        ImageSpan(destination)
            // 设置图片的缩放类型
            .objectFit(ImageFit.Contain)
            // 设置约束尺寸
            .constraintSize(maxWidth: 100.percent)
            // 点击动作触发该方法调用
            .onClick {
                evt => imageOnClick(destination, markdownAIConfiguration.imageCallback)
            }
    }
}
