package markdown.plugin

/**
 * 去除图文混排插件
 */
public class ImageTextMixPlugin <: AbstractMarkdownPlugin {
    public static func create(): ImageTextMixPlugin {
        return ImageTextMixPlugin()
    }

    public func configureParser(builder: ParserBuilder): Unit {
        builder.postProcessor(ImageTextMixPostProcessor())
    }

    public func getClassType(): String {
        "ImageTextMixPlugin"
    }
}

class ImageTextMixPostProcessor <: PostProcessor {
    public func process(node: Node): Node {
        node.accept(ImageTextMixVisitor())
        return node
    }
}

class ImageTextMixVisitor <: AbstractVisitor {
    public func visit(heading: Heading): Unit {
        let her: () -> Node = {
            =>
                let h = Heading()
                h.setLevel(heading.getLevel())
                h
        }
        splitChildren(heading, {n => n is Image && n.getNodeType().endsWith("Image")}, her, her)
    }
    public func visit(p: Paragraph): Unit {
        splitChildren(p, {n => n is Image && n.getNodeType().endsWith("Image")}, {=> Paragraph()}, {=> Paragraph()})
    }
}
/**
 * Block切割
 * @param srcNode 源节点
 * @param splitMatcher 切割条件
 * @param nodeParentFactory 保存切出来的普通节点
 * @param spliterParentFactory 保存切出来的spliter节点
 */
func splitChildren(
    srcNode: Node,
    splitMatcher: (Node) -> Bool,
    nodeParentFactory: () -> Node,
    spliterParentFactory: () -> Node
): Unit {
    if ((srcNode.getFirstChild()?.getNext()).flatten().isNone()) {
        // 子节点数量 <= 1
        return
    }
    var lastBlock: ?Node = None
    var splitMatched = false // 是否触发切割
    var lastBlockIsSpliter = false
    var current: ?Node = srcNode.getFirstChild()
    while (let Some(n) <- current) {
        current = n.getNext()
        if (splitMatcher(n)) {
            // status change
            splitMatched = true
            if (lastBlock.isNone()) {
                lastBlock = srcNode
            }
            // 提取spliter节点
            n.unlink()
            let spliterParent = spliterParentFactory()
            spliterParent.appendChild(n)
            lastBlock?.insertAfter(spliterParent)
            // 处理lastBlock
            lastBlock = spliterParent
            lastBlockIsSpliter = true
        } else {
            if (splitMatched) {
                // 提取非spliter节点
                if (lastBlockIsSpliter) {
                    let nodeParent = nodeParentFactory()
                    lastBlock?.insertAfter(nodeParent)
                    lastBlock = nodeParent
                    lastBlockIsSpliter = false
                }
                n.unlink()
                lastBlock?.appendChild(n)
            }
        }
    }
    if (srcNode.getFirstChild().isNone()) {
        // 如果srcNode已空 将sourcespan信息移动到下一个节点
        let n = srcNode.getNext()
        for (ss in srcNode.getSourceSpans()) {
            n?.addSourceSpan(ss)
        }
        srcNode.unlink()
    }
}
