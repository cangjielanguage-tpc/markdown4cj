package markdown.plugin

/**
 * 节点树纯文本提取
 */
public class NodeViewStringBuilder <: ToString {
    public NodeViewStringBuilder(let root: Node, let codeBlockIsSeparate: Bool) {}

    let builder = StringBuilder()

    /**
     * 提取纯文本
     * - 处理缩进
     * - 处理行内节点
     * - 处理行内节点间隔
     * - block: 尾插换行
     * - codeBlockIsSeparate: 单独代码块模式下，仅复制第一个代码块节点；第一个节点不是代码块则为空
     */
    public func toString(): String {
        if (builder.size == 0) {
            if (codeBlockIsSeparate) {
                // 单独代码块模式: 页面仅显示第一条代码块，全文复制也只复制第一个节点
                if (let Some(firstChild) <- root.getFirstChild()) {
                    if (firstChild is FencedCodeBlock || firstChild is IndentedCodeBlock) {
                        traverse(firstChild)
                    }
                    // 第一个节点不是代码块，直接为空
                }
            } else {
                traverse(root)
            }
        }
        return builder.toString()
    }

    // 使用深度优先遍历处理节点树
    func traverse(nodeView: Node): Unit {
        let node = nodeView

        if (leafNode(node)) {
            return
        }

        // 前处理节点: 前插缩进
        match (node) {
            // 处理列表
            case v: ListItem =>
                add("  " * v.listItemDepth())
                if (let Some(_: OrderedList) <- v.getParent()) {
                    add(v.listItemIndex()).add('. ')
                }
            case v: BlockQuote => add("  " * v.blockQuoteDepth())
            case _ => ()
        }

        // 处理子节点
        for (child in nodeView.iterateChildren()) {
            traverse(child)
        }

        // 后处理节点: 尾插换行/空格
        match (node) {
            case _: DescList => ()
            case _: DescTerm => ()
            case _: DescDef => ()
            case _: Paragraph => add("\n")
            case _: Heading => add("\n")
            case _: TableRow => add("\n")
            case _: TableCell => add(" ")
            case _ => ()
        }
    }

    /*
     * 处理不需要遍历children的节点
     */
    func leafNode(node: Node): Bool {
        match (node) {
            case v: Text => add(v.getLiteral())
            case _: HardLineBreak => add("\n")
            case _: SoftLineBreak => add(" ")
            // 处理Code节点
            case v: Code => add(v.getLiteral())
            case v: IndentedCodeBlock => add(v.getLiteral()).add("\n")
            case v: FencedCodeBlock => add(v.getLiteral()).add("\n")
            // 处理Html节点
            case v: HtmlInline => add(v.getLiteral())
            case v: HtmlBlock => add(v.getLiteral()).add("\n")
            // 处理latex
            case v: LatexMathNode => add(v.latex)
            case v: LatexMathBlock => add(v.latex).add("\n")
            case _ => return false
        }
        return true
    }

    func add(s: ToString): This {
        builder.append(s.toString())
        this
    }
}
