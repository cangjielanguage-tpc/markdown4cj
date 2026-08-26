import { JsNodeImpl, JsNode } from "@cangjie-tpc/markdown_parser_hybrid"
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
import { CustomViewRegistry } from "../plugin/CustomViewRegistry"
import { ArrayList } from "@kit.ArkTS"

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
 * 从 JsNode 的 props 中读取 nodeHash 与 contentHash
 */
function readNodeHashes(node: JsNodeImpl): [string, string] {
  const prop = node.getProps()
  const nodeHash = prop !== undefined ? (prop.get("nodeHash") ?? "0") : "0"
  const contentHash = prop !== undefined ? (prop.get("contentHash") ?? "0") : "0"
  return [nodeHash, contentHash]
}

/**
 * 从 previousChildren 中查找可复用的同类型子节点
 * 优先按位置匹配；位置不匹配时，在未使用的节点中按 hash 匹配，
 * 以兼容节点位置变化、删除后重新出现等更多增量场景。
 *
 * @param usedIndices 已复用节点的索引集合，避免重复匹配
 */
function findReusablePreviousChild(
  previousChildren: NodeView[] | undefined,
  position: number,
  nodeType: string,
  usedIndices: Set<number> | undefined,
  currentNodeHash: string,
  currentContentHash: string
): NodeView | undefined {
  if (previousChildren === undefined || previousChildren.length === 0) {
    return undefined
  }

  // 1. 位置优先匹配：保持最稳定的对象身份
  if (position < previousChildren.length) {
    const candidate = previousChildren[position]
    if (candidate.nodeType === nodeType && !usedIndices?.has(position)) {
      usedIndices?.add(position)
      return candidate
    }
  }

  if (usedIndices === undefined) {
    return undefined
  }

  // 2. 按 nodeHash + contentHash 精确匹配（内容完全未变）
  for (let i = 0; i < previousChildren.length; i++) {
    if (usedIndices.has(i)) {
      continue
    }
    const candidate = previousChildren[i]
    if (candidate.nodeType === nodeType &&
      candidate.nodeHash === currentNodeHash &&
      candidate.contentHash === currentContentHash) {
      usedIndices.add(i)
      return candidate
    }
  }

  // 3. 按 contentHash 匹配（子结构未变）
  if (currentContentHash !== "0") {
    for (let i = 0; i < previousChildren.length; i++) {
      if (usedIndices.has(i)) {
        continue
      }
      const candidate = previousChildren[i]
      if (candidate.nodeType === nodeType && candidate.contentHash === currentContentHash) {
        usedIndices.add(i)
        return candidate
      }
    }
  }

  // 4. 按 nodeHash 匹配（节点自身标识未变）
  if (currentNodeHash !== "0") {
    for (let i = 0; i < previousChildren.length; i++) {
      if (usedIndices.has(i)) {
        continue
      }
      const candidate = previousChildren[i]
      if (candidate.nodeType === nodeType && candidate.nodeHash === currentNodeHash) {
        usedIndices.add(i)
        return candidate
      }
    }
  }

  return undefined
}

/**
 * 判断节点类型是否为叶子节点（无子节点展开）
 */
function isLeafNodeType(nodeType: string): boolean {
  return nodeType === 'Text' || nodeType === 'Code' ||
    nodeType === 'FencedCodeBlock' || nodeType === 'IndentedCodeBlock' ||
    nodeType === 'LatexMathNode' || nodeType === 'LatexMathBlock' ||
    nodeType === 'Image' || nodeType === 'StyleImage' || nodeType === 'ImageHtmlNode'
}

/**
 * 判断当前节点在增量解析中是否可以复用
 */
function canReuseLeafNode(
  nodeType: string,
  previousChild: NodeView | undefined,
  isLinkStyle: boolean
): boolean {
  if (previousChild === undefined) {
    return false
  }
  // FencedCodeBlockListBlock 内容结构复杂，强制重建
  if (nodeType === 'FencedCodeBlockListBlock') {
    return false
  }
  if (isLeafNodeType(nodeType)) {
    return true
  }
  // Link/HeadLink 仅在块状化模式下作为叶子节点复用
  if ((nodeType === 'Link' || nodeType === 'HeadLink') && isLinkStyle) {
    return true
  }
  return false
}

