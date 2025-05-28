/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 本地图片 - rawfile路径下图片
 */
@Component
public class MarkdownImageStyleSpanRawFileComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 图片链接
     */
    var destination: String

    /**
     * 图片样式
     */
    var picStyle: ArrayList<String>

    /**
     * 控件宽度 - 单位px
     */
    var componentWidth: Float64

    /**
     * 图片宽度 - 单位px
     */
    @State
    var imageWidth: ?Float64 = Option<Float64>.None

    /**
     * 图片高度 - 单位px
     */
    @State
    var imageHeight: ?Float64 = Option<Float64>.None

    /**
     * 图片数据
     */
    @State
    var imagePixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 图片高度 - 单位px
     */
    @State
    var radius: Length = 0.0.vp

    /**
     * 对齐方式
     */
    @State
    var align: FlexAlign = FlexAlign.Start

    protected override func aboutToAppear(): Unit {
        localRowImageStyleToPixelMap()
    }

    protected override func aboutToDisappear(): Unit {
        imagePixelMap?.Release()
        imagePixelMap = Option<PixelMap>.None
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
                .constraintSize(maxWidth: 100.percent)
                // 点击动作触发该方法调用
                .onClick {
                    evt => imageOnClick(destination, markdownConfiguration.imageCallback)
                }
                // 图片加载出现异常时触发该回调
                .onError({
                    imageError =>
                })
        }
    }

    /**
     * 图片数据处理 - 本地rawfile图片
     */
    func localRowImageStyleToPixelMap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            pixelMap, width, height => launch {
                this.imagePixelMap = pixelMap
                this.imageWidth = width
                this.imageHeight = height
            }
        }
        let picStyleObj: PicStyleObj = parsePicStyle(picStyle, componentWidth)
        if (picStyleObj.borderRadius.isSome()) {
            radius = picStyleObj.borderRadius()
        }
        align = picStyleObj.align
        let picStyleObjWidth: ?Float64 = length2Float64(picStyleObj.width, componentWidth)
        let picStyleObjHeight: ?Float64 = length2Float64(picStyleObj.height, componentWidth)
        let fut = rawfileToPixelmapStyle(destination, markdownConfiguration.markdownTheme.abilityContext, markdownConfiguration.markdownTheme.stageContext,componentWidth,picStyleObjWidth,picStyleObjHeight, callback)
    }
}
