/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown图片自定义样式页面
 */
@Component
class MarkdownImageStyleComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 图片节点
     */
    var styleImage: StyleImage

    /**
     * style数据
     */
    var picStyleObj: PicStyleObj

    func build() {
        // TODO ImageSpan缺少String入参，网络图片只能用Image接收
         Column() {
            imageStyleComponent()
        }
        // 设置约束尺寸
        .constraintSize(maxWidth: 100.percent)
    }

    /**
     * 图片Style - 有默认占位图
     */
    @Builder
    func imageStyleResourceComponent() {
        if (picStyleObj.height.isSome() && picStyleObj.width.isSome()) {
            // 设置图片的数据源
            Image(styleImage.getDestination())
                // 设置组件自身的高度
                .height(picStyleObj.height())
                // 设置组件自身的宽度
                .width(picStyleObj.width())
                // 占位图
                .alt(markdownConfiguration.markdownTheme.imageResource())
                // 设置图片解码过程中是否对图源自动缩放
                .autoResize(markdownConfiguration.markdownTheme.isAutoResize)
                // 设置元素的边框圆角半径
                .borderRadius(styleImageRadius(picStyleObj.borderRadius))
        } else if (picStyleObj.height.isSome() && !picStyleObj.width.isSome()) {
            // 设置图片的数据源
            Image(styleImage.getDestination())
                // 设置组件自身的高度
                .height(picStyleObj.height())
                // 占位图
                .alt(markdownConfiguration.markdownTheme.imageResource())
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置图片解码过程中是否对图源自动缩放
                .autoResize(markdownConfiguration.markdownTheme.isAutoResize)
                // 设置元素的边框圆角半径
                .borderRadius(styleImageRadius(picStyleObj.borderRadius))
        } else if (!picStyleObj.height.isSome() && picStyleObj.width.isSome()) {
            // 设置图片的数据源
            Image(styleImage.getDestination())
                // 设置组件自身的宽度
                .width(picStyleObj.width())
                // 占位图
                .alt(markdownConfiguration.markdownTheme.imageResource())
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置图片解码过程中是否对图源自动缩放
                .autoResize(markdownConfiguration.markdownTheme.isAutoResize)
                // 设置元素的边框圆角半径
                .borderRadius(styleImageRadius(picStyleObj.borderRadius))
        } else {
            // 设置图片的数据源
            Image(styleImage.getDestination())
                // 占位图
                .alt(markdownConfiguration.markdownTheme.imageResource())
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置图片解码过程中是否对图源自动缩放
                .autoResize(markdownConfiguration.markdownTheme.isAutoResize)
                // 设置元素的边框圆角半径
                .borderRadius(styleImageRadius(picStyleObj.borderRadius))
        }
    }

    /**
     * 图片Style - 没有默认占位图
     */
    @Builder
    func imageStyleNoneResourceComponent() {
        if (picStyleObj.height.isSome() && picStyleObj.width.isSome()) {
            // 设置图片的数据源
            Image(styleImage.getDestination())
                // 设置组件自身的高度
                .height(picStyleObj.height())
                // 设置组件自身的宽度
                .width(picStyleObj.width())
                // 设置图片解码过程中是否对图源自动缩放
                .autoResize(markdownConfiguration.markdownTheme.isAutoResize)
                // 设置元素的边框圆角半径
                .borderRadius(styleImageRadius(picStyleObj.borderRadius))
        } else if (picStyleObj.height.isSome() && !picStyleObj.width.isSome()) {
            // 设置图片的数据源
            Image(styleImage.getDestination())
                // 设置组件自身的高度
                .height(picStyleObj.height())
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置图片解码过程中是否对图源自动缩放
                .autoResize(markdownConfiguration.markdownTheme.isAutoResize)
                // 设置元素的边框圆角半径
                .borderRadius(styleImageRadius(picStyleObj.borderRadius))
        } else if (!picStyleObj.height.isSome() && picStyleObj.width.isSome()) {
            // 设置图片的数据源
            Image(styleImage.getDestination())
                // 设置组件自身的宽度
                .width(picStyleObj.width())
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置图片解码过程中是否对图源自动缩放
                .autoResize(markdownConfiguration.markdownTheme.isAutoResize)
                // 设置元素的边框圆角半径
                .borderRadius(styleImageRadius(picStyleObj.borderRadius))
        } else {
            // 设置图片的数据源
            Image(styleImage.getDestination())
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置图片解码过程中是否对图源自动缩放
                .autoResize(markdownConfiguration.markdownTheme.isAutoResize)
                // 设置元素的边框圆角半径
                .borderRadius(styleImageRadius(picStyleObj.borderRadius))
        }
    }

    /**
     * 图片Style
     */
    @Builder
    func imageStyleComponent() {
        Row() {
            if (markdownConfiguration.markdownTheme.imageResource.isSome()) {
                imageStyleResourceComponent()
            } else {
                imageStyleNoneResourceComponent()
            }
        }
        // 设置子组件在水平方向上的对齐格式
        .justifyContent(picStyleObj.align)
        // 点击动作触发该方法调用
        .onClick {evt => imageOnClick(styleImage.getDestination(), markdownConfiguration.imageCallback)}
    }
}
