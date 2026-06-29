import { Options, MarkdownParser, JsNodeImpl } from "@cangjie-tpc/markdown_parser_hybrid"
import { MarkdownDataSource } from "../datasorce/MarkdownDataSource"
import { MarkdownHeading } from "./MarkdownHeading"
import { MarkdownConfiguration } from '../configs/MarkdownConfiguration'
import { MarkdownPlugin } from '../plugin/MarkdownPlugin'
import { JsNodePoolImpl, NodeView } from "../model/NodeView"
import { nodeToNodeView } from "../utils/MarkdownParserUtils"
import { MarkdownParagraph } from "./MarkdownParagraph"
import { MarkdownThematicBreak } from "./MarkdownThematicBreak"
import { image } from "@kit.ImageKit"
import { MarkdownAudio } from "./MarkdownAudio"
import { MarkdownVideo } from "./MarkdownVideo"
import { MarkdownBanner } from "./MarkdownBanner"
import { MarkdownCodeFenced } from "./MarkdownCodeFenced"
import { MarkdownCodeBlockList } from "./MarkdownCodeBlockList"
import { MarkdownCodeIndented } from "./MarkdownCodeIndented"
import { MarkdownFootnote } from "./MarkdownFootnote"
import { MarkdownDesc } from "./MarkdownDesc"
import { MarkdownTable } from "./MarkdownTable"
import { MarkdownList } from "./MarkdownList"
import { MarkdownQuote } from "./MarkdownQuote"
import { MarkdownLatexMathBlock } from "./MarkdownLatexMathBlock"
import hilog from "@ohos.hilog"

@Component
export struct CJMarkdown {
  @Prop @Watch('refreshData') content: string // 外部传入的Markdown文档
  @ObjectLink config: MarkdownConfiguration // markdown配置项
  @Provide placeholderPixelMap: PixelMap | undefined = undefined // 图片占位图
  @Provide isLatexMathEnabled: boolean = false // 数学公式插件是否启用（控制是否调用latexStringToImage）
  @State componentWidth: number = 0.0 // markdown控件宽度
  scroller: Scroller = new Scroller() // list控制器
  markdownDataSource: MarkdownDataSource = new MarkdownDataSource([]) // markdown页面数据源
  private parseVersion: number = 0 // 解析版本号，每次解析递增
  private appliedVersion: number = 0 // 已应用的版本号，用于渐进式更新（避免丢弃所有中间结果）
  private isThrottled: boolean = false // 解析节流标志
  private hasPendingRefresh: boolean = false // 节流期间有未处理的刷新请求
  imageAndVideoList: Array<string> = Array<string>() // 所有图片视频的url
  jsNodePoolImpl: JsNodePoolImpl = new JsNodePoolImpl()
  plugin: MarkdownPlugin = new MarkdownPlugin() // markdown插件配置

  aboutToAppear(): void {
    this.isLatexMathEnabled = this.plugin.isLatexMathPlugin
    this.refreshData() // 首次加载
    this.loadPlaceholderImage() // 占位图处理
  }

