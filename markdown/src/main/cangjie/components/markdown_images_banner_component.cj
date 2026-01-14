/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

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
     * 滑动控制器
     */
    var controller: SwiperController = SwiperController()

    /**
     * 图片点击事件
     */
    var imageCallback: (String) -> Unit

    func build() {
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
                .onClick ({evt => imageOnClick(commonmarkImage.getDestination(), imageCallback)})
        } else {
            // 设置图片的数据源
            Image(commonmarkImage.getDestination())
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置图片解码过程中是否对图源自动缩放
                .autoResize(markdownConfiguration.markdownTheme.isAutoResize)
                // 图片的点击事件
                .onClick ({evt => imageOnClick(commonmarkImage.getDestination(), imageCallback)})
        }
    }
}
