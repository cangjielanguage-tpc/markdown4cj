import { JsNode, SourceSpan } from "@cangjie-tpc/markdown_parser_hybrid"
import { NodeView } from "../model/NodeView"
import { renderTableCellColumnAlign } from "./MarkdownUtils"
import hilog from "@ohos.hilog"

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
 * 递归查找节点所有子节点中第一个Image节点的destination
 */
function findImageUrlFromDescendants(node: JsNode | undefined): string | undefined {
  if (node === undefined) {
    return undefined
  }
  let child = node.firstChild
  while (child !== undefined) {
    if (child.nodeType == 'Image') {
      return child.destination
    }
    let result = findImageUrlFromDescendants(child)
    if (result !== undefined) {
      return result
    }
    child = child.next
  }
  return undefined
}

/**
 * 解析处理，将JsNode转换成NodeView
 *
 * @param sourceJsNode 源节点JsNode
 * @param targetParentView 目标父节点View - 子节点将添加到此节点
 * @param inheritedStyleView 继承样式上下文 - 用于平铺样式传递
 * @param previousChildren 上一轮的children，用于增量复用
 */
export function nodeToNodeView(
  sourceJsNode: JsNode,
  targetParentView: NodeView,
  inheritedStyleView: NodeView,
  previousChildren?: NodeView[]
): void {
  let currentJsNode = sourceJsNode.firstChild
  while (currentJsNode !== undefined) {
    const nodeType = currentJsNode.nodeType
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
      currentJsNode = currentJsNode.next
      continue
    }
    const currentView: NodeView = new NodeView()
    currentView.nodeType = nodeType
    currentView.sourceSpan = currentJsNode.getSourceSpans()

    currentView.copyStyleFrom(inheritedStyleView)

    // 从解析器props中获取nodeHash和contentHash
    const prop = currentJsNode.getProps()
    if (prop !== undefined) {
      currentView.nodeHash = prop.get("nodeHash") ?? "0"
      currentView.contentHash = prop.get("contentHash") ?? "0"
    }

    switch (nodeType) {
      case 'Text': // 文本
        currentView.nodeText = currentJsNode.literal ?? ""
        targetParentView.children.push(currentView)
        break
      case 'Code': // 行内代码
        currentView.nodeText = currentJsNode.literal ?? ""
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
        currentView.linkUrl = currentJsNode.destination
        currentView.linkTitle = currentJsNode.title
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        break
      case 'HeadLink': // 标题链接
        currentView.isLink = true
        currentView.linkUrl = currentJsNode.destination
        currentView.linkTitle = currentJsNode.title
        currentView.headLinkIndex = currentJsNode.headIndex
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
        currentView.headingLevel = currentJsNode.level ?? 1
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
      case 'IdHeading': // 标题ID
          currentView.isHeading = true
          currentView.headingLevel = currentJsNode.level ?? 1
          // currentView.headingID
          nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
          targetParentView.children.push(currentView)
        break
      case 'FencedCodeBlockListBlock': // 代码块列表
          // currentView.codeListTab =
          nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
          targetParentView.children.push(currentView)
        break
      case 'FencedCodeBlock': // 围栏代码块
        currentView.nodeText = currentJsNode.literal?.replace(/\n$/, '') ?? ""
        currentView.codeInfo = currentJsNode.info
        targetParentView.children.push(currentView)
        break
      case 'IndentedCodeBlock': // 缩进代码块
        currentView.nodeText = currentJsNode.literal?.replace(/\n$/, '') ?? ""
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
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
      case 'TaskListItem': // 任务列表项
        currentView.isTaskList = true
        currentView.isTaskListSelected = currentJsNode.isdone ?? false
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
        currentView.nodeText = currentJsNode.latex ?? ""
        currentView.isLatexMathBlockClose = currentJsNode.isClosed ?? false
        targetParentView.children.push(currentView)
        break
      case 'LatexMathNode': // 数学公式节点
        currentView.nodeText = currentJsNode.latex ?? ""
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
        currentView.tableAlignment = renderTableCellColumnAlign(currentJsNode.alignment)
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
      case 'ThematicBreak': // 分隔线
        targetParentView.children.push(currentView)
        break
      case 'FootnoteBlock': //
        currentView.footnoteID = currentJsNode.noteid
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
      case 'Footnote': //
          currentView.isFootnote = true
          currentView.footnoteID = currentJsNode.noteid
          currentView.nodeText = currentJsNode.noteid ?? ""
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
        currentView.imageUrl = currentJsNode.destination
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
        currentView.imageUrl = currentJsNode.destination
        currentView.imageTitle = currentJsNode.title
        targetParentView.children.push(currentView)
        break
      case 'StyleImage':
        //   const imageStyle = currentJsNode as StyleImage
          currentView.imageUrl = currentJsNode.destination
          currentView.imageTitle = currentJsNode.title
        //   const picStyle = parsePicStyle(imageStyle.styles)
        //   currentView.imageWidth = picStyle.width
        //   currentView.imageHeight = picStyle.height
        //   currentView.imageRadius = picStyle.borderRadius
        //   currentView.imageAlign = picStyle.align
          targetParentView.children.push(currentView)
        break
      case 'CardNode':
        //   const cardNode = currentJsNode as CardNode
        //   currentView.cardName = cardNode.name
        //   currentView.cardData = cardNode.data
        //   targetParentView.children.push(currentView)
        break
      case 'BlockVideo':
        currentView.imageUrl = findImageUrlFromDescendants(sourceJsNode)
        targetParentView.children.push(currentView)
        break
      case 'BlockAudio':
        currentView.imageUrl = findImageUrlFromDescendants(sourceJsNode)
        targetParentView.children.push(currentView)
        break
      case 'BlockAD':
        targetParentView.children.push(currentView)
        break
      default: // 未知节点类型
        targetParentView.children.push(currentView)
        break
    }
    currentJsNode = currentJsNode.next
  }
}