  build() {
    List({
      scroller: this.scroller,
      space: this.config.markdownTheme.globalTheme.markdownBlockSpacing
    }) {
      LazyForEach(
        this.markdownDataSource,
        (item: NodeView, index: number) => {
          ListItem() {
            if (item.nodeType == "Heading" || item.nodeType == "IdHeading") {
              // 标题/标题ID
              MarkdownHeading({
                node: item,
                headingTheme: this.config.markdownTheme.headingTheme,
                globalTheme: this.config.markdownTheme.globalTheme,
                subTheme: this.config.markdownTheme.subTheme,
                supTheme: this.config.markdownTheme.supTheme,
                inlineCodeTheme: this.config.markdownTheme.inlineCodeTheme,
                boldTheme: this.config.markdownTheme.boldTheme,
                italicTheme: this.config.markdownTheme.italicTheme,
                strikethroughTheme: this.config.markdownTheme.strikethroughTheme,
                highlightTheme: this.config.markdownTheme.highlightTheme,
                htmlUnderlineTheme: this.config.markdownTheme.htmlUnderlineTheme,
                linkTheme: this.config.markdownTheme.linkTheme,
                footnoteRefTheme: this.config.markdownTheme.footnoteRefTheme,
                tableTheme: this.config.markdownTheme.tableTheme,
                paragraphTheme: this.config.markdownTheme.paragraphTheme,
                blockQuoteTheme: this.config.markdownTheme.blockQuoteTheme,
                definitionListTheme: this.config.markdownTheme.definitionListTheme,
                imageTheme: this.config.markdownTheme.imageTheme,
                latexMathTheme: this.config.markdownTheme.latexMathTheme,
                latexImageCallback: this.config.latexImageCallback,
                latexStrCallback: this.config.latexStrCallback,
                componentWidth: this.componentWidth,
                textCopyCallback: this.config.textCopyCallback,
                footnoteCallback: this.footnoteCallback,
                tocCallback: this.tocCallback,
                linkCallback: this.config.linkCallback,
                imageCallback: this.imageCallback
              })
            } else if (item.nodeType == "Paragraph") {
              // 段落
              MarkdownParagraph({
                node: item,
                headingTheme: this.config.markdownTheme.headingTheme,
                globalTheme: this.config.markdownTheme.globalTheme,
                subTheme: this.config.markdownTheme.subTheme,
                supTheme: this.config.markdownTheme.supTheme,
                inlineCodeTheme: this.config.markdownTheme.inlineCodeTheme,
                boldTheme: this.config.markdownTheme.boldTheme,
                italicTheme: this.config.markdownTheme.italicTheme,
                strikethroughTheme: this.config.markdownTheme.strikethroughTheme,
                highlightTheme: this.config.markdownTheme.highlightTheme,
                htmlUnderlineTheme: this.config.markdownTheme.htmlUnderlineTheme,
                linkTheme: this.config.markdownTheme.linkTheme,
                footnoteRefTheme: this.config.markdownTheme.footnoteRefTheme,
                tableTheme: this.config.markdownTheme.tableTheme,
                paragraphTheme: this.config.markdownTheme.paragraphTheme,
                blockQuoteTheme: this.config.markdownTheme.blockQuoteTheme,
                definitionListTheme: this.config.markdownTheme.definitionListTheme,
                imageTheme: this.config.markdownTheme.imageTheme,
                latexMathTheme: this.config.markdownTheme.latexMathTheme,
                latexImageCallback: this.config.latexImageCallback,
                latexStrCallback: this.config.latexStrCallback,
                componentWidth: this.componentWidth,
                textCopyCallback: this.config.textCopyCallback,
                footnoteCallback: this.footnoteCallback,
                tocCallback: this.tocCallback,
                linkCallback: this.config.linkCallback,
                imageCallback: this.imageCallback
              })
            } else if (item.nodeType == "FencedCodeBlockListBlock") {
              // 围栏代码块列表
              MarkdownCodeBlockList({
                node: item,
                codeBlockTheme: this.config.markdownTheme.codeBlockTheme,
                codeCopyCallback: this.config.codeCopyCallback,
                codeFullScreenCallback: this.config.codeFullScreenCallback
              })
            } else if (item.nodeType == "FencedCodeBlock") {
              // 围栏代码块
              MarkdownCodeFenced({
                node: item,
                codeBlockTheme: this.config.markdownTheme.codeBlockTheme,
                codeCopyCallback: this.config.codeCopyCallback,
                codeFullScreenCallback: this.config.codeFullScreenCallback
              })
            } else if (item.nodeType == "IndentedCodeBlock") {
              // 缩进代码块
              MarkdownCodeIndented({
                node: item,
                codeBlockTheme: this.config.markdownTheme.codeBlockTheme,
                codeCopyCallback: this.config.codeCopyCallback,
                codeFullScreenCallback: this.config.codeFullScreenCallback
              })
            } else if (item.nodeType == "BulletList") {
              // 无序/任务列表
              MarkdownList({
                node: item,
                blockQuoteTheme: this.config.markdownTheme.blockQuoteTheme,
                orderedListTheme: this.config.markdownTheme.orderedListTheme,
                bulletListTheme: this.config.markdownTheme.bulletListTheme,
                headingTheme: this.config.markdownTheme.headingTheme,
                globalTheme: this.config.markdownTheme.globalTheme,
                subTheme: this.config.markdownTheme.subTheme,
                supTheme: this.config.markdownTheme.supTheme,
                inlineCodeTheme: this.config.markdownTheme.inlineCodeTheme,
                boldTheme: this.config.markdownTheme.boldTheme,
                italicTheme: this.config.markdownTheme.italicTheme,
                strikethroughTheme: this.config.markdownTheme.strikethroughTheme,
                highlightTheme: this.config.markdownTheme.highlightTheme,
                htmlUnderlineTheme: this.config.markdownTheme.htmlUnderlineTheme,
                linkTheme: this.config.markdownTheme.linkTheme,
                footnoteRefTheme: this.config.markdownTheme.footnoteRefTheme,
                tableTheme: this.config.markdownTheme.tableTheme,
                paragraphTheme: this.config.markdownTheme.paragraphTheme,
                definitionListTheme: this.config.markdownTheme.definitionListTheme,
                imageTheme: this.config.markdownTheme.imageTheme,
                footnoteDefTheme: this.config.markdownTheme.footnoteDefTheme,
                codeBlockTheme: this.config.markdownTheme.codeBlockTheme,
                dividerTheme: this.config.markdownTheme.dividerTheme,
                bannerTheme: this.config.markdownTheme.bannerTheme,
                videoTheme: this.config.markdownTheme.videoTheme,
                audioTheme: this.config.markdownTheme.audioTheme,
                latexMathTheme: this.config.markdownTheme.latexMathTheme,
                latexImageCallback: this.config.latexImageCallback,
                latexStrCallback: this.config.latexStrCallback,
                isOrdered: false,
                listDepth: 0,
                componentWidth: this.componentWidth,
                tableBlockComponentWidth: this.componentWidth,
                imageCallback: this.imageCallback,
                videoCallback: this.videoCallback,
                videoImageCallback: this.config.videoImageCallback,
                videoReleaseCallback: this.config.videoReleaseCallback,
                videoDownloadCallback: this.config.videoDownloadCallback,
                audioCallback: this.config.audioCallback,
                codeCopyCallback: this.config.codeCopyCallback,
                codeFullScreenCallback: this.config.codeFullScreenCallback,
                linkCallback: this.config.linkCallback,
                textCopyCallback: this.config.textCopyCallback,
                footnoteCallback: this.footnoteCallback,
                tocCallback: this.tocCallback
              })
            } else if (item.nodeType == "OrderedList") {
              // 有序列表
              MarkdownList({
                node: item,
                blockQuoteTheme: this.config.markdownTheme.blockQuoteTheme,
                orderedListTheme: this.config.markdownTheme.orderedListTheme,
                bulletListTheme: this.config.markdownTheme.bulletListTheme,
                headingTheme: this.config.markdownTheme.headingTheme,
                globalTheme: this.config.markdownTheme.globalTheme,
                subTheme: this.config.markdownTheme.subTheme,
                supTheme: this.config.markdownTheme.supTheme,
                inlineCodeTheme: this.config.markdownTheme.inlineCodeTheme,
                boldTheme: this.config.markdownTheme.boldTheme,
                italicTheme: this.config.markdownTheme.italicTheme,
                strikethroughTheme: this.config.markdownTheme.strikethroughTheme,
                highlightTheme: this.config.markdownTheme.highlightTheme,
                htmlUnderlineTheme: this.config.markdownTheme.htmlUnderlineTheme,
                linkTheme: this.config.markdownTheme.linkTheme,
                footnoteRefTheme: this.config.markdownTheme.footnoteRefTheme,
                tableTheme: this.config.markdownTheme.tableTheme,
                paragraphTheme: this.config.markdownTheme.paragraphTheme,
                definitionListTheme: this.config.markdownTheme.definitionListTheme,
                imageTheme: this.config.markdownTheme.imageTheme,
                footnoteDefTheme: this.config.markdownTheme.footnoteDefTheme,
                codeBlockTheme: this.config.markdownTheme.codeBlockTheme,
                dividerTheme: this.config.markdownTheme.dividerTheme,
                bannerTheme: this.config.markdownTheme.bannerTheme,
                videoTheme: this.config.markdownTheme.videoTheme,
                audioTheme: this.config.markdownTheme.audioTheme,
                latexMathTheme: this.config.markdownTheme.latexMathTheme,
                latexImageCallback: this.config.latexImageCallback,
                latexStrCallback: this.config.latexStrCallback,
                isOrdered: true,
                listDepth: 0,
                componentWidth: this.componentWidth,
                tableBlockComponentWidth: this.componentWidth,
                imageCallback: this.imageCallback,
                videoCallback: this.videoCallback,
                videoImageCallback: this.config.videoImageCallback,
                videoReleaseCallback: this.config.videoReleaseCallback,
                videoDownloadCallback: this.config.videoDownloadCallback,
                audioCallback: this.config.audioCallback,
                codeCopyCallback: this.config.codeCopyCallback,
                codeFullScreenCallback: this.config.codeFullScreenCallback,
                linkCallback: this.config.linkCallback,
                textCopyCallback: this.config.textCopyCallback,
                footnoteCallback: this.footnoteCallback,
                tocCallback: this.tocCallback
              })
            } else if (item.nodeType == "BlockQuote") {
              // 块引用
              MarkdownQuote({
                node: item,
                blockQuoteTheme: this.config.markdownTheme.blockQuoteTheme,
                orderedListTheme: this.config.markdownTheme.orderedListTheme,
                bulletListTheme: this.config.markdownTheme.bulletListTheme,
                headingTheme: this.config.markdownTheme.headingTheme,
                globalTheme: this.config.markdownTheme.globalTheme,
                subTheme: this.config.markdownTheme.subTheme,
                supTheme: this.config.markdownTheme.supTheme,
                inlineCodeTheme: this.config.markdownTheme.inlineCodeTheme,
                boldTheme: this.config.markdownTheme.boldTheme,
                italicTheme: this.config.markdownTheme.italicTheme,
                strikethroughTheme: this.config.markdownTheme.strikethroughTheme,
                highlightTheme: this.config.markdownTheme.highlightTheme,
                htmlUnderlineTheme: this.config.markdownTheme.htmlUnderlineTheme,
                linkTheme: this.config.markdownTheme.linkTheme,
                footnoteRefTheme: this.config.markdownTheme.footnoteRefTheme,
                tableTheme: this.config.markdownTheme.tableTheme,
                paragraphTheme: this.config.markdownTheme.paragraphTheme,
                definitionListTheme: this.config.markdownTheme.definitionListTheme,
                imageTheme: this.config.markdownTheme.imageTheme,
                footnoteDefTheme: this.config.markdownTheme.footnoteDefTheme,
                codeBlockTheme: this.config.markdownTheme.codeBlockTheme,
                dividerTheme: this.config.markdownTheme.dividerTheme,
                bannerTheme: this.config.markdownTheme.bannerTheme,
                videoTheme: this.config.markdownTheme.videoTheme,
                audioTheme: this.config.markdownTheme.audioTheme,
                latexMathTheme: this.config.markdownTheme.latexMathTheme,
                latexImageCallback: this.config.latexImageCallback,
                latexStrCallback: this.config.latexStrCallback,
                componentWidth: this.componentWidth,
                tableBlockComponentWidth: this.componentWidth,
                listDepth: 0,
                imageCallback: this.imageCallback,
                videoCallback: this.videoCallback,
                videoImageCallback: this.config.videoImageCallback,
                videoReleaseCallback: this.config.videoReleaseCallback,
                videoDownloadCallback: this.config.videoDownloadCallback,
                audioCallback: this.config.audioCallback,
                codeCopyCallback: this.config.codeCopyCallback,
                codeFullScreenCallback: this.config.codeFullScreenCallback,
                linkCallback: this.config.linkCallback,
                textCopyCallback: this.config.textCopyCallback,
                footnoteCallback: this.footnoteCallback,
                tocCallback: this.tocCallback
              })
            } else if (item.nodeType == "LatexMathBlock") {
              // 数学公式块
              if (this.isLatexMathEnabled) {
                MarkdownLatexMathBlock({
                  latexMathBlockStr: item.nodeText,
                  latexMathTheme: this.config.markdownTheme.latexMathTheme,
                  latexImageCallback: this.config.latexImageCallback,
                  latexStrCallback: this.config.latexStrCallback
                })
              } else {
                Text(item.nodeText)
                  .width('100%')
                  .textAlign(TextAlign.Center)
                  .padding(10)
              }
            } else if (item.nodeType == "TableBlock") {
              // 表格
              MarkdownTable({
                node: item,
                headingTheme: this.config.markdownTheme.headingTheme,
                globalTheme: this.config.markdownTheme.globalTheme,
                subTheme: this.config.markdownTheme.subTheme,
                supTheme: this.config.markdownTheme.supTheme,
                inlineCodeTheme: this.config.markdownTheme.inlineCodeTheme,
                boldTheme: this.config.markdownTheme.boldTheme,
                italicTheme: this.config.markdownTheme.italicTheme,
                strikethroughTheme: this.config.markdownTheme.strikethroughTheme,
                highlightTheme: this.config.markdownTheme.highlightTheme,
                htmlUnderlineTheme: this.config.markdownTheme.htmlUnderlineTheme,
                linkTheme: this.config.markdownTheme.linkTheme,
                footnoteRefTheme: this.config.markdownTheme.footnoteRefTheme,
                tableTheme: this.config.markdownTheme.tableTheme,
                paragraphTheme: this.config.markdownTheme.paragraphTheme,
                blockQuoteTheme: this.config.markdownTheme.blockQuoteTheme,
                definitionListTheme: this.config.markdownTheme.definitionListTheme,
                imageTheme: this.config.markdownTheme.imageTheme,
                latexMathTheme: this.config.markdownTheme.latexMathTheme,
                latexImageCallback: this.config.latexImageCallback,
                latexStrCallback: this.config.latexStrCallback,
                componentWidth: this.componentWidth,
                textCopyCallback: this.config.textCopyCallback,
                footnoteCallback: this.footnoteCallback,
                tocCallback: this.tocCallback,
                linkCallback: this.config.linkCallback,
                imageCallback: this.imageCallback
              })
            } else if (item.nodeType == "ThematicBreak") {
              // 分割线
              MarkdownThematicBreak({
                dividerTheme: this.config.markdownTheme.dividerTheme
              })
            } else if (item.nodeType == "FootnoteBlock") {
              // 脚注
              MarkdownFootnote({
                node: item,
                headingTheme: this.config.markdownTheme.headingTheme,
                globalTheme: this.config.markdownTheme.globalTheme,
                subTheme: this.config.markdownTheme.subTheme,
                supTheme: this.config.markdownTheme.supTheme,
                inlineCodeTheme: this.config.markdownTheme.inlineCodeTheme,
                boldTheme: this.config.markdownTheme.boldTheme,
                italicTheme: this.config.markdownTheme.italicTheme,
                strikethroughTheme: this.config.markdownTheme.strikethroughTheme,
                highlightTheme: this.config.markdownTheme.highlightTheme,
                htmlUnderlineTheme: this.config.markdownTheme.htmlUnderlineTheme,
                linkTheme: this.config.markdownTheme.linkTheme,
                footnoteRefTheme: this.config.markdownTheme.footnoteRefTheme,
                tableTheme: this.config.markdownTheme.tableTheme,
                paragraphTheme: this.config.markdownTheme.paragraphTheme,
                blockQuoteTheme: this.config.markdownTheme.blockQuoteTheme,
                definitionListTheme: this.config.markdownTheme.definitionListTheme,
                imageTheme: this.config.markdownTheme.imageTheme,
                footnoteDefTheme: this.config.markdownTheme.footnoteDefTheme,
                latexMathTheme: this.config.markdownTheme.latexMathTheme,
                latexImageCallback: this.config.latexImageCallback,
                latexStrCallback: this.config.latexStrCallback,
                componentWidth: this.componentWidth,
                textCopyCallback: this.config.textCopyCallback,
                footnoteCallback: this.footnoteCallback,
                tocCallback: this.tocCallback,
                linkCallback: this.config.linkCallback,
                imageCallback: this.imageCallback
              })
            } else if (item.nodeType == "DescList") {
              // 定义列表
              MarkdownDesc({
                node: item,
                headingTheme: this.config.markdownTheme.headingTheme,
                globalTheme: this.config.markdownTheme.globalTheme,
                subTheme: this.config.markdownTheme.subTheme,
                supTheme: this.config.markdownTheme.supTheme,
                inlineCodeTheme: this.config.markdownTheme.inlineCodeTheme,
                boldTheme: this.config.markdownTheme.boldTheme,
                italicTheme: this.config.markdownTheme.italicTheme,
                strikethroughTheme: this.config.markdownTheme.strikethroughTheme,
                highlightTheme: this.config.markdownTheme.highlightTheme,
                htmlUnderlineTheme: this.config.markdownTheme.htmlUnderlineTheme,
                linkTheme: this.config.markdownTheme.linkTheme,
                footnoteRefTheme: this.config.markdownTheme.footnoteRefTheme,
                tableTheme: this.config.markdownTheme.tableTheme,
                paragraphTheme: this.config.markdownTheme.paragraphTheme,
                blockQuoteTheme: this.config.markdownTheme.blockQuoteTheme,
                definitionListTheme: this.config.markdownTheme.definitionListTheme,
                imageTheme: this.config.markdownTheme.imageTheme,
                latexMathTheme: this.config.markdownTheme.latexMathTheme,
                latexImageCallback: this.config.latexImageCallback,
                latexStrCallback: this.config.latexStrCallback,
                componentWidth: this.componentWidth,
                textCopyCallback: this.config.textCopyCallback,
                footnoteCallback: this.footnoteCallback,
                tocCallback: this.tocCallback,
                linkCallback: this.config.linkCallback,
                imageCallback: this.imageCallback
              })
            } else if (item.nodeType == "SlideBlock") {
              // 图片幻灯片
              MarkdownBanner({
                node: item,
                bannerTheme: this.config.markdownTheme.bannerTheme,
                imageTheme: this.config.markdownTheme.imageTheme,
                imageCallback: this.imageCallback
              })
            } else if (item.nodeType == "BlockVideo") {
              // 视频
              MarkdownVideo({
                node: item,
                videoTheme: this.config.markdownTheme.videoTheme,
                videoCallback: this.videoCallback,
                videoImageCallback: this.config.videoImageCallback,
                videoReleaseCallback: this.config.videoReleaseCallback,
                videoDownloadCallback: this.config.videoDownloadCallback
              })
            } else if (item.nodeType == "BlockAudio") {
              // 音频
              MarkdownAudio({
                node: item,
                audioTheme: this.config.markdownTheme.audioTheme,
                audioCallback: this.config.audioCallback
              })
            } else if (item.nodeType == "BlockAD") {
              // 广告
            } else {
              // 其他
            }
          }
        },
        (item: NodeView, index: number) => {
          // 稳定key：仅用index+nodeType，不包含内容指纹
          // 内容更新通过就地修改NodeView属性+@ObjectLink的@Watch实现，避免组件重建
          // 仅当nodeType变化（如Paragraph→Heading）时key才变化，触发组件重建
          return `${index}-${item.nodeType}`
        }
      )
    }
    .margin(
      {
        top: this.config.markdownTheme.globalTheme.blockMarginTop,
        right: this.config.markdownTheme.globalTheme.blockMarginRight,
        bottom: this.config.markdownTheme.globalTheme.blockMarginBottom,
        left: this.config.markdownTheme.globalTheme.blockMarginLeft
      }
    )
    .backgroundColor(this.config.markdownTheme.globalTheme.backgroundColor)
    .listDirection(Axis.Vertical)
    .alignListItem(ListItemAlign.Start)
    .scrollBar(BarState.Off)
    .enableScrollInteraction(this.config.markdownTheme.globalTheme.openGestureSwipe)
    .onSizeChange((oldValue, newValue) => {
      let newWidth: number = 0
      if (typeof newValue.width === 'number') {
        newWidth = newValue.width
      }
      if (this.componentWidth != newWidth) {
        this.componentWidth = newWidth
      }
    })
  }

