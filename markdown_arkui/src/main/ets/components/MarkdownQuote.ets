import { MarkdownDataSource } from "../datasource/MarkdownDataSource"
import { NodeView } from "../model/NodeView"
import { MarkdownTheme } from "../theme/MarkdownTheme"
import { MarkdownParagraph } from "./MarkdownParagraph"
import { MarkdownHeading } from "./MarkdownHeading"
import { MarkdownExposureEvent } from "../model/MarkdownExposureEvent"
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
import { MarkdownLatexMathBlock } from "./MarkdownLatexMathBlock"
import { MarkdownHighlightParagraph } from "../configs/MarkdownHighlightParagraph"
import { safeString } from "../utils/MarkdownUtils"

/**
 * 块引用控件
 */
@Component
export struct MarkdownQuote {
  @ObjectLink @Watch('refreshData') node: NodeView // 块引用自身节点数据
  @ObjectLink theme: MarkdownTheme // 聚合主题（透传块，无 @Watch）：子主题变化由根组件集中观察发布，经 this.theme.xxxTheme 读取
  @ObjectLink markdownHighlightParagraph: MarkdownHighlightParagraph // 段落高亮配置
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
  tableCopyCallback?: (str: string) => void // 复制点击事件
  latexImageCallback?: (data: ArrayBuffer, height: number, width: number) => void // 数学公式图片点击事件
  latexStrCallback: (str: string) => string = (str: string) => str // 数学公式数据处理事件
  customLongPressCallback?: (str: string) => void = undefined // 自定义长按事件
  paragraphHeadingAnimationStart?: () => void // 段落动画开始回调
  paragraphHeadingAnimationEnd?: () => void // 段落动画结束回调
  @Prop listDepth: number = 0 // 嵌套深度
  scroller: Scroller = new Scroller() // list控制器
  markdownDataSource: MarkdownDataSource = new MarkdownDataSource([]) // markdown页面数据源

  @BuilderParam blockImageCardComponent: (desc:string, imageSrc:string, title:string) => void
  @BuilderParam blockLinkCardComponent: (desc:string, link:string, title:string) => void
  @BuilderParam customTagViewComponent: (tag:string, attrs:Record<string,string>, content:string) => void

  aboutToAppear(): void {
    this.refreshData() // 首次加载
  }

