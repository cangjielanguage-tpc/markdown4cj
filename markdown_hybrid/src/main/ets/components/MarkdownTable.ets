import { MarkdownDataSource } from "../datasource/MarkdownDataSource"
import { CellWidthTracker } from "../model/CellWidthTracker"
import { NodeView } from "../model/NodeView"
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
  @Prop componentWidth: number = 0.0 // 父布局控件宽度
  textCopyCallback?: (text: string) => void // 文本复制的点击事件
  footnoteCallback?: (index: string) => void // 脚注点击事件
  tocCallback?: (index: number) => void // TOC/标题ID点击事件
  linkCallback?: (url: string) => void // 链接点击事件
  imageCallback?: (url: string) => void // 图片点击事件
  imageDownloadCallback?: (url: string) => void // 图片下载事件
  imageReplaceCallback?: (url: string) => Promise<ArrayBuffer | undefined> // 图片替换回调
  latexImageCallback?: (data: ArrayBuffer, height: number, width: number) => void // 数学公式图片点击事件
  latexStrCallback: (str: string) => string = (str: string) => str // 数学公式数据处理事件
  scroller: Scroller = new Scroller() // list控制器
  markdownDataSource: MarkdownDataSource = new MarkdownDataSource([]) // markdown页面数据源
  @State tableBlockCellSize: number = 0 // 表格总共有几列
  @Provide cellWidthTracker: CellWidthTracker = new CellWidthTracker(0) // 列宽跟踪器（非@Observed，onSizeChange只写不触发重渲染）
  @State columnWidths: number[] = [] // 列宽快照（refreshData时从tracker批量读取，触发一次重渲染）
  private widthTimer: number = -1 // 列宽应用防抖定时器
  private static readonly WIDTH_DEBOUNCE_MS: number = 200 // 列宽应用防抖间隔（ms）

  aboutToAppear(): void {
    this.cellWidthTracker.onWidthUpdated = () => {
      this.scheduleApplyColumnWidths()
    }
    this.refreshData() // 首次加载（refreshData内会调度applyColumnWidths）
  }

  aboutToDisappear(): void {
    if (this.widthTimer !== -1) {
      clearTimeout(this.widthTimer)
      this.widthTimer = -1
    }
  }

  build() {
    Scroll() {
      List({ scroller: this.scroller }) {
        LazyForEach(
          this.markdownDataSource,
          (item: NodeView, index: number) => {
            ListItem() {
              if (item.nodeType == "TableRow") {
                // 表格行
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
                  columnWidths: this.columnWidths,
                  textCopyCallback: this.textCopyCallback,
                  footnoteCallback: this.footnoteCallback,
                  tocCallback: this.tocCallback,
                  linkCallback: this.linkCallback,
                  imageCallback: this.imageCallback,
                  imageDownloadCallback: this.imageDownloadCallback,
                  imageReplaceCallback: this.imageReplaceCallback
                })
              } else {
                // 其它
                Text("")
              }
            }
          },
          (item: NodeView, index: number) => {
            return `${index}-${item.nodeType}`
          }
        )
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
      .listDirection(Axis.Vertical)
      .alignListItem(ListItemAlign.Start)
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(this.tableTheme.tableScrollBarState)
    .scrollBarColor(this.tableTheme.tableScrollBarColor)
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
  }

  /**
   * 刷新数据
   */
  refreshData() {
    if (this.node.children.length == 0) {
      this.markdownDataSource.clear()
      this.tableBlockCellSize = 0
      this.cellWidthTracker.resize(0)
      this.columnWidths = []
      return
    }
    // 计算表格总共有几列（取第一行的子节点数）
    let cellSize = 0
    if (this.node.children.length > 0) {
      cellSize = this.node.children[0].children.length
    }
    if (cellSize != this.tableBlockCellSize) {
      this.tableBlockCellSize = cellSize
      this.cellWidthTracker.resize(cellSize)
    }
    this.markdownDataSource.smartUpdateDataArray(this.node.children)
    // 防抖应用列宽：流式输出时高频refreshData，延迟合并为一次@State更新
    this.scheduleApplyColumnWidths()
  }

  /**
   * 防抖调度列宽应用
   * 流式输出期间频繁refreshData，每次都调用applyColumnWidths会导致高频@State重渲染
   * 通过防抖延迟200ms合并，流式期间不触发宽度重渲染，停止后一次性应用
   */
  private scheduleApplyColumnWidths(): void {
    if (this.widthTimer !== -1) {
      clearTimeout(this.widthTimer)
    }
    this.widthTimer = setTimeout(() => {
      this.widthTimer = -1
      this.applyColumnWidths()
    }, MarkdownTable.WIDTH_DEBOUNCE_MS)
  }

  /**
   * 对比tracker中的列宽与当前@State，仅在变化时更新以避免不必要重渲染
   */
  private applyColumnWidths(): void {
    const newWidths = this.cellWidthTracker.getWidths()
    let changed = newWidths.length !== this.columnWidths.length
    for (let i = 0; !changed && i < newWidths.length; i++) {
      if (newWidths[i] !== this.columnWidths[i]) {
        changed = true
      }
    }
    if (changed) {
      this.columnWidths = [...newWidths]
    }
  }
}
