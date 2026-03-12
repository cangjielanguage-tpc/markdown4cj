/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 图片幻灯片
 */
@Component
class MarkdownBannerComponent {
    /**
     * markdown配置
     */
    var markdownTheme: MarkdownTheme

    /**
     * 图片幻灯片image
     */
    var nodeView: NodeView

    /**
     * 图片点击事件
     */
    var imageCallback: (String) -> Unit

    /**
     * 滑动控制器
     */
    var controller: SwiperController = SwiperController()

    /**
     * 数据源
     */
    @State
    var bannerNodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>()

    protected override func aboutToAppear(): Unit {
        for (item in nodeView.children){
            bannerNodeViewList.append(item)
        }
    }

    func build() {
        Swiper(controller) {
            ForEach(
                bannerNodeViewList,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.nodeType == "Image") {
                        // 图片节点
                        imageBannerCommonmarkComponent(item)
                    } else {
                        // 其他节点
                    }
                }
            )
        }
        .autoPlay(false)
        .width(100.percent)
    }

    /**
     * 滑动容器，提供切换子组件显示的能力
     */
    @Builder
    func imageBannerCommonmarkComponent(item: NodeView) {
        if (markdownTheme.bannerImage.isSome()) {
            Image(item.imageUrl())
                .alt(markdownTheme.bannerImage())
                .objectFit(ImageFit.Contain)
                .autoResize(markdownTheme.isAutoResize)
                .onClick {evt => imageOnClick(item.imageUrl(), imageCallback)}
        } else {
            Image(item.imageUrl())
                .objectFit(ImageFit.Contain)
                .autoResize(markdownTheme.isAutoResize)
                .onClick {evt => imageOnClick(item.imageUrl(), imageCallback)}
        }
    }
}
