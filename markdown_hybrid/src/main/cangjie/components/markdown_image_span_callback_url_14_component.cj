/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.state_macro_manage.*

/**
 * URL入参API小于15的图片
 */
@Component
public class MarkdownSpanImageCallbackUrl14Component {
    /**
     * markdown配置
     */
    var url14CallbackMarkdownTheme: MarkdownTheme

    /**
     * 图片链接
     */
    var url14CallbackDestination: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var url14CallbackComponentWidth: Float64

    /**
     * 图片替换事件
     */
    var url14CallbackImageCallbackCallback: (String) -> ?Array<UInt8>

    /**
     * 图片点击事件
     */
    var url14CallbackImageCallback: (String) -> Unit

    /**
     * 链接点击事件
     */
    var url14CallbackLinkCallback: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var url14CallbackLink: Bool

    /**
     * 链接URL
     */
    var url14CallbackLinkUrl: Option<String>

    /**
     * 图片宽度
     */
    var url14CallbackImageWidth: Option<Length>

    /**
     * 图片高度
     */
    var url14CallbackImageHeight: Option<Length>

    /**
     * 图片圆角
     */
    var url14CallbackImageRadius: Option<Length>

    /**
     * 图片对齐方式
     */
    var url14CallbackImageAlign: Option<HorizontalAlign>

    /**
     * 图片加载
     */
    @State
    var url14CallbackImageType: Int64 = 0 // 0：开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片高度 - 单位px
     */
    @State
    var url14CallbackHeight: Float64 = 0.0

    /**
     * 图片宽度 - 单位px
     */
    @State
    var url14CallbackWidth: Float64 = 0.0

    /**
     * 图片圆角 - 单位vp
     */
    @State
    var url14CallbackRadius: Float64 = 0.0

    /**
     * 占位图片高度 - 单位px
     */
    @State
    var url14CallbackPlaceholderHeight: Float64 = 0.0

    /**
     * 占位图片宽度 - 单位px
     */
    @State
    var url14CallbackPlaceholderWidth: Float64 = 0.0

    /**
     * 替换之后的图片宽度 - 单位px
     */
    @State
    var url14CallbackReplaceWidth: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片高度 - 单位px
     */
    @State
    var url14CallbackReplaceHeight: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片数据
     */
    @State
    var url14CallbackReplaceImagePixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 解析加载
     */
    @State
    var url14CallbackReplaceImageType: Int64 = 0 // 0：开始解析。1：解析成功完成。2：解析失败

