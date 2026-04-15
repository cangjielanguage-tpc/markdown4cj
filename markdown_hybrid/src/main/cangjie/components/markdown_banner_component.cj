package markdown.components

import ohos.state_macro_manage.*

/**
 * 图片幻灯片
 */
@Component
class MarkdownBannerComponent {
    var markdownTheme: MarkdownTheme // markdown配置
    var nodeView: NodeView // 图片幻灯片image
    var imageCallback: (String) -> Unit // 图片点击事件
    var controller: SwiperController = SwiperController() // 滑动控制器
    @State
    var bannerNodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>() // 数据源

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
        .padding(
            top: markdownTheme.bannerTheme.bannerPaddingTop,
            right: markdownTheme.bannerTheme.bannerPaddingRight,
            bottom: markdownTheme.bannerTheme.bannerPaddingBottom,
            left: markdownTheme.bannerTheme.bannerPaddingLeft
        )
    }

    /**
     * 滑动容器，提供切换子组件显示的能力
     */
    @Builder
    func imageBannerCommonmarkComponent(item: NodeView) {
        if (markdownTheme.bannerTheme.bannerPlaceholder.isSome()) {
            Image(item.imageUrl())
                .alt(markdownTheme.bannerTheme.bannerPlaceholder())
                .objectFit(ImageFit.Contain)
                .autoResize(markdownTheme.imageTheme.imageAutoResize)
                .onClick {evt => imageOnClick(item.imageUrl(), imageCallback)}
        } else {
            Image(item.imageUrl())
                .objectFit(ImageFit.Contain)
                .autoResize(markdownTheme.imageTheme.imageAutoResize)
                .onClick {evt => imageOnClick(item.imageUrl(), imageCallback)}
        }
    }
}
