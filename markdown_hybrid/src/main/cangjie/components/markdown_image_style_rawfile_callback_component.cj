/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 单独图片，本地url，有样式的图片，有回调
 */
@Component
public class MarkdownImageStyleRawFileCallBackComponent {
    /**
     * markdown配置
     */
    var imgStyleRawFileCbConfig: MarkdownConfiguration

    /**
     * 图片链接
     */
    var imgStyleRawFileCbDestination: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var imgStyleRawFileCbComponentWidth: Float64

    /**
     * 图片样式
     */
    var imgStyleRawFileCbStyle: ArrayList<String>

    /**
     * 图片点击事件
     */
    var imgStyleRawFileCbImgCb: (String) -> Unit

    /**
     * 链接点击事件
     */
    var imgStyleRawFileCbLinkCb: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var imgStyleRawFileCbIsLink: Bool

    /**
     * 链接url
     */
    var imgStyleRawFileCbLinkUrl: ?String

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var imgStyleRawFileCbComponentImgWidth: Float64 = 0.0

    /**
     * 图片宽度 - 单位px
     */
    @State
    var imgStyleRawFileCbImgWidth: ?Float64 = Option<Float64>.None

    /**
     * 图片高度 - 单位px
     */
    @State
    var imgStyleRawFileCbImgHeight: ?Float64 = Option<Float64>.None

    /**
     * 图片数据
     */
    @State
    var imgStyleRawFileCbImgPixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 图片解析加载
     */
    @State
    var imgStyleRawFileCbImgParse: Int64 = 0 // 0：开始解析。1：解析成功完成。2：解析失败

    /**
     * 替换之后的图片宽度 - 单位px
     */
    @State
    var imgStyleRawFileCbCbImgWidth: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片高度 - 单位px
     */
    @State
    var imgStyleRawFileCbCbImgHeight: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片数据
     */
    @State
    var imgStyleRawFileCbCbImgPixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 替换解析加载
     */
    @State
    var imgStyleRawFileCbCbImgParse: Int64 = 0 // 0：开始解析。1：解析成功完成。2：解析失败

    /**
     * 样式图片宽度
     */
    @State
    var imgStyleRawFileCbPicStyleObjWidth: ?Float64 = Option<Float64>.None

    /**
     * 样式图片高度
     */
    @State
    var imgStyleRawFileCbPicStyleObjHeight: ?Float64 = Option<Float64>.None

    /**
     * 样式图片圆角
     */
    @State
    var imgStyleRawFileCbRadius: Option<Length> = Option<Length>.None

    /**
     * 样式图片对齐方式
     */
    @State
    var imgStyleRawFileCbAlign: FlexAlign = FlexAlign.Start

    protected override func aboutToAppear(): Unit {
        imgStyleRawFileCbComponentImgWidth = vp2px(imgStyleRawFileCbComponentWidth.vp)().value
        let picStyle: PicStyleObj = parsePicStyle(imgStyleRawFileCbStyle, imgStyleRawFileCbComponentImgWidth)
        if (picStyle.borderRadius.isSome()) {
            imgStyleRawFileCbRadius = picStyle.borderRadius()
        }
        imgStyleRawFileCbPicStyleObjWidth = length2Float64(picStyle.width, imgStyleRawFileCbComponentImgWidth)
        imgStyleRawFileCbPicStyleObjHeight = length2Float64(picStyle.height, imgStyleRawFileCbComponentImgWidth)
        imgStyleRawFileCbAlign = picStyle.align
        imageCallPixelmap()
        localRowImageToPixelMap()
    }

    protected override func aboutToDisappear(): Unit {
        imgStyleRawFileCbImgPixelMap?.Release()
        imgStyleRawFileCbImgPixelMap = Option<PixelMap>.None
        imgStyleRawFileCbCbImgPixelMap?.Release()
        imgStyleRawFileCbCbImgPixelMap = Option<PixelMap>.None
    }

