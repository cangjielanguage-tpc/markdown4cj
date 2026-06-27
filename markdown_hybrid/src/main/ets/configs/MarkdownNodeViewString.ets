import { NodeView } from "../model/NodeView"

/**
 * 全局文本对象
 * 深度优先遍历NodeView树，提取纯文本
 */
export class MarkdownNodeViewString {
  private root: NodeView | undefined = undefined
  private builder: string = ""
  private isBuilt: boolean = false

  /**
   * 构造函数
   */
  constructor() {
  }

  /**
   * 设置根节点
   *
   * @param root 根节点
   */
  setRoot(root: NodeView): void {
    this.root = root
    this.isBuilt = false
  }

  /**
   * 获取全局文本
   * - 处理缩进（列表、引用）
   * - 处理行内节点（Text/Code/换行等）
   * - block节点尾插换行
   *
   * @returns 全局文本
   */
  toString(): string {
    if (!this.isBuilt && this.root !== undefined) {
      this.builder = ""
      this.traverse(this.root, 0, 0, 0)
      this.isBuilt = true
    }
    return this.builder
  }

  /**
   * 深度优先遍历节点树
   *
   * @param node 当前节点
   * @param listDepth 列表嵌套深度
   * @param quoteDepth 引用嵌套深度
   * @param itemIndex 有序列表项索引（1-based）
   */
  private traverse(node: NodeView, listDepth: number, quoteDepth: number, itemIndex: number): void {
    if (this.leafNode(node)) {
      return
    }

    let childListDepth = listDepth
    let childQuoteDepth = quoteDepth
    if (node.nodeType == 'BulletList' || node.nodeType == 'OrderedList') {
      childListDepth = listDepth + 1
    }
    if (node.nodeType == 'BlockQuote') {
      childQuoteDepth = quoteDepth + 1
    }

    // 前处理节点: 前插缩进
    if (node.nodeType == 'ListItem' || node.nodeType == 'TaskListItem') {
      let depth = listDepth > 0 ? listDepth - 1 : 0
      this.add(this.repeatString("  ", depth))
      if (node.isOrderedList) {
        this.add(String(itemIndex > 0 ? itemIndex : 1) + ". ")
      }
    } else if (node.nodeType == 'BlockQuote') {
      this.add(this.repeatString("  ", quoteDepth))
    }

    // 处理子节点
    let itemIdx = 0
    for (let i = 0; i < node.children.length; i++) {
      let child = node.children[i]
      if (child.nodeType == 'ListItem' || child.nodeType == 'TaskListItem') {
        itemIdx++
      }
      this.traverse(child, childListDepth, childQuoteDepth, itemIdx)
    }

    // 后处理节点: 尾插换行/空格
    if (node.nodeType == 'Paragraph' || node.nodeType == 'Heading' || node.nodeType == 'IdHeading') {
      this.add("\n")
    } else if (node.nodeType == 'TableRow') {
      this.add("\n")
    } else if (node.nodeType == 'TableCell') {
      this.add(" ")
    }
  }

  /**
   * 处理不需要遍历children的叶子节点
   *
   * @param node 当前节点
   * @returns 是否为叶子节点
   */
  private leafNode(node: NodeView): boolean {
    switch (node.nodeType) {
      case 'Text':
        this.add(node.nodeText)
        return true
      case 'HardLineBreak':
        this.add("\n")
        return true
      case 'SoftLineBreak':
        this.add(" ")
        return true
      case 'Code':
        this.add(node.nodeText)
        return true
      case 'IndentedCodeBlock':
        this.add(node.nodeText)
        this.add("\n")
        return true
      case 'FencedCodeBlock':
        this.add(node.nodeText)
        this.add("\n")
        return true
      case 'HtmlInline':
        this.add(node.nodeText)
        return true
      case 'HtmlBlock':
        this.add(node.nodeText)
        this.add("\n")
        return true
      case 'LatexMathNode':
        this.add(node.nodeText)
        return true
      case 'LatexMathBlock':
        this.add(node.nodeText)
        this.add("\n")
        return true
      default:
        return false
    }
  }

  private add(s: string): void {
    this.builder += s
  }

  private repeatString(s: string, n: number): string {
    let result = ""
    for (let i = 0; i < n; i++) {
      result += s
    }
    return result
  }
}
