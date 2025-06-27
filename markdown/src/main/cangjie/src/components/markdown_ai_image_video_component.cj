/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

@Component
public class MarkdownAIImageVideoComponent {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 视频链接
     */
    @State
    var imageVideoUrl: String = ""

    /**
     * 上边距 - 单位vp
     */
    var marginTop: Float64

    /**
     * 下边距 - 单位vp
     */
    var marginBottom: Float64

    /**
     * 视频点击事件
     */
    var videoCallback: (String) -> Unit

    func build() {
        Stack(Alignment.BottomEnd) {
            Stack(Alignment.Center) {
                imgVideoComponent()
            }
            // 设置组件自身的宽度
            .width(100.percent)
        }
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
    }

    /**
     * 视频
     */
    @Builder
    func imgVideoComponent() {
        Text("")
    }
}
