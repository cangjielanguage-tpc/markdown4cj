import { MarkdownDataSource } from "../datasource/MarkdownDataSource"
import { NodeView } from "../model/NodeView"
import { AudioTheme } from "../theme/AudioTheme"
import { BannerTheme } from "../theme/BannerTheme"
import { BlockQuoteTheme } from "../theme/BlockQuoteTheme"
import { BoldTheme } from "../theme/BoldTheme"
import { BulletListTheme } from "../theme/BulletListTheme"
import { CodeBlockTheme } from "../theme/CodeBlockTheme"
import { DefinitionListTheme } from "../theme/DefinitionListTheme"
import { DividerTheme } from "../theme/DividerTheme"
import { FootnoteDefTheme } from "../theme/FootnoteDefTheme"
import { FootnoteRefTheme } from "../theme/FootnoteRefTheme"
import { GlobalTheme } from "../theme/GlobalTheme"
import { HeadingTheme } from "../theme/HeadingTheme"
import { HighlightTheme } from "../theme/HighlightTheme"
import { HtmlUnderlineTheme } from "../theme/HtmlUnderlineTheme"
import { ImageTheme } from "../theme/ImageTheme"
import { InlineCodeTheme } from "../theme/InlineCodeTheme"
import { ItalicTheme } from "../theme/ItalicTheme"
import { LatexMathTheme } from "../theme/LatexMathTheme"
import { LinkTheme } from "../theme/LinkTheme"
import { OrderedListTheme } from "../theme/OrderedListTheme"
import { ParagraphTheme } from "../theme/ParagraphTheme"
import { StrikethroughTheme } from "../theme/StrikethroughTheme"
import { SubTheme } from "../theme/SubTheme"
import { SupTheme } from "../theme/SupTheme"
import { TableTheme } from "../theme/TableTheme"
import { VideoTheme } from "../theme/VideoTheme"
import { listPrefixStr } from "../utils/MarkdownUtils"
import { listBackgroundColor } from "../utils/MarkdownThemeUtils"
import { MarkdownListItem } from "./MarkdownListItem"

/**
 * 无序/任务列表、有序列表控件
 */
@Component
export struct MarkdownList {
  @ObjectLink @Watch('refreshData') node: NodeView // 列表自身节点数据
  @ObjectLink blockQuoteTheme: BlockQuoteTheme // 块引用样式
  @ObjectLink orderedListTheme: OrderedListTheme // 有序列表样式
  @ObjectLink bulletListTheme: BulletListTheme // 无序列表样式
  @ObjectLink headingTheme: HeadingTheme // 标题样式
  @ObjectLink globalTheme: GlobalTheme // 整体样式
  @ObjectLink subTheme: SubTheme // 下标样式
  @ObjectLink supTheme: SupTheme // 上标样式
  @ObjectLink inlineCodeTheme: InlineCodeTheme // 内联代码样式
  @ObjectLink boldTheme: BoldTheme // 加粗样式
  @ObjectLink italicTheme: ItalicTheme // 斜体样式
  @ObjectLink latexMathTheme: LatexMathTheme // 数学公式样式
  @ObjectLink strikethroughTheme: StrikethroughTheme // 删除线样式
  @ObjectLink highlightTheme: HighlightTheme // 高亮样式
  @ObjectLink htmlUnderlineTheme: HtmlUnderlineTheme // 下划线样式
  @ObjectLink linkTheme: LinkTheme // 链接样式
  @ObjectLink footnoteRefTheme: FootnoteRefTheme // 内联脚注样式
  @ObjectLink tableTheme: TableTheme // 表格样式
  @ObjectLink paragraphTheme: ParagraphTheme // 段落样式
  @ObjectLink definitionListTheme: DefinitionListTheme // 定义列表样式
  @ObjectLink imageTheme: ImageTheme // 图片样式
  @ObjectLink footnoteDefTheme: FootnoteDefTheme // 脚注样式
  @ObjectLink codeBlockTheme: CodeBlockTheme // 代码块样式
  @ObjectLink dividerTheme: DividerTheme // 分割线样式
  @ObjectLink bannerTheme: BannerTheme // 轮播图样式
  @ObjectLink videoTheme: VideoTheme // 视频样式
  @ObjectLink audioTheme: AudioTheme // 音频样式
  @Prop isOrdered: boolean // 是无序列表还是有序列表 - true：有序列表，false：无序列表
  @Prop listDepth: number = 0 // 列表深度
  @Prop componentWidth: number = 0.0 // 父布局控件宽度
  @Prop tableBlockComponentWidth: number = 0.0 // 表格控件宽度
  textCopyCallback?: (text: string) => void // 文本复制点击事件
  footnoteCallback?: (index: string) => void // 脚注点击事件
  tocCallback?: (index: number) => void // TOC/标题ID点击事件
  linkCallback?: (url: string) => void // 链接点击事件
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
  latexImageCallback?: (data: ArrayBuffer, height: number, width: number) => void // 数学公式图片点击事件
  latexStrCallback: (str: string) => string = (str: string) => str // 数学公式数据处理事件
  scroller: Scroller = new Scroller() // list控制器
  markdownDataSource: MarkdownDataSource = new MarkdownDataSource([]) // markdown页面数据源

  aboutToAppear(): void {
    this.refreshData() // 首次加载
  }