  /**
   * 刷新数据（节流入口）
   * 流式输出时content高频变化，通过leading-edge节流将解析频率从~30次/秒降至~8次/秒
   * 首次调用立即执行（无延迟），后续调用在parseThrottleMs内被合并，最后一次必有trailing调用
   */
  refreshData() {
    if (this.isThrottled) {
      this.hasPendingRefresh = true
      return
    }
    this.isThrottled = true
    this.hasPendingRefresh = false
    this.executeRefresh()
    const throttleMs = this.config.markdownTheme.globalTheme.parseThrottleMs
    if (throttleMs > 0) {
      setTimeout(() => {
        this.isThrottled = false
        if (this.hasPendingRefresh) {
          this.refreshData()
        }
      }, throttleMs)
    } else {
      this.isThrottled = false
    }
  }

  /**
   * 执行实际解析与数据更新
   */
  private executeRefresh(): void {
    if (this.config.markdownTheme.globalTheme.isMarkdownParserSync) {
      this.refreshSyncData()
    } else {
      this.refreshAsyncData()
    }
  }

  /**
   * 异步触发解析数据
   * 流式输出时content高频变化，parseVersion/appliedVersion确保仅应用最新结果
   */
   refreshAsyncData(): void {
     this.parseVersion++ // 版本号递增
     const currentVersion = this.parseVersion
     let op: Options = this.plugin.buildOptions((): JsNodeImpl => this.jsNodePoolImpl.getJsNode())
     let markdownParser:MarkdownParser = new MarkdownParser(op)
     setTimeout(() => {
       markdownParser.parse(this.content).then((node) => {
         this.applyParseResult(node as JsNodeImpl, currentVersion)
       }).catch(() => {
         // 解析失败时静默处理，保留上一次成功的结果
       })
     }, 0)
   }

