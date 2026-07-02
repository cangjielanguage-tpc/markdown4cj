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
import { MarkdownParagraph } from "./MarkdownParagraph"
import { MarkdownHeading } from "./MarkdownHeading"
import { MarkdownCodeFenced } from "./MarkdownCodeFenced"
import { MarkdownCodeBlockList } from "./MarkdownCodeBlockList"
import { MarkdownCodeIndented } from "./MarkdownCodeIndented"
import { MarkdownTable } from "./MarkdownTable"
import { MarkdownThematicBreak } from "./MarkdownThematicBreak"
import { MarkdownFootnote } from "./MarkdownFootnote"
import { MarkdownBanner } from "./MarkdownBanner"
import { MarkdownVideo } from "./MarkdownVideo"
import { MarkdownAudio } from "./MarkdownAudio"
import { MarkdownList } from "./MarkdownList"
import { MarkdownQuote } from "./MarkdownQuote"
import { MarkdownLatexMathBlock } from "./MarkdownLatexMathBlock"

/**
 * 列表项控件
 */
@Component
export struct MarkdownListItem {
  @ObjectLink @Watch('refreshData') node: NodeView // 列表项自身节点数据
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
  @Prop isOrdered: boolean // 父列表是否是有序列表
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
      space: this.isOrdered ? this.orderedListTheme.orderedListChildChildSpacing : this.bulletListTheme.bulletListChildChildSpacing
    }) {
      LazyForEach(
        this.markdownDataSource,
        (item: NodeView, index: number) => {
          ListItem() {
            if (item.nodeType === "Paragraph") {
              // 段落
              MarkdownParagraph({
                node: item,
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
                blockQuoteTheme: this.blockQuoteTheme,
                definitionListTheme: this.definitionListTheme,
                imageTheme: this.imageTheme,
                latexMathTheme: this.latexMathTheme,
                latexImageCallback: this.latexImageCallback,
                latexStrCallback: this.latexStrCallback,
                componentWidth: this.componentWidth,
                textCopyCallback: this.textCopyCallback,
                footnoteCallback: this.footnoteCallback,
                tocCallback: this.tocCallback,
                linkCallback: this.linkCallback,
                imageCallback: this.imageCallback,
                imageDownloadCallback: this.imageDownloadCallback,
                imageReplaceCallback: this.imageReplaceCallback
              })
            } else if (item.nodeType === "Heading" || item.nodeType === "IdHeading") {
              // 标题/标题ID
              MarkdownHeading({
                node: item,
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
                blockQuoteTheme: this.blockQuoteTheme,
                definitionListTheme: this.definitionListTheme,
                imageTheme: this.imageTheme,
                latexMathTheme: this.latexMathTheme,
                latexImageCallback: this.latexImageCallback,
                latexStrCallback: this.latexStrCallback,
                componentWidth: this.componentWidth,
                textCopyCallback: this.textCopyCallback,
                footnoteCallback: this.footnoteCallback,
                tocCallback: this.tocCallback,
                linkCallback: this.linkCallback,
                imageCallback: this.imageCallback,
                imageDownloadCallback: this.imageDownloadCallback,
                imageReplaceCallback: this.imageReplaceCallback
              })
            } else if (item.nodeType === "FencedCodeBlockListBlock") {
              // 围栏代码块列表
              MarkdownCodeBlockList({
                node: item,
                codeBlockTheme: this.codeBlockTheme,
                codeCopyCallback: this.codeCopyCallback,
                codeFullScreenCallback: this.codeFullScreenCallback
              })
            } else if (item.nodeType === "FencedCodeBlock") {
              // 围栏代码块
              MarkdownCodeFenced({
                node: item,
                codeBlockTheme: this.codeBlockTheme,
                codeCopyCallback: this.codeCopyCallback,
                codeFullScreenCallback: this.codeFullScreenCallback
              })
            } else if (item.nodeType === "IndentedCodeBlock") {
              // 缩进代码块
              MarkdownCodeIndented({
                node: item,
                codeBlockTheme: this.codeBlockTheme,
                codeCopyCallback: this.codeCopyCallback,
                codeFullScreenCallback: this.codeFullScreenCallback
              })
            } else if (item.nodeType === "BulletList") {
              // 无序列表
              MarkdownList({
                node: item,
                orderedListTheme: this.orderedListTheme,
                bulletListTheme: this.bulletListTheme,
                headingTheme: this.headingTheme,
                globalTheme: this.globalTheme,
                blockQuoteTheme: this.blockQuoteTheme,
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
                isOrdered: false,
                listDepth: this.listDepth + 1,
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
            } else if (item.nodeType === "OrderedList") {
              // 有序列表
              MarkdownList({
                node: item,
                orderedListTheme: this.orderedListTheme,
                bulletListTheme: this.bulletListTheme,
                headingTheme: this.headingTheme,
                globalTheme: this.globalTheme,
                blockQuoteTheme: this.blockQuoteTheme,
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
                isOrdered: true,
                listDepth: this.listDepth + 1,
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
            } else if (item.nodeType === "BlockQuote") {
              // 块引用
              MarkdownQuote({
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
                codeFullScreenCallback: this.codeFullScreenCallback,
                listDepth: this.listDepth + 1
              })
            } else if (item.nodeType === "LatexMathBlock") {
              // 数学公式块：闭合时渲染图片，未闭合时渲染文本
              if (item.isLatexMathBlockClose) {
                MarkdownLatexMathBlock({
                  latexMathBlockStr: item.nodeText,
                  latexMathTheme: this.latexMathTheme,
                  latexImageCallback: this.latexImageCallback,
                  latexStrCallback: this.latexStrCallback
                })
              } else if (this.latexMathTheme.latexMathDefaultText) {
                Text(item.nodeText)
                  .fontFamily(this.latexMathTheme.latexMathDefaultTextFontFamily)
                  .fontSize(this.latexMathTheme.latexMathDefaultTextFontSize)
                  .fontWeight(this.latexMathTheme.latexMathDefaultTextFontWeight)
                  .fontStyle(this.latexMathTheme.latexMathDefaultTextFontStyle)
                  .fontColor(this.latexMathTheme.latexMathDefaultTextFontColor)
                  .padding({
                    top: this.latexMathTheme.latexMathPaddingTop,
                    right: this.latexMathTheme.latexMathPaddingRight,
                    bottom: this.latexMathTheme.latexMathPaddingBottom,
                    left: this.latexMathTheme.latexMathPaddingLeft
                  })
                  .margin({
                    top: this.latexMathTheme.latexMathMarginTop,
                    right: this.latexMathTheme.latexMathMarginRight,
                    bottom: this.latexMathTheme.latexMathMarginBottom,
                    left: this.latexMathTheme.latexMathMarginLeft
                  })
              }
            } else if (item.nodeType === "TableBlock") {
              // 表格
              MarkdownTable({
                node: item,
                headingTheme: this.headingTheme,
                globalTheme: this.globalTheme,
                blockQuoteTheme: this.blockQuoteTheme,
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
                latexMathTheme: this.latexMathTheme,
                latexImageCallback: this.latexImageCallback,
                latexStrCallback: this.latexStrCallback,
                componentWidth: this.tableBlockComponentWidth
              })
            } else if (item.nodeType === "ThematicBreak") {
              // 分割线
              MarkdownThematicBreak({
                dividerTheme: this.dividerTheme
              })
            } else if (item.nodeType === "FootnoteBlock") {
              // 脚注
              MarkdownFootnote({
                node: item,
                footnoteDefTheme: this.footnoteDefTheme,
                headingTheme: this.headingTheme,
                globalTheme: this.globalTheme,
                blockQuoteTheme: this.blockQuoteTheme,
                orderedListTheme: this.orderedListTheme,
                bulletListTheme: this.bulletListTheme,
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
                codeBlockTheme: this.codeBlockTheme,
                dividerTheme: this.dividerTheme,
                bannerTheme: this.bannerTheme,
                videoTheme: this.videoTheme,
                audioTheme: this.audioTheme,
                latexMathTheme: this.latexMathTheme,
                latexImageCallback: this.latexImageCallback,
                latexStrCallback: this.latexStrCallback,
                componentWidth: this.componentWidth,
                tableBlockComponentWidth: this.tableBlockComponentWidth,
                listDepth: this.listDepth + 1,
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
            } else if (item.nodeType === "SlideBlock") {
              // 图片幻灯片
              MarkdownBanner({
                node: item,
                bannerTheme: this.bannerTheme,
                imageTheme: this.imageTheme,
                imageCallback: this.imageCallback
              })
            } else if (item.nodeType === "BlockVideo") {
              // 视频
              MarkdownVideo({
                node: item,
                videoTheme: this.videoTheme,
                videoCallback: this.videoCallback,
                videoImageCallback: this.videoImageCallback,
                videoReleaseCallback: this.videoReleaseCallback,
                videoDownloadCallback: this.videoDownloadCallback
              })
            } else if (item.nodeType === "BlockAudio") {
              // 音频
              MarkdownAudio({
                node: item,
                audioTheme: this.audioTheme,
                audioCallback: this.audioCallback
              })
            } else if (item.nodeType === "BlockAD") {
              // 广告
            } else {
              // 其他
            }
          }
        },
        (item: NodeView, index: number) => {
          if (item.nodeType === "LatexMathBlock") {
            return `${index}-${item.nodeHash}-${item.contentHash}`
          }
          return `${index}-${item.nodeHash}`
        }
      )
    }
    .listDirection(Axis.Vertical)
    .alignListItem(ListItemAlign.Start)
    .layoutWeight(1)
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
