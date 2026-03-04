/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * URL入参API大于等于15的图片
 */
@Component
public class MarkdownSpanImageUrl15Component {
    /**
     * markdown配置
     */
    var url15MarkdownTheme: MarkdownTheme

    /**
     * 图片链接
     */
    var url15Destination: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var url15ComponentWidth: Float64

    /**
     * 图片点击事件
     */
    var url15ImageCallback: (String) -> Unit

    /**
     * 链接点击事件
     */
    var url15LinkCallback: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var url15Link: Bool

    /**
     * 链接URL
     */
    var url15LinkUrl: Option<String>

    /**
     * 图片宽度
     */
    var url15ImageWidth: Option<Length>

    /**
     * 图片高度
     */
    var url15ImageHeight: Option<Length>

    /**
     * 图片圆角
     */
    var url15ImageRadius: Option<Length>

    /**
     * 图片对齐方式
     */
    var url15ImageAlign: Option<HorizontalAlign>

    /**
     * 图片加载
     */
    @State
    var url15ImageType: Int64 = 0 // 0：开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片高度 - 单位px
     */
    @State
    var url15Height: Float64 = 0.0

    /**
     * 图片宽度 - 单位px
     */
    @State
    var url15Width: Float64 = 0.0

    /**
     * 图片圆角 - 单位vp
     */
    @State
    var url15Radius: Float64 = 0.0

    /**
     * 占位图片高度 - 单位px
     */
    @State
    var url15PlaceholderHeight: Float64 = 0.0

    /**
     * 占位图片宽度 - 单位px
     */
    @State
    var url15PlaceholderWidth: Float64 = 0.0

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var url15ComponentImageWidth: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        url15ComponentImageWidth = vp2px(url15ComponentWidth.vp)().value
        url15Radius = imageSpanBorderRadius(url15ImageRadius, url15MarkdownTheme.imageBorderRadius)
        url15PlaceholderWidth = if (url15MarkdownTheme.imageFixedRatioWidth.isSome()) {
            url15ComponentImageWidth * url15MarkdownTheme.imageFixedRatioWidth()
        } else {
            url15ComponentImageWidth * url15MarkdownTheme.imageMaximumWidth
        }
        url15PlaceholderHeight = if (url15MarkdownTheme.imageFixedRatioWidth.isSome()) {
            url15ComponentImageWidth * 9.0 / 16.0 * url15MarkdownTheme.imageFixedRatioWidth()
        } else {
            url15ComponentImageWidth * 9.0 / 16.0 * url15MarkdownTheme.imageMaximumWidth
        }
    }

    func build() {
        if (true) {
            if (url15ImageType != 2) {
                // 加载图片
                ImageSpan(url15Destination)
                    .margin(top: url15MarkdownTheme.imageMarginTop, bottom: url15MarkdownTheme.imageMarginBottom)
                    .interopBorderRadius(url15Radius)
                    .width(url15Width.px)
                    .height(url15Height.px)
                    .objectFit(url15MarkdownTheme.imageFitType)
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    .constraintSize(maxWidth: 100.percent)
                    .onClick {
                        evt => imageSpanOnClick(url15Link, url15ImageCallback, url15LinkCallback, url15LinkUrl, url15Destination)
                    }
                    .onComplete {
                        imageLoadResult =>
                            let res = imageWidthAndHeight(
                                url15ComponentImageWidth,
                                imageLoadResult.width,
                                imageLoadResult.height,
                                url15ImageWidth,
                                url15ImageHeight,
                                url15MarkdownTheme.imageMaxHeight,
                                url15MarkdownTheme.imageFixedRatioWidth,
                                url15MarkdownTheme.imageMaximumWidth
                            )
                            url15Width = res[0]
                            url15Height = res[1]
                            url15ImageType = 1
                    }
                    .onError {
                        imageError => url15ImageType = 2
                    }
            }
            if (url15MarkdownTheme.imageResource.isSome() && url15ImageType != 1) {
                // 图片占位图
                imageSpanPlaceholderComponent(
                    url15MarkdownTheme.imageResource(),
                    url15MarkdownTheme.imageMarginTop,
                    url15MarkdownTheme.imageMarginBottom,
                    url15PlaceholderWidth,
                    url15PlaceholderHeight,
                    url15Radius
                )
            }
        }
    }
}
