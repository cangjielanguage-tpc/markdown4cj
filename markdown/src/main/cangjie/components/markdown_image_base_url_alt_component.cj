/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 非图文混排，url入参，有占位图
 */
@Component
public class MarkdownImageBaseUrlAltComponent {
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
    var imageWidth: Length = 0.0.vp

    /**
     * 图片高度 - 单位px
     */
    @State
    var imageHeight: Length = 0.0.vp

    protected override func aboutToAppear(): Unit {
        imageWidth = if (markdownConfiguration.markdownTheme.imageFixedRatioWidth.isSome()) {
            (componentImageWidth * markdownConfiguration.markdownTheme.imageFixedRatioWidth()).px
        } else {
            (componentImageWidth * markdownConfiguration.markdownTheme.imageMaximumWidth).px
        }
        imageHeight = if (markdownConfiguration.markdownTheme.imageFixedRatioWidth.isSome()) {
            (componentImageWidth * 9.0 / 16.0 * markdownConfiguration.markdownTheme.imageFixedRatioWidth()).px
        } else {
            (componentImageWidth * 9.0 / 16.0 * markdownConfiguration.markdownTheme.imageMaximumWidth).px
        }
    }

    func build() {
        Image(destination)
            .alt(markdownConfiguration.markdownTheme.imageResource())
            .borderRadius(imageBorderRadius)
            .width(imageWidth)
            .height(imageHeight)
            .objectFit(markdownConfiguration.markdownTheme.imageFitType)
            .constraintSize(maxWidth: 100.percent)
            .autoResize(markdownConfiguration.markdownTheme.isAutoResize)
            .onClick {evt => imageSpanOnClick(isLink, imageCallback, linkCallback, linkUrl, destination)}
            .onComplete {
                imageLoadResult =>
                    let res = imageWidthHeight(picStyleObjWidth, picStyleObjHeight, componentImageWidth, imageLoadResult.height, imageLoadResult.width)
                    let imageWidthNew = res[0]
                    let imageHeightNew = res[1]
                    imageWidth = imageSpanWidth(markdownConfiguration.markdownTheme.imageFixedRatioWidth, componentImageWidth, imageWidthNew, markdownConfiguration.markdownTheme.imageMaximumWidth)
                    imageHeight = imageSpanHeight(markdownConfiguration.markdownTheme.imageFixedRatioWidth, componentImageWidth, imageWidthNew, imageHeightNew, markdownConfiguration.markdownTheme.imageMaximumWidth)
            }
    }
}
