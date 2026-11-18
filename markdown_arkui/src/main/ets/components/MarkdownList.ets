import { MarkdownDataSource } from "../datasource/MarkdownDataSource"
import { NodeView } from "../model/NodeView"
import { MarkdownExposureEvent } from "../model/MarkdownExposureEvent"
import { MarkdownTheme } from "../theme/MarkdownTheme"
import { listPrefixStr } from "../utils/MarkdownUtils"
import { listBackgroundColor } from "../utils/MarkdownThemeUtils"
import { MarkdownListItem } from "./MarkdownListItem"
import { MarkdownHighlightParagraph } from "../configs/MarkdownHighlightParagraph"

/**
 * 无序/任务列表、有序列表控件
 */
@Component
export struct MarkdownList {
  @ObjectLink @Watch('refreshData') node: NodeView // 列表自身节点数据
  @ObjectLink theme: MarkdownTheme // 聚合主题（透传块，无 @Watch）：子主题变化由根组件集中观察发布，经 this.theme.xxxTheme 读取
  @ObjectLink markdownHighlightParagraph: MarkdownHighlightParagraph // 段落高亮配置
  @Prop isOrdered: boolean // 是无序列表还是有序列表 - true：有序列表，false：无序列表
  @Prop listDepth: number = 0 // 列表深度
  @Prop componentWidth: number = 0.0 // 父布局控件宽度
  @Prop tableBlockComponentWidth: number = 0.0 // 表格控件宽度
  textCopyCallback?: (text: string) => void // 文本复制点击事件
  footnoteCallback?: (index: string) => void // 脚注点击事件
  tocCallback?: (index: number) => void // TOC/标题ID点击事件
  linkCallback?: (url: string) => void // 链接点击事件
  elementExposureCallback?: (event: MarkdownExposureEvent) => void // 元素曝光回调（链接显示/消失）
  exposureThreshold: number = 0.5 // 曝光可见阈值
  imageCallback?: (url: string) => void // 图片点击事件
  imageDownloadCallback?: (url: string) => void // 图片下载点击事件
  imageReplaceCallback?: (url: string) => Promise<ArrayBuffer | undefined> // 图片替换回调
  videoCallback?: (url: string) => void // 视频点击事件
  videoImageCallback?: (url: string, callback: (url: string, ratio: number, time: number) => void) => void // 视频图片替换回调
  videoReleaseCallback?: (url: string) => void // 视频发布点击事件
  videoDownloadCallback?: (url: string) => void // 视频下载点击事件
  audioCallback?: (url: string) => void // 音频点击事件
  codeCopyCallback?: (code: string) => void // 代码复制点击事件
  codeFullScreenCallback?: (code: string, language: string | undefined) => void // 代码全屏点击事件
  tableCopyCallback?: (str: string) => void // 表格复制点击事件
  latexImageCallback?: (data: ArrayBuffer, height: number, width: number) => void // 数学公式图片点击事件
  latexStrCallback: (str: string) => string = (str: string) => str // 数学公式数据处理事件
  customLongPressCallback?: (str: string) => void = undefined // 自定义长按事件
  paragraphHeadingAnimationStart?: () => void // 段落动画开始回调
  paragraphHeadingAnimationEnd?: () => void // 段落动画结束回调
  scroller: Scroller = new Scroller() // list控制器
  markdownDataSource: MarkdownDataSource = new MarkdownDataSource([]) // markdown页面数据源
  @BuilderParam blockImageCardComponent: (desc:string, imageSrc:string, title:string) => void
  @BuilderParam blockLinkCardComponent: (desc:string, link:string, title:string) => void
  @BuilderParam customTagViewComponent: (tag:string, attrs:Record<string,string>, content:string) => void

  aboutToAppear(): void {
    this.refreshData() // 首次加载
  }

