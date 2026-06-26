import { JsNode, SourceSpan } from "@cangjie-tpc/commonmark_hybrid"
import { NodeView } from "../model/NodeView"
import { renderTableCellColumnAlign } from "./MarkdownUtils"

/**
 * 比较两个SourceSpan数组是否相等（基于行号、列号、长度）
 * 用于增量nodeToNodeView的稳定子树判断
 */
function sourceSpansEqual(a: Array<SourceSpan>, b: Array<SourceSpan>): boolean {
  if (a.length !== b.length) return false
  for (let i = 0; i < a.length; i++) {
    if (a[i].getLineIndex() !== b[i].getLineIndex()) return false
    if (a[i].getColumnIndex() !== b[i].getColumnIndex()) return false
    if (a[i].getLength() !== b[i].getLength()) return false
  }
  return true
}

/**
 * 解析处理，将JsNode转换成NodeView
 *
 * @param sourceJsNode 源节点JsNode
 * @param targetParentView 目标父节点View - 子节点将添加到此节点
 * @param inheritedStyleView 继承样式上下文 - 用于平铺样式传递
 */
export function nodeToNodeView(
  sourceJsNode: JsNode,
  targetParentView: NodeView,
  inheritedStyleView: NodeView,
  previousChildren?: NodeView[]
): void {
  let currentJsNode = sourceJsNode.getFirstChild()
  while (currentJsNode !== undefined) {
    const nodeType = currentJsNode.getNodeType()
    // 增量复用：用targetParentView.children.length作为previousChildren的索引
    // 对于Pattern1节点(push currentView)：索引随每个push+1，与previousChildren 1:1对应
    // 对于Pattern2节点(不push，children平铺到targetParentView)：索引随子节点push递增
    //   递归调用传入相同previousChildren，子节点用targetParentView.children.length定位
    const prevChildPos = targetParentView.children.length
    const prevChild: NodeView | undefined =
      (previousChildren !== undefined && prevChildPos < previousChildren.length
        && previousChildren[prevChildPos].nodeType === nodeType)
        ? previousChildren[prevChildPos]
        : undefined
    if (prevChild !== undefined && sourceSpansEqual(prevChild.sourceSpan, currentJsNode.getSourceSpans())) {
      // sourceSpan完全匹配 — 复用整个子树，跳过转换
      targetParentView.children.push(prevChild)
      currentJsNode = currentJsNode.getNext()
      continue
    }
    const currentView: NodeView = new NodeView()
    currentView.nodeType = nodeType
    let prop = currentJsNode.getProps()
    if (prop !== undefined) {
      currentView.nodeHash = prop.get("nodeHash") ?? "0"
      currentView.contentHash = prop.get("contentHash") ?? "0"
    }
    currentView.sourceSpan = currentJsNode.getSourceSpans()

    currentView.copyStyleFrom(inheritedStyleView)

    switch (nodeType) {
      case 'Text': // 文本
        currentView.nodeText = currentJsNode.getLiteral() ?? ""
        targetParentView.children.push(currentView)
        break
      case 'Code': // 行内代码
        currentView.nodeText = currentJsNode.getLiteral() ?? ""
        currentView.isInLineCode = true
        targetParentView.children.push(currentView)
        break
      case 'SoftLineBreak': // 软换行
        targetParentView.children.push(currentView)
        break
      case 'HardLineBreak': // 硬换行
        targetParentView.children.push(currentView)
        break
      case 'LinkReferenceDefinition': // 链接引用定义
        break
      case 'Link': // 链接
        currentView.isLink = true
        currentView.linkUrl = currentJsNode.getDestination()
        currentView.linkTitle = currentJsNode.getTitle()
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        break
      case 'HeadLink': // 标题链接
        currentView.isLink = true
        currentView.linkUrl = currentJsNode.getDestination()
        currentView.linkTitle = currentJsNode.getTitle()
        currentView.headLinkIndex = currentJsNode.getHeadIndex()
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        break
      case 'SubNode': // 下标
      case 'SubHtmlNode':
        currentView.isSubNode = true
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        break
      case 'SupNode': // 上标
      case 'SupHtmlNode':
        currentView.isSupNode = true
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        break
      case 'UnderlineNode': // 下划线
        currentView.isUnderlineNode = true
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        break
      case 'FontNode':
          currentView.isFontNode = true
        //   const fontNode = currentJsNode as FontNode
        //   try {
        //     const sizeString: string | undefined = fontNode.size
        //     if (sizeString !== undefined && sizeString !== null) {
        //       const sizeInt = parseInt(sizeString)
        //       currentView.fontNodeSize = sizeInt
        //     }
        //   } catch (e) {
        //   }
        //   try {
        //     const colorString: string | undefined = fontNode.color
        //     if (colorString !== undefined && colorString !== null) {
        //       const colorUInt32 = parseInt(colorString.replace('#', '0x'))
        //       currentView.fontNodeColor = Color(colorUInt32)
        //     }
        //   } catch (e) {
        //   }
        //   nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        break
      case 'SpanNode':
          currentView.isSpanNode = true
        //   const spanNode = currentJsNode as SpanNode
        //   const style: Map<string, string> | undefined = spanNode.style
        //   if (style !== undefined && style !== null) {
        //     try {
        //       const sizeStr = style.get('font-size')
        //       if (sizeStr !== undefined) {
        //         const size = sizeStringToSize(sizeStr)
        //         if (size !== undefined) {
        //           currentView.spanNodeSize = size
        //         }
        //       }
        //     } catch (e) {
        //     }
        //     try {
        //       const weightStr = style.get('font-weight')
        //       if (weightStr !== undefined) {
        //         const weight = fontWeightToValue(weightStr)
        //         currentView.spanNodeWeight = weight
        //       }
        //     } catch (e) {
        //     }
        //     try {
        //       const colorStr = style.get('color')
        //       if (colorStr !== undefined) {
        //         const color = colorStringToColor(colorStr)
        //         if (color !== undefined) {
        //           currentView.spanNodeColor = color
        //         } else {
        //           if (colorStr.startsWith('#')) {
        //             const colorUInt32 = parseInt(colorStr.replace('#', '0x'))
        //             currentView.spanNodeColor = Color(colorUInt32)
        //           }
        //         }
        //       }
        //     } catch (e) {
        //     }
        //   }
        //   nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        break
      case 'Emphasis': // 斜体
        currentView.isEmphasis = true
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        break
      case 'StrongEmphasis': // 粗体
        currentView.isStrongEmphasis = true
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        break
      case 'Strikethrough': // 删除线
        currentView.isStrikethrough = true
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        break
      case 'HighlightNode': // 高亮
        currentView.isHighlight = true
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        break
      case 'Paragraph': // 段落
        if (currentView.isParagraph) {
          nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        } else {
          currentView.isParagraph = true
          nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
          targetParentView.children.push(currentView)
        }
        break
      case 'Heading': // 标题
        currentView.isHeading = true
        currentView.headingLevel = currentJsNode.getLevel() ?? 1
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
      case 'IdHeading': // 标题ID
          currentView.isHeading = true
          currentView.headingLevel = currentJsNode.getLevel() ?? 1
          // currentView.headingID =
          nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
          targetParentView.children.push(currentView)
        break
      case 'FencedCodeBlockListBlock': // 代码块列表
          // currentView.codeListTab =
          nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
          targetParentView.children.push(currentView)
        break
      case 'FencedCodeBlock': // 围栏代码块
        currentView.nodeText = currentJsNode.getLiteral()?.replace(/\n$/, '') ?? ""
        currentView.codeInfo = currentJsNode.getInfo()
        targetParentView.children.push(currentView)
        break
      case 'IndentedCodeBlock': // 缩进代码块
        currentView.nodeText = currentJsNode.getLiteral()?.replace(/\n$/, '') ?? ""
        targetParentView.children.push(currentView)
        break
      case 'BulletList': // 无序列表
        currentView.isBulletList = true
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
      case 'OrderedList': // 有序列表
        currentView.isOrderedList = true
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
      case 'ListItem': // 列表项
        // currentView.orderedListNumber =
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
      case 'TaskListItem': // 任务列表项
        currentView.isTaskList = true
        currentView.isTaskListSelected = currentJsNode.isDone() ?? false
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
      case 'BlockQuote': // 块引用
        currentView.isQuote = true
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
      case 'LatexMathBlock': // 数学公式块
        currentView.isLatexMathBlock = true
        currentView.nodeText = currentJsNode.getLatex() ?? ""
        // currentView.isLatexMathBlockClose =
        targetParentView.children.push(currentView)
        break
      case 'LatexMathNode': // 数学公式节点
        currentView.nodeText = currentJsNode.getLatex() ?? ""
        targetParentView.children.push(currentView)
        break
      case 'TableBlock': // 表格
        currentView.isTable = true
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
      case 'TableHead': // 表头
        currentView.isTableHead = true
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        break
      case 'TableBody': // 表体
        currentView.isTableBody = true
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        break
      case 'TableRow': // 表格行
        currentView.isTableRow = true
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
      case 'TableCell': // 表格单元格
        currentView.isTableCell = true
          currentView.tableAlignment = renderTableCellColumnAlign(currentJsNode.getAlignment())
          nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
          targetParentView.children.push(currentView)
        break
      case 'ThematicBreak': // 分隔线
        targetParentView.children.push(currentView)
        break
      case 'FootnoteBlock': //
          currentView.footnoteID = currentJsNode.getNoteid()
          nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
          targetParentView.children.push(currentView)
        break
      case 'Footnote': //
          currentView.isFootnote = true
          currentView.footnoteID = currentJsNode.getNoteid()
          currentView.nodeText = currentJsNode.getNoteid() ?? ""
          targetParentView.children.push(currentView)
        break
      case 'DescList': // 定义列表
        currentView.isDescList = true
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
      case 'DescTerm': // 定义列表术语
        currentView.isDescTerm = true
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
      case 'DescDef': // 定义列表描述
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
      case 'IgnoreBlockNode': // 忽略节点
      case 'IgnoreInlineNode':
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        break
      case 'HtmlBlock':
      case 'HtmlInline':
      case 'ImgVideo':
        break
      case 'ImageHtmlNode':
        //   const imageHtmlNode = currentJsNode as ImageHtmlNode
        currentView.imageUrl = currentJsNode.getDestination()
        //   currentView.imageWidth = strToLength(imageHtmlNode.width)
        //   currentView.imageHeight = strToLength(imageHtmlNode.height)
          targetParentView.children.push(currentView)
        break
      case 'SlideBlock': // 幻灯片块
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
      case 'ImageSingleBlock': // 单图块
        break
      case 'Image': // 图片
        currentView.imageUrl = currentJsNode.getDestination()
        currentView.imageTitle = currentJsNode.getTitle()
        targetParentView.children.push(currentView)
        break
      case 'StyleImage':
        //   const imageStyle = currentJsNode as StyleImage
        //   currentView.imageUrl = imageStyle.destination
        //   currentView.imageTitle = imageStyle.title
        //   const picStyle = parsePicStyle(imageStyle.styles)
        //   currentView.imageWidth = picStyle.width
        //   currentView.imageHeight = picStyle.height
        //   currentView.imageRadius = picStyle.borderRadius
        //   currentView.imageAlign = picStyle.align
        //   targetParentView.children.push(currentView)
        break
      case 'CardNode':
        //   const cardNode = currentJsNode as CardNode
        //   currentView.cardName = cardNode.name
        //   currentView.cardData = cardNode.data
        //   targetParentView.children.push(currentView)
        break
      case 'BlockVideo':
        //   const videoChildren = currentJsNode.iterateChildren()
        //   for (const commonmarkNode of videoChildren) {
        //     if (commonmarkNode instanceof CommonmarkImage) {
        //       currentView.imageUrl = (commonmarkNode as CommonmarkImage).destination
        //     }
        //   }
        //   targetParentView.children.push(currentView)
        break
      case 'BlockAudio':
        //   const audioChildren = currentJsNode.iterateChildren()
        //   for (const commonmarkNode of audioChildren) {
        //     if (commonmarkNode instanceof CommonmarkImage) {
        //       currentView.imageUrl = (commonmarkNode as CommonmarkImage).destination
        //     }
        //   }
        //   targetParentView.children.push(currentView)
        break
      case 'BlockAD':
        targetParentView.children.push(currentView)
        break
      default: // 未知节点类型
        targetParentView.children.push(currentView)
        break
    }
    currentJsNode = currentJsNode.getNext()
  }
}

