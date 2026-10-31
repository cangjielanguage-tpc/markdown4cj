import { Options, MarkdownParser, JsNodeImpl } from "@cangjie-tpc/markdown_parser_hybrid"
import { MarkdownDataSource } from "../datasource/MarkdownDataSource"
import { MarkdownHeading } from "./MarkdownHeading"
import { MarkdownConfiguration } from '../configs/MarkdownConfiguration'
import { MarkdownPlugin } from '../plugin/MarkdownPlugin'
import { CustomViewRegistry } from '../plugin/CustomViewRegistry'
import { NodeView } from "../model/NodeView"
import { nodeToNodeView, liftCustomTagBlocks } from "../utils/MarkdownParserUtils"
import { safeString } from "../utils/MarkdownUtils"
import { MarkdownParagraph } from "./MarkdownParagraph"
import { MarkdownThematicBreak } from "./MarkdownThematicBreak"
import { image } from "@kit.ImageKit"
import { MarkdownAudio } from "./MarkdownAudio"
import { MarkdownVideo } from "./MarkdownVideo"
import { MarkdownBanner } from "./MarkdownBanner"
import { MarkdownCodeFenced } from "./MarkdownCodeFenced"
import { MarkdownCodeSeparate } from "./MarkdownCodeSeparate"
import { MarkdownCodeBlockList } from "./MarkdownCodeBlockList"
import { MarkdownCodeIndented } from "./MarkdownCodeIndented"
import { MarkdownFootnote } from "./MarkdownFootnote"
import { MarkdownDesc } from "./MarkdownDesc"
import { MarkdownTable } from "./MarkdownTable"
import { MarkdownList } from "./MarkdownList"
import { MarkdownQuote } from "./MarkdownQuote"
import { MarkdownLatexMathBlock } from "./MarkdownLatexMathBlock"
import { LatexParseQueue } from "../model/LatexParseQueue"
import { MarkdownScrollController } from "../controller/MarkdownScrollController"
import { StickyScrollYHolder } from "../model/StickyScrollYHolder"
import { ArrayList } from "@kit.ArkTS"
import { MarkdownVisibleRectHolder } from "../model/MarkdownVisibleRectHolder"

@Component
export struct CJMarkdown {
  @Prop @Watch('refreshData') content: string // 外部传入的Markdown文档
  @ObjectLink config: MarkdownConfiguration // markdown配置项
  @Provide placeholderPixelMap: PixelMap | undefined = undefined // 图片占位图
  @Provide isLatexMathEnabled: boolean = false // 数学公式插件是否启用（控制是否调用latexStringToImage）
  @Provide('mdStickyHolder') stickyHolder: StickyScrollYHolder = new StickyScrollYHolder() // 引用不变，不触发build()；通过setY+监听器通知MarkdownTable
  // CJMarkdown 根节点可见矩形持有者：根 List 经 onAreaChange（页面矩形逐帧推送）+
  // onVisibleAreaChange(缓存ratio，ratio变化时补喂) 喂给 holder.applyRect，推算可见区域 visTop/visBottom，
  // 下发给 MarkdownParagraph/MarkdownHeading/MarkdownTableCell 作链接曝光判定的「正交裁剪窗口」
  // （替代整屏高度，避免被标题栏/面板/系统栏遮挡区域误判可见）。
  // 布局事件是框架布局管线原生 dirty 机制，无 Inspector 全树查找，取代旧版轮询 getRectangleById。
  @Provide('mdVisibleRectHolder') visibleRectHolder: MarkdownVisibleRectHolder = new MarkdownVisibleRectHolder()
  private lastRatio: number = 0 // onVisibleAreaChange 最近一次 ratio（onAreaChange 喂 rect 时与 rect 一起传给 holder）
  @State componentWidth: number = 0.0 // markdown控件宽度
  scroller: Scroller = new Scroller() // list控制器
  scrollController?: MarkdownScrollController // 外层滚动控制器（不固定高度模式由页面传入）
  markdownDataSource: MarkdownDataSource = new MarkdownDataSource([]) // markdown页面数据源
  private parseVersion: number = 0 // 解析版本号，每次解析递增
  private appliedVersion: number = 0 // 已应用的版本号，用于渐进式更新（避免丢弃所有中间结果）
  private isThrottled: boolean = false // 解析节流标志
  private hasPendingRefresh: boolean = false // 节流期间有未处理的刷新请求
  imageAndVideoList: Array<string> = Array<string>() // 所有图片视频的url
  plugin: MarkdownPlugin = new MarkdownPlugin() // markdown插件配置
  private isAlive: boolean = true // 组件是否存活
  private throttleTimerId: number = -1 // 节流定时器ID
  private parseTimerId: number = -1 // 异步解析setTimeout定时器ID
  private exposureFallbackTimerId: number = -1 // 曝光兜底轮询setInterval定时器ID
  private indexFootnoteHashMap: Map<string, number> = new Map<string, number>() // 脚注ID→列表索引映射
  private indexTocHashMap: Map<number, number> = new Map<number, number>() // TOC标题索引→列表索引映射

