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
public class MarkdownImageCallbackUrlComponent {
    /**
     * markdown配置
     */
    var urlCallbackMarkdownTheme: MarkdownTheme

    /**
     * 图片链接
     */
    var urlCallbackDestination: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var urlCallbackComponentWidth: Float64

    /**
     * 图片替换事件
     */
    var urlCallbackImageCallbackCallback: (String) -> ?Array<UInt8>

    /**
     * 图片下载的点击事件
     */
    var urlCallbackImageDownloadCallback: ?(String) -> Unit

    /**
     * 图片点击事件
     */
    var urlCallbackImageCallback: (String) -> Unit

    /**
     * 链接点击事件
     */
    var urlCallbackLinkCallback: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var urlCallbackLink: Bool

    /**
     * 链接URL
     */
    var urlCallbackLinkUrl: Option<String>

    /**
     * 图片宽度
     */
    var urlCallbackImageWidth: Option<Length>

    /**
     * 图片高度
     */
    var urlCallbackImageHeight: Option<Length>

    /**
     * 图片圆角
     */
    var urlCallbackImageRadius: Option<Length>

    /**
     * 图片对齐方式
     */
    var urlCallbackImageAlign: Option<HorizontalAlign>

    /**
     * 图片加载
     */
    @State
    var urlCallbackImageType: Int64 = 0 // 0：开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片高度 - 单位px
     */
    @State
    var urlCallbackHeight: Float64 = 0.0

    /**
     * 图片宽度 - 单位px
     */
    @State
    var urlCallbackWidth: Float64 = 0.0

    /**
     * 图片圆角 - 单位vp
     */
    @State
    var urlCallbackRadius: Float64 = 0.0

    /**
     * 占位图片高度 - 单位px
     */
    @State
    var urlCallbackPlaceholderHeight: Float64 = 0.0

    /**
     * 占位图片宽度 - 单位px
     */
    @State
    var urlCallbackPlaceholderWidth: Float64 = 0.0

    /**
     * 替换之后的图片宽度 - 单位px
     */
    @State
    var urlCallbackReplaceWidth: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片高度 - 单位px
     */
    @State
    var urlCallbackReplaceHeight: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片数据
     */
    @State
    var urlCallbackReplaceImagePixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 解析加载
     */
    @State
    var urlCallbackReplaceImageType: Int64 = 0 // 0：开始解析。1：解析成功完成。2：解析失败

    /**
     * 替换子线程
     */
    var urlCallbackReplaceFut: ?Future<Unit> = Option<Future<Unit>>.None

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var urlCallbackComponentImageWidth: Float64 = 0.0

    /**
     * 图片对齐
     */
    @State
    var urlHorizontalAlign: HorizontalAlign = HorizontalAlign.Start

    protected override func aboutToAppear(): Unit {
        urlCallbackComponentImageWidth = vp2px(urlCallbackComponentWidth.vp)().value
        urlCallbackRadius = imageSpanBorderRadius(urlCallbackImageRadius, urlCallbackMarkdownTheme.imageBorderRadius)
        urlCallbackPlaceholderWidth = if (urlCallbackMarkdownTheme.imageFixedRatioWidth.isSome()) {
            urlCallbackComponentImageWidth * urlCallbackMarkdownTheme.imageFixedRatioWidth()
        } else {
            urlCallbackComponentImageWidth * urlCallbackMarkdownTheme.imageMaximumWidth
        }
        urlCallbackPlaceholderHeight = if (urlCallbackMarkdownTheme.imageFixedRatioWidth.isSome()) {
            urlCallbackComponentImageWidth * 9.0 / 16.0 * urlCallbackMarkdownTheme.imageFixedRatioWidth()
        } else {
            urlCallbackComponentImageWidth * 9.0 / 16.0 * urlCallbackMarkdownTheme.imageMaximumWidth
        }
        urlHorizontalAlign = if(urlCallbackImageAlign.isSome()){
            urlCallbackImageAlign()
        } else {
            HorizontalAlign.Start
        }
        imageCallbackPixelmap()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        urlCallbackReplaceImagePixelMap?.Release()
        urlCallbackReplaceImagePixelMap = Option<PixelMap>.None
        urlCallbackReplaceFut?.cancel()
    }