/**
 * 哈希计算器 - 对应Cangjie的DefaultHasher
 * 使用多项式滚动哈希: hash = hash * 31 + value, 32位环绕
 */
class DefaultHasher {
  private hash: number = 0

  writeInt(value: number): void {
    this.hash = (this.hash * 31 + value) | 0
  }

  writeString(value: string): void {
    for (let i = 0; i < value.length; i++) {
      this.writeInt(value.charCodeAt(i))
    }
  }

  finish(): number {
    return this.hash
  }

  reset(): void {
    this.hash = 0
  }
}

/**
 * 计算NodeView树的nodeHash和contentHash（对应Cangjie的NodeIdPlugin）
 * - nodeHash: 基于位置（父positionHash + 子index + nodeType），前序遍历计算
 * - contentHash: 基于内容（节点自身属性 + 子节点contentHash），后序遍历计算
 *
 * 将此函数在nodeToNodeView之后调用，使isBlockStable能用O(1)哈希比较
 * 代替O(N)的contentFingerprint()回退路径
 *
 * @param rootView 根NodeView
 */
export function computeHashes(rootView: NodeView): void {
  const posHasher = new DefaultHasher()
  const nodeHasher = new DefaultHasher()
  const contentHasher = new DefaultHasher()
  computeHashesRecursive(rootView, 0, 0, posHasher, nodeHasher, contentHasher)
}

