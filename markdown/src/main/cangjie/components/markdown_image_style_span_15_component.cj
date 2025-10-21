/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 网络图片、沙盒图片
 */
@Component
public class MarkdownImageStyleSpan15Component {
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
    var width: Float64 = 0.0

    /**
     * 图片高度 - 单位px
     */
    @State
    var height: Float64 = 0.0

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

    /**
     * 图片点击事件
     */
    var imageCallback: (String) -> Unit

    func build() {
        ImageSpan(destination)
            // 设置组件自身的宽度
            .width(width.px)
            // 设置组件自身的高度
            .height(height.px)
            // 设置图片的缩放类型
            .objectFit(ImageFit.Contain)
            // 设置约束尺寸
            .constraintSize(maxWidth: 100.percent)
            // 设置元素的边框圆角半径
            .borderRadius(radius)
            // 点击动作触发该方法调用
            .onClick {
                evt => imageOnClick(destination, imageCallback)
            }
            // 图片成功加载时触发该回调，返回成功加载的图片尺寸
            .onComplete(
                {
                    imageLoadResult =>
                        let picStyleObj: PicStyleObj = parsePicStyle(picStyle, componentWidth)
                        let aspectRatio: Float64 = imageLoadResult.height / imageLoadResult.width
                        let widthNew = if (componentWidth > imageLoadResult.width) {
                            imageLoadResult.width
                        } else {
                            componentWidth
                        }
                        let heightNew = widthNew * aspectRatio
                        let picStyleObjWidth: ?Float64 = length2Float64(picStyleObj.width, componentWidth)
                        let picStyleObjHeight: ?Float64 = length2Float64(picStyleObj.height, componentWidth)
                        if (picStyleObjWidth.isSome() && picStyleObjHeight.isSome()) {
                            let aspectRatioNew: Float64 = picStyleObjHeight() / picStyleObjWidth()
                            width = if (componentWidth > picStyleObjWidth()) {
                                picStyleObjWidth()
                            } else {
                                componentWidth
                            }
                            height = width * aspectRatioNew
                        } else if (picStyleObjWidth.isSome() && picStyleObjHeight.isNone()) {
                            width = if (componentWidth > picStyleObjWidth()) {
                                picStyleObjWidth()
                            } else {
                                componentWidth
                            }
                            height = width * aspectRatio
                        } else if (picStyleObjWidth.isNone() && picStyleObjHeight.isSome()) {
                            width = if (componentWidth > picStyleObjHeight() / aspectRatio) {
                                picStyleObjHeight() / aspectRatio
                            } else {
                                componentWidth
                            }
                            height = width * aspectRatio
                        } else {
                            width = widthNew
                            height = heightNew
                        }
                        if (picStyleObj.borderRadius.isSome()) {
                            radius = picStyleObj.borderRadius()
                        }
                        align = picStyleObj.align
                }
            )
    }
}