  build() {
    List({ scroller: this.scroller, space: this.theme.blockQuoteTheme.blockQuoteChildSpacing }) {
      LazyForEach(
        this.markdownDataSource,
        (item: NodeView, index: number) => {
          // 块引用内表格不吸顶：stickyHolder.y 是最外层滚动 Y，tableY 相对父 List，offset 计算错误
          // 始终走 ListItem 路径，MarkdownTable 内部通过 enableSticky=false 关闭吸顶渲染
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
                  paragraphHeadingAnimationEnd: this.paragraphHeadingAnimationEnd
                })
              } else if (item.nodeType === "Heading" || item.nodeType === "IdHeading") {
                // 标题/标题ID
                MarkdownHeading({
                  node: item,
                  theme: this.theme,
                  latexImageCallback: this.latexImageCallback,
                  latexStrCallback: this.latexStrCallback,
                  componentWidth: this.componentWidth,
                  textCopyCallback: this.textCopyCallback,
                  footnoteCallback: this.footnoteCallback,
                  tocCallback: this.tocCallback,
                  linkCallback: this.linkCallback,
                  imageCallback: this.imageCallback,
                  imageDownloadCallback: this.imageDownloadCallback,
                  imageReplaceCallback: this.imageReplaceCallback,
                  markdownHighlightParagraph: this.markdownHighlightParagraph,
                  customLongPressCallback: this.customLongPressCallback,
                  elementExposureCallback: this.elementExposureCallback,
                  exposureThreshold: this.exposureThreshold,
                  paragraphHeadingAnimationStart: this.paragraphHeadingAnimationStart,
                  paragraphHeadingAnimationEnd: this.paragraphHeadingAnimationEnd
                })
              } else if (item.nodeType === "FencedCodeBlockListBlock") {
                // 围栏代码块列表
                MarkdownCodeBlockList({
                  node: item,
                  codeBlockTheme: this.theme.codeBlockTheme,
                  codeCopyCallback: this.codeCopyCallback,
                  codeFullScreenCallback: this.codeFullScreenCallback
                })
              } else if (item.nodeType === "FencedCodeBlock") {
                // 围栏代码块
                MarkdownCodeFenced({
                  node: item,
                  codeBlockTheme: this.theme.codeBlockTheme,
                  codeCopyCallback: this.codeCopyCallback,
                  codeFullScreenCallback: this.codeFullScreenCallback
                })
              } else if (item.nodeType === "IndentedCodeBlock") {
                // 缩进代码块
                MarkdownCodeIndented({
                  node: item,
                  codeBlockTheme: this.theme.codeBlockTheme,
                  codeCopyCallback: this.codeCopyCallback,
                  codeFullScreenCallback: this.codeFullScreenCallback
                })
              } else if (item.nodeType === "BulletList") {
                // 无序列表
                MarkdownList({
                  node: item,
                  theme: this.theme,
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
              } else if (item.nodeType === "OrderedList") {
                // 有序列表
                MarkdownList({
                  node: item,
                  theme: this.theme,
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
              } else if (item.nodeType === "BlockQuote") {
                // 块引用
                MarkdownQuote({
                  node: item,
                  theme: this.theme,
                  latexImageCallback: this.latexImageCallback,
                  latexStrCallback: this.latexStrCallback,
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
                  listDepth: this.listDepth + 1,
                  tableCopyCallback: this.tableCopyCallback,
                  markdownHighlightParagraph: this.markdownHighlightParagraph,
                  customLongPressCallback: this.customLongPressCallback,
                  paragraphHeadingAnimationStart: this.paragraphHeadingAnimationStart,
                  paragraphHeadingAnimationEnd: this.paragraphHeadingAnimationEnd,
                  blockImageCardComponent:this.blockImageCardComponent,
                  blockLinkCardComponent:this.blockLinkCardComponent,
                  customTagViewComponent: this.customTagViewComponent
                })
              } else if (item.nodeType === "LatexMathBlock") {
                // 数学公式块：闭合时渲染图片，未闭合时渲染文本
                if (item.isLatexMathBlockClose) {
                  MarkdownLatexMathBlock({
                    latexMathBlockStr: item.nodeText,
                    latexMathTheme: this.theme.latexMathTheme,
                    latexImageCallback: this.latexImageCallback,
                    latexStrCallback: this.latexStrCallback
                  })
                } else if (this.theme.latexMathTheme.latexMathDefaultText) {
                  Text(item.nodeText)
                    .fontFamily(this.theme.latexMathTheme.latexMathDefaultTextFontFamily)
                    .fontSize(this.theme.latexMathTheme.latexMathDefaultTextFontSize)
                    .fontWeight(this.theme.latexMathTheme.latexMathDefaultTextFontWeight)
                    .fontStyle(this.theme.latexMathTheme.latexMathDefaultTextFontStyle)
                    .fontColor(this.theme.latexMathTheme.latexMathDefaultTextFontColor)
                    .padding({
                      top: this.theme.latexMathTheme.latexMathPaddingTop,
                      right: this.theme.latexMathTheme.latexMathPaddingRight,
                      bottom: this.theme.latexMathTheme.latexMathPaddingBottom,
                      left: this.theme.latexMathTheme.latexMathPaddingLeft
                    })
                    .margin({
                      top: this.theme.latexMathTheme.latexMathMarginTop,
                      right: this.theme.latexMathTheme.latexMathMarginRight,
                      bottom: this.theme.latexMathTheme.latexMathMarginBottom,
                      left: this.theme.latexMathTheme.latexMathMarginLeft
                    })
                }
              } else if (item.nodeType === "TableBlock") {
                // 表格
                MarkdownTable({
                  node: item,
                  headingTheme: this.theme.headingTheme,
                  globalTheme: this.theme.globalTheme,
                  blockQuoteTheme: this.theme.blockQuoteTheme,
                  subTheme: this.theme.subTheme,
                  supTheme: this.theme.supTheme,
                  inlineCodeTheme: this.theme.inlineCodeTheme,
                  boldTheme: this.theme.boldTheme,
                  italicTheme: this.theme.italicTheme,
                  strikethroughTheme: this.theme.strikethroughTheme,
                  highlightTheme: this.theme.highlightTheme,
                  htmlUnderlineTheme: this.theme.htmlUnderlineTheme,
                  linkTheme: this.theme.linkTheme,
                  footnoteRefTheme: this.theme.footnoteRefTheme,
                  tableTheme: this.theme.tableTheme,
                  paragraphTheme: this.theme.paragraphTheme,
                  definitionListTheme: this.theme.definitionListTheme,
                  imageTheme: this.theme.imageTheme,
                  latexMathTheme: this.theme.latexMathTheme,
                  latexImageCallback: this.latexImageCallback,
                  latexStrCallback: this.latexStrCallback,
                  componentWidth: this.tableBlockComponentWidth,
                  tableCopyCallback: this.tableCopyCallback,
                  markdownHighlightParagraph: this.markdownHighlightParagraph,
                  customLongPressCallback: this.customLongPressCallback,
                  elementExposureCallback: this.elementExposureCallback,
                  exposureThreshold: this.exposureThreshold,
                  enableSticky: false,
                  blockImageCardComponent:this.blockImageCardComponent,
                  blockLinkCardComponent:this.blockLinkCardComponent
                })
              } else if (item.nodeType === "ThematicBreak") {
                // 分割线
                MarkdownThematicBreak({
                  dividerTheme: this.theme.dividerTheme
                })
              } else if (item.nodeType === "FootnoteBlock") {
                // 脚注
                MarkdownFootnote({
                  node: item,
                  theme: this.theme,
                  latexImageCallback: this.latexImageCallback,
                  latexStrCallback: this.latexStrCallback,
                  componentWidth: this.componentWidth,
                  tableBlockComponentWidth: this.tableBlockComponentWidth,
                  listDepth: this.listDepth + 1,
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
                  markdownHighlightParagraph: this.markdownHighlightParagraph,
                  customLongPressCallback: this.customLongPressCallback,
                  paragraphHeadingAnimationStart: this.paragraphHeadingAnimationStart,
                  paragraphHeadingAnimationEnd: this.paragraphHeadingAnimationEnd
                })
              } else if (item.nodeType === "SlideBlock") {
                // 图片幻灯片
                MarkdownBanner({
                  node: item,
                  bannerTheme: this.theme.bannerTheme,
                  imageTheme: this.theme.imageTheme,
                  imageCallback: this.imageCallback
                })
              } else if (item.nodeType === "BlockVideo") {
                // 视频
                MarkdownVideo({
                  node: item,
                  videoTheme: this.theme.videoTheme,
                  videoCallback: this.videoCallback,
                  videoImageCallback: this.videoImageCallback,
                  videoReleaseCallback: this.videoReleaseCallback,
                  videoDownloadCallback: this.videoDownloadCallback
                })
              } else if (item.nodeType === "BlockAudio") {
                // 音频
                MarkdownAudio({
                  node: item,
                  audioTheme: this.theme.audioTheme,
                  audioCallback: this.audioCallback
                })
              }else if (item.nodeType === "CustomCardImage") {
                // 音频
                this.blockImageCardComponent(
                  safeString(item.imageAltText),
                  safeString(item.imageUrl),
                  safeString(item.imageTitle)
                )
              } else if (item.nodeType === "CustomCardLink") {
                // 音频
                this.blockLinkCardComponent(
                  safeString(item.nodeText),
                  safeString(item.linkUrl),
                  safeString(item.linkTitle)
                )
              } else if (item.customTag !== undefined) {
                // 已注册的自定义标签块级视图
                this.customTagViewComponent(
                  item.customTag,
                  item.customAttrs ?? {},
                  item.customContent ?? ""
                )
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
          if (item.nodeType === "TableBlock") {
            return `${index}-${item.nodeHash}-${this.theme.tableTheme.tableStickyHeader}`
          }
          return `${index}-${item.nodeHash}`
        }
      )
    }
    .listDirection(Axis.Vertical)
    .alignListItem(ListItemAlign.Start)
    .sticky(StickyStyle.Header)
    .backgroundColor(this.theme.blockQuoteTheme.blockQuoteBackgroundColor)
    .borderRadius({
      topLeft: this.theme.blockQuoteTheme.blockQuoteRadiusTopLeft,
      topRight: this.theme.blockQuoteTheme.blockQuoteRadiusTopRight,
      bottomLeft: this.theme.blockQuoteTheme.blockQuoteRadiusBottomLeft,
      bottomRight: this.theme.blockQuoteTheme.blockQuoteRadiusBottomRight
    })
    .borderWidth({ left: this.theme.blockQuoteTheme.blockQuoteLeftBorderWidth })
    .borderColor(this.theme.blockQuoteTheme.blockQuoteLeftBorderColor)
    .padding({
      top: this.theme.blockQuoteTheme.blockQuotePaddingTop,
      right: this.theme.blockQuoteTheme.blockQuotePaddingRight,
      bottom: this.theme.blockQuoteTheme.blockQuotePaddingBottom,
      left: this.theme.blockQuoteTheme.blockQuotePaddingLeft
    })
    .margin({
      top: this.theme.blockQuoteTheme.blockQuoteMarginTop,
      right: this.theme.blockQuoteTheme.blockQuoteMarginRight,
      bottom: this.theme.blockQuoteTheme.blockQuoteMarginBottom,
      left: this.theme.blockQuoteTheme.blockQuoteMarginLeft
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