/**
 * 递归计算nodeHash和contentHash
 * posHasher/nodeHasher/contentHasher跨节点复用（reset+重写），减少GC压力
 *
 * 计算顺序：
 * 1. 前序：用posHasher算positionHash，用nodeHasher算nodeHash
 * 2. 递归子节点，收集contentHash到数组（此时contentHasher被子节点复用，父节点不能同时使用）
 * 3. 后序：用contentHasher写入自身属性+子节点contentHash，算出本节点contentHash
 *
 * @param node 当前节点
 * @param parentPositionHash 父节点的positionHash
 * @param index 当前节点在父节点children中的索引
 * @param posHasher 复用的position哈希器
 * @param nodeHasher 复用的node哈希器
 * @param contentHasher 复用的content哈希器
 * @return 当前节点的contentHash（数值形式，用于传递给父节点）
 */
function computeHashesRecursive(
  node: NodeView,
  parentPositionHash: number,
  index: number,
  posHasher: DefaultHasher,
  nodeHasher: DefaultHasher,
  contentHasher: DefaultHasher
): number {
  // Pass 1: 计算positionHash和nodeHash（前序）
  posHasher.reset()
  posHasher.writeInt(parentPositionHash)
  posHasher.writeInt(index)
  const positionHash = posHasher.finish()

  nodeHasher.reset()
  nodeHasher.writeInt(positionHash)
  nodeHasher.writeString(node.nodeType)
  node.nodeHash = nodeHasher.finish().toString()

  // Pass 2: 递归子节点，收集contentHash（contentHasher在此期间被子节点复用）
  const childHashes: number[] = []
  for (let i = 0; i < node.children.length; i++) {
    childHashes.push(computeHashesRecursive(node.children[i], positionHash, i, posHasher, nodeHasher, contentHasher))
  }

  // Pass 3: 计算contentHash（后序：子节点已递归完毕，contentHasher空闲可复用）
  contentHasher.reset()
  // 节点自身属性
  contentHasher.writeString(node.nodeType)
  contentHasher.writeString(node.nodeText)
  contentHasher.writeInt(node.headingLevel)
  contentHasher.writeString(node.headingID ?? "")
  contentHasher.writeInt(Number(node.tableAlignment))
  contentHasher.writeInt(node.orderedListNumber)
  contentHasher.writeInt(node.isTaskListSelected ? 1 : 0)
  contentHasher.writeString(node.footnoteID ?? "")
  contentHasher.writeString(node.linkUrl ?? "")
  contentHasher.writeString(node.linkTitle ?? "")
  contentHasher.writeString(node.imageUrl ?? "")
  contentHasher.writeString(node.imageTitle ?? "")
  contentHasher.writeInt(node.imageWidth)
  contentHasher.writeInt(node.imageHeight)
  contentHasher.writeString(node.codeInfo ?? "")
  contentHasher.writeInt(node.headLinkIndex ?? -1)
  contentHasher.writeString(node.cardName ?? "")
  contentHasher.writeString(node.cardData ?? "")
  // 子节点contentHash
  for (let i = 0; i < childHashes.length; i++) {
    contentHasher.writeInt(childHashes[i])
  }

  const contentHash = contentHasher.finish()
  node.contentHash = contentHash.toString()

  return contentHash
}
