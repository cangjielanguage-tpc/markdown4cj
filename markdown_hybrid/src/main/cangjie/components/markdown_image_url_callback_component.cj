/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 单独图片，网络url，普通图片，有回调
 */
@Component
public class MarkdownImageUrlCallbackComponent {
    /**
     * markdown配置
     */
    var imgUrlCbConfig: MarkdownConfiguration

    /**
     * 图片链接
     */
    var imgUrlCbDestination: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var imgUrlCbComponentWidth: Float64

    /**
     * 图片点击事件
     */
    var imgUrlCbImgCb: (String) -> Unit

    /**
     * 链接点击事件
     */
    var imgUrlCbLinkCb: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var imgUrlCbIsLink: Bool

    /**
     * 链接url
     */
    var imgUrlCbLinkUrl: ?String

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var imgUrlCbComponentImgWidth: Float64 = 0.0

    /**
     * 替换之后的图片宽度 - 单位px
     */
    @State
    var imgUrlCbImgWidth: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片高度 - 单位px
     */
    @State
    var imgUrlCbImgHeight: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片数据
     */
    @State
    var imgUrlCbImgPixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 替换解析加载
     */
    @State
    var imgUrlCbImgParse: Int64 = 0 // 0：开始解析。1：解析成功完成。2：解析失败

    protected override func aboutToAppear(): Unit {
        imgUrlCbComponentImgWidth = vp2px(imgUrlCbComponentWidth.vp)().value
        imageCallPixelmap()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        imgUrlCbImgPixelMap?.Release()
        imgUrlCbImgPixelMap = Option<PixelMap>.None
    }

    func build() {
        Column(){
            if (imgUrlCbImgParse == 1) {
                MarkdownImageBaseRawFileComponent(
                    markdownConfiguration: imgUrlCbConfig,
                    destination: imgUrlCbDestination,
                    imagePixelMap: imgUrlCbImgPixelMap(),
                    componentImageWidth: imgUrlCbComponentImgWidth,
                    imageCallback: imgUrlCbImgCb,
                    linkCallback: imgUrlCbLinkCb,
                    isLink: imgUrlCbIsLink,
                    linkUrl: imgUrlCbLinkUrl,
                    imageBorderRadius: imgUrlCbConfig.markdownTheme.imageBorderRadius,
                    imageWidth: imgUrlCbImgWidth(),
                    imageHeight: imgUrlCbImgHeight()
                )
            } else {
                if (imgUrlCbConfig.markdownTheme.imageResource.isSome()) {
                    MarkdownImageBaseUrlAltComponent(
                        markdownConfiguration: imgUrlCbConfig,
                        destination: imgUrlCbDestination,
                        componentImageWidth: imgUrlCbComponentImgWidth,
                        imageCallback: imgUrlCbImgCb,
                        linkCallback: imgUrlCbLinkCb,
                        isLink: imgUrlCbIsLink,
                        linkUrl: imgUrlCbLinkUrl,
                        imageBorderRadius: imgUrlCbConfig.markdownTheme.imageBorderRadius
                    )
                } else {
                    MarkdownImageBaseUrlNoAltComponent(
                        markdownConfiguration: imgUrlCbConfig,
                        destination: imgUrlCbDestination,
                        componentImageWidth: imgUrlCbComponentImgWidth,
                        imageCallback: imgUrlCbImgCb,
                        linkCallback: imgUrlCbLinkCb,
                        isLink: imgUrlCbIsLink,
                        linkUrl: imgUrlCbLinkUrl,
                        imageBorderRadius: imgUrlCbConfig.markdownTheme.imageBorderRadius
                    )
                }
            }
            if(imgUrlCbConfig.markdownTheme.isImageDownload){
                MarkdownImageDownloadComponent(
                    markdownConfiguration: imgUrlCbConfig,
                    destination: imgUrlCbDestination
                )
            }
        }
        .margin(top: imgUrlCbConfig.markdownTheme.imageMarginTop, bottom: imgUrlCbConfig.markdownTheme.imageMarginBottom)
    }

    func imageCallPixelmap() {
        spawn {
            let data: ?Array<UInt8> = imgUrlCbConfig.imageCallbackCallback()(imgUrlCbDestination)
            if (data.isSome()) {
                var imageSource: ImageSource = createImageSource(data())
                let pixelMap1: PixelMap = imageSource.createPixelMap()
                var size: Size = pixelMap1.getImageInfo().size
                let imgWidth: Float64 = Float64(size.width)
                let imgHeight: Float64 = Float64(size.height)
                imageSource.Release()
                launch {
                    imgUrlCbImgWidth = imgWidth
                    imgUrlCbImgHeight = imgHeight
                    imgUrlCbImgPixelMap = pixelMap1
                    if (imgUrlCbImgPixelMap.isSome() && imgUrlCbImgWidth.isSome() && imgUrlCbImgHeight.isSome()) {
                        imgUrlCbImgParse = 1
                    } else {
                        imgUrlCbImgParse = 2
                    }
                }
            } else {
                launch {
                    imgUrlCbImgParse = 2
                }
            }
        }
    }
}