    func build() {
         Column(){
             Column(){
                if (urlCallbackReplaceImageType == 1) {
                    // 替换之后的图片
                    Image(urlCallbackReplaceImagePixelMap())
                        .borderRadius(urlCallbackRadius)
                        .width(urlCallbackReplaceWidth())
                        .height(urlCallbackReplaceHeight())
                        .objectFit(urlCallbackMarkdownTheme.imageFitType)
                        .constraintSize(maxWidth: 100.percent)
                        .onClick {
                            evt => imageSpanOnClick(urlCallbackLink, urlCallbackImageCallback, urlCallbackLinkCallback, urlCallbackLinkUrl, urlCallbackDestination)
                        }
                }else{
                    if (urlCallbackImageType != 2) {
                        // 加载图片
                        Image(urlCallbackDestination)
                            .borderRadius(urlCallbackRadius)
                            .width(urlCallbackWidth.px)
                            .height(urlCallbackHeight.px)
                            .objectFit(urlCallbackMarkdownTheme.imageFitType)
                            .constraintSize(maxWidth: 100.percent)
                            .onClick {
                                evt => imageSpanOnClick(urlCallbackLink, urlCallbackImageCallback, urlCallbackLinkCallback, urlCallbackLinkUrl, urlCallbackDestination)
                            }
                            .onComplete {
                                imageLoadResult =>
                                    let res = imageWidthAndHeight(
                                        urlCallbackComponentImageWidth,
                                        imageLoadResult.width,
                                        imageLoadResult.height,
                                        urlCallbackImageWidth,
                                        urlCallbackImageHeight,
                                        urlCallbackMarkdownTheme.imageFixedRatioWidth,
                                        urlCallbackMarkdownTheme.imageMaximumWidth
                                    )
                                    urlCallbackWidth = res[0]
                                    urlCallbackHeight = res[1]
                                    urlCallbackImageType = 1
                            }
                            .onError {
                                imageError => urlCallbackImageType = 2
                            }
                    }
                    if (urlCallbackMarkdownTheme.imageResource.isSome() && urlCallbackImageType != 1) {
                        // 图片占位图
                        imagePlaceholderComponent(
                            urlCallbackMarkdownTheme.imageResource(),
                            urlCallbackPlaceholderWidth,
                            urlCallbackPlaceholderHeight,
                            urlCallbackRadius
                        )
                    }
                }
            }
            .alignItems(urlHorizontalAlign)
            if(urlCallbackMarkdownTheme.isImageDownload){
                MarkdownImageDownloadComponent(
                    markdownTheme: urlCallbackMarkdownTheme,
                    destination: urlCallbackDestination,
                    imageDownloadCallback: urlCallbackImageDownloadCallback
                )
            }
        }
        .margin(top: urlCallbackMarkdownTheme.imageMarginTop, bottom: urlCallbackMarkdownTheme.imageMarginBottom)
    }

    func imageCallbackPixelmap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            imagePixelMap, imageResWidth, imageResHeight => launch {
                if (imagePixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    this.urlCallbackReplaceImagePixelMap = imagePixelMap
                    let res = imageWidthAndHeight(
                        urlCallbackComponentImageWidth,
                        imageResWidth(),
                        imageResHeight(),
                        urlCallbackImageWidth,
                        urlCallbackImageHeight,
                        urlCallbackMarkdownTheme.imageFixedRatioWidth,
                        urlCallbackMarkdownTheme.imageMaximumWidth
                    )
                    urlCallbackReplaceWidth = res[0]
                    urlCallbackReplaceHeight = res[1]
                    urlCallbackReplaceImageType = 1
                } else {
                    urlCallbackReplaceImageType = 2
                }
            }
        }
        urlCallbackReplaceFut = callbackToPixelmap(
            urlCallbackDestination,
            urlCallbackImageCallbackCallback,
            callback
        )
    }
}
