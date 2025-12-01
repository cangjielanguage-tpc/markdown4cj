/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.plugin

/**
 * 节点树纯文本提取
 */
public class NodeViewStringBuilder <: ToString {
    public NodeViewStringBuilder(let root: NodeView) {}

    let builder = StringBuilder()

    /**
     * 提取纯文本
     * - 处理缩进
     * - 处理行内节点
     * - 处理行内节点间隔
     * - block: 尾插换行
     */
    public func toString(): String {
        if (builder.size == 0) {
            traverse(root)
        }
        return builder.toString()
    }

    // 使用深度优先遍历处理节点树
    func traverse(nodeView: NodeView): Unit {
        let node = nodeView.node

        if (leafNode(node)) {
            return
        }

        // 前处理节点: 前插缩进
        match (node) {
            // 处理列表
            case v: ListItem =>
                if (nodeView.bulletList) {
                    add("  " * nodeView.bulletListDepth)
                } else {
                    add("  " * nodeView.depth).add(nodeView.order).add('. ')
                }
            case v: BlockQuote => add("  " * nodeView.blockQuoteDepth)
            case _ => ()
        }

        // 处理子节点
        for (child in nodeView.children) {
            traverse(child)
        }

        // 后处理节点: 尾插换行/空格
        match (node) {
            case v: DescList => ()
            case v: DescTerm => ()
            case v: DescDef => ()
            case v: Paragraph => add("\n")
            case v: Heading => add("\n")
            case v: TableRow => add("\n")
            case v: TableCell => add(" ")
            case _ => ()
        }
    }

    /*
     * 处理不需要遍历children的节点
     */
    func leafNode(node: Node): Bool {
        match (node) {
            case v: Text => add(v.getLiteral())
            case v: HardLineBreak => add("\n")
            case v: SoftLineBreak => add(" ")
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