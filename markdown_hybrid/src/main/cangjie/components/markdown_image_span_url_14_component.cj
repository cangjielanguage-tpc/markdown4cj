/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * URL入参API小于15的图片
 */
@Component
public class MarkdownSpanImageUrl14Component {
    /**
     * markdown配置
     */
    var url14MarkdownTheme: MarkdownTheme

    /**
     * 图片链接
     */
    var url14Destination: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var url14ComponentWidth: Float64

    /**
     * 图片点击事件
     */
    var url14ImageCallback: (String) -> Unit

    /**
     * 链接点击事件
     */
    var url14LinkCallback: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var url14Link: Bool

    /**
     * 链接URL
     */
    var url14LinkUrl: Option<String>

    /**
     * 图片宽度
     */
    var url14ImageWidth: Option<Length>

    /**
     * 图片高度
     */
    var url14ImageHeight: Option<Length>

    /**
     * 图片圆角
     */
    var url14ImageRadius: Option<Length>

    /**
     * 图片对齐方式
     */
    var url14ImageAlign: Option<HorizontalAlign>

    /**
     * 图片加载
     */
    @State
    var url14ImageType: Int64 = 0 // 0：开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片高度 - 单位px
     */
    @State
    var url14Height: Float64 = 0.0

    /**
     * 图片宽度 - 单位px
     */
    @State
    var url14Width: Float64 = 0.0

    /**
     * 图片圆角 - 单位vp
     */
    @State
    var url14Radius: Float64 = 0.0

    /**
     * 占位图片高度 - 单位px
     */
    @State
    var url14PlaceholderHeight: Float64 = 0.0

    /**
     * 占位图片宽度 - 单位px
     */
    @State
    var url14PlaceholderWidth: Float64 = 0.0

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var url14ComponentImageWidth: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        url14ComponentImageWidth = vp2px(url14ComponentWidth.vp)().value
        url14Radius = imageSpanBorderRadius(url14ImageRadius, url14MarkdownTheme.imageBorderRadius)
        url14PlaceholderWidth = if (url14MarkdownTheme.imageFixedRatioWidth.isSome()) {
            url14ComponentImageWidth * url14MarkdownTheme.imageFixedRatioWidth()
        } else {
            url14ComponentImageWidth * url14MarkdownTheme.imageMaximumWidth
        }
        url14PlaceholderHeight = if (url14MarkdownTheme.imageFixedRatioWidth.isSome()) {
            url14ComponentImageWidth * 9.0 / 16.0 * url14MarkdownTheme.imageFixedRatioWidth()
        } else {
            url14ComponentImageWidth * 9.0 / 16.0 * url14MarkdownTheme.imageMaximumWidth
        }
    }

    func build() {
        if (true) {
            if (url14ImageType != 2) {
                // 加载图片
                ImageSpan(url14Destination)
                    .margin(top: url14MarkdownTheme.imageMarginTop, bottom: url14MarkdownTheme.imageMarginBottom)
                    .interopBorderRadius(url14Radius)
                    .width(url14Width.px)
                    .height(url14Height.px)
                    .objectFit(url14MarkdownTheme.imageFitType)
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    .constraintSize(maxWidth: 100.percent)
                    .onClick {
                        evt => imageSpanOnClick(url14Link, url14ImageCallback, url14LinkCallback, url14LinkUrl, url14Destination)
                    }
                    .interopOnComplete {
                        imageLoadResult =>
                            let res = imageWidthAndHeight(
                                url14ComponentImageWidth,
                                imageLoadResult.width,
                                imageLoadResult.height,
                                url14ImageWidth,
                                url14ImageHeight,
                                url14MarkdownTheme.imageFixedRatioWidth,
                                url14MarkdownTheme.imageMaximumWidth
                            )
                            url14Width = res[0]
                            url14Height = res[1]
                            url14ImageType = 1
                    }
                    .interopOnError {
                        imageError => url14ImageType = 2
                    }
            }
            if (url14MarkdownTheme.imageResource.isSome() && url14ImageType != 1) {
                // 图片占位图
                imageSpanPlaceholderComponent(
                    url14MarkdownTheme.imageResource(),
                    url14MarkdownTheme.imageMarginTop,
                    url14MarkdownTheme.imageMarginBottom,
                    url14PlaceholderWidth,
                    url14PlaceholderHeight,
                    url14Radius
                )
            }
        }
    }
}