/**
 * 应用 StyleImage 的样式属性到 NodeView
 */
function applyStyleImageProps(view: NodeView, imageStyles: Array<string> | undefined | null): void {
  if (imageStyles === undefined || imageStyles === null || imageStyles.length === 0) {
    return
  }
  const picStyle = parsePicStyle(imageStyles)
  if (picStyle.width !== undefined) {
    view.imageStyleWidth = picStyle.width
  }
  if (picStyle.height !== undefined) {
    view.imageStyleHeight = picStyle.height
  }
  if (picStyle.borderRadius !== undefined) {
    view.imageRadius = picStyle.borderRadius
  }
  if (picStyle.align !== undefined) {
    view.imageAlign = picStyle.align
  }
}

/**
 * 应用 ImageHtmlNode 的 width/height 到 NodeView
 */
function applyImageHtmlNodeProps(view: NodeView, imgHtmlNode: JsNode): void {
  const imgWidth: number | string | undefined = imgHtmlNode.width
  if (imgWidth !== undefined) {
    const widthStr = typeof imgWidth === 'number' ? String(imgWidth) : imgWidth
    const w = strToLengthNumber(widthStr)
    if (w !== undefined) {
      view.imageStyleWidth = w
    }
  }
  const imgHeight: string | undefined = imgHtmlNode.height
  if (imgHeight !== undefined) {
    const h = strToLengthNumber(imgHeight)
    if (h !== undefined) {
      view.imageStyleHeight = h
    }
  }
}

/**
 * 更新复用的图片/样式图片/HTML图片节点
 */
function updateReusedImageNode(
  prevChild: NodeView,
  currentJsNode: JsNodeImpl,
  nodeType: string
): void {
  const newUrl: string | undefined = currentJsNode.destination
  const newTitle: string | undefined = currentJsNode.title
  const urlChanged = prevChild.imageUrl !== newUrl
  if (urlChanged) {
    prevChild.imageUrl = newUrl
    prevChild.imageTitle = newTitle
    if (prevChild.imageReplacePixelMap !== undefined) {
      try {
        prevChild.imageReplacePixelMap.release()
      } catch (e) {
        console.error('Image imageReplacePixelMap release failed: ' + JSON.stringify(e))
      }
      prevChild.imageReplacePixelMap = undefined
    }
    prevChild.imageReplaceTried = false
    prevChild.imageWidth = undefined
    prevChild.imageHeight = undefined
    prevChild.imageNaturalWidth = undefined
    prevChild.imageNaturalHeight = undefined
  } else if (prevChild.imageTitle !== newTitle) {
    // URL 未变但 title 变化：同步更新 title，无需重置已加载的图片资源
    prevChild.imageTitle = newTitle
  }
  if (nodeType === 'StyleImage') {
    applyStyleImageProps(prevChild, currentJsNode.ImageStyles)
  } else if (nodeType === 'ImageHtmlNode') {
    applyImageHtmlNodeProps(prevChild, currentJsNode as JsNode)
  }
}

/**
 * 更新复用的链接/标题链接节点
 */
function updateReusedLinkNode(
  prevChild: NodeView,
  currentJsNode: JsNodeImpl,
  nodeType: string
): void {
  const newUrl: string | undefined = currentJsNode.destination
  const newText: string = getLinkText(currentJsNode)
  if (prevChild.linkUrl !== newUrl || prevChild.nodeText !== newText) {
    prevChild.linkUrl = newUrl
    prevChild.linkTitle = currentJsNode.title
    prevChild.nodeText = newText
    const iconInfo = computeLinkIconInfo(newUrl ?? '', newText)
    prevChild.linkIconType = iconInfo.iconType
    prevChild.linkTypeStr = iconInfo.typeStr
    if (prevChild.linkIconPixelMap !== undefined) {
      try {
        prevChild.linkIconPixelMap.release()
      } catch (e) {
        console.error('Link linkIconPixelMap release failed: ' + JSON.stringify(e))
      }
      prevChild.linkIconPixelMap = undefined
    }
    prevChild.linkIconTried = false
    prevChild.linkIconText = ''
    prevChild.linkIconWidth = 0
    prevChild.linkIconHeight = 0
  }
  if (nodeType === 'HeadLink') {
    prevChild.headLinkIndex = currentJsNode.headIndex
  } else {
    prevChild.headLinkIndex = undefined
  }
}

