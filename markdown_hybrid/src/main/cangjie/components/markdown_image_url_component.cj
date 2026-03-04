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
public class MarkdownImageUrlComponent {
    /**
     * markdown配置
     */
    var urlMarkdownTheme: MarkdownTheme

    /**
     * 图片链接
     */
    var urlDestination: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var urlComponentWidth: Float64

    /**
     * 图片下载的点击事件
     */
    var urlImageDownloadCallback: ?(String) -> Unit

    /**
     * 图片点击事件
     */
    var urlImageCallback: (String) -> Unit

    /**
     * 链接点击事件
     */
    var urlLinkCallback: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var urlLink: Bool

    /**
     * 链接URL
     */
    var urlLinkUrl: Option<String>

    /**
     * 图片宽度
     */
    var urlImageWidth: Option<Length>

    /**
     * 图片高度
     */
    var urlImageHeight: Option<Length>

    /**
     * 图片圆角
     */
    var urlImageRadius: Option<Length>

    /**
     * 图片对齐方式
     */
    var urlImageAlign: Option<HorizontalAlign>

    /**
     * 图片加载
     */
    @State
    var urlImageType: Int64 = 0 // 0：开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片高度 - 单位px
     */
    @State
    var urlHeight: Float64 = 0.0

    /**
     * 图片宽度 - 单位px
     */
    @State
    var urlWidth: Float64 = 0.0

    /**
     * 图片圆角 - 单位vp
     */
    @State
    var urlRadius: Float64 = 0.0

    /**
     * 占位图片高度 - 单位px
     */
    @State
    var urlPlaceholderHeight: Float64 = 0.0

    /**
     * 占位图片宽度 - 单位px
     */
    @State
    var urlPlaceholderWidth: Float64 = 0.0

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var urlComponentImageWidth: Float64 = 0.0

    /**
     * 图片对齐
     */
    @State
    var urlHorizontalAlign: HorizontalAlign = HorizontalAlign.Start

    protected override func aboutToAppear(): Unit {
        urlComponentImageWidth = vp2px(urlComponentWidth.vp)().value
        urlRadius = imageSpanBorderRadius(urlImageRadius, urlMarkdownTheme.imageBorderRadius)
        urlPlaceholderWidth = if (urlMarkdownTheme.imageFixedRatioWidth.isSome()) {
            urlComponentImageWidth * urlMarkdownTheme.imageFixedRatioWidth()
        } else {
            urlComponentImageWidth * urlMarkdownTheme.imageMaximumWidth
        }
        urlPlaceholderHeight = if (urlMarkdownTheme.imageFixedRatioWidth.isSome()) {
            urlComponentImageWidth * 9.0 / 16.0 * urlMarkdownTheme.imageFixedRatioWidth()
        } else {
            urlComponentImageWidth * 9.0 / 16.0 * urlMarkdownTheme.imageMaximumWidth
        }
        urlHorizontalAlign = if(urlImageAlign.isSome()){
            urlImageAlign()
        } else {
            HorizontalAlign.Start
        }
    }

    func build() {
        Column(){
            Column(){
                if (urlImageType != 2) {
                    // 加载图片
                    Image(urlDestination)
                        .borderRadius(urlRadius)
                        .width(urlWidth.px)
                        .height(urlHeight.px)
                        .objectFit(urlMarkdownTheme.imageFitType)
                        .constraintSize(maxWidth: 100.percent)
                        .onClick {
                            evt => imageSpanOnClick(urlLink, urlImageCallback, urlLinkCallback, urlLinkUrl, urlDestination)
                        }
                        .onComplete {
                            imageLoadResult =>
                                let res = imageWidthAndHeight(
                                    urlComponentImageWidth,
                                    imageLoadResult.width,
                                    imageLoadResult.height,
                                    urlImageWidth,
                                    urlImageHeight,
                                    urlMarkdownTheme.imageMaxHeight,
                                    urlMarkdownTheme.imageFixedRatioWidth,
                                    urlMarkdownTheme.imageMaximumWidth
                                )
                                urlWidth = res[0]
                                urlHeight = res[1]
                                urlImageType = 1
                        }
                        .onError {
                            imageError => urlImageType = 2
                        }
                }
                if (urlMarkdownTheme.imageResource.isSome() && urlImageType != 1) {
                    // 图片占位图
                    imagePlaceholderComponent(
                        urlMarkdownTheme.imageResource(),
                        urlPlaceholderWidth,
                        urlPlaceholderHeight,
                        urlRadius
                    )
                }
            }
            .alignItems(urlHorizontalAlign)
            if(urlMarkdownTheme.isImageDownload){
                MarkdownImageDownloadComponent(
                    markdownTheme: urlMarkdownTheme,
                    destination: urlDestination,
                    imageDownloadCallback: urlImageDownloadCallback
                )
            }
        }
        .margin(top: urlMarkdownTheme.imageMarginTop, bottom: urlMarkdownTheme.imageMarginBottom)
    }
}
