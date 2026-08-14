import { MarkdownDataSource } from "../datasource/MarkdownDataSource"
import { CellWidthTracker } from "../model/CellWidthTracker"
import { NodeView } from "../model/NodeView"
import { MarkdownExposureEvent } from "../model/MarkdownExposureEvent"
import { TableHorizontalScrollSync } from "../model/TableHorizontalScrollSync"
import { StickyScrollYHolder, StickyOffsetHolder } from "../model/StickyScrollYHolder"
import { GlobalTheme } from "../theme/GlobalTheme"
import { HeadingTheme } from "../theme/HeadingTheme"
import { BlockQuoteTheme } from "../theme/BlockQuoteTheme"
import { BoldTheme } from "../theme/BoldTheme"
import { DefinitionListTheme } from "../theme/DefinitionListTheme"
import { FootnoteRefTheme } from "../theme/FootnoteRefTheme"
import { HighlightTheme } from "../theme/HighlightTheme"
import { HtmlUnderlineTheme } from "../theme/HtmlUnderlineTheme"
import { ImageTheme } from "../theme/ImageTheme"
import { InlineCodeTheme } from "../theme/InlineCodeTheme"
import { ItalicTheme } from "../theme/ItalicTheme"
import { LatexMathTheme } from "../theme/LatexMathTheme"
import { LinkTheme } from "../theme/LinkTheme"
import { ParagraphTheme } from "../theme/ParagraphTheme"
import { StrikethroughTheme } from "../theme/StrikethroughTheme"
import { SubTheme } from "../theme/SubTheme"
import { SupTheme } from "../theme/SupTheme"
import { TableTheme } from "../theme/TableTheme"
import { MarkdownTableRow } from "./MarkdownTableRow"
import { MarkDownTableTitle } from "./MarkdownTableTitle"
import { MarkdownHighlightParagraph } from "../configs/MarkdownHighlightParagraph"

/**
 * 表格控件
 */
@Component
export struct MarkdownTable {
  @ObjectLink @Watch('refreshData') node: NodeView // 表格自身节点数据
  @ObjectLink definitionListTheme: DefinitionListTheme // 定义列表样式
  @ObjectLink headingTheme: HeadingTheme // 标题样式
  @ObjectLink globalTheme: GlobalTheme // 整体样式
  @ObjectLink blockQuoteTheme: BlockQuoteTheme // 块引用样式
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
  @ObjectLink imageTheme: ImageTheme // 图片样式
  @ObjectLink markdownHighlightParagraph: MarkdownHighlightParagraph // 段落高亮配置
  @Prop @Watch('onComponentWidthChanged') componentWidth: number = 0.0 // 父布局控件宽度
  textCopyCallback?: (text: string) => void // 文本复制的点击事件
  footnoteCallback?: (index: string) => void // 脚注点击事件
  tocCallback?: (index: number) => void // TOC/标题ID点击事件
  linkCallback?: (url: string) => void // 链接点击事件
  imageCallback?: (url: string) => void // 图片点击事件
  tableCopyCallback?: (str: string) => void // 复制点击事件
  imageDownloadCallback?: (url: string) => void // 图片下载事件
  imageReplaceCallback?: (url: string) => Promise<ArrayBuffer | undefined> // 图片替换回调
  latexImageCallback?: (data: ArrayBuffer, height: number, width: number) => void // 数学公式图片点击事件
  latexStrCallback: (str: string) => string = (str: string) => str // 数学公式数据处理事件
  customLongPressCallback?: () => void = undefined // 自定义长按事件
  elementExposureCallback?: (event: MarkdownExposureEvent) => void // 元素曝光回调（透传给TableRow→TableCell）
  exposureThreshold: number = 0.5 // 曝光阈值（透传给TableRow→TableCell）
  scroller: Scroller = new Scroller() // list控制器（非sticky模式使用）
  markdownDataSource: MarkdownDataSource = new MarkdownDataSource([]) // markdown数据源（非sticky模式：全部行；sticky模式：body行）
  @State tableBlockCellSize: number = 0 // 表格总共有几列
  @Provide cellWidthTracker: CellWidthTracker = new CellWidthTracker(0) // 列宽跟踪器（非@Observed，onSizeChange只写不触发重渲染）
  @Provide('tableColumnWidths') columnWidths: number[] = [] // 列宽快照（@Provide让TableCell通过@Consume直接读取，避免LazyForEach不刷新@Prop的问题）
  @Provide tableContainerId: string = '' // 表格横向body Scroll容器id（TableCell曝光水平可见性判定用）
  private isAlive: boolean = true // 组件是否存活
  // ===== sticky 模式专用 =====
  private headerScroller: Scroller = new Scroller() // sticky 模式 header 横向 Scroll 控制器
  private bodyScroller: Scroller = new Scroller() // sticky 模式 body 横向 Scroll 控制器
  private syncManager: TableHorizontalScrollSync = new TableHorizontalScrollSync() // header/body 横向滚动同步器
  private oldStickyRowCount: number = 0 // sticky 模式上一次的总行数（含标题行），用于行减少时清理列宽记录
  // ===== offset sticky 模式（不固定高度，外层滚动） =====
  // @Consume 获取 holder 引用（引用不变，不触发build()），通过监听器更新 StickyOffsetHolder
  // StickyOffsetHolder 是 @Observed，@ObjectLink 在 StickyOffsetApplier 中检测变化
  // 只有 StickyOffsetApplier 重渲染（极轻量），MarkdownTable 和 CJMarkdown 都不重渲染
  @Consume('mdStickyHolder') stickyHolder: StickyScrollYHolder
  @State private useOffsetSticky: boolean = false // 是否使用 offset sticky 模式（aboutToAppear 时确定）
  @State private tableY: number = Number.MAX_SAFE_INTEGER // 表格在父容器中的Y位置（onAreaChange获取）
  @State private tableHeight: number = 0 // 表格总高度（onAreaChange获取）
  private tablePaddingTopNum: number = 0 // tablePaddingTop 的数值
  private tablePaddingBottomNum: number = 0 // tablePaddingBottom 的数值
  private tableBorderTopNum: number = 0 // tableBorderWidth 的数值（border 顶部宽度，border均匀）
  @State private offsetHolder: StickyOffsetHolder = new StickyOffsetHolder() // @State，引用不变不触发build()；@ObjectLink检测offset属性变化
  @State private copyRowHeight: number = 0 // 复制按钮栏高度（onAreaChange获取）
  @State private stickyContentHeight: number = 0 // 吸顶内容总高度（copy row + header，onAreaChange获取）

