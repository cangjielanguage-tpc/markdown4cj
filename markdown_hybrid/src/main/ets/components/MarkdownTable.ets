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
  @Prop @Watch('onComponentWidthChanged') componentWidth: number = 0.0 // 父布局控件宽度
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
  @Provide('tableColumnWidths') columnWidths: number[] = [] // 列宽快照（@Provide让TableCell通过@Consume直接读取，避免LazyForEach不刷新@Prop的问题）
  private isAlive: boolean = true // 组件是否存活

  /**
   * componentWidth变化时立即应用列宽
   * 初始渲染时componentWidth可能为0（父布局onSizeChange尚未触发），
   * 后续变为实际宽度时需重新应用均分回退，否则列宽全0无对齐
   */
  onComponentWidthChanged(): void {
    this.applyColumnWidths()
  }

  aboutToAppear(): void {
    this.cellWidthTracker.onWidthUpdated = () => {
      // onSizeChange回调时立即应用列宽（不防抖），确保测量结果及时生效
      this.applyColumnWidths()
    }
    this.refreshData() // 首次加载（refreshData内会调度applyColumnWidths）
  }

  aboutToDisappear(): void {
    this.isAlive = false
    this.cellWidthTracker.onWidthUpdated = undefined
  }

  build() {
    Scroll() {
      List({ scroller: this.scroller }) {
        LazyForEach(
          this.markdownDataSource,
          (item: NodeView, index: number) => {
            ListItem() {
              if (item.nodeType === "TableRow") {
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
            return `${index}-${item.nodeHash}`
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
    if (this.node.children.length === 0) {
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
    const oldRowCount = this.markdownDataSource.totalCount()
    if (cellSize !== this.tableBlockCellSize) {
      this.tableBlockCellSize = cellSize
      this.cellWidthTracker.resize(cellSize)
    }
    this.markdownDataSource.smartUpdateDataArray(this.node.children)
    // 行数减少时清理已删除行的历史测量数据，防止整体替换内容时残留宽度影响新表格
    const newRowCount = this.markdownDataSource.totalCount()
    if (newRowCount < oldRowCount) {
      for (let i = newRowCount; i < oldRowCount; i++) {
        this.cellWidthTracker.clearRow(i)
      }
    }
    // 立即应用列宽：applyColumnWidths内部有变化检测，宽度未变时不会触发@State重渲染
    this.applyColumnWidths()
  }

  /**
   * 对比tracker中的列宽与当前@State，仅在变化时更新以避免不必要重渲染
   * 若tracker尚无有效数据（全0），用componentWidth均分作为初始值，确保列对齐
   */
  private applyColumnWidths(): void {
    const trackerWidths = this.cellWidthTracker.getWidths()
    const newWidths: number[] = [...trackerWidths]
    let hasData = false
    for (let i = 0; i < newWidths.length; i++) {
      if (newWidths[i] > 0) {
        hasData = true
        break
      }
    }
    if (!hasData && newWidths.length > 0 && this.componentWidth > 0) {
      const evenWidth = this.componentWidth / newWidths.length
      for (let i = 0; i < newWidths.length; i++) {
        newWidths[i] = evenWidth
      }
    }
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
