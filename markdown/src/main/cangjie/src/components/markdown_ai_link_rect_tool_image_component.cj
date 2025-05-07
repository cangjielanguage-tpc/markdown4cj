/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 行内链接
 */
@Component
public class MarkdownAILinkRectToolImageComponent {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 链接内容
     */
    var strUrl: String

    /**
     * 链接高度
     */
    @State
    var imageHeight: ?Float64 = Option<Float64>.None

    /**
     * 链接宽度
     */
    @State
    var imageWidth: ?Float64 = Option<Float64>.None

    /**
     * 链接图片信息
     */
    @State
    var imagePixelMap: ?PixelMap = Option<PixelMap>.None

    /**
     * 链接数组信息
     */
    var arrayUint8: ?Array<UInt8> = Option<Array<UInt8>>.None

    protected override func aboutToAppear(): Unit {
        // 链接解析
        latexMathImagePixelmap()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存
        imagePixelMap?.Release()
        imagePixelMap = Option<PixelMap>.None
        arrayUint8 = Option<Array<UInt8>>.None
    }

    func build() {
        if (imagePixelMap.isSome() && imageHeight.isSome() && imageWidth.isSome()) {
            ImageSpan(imagePixelMap())
                // 设置组件自身的高度
                .height(imageHeight().px)
                // 设置组件自身的宽度
                .width(imageWidth().px)
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置约束尺寸
                .constraintSize(maxWidth: 100.percent)
                // 点击动作触发该方法调用
                .onClick {
                    evt => latexImageOnClick(arrayUint8(), imageHeight().px, imageWidth().px, markdownAIConfiguration.latexImageCallback)
                }
        }
    }

    /**
     * 链接数据处理 - 行内链接
     */
    func latexMathImagePixelmap(): Unit {
        let callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit = {
            pixelMap, height, width, arr => launch {
                imageHeight = height
                imageWidth = width
                imagePixelMap = pixelMap
                arrayUint8 = arr
            }
        }
//        // 解析链接
//        MarkdownParseLinkUtil.latexMathStrToPixelMapRow(strUrl, markdownAIConfiguration.markdownAITheme.resPath, markdownAIConfiguration, componentWidth, callback)
    }
}