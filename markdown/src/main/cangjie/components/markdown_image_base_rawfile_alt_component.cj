/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 非图文混排，占位图
 */
@Component
public class MarkdownImageBaseRawFileAltComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 图片圆角 - 单位vp
     */
    var imageBorderRadius: Float64

    /**
     * 图片宽度 - 单位px
     */
    var imageWidth: Length

    /**
     * 图片高度 - 单位px
     */
    var imageHeight: Length

    func build() {
        Image(markdownConfiguration.markdownTheme.imageResource())
            .borderRadius(imageBorderRadius)
            .width(imageWidth)
            .height(imageHeight)
            .constraintSize(maxWidth: 100.percent)
            .autoResize(markdownConfiguration.markdownTheme.isAutoResize)
    }
}
