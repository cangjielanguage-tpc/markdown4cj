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

    public open override func afterRender(doc: Node, _: MarkdownVisitor): Unit {
        calcNodeid(doc.getFirstChild(), HashCalcular())
    }

    public func getClassType(): String {
        "BlockIdPlugin"
    }
}

func calcNodeid(node: ?Node, hasher: HashCalcular): Unit {
    let current = node ?? return ()
    // 计算子节点
    calcNodeid(current.getFirstChild(), hasher)
    // 计算当前节点 只与children/current相关
    let currentId = caclNodeId(current)
    hasher.accumulate(currentId)
    current.getView().addProp("nodeid", hasher.hashTotal)
    // 使用新HashCalcular计算next节点
    let next = current.getNext()
    let nextHasher = HashCalcular()
    calcNodeid(next, nextHasher)
    // 同级节点hash归一
    hasher.accumulate(nextHasher.hashTotal)
}

func caclNodeId(instance: Node): Int {
    let str = match (instance) {
        case v: NodeHash => v.nodeHash()
        case v: HtmlInline => v.nodeHash()
        case v: Code => v.nodeHash()
        case v: LinkReferenceDefinition => v.nodeHash()
        case v: StrongEmphasis => v.nodeHash()
        case v: Emphasis => v.nodeHash()
        case v: HtmlBlock => v.nodeHash()
        case v: IndentedCodeBlock => v.nodeHash()
        case v: FencedCodeBlock => v.nodeHash()
        case v: Heading => v.nodeHash()
        case v: BulletList => v.nodeHash()
        case v: OrderedList => v.nodeHash()
        case v: Strikethrough => v.nodeHash()
        case v: TableCell => v.nodeHash()
        case v: ImageHtmlNode => v.nodeHash()
        case v: FontNode => v.nodeHash()
        case v: HeadTree => v.nodeHash()
        case _ => instance.toString()
    }
    str.hashCode()
}

class HashCalcular {
    var hashTotal = 17
    @OverflowWrapping
    func accumulate(hash: Int): Unit {
        this.hashTotal = this.hashTotal * 31 + hash
    }
}