  @Builder
  CustomBlockImageBuilder(description: String, destination: String, title: String) { /* cjlint-ignore !G.FUN.02 */
    Text("")
  }

  @Builder
  CustomBlockLinkBuilder(description: String, destination: String, title: String) { /* cjlint-ignore !G.FUN.02 */
    Text("")
  }

  @BuilderParam blockImageCardComponent: (desc:string, imageSrc:string, title:string) => void = this.CustomBlockImageBuilder  //自定义卡片布局块级图片
  @BuilderParam blockLinkCardComponent: (desc:string, link:string, title:string) => void = this.CustomBlockLinkBuilder  //自定义卡片布局行内链接

  @Builder
  CustomTagViewBuilder(tag: string, attrs: Record<string, string>, content: string) { /* cjlint-ignore !G.FUN.02 */
    Text("")
  }

  @BuilderParam customTagViewComponent: (tag:string, attrs:Record<string,string>, content:string) => void = this.CustomTagViewBuilder  //自定义标签块级视图（如 <sdui data='...'></sdui>）
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
   * 通过footnoteID查找脚注定义块的列表索引，滚动到该位置
   */
  footnoteCallback: (id: string) => void = (id: string) => {
    const idx = this.indexFootnoteHashMap.get(id)
    if (idx !== undefined) {
      this.scroller.scrollToIndex(idx, true)
      this.config.footnoteCallback?.(idx)
    }
  }
  /**
   * TOC/标题ID点击回调
   * 通过headLinkIndex验证目标标题位置，滚动到该位置
   */
  tocCallback: (index: number) => void = (index: number) => {
    const idx = this.indexTocHashMap.get(index)
    if (idx !== undefined) {
      this.scroller.scrollToIndex(idx, true)
      this.config.tocIndexCallback?.(idx)
    }
  }

  // 是否启用元素曝光统计：仅当 config.elementExposureCallback 已设置时为 true。
  // 整条曝光链路（CJMarkdown 的布局事件喂数 + holder，以及 MarkdownParagraph/MarkdownHeading/
  // MarkdownTableCell 的 computeLinkRanges/getRectsForRange/监听器）都以此为开关，未设回调时全部短路不执行。
  // 用方法而非 getter：@Component struct 内 `private get exposureEnabled` 在运行时返回 undefined
  //（实测 cbDefined=true 但运行时 disabled），导致门控永久判 false、整条链路死。
  private isExposureEnabled(): boolean {
    return this.config?.elementExposureCallback !== undefined
  }

  /**
   * 根 List 布局事件喂 holder（替代旧版轮询 getRectangleById）：
   * - onAreaChange：页面矩形变化（外层滚动/自身尺寸变化）时框架逐帧推送，是 rectTop 采样的主来源；
   * - onVisibleAreaChange：ratio 变化时补喂一次（feedHolderWithRatio），兜住「ratio 回升/离屏但无新布局事件」的窗口。
   * 回调体只做算术喂入，holder 对相同输入是确定性的（changed=false 不通知监听者）。
   */
  private feedHolderFromArea(area: Area): void {
    if (!this.isAlive || !this.isExposureEnabled()) {
      return
    }
    // 页面坐标系（globalPosition）：Area 无 windowOffset（那是 componentUtils.Rectangle 的字段）。
    // holder 矩形与块级快照同源（都是 globalPosition），链路内全是同系差值，坐标系自洽。
    const gp: Position = area.globalPosition
    if (!gp || typeof area.height !== 'number' || typeof gp.y !== 'number') {
      return
    }
    const y: number = gp.y as number
    const h: number = area.height as number
    const topPx: number = vp2px(y)
    this.visibleRectHolder.applyRect(topPx, topPx + vp2px(h), this.lastRatio)
  }

  /**
   * ratio 变化时用 holder 缓存的矩形补喂一次：
   * - 回屏（ratio 从 ≤0 回升）：走 holder 的重新初始化分支，否则 vis 卡在 0；
   * - 离屏（ratio==0）：走 ratioDown 收缩分支，visHeight 归零（屏外语义）。
   * holder.ready=false（rect 尚未从 onAreaChange 喂入过）时跳过，避免用初始 0 值污染 holder。
   */
  private feedHolderWithRatio(ratio: number): void {
    if (!this.isAlive || !this.isExposureEnabled()) {
      return
    }
    if (!this.visibleRectHolder.ready) {
      return
    }
    this.visibleRectHolder.applyRect(this.visibleRectHolder.rectTop, this.visibleRectHolder.rectBottom, ratio)
  }

