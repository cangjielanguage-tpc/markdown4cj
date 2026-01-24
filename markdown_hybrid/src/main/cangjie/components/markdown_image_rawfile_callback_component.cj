/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 单独图片，本地url，普通图片，有回调
 */
@Component
public class MarkdownImageRawFileCallbackComponent {
    /**
     * markdown配置
     */
    var imgRawFileCbConfig: MarkdownConfiguration

    /**
     * 图片链接
     */
    var imgRawFileCbDestination: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var imgRawFileCbComponentWidth: Float64

    /**
     * 图片点击事件
     */
    var imgRawFileCbImgCb: (String) -> Unit

    /**
     * 链接点击事件
     */
    var imgRawFileCbLinkCb: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var imgRawFileCbIsLink: Bool

    /**
     * 链接url
     */
    var imgRawFileCbLinkUrl: ?String

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var imgRawFileCbComponentImgWidth: Float64 = 0.0

    /**
     * 图片宽度 - 单位px
     */
    @State
    var imgRawFileCbImgWidth: ?Float64 = Option<Float64>.None

    /**
     * 图片高度 - 单位px
     */
    @State
    var imgRawFileCbImgHeight: ?Float64 = Option<Float64>.None

    /**
     * 图片数据
     */
    @State
    var imgRawFileCbImgPixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 图片解析加载
     */
    @State
    var imgRawFileCbImgParse: Int64 = 0 // 0：开始解析。1：解析成功完成。2：解析失败

    /**
     * 替换之后的图片宽度 - 单位px
     */
    @State
    var imgRawFileCbCbImgWidth: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片高度 - 单位px
     */
    @State
    var imgRawFileCbCbImgHeight: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片数据
     */
    @State
    var imgRawFileCbCbImgPixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 替换解析加载
     */
    @State
    var imgRawFileCbCbImgParse: Int64 = 0 // 0：开始解析。1：解析成功完成。2：解析失败

    protected override func aboutToAppear(): Unit {
        imgRawFileCbComponentImgWidth = vp2px(imgRawFileCbComponentWidth.vp)().value
        imageCallPixelmap()
        localRowImageToPixelMap()
    }

    protected override func aboutToDisappear(): Unit {
        imgRawFileCbImgPixelMap?.Release()
        imgRawFileCbImgPixelMap = Option<PixelMap>.None
        imgRawFileCbCbImgPixelMap?.Release()
        imgRawFileCbCbImgPixelMap = Option<PixelMap>.None
    }