  /**
   * 同步解析数据（UI线程，isMarkdownParserSync=true时使用）
   */
   async refreshSyncData(): Promise<void> {
     this.parseVersion++ // 版本号递增
     const currentVersion = this.parseVersion
     let op: Options = this.plugin.buildOptions((): JsNodeImpl => this.jsNodePoolImpl.getJsNode())
     let markdownParser:MarkdownParser = new MarkdownParser(op)
     try {
       let node: JsNodeImpl = await markdownParser.parse(this.content) as JsNodeImpl
       this.applyParseResult(node, currentVersion)
     } catch (e) {
       // 解析失败时静默处理，保留上一次成功的结果
     }
   }

  /**
   * 应用解析结果到数据源（渐进式版本跟踪+增量转换+哈希计算+智能更新）
   */
   private applyParseResult(node: JsNodeImpl, currentVersion: number): void {
     // 渐进式版本跟踪：仅丢弃比已应用版本更旧的结果，保留比已应用版本更新的结果
     // 避免strictVersionTracking导致所有中间结果被丢弃、UI卡在旧状态
     if (currentVersion <= this.appliedVersion) {
       return
     }
     let nodeView: NodeView = new NodeView()
     try {
       nodeToNodeView(node, nodeView, nodeView, this.markdownDataSource.dataArray)
     } catch (e) {
       // nodeToNodeView失败时静默处理
       hilog.error(1,"1",`-----------e:${e}`)
     }
     if (nodeView.children.length == 0) {
       this.markdownDataSource.clear()
       this.appliedVersion = currentVersion
       return
     }
     this.markdownDataSource.smartUpdateDataArray(nodeView.children)
     this.config.markdownNodeViewString.setRoot(nodeView)
     this.appliedVersion = currentVersion
     this.jsNodePoolImpl.put(node)
   }

