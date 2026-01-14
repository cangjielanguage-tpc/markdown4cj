/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.arkui.state_macro_manage.*

/**
 * 普通网络/沙盒图片、未设置图片预处理接口、API15以下
 */
@Component
public class MarkdownImgUrl14Component {
    /**
     * markdown配置
     */
    var markdownConfigurationUrl14: MarkdownConfiguration

    /**
     * 图片链接
     */
    var destinationUrl14: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var componentWidthUrl14: Float64

    /**
     * 链接点击事件
     */
    var linkCallbackUrl14: ?(String) -> Unit

    /**
     * 图片点击事件
     */
    var imageCallbackUrl14: (String) -> Unit

    /**
     * 是否是链接
     */
    var isLinkUrl14: Bool = false

    /**
     * 链接url
     */
    var linkUrlUrl14: ?String = Option<String>.None

    /**
     * 图片加载
     */
    @State
    var imageType: Int64 = 0 // 0：开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片高度 - 单位px
     */
    @State
    var heightUrl14: Float64 = 0.0

    /**
     * 图片宽度 - 单位px
     */
    @State
    var widthUrl14: Float64 = 0.0

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var componentImageWidth: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        componentImageWidth = getUIContext().vp2px(componentWidthUrl14.vp)().value
    }

    func build() {
        if (true) {
            if (imageType != 2) {
                // 图片开始加载和成功加载
                ImageSpan(destinationUrl14)
                    // 设置外边距属性
                    .margin(top: markdownConfigurationUrl14.markdownTheme.imageMarginTop, bottom: markdownConfigurationUrl14.markdownTheme.imageMarginBottom)
                    // 自定义图片圆角
                    .interopBorderRadius(markdownConfigurationUrl14.markdownTheme.imageBorderRadius)
                    // 设置组件自身的宽度
                    .width(imageSpanWidth(markdownConfigurationUrl14.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthUrl14, markdownConfigurationUrl14.markdownTheme.imageMaximumWidth))
                    // 设置组件自身的高度
                    .height(imageSpanHeight(markdownConfigurationUrl14.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthUrl14, heightUrl14, markdownConfigurationUrl14.markdownTheme.imageMaximumWidth))
                    // 设置组件的可见性
                    .visibility(visibilityImageSpanType(imageType))
                    // 设置图片的缩放类型
                    .objectFit(markdownConfigurationUrl14.markdownTheme.imageFitType)
                    // 设置图片基于文本的对齐方式
                    .verticalAlign(ImageSpanAlignment.Center)
                    // 设置约束尺寸，组件布局时，进行尺寸范围限制
                    .constraintSize(maxWidth: 100.percent)
                    // 点击动作触发该方法调用
                    .onClick ({evt => imageSpanOnClick(isLinkUrl14, imageCallbackUrl14, linkCallbackUrl14, linkUrlUrl14, destinationUrl14)})
                    // 图片成功加载时触发该回调，返回成功加载的图片尺寸
                    .interopOnComplete {
                        imageLoadResult =>
                            let res = imageSpanComplete(imageLoadResult.height, imageLoadResult.width, componentImageWidth)
                            widthUrl14 = res[0]
                            heightUrl14 = res[1]
                            imageType = 1
                    }
                    // 图片加载出现异常时触发该回调
                    .interopOnError {
                        imageError => imageType = 2
                    }
            }
            if (markdownConfigurationUrl14.markdownTheme.imageResource.isSome() && imageType != 1) {
                // 有占位图
                imagePlaceholderComponent(markdownConfigurationUrl14.markdownTheme.imageResource(), markdownConfigurationUrl14.markdownTheme.imageMarginTop, markdownConfigurationUrl14.markdownTheme.imageMarginBottom, markdownConfigurationUrl14.markdownTheme.imageFixedRatioWidth, markdownConfigurationUrl14.markdownTheme.imageMaximumWidth, markdownConfigurationUrl14.markdownTheme.imageBorderRadius, componentImageWidth)
            }
        }
    }
}
