/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * RawFile入参的图片
 */
@Component
public class MarkdownImageCallbackRawFileComponent {
    /**
     * markdown配置
     */
    var rawFileCallbackMarkdownTheme: MarkdownTheme

    /**
     * 图片链接
     */
    var rawFileCallbackDestination: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var rawFileCallbackComponentWidth: Float64

    /**
     * 图片替换事件
     */
    var rawFileCallbackImageCallbackCallback: (String) -> ?Array<UInt8>

    /**
     * 图片下载的点击事件
     */
    var rawFileCallbackImageDownloadCallback: ?(String) -> Unit

    /**
     * 图片点击事件
     */
    var rawFileCallbackImageCallback: (String) -> Unit

    /**
     * 链接点击事件
     */
    var rawFileCallbackLinkCallback: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var rawFileCallbackLink: Bool

    /**
     * 链接URL
     */
    var rawFileCallbackLinkUrl: Option<String>

    /**
     * 图片宽度
     */
    var rawFileCallbackImageWidth: Option<Length>

    /**
     * 图片高度
     */
    var rawFileCallbackImageHeight: Option<Length>

    /**
     * 图片圆角
     */
    var rawFileCallbackImageRadius: Option<Length>

    /**
     * 图片对齐方式
     */
    var rawFileCallbackImageAlign: Option<HorizontalAlign>

    /**
     * 图片加载
     */
    @State
    var rawFileCallbackImageType: Int64 = 0 // 0：开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片数据
     */
    @State
    var rawFileCallbackImagePixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 图片高度 - 单位px
     */
    @State
    var rawFileCallbackHeight: Float64 = 0.0

    /**
     * 图片宽度 - 单位px
     */
    @State
    var rawFileCallbackWidth: Float64 = 0.0

    /**
     * 图片圆角 - 单位vp
     */
    @State
    var rawFileCallbackRadius: Float64 = 0.0

    /**
     * 占位图片高度 - 单位px
     */
    @State
    var rawFileCallbackPlaceholderHeight: Float64 = 0.0

    /**
     * 占位图片宽度 - 单位px
     */
    @State
    var rawFileCallbackPlaceholderWidth: Float64 = 0.0

    /**
     * 替换之后的图片宽度 - 单位px
     */
    @State
    var rawFileCallbackReplaceWidth: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片高度 - 单位px
     */
    @State
    var rawFileCallbackReplaceHeight: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片数据
     */
    @State
    var rawFileCallbackReplaceImagePixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 解析加载
     */
    @State
    var rawFileCallbackReplaceImageType: Int64 = 0 // 0：开始解析。1：解析成功完成。2：解析失败

    /**
     * 替换子线程
     */
    var rawFileCallbackReplaceFut: ?Future<Unit> = Option<Future<Unit>>.None

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var rawFileCallbackComponentImageWidth: Float64 = 0.0

    /**
     * 解析子线程
     */
    var rawFileCallbackFut: ?Future<Unit> = Option<Future<Unit>>.None

    /**
     * 图片对齐
     */
    @State
    var urlHorizontalAlign: HorizontalAlign = HorizontalAlign.Start

    protected override func aboutToAppear(): Unit {
        rawFileCallbackComponentImageWidth = vp2px(rawFileCallbackComponentWidth.vp)().value
        rawFileCallbackRadius = imageSpanBorderRadius(rawFileCallbackImageRadius, rawFileCallbackMarkdownTheme.imageBorderRadius)
        rawFileCallbackPlaceholderWidth = if (rawFileCallbackMarkdownTheme.imageFixedRatioWidth.isSome()) {
            rawFileCallbackComponentImageWidth * rawFileCallbackMarkdownTheme.imageFixedRatioWidth()
        } else {
            rawFileCallbackComponentImageWidth * rawFileCallbackMarkdownTheme.imageMaximumWidth
        }
        rawFileCallbackPlaceholderHeight = if (rawFileCallbackMarkdownTheme.imageFixedRatioWidth.isSome()) {
            rawFileCallbackComponentImageWidth * 9.0 / 16.0 * rawFileCallbackMarkdownTheme.imageFixedRatioWidth()
        } else {
            rawFileCallbackComponentImageWidth * 9.0 / 16.0 * rawFileCallbackMarkdownTheme.imageMaximumWidth
        }
        urlHorizontalAlign = if (rawFileCallbackImageAlign.isSome()) {
            rawFileCallbackImageAlign()
        } else {
            HorizontalAlign.Start
        }
        imageCallbackPixelmap()
        localRowImageToPixelMap()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        rawFileCallbackReplaceImagePixelMap?.Release()
        rawFileCallbackReplaceImagePixelMap = Option<PixelMap>.None
        rawFileCallbackReplaceFut?.cancel()
        rawFileCallbackImagePixelMap?.Release()
        rawFileCallbackImagePixelMap = Option<PixelMap>.None
        rawFileCallbackFut?.cancel()
    }