  /**
   * componentWidth变化时立即应用列宽
   * 不清除tracker数据：tracker保留已测量的内容宽度，避免clearWidths后
   * 内容宽于evenWidth的cell因size不变不触发onSizeChange导致tracker为空
   * applyColumnWidths内部用max(tracker, evenWidth)确保每列至少evenWidth
   */
  onComponentWidthChanged(): void {
    this.applyColumnWidths()
  }

  aboutToAppear(): void {
    this.tableContainerId = 'md-tbl-' + this.node.nodeHash
    this.cellWidthTracker.onWidthUpdated = () => {
      this.applyColumnWidths()
    }
    if (this.tableTheme.tableStickyHeader) {
      this.syncManager.registerHeader(this.headerScroller)
      this.syncManager.registerBody(this.bodyScroller)
    }
    this.useOffsetSticky = this.stickyHolder.enabled
    this.stickyHolder.addListener(this.onStickyYChanged)
    this.refreshData()
  }

  aboutToDisappear(): void {
    this.isAlive = false
    this.cellWidthTracker.onWidthUpdated = undefined
    this.stickyHolder.removeListener(this.onStickyYChanged)
    if (this.tableTheme.tableStickyHeader) {
      this.syncManager.unregisterHeader()
      this.syncManager.unregisterBody()
      this.syncManager.reset()
    }
  }

  /**
   * 外层滚动Y变化时直接更新 offsetHolder.offset
   * @Observed + @ObjectLink 只触发 StickyOffsetApplier 重渲染，不触发 MarkdownTable build()
   */
  private onStickyYChanged = (y: number): void => {
    this.recalculateOffset(y)
  }

  /**
   * 表格位置/高度变化时重新计算偏移
   */
  onTableAreaChanged(): void {
    this.recalculateOffset(this.stickyHolder.y)
  }

