/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 单独图片，本地url，普通图片，没有回调
 */
@Component
public class MarkdownImageRawFileComponent {
    /**
     * markdown配置
     */
    var imgRawFileConfig: MarkdownConfiguration

    /**
     * 图片链接
     */
    var imgRawFileDestination: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var imgRawFileComponentWidth: Float64

    /**
     * 图片点击事件
     */
    var imgRawFileImgCb: (String) -> Unit

    /**
     * 链接点击事件
     */
    var imgRawFileLinkCb: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var imgRawFileIsLink: Bool

    /**
     * 链接url
     */
    var imgRawFileLinkUrl: ?String

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var imgRawFileComponentImgWidth: Float64 = 0.0

    /**
     * 图片宽度 - 单位px
     */
    @State
    var imgRawFileImgWidth: ?Float64 = Option<Float64>.None

    /**
     * 图片高度 - 单位px
     */
    @State
    var imgRawFileImgHeight: ?Float64 = Option<Float64>.None

    /**
     * 图片数据
     */
    @State
    var imgRawFileImgPixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 解析加载
     */
    @State
    var imgRawFileImgParse: Int64 = 0 // 0：开始解析。1：解析成功完成。2：解析失败

    protected override func aboutToAppear(): Unit {
        imgRawFileComponentImgWidth = vp2px(imgRawFileComponentWidth.vp)().value
        localRowImageToPixelMap()
    }

    protected override func aboutToDisappear(): Unit {
        imgRawFileImgPixelMap?.Release()
        imgRawFileImgPixelMap = Option<PixelMap>.None
    }

    func build() {
        Column(){
            if (imgRawFileImgParse == 1) {
                MarkdownImageBaseRawFileComponent(
                    markdownConfiguration: imgRawFileConfig,
                    destination: imgRawFileDestination,
                    imagePixelMap: imgRawFileImgPixelMap(),
                    componentImageWidth: imgRawFileComponentImgWidth,
                    imageCallback: imgRawFileImgCb,
                    linkCallback: imgRawFileLinkCb,
                    isLink: imgRawFileIsLink,
                    linkUrl: imgRawFileLinkUrl,
                    imageBorderRadius: imgRawFileConfig.markdownTheme.imageBorderRadius,
                    imageWidth: imgRawFileImgWidth(),
                    imageHeight: imgRawFileImgHeight()
                )
            } else {
                if (imgRawFileConfig.markdownTheme.imageResource.isSome()) {
                    MarkdownImageBaseRawFileAltComponent(
                        markdownConfiguration: imgRawFileConfig,
                        imageBorderRadius: imgRawFileConfig.markdownTheme.imageBorderRadius,
                        imageWidth: if (imgRawFileConfig.markdownTheme.imageFixedRatioWidth.isSome()) {
                            (imgRawFileComponentImgWidth * imgRawFileConfig.markdownTheme.imageFixedRatioWidth()).px
                        } else {
                            (imgRawFileComponentImgWidth * imgRawFileConfig.markdownTheme.imageMaximumWidth).px
                        },
                        imageHeight: if (imgRawFileConfig.markdownTheme.imageFixedRatioWidth.isSome()) {
                            (imgRawFileComponentImgWidth * 9.0 / 16.0 * imgRawFileConfig.markdownTheme.imageFixedRatioWidth()).px
                        } else {
                            (imgRawFileComponentImgWidth * 9.0 / 16.0 * imgRawFileConfig.markdownTheme.imageMaximumWidth).px
                        }
                    )
                }
            }
            if(imgRawFileConfig.markdownTheme.isImageDownload){
                MarkdownImageDownloadComponent(
                    markdownConfiguration: imgRawFileConfig,
                    destination: imgRawFileDestination
                )
            }
        }
        .margin(top: imgRawFileConfig.markdownTheme.imageMarginTop, bottom: imgRawFileConfig.markdownTheme.imageMarginBottom)
    }

    /**
     * 图片数据处理 - 本地rawfile图片
     */
    func localRowImageToPixelMap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            pixelMap, width, height => launch {
                imgRawFileImgPixelMap = pixelMap
                imgRawFileImgWidth = width
                imgRawFileImgHeight = height
                if (imgRawFileImgPixelMap.isSome() && imgRawFileImgWidth.isSome() && imgRawFileImgHeight.isSome()) {
                    imgRawFileImgParse = 1
                } else {
                    imgRawFileImgParse = 2
                }
            }
        }
        let fut = rawfileToPixelmap(imgRawFileDestination, imgRawFileConfig.markdownTheme.abilityContext, imgRawFileConfig.markdownTheme.stageContext, imgRawFileComponentImgWidth, callback)
    }
}
