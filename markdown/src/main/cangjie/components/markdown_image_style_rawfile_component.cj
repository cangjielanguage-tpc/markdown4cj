/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 单独图片，本地url，有样式的图片，没有回调
 */
@Component
public class MarkdownImageStyleRawFileComponent {
    /**
     * markdown配置
     */
    var imgStyleRawFileConfig: MarkdownConfiguration

    /**
     * 图片链接
     */
    var imgStyleRawFileDestination: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var imgStyleRawFileComponentWidth: Float64

    /**
     * 图片样式
     */
    var imgStyleRawFileStyle: ArrayList<String>

    /**
     * 图片点击事件
     */
    var imgStyleRawFileImgCb: (String) -> Unit

    /**
     * 链接点击事件
     */
    var imgStyleRawFileLinkCb: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var imgStyleRawFileIsLink: Bool

    /**
     * 链接url
     */
    var imgStyleRawFileLinkUrl: ?String

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var imgStyleRawFileComponentImgWidth: Float64 = 0.0

    /**
     * 样式图片宽度
     */
    @State
    var imgStyleRawFilePicStyleObjWidth: ?Float64 = Option<Float64>.None

    /**
     * 样式图片高度
     */
    @State
    var imgStyleRawFilePicStyleObjHeight: ?Float64 = Option<Float64>.None

    /**
     * 样式图片圆角
     */
    @State
    var imgStyleRawFileRadius: Option<Length> = Option<Length>.None

    /**
     * 样式图片对齐方式
     */
    @State
    var imgStyleRawFileAlign: FlexAlign = FlexAlign.Start

    /**
     * 图片宽度 - 单位px
     */
    @State
    var imgStyleRawFileImgWidth: ?Float64 = Option<Float64>.None

    /**
     * 图片高度 - 单位px
     */
    @State
    var imgStyleRawFileImgHeight: ?Float64 = Option<Float64>.None

    /**
     * 图片数据
     */
    @State
    var imgStyleRawFileImgPixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 解析加载
     */
    @State
    var imgStyleRawFileImgParse: Int64 = 0 // 0：开始解析。1：解析成功完成。2：解析失败

    protected override func aboutToAppear(): Unit {
        imgStyleRawFileComponentImgWidth = vp2px(imgStyleRawFileComponentWidth.vp)().value
        let picStyle: PicStyleObj = parsePicStyle(imgStyleRawFileStyle, imgStyleRawFileComponentImgWidth)
        if (picStyle.borderRadius.isSome()) {
            imgStyleRawFileRadius = picStyle.borderRadius()
        }
        imgStyleRawFilePicStyleObjWidth = length2Float64(picStyle.width, imgStyleRawFileComponentImgWidth)
        imgStyleRawFilePicStyleObjHeight = length2Float64(picStyle.height, imgStyleRawFileComponentImgWidth)
        imgStyleRawFileAlign = picStyle.align
        localRowImageToPixelMap()
    }

    protected override func aboutToDisappear(): Unit {
        imgStyleRawFileImgPixelMap?.Release()
        imgStyleRawFileImgPixelMap = Option<PixelMap>.None
    }

    func build() {
        Column(){
            if (imgStyleRawFileImgParse == 1) {
                MarkdownImageBaseRawFileComponent(
                    markdownConfiguration: imgStyleRawFileConfig,
                    destination: imgStyleRawFileDestination,
                    imagePixelMap: imgStyleRawFileImgPixelMap(),
                    componentImageWidth: imgStyleRawFileComponentImgWidth,
                    imageCallback: imgStyleRawFileImgCb,
                    linkCallback: imgStyleRawFileLinkCb,
                    isLink: imgStyleRawFileIsLink,
                    linkUrl: imgStyleRawFileLinkUrl,
                    imageBorderRadius: imageSpanBorderRadius(imgStyleRawFileRadius, imgStyleRawFileConfig.markdownTheme.imageBorderRadius),
                    imageWidth: imgStyleRawFileImgWidth(),
                    imageHeight: imgStyleRawFileImgHeight()
                )
            } else {
                if (imgStyleRawFileConfig.markdownTheme.imageResource.isSome()) {
                    MarkdownImageBaseRawFileAltComponent(
                        markdownConfiguration: imgStyleRawFileConfig,
                        imageBorderRadius: imgStyleRawFileConfig.markdownTheme.imageBorderRadius,
                        imageWidth: if (imgStyleRawFileConfig.markdownTheme.imageFixedRatioWidth.isSome()) {
                            (imgStyleRawFileComponentImgWidth * imgStyleRawFileConfig.markdownTheme.imageFixedRatioWidth()).px
                        } else {
                            (imgStyleRawFileComponentImgWidth * imgStyleRawFileConfig.markdownTheme.imageMaximumWidth).px
                        },
                        imageHeight: if (imgStyleRawFileConfig.markdownTheme.imageFixedRatioWidth.isSome()) {
                            (imgStyleRawFileComponentImgWidth * 9.0 / 16.0 * imgStyleRawFileConfig.markdownTheme.imageFixedRatioWidth()).px
                        } else {
                            (imgStyleRawFileComponentImgWidth * 9.0 / 16.0 * imgStyleRawFileConfig.markdownTheme.imageMaximumWidth).px
                        }
                    )
                }
            }
            if(imgStyleRawFileConfig.markdownTheme.isImageDownload){
                MarkdownImageDownloadComponent(
                    markdownConfiguration: imgStyleRawFileConfig,
                    destination: imgStyleRawFileDestination
                )
            }
        }
        .margin(top: imgStyleRawFileConfig.markdownTheme.imageMarginTop, bottom: imgStyleRawFileConfig.markdownTheme.imageMarginBottom)
    }

    /**
     * 图片数据处理 - 本地rawfile图片
     */
    func localRowImageToPixelMap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            pixelMap, width, height => launch {
                imgStyleRawFileImgPixelMap = pixelMap
                imgStyleRawFileImgWidth = width
                imgStyleRawFileImgHeight = height
                if (imgStyleRawFileImgPixelMap.isSome() && imgStyleRawFileImgWidth.isSome() && imgStyleRawFileImgHeight.isSome()) {
                    imgStyleRawFileImgParse = 1
                } else {
                    imgStyleRawFileImgParse = 2
                }
            }
        }
        let fut = rawfileToPixelmapStyle(imgStyleRawFileDestination, imgStyleRawFileConfig.markdownTheme.abilityContext, imgStyleRawFileConfig.markdownTheme.stageContext, imgStyleRawFileComponentImgWidth, imgStyleRawFilePicStyleObjWidth, imgStyleRawFilePicStyleObjHeight, callback)
    }
}