  /**
   * 计算 header 吸顶偏移量并更新 offsetHolder
   * - offset <= 0：表格未滚出视口，不吸顶
   * - upperBound <= 0：表格比吸顶内容短，不吸顶
   * - offset >= upperBound：吸顶内容底部到达表格底部（含padding+border），锁定在upperBound，随表格自然滚走
   * - 0 < offset < upperBound：正常吸顶，钉在视口顶部
   */
  private recalculateOffset(scrollY: number): void {
    if (scrollY < 0 || this.tableY === Number.MAX_SAFE_INTEGER) {
      this.offsetHolder.offset = 0
      return
    }
    const offset = scrollY - this.tableY
    // 上界 = 表格总高度 - borderTop - paddingTop - 吸顶内容高度
    // 吸顶内容底部到达表格border box底部时锁定，随表格自然滚走，与固定高度模式一致
    const upperBound = this.tableHeight - this.tableBorderTopNum - this.tablePaddingTopNum
      - this.stickyContentHeight
    if (offset <= 0 || upperBound <= 0) {
      this.offsetHolder.offset = 0
    } else if (offset >= upperBound) {
      this.offsetHolder.offset = upperBound
    } else {
      this.offsetHolder.offset = offset
    }
  }

  /**
   * 递归提取节点树中的所有文本，用于复制整表内容
   * 表格行间用换行分隔，单元格间用制表符分隔
   */
  private getFullTableText(): string {
    if (this.node.children.length === 0) {
      return ''
    }
    const lines: string[] = []
    for (let i = 0; i < this.node.children.length; i++) {
      const row = this.node.children[i]
      const cells: string[] = []
      for (let j = 0; j < row.children.length; j++) {
        cells.push(this.extractNodeText(row.children[j]))
      }
      lines.push(cells.join('\t'))
    }
    return lines.join('\n')
  }

  /**
   * 递归提取单个节点的文本内容
   */
  private extractNodeText(node: NodeView): string {
    let text = node.nodeText
    for (let i = 0; i < node.children.length; i++) {
      text += this.extractNodeText(node.children[i])
    }
    return text
  }

