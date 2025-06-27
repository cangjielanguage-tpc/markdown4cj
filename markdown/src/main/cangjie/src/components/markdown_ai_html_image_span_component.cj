/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * HTML图片
 */
@Component
public class MarkdownAIHtmlImageSpanComponent {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 图片内容
     */
    var destination: String

    /**
     * 图片高度
     */
    var strHeight: ?String

    /**
     * 图片宽度
     */
    var strWidth: ?String

    /**
     * 图片点击事件
     */
    var imageCallback: (String) -> Unit

    /**
     * 图片高度
     */
    @State
    var imageHeight: ?Float64 = Option<Float64>.None

    /**
     * 图片宽度
     */
    @State
    var imageWidth: ?Float64 = Option<Float64>.None

    protected override func aboutToAppear(): Unit {
        // 转换宽度
        if (let Some(v) <- strWidth) {
            imageWidth = Float64.parse(v)
        }
        // 转换高度
        if (let Some(v) <- strHeight) {
            imageHeight = Float64.parse(v)
        }
    }

    func build() {
        if (imageHeight.isSome() && imageWidth.isSome()) {
            ImageSpan(destination)
                // 设置组件自身的高度
                .height(imageHeight().px)
                // 设置组件自身的宽度
                .width(imageWidth())
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置约束尺寸
                .constraintSize(maxWidth: 100.percent)
                // 点击动作触发该方法调用
                .onClick {
                    evt =>
                    imageOnClick(destination, imageCallback)
                }
        } else if (imageHeight.isSome() && !imageWidth.isSome()) {
            ImageSpan(destination)
                // 设置组件自身的高度
                .height(imageHeight().px)
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置约束尺寸
                .constraintSize(maxWidth: 100.percent)
                // 点击动作触发该方法调用
                .onClick {
                    evt =>
                    imageOnClick(destination, imageCallback)
                }
        } else if (!imageHeight.isSome() && imageWidth.isSome()) {
            ImageSpan(destination)
                // 设置组件自身的宽度
                .width(imageWidth().px)
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置约束尺寸
                .constraintSize(maxWidth: 100.percent)
                // 点击动作触发该方法调用
                .onClick {
                    evt =>
                    imageOnClick(destination, imageCallback)
                }
        } else if (!imageHeight.isSome() && !imageWidth.isSome()) {
            ImageSpan(destination)
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置约束尺寸
                .constraintSize(maxWidth: 100.percent)
                // 点击动作触发该方法调用
                .onClick {
                    evt =>
                    imageOnClick(destination, imageCallback)
                }
        }
    }
}
