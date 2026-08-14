import { NodeView } from "../model/NodeView"
import { BannerTheme } from "../theme/BannerTheme"
import { ImageTheme } from "../theme/ImageTheme"

/**
 * 轮播图控件
 */
@Component
export struct MarkdownBanner {
  @ObjectLink @Watch('refreshData') node: NodeView // 轮播图自身节点数据
  @ObjectLink bannerTheme: BannerTheme // 轮播图样式
  @ObjectLink imageTheme: ImageTheme // 图片样式
  imageCallback?: (url: string) => void // 图片点击事件
  @State bannerNodeViewList: Array<NodeView> = new Array<NodeView>() // 数据源
  controller: SwiperController = new SwiperController() // 滑动控制器

  aboutToAppear(): void {
    this.refreshData()
  }

  /**
   * 刷新数据
   */
  refreshData(): void {
    this.bannerNodeViewList = this.node.children.slice()
  }

  build() {
    Row() {
      Swiper(this.controller) {
        ForEach(
          this.bannerNodeViewList,
          (item: NodeView, index: number) => {
            if (item.nodeType === "Image") {
              // 图片节点
              this.imageBannerCommonmarkComponent(item)
            } else {
              // 其他节点
            }
          },
          (item: NodeView, index: number) => `${index}-${item.nodeType}-${item.imageUrl ?? ''}`
        )
      }
      .autoPlay(false)
      .layoutWeight(1)
    }
    .padding({
      top: this.bannerTheme.bannerPaddingTop,
      right: this.bannerTheme.bannerPaddingRight,
      bottom: this.bannerTheme.bannerPaddingBottom,
      left: this.bannerTheme.bannerPaddingLeft
    })
    .margin({
      top: this.bannerTheme.bannerMarginTop,
      right: this.bannerTheme.bannerMarginRight,
      bottom: this.bannerTheme.bannerMarginBottom,
      left: this.bannerTheme.bannerMarginLeft
    })
  }

  /**
   * 滑动容器，提供切换子组件显示的能力
   *
   * @param item 节点视图
   */
  @Builder
  imageBannerCommonmarkComponent(item: NodeView) {
    if (this.bannerTheme.bannerPlaceholder !== undefined) {
      Image(item.imageUrl ?? "")
        .alt(this.bannerTheme.bannerPlaceholder)
        .objectFit(ImageFit.Contain)
        .autoResize(this.imageTheme.imageAutoResize)
        .onClick(() => {
          if (item.imageUrl !== undefined) {
            this.imageCallback?.(item.imageUrl)
          }
        })
    } else {
      Image(item.imageUrl ?? "")
        .objectFit(ImageFit.Contain)
        .autoResize(this.imageTheme.imageAutoResize)
        .onClick(() => {
          if (item.imageUrl !== undefined) {
            this.imageCallback?.(item.imageUrl)
          }
        })
    }
  }
}