/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 内联代码
 */
@Component
public class MarkdownCodeLineImageSpanComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 内联代码
     */
    var strCode: String

    /**
     * 链接
     */
    var strUrl: ?String

    /**
     * 内联代码高度
     */
    @State
    var imageHeight: ?Float64 = Option<Float64>.None

    /**
     * 内联代码宽度
     */
    @State
    var imageWidth: ?Float64 = Option<Float64>.None

    /**
     * 内联代码图片信息
     */
    @State
    var imagePixelMap: ?PixelMap = Option<PixelMap>.None

    /**
     * 内联代码数组信息
     */
    var arrayUint8: ?Array<UInt8> = Option<Array<UInt8>>.None

    /**
     * 图片最大宽度
     */
    var maxWidth: Length = 100.percent

    var isFakeBoldText: Bool = false

    protected override func aboutToAppear(): Unit {
        // 链接解析
        codeLinePixelmap()
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
                    evt => if (markdownConfiguration.linkCallback.isSome() && strUrl.isSome()) {
                        markdownConfiguration.linkCallback()(strUrl())
                    }
                }
        }
    }

    /**
     * 链接数据处理
     */
    func codeLinePixelmap(): Unit {
        let callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit = {
            pixelMap, height, width, arr => launch {
                imageHeight = height
                imageWidth = width
                imagePixelMap = pixelMap
                arrayUint8 = arr
            }
        }
        // 解析内联代码
        MarkdownParseCodeUtil.codeStrToRectPixelMap(strCode, markdownConfiguration, isFakeBoldText, callback)
    }
}