    func build() {
        Column(){
             Column(){
                if (rawFileCallbackReplaceImageType == 1) {
                    // 替换之后的图片
                    Image(rawFileCallbackReplaceImagePixelMap())
                        .borderRadius(rawFileCallbackRadius)
                        .borderWidth(rawFileCallbackMarkdownTheme.imageBorderWidth)
                        .borderColor(rawFileCallbackMarkdownTheme.imageBorderColor)
                        .width(rawFileCallbackReplaceWidth())
                        .height(rawFileCallbackReplaceHeight())
                        .objectFit(rawFileCallbackMarkdownTheme.imageFitType)
                        .constraintSize(maxWidth: 100.percent)
                        .onClick {
                            evt => imageSpanOnClick(rawFileCallbackLink, rawFileCallbackImageCallback, rawFileCallbackLinkCallback, rawFileCallbackLinkUrl, rawFileCallbackDestination)
                        }
                }else{
                    if (rawFileCallbackImageType == 1) {
                        // 加载图片
                        Image(rawFileCallbackImagePixelMap())
                            .borderRadius(rawFileCallbackRadius)
                            .borderWidth(rawFileCallbackMarkdownTheme.imageBorderWidth)
                            .borderColor(rawFileCallbackMarkdownTheme.imageBorderColor)
                            .width(rawFileCallbackWidth.px)
                            .height(rawFileCallbackHeight.px)
                            .objectFit(rawFileCallbackMarkdownTheme.imageFitType)
                            .constraintSize(maxWidth: 100.percent)
                            .onClick {
                                evt => imageSpanOnClick(rawFileCallbackLink, rawFileCallbackImageCallback, rawFileCallbackLinkCallback, rawFileCallbackLinkUrl, rawFileCallbackDestination)
                            }
                    }
                    if (rawFileCallbackMarkdownTheme.imageResource.isSome() && rawFileCallbackImageType != 1) {
                        // 图片占位图
                        imagePlaceholderComponent(
                            rawFileCallbackMarkdownTheme.imageResource(),
                            rawFileCallbackPlaceholderWidth,
                            rawFileCallbackPlaceholderHeight,
                            rawFileCallbackRadius,
                            rawFileCallbackMarkdownTheme.imageBorderWidth,
                            rawFileCallbackMarkdownTheme.imageBorderColor
                        )
                    }
                }
            }
            .alignItems(urlHorizontalAlign)
            if(rawFileCallbackMarkdownTheme.isImageDownload){
                MarkdownImageDownloadComponent(
                    markdownTheme: rawFileCallbackMarkdownTheme,
                    destination: rawFileCallbackDestination,
                    imageDownloadCallback: rawFileCallbackImageDownloadCallback
                )
            }
        }
        .margin(top: rawFileCallbackMarkdownTheme.imageMarginTop, bottom: rawFileCallbackMarkdownTheme.imageMarginBottom)
    }

    func imageCallbackPixelmap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            imagePixelMap, imageResWidth, imageResHeight => launch {
                if (imagePixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    this.rawFileCallbackReplaceImagePixelMap = imagePixelMap
                    let res = imageWidthAndHeight(
                        rawFileCallbackComponentImageWidth,
                        imageResWidth(),
                        imageResHeight(),
                        rawFileCallbackImageWidth,
                        rawFileCallbackImageHeight,
                        rawFileCallbackMarkdownTheme.imageMaxWidth,
                        rawFileCallbackMarkdownTheme.imageMaxHeight,
                        rawFileCallbackMarkdownTheme.imageFixedRatioWidth,
                        rawFileCallbackMarkdownTheme.imageMaximumWidth
                    )
                    rawFileCallbackReplaceWidth = res[0]
                    rawFileCallbackReplaceHeight = res[1]
                    rawFileCallbackReplaceImageType = 1
                } else {
                    rawFileCallbackReplaceImageType = 2
                }
            }
        }
        rawFileCallbackReplaceFut = callbackToPixelmap(
            rawFileCallbackDestination,
            rawFileCallbackImageCallbackCallback,
            callback
        )
    }

    /**
     * 本地图片加载
     */
    func localRowImageToPixelMap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            rawFileCallbackImagePixelMap, imageResWidth, imageResHeight => launch {
                if (rawFileCallbackImagePixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    this.rawFileCallbackImagePixelMap = rawFileCallbackImagePixelMap
                    let res = imageWidthAndHeight(
                        rawFileCallbackComponentImageWidth,
                        imageResWidth(),
                        imageResHeight(),
                        rawFileCallbackImageWidth,
                        rawFileCallbackImageHeight,
                        rawFileCallbackMarkdownTheme.imageMaxWidth,
                        rawFileCallbackMarkdownTheme.imageMaxHeight,
                        rawFileCallbackMarkdownTheme.imageFixedRatioWidth,
                        rawFileCallbackMarkdownTheme.imageMaximumWidth
                    )
                    rawFileCallbackWidth = res[0]
                    rawFileCallbackHeight = res[1]
                    rawFileCallbackImageType = 1
                } else {
                    rawFileCallbackImageType = 2
                }
            }
        }
        rawFileCallbackFut = rawfileToPixelmap1(
            rawFileCallbackDestination,
            rawFileCallbackMarkdownTheme.abilityContext,
            rawFileCallbackMarkdownTheme.stageContext,
            callback
        )
    }
}