    /**
     * 替换子线程
     */
    var url14CallbackReplaceFut: ?Future<Unit> = Option<Future<Unit>>.None

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var url14CallbackComponentImageWidth: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        url14CallbackComponentImageWidth = vp2px(url14CallbackComponentWidth.vp)().value
        url14CallbackRadius = imageSpanBorderRadius(url14CallbackImageRadius, url14CallbackMarkdownTheme.imageBorderRadius)
        url14CallbackPlaceholderWidth = if (url14CallbackMarkdownTheme.imageFixedRatioWidth.isSome()) {
            url14CallbackComponentImageWidth * url14CallbackMarkdownTheme.imageFixedRatioWidth()
        } else {
            url14CallbackComponentImageWidth * url14CallbackMarkdownTheme.imageMaximumWidth
        }
        url14CallbackPlaceholderHeight = if (url14CallbackMarkdownTheme.imageFixedRatioWidth.isSome()) {
            url14CallbackComponentImageWidth * 9.0 / 16.0 * url14CallbackMarkdownTheme.imageFixedRatioWidth()
        } else {
            url14CallbackComponentImageWidth * 9.0 / 16.0 * url14CallbackMarkdownTheme.imageMaximumWidth
        }
        imageCallbackPixelmap()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        url14CallbackReplaceImagePixelMap?.Release()
        url14CallbackReplaceImagePixelMap = Option<PixelMap>.None
        url14CallbackReplaceFut?.cancel()
    }

    func build() {
        if (true) {
            if (url14CallbackReplaceImageType == 1) {
                // 替换之后的图片
                ImageSpan(url14CallbackReplaceImagePixelMap())
                    .margin(top: url14CallbackMarkdownTheme.imageMarginTop, bottom: url14CallbackMarkdownTheme.imageMarginBottom)
                    .interopBorderRadius(url14CallbackRadius)
                    .borderWidth(url14CallbackMarkdownTheme.imageBorderWidth)
                    .borderColor(url14CallbackMarkdownTheme.imageBorderColor)
                    .width(url14CallbackReplaceWidth().px)
                    .height(url14CallbackReplaceHeight().px)
                    .objectFit(url14CallbackMarkdownTheme.imageFitType)
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    .constraintSize(maxWidth: 100.percent)
                    .onClick {
                        evt => imageSpanOnClick(url14CallbackLink, url14CallbackImageCallback, url14CallbackLinkCallback, url14CallbackLinkUrl, url14CallbackDestination)
                    }
            }else{
                if (url14CallbackImageType != 2) {
                    // 加载图片
                    ImageSpan(url14CallbackDestination)
                        .margin(top: url14CallbackMarkdownTheme.imageMarginTop, bottom: url14CallbackMarkdownTheme.imageMarginBottom)
                        .interopBorderRadius(url14CallbackRadius)
                        .borderWidth(url14CallbackMarkdownTheme.imageBorderWidth)
                        .borderColor(url14CallbackMarkdownTheme.imageBorderColor)
                        .width(url14CallbackWidth.px)
                        .height(url14CallbackHeight.px)
                        .objectFit(url14CallbackMarkdownTheme.imageFitType)
                        .verticalAlign(ImageSpanAlignment.CENTER)
                        .constraintSize(maxWidth: 100.percent)
                        .onClick {
                            evt => imageSpanOnClick(url14CallbackLink, url14CallbackImageCallback, url14CallbackLinkCallback, url14CallbackLinkUrl, url14CallbackDestination)
                        }
                        .interopOnComplete {
                            imageLoadResult =>
                                let res = imageWidthAndHeight(
                                    url14CallbackComponentImageWidth,
                                    imageLoadResult.width,
                                    imageLoadResult.height,
                                    url14CallbackImageWidth,
                                    url14CallbackImageHeight,
                                    url14CallbackMarkdownTheme.imageMaxWidth,
                                    url14CallbackMarkdownTheme.imageMaxHeight,
                                    url14CallbackMarkdownTheme.imageFixedRatioWidth,
                                    url14CallbackMarkdownTheme.imageMaximumWidth
                                )
                                url14CallbackWidth = res[0]
                                url14CallbackHeight = res[1]
                                url14CallbackImageType = 1
                        }
                        .interopOnError {
                            imageError => url14CallbackImageType = 2
                        }
                }
                if (url14CallbackMarkdownTheme.imageResource.isSome() && url14CallbackImageType != 1) {
                    // 图片占位图
                    imageSpanPlaceholderComponent(
                        url14CallbackMarkdownTheme.imageResource(),
                        url14CallbackMarkdownTheme.imageMarginTop,
                        url14CallbackMarkdownTheme.imageMarginBottom,
                        url14CallbackPlaceholderWidth,
                        url14CallbackPlaceholderHeight,
                        url14CallbackRadius,
                        url14CallbackMarkdownTheme.imageBorderWidth,
                        url14CallbackMarkdownTheme.imageBorderColor
                    )
                }
            }
        }
    }

    func imageCallbackPixelmap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            imagePixelMap, imageResWidth, imageResHeight => launch {
                if (imagePixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    this.url14CallbackReplaceImagePixelMap = imagePixelMap
                    let res = imageWidthAndHeight(
                        url14CallbackComponentImageWidth,
                        imageResWidth(),
                        imageResHeight(),
                        url14CallbackImageWidth,
                        url14CallbackImageHeight,
                        url14CallbackMarkdownTheme.imageMaxWidth,
                        url14CallbackMarkdownTheme.imageMaxHeight,
                        url14CallbackMarkdownTheme.imageFixedRatioWidth,
                        url14CallbackMarkdownTheme.imageMaximumWidth
                    )
                    url14CallbackReplaceWidth = res[0]
                    url14CallbackReplaceHeight = res[1]
                    url14CallbackReplaceImageType = 1
                } else {
                    url14CallbackReplaceImageType = 2
                }
            }
        }
        url14CallbackReplaceFut = callbackToPixelmap(
            url14CallbackDestination,
            url14CallbackImageCallbackCallback,
            callback
        )
    }
}
