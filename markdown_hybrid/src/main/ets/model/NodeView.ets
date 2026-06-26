import { SourceSpan } from "@cangjie-tpc/markdown_parser_hybrid"

/**
 * MarkdownNodeView
 */
@Observed
export class NodeView {
  children: Array<NodeView> = Array<NodeView>() // 子节点列表
  nodeType: string = "" // node类型
  nodeText: string = "" // node文本内容
  nodeHash: string = "0" // node自身标识
  contentHash: string = "0" // node子节点标识
  isParagraph: boolean = false // 是否在段落中
  isHeading: boolean = false // 是否在标题中
  headingLevel: number = 1 // 标题等级
  headingID: string = "" // 标题ID
  isTable: boolean = false // 是否在表格中
  tableAlignment: HorizontalAlign = HorizontalAlign.Start // 表格列对齐方式
  isTableHead: boolean = false // 是否在表格标题中
  isTableBody: boolean = false // 是否在表格内容中
  isTableRow: boolean = false // 是否在表格行中
  isTableCell: boolean = false // 是否在表格列中
  isDescList: boolean = false // 是否在定义列表中
  isDescTerm: boolean = false // 是否在定义列表术语中
  isBulletList: boolean = false // 是否在无序列表中
  isOrderedList: boolean = false // 是否在有序列表中
  orderedListNumber: number = 0 // 有序列表编号
  isTaskList: boolean = false // 是否在任务列表中
  isTaskListSelected: boolean = false // 任务列表是否选中
  isQuote: boolean = false // 是否在块引用中
  isFootnote: boolean = false // 是否在脚注中
  footnoteID?: string = undefined // 脚注ID
  isLatexMathBlock: boolean = false // 是否在块结构数学公式中
  isLatexMathBlockClose: boolean = false // 块结构数学公式是否结束
  isFontNode: boolean = false // 是否在FontNode中
  fontNodeSize?: number = undefined // FontNode文本大小
  fontNodeColor?: Color = undefined // FontNode文本颜色
  isSpanNode: boolean = false // 是否在SpanNode中
  spanNodeSize?: number = undefined // SpanNode文本大小
  spanNodeWeight?: FontWeight = undefined // SpanNode文本加粗
  spanNodeColor?: Color = undefined // SpanNode文本颜色
  isEmphasis: boolean = false // 是否在斜体中
  isStrongEmphasis: boolean = false // 是否在粗体中
  isUnderlineNode: boolean = false // 是否在下划线中
  isStrikethrough: boolean = false // 是否在删除线中
  isHighlight: boolean = false // 是否在高亮文本中
  isSubNode: boolean = false // 是否在下标中
  isSupNode: boolean = false // 是否在上标中
  isInLineCode: boolean = false // 是否在内联代码中
  isLink: boolean = false // 是否在链接中
  headLinkIndex?: number = undefined // HeadLink标识
  linkUrl?: string = undefined // 链接URL
  linkTitle?: string = undefined // 链接标题
  imageUrl?: string = undefined // 图片URL
  imageTitle?: string = undefined // 图片标题
  imageStyleWidth?: number = undefined // 图片样式宽度
  imageStyleHeight?: number = undefined // 图片样式高度
  imageWidth: number = 0 // 控件宽度
  imageHeight: number = 0 // 控件高度
  imageRadius?: Length = undefined // 图片圆角
  imageAlign?: HorizontalAlign = undefined // 图片对齐方式
  codeInfo?: string = undefined // 代码块的代码类型
  codeListTab?: Array<string> = undefined // 代码块列表标题
  cardName?: string = undefined // 卡片名称
  cardData?: string = undefined // 卡片内容
  sourceSpan: Array<SourceSpan> = new Array<SourceSpan>() // 每个节点位置信息

  /**
   * 递归计算内容指纹（所有后代节点的nodeText拼接）
   * 用于LazyForEach/ForEach的key生成，确保内容变化时key也变化，触发组件重建
   *
   * @return 内容指纹字符串
   */
  contentFingerprint(): string {
    let result = this.nodeType + ":" + this.nodeText
    for (let i = 0; i < this.children.length; i++) {
      result += "|" + this.children[i].contentFingerprint()
    }
    return result
  }

  /**
   * 全量数据拷贝（包括children、nodeType等所有属性）
   * 用于就地更新NodeView属性，保持对象引用不变
   * 这样@Observed能检测到属性变化，@ObjectLink的@Watch会触发，避免组件重建导致闪烁
   *
   * @param source 拷贝的NodeView
   */
  copyDataFrom(source: NodeView): void {
    this.nodeType = source.nodeType
    this.nodeText = source.nodeText
    this.nodeHash = source.nodeHash
    this.contentHash = source.contentHash
    this.children = source.children
    this.sourceSpan = source.sourceSpan
    this.headingLevel = source.headingLevel
    this.headingID = source.headingID
    this.copyStyleFrom(source)
  }

  /**
   * 属性拷贝
   *
   * @param source 拷贝的NodeView
   */
  copyStyleFrom(source: NodeView): void {
    this.isParagraph = source.isParagraph
    this.isHeading = source.isHeading
    this.headingLevel = source.headingLevel
    this.headingID = source.headingID
    this.isTable = source.isTable
    this.tableAlignment = source.tableAlignment
    this.isTableHead = source.isTableHead
    this.isTableBody = source.isTableBody
    this.isTableRow = source.isTableRow
    this.isTableCell = source.isTableCell
    this.isDescList = source.isDescList
    this.isDescTerm = source.isDescTerm
    this.isBulletList = source.isBulletList
    this.isOrderedList = source.isOrderedList
    this.orderedListNumber = source.orderedListNumber
    this.isTaskList = source.isTaskList
    this.isTaskListSelected = source.isTaskListSelected
    this.isQuote = source.isQuote
    this.isFootnote = source.isFootnote
    this.footnoteID = source.footnoteID
    this.isLatexMathBlock = source.isLatexMathBlock
    this.isLatexMathBlockClose = source.isLatexMathBlockClose
    this.isFontNode = source.isFontNode
    this.fontNodeSize = source.fontNodeSize
    this.fontNodeColor = source.fontNodeColor
    this.isSpanNode = source.isSpanNode
    this.spanNodeSize = source.spanNodeSize
    this.spanNodeWeight = source.spanNodeWeight
    this.spanNodeColor = source.spanNodeColor
    this.isEmphasis = source.isEmphasis
    this.isStrongEmphasis = source.isStrongEmphasis
    this.isUnderlineNode = source.isUnderlineNode
    this.isStrikethrough = source.isStrikethrough
    this.isHighlight = source.isHighlight
    this.isSubNode = source.isSubNode
    this.isSupNode = source.isSupNode
    this.isInLineCode = source.isInLineCode
    this.headLinkIndex = source.headLinkIndex
    this.isLink = source.isLink
    this.linkUrl = source.linkUrl
    this.linkTitle = source.linkTitle
    this.imageUrl = source.imageUrl
    this.imageWidth = source.imageWidth
    this.imageTitle = source.imageTitle
    this.imageHeight = source.imageHeight
    this.imageStyleWidth = source.imageStyleWidth
    this.imageStyleHeight = source.imageStyleHeight
    this.imageRadius = source.imageRadius
    this.imageAlign = source.imageAlign
    this.codeInfo = source.codeInfo
    this.codeListTab = source.codeListTab
    this.cardName = source.cardName
    this.cardData = source.cardData
  }
}