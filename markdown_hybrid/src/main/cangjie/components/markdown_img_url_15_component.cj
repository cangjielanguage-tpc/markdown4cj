/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 普通网络/沙盒图片、未设置图片预处理接口、API15及以上
 */
@Component
public class MarkdownImgUrl15Component {
    /**
     * markdown配置
     */
    var markdownConfigurationUrl15: MarkdownConfiguration

    /**
     * 图片链接
     */
    var destinationUrl15: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var componentWidthUrl15: Float64

    /**
     * 图片点击事件
     */
    var imageCallbackUrl15: (String) -> Unit

    /**
     * 链接点击事件
     */
    var linkCallbackUrl15: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var isLinkUrl15: Bool = false

    /**
     * 链接url
     */
    var linkUrlUrl15: ?String = Option<String>.None

    /**
     * 图片加载
     */
    @State
    var imageType: Int64 = 0 // 0：开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片宽度 - 单位px
     */
    @State
    var widthUrl15: Float64 = 0.0

    /**
     * 图片高度 - 单位px
     */
    @State
    var heightUrl15: Float64 = 0.0

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var componentImageWidth: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        componentImageWidth = vp2px(componentWidthUrl15.vp)().value
    }

    func build() {
        if (true) {
            if (imageType != 2) {
                // 图片开始加载和成功加载
                ImageSpan(destinationUrl15)
                    // 设置外边距属性
                    .margin(top: markdownConfigurationUrl15.markdownTheme.imageMarginTop, bottom: markdownConfigurationUrl15.markdownTheme.imageMarginBottom)
                    // 自定义图片圆角
                    .interopBorderRadius(markdownConfigurationUrl15.markdownTheme.imageBorderRadius)
                    // 设置组件自身的宽度
                    .width(widthUrl15.px)
                    // 设置组件自身的高度
                    .height(heightUrl15.px)
                    // 设置组件的可见性
                    .visibility(visibilityImageSpanType(imageType))
                    // 设置图片的缩放类型
                    .objectFit(markdownConfigurationUrl15.markdownTheme.imageFitType)
                    // 设置图片基于文本的对齐方式
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    // 设置约束尺寸，组件布局时，进行尺寸范围限制
                    .constraintSize(maxWidth: 100.percent)
                    // 点击动作触发该方法调用
                    .onClick {evt => imageSpanOnClick(isLinkUrl15, imageCallbackUrl15, linkCallbackUrl15, linkUrlUrl15, destinationUrl15)}
                    // 图片成功加载时触发该回调，返回成功加载的图片尺寸
                    .onComplete {
                        imageLoadResult =>
                            let res = imageWidthAndHeight(
                                componentImageWidth,
                                imageLoadResult.width,
                                imageLoadResult.height,
                                Option<Length>.None,
                                Option<Length>.None,
                                markdownConfigurationUrl15.markdownTheme.imageMaxHeight,
                                markdownConfigurationUrl15.markdownTheme.imageFixedRatioWidth,
                                markdownConfigurationUrl15.markdownTheme.imageMaximumWidth
                            )
                            widthUrl15 = res[0]
                            heightUrl15 = res[1]
                            imageType = 1
                    }
                    // 图片加载出现异常时触发该回调
                    .onError {
                        imageError => imageType = 2
                    }
            }
            if (markdownConfigurationUrl15.markdownTheme.imageResource.isSome() && imageType != 1) {
                // 有占位图
                imagePlaceholderComponent(markdownConfigurationUrl15.markdownTheme.imageResource(), markdownConfigurationUrl15.markdownTheme.imageMarginTop, markdownConfigurationUrl15.markdownTheme.imageMarginBottom, markdownConfigurationUrl15.markdownTheme.imageFixedRatioWidth, markdownConfigurationUrl15.markdownTheme.imageMaximumWidth, markdownConfigurationUrl15.markdownTheme.imageBorderRadius, componentImageWidth)
            }
        }
    }
}
