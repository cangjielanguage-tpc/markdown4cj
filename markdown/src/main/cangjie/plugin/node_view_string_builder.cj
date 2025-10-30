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
     * - 处理换行
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
        match (node) {
            // 处理Paragraph
            case v: Paragraph => add("\n")
            case v: Text => add(v.getLiteral())
            case v: HardLineBreak => add("\n")
            case v: SoftLineBreak => add(" ")
            // 处理Heading
            case v: Heading => add(" ")
            // 处理Code节点
            case v: Code => add(v.getLiteral())
            case v: IndentedCodeBlock => add("\n").add(v.getLiteral())
            case v: FencedCodeBlock => add("\n").add(v.getLiteral())
            // 处理Html节点
            case v: HtmlInline => add(v.getLiteral())
            case v: HtmlBlock => add("\n").add(v.getLiteral())
            case v: FencedCodeBlock => add("\n").add(v.getLiteral())
            // 处理latex
            case v: LatexMathNode => add(v.latex)
            case v: LatexMathBlock => add("\n").add(v.latex)
            // 处理table
            case v: TableRow => add("\n")
            case v: TableCell => add(" ")
            // 处理列表
            case v: ListItem =>
                if (nodeView.bulletList) {
                    add("  " * nodeView.bulletListDepth)
                } else {
                    add("  " * nodeView.depth).add(nodeView.order).add('. ')
                }
            case v: BlockQuote => add("\n").add("  " * nodeView.blockQuoteDepth)
            case _ => println("ignore node: ${node}")
        }

        for (child in nodeView.children) {
            traverse(child)
        }
    }
    func add(s: ToString): This {
        builder.append(s.toString())
        this
    }
}
