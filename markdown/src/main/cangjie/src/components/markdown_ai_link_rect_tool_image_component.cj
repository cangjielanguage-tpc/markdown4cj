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
     * 链接
     */
    var strUrl: String

    /**
     * 链接内容
     */
    var strText: String

    /**
     * 链接类型
     */
    var strType: String

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

    /**
     * 图片背景颜色
     */
    var backGroupColor: Color

    /**
     * 图片最大宽度
     */
    var maxWidth: Length = 100.percent

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
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置约束尺寸
                .constraintSize(maxWidth: maxWidth)
                // 设置图片基于文本的对齐方式
                .verticalAlign(ImageSpanAlignment.CENTER)
                // 设置图片是否隐藏
                .visibility(isVisibility(strType != ""))
                // 左右外边距
                .margin(right: markdownAIConfiguration.markdownAITheme.linkRectToolImageMargin, left: markdownAIConfiguration.markdownAITheme.linkRectToolImageMargin)
                // 点击动作触发该方法调用
                .onClick {
                    evt => if (markdownAIConfiguration.linkCallback.isSome()) {
                        markdownAIConfiguration.linkCallback()(strUrl)
                    }
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
        // 解析链接
        MarkdownParseLinkUtil.linkStrToRectToolPixelMap(strText, strType, markdownAIConfiguration, callback, backGroupColor)
    }
}

func typeStringColor(str: String): (Color, Color) {
    match (str) {
        case "PDF" => return (Color(0xFFB41700), Color(180, 23, 0, alpha: 0.2))
        case "DOC" => return (Color(0xFF3D73CF), Color(61, 115, 207, alpha: 0.2))
        case "DOCX" => return (Color(0xFF3D73CF), Color(61, 115, 207, alpha: 0.2))
        case "TXT" => return (Color(0xFF000000), Color(0, 0, 0, alpha: 0.2))
        case "DEFAULT" => return (Color(0xFF000000), Color(0, 0, 0, alpha: 0.2))
        case _ => return (Color(0xFF000000), Color(0, 0, 0, alpha: 0.2))
    }
}
