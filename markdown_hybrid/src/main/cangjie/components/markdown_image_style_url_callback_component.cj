/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 单独图片，网络url，有样式的图片，有回调
 */
@Component
public class MarkdownImageStyleUrlCallbackComponent {
    /**
     * markdown配置
     */
    var imgStyleUrlCbConfig: MarkdownConfiguration

    /**
     * 图片链接
     */
    var imgStyleUrlCbDestination: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var imgStyleUrlCbComponentWidth: Float64

    /**
     * 图片样式
     */
    var imgStyleUrlCbStyle: ArrayList<String>

    /**
     * 图片点击事件
     */
    var imgStyleUrlCbImgCb: (String) -> Unit

    /**
     * 链接点击事件
     */
    var imgStyleUrlCbLinkCb: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var imgStyleUrlCbIsLink: Bool

    /**
     * 链接url
     */
    var imgStyleUrlCbLinkUrl: ?String

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var imgStyleUrlCbComponentImgWidth: Float64 = 0.0

    /**
     * 替换之后的图片宽度 - 单位px
     */
    @State
    var imgStyleUrlCbImgWidth: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片高度 - 单位px
     */
    @State
    var imgStyleUrlCbImgHeight: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片数据
     */
    @State
    var imgStyleUrlCbImgPixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 替换解析加载
     */
    @State
    var imgStyleUrlCbImgParse: Int64 = 0 // 0：开始解析。1：解析成功完成。2：解析失败

    /**
     * 样式图片宽度
     */
    @State
    var imgStyleUrlCbPicStyleObjWidth: ?Float64 = Option<Float64>.None

    /**
     * 样式图片高度
     */
    @State
    var imgStyleUrlCbPicStyleObjHeight: ?Float64 = Option<Float64>.None

    /**
     * 样式图片圆角
     */
    @State
    var imgStyleUrlCbRadius: Option<Length> = Option<Length>.None

    /**
     * 样式图片对齐方式
     */
    @State
    var imgStyleUrlCbAlign: FlexAlign = FlexAlign.Start

    protected override func aboutToAppear(): Unit {
        imgStyleUrlCbComponentImgWidth = vp2px(imgStyleUrlCbComponentWidth.vp)().value
        let picStyle: PicStyleObj = parsePicStyle(imgStyleUrlCbStyle, imgStyleUrlCbComponentImgWidth)
        if (picStyle.borderRadius.isSome()) {
            imgStyleUrlCbRadius = picStyle.borderRadius()
        }
        imgStyleUrlCbPicStyleObjWidth = length2Float64(picStyle.width, imgStyleUrlCbComponentImgWidth)
        imgStyleUrlCbPicStyleObjHeight = length2Float64(picStyle.height, imgStyleUrlCbComponentImgWidth)
        imgStyleUrlCbAlign = picStyle.align
        imageCallPixelmap()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        imgStyleUrlCbImgPixelMap?.Release()
        imgStyleUrlCbImgPixelMap = Option<PixelMap>.None
    }

    func build() {
        Column(){
            if (imgStyleUrlCbImgParse == 1) {
                MarkdownImageBaseRawFileComponent(
                    markdownConfiguration: imgStyleUrlCbConfig,
                    destination: imgStyleUrlCbDestination,
                    imagePixelMap: imgStyleUrlCbImgPixelMap(),
                    componentImageWidth: imgStyleUrlCbComponentImgWidth,
                    imageCallback: imgStyleUrlCbImgCb,
                    linkCallback: imgStyleUrlCbLinkCb,
                    isLink: imgStyleUrlCbIsLink,
                    linkUrl: imgStyleUrlCbLinkUrl,
                    imageBorderRadius: imageSpanBorderRadius(imgStyleUrlCbRadius, imgStyleUrlCbConfig.markdownTheme.imageBorderRadius),
                    imageWidth: imgStyleUrlCbImgWidth(),
                    imageHeight: imgStyleUrlCbImgHeight()
                )
             } else {
                if (imgStyleUrlCbConfig.markdownTheme.imageResource.isSome()) {
                    MarkdownImageBaseUrlAltComponent(
                        markdownConfiguration: imgStyleUrlCbConfig,
                        destination: imgStyleUrlCbDestination,
                        componentImageWidth: imgStyleUrlCbComponentImgWidth,
                        imageCallback: imgStyleUrlCbImgCb,
                        linkCallback: imgStyleUrlCbLinkCb,
                        isLink: imgStyleUrlCbIsLink,
                        linkUrl: imgStyleUrlCbLinkUrl,
                        imageBorderRadius: imageSpanBorderRadius(imgStyleUrlCbRadius, imgStyleUrlCbConfig.markdownTheme.imageBorderRadius),
                        picStyleObjWidth: imgStyleUrlCbPicStyleObjWidth,
                        picStyleObjHeight: imgStyleUrlCbPicStyleObjHeight
                    )
                }else {
                    MarkdownImageBaseUrlNoAltComponent(
                        markdownConfiguration: imgStyleUrlCbConfig,
                        destination: imgStyleUrlCbDestination,
                        componentImageWidth: imgStyleUrlCbComponentImgWidth,
                        imageCallback: imgStyleUrlCbImgCb,
                        linkCallback: imgStyleUrlCbLinkCb,
                        isLink: imgStyleUrlCbIsLink,
                        linkUrl: imgStyleUrlCbLinkUrl,
                        imageBorderRadius: imgStyleUrlCbConfig.markdownTheme.imageBorderRadius,
                        picStyleObjWidth: imgStyleUrlCbPicStyleObjWidth,
                        picStyleObjHeight: imgStyleUrlCbPicStyleObjHeight
                    )
                }
             }
            if(imgStyleUrlCbConfig.markdownTheme.isImageDownload){
                MarkdownImageDownloadComponent(
                    markdownConfiguration: imgStyleUrlCbConfig,
                    destination: imgStyleUrlCbDestination
                )
            }
        }
        .margin(top: imgStyleUrlCbConfig.markdownTheme.imageMarginTop, bottom: imgStyleUrlCbConfig.markdownTheme.imageMarginBottom)
    }

    func imageCallPixelmap() {
        spawn {
            let data: ?Array<UInt8> = imgStyleUrlCbConfig.imageCallbackCallback()(imgStyleUrlCbDestination)
            if (data.isSome()) {
                var imageSource: ImageSource = createImageSource(data())
                let pixelMap1: PixelMap = imageSource.createPixelMap()
                var size: Size = pixelMap1.getImageInfo().size
                let imgWidth: Float64 = Float64(size.width)
                let imgHeight: Float64 = Float64(size.height)
                imageSource.Release()
                launch {
                    imgStyleUrlCbImgWidth = imgWidth
                    imgStyleUrlCbImgHeight = imgHeight
                    imgStyleUrlCbImgPixelMap = pixelMap1
                    if (imgStyleUrlCbImgPixelMap.isSome() && imgStyleUrlCbImgWidth.isSome() && imgStyleUrlCbImgHeight.isSome()) {
                        imgStyleUrlCbImgParse = 1
                    } else {
                        imgStyleUrlCbImgParse = 2
                    }
                }
            } else {
                launch {
                    imgStyleUrlCbImgParse = 2
                }
            }
        }
    }
}
