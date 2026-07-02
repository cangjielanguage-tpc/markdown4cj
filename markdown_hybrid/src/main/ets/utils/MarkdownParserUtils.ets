import { JsNodeImpl, JsNode, SourceSpan } from "@cangjie-tpc/markdown_parser_hybrid"
import { NodeView } from "../model/NodeView"
import {
  renderTableCellColumnAlign,
  sizeStringToSize,
  colorStringToColor,
  fontWeightToValue,
  strToLengthNumber,
  parsePicStyle
} from "./MarkdownUtils"
import { computeLinkIconInfo } from "./MarkdownLinkIconGenerator"

/**
 * 比较两个SourceSpan数组是否相等（基于行号、列号、长度）
 * 用于增量nodeToNodeView的稳定子树判断
 *
 * @param a 源位置数组A
 * @param b 源位置数组B
 * @return 是否相等
 */
function sourceSpansEqual(a: Array<SourceSpan>, b: Array<SourceSpan>): boolean {
  if (a.length !== b.length) {
    return false
  }
  for (let i = 0; i < a.length; i++) {
    if (a[i].getLineIndex() !== b[i].getLineIndex()) {
      return false
    }
    if (a[i].getColumnIndex() !== b[i].getColumnIndex()) {
      return false
    }
    if (a[i].getLength() !== b[i].getLength()) {
      return false
    }
  }
  return true
}

/**
 * 递归查找节点所有子节点中第一个Image节点的destination
 *
 * @param node 起始节点
 * @return 找到的图片URL，未找到返回undefined
 */