  aboutToAppear(): void {
    this.isLatexMathEnabled = this.plugin.isLatexMathPlugin
    if (this.scrollController) {
      this.stickyHolder.enabled = true
      this.scrollController.setListener((yOffset: number) => {
        this.stickyHolder.setY(yOffset)
      })
    }
    this.refreshData() // 首次加载
    this.loadPlaceholderImage() // 占位图处理
    // 曝光兜底轮询：holder 广播仅由根 List 布局事件驱动，覆盖不到的位移场景
    // （固定高度模式根 List 内滚、订阅者边界回填滞后等非框架推送位移）由低频轮询兜底，
    // 每 100ms 无条件 forceNotify 一次（notify 内部有视口外过滤，未启用曝光时直接短路）。
    // 无条件启动：aboutToAppear 时刻曝光配置可能尚未同步（refreshData 异步首跑，
    // 此刻 elementExposureCallback 可能是 undefined），此处门控会永久错过启动时机；
    // 改由回调内每次 isExposureEnabled 门控——未启用时每 100ms 仅一次布尔判断，零回调税。
    this.exposureFallbackTimerId = setInterval(() => {
      if (!this.isAlive || !this.isExposureEnabled()) {
        return
      }
      this.visibleRectHolder.forceNotify()
    }, 100)
  }

  aboutToDisappear(): void {
    this.isAlive = false
    if (this.exposureFallbackTimerId !== -1) {
      clearInterval(this.exposureFallbackTimerId)
      this.exposureFallbackTimerId = -1
    }
    if (this.scrollController) {
      this.scrollController.setListener(null)
    }
    if (this.throttleTimerId !== -1) {
      clearTimeout(this.throttleTimerId)
      this.throttleTimerId = -1
    }
    if (this.parseTimerId !== -1) {
      clearTimeout(this.parseTimerId)
      this.parseTimerId = -1
    }
    if (this.placeholderPixelMap !== undefined) {
      try {
        this.placeholderPixelMap.release()
      } catch (e) {
        console.error('placeholderPixelMap release failed: ' + (e instanceof Error ? e.stack : String(e)))
      }
      this.placeholderPixelMap = undefined
    }
    this.releaseDataSourcePixelMaps()
    LatexParseQueue.dispose()
    this.imageAndVideoList = []
  }

  /**
   * 释放数据源中所有NodeView的PixelMap资源
   */
  private releaseDataSourcePixelMaps(): void {
    const arr = this.markdownDataSource.getAllData()
    for (let i = 0; i < arr.length; i++) {
      arr[i].releaseOwnPixelMaps()
      arr[i].releaseChildrenPixelMaps()
    }
    this.markdownDataSource.clear()
  }

