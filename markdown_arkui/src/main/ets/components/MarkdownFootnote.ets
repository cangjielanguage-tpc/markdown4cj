import { MarkdownHighlightParagraph } from "../configs/MarkdownHighlightParagraph"
import { MarkdownDataSource } from "../datasource/MarkdownDataSource"
import { NodeView } from "../model/NodeView"
import { MarkdownTheme } from "../theme/MarkdownTheme"
import { footnoteBackgroundColor } from "../utils/MarkdownThemeUtils"
import { MarkdownParagraph } from "./MarkdownParagraph"
import { MarkdownExposureEvent } from "../model/MarkdownExposureEvent"

/**
 * 脚注控件
 */
@Component
export struct MarkdownFootnote {
  @ObjectLink @Watch('refreshData') node: NodeView // 脚注自身节点数据
  @ObjectLink theme: MarkdownTheme // 聚合主题（透传块，无 @Watch）：子主题变化由根组件集中观察发布，经 this.theme.xxxTheme 读取
  @ObjectLink markdownHighlightParagraph: MarkdownHighlightParagraph // 段落高亮配置
  @Prop componentWidth: number = 0.0 // 父布局控件宽度
  @Prop tableBlockComponentWidth: number = 0.0 // 表格控件宽度
  @Prop listDepth: number = 0 // 嵌套深度
  textCopyCallback?: (text: string) => void // 文本复制的点击事件
  footnoteCallback?: (index: string) => void // 脚注点击事件
  tocCallback?: (index: number) => void // TOC/标题ID点击事件
  linkCallback?: (url: string) => void // 链接点击事件
  elementExposureCallback?: (event: MarkdownExposureEvent) => void // 元素曝光回调（链接显示/消失）
  exposureThreshold: number = 0.5 // 曝光可见阈值
  imageCallback?: (url: string) => void // 图片点击事件
  imageDownloadCallback?: (url: string) => void // 图片下载事件
  imageReplaceCallback?: (url: string) => Promise<ArrayBuffer | undefined> // 图片替换回调
  videoCallback?: (url: string) => void // 视频点击事件
  videoImageCallback?: (url: string, callback: (url: string, ratio: number, time: number) => void) => void // 视频图片替换回调
  videoReleaseCallback?: (url: string) => void // 视频发布点击事件
  videoDownloadCallback?: (url: string) => void // 视频下载点击事件
  audioCallback?: (url: string) => void // 音频点击事件
  codeCopyCallback?: (code: string) => void // 代码复制点击事件
  codeFullScreenCallback?: (code: string, language: string | undefined) => void // 代码全屏点击事件
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
            if (item.nodeType === "Paragraph") {
              // 段落
              MarkdownParagraph({
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
              // 其他
            }
          }
        },
        (item: NodeView, index: number) => {
          return `${index}-${item.nodeHash}`
        }
      )
    }
    .backgroundColor(footnoteBackgroundColor(this.theme.blockQuoteTheme, this.theme.footnoteDefTheme, this.theme.globalTheme, false))
    .listDirection(Axis.Vertical)
    .alignListItem(ListItemAlign.Start)
    .padding({
      top: this.theme.footnoteDefTheme.footnoteDefPaddingTop,
      right: this.theme.footnoteDefTheme.footnoteDefPaddingRight,
      bottom: this.theme.footnoteDefTheme.footnoteDefPaddingBottom,
      left: this.theme.footnoteDefTheme.footnoteDefPaddingLeft
    })
    .margin({
      top: this.theme.footnoteDefTheme.footnoteDefMarginTop,
      right: this.theme.footnoteDefTheme.footnoteDefMarginRight,
      bottom: this.theme.footnoteDefTheme.footnoteDefMarginBottom,
      left: this.theme.footnoteDefTheme.footnoteDefMarginLeft
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