function findImageUrlFromDescendants(node: JsNodeImpl | undefined): string | undefined {
  if (node === undefined) {
    return undefined
  }
  let child = node.firstChild
  while (child !== undefined) {
    if (child.nodeType === 'Image') {
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
 * 从JsNode.toStr中解析tabs数组
 * FencedCodeBlockListBlock的toStr格式类似于: "name:mylist, tabs=[tab1, tab2, tab3]"
 * 如果解析失败返回undefined
 *
 * @param toStr to字符串
 * @return 解析出的标签数组，无法解析时返回undefined
 */
function parseTabsFromToStr(toStr: string): Array<string> | undefined {
  if (!toStr) {
    return undefined
  }
  if (toStr.length === 0) {
    return undefined
  }
  let tabsKey = 'tabs=['
  let startIdx = toStr.indexOf(tabsKey)
  if (startIdx < 0) {
    return undefined
  }
  startIdx += tabsKey.length
  let endIdx = toStr.indexOf(']', startIdx)
  if (endIdx < 0) {
    return undefined
  }
  let tabsContent = toStr.substring(startIdx, endIdx)
  if (tabsContent.length === 0) {
    return []
  }
  let tabs = tabsContent.split(', ')
  return tabs
}

/**
 * 递归提取Link节点下所有子节点的文本
 * 用于链接块状化时获取链接显示文本
 *
 * @param node JsNode起始节点
 * @return 拼接后的链接文本
 */
function getLinkText(node: JsNodeImpl | undefined): string {
  if (node === undefined) {
    return ""
  }
  const parts: string[] = []
  let child = node.firstChild
  while (child !== undefined) {
    const childType = child.nodeType
    if (childType === 'Text' || childType === 'Code') {
      parts.push(child.literal ?? "")
    } else if (childType === 'LatexMathNode') {
      parts.push(child.latex ?? "")
    } else if (childType === 'Footnote') {
      parts.push(child.noteid ?? "")
    } else if (childType === 'SoftLineBreak') {
      parts.push(" ")
    } else if (childType === 'HardLineBreak') {
      parts.push("\n")
    } else {
      parts.push(getLinkText(child))
    }
    child = child.next
  }
  return parts.join("")
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
  sourceJsNode: JsNodeImpl,
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
    // 分步判空，避免&&短路求值在ArkTS运行时不可靠
    let prevChild: NodeView | undefined = undefined
    if (previousChildren !== undefined) {
      if (prevChildPos < previousChildren.length) {
        const candidate = previousChildren[prevChildPos]
        if (candidate.nodeType === nodeType) {
          prevChild = candidate
        }
      }
    }
    let canReuse = prevChild !== undefined
    if (canReuse && nodeType === 'FencedCodeBlockListBlock') {
      canReuse = false
    }
    if (canReuse && nodeType !== 'Text' && nodeType !== 'Code' &&
        nodeType !== 'FencedCodeBlock' && nodeType !== 'IndentedCodeBlock' &&
        nodeType !== 'LatexMathNode' && nodeType !== 'LatexMathBlock') {
      canReuse = false
    }
    // 提前读取props，用于复用判断和新NodeView创建
    const prop = currentJsNode.getProps()
    const newNodeHash = prop !== undefined ? (prop.get("nodeHash") ?? "0") : "0"
    const newContentHash = prop !== undefined ? (prop.get("contentHash") ?? "0") : "0"
    if (canReuse && prevChild !== undefined) {
      if (sourceSpansEqual(prevChild.sourceSpan, currentJsNode.getSourceSpans())) {
        // sourceSpan完全匹配 — 复用整个子树，跳过转换
        // FencedCodeBlockListBlock例外：其sourceSpan仅从首个代码块设置，新增代码块时不变化
        // 流式输出时sourceSpan可能不变但文本已增长，需同步更新nodeText和hash
        // 否则ForEach key不变，Span不重建，显示旧文本（如URL截断）
        prevChild.nodeHash = newNodeHash
        prevChild.contentHash = newContentHash
        if (nodeType === 'Text' || nodeType === 'Code') {
          prevChild.nodeText = currentJsNode.literal ?? ""
        } else if (nodeType === 'FencedCodeBlock' || nodeType === 'IndentedCodeBlock') {
          prevChild.nodeText = currentJsNode.literal?.replace(/\n$/, '') ?? ""
          if (nodeType === 'FencedCodeBlock') {
            prevChild.codeInfo = currentJsNode.info
          }
        } else if (nodeType === 'LatexMathNode') {
          // 行内数学公式：流式输出时latex内容可能增长（如"$x^"→"$x^2$"），
          // 但sourceSpan可能不变（解析器仅记录起始定界符位置）。
          // 需同步更新nodeText，并在文本变化时重置图片缓存，
          // 否则MarkdownParagraph.onListChanged不会重新入队加载（latexPixelMap非undefined即跳过），
          // 导致显示旧图片或原始latex纯文本。
          const newLatex: string = currentJsNode.latex ?? ""
          if (prevChild.nodeText !== newLatex) {
            prevChild.nodeText = newLatex
            if (prevChild.latexPixelMap !== undefined) {
              try {
                prevChild.latexPixelMap.release()
              } catch (e) {
                console.error('LatexMathNode latexPixelMap release failed: ' + JSON.stringify(e))
              }
              prevChild.latexPixelMap = undefined
            }
            prevChild.latexImageData = undefined
            prevChild.latexImageWidth = 0
            prevChild.latexImageHeight = 0
            prevChild.latexIsLoading = false
          }
        } else if (nodeType === 'LatexMathBlock') {
          // 块级数学公式：同理更新latex文本和闭合状态，
          // MarkdownLatexMathBlock的@Prop latexMathBlockStr变化会触发@Watch重新解析图片。
          // isLatexMathBlockClose也需同步，否则未闭合状态可能错误保留。
          prevChild.nodeText = currentJsNode.latex ?? ""
          prevChild.isLatexMathBlockClose = currentJsNode.isClosed ?? false
        }
        targetParentView.children.push(prevChild)
        currentJsNode = currentJsNode.next
        continue
      }
    }
    const currentView: NodeView = new NodeView()
    currentView.nodeType = nodeType
    currentView.sourceSpan = currentJsNode.getSourceSpans()

    currentView.copyStyleFrom(inheritedStyleView)

    if (prop !== undefined) {
      currentView.nodeHash = newNodeHash
      currentView.contentHash = newContentHash
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
        if (inheritedStyleView.isLinkStyle) {
          currentView.nodeText = getLinkText(currentJsNode)
          const iconInfo = computeLinkIconInfo(currentView.linkUrl ?? '', currentView.nodeText)
          currentView.linkIconType = iconInfo.iconType
          currentView.linkTypeStr = iconInfo.typeStr
          targetParentView.children.push(currentView)
        } else {
          nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        }
        break
      case 'HeadLink': // 标题链接
        currentView.isLink = true
        currentView.linkUrl = currentJsNode.destination
        currentView.linkTitle = currentJsNode.title
        currentView.headLinkIndex = currentJsNode.headIndex
        if (inheritedStyleView.isLinkStyle) {
          currentView.nodeText = getLinkText(currentJsNode)
          const iconInfo = computeLinkIconInfo(currentView.linkUrl ?? '', currentView.nodeText)
          currentView.linkIconType = iconInfo.iconType
          currentView.linkTypeStr = iconInfo.typeStr
          targetParentView.children.push(currentView)
        } else {
          nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        }
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
      case 'FontNode': { // FontNode标签
        currentView.isFontNode = true
        const fontNode = currentJsNode as JsNode
        // size属性
        const fontSizeStr: string | undefined = fontNode.size
        if (fontSizeStr !== undefined) {
          if (fontSizeStr.length > 0) {
            const size = sizeStringToSize(fontSizeStr)
            if (size !== undefined) {
              currentView.fontNodeSize = size
            }
          }
        }
        // color属性
        const fontColorStr: string | undefined = fontNode.color
        if (fontColorStr !== undefined) {
          if (fontColorStr.length > 0) {
            const color = colorStringToColor(fontColorStr)
            if (color !== undefined) {
              currentView.fontNodeColor = color
            }
          }
        }
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        break
      }
      case 'SpanNode': { // SpanNode标签
        currentView.isSpanNode = true
        // SpanNodeStyle直接在JsNodeImpl类上声明，可直接访问
        const style: Map<string, string> | undefined = currentJsNode.SpanNodeStyle
        if (style !== undefined) {
          // font-size
          const sizeStr = style.get('font-size')
          if (sizeStr !== undefined) {
            const size = sizeStringToSize(sizeStr)
            if (size !== undefined) {
              currentView.spanNodeSize = size
            }
          }
          // font-weight
          const weightStr = style.get('font-weight')
          if (weightStr !== undefined) {
            const weight = fontWeightToValue(weightStr)
            if (weight !== undefined) {
              currentView.spanNodeWeight = weight
            }
          }
          // color
          const colorStr = style.get('color')
          if (colorStr !== undefined) {
            const color = colorStringToColor(colorStr)
            if (color !== undefined) {
              currentView.spanNodeColor = color
            }
          }
        }
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren)
        break
      }
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
          if (prop !== undefined) {
            currentView.headingID = prop.get("headingId") ?? ""
          }
          nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
          targetParentView.children.push(currentView)
        break
      case 'FencedCodeBlockListBlock': // 代码块列表
          currentView.codeListTab = parseTabsFromToStr(currentJsNode.toStr)
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
      case 'FootnoteBlock': // 脚注
        currentView.footnoteID = currentJsNode.noteid
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
      case 'Footnote': // 脚注
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
      case 'ImageHtmlNode': { // HTML图片
        currentView.imageUrl = currentJsNode.destination
        currentView.imageTitle = currentJsNode.title
        // 通过JsNode接口访问width/heigh/color等HTML属性字段
        // （JsNodeImpl类声明中仅部分字段显式声明，JsNode接口包含完整字段定义）
        const imgHtmlNode = currentJsNode as JsNode
        // width属性（number|string）
        const imgWidth: number | string | undefined = imgHtmlNode.width
        if (imgWidth !== undefined) {
          const widthStr = typeof imgWidth === 'number' ? String(imgWidth) : imgWidth
          const w = strToLengthNumber(widthStr)
          if (w !== undefined) {
            currentView.imageStyleWidth = w
          }
        }
        // heigh属性（注意JsNode接口字段拼写为heigh，非height）
        const imgHeight: string | undefined = imgHtmlNode.heigh
        if (imgHeight !== undefined) {
          const h = strToLengthNumber(imgHeight)
          if (h !== undefined) {
            currentView.imageStyleHeight = h
          }
        }
        targetParentView.children.push(currentView)
        break
      }
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
      case 'StyleImage': { // 样式图片
        currentView.imageUrl = currentJsNode.destination
        currentView.imageTitle = currentJsNode.title
        // ImageStyles直接在JsNodeImpl类上声明，可直接访问
        // 先判空再传入parsePicStyle，避免undefined/null导致.length异常
        const imageStyles: Array<string> | undefined = currentJsNode.ImageStyles
        if (imageStyles !== undefined && imageStyles !== null) {
          if (imageStyles.length > 0) {
            const picStyle = parsePicStyle(imageStyles)
          if (picStyle.width !== undefined) {
            currentView.imageStyleWidth = picStyle.width
          }
          if (picStyle.height !== undefined) {
            currentView.imageStyleHeight = picStyle.height
          }
          if (picStyle.borderRadius !== undefined) {
            currentView.imageRadius = picStyle.borderRadius
          }
          if (picStyle.align !== undefined) {
            currentView.imageAlign = picStyle.align
          }
          }
        }
        targetParentView.children.push(currentView)
        break
      }
      case 'BlockVideo': // 视频
        currentView.imageUrl = findImageUrlFromDescendants(currentJsNode)
        targetParentView.children.push(currentView)
        break
      case 'BlockAudio': // 音频
        currentView.imageUrl = findImageUrlFromDescendants(currentJsNode)
        targetParentView.children.push(currentView)
        break
      case 'BlockAD': // 广告
        targetParentView.children.push(currentView)
        break
      default: // 未知节点类型
        targetParentView.children.push(currentView)
        break
    }
    currentJsNode = currentJsNode.next
  }
}