  /**
   * 异步处理图片占位图（可等待）
   */
  async loadPlaceholderImage(): Promise<void> {
    if (this.config.markdownTheme.imageTheme.imagePlaceholder !== undefined) {
      const hostContext = this.getUIContext().getHostContext()
      if (hostContext !== undefined) {
        const resourceMgr = hostContext.resourceManager
        const fileData = await resourceMgr.getMediaContent(this.config.markdownTheme.imageTheme.imagePlaceholder)
        const imageSource = image.createImageSource(fileData.buffer)
        this.placeholderPixelMap = await imageSource.createPixelMap()
      }
    }
  }

  /**
   * 图片点击回调
   */
  imageCallback: (url: string) => void = (url: string) => {
    this.config.imageCallback?.(url, this.imageAndVideoList)
  }

  /**
   * 视频点击回调
   */
  videoCallback: (url: string) => void = (url: string) => {
    this.config.videoCallback?.(url, this.imageAndVideoList)
  }

  /**
   * 脚注点击回调
   * 组件传入脚注ID（字符串），转换为数值索引后回调config
   */
  footnoteCallback: (id: string) => void = (id: string) => {
    const idx = Number(id)
    if (!isNaN(idx)) {
      this.config.footnoteCallback?.(idx)
    }
  }

  /**
   * TOC/标题ID点击回调
   */
  tocCallback: (index: number) => void = (index: number) => {
    this.config.tocIndexCallback?.(index)
  }
}
