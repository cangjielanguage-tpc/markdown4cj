import { JsNode } from "@cangjie-tpc/commonmark_hybrid"
import { NodeView } from "../model/NodeView"
import { renderTableCellColumnAlign } from "./MarkdownUtils"

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
  inheritedStyleView: NodeView
): void {
  let currentJsNode = sourceJsNode.getFirstChild()
  while (currentJsNode !== undefined) {
    const currentView: NodeView = new NodeView()
    const nodeType = currentJsNode.getNodeType()
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
        nodeToNodeView(currentJsNode, targetParentView, currentView)
        break
      case 'HeadLink': // 标题链接
        currentView.isLink = true
        currentView.linkUrl = currentJsNode.getDestination()
        currentView.linkTitle = currentJsNode.getTitle()
        currentView.headLinkIndex = currentJsNode.getHeadIndex()
        nodeToNodeView(currentJsNode, targetParentView, currentView)
        break
      case 'SubNode': // 下标
      case 'SubHtmlNode':
        currentView.isSubNode = true
        nodeToNodeView(currentJsNode, targetParentView, currentView)
        break
      case 'SupNode': // 上标
      case 'SupHtmlNode':
        currentView.isSupNode = true
        nodeToNodeView(currentJsNode, targetParentView, currentView)
        break
      case 'UnderlineNode': // 下划线
        currentView.isUnderlineNode = true
        nodeToNodeView(currentJsNode, targetParentView, currentView)
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
        //   nodeToNodeView(currentJsNode, targetParentView, currentView)
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
        //   nodeToNodeView(currentJsNode, targetParentView, currentView)
        break
      case 'Emphasis': // 斜体
        currentView.isEmphasis = true
        nodeToNodeView(currentJsNode, targetParentView, currentView)
        break
      case 'StrongEmphasis': // 粗体
        currentView.isStrongEmphasis = true
        nodeToNodeView(currentJsNode, targetParentView, currentView)
        break
      case 'Strikethrough': // 删除线
        currentView.isStrikethrough = true
        nodeToNodeView(currentJsNode, targetParentView, currentView)
        break
      case 'HighlightNode': // 高亮
        currentView.isHighlight = true
        nodeToNodeView(currentJsNode, targetParentView, currentView)
        break
      case 'Paragraph': // 段落
        if (currentView.isParagraph) {
          nodeToNodeView(currentJsNode, targetParentView, currentView)
        } else {
          currentView.isParagraph = true
          nodeToNodeView(currentJsNode, currentView, currentView)
          targetParentView.children.push(currentView)
        }
        break
      case 'Heading': // 标题
        currentView.isHeading = true
        currentView.headingLevel = currentJsNode.getLevel() ?? 1
        nodeToNodeView(currentJsNode, currentView, currentView)
        targetParentView.children.push(currentView)
        break
      case 'IdHeading': // 标题ID
          currentView.isHeading = true
          currentView.headingLevel = currentJsNode.getLevel() ?? 1
          // currentView.headingID =
          nodeToNodeView(currentJsNode, currentView, currentView)
          targetParentView.children.push(currentView)
        break
      case 'FencedCodeBlockListBlock': // 代码块列表
          // currentView.codeListTab =
          nodeToNodeView(currentJsNode, currentView, currentView)
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
        nodeToNodeView(currentJsNode, currentView, currentView)
        targetParentView.children.push(currentView)
        break
      case 'OrderedList': // 有序列表
        currentView.isOrderedList = true
        nodeToNodeView(currentJsNode, currentView, currentView)
        targetParentView.children.push(currentView)
        break
      case 'ListItem': // 列表项
        // currentView.orderedListNumber =
        nodeToNodeView(currentJsNode, currentView, currentView)
        targetParentView.children.push(currentView)
        break
      case 'TaskListItem': // 任务列表项
        currentView.isTaskList = true
        currentView.isTaskListSelected = currentJsNode.isDone() ?? false
        nodeToNodeView(currentJsNode, currentView, currentView)
        targetParentView.children.push(currentView)
        break
      case 'BlockQuote': // 块引用
        currentView.isQuote = true
        nodeToNodeView(currentJsNode, currentView, currentView)
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
        nodeToNodeView(currentJsNode, currentView, currentView)
        targetParentView.children.push(currentView)
        break
      case 'TableHead': // 表头
        currentView.isTableHead = true
        nodeToNodeView(currentJsNode, targetParentView, currentView)
        break
      case 'TableBody': // 表体
        currentView.isTableBody = true
        nodeToNodeView(currentJsNode, targetParentView, currentView)
        break
      case 'TableRow': // 表格行
        currentView.isTableRow = true
        nodeToNodeView(currentJsNode, currentView, currentView)
        targetParentView.children.push(currentView)
        break
      case 'TableCell': // 表格单元格
        currentView.isTableCell = true
          currentView.tableAlignment = renderTableCellColumnAlign(currentJsNode.getAlignment())
          nodeToNodeView(currentJsNode, currentView, currentView)
          targetParentView.children.push(currentView)
        break
      case 'ThematicBreak': // 分隔线
        targetParentView.children.push(currentView)
        break
      case 'FootnoteBlock': //
          currentView.footnoteID = currentJsNode.getNoteid()
          nodeToNodeView(currentJsNode, currentView, currentView)
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
        nodeToNodeView(currentJsNode, currentView, currentView)
        targetParentView.children.push(currentView)
        break
      case 'DescTerm': // 定义列表术语
        currentView.isDescTerm = true
        nodeToNodeView(currentJsNode, currentView, currentView)
        targetParentView.children.push(currentView)
        break
      case 'DescDef': // 定义列表描述
        nodeToNodeView(currentJsNode, currentView, currentView)
        targetParentView.children.push(currentView)
        break
      case 'IgnoreBlockNode': // 忽略节点
      case 'IgnoreInlineNode':
        nodeToNodeView(currentJsNode, targetParentView, currentView)
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
        nodeToNodeView(currentJsNode, currentView, currentView)
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
