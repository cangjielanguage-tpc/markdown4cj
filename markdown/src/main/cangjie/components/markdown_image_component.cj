/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 单独block图片
 */
@Component
public class MarkdownImageComponent {
    /**
     * 图片链接
     */
    var destination: String

    /**
     * 图片点击事件
     */
    var imageCallback: (String) -> Unit

    func build() {
        Image(destination)
            // 设置约束尺寸
            .constraintSize(maxWidth: 100.percent)
            // 设置图片的缩放类型
            .objectFit(ImageFit.Contain)
            // 点击动作触发该方法调用
            .onClick {
                evt => imageOnClick(destination, imageCallback)
            }
    }
}