/**
 * 就地更新可复用的叶子节点
 */
function updateReusedLeafNode(
  prevChild: NodeView,
  currentJsNode: JsNodeImpl,
  nodeType: string,
  inheritedStyleView: NodeView
): void {
  const hashResult = readNodeHashes(currentJsNode)
  prevChild.nodeHash = hashResult[0]
  prevChild.contentHash = hashResult[1]
  prevChild.sourceSpan = currentJsNode.getSourceSpans()
  prevChild.copyStyleFrom(inheritedStyleView)

  // copyStyleFrom 可能覆盖节点自身类型标记，需重新设置
  if (nodeType === 'Code') {
    prevChild.isInLineCode = true
  }
  if (nodeType === 'Link' || nodeType === 'HeadLink') {
    prevChild.isLink = true
  }
  if (nodeType === 'LatexMathBlock') {
    prevChild.isLatexMathBlock = true
  }

  switch (nodeType) {
    case 'Text':
    case 'Code':
      prevChild.nodeText = currentJsNode.literal ?? ""
      break
    case 'FencedCodeBlock':
    case 'IndentedCodeBlock':
      prevChild.nodeText = currentJsNode.literal?.replace(/\n$/, '') ?? ""
      if (nodeType === 'FencedCodeBlock') {
        prevChild.codeInfo = currentJsNode.info
      }
      break
    case 'LatexMathNode': {
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
      break
    }
    case 'LatexMathBlock':
      prevChild.nodeText = currentJsNode.latex ?? ""
      prevChild.isLatexMathBlockClose = currentJsNode.isClosed ?? false
      break
    case 'Image':
    case 'StyleImage':
    case 'ImageHtmlNode':
      updateReusedImageNode(prevChild, currentJsNode, nodeType)
      break
    case 'Link':
    case 'HeadLink':
      updateReusedLinkNode(prevChild, currentJsNode, nodeType)
      break
  }
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
  previousChildren?: NodeView[],
  highlightSelectedList?: ArrayList<string>,
  inheritedUsedIndices?: Set<number>
): void {
  let currentJsNode = sourceJsNode.firstChild
  // 追踪本层 previousChildren 中哪些索引已被复用，避免跨位置 hash 匹配时重复消费
  // 行内容器（StrongEmphasis/SupHtmlNode 等）平铺子节点到同一 targetParentView 并共用同一 previousChildren，
  // 必须共享同一个 usedIndices，否则 hash 匹配会跨递归分支重复消费同一索引，
  // 导致同一个 NodeView 被复用到多个位置，后一次 copyStyleFrom 覆盖前一次的样式标记。
  const usedIndices = inheritedUsedIndices ?? (previousChildren !== undefined ? new Set<number>() : undefined)

  while (currentJsNode !== undefined) {
    const nodeType = currentJsNode.nodeType
    const hashResult = readNodeHashes(currentJsNode)
    const newNodeHash = hashResult[0]
    const newContentHash = hashResult[1]
    const prevChildPos = targetParentView.children.length
    const prevChild = findReusablePreviousChild(
      previousChildren, prevChildPos, nodeType, usedIndices, newNodeHash, newContentHash
    )

    // 增量复用：仅叶子节点可复用，容器节点走新建/递归分支
    if (canReuseLeafNode(nodeType, prevChild, inheritedStyleView.isLinkStyle) && prevChild !== undefined) {
      updateReusedLeafNode(prevChild, currentJsNode, nodeType, inheritedStyleView)
      targetParentView.children.push(prevChild)
      currentJsNode = currentJsNode.next
      continue
    }
    const currentView = new NodeView()
    currentView.nodeType = nodeType
    currentView.sourceSpan = currentJsNode.getSourceSpans()
    currentView.nodeHash = newNodeHash
    currentView.contentHash = newContentHash
    currentView.copyStyleFrom(inheritedStyleView)

    // 根据节点类型配置 currentView 并决定递归/平铺方式
    // A. 叶子节点：直接 push 到 targetParentView
    // B. 行内容器：设置样式标记后，子节点平铺到 targetParentView
    // C. 块级容器：设置样式标记后，子节点挂到 currentView，再 push currentView
    // D. 表格头/体 与 忽略节点：设置样式标记后，子节点平铺到 targetParentView，不 push currentView
    switch (nodeType) {
      // ===== 纯叶子节点 =====
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
      case 'HardLineBreak': // 硬换行
        targetParentView.children.push(currentView)
        break
      case 'LinkReferenceDefinition': // 链接引用定义
        break

      // ===== 链接（块状化时作为叶子，否则平铺子节点） =====
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
          nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren, highlightSelectedList, usedIndices)
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
          nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren, highlightSelectedList, usedIndices)
        }
        break

      // ===== 行内样式容器（子节点平铺） =====
      case 'SubNode': // 下标
      case 'SubHtmlNode':
        currentView.isSubNode = true
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren, highlightSelectedList, usedIndices)
        break
      case 'SupNode': // 上标
      case 'SupHtmlNode':
        currentView.isSupNode = true
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren, highlightSelectedList, usedIndices)
        break
      case 'UnderlineNode': // 下划线
        currentView.isUnderlineNode = true
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren, highlightSelectedList, usedIndices)
        break
      case 'Emphasis': // 斜体
        currentView.isEmphasis = true
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren, highlightSelectedList, usedIndices)
        break
      case 'StrongEmphasis': // 粗体
        currentView.isStrongEmphasis = true
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren, highlightSelectedList, usedIndices)
        break
      case 'Strikethrough': // 删除线
        currentView.isStrikethrough = true
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren, highlightSelectedList, usedIndices)
        break
      case 'HighlightNode': // 高亮
        currentView.isHighlight = true
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren, undefined, usedIndices)
        break
      case 'FontNode': { // FontNode标签
        currentView.isFontNode = true
        const fontNode = currentJsNode as JsNode
        const fontSizeStr: string | undefined = fontNode.size
        if (fontSizeStr !== undefined && fontSizeStr.length > 0) {
          const size = sizeStringToSize(fontSizeStr)
          if (size !== undefined) {
            currentView.fontNodeSize = size
          }
        }
        const fontColorStr: string | undefined = fontNode.color
        if (fontColorStr !== undefined && fontColorStr.length > 0) {
          const color = colorStringToColor(fontColorStr)
          if (color !== undefined) {
            currentView.fontNodeColor = color
          }
        }
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren, undefined, usedIndices)
        break
      }
      case 'SpanNode': { // SpanNode标签
        currentView.isSpanNode = true
        const style: Map<string, string> | undefined = currentJsNode.SpanNodeStyle
        if (style !== undefined) {
          const sizeStr = style.get('font-size')
          if (sizeStr !== undefined) {
            const size = sizeStringToSize(sizeStr)
            if (size !== undefined) {
              currentView.spanNodeSize = size
            }
          }
          const weightStr = style.get('font-weight')
          if (weightStr !== undefined) {
            const weight = fontWeightToValue(weightStr)
            if (weight !== undefined) {
              currentView.spanNodeWeight = weight
            }
          }
          const colorStr = style.get('color')
          if (colorStr !== undefined) {
            const color = colorStringToColor(colorStr)
            if (color !== undefined) {
              currentView.spanNodeColor = color
            }
          }
        }
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren, undefined, usedIndices)
        break
      }

      // ===== 块级结构容器（子节点挂到 currentView） =====
      case 'Paragraph': // 段落
        highlightSelectedList?.add(currentView.nodeHash.toString())
        if (currentView.isParagraph) {
          nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren, highlightSelectedList, usedIndices)
        } else {
          currentView.isParagraph = true
          nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children, highlightSelectedList)
          targetParentView.children.push(currentView)
        }
        break
      case 'Heading': // 标题
        highlightSelectedList?.add(currentView.nodeHash.toString())
        currentView.isHeading = true
        currentView.headingLevel = currentJsNode.level ?? 1
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children, highlightSelectedList)
        targetParentView.children.push(currentView)
        break
      case 'IdHeading': // 标题ID
        highlightSelectedList?.add(currentView.nodeHash.toString())
        currentView.isHeading = true
        currentView.headingLevel = currentJsNode.level ?? 1
        const headingProp = currentJsNode.getProps()
        if (headingProp !== undefined) {
          currentView.headingID = headingProp.get("headingId") ?? ""
        }
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children, highlightSelectedList)
        targetParentView.children.push(currentView)
        break
      case 'FencedCodeBlockListBlock': // 代码块列表
        currentView.codeListTab = parseTabsFromToStr(currentJsNode.toStr)
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
      case 'FencedCodeBlock': // 围栏代码块
        {
          // 自定义标签载体还原：preprocessCustomTags 把 <tag ...>...</tag> 原文包进无语言围栏块，
          // 此处从 literal 还原为自定义视图节点（不作为代码块渲染）。
          // parseTagLiteral 内部自跳前导空白，此处不做首字符判断（literal 可能带前导换行）
          const fenceLiteral = currentJsNode.literal ?? ''
          const parsedFenceTag = CustomViewRegistry.parseTagLiteral(fenceLiteral)
          if (parsedFenceTag !== undefined && CustomViewRegistry.isRegistered(parsedFenceTag.tag)) {
            currentView.nodeType = 'CustomTagView' // 专属类型，避免被 FencedCodeBlock 渲染分支截走
            currentView.customTag = parsedFenceTag.tag
            currentView.customAttrs = parsedFenceTag.attrs
            currentView.customContent = parsedFenceTag.content
            targetParentView.children.push(currentView)
            break
          }
          currentView.nodeText = fenceLiteral.replace(/\n$/, '')
          currentView.codeInfo = currentJsNode.info
          targetParentView.children.push(currentView)
        }
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
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children, highlightSelectedList)
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
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren, undefined, usedIndices)
        break
      case 'TableBody': // 表体
        currentView.isTableBody = true
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren, undefined, usedIndices)
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
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children, highlightSelectedList)
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

      // ===== 特殊/自定义节点 =====
      case 'IgnoreBlockNode': // 忽略节点
      case 'IgnoreInlineNode':
        nodeToNodeView(currentJsNode, targetParentView, currentView, previousChildren, undefined, usedIndices)
        break
      case 'HtmlBlock': {
        // 已注册的自定义标签块（如 <sdui data='...'></sdui>）转为自定义视图节点；其余保持原有丢弃行为
        const parsedTag = CustomViewRegistry.parseTagLiteral(currentJsNode.literal)
        if (parsedTag !== undefined && CustomViewRegistry.isRegistered(parsedTag.tag)) {
          currentView.nodeType = 'CustomTagView' // 专属类型，走 customTagViewComponent 渲染
          currentView.customTag = parsedTag.tag
          currentView.customAttrs = parsedTag.attrs
          currentView.customContent = parsedTag.content
          targetParentView.children.push(currentView)
        }
        break
      }
      case 'HtmlInline': {
        // 非CommonMark已知块标签（如 <sdui>）单行书写时落在段落行内流（HtmlInline）。
        // 已注册自定义标签的开标签生成节点（后处理 liftCustomTagBlocks 会将其提升为块级），闭标签丢弃
        const inlineLiteral = currentJsNode.literal ?? ''
        if (inlineLiteral.length > 1 && inlineLiteral[1] !== '/') {
          const parsedInlineTag = CustomViewRegistry.parseTagLiteral(inlineLiteral)
          if (parsedInlineTag !== undefined && CustomViewRegistry.isRegistered(parsedInlineTag.tag)) {
            currentView.nodeType = 'CustomTagView' // 专属类型，走 customTagViewComponent 渲染
            currentView.customTag = parsedInlineTag.tag
            currentView.customAttrs = parsedInlineTag.attrs
            currentView.customContent = parsedInlineTag.content
            targetParentView.children.push(currentView)
          }
        }
        break
      }
      case 'ImgVideo':
        break
      case 'ImageHtmlNode': // HTML图片
        currentView.imageUrl = currentJsNode.destination
        currentView.imageTitle = currentJsNode.title
        applyImageHtmlNodeProps(currentView, currentJsNode as JsNode)
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
      case 'StyleImage': // 样式图片
        currentView.imageUrl = currentJsNode.destination
        currentView.imageTitle = currentJsNode.title
        applyStyleImageProps(currentView, currentJsNode.ImageStyles)
        targetParentView.children.push(currentView)
        break
      case 'CustomCardImage': // 自定义卡片图片
        let cciChild = currentJsNode.firstChild
        while (cciChild !== undefined) {
          const childType = cciChild.nodeType
          if (childType === 'Image' || childType === 'StyleImage' || childType === 'ImageHtmlNode') {
            currentView.imageUrl = cciChild.destination
            currentView.imageTitle = cciChild.title
            let subChild = cciChild.firstChild
            while (subChild !== undefined) {
              if (subChild.nodeType === 'Text') {
                currentView.imageAltText = subChild.literal
              }
              subChild = subChild.next
            }
          }
          cciChild = cciChild.next
        }
        targetParentView.children.push(currentView)
        break
      case 'CustomCardLink': // 自定义卡片链接
        let cclChild = currentJsNode.firstChild
        while (cclChild !== undefined) {
          const childType = cclChild.nodeType
          if (childType === 'Link' || childType === 'HeadLink') {
            currentView.linkUrl = cclChild.destination
            currentView.linkTitle = cclChild.title
            currentView.nodeText = getLinkText(cclChild)
          }
          cclChild = cclChild.next
        }
        targetParentView.children.push(currentView)
        break
      case 'TableCellPart': // 表格单元格内文本段（与自定义卡片共存时由解析器包裹）
        currentView.isTableCellPart = true
        nodeToNodeView(currentJsNode, currentView, currentView, prevChild?.children)
        targetParentView.children.push(currentView)
        break
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

