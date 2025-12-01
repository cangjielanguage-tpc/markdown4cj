/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.plugin

/**
 * 根据节点树的内容计算Block节点的id
 * blockid存于NodeView
 * 要求所有节点关系/内容不再更改 因此必须在最后加载此插件
 */
public class NodeIdPlugin <: AbstractMarkdownPlugin {
    public static func create(): NodeIdPlugin {
        return NodeIdPlugin()
    }

    public override func afterRender(doc: Node, _: MarkdownVisitor): Unit {
        let view = doc.getView()
        calcNodeIdWithLoop(view)
    }

    public func getClassType(): String {
        "NodeIdPlugin"
    }

    let stack = ArrayList<NodeHashCalculator>()

    func calcNodeIdWithLoop(rootNode: NodeView): Unit {
        stack.add(NodeHashCalculator(rootNode, None, 0))

        while (stack.size > 0) {
            let parent = stack[stack.size - 1]
            let childIndex = parent.childIndex
            if (childIndex < parent.node.children.size) {
                let child = parent.node.children[childIndex]
                let childHasher = NodeHashCalculator(child, parent, childIndex)
                if (child.children.size > 0) {
                    // 保存当前状态，然后处理子节点
                    stack.add(childHasher)
                } else {
                    // 没有子节点
                    childHasher.finish()
                }
            } else {
                // 所有子节点处理完毕，处理父节点
                parent.finish()
                stack.remove(at: stack.size - 1)
            }
        }
    }
}

/**
 * 用于计算node的nodeHash/contentHash
 * init时
 *     - 计算nodeHash
 * finish时
 *     - 写入nodeHash/contentHash
 *     - 更新parent.contentHash
 *     - 更新parent的childIndex
 */
class NodeHashCalculator {
    var childIndex = 0 // 当前遍历到node的第几个子节点
    var nodeHasher = DefaultHasher() // 用于计算node的nodeHash
    var posionHasher = DefaultHasher() // 用于计算node的posistion的nodeHash
    var contentHasher = DefaultHasher() // 用于计算node的contentHash
    NodeHashCalculator(
        let node: NodeView, /* 当前节点 */
        let parent: ?NodeHashCalculator, /* 父节点 */
        let index: Int /* node属于parent的第几个子节点 */
    ) {
        // 根据parent.position/index 计算position
        posionHasher.write(parent?.posionHasher.finish() ?? 0)
        posionHasher.write(index)

        // 根据node.porpString 计算基础contentHash
        contentHasher.write(match (node.node) {
            case v: NodeHash => v.propString()
            case _ => node.toString()
        })

        // 根据position/NodeType 计算nodeHash
        nodeHasher.write(posionHasher.finish())
        nodeHasher.write(node.node.getNodeType())
    }

    /**
     * 累加contentHash
     */
    @OverflowWrapping
    func accumulate(hash: Int): Unit {
        this.contentHasher.write(hash)
    }

    /**
     * 写入nodeHash/contentHash
     * 将node.contentHash累加到parent.contentHash
     * 更新parent.childIndex
     */
    func finish(): Unit {
        node.nodeHash = nodeHasher.finish()
        node.contentHash = contentHasher.finish()
        if (let Some(p) <- parent) {
            p.accumulate(contentHasher.finish())
            p.childIndex += 1
        }
    }
}
