/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 单独图片，网络url，有样式的图片，没有回调
 */
@Component
public class MarkdownImageStyleUrlComponent {
    /**
     * markdown配置
     */
    var imgStyleUrlConfig: MarkdownConfiguration

    /**
     * 图片链接
     */
    var imgStyleUrlDestination: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var imgStyleUrlComponentWidth: Float64

    /**
     * 图片样式
     */
    var imgStyleUrlStyle: ArrayList<String>

    /**
     * 图片点击事件
     */
    var imgStyleUrlImgCb: (String) -> Unit

    /**
     * 链接点击事件
     */
    var imgStyleUrlLinkCb: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var imgStyleUrlIsLink: Bool

    /**
     * 链接url
     */
    var imgStyleUrlLinkUrl: ?String

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var imgStyleUrlComponentImgWidth: Float64 = 0.0

    /**
     * 样式图片宽度
     */
    @State
    var imgStyleUrlPicStyleObjWidth: ?Float64 = Option<Float64>.None

    /**
     * 样式图片高度
     */
    @State
    var imgStyleUrlPicStyleObjHeight: ?Float64 = Option<Float64>.None

    /**
     * 样式图片圆角
     */
    @State
    var imgStyleUrlRadius: Option<Length> = Option<Length>.None

    /**
     * 样式图片对齐方式
     */
    @State
    var imgStyleUrlAlign: FlexAlign = FlexAlign.Start

    protected override func aboutToAppear(): Unit {
        imgStyleUrlComponentImgWidth = vp2px(imgStyleUrlComponentWidth.vp)().value
        let picStyle: PicStyleObj = parsePicStyle(imgStyleUrlStyle, imgStyleUrlComponentImgWidth)
        if (picStyle.borderRadius.isSome()) {
            imgStyleUrlRadius = picStyle.borderRadius()
        }
        imgStyleUrlPicStyleObjWidth = length2Float64(picStyle.width, imgStyleUrlComponentImgWidth)
        imgStyleUrlPicStyleObjHeight = length2Float64(picStyle.height, imgStyleUrlComponentImgWidth)
        imgStyleUrlAlign = picStyle.align
    }

    func build() {
        Column(){
            if (imgStyleUrlConfig.markdownTheme.imageResource.isSome()) {
                MarkdownImageBaseUrlAltComponent(
                    markdownConfiguration: imgStyleUrlConfig,
                    destination: imgStyleUrlDestination,
                    componentImageWidth: imgStyleUrlComponentWidth,
                    imageCallback: imgStyleUrlImgCb,
                    linkCallback: imgStyleUrlLinkCb,
                    isLink: imgStyleUrlIsLink,
                    linkUrl: imgStyleUrlLinkUrl,
                    imageBorderRadius: imageSpanBorderRadius(imgStyleUrlRadius, imgStyleUrlConfig.markdownTheme.imageBorderRadius),
                    picStyleObjWidth: imgStyleUrlPicStyleObjWidth,
                    picStyleObjHeight: imgStyleUrlPicStyleObjHeight
                )
            } else {
                MarkdownImageBaseUrlNoAltComponent(
                    markdownConfiguration: imgStyleUrlConfig,
                    destination: imgStyleUrlDestination,
                    componentImageWidth: imgStyleUrlComponentWidth,
                    imageCallback: imgStyleUrlImgCb,
                    linkCallback: imgStyleUrlLinkCb,
                    isLink: imgStyleUrlIsLink,
                    linkUrl: imgStyleUrlLinkUrl,
                    imageBorderRadius: imageSpanBorderRadius(imgStyleUrlRadius, imgStyleUrlConfig.markdownTheme.imageBorderRadius),
                    picStyleObjWidth: imgStyleUrlPicStyleObjWidth,
                    picStyleObjHeight: imgStyleUrlPicStyleObjHeight
                )
            }
            if(imgStyleUrlConfig.markdownTheme.isImageDownload){
                MarkdownImageDownloadComponent(
                    markdownConfiguration: imgStyleUrlConfig,
                    destination: imgStyleUrlDestination
                )
            }
        }
        .margin(top: imgStyleUrlConfig.markdownTheme.imageMarginTop, bottom: imgStyleUrlConfig.markdownTheme.imageMarginBottom)
    }
}