    func build() {
        Column(){
            if (imgRawFileCbCbImgParse == 1) {
                MarkdownImageBaseRawFileComponent(
                    markdownConfiguration: imgRawFileCbConfig,
                    destination: imgRawFileCbDestination,
                    imagePixelMap: imgRawFileCbCbImgPixelMap(),
                    componentImageWidth: imgRawFileCbComponentImgWidth,
                    imageCallback: imgRawFileCbImgCb,
                    linkCallback: imgRawFileCbLinkCb,
                    isLink: imgRawFileCbIsLink,
                    linkUrl: imgRawFileCbLinkUrl,
                    imageBorderRadius: imgRawFileCbConfig.markdownTheme.imageBorderRadius,
                    imageWidth: imgRawFileCbCbImgWidth(),
                    imageHeight: imgRawFileCbCbImgHeight()
                )
            } else {
                if (imgRawFileCbImgParse == 1) {
                    MarkdownImageBaseRawFileComponent(
                        markdownConfiguration: imgRawFileCbConfig,
                        destination: imgRawFileCbDestination,
                        imagePixelMap: imgRawFileCbImgPixelMap(),
                        componentImageWidth: imgRawFileCbComponentImgWidth,
                        imageCallback: imgRawFileCbImgCb,
                        linkCallback: imgRawFileCbLinkCb,
                        isLink: imgRawFileCbIsLink,
                        linkUrl: imgRawFileCbLinkUrl,
                        imageBorderRadius: imgRawFileCbConfig.markdownTheme.imageBorderRadius,
                        imageWidth: imgRawFileCbImgWidth(),
                        imageHeight: imgRawFileCbImgHeight()
                    )
                } else {
                    if (imgRawFileCbConfig.markdownTheme.imageResource.isSome()) {
                        MarkdownImageBaseRawFileAltComponent(
                            markdownConfiguration: imgRawFileCbConfig,
                            imageBorderRadius: imgRawFileCbConfig.markdownTheme.imageBorderRadius,
                            imageWidth: if (imgRawFileCbConfig.markdownTheme.imageFixedRatioWidth.isSome()) {
                                (imgRawFileCbComponentImgWidth * imgRawFileCbConfig.markdownTheme.imageFixedRatioWidth()).px
                            } else {
                                (imgRawFileCbComponentImgWidth * imgRawFileCbConfig.markdownTheme.imageMaximumWidth).px
                            },
                            imageHeight: if (imgRawFileCbConfig.markdownTheme.imageFixedRatioWidth.isSome()) {
                                (imgRawFileCbComponentImgWidth * 9.0 / 16.0 * imgRawFileCbConfig.markdownTheme.imageFixedRatioWidth()).px
                            } else {
                                (imgRawFileCbComponentImgWidth * 9.0 / 16.0 * imgRawFileCbConfig.markdownTheme.imageMaximumWidth).px
                            }
                        )
                    }
                }
            }
            if(imgRawFileCbConfig.markdownTheme.isImageDownload){
                MarkdownImageDownloadComponent(
                    markdownConfiguration: imgRawFileCbConfig,
                    destination: imgRawFileCbDestination
                )
            }
        }
        // 设置外边距属性
        .margin(top: imgRawFileCbConfig.markdownTheme.imageMarginTop, bottom: imgRawFileCbConfig.markdownTheme.imageMarginBottom)
    }

    func imageCallPixelmap() {
        spawn {
            let data: ?Array<UInt8> = imgRawFileCbConfig.imageCallbackCallback()(imgRawFileCbDestination)
            if (data.isSome()) {
                var imageSource: ImageSource = createImageSource(data())
                let pixelMap: PixelMap = imageSource.createPixelMap()
                var sizeRawFileCallback: Size = pixelMap.getImageInfo().size
                let width: Float64 = Float64(sizeRawFileCallback.width)
                let height: Float64 = Float64(sizeRawFileCallback.height)
                imageSource.Release()
                launch {
                    imgRawFileCbCbImgPixelMap = pixelMap
                    imgRawFileCbCbImgWidth = width
                    imgRawFileCbCbImgHeight = height
                    if (imgRawFileCbCbImgPixelMap.isSome() && imgRawFileCbCbImgWidth.isSome() && imgRawFileCbCbImgHeight.isSome()) {
                        imgRawFileCbCbImgParse = 1
                    } else {
                        imgRawFileCbCbImgParse = 2
                    }
                }
            } else {
                launch {
                    imgRawFileCbCbImgParse = 2
                }
            }
        }
    }

    /**
     * 图片数据处理 - 本地rawfile图片
     */
    func localRowImageToPixelMap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            pixelMap, width, height => launch {
                imgRawFileCbImgPixelMap = pixelMap
                imgRawFileCbImgWidth = width
                imgRawFileCbImgHeight = height
                if (imgRawFileCbImgPixelMap.isSome() && imgRawFileCbImgWidth.isSome() && imgRawFileCbImgHeight.isSome()) {
                    imgRawFileCbImgParse = 1
                } else {
                    imgRawFileCbImgParse = 2
                }
            }
        }
        let fut = rawfileToPixelmap(imgRawFileCbDestination, imgRawFileCbConfig.markdownTheme.abilityContext, imgRawFileCbConfig.markdownTheme.stageContext, imgRawFileCbComponentImgWidth, callback)
    }
}
