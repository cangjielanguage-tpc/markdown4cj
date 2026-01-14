/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.arkui.state_macro_manage.*

/**
 * HTML图片
 */
@Component
public class MarkdownImgHtml15Component {
    /**
     * markdown配置
     */
    var markdownConfigurationHtml15: MarkdownConfiguration

    /**
     * 图片链接
     */
    var destinationHtml15: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var componentWidthHtml15: Float64

    /**
     * 图片点击事件
     */
    var imageCallbackHtml15: (String) -> Unit

    /**
     * 链接点击事件
     */
    var linkCallbackHtml15: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var isLinkHtml15: Bool = false

    /**
     * 链接url
     */
    var linkUrlHtml15: ?String = Option<String>.None

    /**
     * 图片宽度
     */
    var imageWidthHtml15: ?Float64

    /**
     * 图片高度
     */
    var imageHeightHtml15: ?Float64

    /**
     * 图片加载
     */
    @State
    var imageType: Int64 = 0 // 0：开始加载。1：加载成功完成。2：加载失败

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
     * 图片最大宽度 - 单位px
     */
    @State
    var componentImageWidth: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        componentImageWidth = getUIContext().vp2px(componentWidthHtml15.vp)().value
    }

    func build() {
        if (true) {
            if (imageType != 2) {
                ImageSpan(destinationHtml15)
                    // 设置外边距属性
                    .margin(top: markdownConfigurationHtml15.markdownTheme.imageMarginTop, bottom: markdownConfigurationHtml15.markdownTheme.imageMarginBottom)
                    // 自定义图片圆角
                    .interopBorderRadius(markdownConfigurationHtml15.markdownTheme.imageBorderRadius)
                    // 设置组件自身的宽度
                    .width(imageSpanWidth(markdownConfigurationHtml15.markdownTheme.imageFixedRatioWidth, componentImageWidth, width, markdownConfigurationHtml15.markdownTheme.imageMaximumWidth))
                    // 设置组件自身的高度
                    .height(imageSpanHeight(markdownConfigurationHtml15.markdownTheme.imageFixedRatioWidth, componentImageWidth, width, height, markdownConfigurationHtml15.markdownTheme.imageMaximumWidth))
                    // 设置组件的可见性
                    .visibility(visibilityImageSpanType(imageType))
                    // 设置图片的缩放类型
                    .objectFit(markdownConfigurationHtml15.markdownTheme.imageFitType)
                    // 设置图片基于文本的对齐方式
                    .verticalAlign(ImageSpanAlignment.Center)
                    // 设置约束尺寸，组件布局时，进行尺寸范围限制
                    .constraintSize(maxWidth: 100.percent)
                    // 点击动作触发该方法调用
                    .onClick ({evt => imageSpanOnClick(isLinkHtml15, imageCallbackHtml15, linkCallbackHtml15, linkUrlHtml15, destinationHtml15)})
                    // 图片成功加载时触发该回调，返回成功加载的图片尺寸
                    .onComplete ({
                        imageLoadResult =>
                            let res = imageSpanHtmlComplete(getUIContext(), imageLoadResult.height, imageLoadResult.width, componentImageWidth, imageWidthHtml15, imageHeightHtml15)
                            width = res[0]
                            height = res[1]
                            imageType = 1
                    })
                    // 图片加载出现异常时触发该回调
                    .onError ({
                        imageError => imageType = 2
                    })
            }
            if (markdownConfigurationHtml15.markdownTheme.imageResource.isSome() && imageType != 1) {
                // 有占位图
                imagePlaceholderComponent(markdownConfigurationHtml15.markdownTheme.imageResource(), markdownConfigurationHtml15.markdownTheme.imageMarginTop, markdownConfigurationHtml15.markdownTheme.imageMarginBottom, markdownConfigurationHtml15.markdownTheme.imageFixedRatioWidth, markdownConfigurationHtml15.markdownTheme.imageMaximumWidth, markdownConfigurationHtml15.markdownTheme.imageBorderRadius, componentImageWidth)
            }
        }
    }
}