  build() {
    if (this.config.markdownTheme.codeBlockTheme.codeBlockIsSeparate) {
      List({
        scroller: this.scroller,
        space: this.config.markdownTheme.globalTheme.markdownBlockSpacing
      }) {
        LazyForEach(
          this.markdownDataSource,
          (item: NodeView, index: number) => {
            ListItem() {
              if (index === 0 && (item.nodeType === "FencedCodeBlock" || item.nodeType === "IndentedCodeBlock")) {
                MarkdownCodeSeparate({
                  node: item,
                  codeBlockTheme: this.config.markdownTheme.codeBlockTheme,
                  codeCopyCallback: this.config.codeCopyCallback,
                  codeFullScreenCallback: this.config.codeFullScreenCallback
                })
              } else {
                Text("")
              }
            }
          },
          (item: NodeView, index: number) => {
            return `${index}-${item.nodeHash}`
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
      .onVisibleAreaChange([0.0, 0.01, 0.1, 0.25, 0.5, 0.75, 1.0], (_isVisible: boolean, currentRatio: number) => {
        if (!this.isExposureEnabled()) {
          return
        }
        // 缓存 ratio 供 onAreaChange 喂 rect 时一起传给 holder；并用缓存矩形补喂一次：
        // - 回屏（ratio>0）：走 holder 重新初始化分支，否则 vis 卡在 0；
        // - 离屏（ratio==0）：走 ratioDown 收缩分支，visHeight 归零。
        this.lastRatio = currentRatio
        this.feedHolderWithRatio(currentRatio)
      })
      .onAreaChange((_oldArea: Area, newArea: Area) => {
        // 页面矩形逐帧推送（外层滚动/尺寸变化），曝光 rectTop 采样的主来源。
        this.feedHolderFromArea(newArea)
      })
      .onSizeChange((oldValue, newValue) => {
        let newWidth: number = 0
        if (typeof newValue.width === 'number') {
          newWidth = newValue.width
        }
        if (this.componentWidth !== newWidth) {
          this.componentWidth = newWidth
        }
      })
    } else {
      List({
        scroller: this.scroller,
        space: this.config.markdownTheme.globalTheme.markdownBlockSpacing
      }) {
        LazyForEach(
          this.markdownDataSource,
          (item: NodeView, index: number) => {
            if (item.nodeType === "TableBlock" && this.config.markdownTheme.tableTheme.tableStickyHeader) {
              // sticky 模式：表格以 ListItemGroup 形式直接作为 List 子节点，标题行天然吸顶
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
                elementExposureCallback: this.config.elementExposureCallback,
                exposureThreshold: this.config.exposureThreshold,
                imageCallback: this.imageCallback,
                imageDownloadCallback: this.config.imageDownloadCallback,
                imageReplaceCallback: this.config.imageReplaceCallback,
                markdownHighlightParagraph: this.config.markdownHighlightParagraph,
                customLongPressCallback: this.config.customLongPressCallback,
                blockImageCardComponent:this.blockImageCardComponent,
                blockLinkCardComponent:this.blockLinkCardComponent
              })
            } else {
              ListItem() {
                if (item.nodeType === "Heading" || item.nodeType === "IdHeading") {
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
                    imageCallback: this.imageCallback,
                    imageDownloadCallback: this.config.imageDownloadCallback,
                    imageReplaceCallback: this.config.imageReplaceCallback,
                    markdownHighlightParagraph: this.config.markdownHighlightParagraph,
                    customLongPressCallback: this.config.customLongPressCallback,
                    elementExposureCallback: this.config.elementExposureCallback,
                    exposureThreshold: this.config.exposureThreshold,
                    paragraphHeadingAnimationStart: this.config.paragraphHeadingAnimationStart,
                    paragraphHeadingAnimationEnd: this.config.paragraphHeadingAnimationEnd
                  })
                } else if (item.nodeType === "Paragraph") {
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
                    elementExposureCallback: this.config.elementExposureCallback,
                    exposureThreshold: this.config.exposureThreshold,
                    imageCallback: this.imageCallback,
                    imageDownloadCallback: this.config.imageDownloadCallback,
                    imageReplaceCallback: this.config.imageReplaceCallback,
                    markdownHighlightParagraph: this.config.markdownHighlightParagraph,
                    customLongPressCallback: this.config.customLongPressCallback,
                    paragraphHeadingAnimationStart: this.config.paragraphHeadingAnimationStart,
                    paragraphHeadingAnimationEnd: this.config.paragraphHeadingAnimationEnd,
                  })
                } else if (item.nodeType === "FencedCodeBlockListBlock") {
                  // 围栏代码块列表
                  MarkdownCodeBlockList({
                    node: item,
                    codeBlockTheme: this.config.markdownTheme.codeBlockTheme,
                    codeCopyCallback: this.config.codeCopyCallback,
                    codeFullScreenCallback: this.config.codeFullScreenCallback
                  })
                } else if (item.nodeType === "FencedCodeBlock") {
                  // 围栏代码块
                  MarkdownCodeFenced({
                    node: item,
                    codeBlockTheme: this.config.markdownTheme.codeBlockTheme,
                    codeCopyCallback: this.config.codeCopyCallback,
                    codeFullScreenCallback: this.config.codeFullScreenCallback
                  })
                } else if (item.nodeType === "IndentedCodeBlock") {
                  // 缩进代码块
                  MarkdownCodeIndented({
                    node: item,
                    codeBlockTheme: this.config.markdownTheme.codeBlockTheme,
                    codeCopyCallback: this.config.codeCopyCallback,
                    codeFullScreenCallback: this.config.codeFullScreenCallback
                  })
                } else if (item.nodeType === "BulletList") {
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
                    imageDownloadCallback: this.config.imageDownloadCallback,
                    imageReplaceCallback: this.config.imageReplaceCallback,
                    videoCallback: this.videoCallback,
                    videoImageCallback: this.config.videoImageCallback,
                    videoReleaseCallback: this.config.videoReleaseCallback,
                    videoDownloadCallback: this.config.videoDownloadCallback,
                    audioCallback: this.config.audioCallback,
                    codeCopyCallback: this.config.codeCopyCallback,
                    codeFullScreenCallback: this.config.codeFullScreenCallback,
                    linkCallback: this.config.linkCallback,
                    elementExposureCallback: this.config.elementExposureCallback,
                    exposureThreshold: this.config.exposureThreshold,
                    textCopyCallback: this.config.textCopyCallback,
                    footnoteCallback: this.footnoteCallback,
                    tocCallback: this.tocCallback,
                    tableCopyCallback: this.config.tableCopyCallback,
                    markdownHighlightParagraph: this.config.markdownHighlightParagraph,
                    customLongPressCallback: this.config.customLongPressCallback,
                    paragraphHeadingAnimationStart: this.config.paragraphHeadingAnimationStart,
                    paragraphHeadingAnimationEnd: this.config.paragraphHeadingAnimationEnd,
                    blockImageCardComponent:this.blockImageCardComponent,
                    blockLinkCardComponent:this.blockLinkCardComponent,
                    customTagViewComponent: this.customTagViewComponent
                  })
                } else if (item.nodeType === "OrderedList") {
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
                    imageDownloadCallback: this.config.imageDownloadCallback,
                    imageReplaceCallback: this.config.imageReplaceCallback,
                    videoCallback: this.videoCallback,
                    videoImageCallback: this.config.videoImageCallback,
                    videoReleaseCallback: this.config.videoReleaseCallback,
                    videoDownloadCallback: this.config.videoDownloadCallback,
                    audioCallback: this.config.audioCallback,
                    codeCopyCallback: this.config.codeCopyCallback,
                    codeFullScreenCallback: this.config.codeFullScreenCallback,
                    linkCallback: this.config.linkCallback,
                    elementExposureCallback: this.config.elementExposureCallback,
                    exposureThreshold: this.config.exposureThreshold,
                    textCopyCallback: this.config.textCopyCallback,
                    footnoteCallback: this.footnoteCallback,
                    tocCallback: this.tocCallback,
                    tableCopyCallback: this.config.tableCopyCallback,
                    markdownHighlightParagraph: this.config.markdownHighlightParagraph,
                    customLongPressCallback: this.config.customLongPressCallback,
                    paragraphHeadingAnimationStart: this.config.paragraphHeadingAnimationStart,
                    paragraphHeadingAnimationEnd: this.config.paragraphHeadingAnimationEnd,
                    blockImageCardComponent:this.blockImageCardComponent,
                    blockLinkCardComponent:this.blockLinkCardComponent,
                    customTagViewComponent: this.customTagViewComponent
                  })
                } else if (item.nodeType === "BlockQuote") {
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
                    imageDownloadCallback: this.config.imageDownloadCallback,
                    imageReplaceCallback: this.config.imageReplaceCallback,
                    videoCallback: this.videoCallback,
                    videoImageCallback: this.config.videoImageCallback,
                    videoReleaseCallback: this.config.videoReleaseCallback,
                    videoDownloadCallback: this.config.videoDownloadCallback,
                    audioCallback: this.config.audioCallback,
                    codeCopyCallback: this.config.codeCopyCallback,
                    codeFullScreenCallback: this.config.codeFullScreenCallback,
                    linkCallback: this.config.linkCallback,
                    elementExposureCallback: this.config.elementExposureCallback,
                    exposureThreshold: this.config.exposureThreshold,
                    textCopyCallback: this.config.textCopyCallback,
                    footnoteCallback: this.footnoteCallback,
                    tocCallback: this.tocCallback,
                    tableCopyCallback: this.config.tableCopyCallback,
                    markdownHighlightParagraph: this.config.markdownHighlightParagraph,
                    customLongPressCallback: this.config.customLongPressCallback,
                    paragraphHeadingAnimationStart: this.config.paragraphHeadingAnimationStart,
                    paragraphHeadingAnimationEnd: this.config.paragraphHeadingAnimationEnd,
                    blockImageCardComponent:this.blockImageCardComponent,
                    blockLinkCardComponent:this.blockLinkCardComponent,
                    customTagViewComponent: this.customTagViewComponent
                  })
                } else if (item.nodeType === "LatexMathBlock") {
                  // 数学公式块：isLatexMathBlockClose为true时才渲染图片，否则显示纯文本
                  if (this.isLatexMathEnabled && item.isLatexMathBlockClose) {
                    MarkdownLatexMathBlock({
                      latexMathBlockStr: item.nodeText,
                      latexMathTheme: this.config.markdownTheme.latexMathTheme,
                      latexImageCallback: this.config.latexImageCallback,
                      latexStrCallback: this.config.latexStrCallback
                    })
                  } else if (this.config.markdownTheme.latexMathTheme.latexMathDefaultText) {
                    Text(item.nodeText)
                      .fontFamily(this.config.markdownTheme.latexMathTheme.latexMathDefaultTextFontFamily)
                      .fontSize(this.config.markdownTheme.latexMathTheme.latexMathDefaultTextFontSize)
                      .fontWeight(this.config.markdownTheme.latexMathTheme.latexMathDefaultTextFontWeight)
                      .fontStyle(this.config.markdownTheme.latexMathTheme.latexMathDefaultTextFontStyle)
                      .fontColor(this.config.markdownTheme.latexMathTheme.latexMathDefaultTextFontColor)
                      .padding({
                        top: this.config.markdownTheme.latexMathTheme.latexMathPaddingTop,
                        right: this.config.markdownTheme.latexMathTheme.latexMathPaddingRight,
                        bottom: this.config.markdownTheme.latexMathTheme.latexMathPaddingBottom,
                        left: this.config.markdownTheme.latexMathTheme.latexMathPaddingLeft
                      })
                      .margin({
                        top: this.config.markdownTheme.latexMathTheme.latexMathMarginTop,
                        right: this.config.markdownTheme.latexMathTheme.latexMathMarginRight,
                        bottom: this.config.markdownTheme.latexMathTheme.latexMathMarginBottom,
                        left: this.config.markdownTheme.latexMathTheme.latexMathMarginLeft
                      })
                  }
                } else if (item.nodeType === "TableBlock") {
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
                    elementExposureCallback: this.config.elementExposureCallback,
                    exposureThreshold: this.config.exposureThreshold,
                    imageCallback: this.imageCallback,
                    imageDownloadCallback: this.config.imageDownloadCallback,
                    imageReplaceCallback: this.config.imageReplaceCallback,
                    tableCopyCallback: this.config.tableCopyCallback,
                    markdownHighlightParagraph: this.config.markdownHighlightParagraph,
                    customLongPressCallback: this.config.customLongPressCallback,
                    blockImageCardComponent:this.blockImageCardComponent,
                    blockLinkCardComponent:this.blockLinkCardComponent
                  })
                } else if (item.nodeType === "ThematicBreak") {
                  // 分割线
                  MarkdownThematicBreak({
                    dividerTheme: this.config.markdownTheme.dividerTheme
                  })
                } else if (item.nodeType === "FootnoteBlock") {
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
                    orderedListTheme: this.config.markdownTheme.orderedListTheme,
                    bulletListTheme: this.config.markdownTheme.bulletListTheme,
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
                    textCopyCallback: this.config.textCopyCallback,
                    footnoteCallback: this.footnoteCallback,
                    tocCallback: this.tocCallback,
                    linkCallback: this.config.linkCallback,
                    elementExposureCallback: this.config.elementExposureCallback,
                    exposureThreshold: this.config.exposureThreshold,
                    imageCallback: this.imageCallback,
                    imageDownloadCallback: this.config.imageDownloadCallback,
                    imageReplaceCallback: this.config.imageReplaceCallback,
                    videoCallback: this.videoCallback,
                    videoImageCallback: this.config.videoImageCallback,
                    videoReleaseCallback: this.config.videoReleaseCallback,
                    videoDownloadCallback: this.config.videoDownloadCallback,
                    audioCallback: this.config.audioCallback,
                    codeCopyCallback: this.config.codeCopyCallback,
                    codeFullScreenCallback: this.config.codeFullScreenCallback,
                    markdownHighlightParagraph: this.config.markdownHighlightParagraph,
                    customLongPressCallback: this.config.customLongPressCallback,
                    paragraphHeadingAnimationStart: this.config.paragraphHeadingAnimationStart,
                    paragraphHeadingAnimationEnd: this.config.paragraphHeadingAnimationEnd,
                  })
                } else if (item.nodeType === "DescList") {
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
                    elementExposureCallback: this.config.elementExposureCallback,
                    exposureThreshold: this.config.exposureThreshold,
                    imageCallback: this.imageCallback,
                    imageDownloadCallback: this.config.imageDownloadCallback,
                    imageReplaceCallback: this.config.imageReplaceCallback,
                    markdownHighlightParagraph: this.config.markdownHighlightParagraph,
                    customLongPressCallback: this.config.customLongPressCallback,
                    paragraphHeadingAnimationStart: this.config.paragraphHeadingAnimationStart,
                    paragraphHeadingAnimationEnd: this.config.paragraphHeadingAnimationEnd,
                  })
                } else if (item.nodeType === "SlideBlock") {
                  // 图片幻灯片
                  MarkdownBanner({
                    node: item,
                    bannerTheme: this.config.markdownTheme.bannerTheme,
                    imageTheme: this.config.markdownTheme.imageTheme,
                    imageCallback: this.imageCallback
                  })
                } else if (item.nodeType === "BlockVideo") {
                  // 视频
                  MarkdownVideo({
                    node: item,
                    videoTheme: this.config.markdownTheme.videoTheme,
                    videoCallback: this.videoCallback,
                    videoImageCallback: this.config.videoImageCallback,
                    videoReleaseCallback: this.config.videoReleaseCallback,
                    videoDownloadCallback: this.config.videoDownloadCallback
                  })
                } else if (item.nodeType === "BlockAudio") {
                  // 音频
                  MarkdownAudio({
                    node: item,
                    audioTheme: this.config.markdownTheme.audioTheme,
                    audioCallback: this.config.audioCallback
                  })
                } else if (item.nodeType === "CustomCardImage") {
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
                  // 已注册的自定义标签块级视图（如 <sdui data='...'></sdui>），回调宿主Builder渲染
                  // 来源可能是块级 HtmlBlock，也可能是提升后的行内 HtmlInline（nodeType 不限定）
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
            }
          },
          (item: NodeView, index: number) => {
            if (item.nodeType === "LatexMathBlock") {
              return `${index}-${item.nodeHash}-${item.contentHash}`
            }
            if (item.nodeType === "TableBlock") {
              return `${index}-${item.nodeHash}-${this.config.markdownTheme.tableTheme.tableStickyHeader}`
            }
            return `${index}-${item.nodeHash}`
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
      .sticky(StickyStyle.Header)
      .onVisibleAreaChange([0.0, 0.01, 0.1, 0.25, 0.5, 0.75, 1.0], (_isVisible: boolean, currentRatio: number) => {
        if (!this.isExposureEnabled()) {
          return
        }
        // 缓存 ratio 供 onAreaChange 喂 rect 时一起传给 holder；并用缓存矩形补喂一次：
        // - 回屏（ratio>0）：走 holder 重新初始化分支，否则 vis 卡在 0；
        // - 离屏（ratio==0）：走 ratioDown 收缩分支，visHeight 归零。
        this.lastRatio = currentRatio
        this.feedHolderWithRatio(currentRatio)
      })
      .onAreaChange((_oldArea: Area, newArea: Area) => {
        // 页面矩形逐帧推送（外层滚动/尺寸变化），曝光 rectTop 采样的主来源。
        this.feedHolderFromArea(newArea)
      })
      .onSizeChange((oldValue, newValue) => {
        let newWidth: number = 0
        if (typeof newValue.width === 'number') {
          newWidth = newValue.width
        }
        if (this.componentWidth !== newWidth) {
          this.componentWidth = newWidth
        }
      })
    }
  }

  /**
   * 刷新数据
   * enableParseThrottle为true时，通过leading-edge节流控制解析频率
   * enableParseThrottle为false时，直接触发解析，由调用方自行控制节流
   */
  refreshData() {
    if (!this.config.markdownTheme.globalTheme.enableParseThrottle) {
      this.executeRefresh()
      return
    }
    if (this.isThrottled) {
      this.hasPendingRefresh = true
      return
    }
    this.isThrottled = true
    this.hasPendingRefresh = false
    this.executeRefresh()
    const throttleMs = this.config.markdownTheme.globalTheme.parseThrottleMs
    if (throttleMs > 0) {
      this.throttleTimerId = setTimeout(() => {
        this.throttleTimerId = -1
        if (!this.isAlive) {
          return
        }
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
   * Options/MarkdownParser延迟到setTimeout回调内创建：被后续刷新取消（clearTimeout）的
   * 请求不再白白分配Options（含JsNodeTreeBuilder）与Parser对象，降低流式场景GC压力
   */
  refreshAsyncData(): void {
    this.parseVersion++ // 版本号递增
    const currentVersion = this.parseVersion
    if (this.parseTimerId !== -1) {
      clearTimeout(this.parseTimerId)
    }
    this.parseTimerId = setTimeout(() => {
      this.parseTimerId = -1
      if (!this.isAlive) {
        return
      }
      try {
        let op: Options = this.plugin.buildOptions()
        let markdownParser: MarkdownParser = new MarkdownParser(op)
        markdownParser.parse(CustomViewRegistry.preprocessCustomTags(this.content)).then((node) => {
          if (!this.isAlive) {
            return
          }
          this.applyParseResult(node as JsNodeImpl, currentVersion)
        }).catch((e: Error) => {
          console.error('refreshAsyncData parse failed, keeping last result: ' + (e instanceof Error ? e.stack : String(e)))
        })
      } catch (e) {
        console.error('refreshAsyncData sync parse exception: ' + (e instanceof Error ? e.stack : String(e)))
      }
    }, 0)
  }

  /**
   * 同步解析数据（UI线程，isMarkdownParserSync=true时使用）
   */
  async refreshSyncData(): Promise<void> {
    this.parseVersion++ // 版本号递增
    const currentVersion = this.parseVersion
    let op: Options = this.plugin.buildOptions()
    let markdownParser: MarkdownParser = new MarkdownParser(op)
    try {
      let node: JsNodeImpl = await markdownParser.parse(CustomViewRegistry.preprocessCustomTags(this.content)) as JsNodeImpl
      if (!this.isAlive) {
        return
      }
      this.applyParseResult(node, currentVersion)
    } catch (e) {
      console.error('refreshSyncData parse failed, keeping last result: ' + (e instanceof Error ? e.stack : String(e)))
    }
  }

  /**
   * 应用解析结果到数据源（渐进式版本跟踪+增量转换+哈希计算+智能更新）
   *
   * @param node 节点
   * @param currentVersion 当前版本
   */
  private applyParseResult(node: JsNodeImpl, currentVersion: number): void {
    if (!this.isAlive || currentVersion <= this.appliedVersion) {
      return
    }
    let nodeView: NodeView = new NodeView()
    let highlightSelectedList: ArrayList<string> = new ArrayList<string>()
    nodeView.isLinkStyle = this.config.markdownTheme.linkTheme.linkIsIcon
    let parseOk: boolean = false
    try {
      nodeToNodeView(node, nodeView, nodeView, this.markdownDataSource.dataArray, highlightSelectedList)
      liftCustomTagBlocks(nodeView) // 行内自定义标签（如段落中的 <sdui>）提升为块级
      parseOk = true
    } catch (e) {
      console.error('nodeToNodeView failed: ' + (e instanceof Error ? e.stack : String(e)))
    }
    this.collectImageAndVideoUrls(node)
    if (!parseOk) {
      // 解析失败时不更新数据源，保留上一次成功的结果
      this.appliedVersion = currentVersion
      return
    }
    if (nodeView.children.length === 0) {
      this.markdownDataSource.clear()
      this.buildIndexMaps()
      this.config.markdownNodeViewString.setRoot(nodeView, this.config.markdownTheme.codeBlockTheme.codeBlockIsSeparate)
      this.appliedVersion = currentVersion
      return
    }
    this.markdownDataSource.smartUpdateDataArray(nodeView.children)
    this.buildIndexMaps()
    this.config.markdownHighlightParagraph.setAllParagraphItems(highlightSelectedList)
    this.config.markdownNodeViewString.setRoot(nodeView, this.config.markdownTheme.codeBlockTheme.codeBlockIsSeparate)
    this.appliedVersion = currentVersion
  }

  /**
   * 构建脚注ID和TOC标题索引的哈希映射表
   * 遍历数据源，记录FootnoteBlock的footnoteID→列表索引，Heading/IdHeading的列表索引→列表索引
   */
  private buildIndexMaps(): void {
    this.indexFootnoteHashMap.clear()
    this.indexTocHashMap.clear()
    const arr = this.markdownDataSource.getAllData()
    for (let i = 0; i < arr.length; i++) {
      const item = arr[i]
      if (item.nodeType === "Heading" || item.nodeType === "IdHeading") {
        this.indexTocHashMap.set(i, i)
      } else if (item.nodeType === "FootnoteBlock") {
        this.indexFootnoteHashMap.set(item.footnoteID ?? "", i)
      }
    }
  }

  /**
   * 从解析器props中收集所有图片和视频URL到imageAndVideoList
   *
   * links 格式为 JSON 数组字符串（如 ["url1","url2"]），优先用 JSON.parse 解析，
   * 正确处理 URL 内含逗号/引号等特殊字符。JSON.parse 失败时降级到手动分割。
   *
   * @param node 解析后的根节点
   */
  private collectImageAndVideoUrls(node: JsNodeImpl): void {
    this.imageAndVideoList = []
    const prop = node.getProps()
    if (prop !== undefined) {
      const links = prop.get("links")
      if (links !== undefined && links.length > 0) {
        // 优先 JSON.parse：正确处理 URL 内含逗号/引号等特殊字符
        try {
          const parsed: Object = JSON.parse(links)
          if (Array.isArray(parsed)) {
            const arr: Object[] = parsed as Object[]
            const result: string[] = []
            for (let i = 0; i < arr.length; i++) {
              const item: Object = arr[i]
              if (typeof item === 'string') {
                const s: string = item as string
                if (s.length > 0) {
                  result.push(s)
                }
              }
            }
            this.imageAndVideoList = result
            return
          }
        } catch (_e) {
          // 非合法 JSON，降级到手动分割
        }
        // 降级：处理非 JSON 格式的逗号分隔字符串
        let str = links
        if (str.startsWith('[') && str.endsWith(']')) {
          str = str.substring(1, str.length - 1)
        }
        this.imageAndVideoList = str.split(',')
          .map((s: string) => s.trim())
          .filter((s: string) => s.length > 0)
          .map((s: string) => {
            if (s.startsWith('"') && s.endsWith('"')) {
              return s.substring(1, s.length - 1)
            }
            if (s.startsWith("'") && s.endsWith("'")) {
              return s.substring(1, s.length - 1)
            }
            return s
          })
      }
    }
  }

  /**
   * 异步处理图片占位图（可等待）
   */
  async loadPlaceholderImage(): Promise<void> {
    if (this.config.markdownTheme.imageTheme.imagePlaceholder !== undefined) {
      let imageSource: image.ImageSource | undefined = undefined
      try {
        const hostContext = this.getUIContext().getHostContext()
        if (hostContext !== undefined) {
          const resourceMgr = hostContext.resourceManager
          const fileData = await resourceMgr.getMediaContent(this.config.markdownTheme.imageTheme.imagePlaceholder)
          if (!this.isAlive) {
            return
          }
          imageSource = image.createImageSource(fileData.buffer)
          const pm = await imageSource.createPixelMap()
          if (!this.isAlive) {
            try {
              pm.release()
            } catch (e) {
              console.error('pm release failed: ' + (e instanceof Error ? e.stack : String(e)))
            }
            return
          }
          this.placeholderPixelMap = pm
        }
      } catch (e) {
        console.error('loadPlaceholderImage failed: ' + (e instanceof Error ? e.stack : String(e)))
      } finally {
        if (imageSource !== undefined) {
          try {
            imageSource.release()
          } catch (e) {
            console.error('imageSource release failed: ' + (e instanceof Error ? e.stack : String(e)))
          }
        }
      }
    }
  }
}
