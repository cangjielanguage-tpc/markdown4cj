import { MarkdownDataSource } from "../datasource/MarkdownDataSource"
import { NodeView } from "../model/NodeView"
import { MarkdownExposureEvent } from "../model/MarkdownExposureEvent"
import { MarkdownTheme } from "../theme/MarkdownTheme"
import { MarkdownDescDef } from "./MarkdownDescDef"
import { MarkdownDescTerm } from "./MarkdownDescTerm"
import { MarkdownHighlightParagraph } from "../configs/MarkdownHighlightParagraph"

/**
 * 定义列表控件
 */
@Component
export struct MarkdownDesc {
  @ObjectLink @Watch('refreshData') node: NodeView // 定义列表自身节点数据
  @ObjectLink theme: MarkdownTheme // 聚合主题（透传块，无 @Watch）：子主题变化由根组件集中观察发布，经 this.theme.xxxTheme 读取
  @ObjectLink markdownHighlightParagraph: MarkdownHighlightParagraph // 段落高亮配置
  @Prop componentWidth: number = 0.0 // 父布局控件宽度
  textCopyCallback?: (text: string) => void // 文本复制的点击事件
  footnoteCallback?: (index: string) => void // 脚注点击事件
  tocCallback?: (index: number) => void // TOC/标题ID点击事件
  linkCallback?: (url: string) => void // 链接点击事件
  elementExposureCallback?: (event: MarkdownExposureEvent) => void // 元素曝光回调（链接显示/消失）
  exposureThreshold: number = 0.5 // 曝光可见阈值
  imageCallback?: (url: string) => void // 图片点击事件
  imageDownloadCallback?: (url: string) => void // 图片下载事件
  imageReplaceCallback?: (url: string) => Promise<ArrayBuffer | undefined> // 图片替换回调
  latexImageCallback?: (data: ArrayBuffer, height: number, width: number) => void // 数学公式图片点击事件
  latexStrCallback: (str: string) => string = (str: string) => str // 数学公式数据处理事件
  customLongPressCallback?: (str: string) => void = undefined // 自定义长按事件
  paragraphHeadingAnimationStart?: () => void // 段落动画开始回调
  paragraphHeadingAnimationEnd?: () => void // 段落动画结束回调
  scroller: Scroller = new Scroller() // list控制器
  markdownDataSource: MarkdownDataSource = new MarkdownDataSource([]) // markdown页面数据源

  aboutToAppear(): void {
    this.refreshData() // 首次加载
  }

  build() {
    List({ scroller: this.scroller }) {
      LazyForEach(
        this.markdownDataSource,
        (item: NodeView, index: number) => {
          ListItem() {
            if (item.nodeType === "DescDef") {
              // 定义列表释义
              MarkdownDescDef({
                node: item,
                theme: this.theme,
                latexImageCallback: this.latexImageCallback,
                latexStrCallback: this.latexStrCallback,
                componentWidth: this.componentWidth,
                textCopyCallback: this.textCopyCallback,
                footnoteCallback: this.footnoteCallback,
                tocCallback: this.tocCallback,
                linkCallback: this.linkCallback,
                elementExposureCallback: this.elementExposureCallback,
                exposureThreshold: this.exposureThreshold,
                imageCallback: this.imageCallback,
                imageDownloadCallback: this.imageDownloadCallback,
                imageReplaceCallback: this.imageReplaceCallback,
                markdownHighlightParagraph: this.markdownHighlightParagraph,
                customLongPressCallback: this.customLongPressCallback,
                paragraphHeadingAnimationStart: this.paragraphHeadingAnimationStart,
                paragraphHeadingAnimationEnd: this.paragraphHeadingAnimationEnd,
              })
            } else if (item.nodeType === "DescTerm") {
              // 定义列表术语
              MarkdownDescTerm({
                node: item,
                theme: this.theme,
                latexImageCallback: this.latexImageCallback,
                latexStrCallback: this.latexStrCallback,
                componentWidth: this.componentWidth,
                textCopyCallback: this.textCopyCallback,
                footnoteCallback: this.footnoteCallback,
                tocCallback: this.tocCallback,
                linkCallback: this.linkCallback,
                elementExposureCallback: this.elementExposureCallback,
                exposureThreshold: this.exposureThreshold,
                imageCallback: this.imageCallback,
                imageDownloadCallback: this.imageDownloadCallback,
                imageReplaceCallback: this.imageReplaceCallback,
                markdownHighlightParagraph: this.markdownHighlightParagraph,
                customLongPressCallback: this.customLongPressCallback,
                paragraphHeadingAnimationStart: this.paragraphHeadingAnimationStart,
                paragraphHeadingAnimationEnd: this.paragraphHeadingAnimationEnd,
              })
            } else {
              // 其它
              Text("")
            }
          }
          .margin({
            // 与仓颉侧 descDefItemSpacing 对齐：仅释义行（DescDef）加顶部间距（index===1 时为 0），术语行与其它节点无间距
            top: item.nodeType === "DescDef"
              ? (index === 1 ? 0 : this.theme.definitionListTheme.definitionListDescriptionItemSpacing)
              : 0
          })
        },
        (item: NodeView, index: number) => {
          return `${index}-${item.nodeHash}`
        }
      )
    }
    .backgroundColor(this.theme.definitionListTheme.definitionListBackgroundColor ?? this.theme.globalTheme.backgroundColor)
    .listDirection(Axis.Vertical)
    .alignListItem(ListItemAlign.Start)
    .padding({
      top: this.theme.definitionListTheme.definitionListPaddingTop,
      right: this.theme.definitionListTheme.definitionListPaddingRight,
      bottom: this.theme.definitionListTheme.definitionListPaddingBottom,
      left: this.theme.definitionListTheme.definitionListPaddingLeft
    })
    .margin({
      top: this.theme.definitionListTheme.definitionListMarginTop,
      right: this.theme.definitionListTheme.definitionListMarginRight,
      bottom: this.theme.definitionListTheme.definitionListMarginBottom,
      left: this.theme.definitionListTheme.definitionListMarginLeft
    })
  }

  /**
   * 刷新数据
   */
  refreshData() {
    if (this.node.children.length === 0) {
      this.markdownDataSource.clear()
      return
    }
    this.markdownDataSource.smartUpdateDataArray(this.node.children)
  }
}