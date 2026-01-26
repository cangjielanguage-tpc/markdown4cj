/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 单独图片，网络url，普通图片，没有回调
 */
@Component
public class MarkdownImageUrlComponent {
    /**
     * markdown配置
     */
    var imgUrlConfig: MarkdownConfiguration

    /**
     * 图片链接
     */
    var imgUrlDestination: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var imgUrlComponentWidth: Float64

    /**
     * 图片点击事件
     */
    var imgUrlImgCb: (String) -> Unit

    /**
     * 链接点击事件
     */
    var imgUrlLinkCb: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var imgUrlIsLink: Bool

    /**
     * 链接url
     */
    var imgUrlLinkUrl: ?String

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var imgUrlComponentImgWidth: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        imgUrlComponentImgWidth = vp2px(imgUrlComponentWidth.vp)().value
    }

    func build() {
        Column(){
            if (imgUrlConfig.markdownTheme.imageResource.isSome()) {
                MarkdownImageBaseUrlAltComponent(
                    markdownConfiguration: imgUrlConfig,
                    destination: imgUrlDestination,
                    componentImageWidth: imgUrlComponentImgWidth,
                    imageCallback: imgUrlImgCb,
                    linkCallback: imgUrlLinkCb,
                    isLink: imgUrlIsLink,
                    linkUrl: imgUrlLinkUrl,
                    imageBorderRadius: imgUrlConfig.markdownTheme.imageBorderRadius
                )
            } else {
                MarkdownImageBaseUrlNoAltComponent(
                    markdownConfiguration: imgUrlConfig,
                    destination: imgUrlDestination,
                    componentImageWidth: imgUrlComponentImgWidth,
                    imageCallback: imgUrlImgCb,
                    linkCallback: imgUrlLinkCb,
                    isLink: imgUrlIsLink,
                    linkUrl: imgUrlLinkUrl,
                    imageBorderRadius: imgUrlConfig.markdownTheme.imageBorderRadius
                )
            }
            if(imgUrlConfig.markdownTheme.isImageDownload){
                MarkdownImageDownloadComponent(
                    markdownConfiguration: imgUrlConfig,
                    destination: imgUrlDestination
                )
            }
        }
        .margin(top: imgUrlConfig.markdownTheme.imageMarginTop, bottom: imgUrlConfig.markdownTheme.imageMarginBottom)
    }
}
