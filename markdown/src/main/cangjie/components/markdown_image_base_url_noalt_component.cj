/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 非图文混排，url入参，没有占位图
 */
@Component
public class MarkdownImageBaseUrlNoAltComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 图片链接
     */
    var destination: String

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
     * 图片样式宽度
     */
    var picStyleObjWidth: ?Float64 = Option<Float64>.None

    /**
     * 图片样式高度
     */
    var picStyleObjHeight: ?Float64 = Option<Float64>.None

    /**
     * 图片宽度 - 单位px
     */
    @State
    var imageWidth: Float64 = 0.0

    /**
     * 图片高度 - 单位px
     */
    @State
    var imageHeight: Float64 = 0.0

    func build() {
        Image(destination)
            .borderRadius(imageBorderRadius)
            .width(imageSpanWidth(markdownConfiguration.markdownTheme.imageFixedRatioWidth, componentImageWidth, imageWidth, markdownConfiguration.markdownTheme.imageMaximumWidth))
            .height(imageSpanHeight(markdownConfiguration.markdownTheme.imageFixedRatioWidth, componentImageWidth, imageWidth, imageHeight, markdownConfiguration.markdownTheme.imageMaximumWidth))
            .objectFit(markdownConfiguration.markdownTheme.imageFitType)
            .constraintSize(maxWidth: 100.percent)
            .autoResize(markdownConfiguration.markdownTheme.isAutoResize)
            .onClick {evt => imageSpanOnClick(isLink, imageCallback, linkCallback, linkUrl, destination)}
            .onComplete {
                imageLoadResult =>
                    let res = imageWidthHeight(picStyleObjWidth, picStyleObjHeight, componentImageWidth, imageLoadResult.height, imageLoadResult.width)
                    imageWidth = res[0]
                    imageHeight = res[1]
            }
    }
}
