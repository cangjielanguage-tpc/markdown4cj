/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.plugin

/**
 * 根据节点树的内容计算Block节点的id
 * blockid存于NodeView
 * 要求所有节点关系/内容不再更改 因此必须在最后加载此插件
 */
public class BlockIdPlugin <: AbstractMarkdownPlugin {
    public static func create(): BlockIdPlugin {
        return BlockIdPlugin()
    }

    public override func afterRender(doc: Node, _: MarkdownVisitor): Unit {
        let view = doc.getView()
        calcNodeIdWithLoop(view)
    }

    public func getClassType(): String {
        "BlockIdPlugin"
    }

}

func calcNodeIdWithLoop(rootNode: NodeView): Unit {
    let stack = ArrayList<HashCalcular>()
    stack.append(HashCalcular(rootNode, None))

    while (stack.size > 0) {
        let parent = stack[stack.size - 1]
        if (parent.childIndex < parent.node.children.size) {
            let child = parent.node.children[parent.childIndex]
            let childHasher = HashCalcular(child, parent)
            if (child.children.size > 0) {
                // 保存当前状态，然后处理子节点
                stack.append(childHasher)
            } else {
                // 没有子节点
                childHasher.finish()
            }
        } else {
            // 所有子节点处理完毕，处理父节点
            parent.finish()
            stack.remove(stack.size - 1)
        }
    }
}

func calcNodeId(instance: NodeView): Int {
    let str = match (instance.node) {
        case v: NodeHash => v.nodeHash()
        case _ => instance.toString()
    }
    str.hashCode()
}

class HashCalcular {
    var hashTotal = 17
    var childIndex = 0
    HashCalcular(let node: NodeView, let parent: ?HashCalcular) {
        accumulate(calcNodeId(node))
    }

    @OverflowWrapping
    func accumulate(hash: Int): Unit {
        this.hashTotal = this.hashTotal * 31 + hash
    }
    func finish(): Unit {
        node.addProp("nodeid", hashTotal)
        if (let Some(p) <- parent) {
            p.accumulate(hashTotal)
            p.childIndex += 1
        }
    }
}
