/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * RawFile入参的图片
 */
@Component
public class MarkdownSpanImageRawFileComponent {
    /**
     * markdown配置
     */
    var rawFileMarkdownTheme: MarkdownTheme

    /**
     * 图片链接
     */
    var rawFileDestination: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var rawFileComponentWidth: Float64

    /**
     * 图片点击事件
     */
    var rawFileImageCallback: (String) -> Unit

    /**
     * 链接点击事件
     */
    var rawFileLinkCallback: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var rawFileLink: Bool

    /**
     * 链接URL
     */
    var rawFileLinkUrl: Option<String>

    /**
     * 图片宽度
     */
    var rawFileImageWidth: Option<Length>

    /**
     * 图片高度
     */
    var rawFileImageHeight: Option<Length>

    /**
     * 图片圆角
     */
    var rawFileImageRadius: Option<Length>

    /**
     * 图片对齐方式
     */
    var rawFileImageAlign: Option<HorizontalAlign>

    /**
     * 图片加载
     */
    @State
    var rawFileImageType: Int64 = 0 // 0：开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片数据
     */
    @State
    var rawFileImagePixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 图片高度 - 单位px
     */
    @State
    var rawFileHeight: Float64 = 0.0

    /**
     * 图片宽度 - 单位px
     */
    @State
    var rawFileWidth: Float64 = 0.0

    /**
     * 图片圆角 - 单位vp
     */
    @State
    var rawFileRadius: Float64 = 0.0

    /**
     * 占位图片高度 - 单位px
     */
    @State
    var rawFilePlaceholderHeight: Float64 = 0.0

    /**
     * 占位图片宽度 - 单位px
     */
    @State
    var rawFilePlaceholderWidth: Float64 = 0.0

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var rawFileComponentImageWidth: Float64 = 0.0

    /**
     * 解析子线程
     */
    var rawFileFut: ?Future<Unit> = Option<Future<Unit>>.None

    protected override func aboutToAppear(): Unit {
        rawFileComponentImageWidth = vp2px(rawFileComponentWidth.vp)().value
        rawFileRadius = imageSpanBorderRadius(rawFileImageRadius, rawFileMarkdownTheme.imageBorderRadius)
        rawFilePlaceholderWidth = if (rawFileMarkdownTheme.imageFixedRatioWidth.isSome()) {
            rawFileComponentImageWidth * rawFileMarkdownTheme.imageFixedRatioWidth()
        } else {
            rawFileComponentImageWidth * rawFileMarkdownTheme.imageMaximumWidth
        }
        rawFilePlaceholderHeight = if (rawFileMarkdownTheme.imageFixedRatioWidth.isSome()) {
            rawFileComponentImageWidth * 9.0 / 16.0 * rawFileMarkdownTheme.imageFixedRatioWidth()
        } else {
            rawFileComponentImageWidth * 9.0 / 16.0 * rawFileMarkdownTheme.imageMaximumWidth
        }
        imageRawFilePixelMap()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        rawFileImagePixelMap?.Release()
        rawFileImagePixelMap = Option<PixelMap>.None
        rawFileFut?.cancel()
    }

    func build() {
        if (true) {
            if (rawFileImageType == 1) {
                // 加载图片
                ImageSpan(rawFileImagePixelMap())
                    .margin(top: rawFileMarkdownTheme.imageMarginTop, bottom: rawFileMarkdownTheme.imageMarginBottom)
                    .interopBorderRadius(rawFileRadius)
                    .width(rawFileWidth.px)
                    .height(rawFileHeight.px)
                    .objectFit(rawFileMarkdownTheme.imageFitType)
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    .constraintSize(maxWidth: 100.percent)
                    .onClick {
                        evt => imageSpanOnClick(rawFileLink, rawFileImageCallback, rawFileLinkCallback, rawFileLinkUrl, rawFileDestination)
                    }
            }
            if (rawFileMarkdownTheme.imageResource.isSome() && rawFileImageType != 1) {
                // 图片占位图
                imageSpanPlaceholderComponent(
                    rawFileMarkdownTheme.imageResource(),
                    rawFileMarkdownTheme.imageMarginTop,
                    rawFileMarkdownTheme.imageMarginBottom,
                    rawFilePlaceholderWidth,
                    rawFilePlaceholderHeight,
                    rawFileRadius
                )
            }
        }
    }

    /**
     * 本地图片加载
     */
    func imageRawFilePixelMap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            rawFileImagePixelMap, imageResWidth, imageResHeight => launch {
                if (rawFileImagePixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    this.rawFileImagePixelMap = rawFileImagePixelMap
                    let res = imageWidthAndHeight(
                        rawFileComponentImageWidth,
                        imageResWidth(),
                        imageResHeight(),
                        rawFileImageWidth,
                        rawFileImageHeight,
                        rawFileMarkdownTheme.imageFixedRatioWidth,
                        rawFileMarkdownTheme.imageMaximumWidth
                    )
                    rawFileWidth = res[0]
                    rawFileHeight = res[1]
                    rawFileImageType = 1
                } else {
                    rawFileImageType = 2
                }
            }
        }
        rawFileFut = rawfileToPixelmap1(
            rawFileDestination,
            rawFileMarkdownTheme.abilityContext,
            rawFileMarkdownTheme.stageContext,
            callback
        )
    }
}