/**
 * 行内容器（段落/标题）children 是否含自定义标签节点
 */
function hasCustomTagChild(node: NodeView): boolean {
  for (let i = 0; i < node.children.length; i++) {
    if (node.children[i].customTag !== undefined) {
      return true
    }
  }
  return false
}

/**
 * 把含自定义标签节点的行内容器拆为 段落切片/卡片节点 序列，追加到 out
 */
function splitInlineContainerByCustomTags(node: NodeView, out: Array<NodeView>): void {
  let currentChildren: Array<NodeView> = []
  for (let i = 0; i < node.children.length; i++) {
    const child = node.children[i]
    if (child.customTag !== undefined) {
      // 先冲刷切片段落
      if (currentChildren.length > 0) {
        const seg = new NodeView()
        seg.copyStyleFrom(node)
        seg.nodeType = node.nodeType
        seg.nodeHash = `${node.nodeHash}-seg${out.length}`
        seg.contentHash = `${node.contentHash}-seg${out.length}`
        seg.children = currentChildren
        out.push(seg)
        currentChildren = []
      }
      out.push(child)
    } else {
      currentChildren.push(child)
    }
  }
  if (currentChildren.length > 0) {
    const seg = new NodeView()
    seg.copyStyleFrom(node)
    seg.nodeType = node.nodeType
    seg.nodeHash = `${node.nodeHash}-seg${out.length}`
    seg.contentHash = `${node.contentHash}-seg${out.length}`
    seg.children = currentChildren
    out.push(seg)
  }
}

/**
 * 将行内容器（段落/标题）中的自定义标签节点提升为块级（原地修改 root 子树）
 *
 * CommonMark 规范中非已知块标签（如 <sdui>）的单行书写落在段落行内流（HtmlInline），
 * 卡片为块级视图无法行内渲染，故在 NodeView 层拆段提升到容器父级，
 * 与 CTMarkdown-master CustomInlineTagParser 的行内兜底语义对齐。
 * 仅提升段落/标题；表格单元格内的自定义标签保持原位（表格结构不可插块）。
 */
export function liftCustomTagBlocks(parent: NodeView): void {
  const rebuilt: Array<NodeView> = []
  for (let i = 0; i < parent.children.length; i++) {
    const child = parent.children[i]
    if ((child.isParagraph || child.isHeading) && hasCustomTagChild(child)) {
      splitInlineContainerByCustomTags(child, rebuilt)
    } else {
      liftCustomTagBlocks(child)
      rebuilt.push(child)
    }
  }
  parent.children = rebuilt
}