  build() {
    List({
      scroller: this.scroller,
      space: this.isOrdered ? this.orderedListTheme.orderedListChildSpacing : this.bulletListTheme.bulletListChildSpacing
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
                }
                MarkdownListItem({
                  node: item,
                  blockQuoteTheme: this.blockQuoteTheme,
                  orderedListTheme: this.orderedListTheme,
                  bulletListTheme: this.bulletListTheme,
                  headingTheme: this.headingTheme,
                  globalTheme: this.globalTheme,
                  subTheme: this.subTheme,
                  supTheme: this.supTheme,
                  inlineCodeTheme: this.inlineCodeTheme,
                  boldTheme: this.boldTheme,
                  italicTheme: this.italicTheme,
                  strikethroughTheme: this.strikethroughTheme,
                  highlightTheme: this.highlightTheme,
                  htmlUnderlineTheme: this.htmlUnderlineTheme,
                  linkTheme: this.linkTheme,
                  footnoteRefTheme: this.footnoteRefTheme,
                  tableTheme: this.tableTheme,
                  paragraphTheme: this.paragraphTheme,
                  definitionListTheme: this.definitionListTheme,
                  imageTheme: this.imageTheme,
                  footnoteDefTheme: this.footnoteDefTheme,
                  codeBlockTheme: this.codeBlockTheme,
                  dividerTheme: this.dividerTheme,
                  bannerTheme: this.bannerTheme,
                  videoTheme: this.videoTheme,
                  audioTheme: this.audioTheme,
                  latexMathTheme: this.latexMathTheme,
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
                  imageCallback: this.imageCallback,
                  imageDownloadCallback: this.imageDownloadCallback,
                  imageReplaceCallback: this.imageReplaceCallback,
                  videoCallback: this.videoCallback,
                  videoImageCallback: this.videoImageCallback,
                  videoReleaseCallback: this.videoReleaseCallback,
                  videoDownloadCallback: this.videoDownloadCallback,
                  audioCallback: this.audioCallback,
                  codeCopyCallback: this.codeCopyCallback,
                  codeFullScreenCallback: this.codeFullScreenCallback
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
    .backgroundColor(listBackgroundColor(this.isOrdered, this.blockQuoteTheme, this.orderedListTheme, this.bulletListTheme, this.globalTheme, this.node))
    .alignListItem(ListItemAlign.Start)
    .listDirection(Axis.Vertical)
    .padding({
      top: this.isOrdered ? this.orderedListTheme.orderedListPaddingTop : this.bulletListTheme.bulletListPaddingTop,
      right: this.isOrdered ? this.orderedListTheme.orderedListPaddingRight : this.bulletListTheme.bulletListPaddingRight,
      bottom: this.isOrdered ? this.orderedListTheme.orderedListPaddingBottom : this.bulletListTheme.bulletListPaddingBottom,
      left: this.isOrdered ? this.orderedListTheme.orderedListPaddingLeft : this.bulletListTheme.bulletListPaddingLeft
    })
    .margin({
      top: this.isOrdered ? this.orderedListTheme.orderedListMarginTop : this.bulletListTheme.bulletListMarginTop,
      right: this.isOrdered ? this.orderedListTheme.orderedListMarginRight : this.bulletListTheme.bulletListMarginRight,
      bottom: this.isOrdered ? this.orderedListTheme.orderedListMarginBottom : this.bulletListTheme.bulletListMarginBottom,
      left: this.isOrdered ? this.orderedListTheme.orderedListMarginLeft : this.bulletListTheme.bulletListMarginLeft
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
    Text(listPrefixStr(this.isOrdered && item.orderedListNumber > 0 ? item.orderedListNumber : index + 1, this.listDepth, this.isOrdered, this.bulletListTheme))
      .fontFamily(this.isOrdered ? this.orderedListTheme.orderedListMarkerTextFontFamily : this.bulletListTheme.bulletListBulletTextFontFamily)
      .fontSize(this.isOrdered ? this.orderedListTheme.orderedListMarkerTextFontSize : this.bulletListTheme.bulletListBulletTextFontSize)
      .fontWeight(this.isOrdered ? this.orderedListTheme.orderedListMarkerTextFontWeight : this.bulletListTheme.bulletListBulletTextFontWeight)
      .fontStyle(this.isOrdered ? this.orderedListTheme.orderedListMarkerTextFontStyle : this.bulletListTheme.bulletListBulletTextFontStyle)
      .fontColor(this.isOrdered ? this.orderedListTheme.orderedListMarkerTextFontColor : this.bulletListTheme.bulletListBulletTextFontColor)
      .lineHeight(this.isOrdered ? this.orderedListTheme.orderedListMarkerTextLineHeight : this.bulletListTheme.bulletListBulletTextLineHeight)
      .margin({ right: this.isOrdered ? this.orderedListTheme.orderedListMarkerSpacing : this.bulletListTheme.bulletListBulletSpacing })
      .halfLeading(true)
      .textAlign(TextAlign.Center)
  }

  /**
   * 任务列表的前缀多选框
   *
   * @param item 节点视图
   */
  @Builder
  listPrefixCheckboxINCComponent(item: NodeView) {
    Checkbox()
      .height(this.bulletListTheme.bulletListCheckboxHeight)
      .width(this.bulletListTheme.bulletListCheckboxWidth)
      .margin({ right: this.bulletListTheme.bulletListCheckboxSpacing })
      .shape(this.bulletListTheme.bulletListCheckboxShape)
      .selectedColor(this.bulletListTheme.bulletListCheckboxSelectedColor)
      .select(item.isTaskListSelected)
      .enabled(false)
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