    func build() {
        Column(){
            if (imgStyleRawFileCbCbImgParse == 1) {
                MarkdownImageBaseRawFileComponent(
                    markdownConfiguration: imgStyleRawFileCbConfig,
                    destination: imgStyleRawFileCbDestination,
                    imagePixelMap: imgStyleRawFileCbCbImgPixelMap(),
                    componentImageWidth: imgStyleRawFileCbComponentImgWidth,
                    imageCallback: imgStyleRawFileCbImgCb,
                    linkCallback: imgStyleRawFileCbLinkCb,
                    isLink: imgStyleRawFileCbIsLink,
                    linkUrl: imgStyleRawFileCbLinkUrl,
                    imageBorderRadius: imageSpanBorderRadius(imgStyleRawFileCbRadius, imgStyleRawFileCbConfig.markdownTheme.imageBorderRadius),
                    imageWidth: imgStyleRawFileCbCbImgWidth(),
                    imageHeight: imgStyleRawFileCbCbImgHeight()
                )
            } else {
                if (imgStyleRawFileCbImgParse == 1) {
                    MarkdownImageBaseRawFileComponent(
                        markdownConfiguration: imgStyleRawFileCbConfig,
                        destination: imgStyleRawFileCbDestination,
                        imagePixelMap: imgStyleRawFileCbImgPixelMap(),
                        componentImageWidth: imgStyleRawFileCbComponentImgWidth,
                        imageCallback: imgStyleRawFileCbImgCb,
                        linkCallback: imgStyleRawFileCbLinkCb,
                        isLink: imgStyleRawFileCbIsLink,
                        linkUrl: imgStyleRawFileCbLinkUrl,
                        imageBorderRadius: imageSpanBorderRadius(imgStyleRawFileCbRadius, imgStyleRawFileCbConfig.markdownTheme.imageBorderRadius),
                        imageWidth: imgStyleRawFileCbImgWidth(),
                        imageHeight: imgStyleRawFileCbImgHeight()
                    )
                } else {
                    if (imgStyleRawFileCbConfig.markdownTheme.imageResource.isSome()) {
                        MarkdownImageBaseRawFileAltComponent(
                            markdownConfiguration: imgStyleRawFileCbConfig,
                            imageBorderRadius: imgStyleRawFileCbConfig.markdownTheme.imageBorderRadius,
                            imageWidth: if (imgStyleRawFileCbConfig.markdownTheme.imageFixedRatioWidth.isSome()) {
                                (imgStyleRawFileCbComponentImgWidth * imgStyleRawFileCbConfig.markdownTheme.imageFixedRatioWidth()).px
                            } else {
                                (imgStyleRawFileCbComponentImgWidth * imgStyleRawFileCbConfig.markdownTheme.imageMaximumWidth).px
                            },
                            imageHeight: if (imgStyleRawFileCbConfig.markdownTheme.imageFixedRatioWidth.isSome()) {
                                (imgStyleRawFileCbComponentImgWidth * 9.0 / 16.0 * imgStyleRawFileCbConfig.markdownTheme.imageFixedRatioWidth()).px
                            } else {
                                (imgStyleRawFileCbComponentImgWidth * 9.0 / 16.0 * imgStyleRawFileCbConfig.markdownTheme.imageMaximumWidth).px
                            }
                        )
                    }
                }
            }
            if(imgStyleRawFileCbConfig.markdownTheme.isImageDownload){
                MarkdownImageDownloadComponent(
                    markdownConfiguration: imgStyleRawFileCbConfig,
                    destination: imgStyleRawFileCbDestination
                )
            }
        }
        // 设置外边距属性
        .margin(top: imgStyleRawFileCbConfig.markdownTheme.imageMarginTop, bottom: imgStyleRawFileCbConfig.markdownTheme.imageMarginBottom)
    }

    func imageCallPixelmap() {
        spawn {
            let data: ?Array<UInt8> = imgStyleRawFileCbConfig.imageCallbackCallback()(imgStyleRawFileCbDestination)
            if (data.isSome()) {
                var imageSource: ImageSource = createImageSource(data())
                let pixelMap: PixelMap = imageSource.createPixelMap()
                var sizeRawFileCallback: Size = pixelMap.getImageInfo().size
                let width: Float64 = Float64(sizeRawFileCallback.width)
                let height: Float64 = Float64(sizeRawFileCallback.height)
                imageSource.Release()
                launch {
                    imgStyleRawFileCbCbImgPixelMap = pixelMap
                    imgStyleRawFileCbCbImgWidth = width
                    imgStyleRawFileCbCbImgHeight = height
                    if (imgStyleRawFileCbCbImgPixelMap.isSome() && imgStyleRawFileCbCbImgWidth.isSome() && imgStyleRawFileCbCbImgHeight.isSome()) {
                        imgStyleRawFileCbCbImgParse = 1
                    } else {
                        imgStyleRawFileCbCbImgParse = 2
                    }
                }
            } else {
                launch {
                    imgStyleRawFileCbCbImgParse = 2
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
                imgStyleRawFileCbImgPixelMap = pixelMap
                imgStyleRawFileCbImgWidth = width
                imgStyleRawFileCbImgHeight = height
                if (imgStyleRawFileCbImgPixelMap.isSome() && imgStyleRawFileCbImgWidth.isSome() && imgStyleRawFileCbImgHeight.isSome()) {
                    imgStyleRawFileCbImgParse = 1
                } else {
                    imgStyleRawFileCbImgParse = 2
                }
            }
        }
        let fut = rawfileToPixelmapStyle(imgStyleRawFileCbDestination, imgStyleRawFileCbConfig.markdownTheme.abilityContext, imgStyleRawFileCbConfig.markdownTheme.stageContext, imgStyleRawFileCbComponentImgWidth, imgStyleRawFileCbPicStyleObjWidth, imgStyleRawFileCbPicStyleObjHeight, callback)
    }
}
