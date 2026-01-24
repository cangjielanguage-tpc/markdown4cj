/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 非图文混排，本地url
 */
@Component
public class MarkdownImageBaseRawFileComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 图片链接
     */
    var destination: String

    /**
     * 图片数据
     */
    var imagePixelMap: PixelMap

    /**
     * 图片最大宽度 - 单位px
     */
    var componentImageWidth: Float64

    /**
     * 图片点击事件
     */
    var imageCallback: (String) -> Unit

    /**
     * 链接点击事件
     */
    var linkCallback: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var isLink: Bool

    /**
     * 链接url
     */
    var linkUrl: ?String

    /**
     * 图片圆角 - 单位vp
     */
    var imageBorderRadius: Float64

    /**
     * 图片宽度 - 单位px
     */
    var imageWidth: Float64

    /**
     * 图片高度 - 单位px
     */
    var imageHeight: Float64

    func build() {
        Image(imagePixelMap)
            .borderRadius(imageBorderRadius)
            .width(imageSpanWidth(markdownConfiguration.markdownTheme.imageFixedRatioWidth, componentImageWidth, imageWidth, markdownConfiguration.markdownTheme.imageMaximumWidth))
            .height(imageSpanHeight(markdownConfiguration.markdownTheme.imageFixedRatioWidth, componentImageWidth, imageWidth, imageHeight, markdownConfiguration.markdownTheme.imageMaximumWidth))
            .objectFit(markdownConfiguration.markdownTheme.imageFitType)
            .constraintSize(maxWidth: 100.percent)
            .autoResize(markdownConfiguration.markdownTheme.isAutoResize)
            .onClick {evt => imageSpanOnClick(isLink, imageCallback, linkCallback, linkUrl, destination)}
    }
}
