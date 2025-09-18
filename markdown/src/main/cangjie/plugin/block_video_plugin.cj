/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.plugin

public class BlockVideoPlugin <: AbstractMarkdownPlugin {
    public static func create(): BlockVideoPlugin {
        return BlockVideoPlugin()
    }

    public func getClassType(): String {
        "BlockVideoPlugin"
    }

    public override func configureParser(builder: ParserBuilder): Unit {
        builder.postProcessor(BlockVideoProcessor())
    }
}

class BlockVideoProcessor <: PostProcessor {
    public func process(node: Node): Node {
        node.accept(BlockVideoVisitor())
        node
    }
}

func isVideo(destination: String): Bool {
    var k = destination.lastIndexOf(b'?') ?? destination.size
    let dest = destination[..k]
    let i = dest.lastIndexOf(b'.') ?? return false
    return match (dest[i..]) {
        case '.mp4' | '.mov' | '.avi' | '.mkv' | '.wmv' | '.flv' | '.webm' | '.m4v' | '.3gp' => return true
        case _ => false
    }
}

class BlockVideoVisitor <: AbstractVisitor {
    public func visit(p: Heading): Unit {
        visit(
            p,
            {
                =>
                let h = Heading()
                h.setLevel(p.getLevel())
                return h
            }
        )
    }
    public func visit(p: Paragraph): Unit {
        visit(p, {=> Paragraph()})
    }
    public func visit(blockNode: Node, newBlock: () -> Node): Unit {
        var p = blockNode
        var current: ?Node = p.getFirstChild()
        while (let Some(n) <- current) {
            current = n.getNext()
            match (n) {
                case n: Image where isVideo(n.getDestination()) =>
                    let oldp = p
                    // 提取Video
                    n.unlink()
                    let block = BlockVideo()
                    block.appendChild(n)
                    p.insertAfter(block)
                    // 分割后续paragraph.children
                    if (let Some(c) <- current) {
                        let newp = newBlock()
                        var n1: ?Node = current
                        while (let Some(n11) <- n1) {
                            n1 = n11.getNext()
                            n11.unlink()
                            newp.appendChild(n11)
                        }
                        block.insertAfter(newp)
                        p = newp
                    }
                    // 清理空p
                    if (oldp.getFirstChild().isNone()) {
                        oldp.unlink()
                    }
                case _ => ()
            }
        }
    }
}

public class BlockVideo <: CustomBlock {
    public func getNodeType() {
        "BlockVideo"
    }
}
