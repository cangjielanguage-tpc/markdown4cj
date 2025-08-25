/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 行内数学公式
 */
@Component
public class MarkdownAILatexImageSpanComponent {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 控件宽度 - 单位px
     */
    var componentWidth: Float64

    /**
     * 数学公示内容
     */
    var strLatexMath: String

    /**
     * 数学公式高度
     */
    @State
    var imageHeight: ?Float64 = Option<Float64>.None

    /**
     * 数学公式宽度
     */
    @State
    var imageWidth: ?Float64 = Option<Float64>.None

    /**
     * 数学公式图片信息
     */
    @State
    var imagePixelMap: ?PixelMap = Option<PixelMap>.None

    /**
     * 数学公式数组信息
     */
    var arrayUint8: ?Array<UInt8> = Option<Array<UInt8>>.None

    /**
     * 图片背景颜色
     */
    var backGroupColor: Color

    /**
     * 图片最大宽度
     */
    var maxWidth: Length = 100.percent

    protected override func aboutToAppear(): Unit {
        // 数学公式解析
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
                // 设置组件自身的宽度
                .width(imageWidth().px)
                // 设置组件自身的高度
                .height(imageHeight().px)
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置约束尺寸
                .constraintSize(maxWidth: maxWidth)
                // 设置图片基于文本的对齐方式
                .verticalAlign(ImageSpanAlignment.CENTER)
                // 点击动作触发该方法调用
                .onClick {
                    evt => latexImageOnClick(arrayUint8(), imageHeight().px, imageWidth().px, markdownAIConfiguration.latexImageCallback)
                }
        }
    }

    /**
     * 数学公式数据处理 - 行内数学公式
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
        // 解析数学公式
        MarkdownParseLatexUtil.latexMathStrToPixelMapRow(strLatexMath, markdownAIConfiguration, componentWidth, callback, backGroupColor)
    }
}