  build() {
    if (this.tableTheme.tableStickyHeader && this.useOffsetSticky) {
      // offset sticky 模式（不固定高度）：header用.offset()钉在视口顶部，非浮层
      ListItemGroup() {
        ListItem() {
          this.offsetStickyBodyBuilder()
        }
      }
      .backgroundColor(this.globalTheme.backgroundColor)
      .borderStyle(this.tableTheme.tableBorderStyle)
      .borderWidth(this.tableTheme.tableBorderWidth)
      .borderColor(this.tableTheme.tableBorderColor)
      .borderRadius({
        topLeft: this.tableTheme.tableRadiusTopLeft,
        topRight: this.tableTheme.tableRadiusTopRight,
        bottomLeft: this.tableTheme.tableRadiusBottomLeft,
        bottomRight: this.tableTheme.tableRadiusBottomRight
      })
      .padding({
        top: this.tableTheme.tablePaddingTop,
        right: this.tableTheme.tablePaddingRight,
        bottom: this.tableTheme.tablePaddingBottom,
        left: this.tableTheme.tablePaddingLeft
      })
      .margin({
        top: this.tableTheme.tableMarginTop,
        right: this.tableTheme.tableMarginRight,
        bottom: this.tableTheme.tableMarginBottom,
        left: this.tableTheme.tableMarginLeft
      })
      .clip(true)
      .onAreaChange((oldValue: Area, newValue: Area) => {
        // position.y 是 ListItemGroup border box 顶（相对 List，滚动时不变）
        // header 实际位置 = border box 顶 + border.top + padding.top（header 在 border+padding 内侧）
        // tableY = blockMarginTop + position.y + tableBorderTop + tablePaddingTop
        let marginTop: number = 0
        if (typeof this.globalTheme.blockMarginTop === 'number') {
          marginTop = this.globalTheme.blockMarginTop
        }
        let paddingTop: number = 0
        if (typeof this.tableTheme.tablePaddingTop === 'number') {
          paddingTop = this.tableTheme.tablePaddingTop
        }
        let paddingBottom: number = 0
        if (typeof this.tableTheme.tablePaddingBottom === 'number') {
          paddingBottom = this.tableTheme.tablePaddingBottom
        }
        let borderTop: number = 0
        if (typeof this.tableTheme.tableBorderWidth === 'number') {
          borderTop = this.tableTheme.tableBorderWidth
        }
        this.tablePaddingTopNum = paddingTop
        this.tablePaddingBottomNum = paddingBottom
        this.tableBorderTopNum = borderTop
        this.tableY = (newValue.position.y as number) + marginTop + borderTop + paddingTop
        this.tableHeight = newValue.height as number
        this.onTableAreaChanged()
      })
    } else if (this.tableTheme.tableStickyHeader) {
      // 原生 sticky 模式（固定高度）：ListItemGroup + List.sticky(StickyStyle.Header)
      ListItemGroup({ header: this.tableHeaderBuilder }) {
        ListItem() {
          this.tableBodyBuilder()
        }
      }
      .backgroundColor(this.globalTheme.backgroundColor)
      .borderStyle(this.tableTheme.tableBorderStyle)
      .borderWidth(this.tableTheme.tableBorderWidth)
      .borderColor(this.tableTheme.tableBorderColor)
      .borderRadius({
        topLeft: this.tableTheme.tableRadiusTopLeft,
        topRight: this.tableTheme.tableRadiusTopRight,
        bottomLeft: this.tableTheme.tableRadiusBottomLeft,
        bottomRight: this.tableTheme.tableRadiusBottomRight
      })
      .padding({
        top: this.tableTheme.tablePaddingTop,
        right: this.tableTheme.tablePaddingRight,
        bottom: this.tableTheme.tablePaddingBottom,
        left: this.tableTheme.tablePaddingLeft
      })
      .margin({
        top: this.tableTheme.tableMarginTop,
        right: this.tableTheme.tableMarginRight,
        bottom: this.tableTheme.tableMarginBottom,
        left: this.tableTheme.tableMarginLeft
      })
      .clip(true)
    } else {
      // 非 sticky 模式：保留 Scroll > List > LazyForEach 结构
      Column() {
        if (this.tableTheme.tableHeadIsShow) {
          MarkDownTableTitle({
            node: this.node,
            tableTheme: this.tableTheme,
            tableCopyCallback: this.tableCopyCallback
          })
        }
        Scroll() {
          List({ scroller: this.scroller }) {
            LazyForEach(
              this.markdownDataSource,
              (item: NodeView, index: number) => {
                ListItem() {
                  if (item.nodeType === "TableRow") {
                    MarkdownTableRow({
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
                      tableBlockRowRow: index,
                      tableBlockRowCellSize: this.tableBlockCellSize,
                      tableBlockRowRowSize: this.node.children.length,
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
                      exposureThreshold: this.exposureThreshold
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
          .listDirection(Axis.Vertical)
          .alignListItem(ListItemAlign.Start)
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(this.tableTheme.tableScrollBarState)
        .scrollBarColor(this.tableTheme.tableScrollBarColor)
        .id(this.tableContainerId)
      }
      .backgroundColor(this.globalTheme.backgroundColor)
      .borderStyle(this.tableTheme.tableBorderStyle)
      .borderWidth(this.tableTheme.tableBorderWidth)
      .borderColor(this.tableTheme.tableBorderColor)
      .borderRadius({
        topLeft: this.tableTheme.tableRadiusTopLeft,
        topRight: this.tableTheme.tableRadiusTopRight,
        bottomLeft: this.tableTheme.tableRadiusBottomLeft,
        bottomRight: this.tableTheme.tableRadiusBottomRight
      })
      .padding({
        top: this.tableTheme.tablePaddingTop,
        right: this.tableTheme.tablePaddingRight,
        bottom: this.tableTheme.tablePaddingBottom,
        left: this.tableTheme.tablePaddingLeft
      })
      .margin({
        top: this.tableTheme.tableMarginTop,
        right: this.tableTheme.tableMarginRight,
        bottom: this.tableTheme.tableMarginBottom,
        left: this.tableTheme.tableMarginLeft
      })
      .clip(true)
    }
  }

  /**
   * sticky 模式：标题行 builder（ListItemGroup header）
   * 标题行包在独立横向 Scroll 中，与 body 通过 syncManager 同步横向偏移
   */
  @Builder
  tableHeaderBuilder() {
    if (this.node.children.length > 0) {
      Column() {
        // 复制按钮栏（不随横向滑动，充满屏幕宽度）
        if (this.tableTheme.tableHeadIsShow) {
          MarkDownTableTitle({
            node: this.node,
            tableTheme: this.tableTheme,
            tableCopyCallback: this.tableCopyCallback
          })
        }

        // 标题行横向 Scroll，与 body 通过 syncManager 同步
        Scroll(this.headerScroller) {
          MarkdownTableRow({
            node: this.node.children[0],
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
            tableBlockRowRow: 0,
            tableBlockRowCellSize: this.tableBlockCellSize,
            tableBlockRowRowSize: this.node.children.length,
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
            exposureThreshold: this.exposureThreshold
          })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .onScrollFrameBegin((offset: number, state: ScrollState) => {
          if (state !== ScrollState.Idle) {
            const newX = this.headerScroller.currentOffset().xOffset + offset
            this.syncManager.onHeaderScrolled(newX)
          }
          return { offsetRemain: offset }
        })
      }
    }
  }

  /**
   * sticky 模式：内容行 builder（单个 ListItem 内的横向 Scroll + Column + LazyForEach）
   * 所有 body 行共用一个横向 Scroll，与 header 通过 syncManager 同步横向偏移
   * 使用 LazyForEach + smartUpdateDataArray 确保 copyDataFrom 就地更新行对象，
   * @ObjectLink 检测到属性变化触发重渲染，避免 ForEach 复用组件时 @ObjectLink 不更新的问题
   */
  @Builder
  tableBodyBuilder() {
    Scroll(this.bodyScroller) {
      Column() {
        LazyForEach(
          this.markdownDataSource,
          (item: NodeView, index: number) => {
            MarkdownTableRow({
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
              tableBlockRowRow: index + 1,
              tableBlockRowCellSize: this.tableBlockCellSize,
              tableBlockRowRowSize: this.node.children.length,
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
              exposureThreshold: this.exposureThreshold
            })
          },
          (item: NodeView, index: number) => {
            return `${index}-${item.nodeHash}`
          }
        )
      }
      .alignItems(HorizontalAlign.Start)
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(this.tableTheme.tableScrollBarState)
    .scrollBarColor(this.tableTheme.tableScrollBarColor)
    .id(this.tableContainerId)
    .onScrollFrameBegin((offset: number, state: ScrollState) => {
      if (state !== ScrollState.Idle) {
        const newX = this.bodyScroller.currentOffset().xOffset + offset
        this.syncManager.onBodyScrolled(newX)
      }
      return { offsetRemain: offset }
    })
  }

  /**
   * offset sticky 模式：StickyOffsetApplier 包裹 copy row + header Scroll，body 在独立 Scroll 中
   * - copy row 在 Scroll 外，充满屏幕宽度，不随横向滑动
   * - header 在独立横向 Scroll 中，与 body 通过 syncManager 同步横向偏移
   * - StickyOffsetApplier 包裹 copy row + header，整体随 offset 吸顶
   * - body 在独立横向 Scroll 中，不吸顶，横向滑动与 header 同步
   */
  @Builder
  offsetStickyBodyBuilder() {
    Column() {
      // Header（StickyOffsetApplier 包裹 copy row + header，offset 变化只触发 Applier 重渲染）
      if (this.node.children.length > 0) {
        StickyOffsetApplier({
          holder: this.offsetHolder,
          bgColor: this.globalTheme.backgroundColor
        }) {
          Column() {
            // 复制按钮栏（Scroll 外，充满宽度，不随横向滑动）
            if (this.tableTheme.tableHeadIsShow) {
              MarkDownTableTitle({
                node: this.node,
                tableTheme: this.tableTheme,
                tableCopyCallback: this.tableCopyCallback
              })
            }

            // 标题行横向 Scroll，与 body 通过 syncManager 同步
            Scroll(this.headerScroller) {
              MarkdownTableRow({
                node: this.node.children[0],
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
                tableBlockRowRow: 0,
                tableBlockRowCellSize: this.tableBlockCellSize,
                tableBlockRowRowSize: this.node.children.length,
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
                exposureThreshold: this.exposureThreshold
              })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .onScrollFrameBegin((offset: number, state: ScrollState) => {
              if (state !== ScrollState.Idle) {
                const newX = this.headerScroller.currentOffset().xOffset + offset
                this.syncManager.onHeaderScrolled(newX)
              }
              return { offsetRemain: offset }
            })
          }
          .onAreaChange((oldValue: Area, newValue: Area) => {
            this.stickyContentHeight = newValue.height as number
            this.onTableAreaChanged()
          })
        }
      }

      // Body（独立横向 Scroll，与 header 通过 syncManager 同步）
      Scroll(this.bodyScroller) {
        Column() {
          LazyForEach(
            this.markdownDataSource,
            (item: NodeView, index: number) => {
              MarkdownTableRow({
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
                tableBlockRowRow: index + 1,
                tableBlockRowCellSize: this.tableBlockCellSize,
                tableBlockRowRowSize: this.node.children.length,
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
                exposureThreshold: this.exposureThreshold
              })
            },
            (item: NodeView, index: number) => {
              return `${index}-${item.nodeHash}`
            }
          )
        }
        .alignItems(HorizontalAlign.Start)
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(this.tableTheme.tableScrollBarState)
      .scrollBarColor(this.tableTheme.tableScrollBarColor)
      .id(this.tableContainerId)
      .onScrollFrameBegin((offset: number, state: ScrollState) => {
        if (state !== ScrollState.Idle) {
          const newX = this.bodyScroller.currentOffset().xOffset + offset
          this.syncManager.onBodyScrolled(newX)
        }
        return { offsetRemain: offset }
      })
    }
  }

  /**
   * 刷新数据
   */
  refreshData() {
    if (this.node.children.length === 0) {
      this.markdownDataSource.clear()
      this.tableBlockCellSize = 0
      this.cellWidthTracker.resize(0)
      this.columnWidths = []
      this.oldStickyRowCount = 0
      this.syncManager.reset()
      return
    }
    // 计算表格总共有几列（取第一行的子节点数）
    let cellSize = 0
    if (this.node.children.length > 0) {
      cellSize = this.node.children[0].children.length
    }
    if (cellSize !== this.tableBlockCellSize) {
      this.tableBlockCellSize = cellSize
      this.cellWidthTracker.resize(cellSize)
    }
    if (this.tableTheme.tableStickyHeader) {
      // sticky 模式：body 行通过 smartUpdateDataArray 就地更新（copyDataFrom），
      // 确保 @ObjectLink 检测到行属性变化，避免 ForEach 复用组件时 UI 不同步
      const newRowCount = this.node.children.length
      const newBodyRows = this.node.children.slice(1)
      // 行减少时清理已删除行的历史测量数据
      if (newRowCount < this.oldStickyRowCount) {
        for (let i = newRowCount; i < this.oldStickyRowCount; i++) {
          this.cellWidthTracker.clearRow(i)
        }
      }
      this.oldStickyRowCount = newRowCount
      this.markdownDataSource.smartUpdateDataArray(newBodyRows)
    } else {
      // 非 sticky 模式：data source 增量更新
      const oldRowCount = this.markdownDataSource.totalCount()
      this.markdownDataSource.smartUpdateDataArray(this.node.children)
      const newRowCount = this.markdownDataSource.totalCount()
      if (newRowCount < oldRowCount) {
        for (let i = newRowCount; i < oldRowCount; i++) {
          this.cellWidthTracker.clearRow(i)
        }
      }
    }
    // 立即应用列宽：applyColumnWidths内部有变化检测，宽度未变时不会触发@State重渲染
    this.applyColumnWidths()
  }

  /**
   * 对比tracker中的列宽与当前@State，仅在变化时更新以避免不必要重渲染
   * 每列宽度 = max(tracker测量值, componentWidth均分值)
   * - tracker有数据时：列宽≥内容最大宽度（列对齐）且≥evenWidth（充满屏幕）
   * - tracker无数据时：列宽=evenWidth（充满屏幕，待cell渲染后tracker更新）
   * - tracker宽度>evenWidth时：列宽=tracker宽度（内容超宽，横向滚动）
   */
  private applyColumnWidths(): void {
    const trackerWidths = this.cellWidthTracker.getWidths()
    const newWidths: number[] = [...trackerWidths]
    if (this.componentWidth > 0 && newWidths.length > 0) {
      const evenWidth = this.componentWidth / newWidths.length
      for (let i = 0; i < newWidths.length; i++) {
        if (newWidths[i] < evenWidth) {
          newWidths[i] = evenWidth
        }
      }
    }
    let changed = newWidths.length !== this.columnWidths.length
    for (let i = 0;!changed && i < newWidths.length; i++) {
      if (newWidths[i] !== this.columnWidths[i]) {
        changed = true
      }
    }
    if (changed) {
      this.columnWidths = [...newWidths]
    }
  }
}

/**
 * 吸顶偏移量应用器
 *
 * 极轻量组件：build() 只有 Column { child }.offset().zIndex(1).backgroundColor()
 * @ObjectLink 检测 holder.offset 变化，只触发本组件重渲染
 * 不触发父组件 MarkdownTable 的 build()，避免重渲染开销导致吸顶延迟
 */
@Component
struct StickyOffsetApplier {
  @ObjectLink holder: StickyOffsetHolder
  bgColor: ResourceColor = Color.White
  @BuilderParam child: () => void

  build() {
    Column() {
      this.child()
    }
    .backgroundColor(this.bgColor)
    .zIndex(1)
    .offset({ x: 0, y: this.holder.offset })
  }
}
