/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.components

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*

/**
 * Markdown图片幻灯片自定义控件
 */
@Component
class MarkdownImageBannerComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 图片幻灯片image
     */
    var slideBlockNodeView: NodeView

    /**
     * 外边距 - 上面
     */
    var marginTop: Float64

    /**
     * 外边距 - 下面
     */
    var marginBottom: Float64

    /**
     * 滑动控制器
     */
    var controller: SwiperController = SwiperController()

    func build() {
        Column() {
            imageBannerComponent()
        }
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
    }

    /**
     * 滑动容器，提供切换子组件显示的能力
     */
    @Builder
    func imageBannerCommonmarkComponent(commonmarkImage: CommonmarkImage) {
        if (markdownConfiguration.markdownTheme.bannerImage.isSome()) {
            // 设置图片的数据源
            Image(commonmarkImage.getDestination())
                // 加载时显示的占位图
                .alt(markdownConfiguration.markdownTheme.bannerImage())
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置图片解码过程中是否对图源自动缩放
                .autoResize(markdownConfiguration.markdownTheme.isAutoResize)
                // 图片的点击事件
                .onClick ({evt => imageOnClick(commonmarkImage.getDestination(), markdownConfiguration.imageCallback)})
        } else {
            // 设置图片的数据源
            Image(commonmarkImage.getDestination())
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置图片解码过程中是否对图源自动缩放
                .autoResize(markdownConfiguration.markdownTheme.isAutoResize)
                // 图片的点击事件
                .onClick ({evt => imageOnClick(commonmarkImage.getDestination(), markdownConfiguration.imageCallback)})
        }
    }

    /**
     * 滑动容器，提供切换子组件显示的能力
     */
    @Builder
    func imageBannerComponent() {
        Swiper(controller: controller) {
            ForEach(
                slideBlockNodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is CommonmarkImage) {
                        // 图片节点
                        imageBannerCommonmarkComponent((item.node as CommonmarkImage)())
                    } else {
                        // 其他节点
                    }
                }
            )
        }
        // 子组件是否自动播放，自动播放状态下，导航点不可操作
        .autoPlay(false)
        // 设置组件自身的宽度
        .width(100.percent)
    }
}