  build() {
    List({
      scroller: this.scroller,
      space: this.isOrdered ? this.theme.orderedListTheme.orderedListChildSpacing : this.theme.bulletListTheme.bulletListChildSpacing
    }) {
      LazyForEach(
        this.markdownDataSource,
        (item: NodeView, index: number) => {
          ListItem() {
            Row() {
              if (item.nodeType === "ListItem") {
                this.listPrefixTextINCComponent(item, index) // 普通列表项
              } else if (item.nodeType === "TaskListItem") {
                this.listPrefixCheckboxINCComponent(item) // 任务列表项
                Blank().width(this.theme.bulletListTheme.bulletListCheckboxSpacing) // 复选框与内容间距，与仓颉侧 Blank 间隔器写法对齐
              }
              MarkdownListItem({
                node: item,
                theme: this.theme,
                latexImageCallback: this.latexImageCallback,
                latexStrCallback: this.latexStrCallback,
                isOrdered: this.isOrdered,
                listDepth: this.listDepth,
                componentWidth: this.componentWidth,
                tableBlockComponentWidth: this.tableBlockComponentWidth,
                textCopyCallback: this.textCopyCallback,
                footnoteCallback: this.footnoteCallback,
                tocCallback: this.tocCallback,
                linkCallback: this.linkCallback,
                elementExposureCallback: this.elementExposureCallback,
                exposureThreshold: this.exposureThreshold,
                imageCallback: this.imageCallback,
                imageDownloadCallback: this.imageDownloadCallback,
                imageReplaceCallback: this.imageReplaceCallback,
                videoCallback: this.videoCallback,
                videoImageCallback: this.videoImageCallback,
                videoReleaseCallback: this.videoReleaseCallback,
                videoDownloadCallback: this.videoDownloadCallback,
                audioCallback: this.audioCallback,
                codeCopyCallback: this.codeCopyCallback,
                codeFullScreenCallback: this.codeFullScreenCallback,
                tableCopyCallback: this.tableCopyCallback,
                markdownHighlightParagraph: this.markdownHighlightParagraph,
                customLongPressCallback: this.customLongPressCallback,
                paragraphHeadingAnimationStart: this.paragraphHeadingAnimationStart,
                paragraphHeadingAnimationEnd: this.paragraphHeadingAnimationEnd,
                blockImageCardComponent:this.blockImageCardComponent,
                blockLinkCardComponent:this.blockLinkCardComponent,
                customTagViewComponent: this.customTagViewComponent
              })
            }
            .alignItems(VerticalAlign.Top)
            .justifyContent(FlexAlign.Start)
          }
          .layoutWeight(1)
        },
        (item: NodeView, index: number) => {
          return `${index}-${item.nodeHash}`
        }
      )
    }
    .backgroundColor(listBackgroundColor(this.isOrdered, this.theme.blockQuoteTheme, this.theme.orderedListTheme, this.theme.bulletListTheme, this.theme.globalTheme, this.node))
    .alignListItem(ListItemAlign.Start)
    .listDirection(Axis.Vertical)
    .padding({
      top: this.isOrdered ? this.theme.orderedListTheme.orderedListPaddingTop : this.theme.bulletListTheme.bulletListPaddingTop,
      right: this.isOrdered ? this.theme.orderedListTheme.orderedListPaddingRight : this.theme.bulletListTheme.bulletListPaddingRight,
      bottom: this.isOrdered ? this.theme.orderedListTheme.orderedListPaddingBottom : this.theme.bulletListTheme.bulletListPaddingBottom,
      left: this.isOrdered ? this.theme.orderedListTheme.orderedListPaddingLeft : this.theme.bulletListTheme.bulletListPaddingLeft
    })
    .margin({
      top: this.isOrdered ? this.theme.orderedListTheme.orderedListMarginTop : this.theme.bulletListTheme.bulletListMarginTop,
      right: this.isOrdered ? this.theme.orderedListTheme.orderedListMarginRight : this.theme.bulletListTheme.bulletListMarginRight,
      bottom: this.isOrdered ? this.theme.orderedListTheme.orderedListMarginBottom : this.theme.bulletListTheme.bulletListMarginBottom,
      left: this.isOrdered ? this.theme.orderedListTheme.orderedListMarginLeft : this.theme.bulletListTheme.bulletListMarginLeft
    })
  }

  /**
   * 无序/有序列表的前缀文本
   *
   * @param item 节点视图
   * @param index 索引
   */
  @Builder
  listPrefixTextINCComponent(item: NodeView, index: number) {
    Text(listPrefixStr(this.isOrdered && item.orderedListNumber > 0 ? item.orderedListNumber : index + 1, this.listDepth, this.isOrdered, this.theme.bulletListTheme))
      .fontFamily(this.isOrdered ? this.theme.orderedListTheme.orderedListMarkerTextFontFamily : this.theme.bulletListTheme.bulletListBulletTextFontFamily)
      .fontSize(this.isOrdered ? this.theme.orderedListTheme.orderedListMarkerTextFontSize : this.theme.bulletListTheme.bulletListBulletTextFontSize)
      .fontWeight(this.isOrdered ? this.theme.orderedListTheme.orderedListMarkerTextFontWeight : this.theme.bulletListTheme.bulletListBulletTextFontWeight)
      .fontStyle(this.isOrdered ? this.theme.orderedListTheme.orderedListMarkerTextFontStyle : this.theme.bulletListTheme.bulletListBulletTextFontStyle)
      .fontColor(this.isOrdered ? this.theme.orderedListTheme.orderedListMarkerTextFontColor : this.theme.bulletListTheme.bulletListBulletTextFontColor)
      .lineHeight(this.isOrdered ? this.theme.orderedListTheme.orderedListMarkerTextLineHeight : this.theme.bulletListTheme.bulletListBulletTextLineHeight)
      .margin({
        right: this.isOrdered ? this.theme.orderedListTheme.orderedListMarkerSpacing : this.theme.bulletListTheme.bulletListBulletSpacing
      })
      .textAlign(TextAlign.Center)
      .transition(
        TransitionEffect.asymmetric(
          this.theme.globalTheme.paragraphHeadingAnimationEnabled
            ? TransitionEffect.opacity(0).animation({ duration: this.theme.globalTheme.paragraphHeadingAnimationDuration })
            : TransitionEffect.IDENTITY,
          TransitionEffect.IDENTITY
        )
      )
  }

  /**
   * 任务列表的前缀多选框
   *
   * @param item 节点视图
   */
  @Builder
  listPrefixCheckboxINCComponent(item: NodeView) {
    Checkbox()
      .height(this.theme.bulletListTheme.bulletListCheckboxHeight)
      .width(this.theme.bulletListTheme.bulletListCheckboxWidth)
      .shape(this.theme.bulletListTheme.bulletListCheckboxShape)
      .selectedColor(this.theme.bulletListTheme.bulletListCheckboxSelectedColor)
      .select(item.isTaskListSelected)
      .enabled(false)
      .transition(
        TransitionEffect.asymmetric(
          this.theme.globalTheme.paragraphHeadingAnimationEnabled
            ? TransitionEffect.opacity(0).animation({ duration: this.theme.globalTheme.paragraphHeadingAnimationDuration })
            : TransitionEffect.IDENTITY,
          TransitionEffect.IDENTITY
        )
      )
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
