package markdown_parser.plugin

/**
 * 根据节点树的内容计算Block节点的id
 * blockid存于NodeView
 * 要求所有节点关系/内容不再更改 因此必须在最后加载此插件
 */
public class NodeIdPlugin <: AbstractMarkdownPlugin {
    public static func create(): NodeIdPlugin {
        return NodeIdPlugin(true, true)
    }

    NodeIdPlugin(let needNodeHash: Bool, let needContentHash: Bool) {}

    public override func afterRender(doc: Node, _: MarkdownVisitor): Unit {
        calcNodeId(doc)
    }

    public func getClassType(): String {
        "NodeIdPlugin"
    }

    let stack = ArrayList<NodeHashCalculator>()

    func calcNodeId(rootNode: Node): Unit {
        stack.add(NodeHashCalculator(rootNode, None, 0, needNodeHash, needContentHash))
        calcNodeIdWithStack(stack, needNodeHash, needContentHash)
    }
}

public func calcNodeIdWithStack(stack: ArrayList<NodeHashCalculator>, needNodeHash: Bool, needContentHash: Bool): Unit {
    while (stack.size > 0) {
        let parent = stack[stack.size - 1]
        let childIndex = parent.childIndex
        if (let Some(child) <- parent.child) {
            let childHasher = NodeHashCalculator(child, parent, parent.childIndex, needNodeHash, needContentHash)
            if (child.getFirstChild().isSome()) {
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
/**
 * 用于计算node的nodeHash/contentHash
 * init时
 *     - 计算nodeHash
 * finish时
 *     - 写入nodeHash/contentHash
 *     - 更新parent.contentHash
 *     - 更新parent的childIndex
 */
public class NodeHashCalculator {
    public var child: ?Node = None // 当前遍历到node的第几个子节点
    public var childIndex: Int64 = 0 // 当前遍历到node的第几个子节点
    public var nodeHasher: DefaultHasher = DefaultHasher() // 用于计算node的nodeHash
    public var posionHasher: DefaultHasher = DefaultHasher() // 用于计算node的posistion的nodeHash
    public var contentHasher: DefaultHasher = DefaultHasher() // 用于计算node的contentHash
    public NodeHashCalculator(
        let node: Node, /* 当前节点 */
        let parent: ?NodeHashCalculator, /* 父节点 */
        let index: Int, /* node属于parent的第几个子节点 */
        let needNodeHash: Bool,
        let needContentHash: Bool
    ) {
        child = node.getFirstChild()
        if (needNodeHash) {
            // 根据parent.position/index 计算position
            posionHasher.write(parent?.posionHasher.finish() ?? 0)
            posionHasher.write(index)

            // 根据position/NodeType 计算nodeHash
            nodeHasher.write(posionHasher.finish())
            nodeHasher.write(node.getNodeType())
        }
        if (needContentHash) {
            // 根据node.porpString 计算基础contentHash
            contentHasher.write(match (node) {
                case v: NodeHash => v.propString()
                case _ => node.toString()
            })
        }
    }

    /**
     * 累加contentHash
     */
    @OverflowWrapping
    func accumulate(hash: Int): Unit {
        if (needContentHash) {
            this.contentHasher.write(hash)
        }
    }

    /**
     * 写入nodeHash/contentHash
     * 将node.contentHash累加到parent.contentHash
     * 更新parent.childIndex
     */
    public func finish(): Unit {
        if (needNodeHash) {
            node.addProp("nodeHash", nodeHasher.finish())
        }
        if (needContentHash) {
            node.addProp("contentHash", contentHasher.finish())
        }
        if (let Some(p) <- parent) {
            p.accumulate(contentHasher.finish())
            p.child = node.getNext()
            p.childIndex += 1
        }
    }
}
