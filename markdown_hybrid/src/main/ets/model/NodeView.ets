import { SourceSpan, JsNodeImpl } from "@cangjie-tpc/markdown_parser_hybrid"

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
  fontNodeColor?: ResourceColor = undefined // FontNode文本颜色
  isSpanNode: boolean = false // 是否在SpanNode中
  spanNodeSize?: number = undefined // SpanNode文本大小
  spanNodeWeight?: FontWeight = undefined // SpanNode文本加粗
  spanNodeColor?: ResourceColor = undefined // SpanNode文本颜色
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
  imageWidth?: number = undefined // 控件宽度
  imageHeight?: number = undefined // 控件高度
  imageRadius?: Length = undefined // 图片圆角
  imageAlign?: HorizontalAlign = undefined // 图片对齐方式
  imageReplacePixelMap: PixelMap | undefined = undefined // 图片替换PixelMap（imageReplaceCallback异步加载后设置）
  imageReplaceTried: boolean = false // 图片替换是否已尝试（防止重复请求）
  latexPixelMap: PixelMap | undefined = undefined // 数学公式图片PixelMap（异步加载后设置）
  latexImageData: ArrayBuffer | undefined = undefined // 数学公式图片原始数据
  latexImageWidth: number = 0 // 数学公式图片宽度 - 单位px
  latexImageHeight: number = 0 // 数学公式图片高度 - 单位px
  latexIsLoading: boolean = false // 数学公式是否正在加载
  codeInfo?: string = undefined // 代码块的代码类型
  codeListTab?: Array<string> = undefined // 代码块列表标题
  cardName?: string = undefined // 卡片名称
  cardData?: string = undefined // 卡片内容
  sourceSpan: Array<SourceSpan> = new Array<SourceSpan>() // 每个节点位置信息
  isLinkStyle: boolean = false // 链接是否块状化（isLinkStyle=true时Link节点作为独立节点，不扁平化）
  linkIconType: number = 0 // 链接图标类型（0=圆形,1=方形,2=空心方形带类型标签）
  linkTypeStr: string = '' // 链接类型字符串（iconType=2时使用）
  linkIconPixelMap: PixelMap | undefined = undefined // 链接图标PixelMap（C++原生绘图异步加载后设置）
  linkIconTried: boolean = false // 链接图标是否已尝试生成（防止重复请求）
  linkIconText: string = '' // 链接图标生成时使用的文本（用于检测流式输出中文本变化，避免显示过期图标）
  linkIconWidth: number = 0 // 链接图标宽度 - 单位px
  linkIconHeight: number = 0 // 链接图标高度 - 单位px

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
    if (this.children !== source.children) {
      this.releaseChildrenPixelMaps()
    }
    this.children = source.children
    this.sourceSpan = source.sourceSpan
    this.headingLevel = source.headingLevel
    this.headingID = source.headingID
    this.copyStyleFrom(source)
    if (this.imageReplacePixelMap !== undefined && this.imageReplacePixelMap !== source.imageReplacePixelMap) {
      try {
        this.imageReplacePixelMap.release()
      } catch (e) {
        console.error('imageReplacePixelMap release failed: ' + JSON.stringify(e))
      }
    }
    this.imageReplacePixelMap = source.imageReplacePixelMap
    this.imageReplaceTried = source.imageReplaceTried
    if (this.latexPixelMap !== undefined && this.latexPixelMap !== source.latexPixelMap) {
      try {
        this.latexPixelMap.release()
      } catch (e) {
        console.error('latexPixelMap release failed: ' + JSON.stringify(e))
      }
    }
    this.latexPixelMap = source.latexPixelMap
    this.latexImageData = source.latexImageData
    this.latexImageWidth = source.latexImageWidth
    this.latexImageHeight = source.latexImageHeight
    this.latexIsLoading = source.latexIsLoading
    if (this.linkIconPixelMap !== undefined && this.linkIconPixelMap !== source.linkIconPixelMap) {
      try {
        this.linkIconPixelMap.release()
      } catch (e) {
        console.error('linkIconPixelMap release failed: ' + JSON.stringify(e))
      }
    }
    this.linkIconPixelMap = source.linkIconPixelMap
    this.linkIconTried = source.linkIconTried
    this.linkIconText = source.linkIconText
    this.linkIconWidth = source.linkIconWidth
    this.linkIconHeight = source.linkIconHeight
  }

  /**
   * 递归释放子树中所有节点持有的PixelMap资源
   */
  releaseChildrenPixelMaps(): void {
    for (let i = 0; i < this.children.length; i++) {
      const child = this.children[i]
      try {
        if (child.imageReplacePixelMap !== undefined) {
          child.imageReplacePixelMap.release()
        }
      } catch (e) {
        console.error('releaseChildrenPixelMaps imageReplacePixelMap release failed: ' + JSON.stringify(e))
      }
      try {
        if (child.latexPixelMap !== undefined) {
          child.latexPixelMap.release()
        }
      } catch (e) {
        console.error('releaseChildrenPixelMaps latexPixelMap release failed: ' + JSON.stringify(e))
      }
      try {
        if (child.linkIconPixelMap !== undefined) {
          child.linkIconPixelMap.release()
        }
      } catch (e) {
        console.error('releaseChildrenPixelMaps linkIconPixelMap release failed: ' + JSON.stringify(e))
      }
      child.releaseChildrenPixelMaps()
    }
  }

  /**
   * 释放自身持有的PixelMap资源（不递归子节点）
   */
  releaseOwnPixelMaps(): void {
    try {
      if (this.imageReplacePixelMap !== undefined) {
        this.imageReplacePixelMap.release()
        this.imageReplacePixelMap = undefined
      }
    } catch (e) {
      console.error('releaseOwnPixelMaps imageReplacePixelMap release failed: ' + JSON.stringify(e))
    }
    try {
      if (this.latexPixelMap !== undefined) {
        this.latexPixelMap.release()
        this.latexPixelMap = undefined
      }
    } catch (e) {
      console.error('releaseOwnPixelMaps latexPixelMap release failed: ' + JSON.stringify(e))
    }
    try {
      if (this.linkIconPixelMap !== undefined) {
        this.linkIconPixelMap.release()
        this.linkIconPixelMap = undefined
      }
    } catch (e) {
      console.error('releaseOwnPixelMaps linkIconPixelMap release failed: ' + JSON.stringify(e))
    }
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
    this.isLinkStyle = source.isLinkStyle
    this.linkIconType = source.linkIconType
    this.linkTypeStr = source.linkTypeStr
  }
}

export interface JsNodePool {
  getJsNode(): JsNodeImpl
}

export class JsNodePoolImpl implements JsNodePool {
  generator: Array<JsNodeImpl> = []

  constructor() {
  }

  /**
   * 将节点树回收到对象池中
   *
   * @param nodeTree 节点树
   */
  put(nodeTree: JsNodeImpl) {
    traverseTree(nodeTree, this.generator)
  }

  /**
   * 将节点树中的Node依次取出,若无则返回新Node
   *
   * @return 节点对象，池为空时返回新实例
   */
  getJsNode(): JsNodeImpl {
    return this.generator.pop() ?? new JsNodeImpl()
  }
}

/**
 * 递归遍历节点树，将所有节点reset后存入数组（用于节点池回收）
 *
 * @param node 当前节点
 * @param arr 存放回收节点的数组
 */
export function traverseTree(node: JsNodeImpl | undefined, arr: Array<JsNodeImpl>) {
  if (node !== undefined) {
    let child:JsNodeImpl|undefined = node.firstChild
    let next:JsNodeImpl|undefined = node.next
    node.reset()
    arr.push(node)
    traverseTree(child, arr)
    traverseTree(next, arr)
  }
}