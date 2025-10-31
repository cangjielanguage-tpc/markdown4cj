/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 普通网络/沙盒图片、未设置图片预处理接口、API15以下
 */
@Component
public class MarkdownImgUrl14Component {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 图片链接
     */
    var destination: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var componentWidth: Float64

    /**
     * 图片点击事件
     */
    var imageCallback: (String) -> Unit

    /**
     * 链接点击事件
     */
    var linkCallback: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var isLink: Bool = false

    /**
     * 链接url
     */
    var linkUrl: ?String = Option<String>.None

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
     * 图片上边距
     */
    @State
    var imageMarginTop: Float64 = 10.0

    /**
     * 图片下边距
     */
    @State
    var imageMarginBottom: Float64 = 10.0

    /**
     * 图片圆角大小
     */
    @State
    var imageBorderRadius: Float64 = 0.0

    /**
     * 基于外层控件宽度大小对图片进行百分比缩放比例
     */
    @State
    var imageFixedRatioWidth: Option<Float64> = Option<Float64>.None

    /**
     * 基于图片自身宽度大小对图片进行百分比缩放比例
     */
    @State
    var imageMaximumWidth: Float64 = 1.0

    /**
     * 图片占位图
     */
    @State
    var imageResource: Option<AppResource> = Option<AppResource>.None

    /**
     * 是否有图片占位图
     */
    @State
    var isImageResource: Bool = false

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var componentImageWidth: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        imageMarginTop = markdownConfiguration.markdownTheme.imageMarginTop
        imageMarginBottom = markdownConfiguration.markdownTheme.imageMarginBottom
        imageBorderRadius = markdownConfiguration.markdownTheme.imageBorderRadius
        imageFixedRatioWidth = markdownConfiguration.markdownTheme.imageFixedRatioWidth
        imageMaximumWidth = markdownConfiguration.markdownTheme.imageMaximumWidth
        imageResource = markdownConfiguration.markdownTheme.imageResource
        if (imageResource.isSome()) {
            isImageResource = true
        } else {
            isImageResource = false
        }
        componentImageWidth = vp2px(componentWidth.vp)().value
    }

    protected override func aboutToDisappear(): Unit {
    }

    func build() {
        if (true) {
            if (imageType != 2) {
                // 图片开始加载和成功加载
                ImageSpan(destination)
                    // 设置外边距属性
                    .margin(top: imageMarginTop, bottom: imageMarginBottom)
                    // 自定义图片圆角
                    .interopBorderRadius(imageBorderRadius)
                    // 设置组件自身的宽度
                    .width(if (imageFixedRatioWidth.isSome()) {
                        (componentImageWidth * imageFixedRatioWidth()).px
                    } else {
                        (width * imageMaximumWidth).px
                    })
                    // 设置组件自身的高度
                    .height(if (imageFixedRatioWidth.isSome()) {
                        (height * (componentImageWidth / width) * imageFixedRatioWidth()).px
                    } else {
                        (height * imageMaximumWidth).px
                    })
                    // 设置组件的可见性
                    .visibility(if (imageType == 1) {
                        Visibility.Visible
                    } else {
                        Visibility.None
                    })
                    // 设置图片的缩放类型
                    .objectFit(ImageFit.Contain)
                    // 设置图片基于文本的对齐方式
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    // 设置约束尺寸，组件布局时，进行尺寸范围限制
                    .constraintSize(maxWidth: 100.percent)
                    // 点击动作触发该方法调用
                    .onClick {
                        evt => if (isLink) {
                            if (linkCallback.isSome() && linkUrl.isSome()) {
                                linkCallback()(linkUrl())
                            }
                        } else {
                            imageOnClick(destination, imageCallback)
                        }
                    }
                    // 图片成功加载时触发该回调，返回成功加载的图片尺寸
                    .interopOnComplete {
                        imageLoadResult =>
                            var aspectRatio: Float64 = imageLoadResult.height / imageLoadResult.width
                            width = if (componentImageWidth > imageLoadResult.width) {
                                imageLoadResult.width
                            } else {
                                componentImageWidth
                            }
                            height = width * aspectRatio
                            imageType = 1
                    }
                    // 图片加载出现异常时触发该回调
                    .interopOnError {
                        imageError => imageType = 2
                    }
            }
            if (isImageResource && imageType != 1) {
                // 有占位图
                ImageSpan(imageResource())
                    // 设置外边距属性
                    .margin(top: imageMarginTop, bottom: imageMarginBottom)
                    // 自定义图片圆角
                    .interopBorderRadius(imageBorderRadius)
                    // 设置组件自身的宽度
                    .width(if (imageFixedRatioWidth.isSome()) {
                        (componentImageWidth * imageFixedRatioWidth()).px
                    } else {
                        (componentImageWidth * imageMaximumWidth).px
                    })
                    // 设置组件自身的高度
                    .height(if (imageFixedRatioWidth.isSome()) {
                        (componentImageWidth * 9.0/16.0 * imageFixedRatioWidth()).px
                    } else {
                        (componentImageWidth * 9.0/16.0 * imageMaximumWidth).px
                    })
                    // 设置图片的缩放类型
                    .objectFit(ImageFit.Cover)
                    // 设置图片基于文本的对齐方式
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    // 设置约束尺寸，组件布局时，进行尺寸范围限制
                    .constraintSize(maxWidth: 100.percent)
            }
        }
    }
}
