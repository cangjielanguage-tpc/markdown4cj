package markdown.plugin
internal import commonmark4cj.commonmark.Text as CommonmarkText
internal import commonmark4cj.commonmark.Node as CommonmarkNode

public class BlockCustomCardPlugin <: AbstractMarkdownPlugin {

    public static func create():BlockCustomCardPlugin {
        return BlockCustomCardPlugin()
    }

    public func getClassType(): String {
        "BlockCustomCardPlugin"
    }

    public override func configureParser(builder: ParserBuilder): Unit {
        builder.postProcessor(BlockCustomCardProcessor())
    }
}

class BlockCustomCardProcessor <: PostProcessor {

    public func process(node: Node): Node {
        node.accept(BlockCustomCardVisitor())
        node
    }
}


func getAltText(n: Node): String {
        let altTextBuilder = StringClass()
        n.iterateChildren().forEach({
            child: CommonmarkNode =>
                if (child is CommonmarkText) {
                    altTextBuilder.addString((child as CommonmarkText)().getLiteral())
                }
        })
        let altText = altTextBuilder.str.trimAscii()
        return altText
}



func isRightImg(str:String,blockImage:?(String) -> Bool):Bool{
    if (let Some(v) <- blockImage) {
        return v(str)
    }
    return false
}

//评分：[](star_5 "rating")

func isRightLink(str:String,blockLink:?(String) -> Bool):Bool{
     if (let Some(v) <- blockLink) {
        return v(str)
    }
    return false
}




class BlockCustomCardVisitor <: AbstractVisitor {

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
                case n: Image where isRightImg(getAltText(n),customCardCondition.mBlockImage) =>
                    let oldp = p
                    // 提取Video
                    n.unlink()
                    let block = CustomCardImage()
                    block.appendChild(n)
                    block.setSourceSpans(n.getSourceSpans())
                    p.insertAfter(block)
                    // 分割后续paragraph.children
                    if (let Some(_) <- current) {
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
                case n: Link where isRightLink(n.getDestination(),customCardCondition.mBlockLink) =>
                    let oldp = p
                    // 提取Video
                    n.unlink()
                    let block = CustomCardLink()
                    block.appendChild(n)
                    block.setSourceSpans(n.getSourceSpans())
                    p.insertAfter(block)
                    // 分割后续paragraph.children
                    if (let Some(_) <- current) {
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

public class CustomCardImage <: CustomBlock {
    public func getNodeType(): String {
        "CustomCardImage"
    }
}

public class CustomCardLink <: CustomBlock {
    public func getNodeType(): String {
        "CustomCardLink"
    }
}


/**
 * 文本对象
 */
public class StringClass {
    var str: String = "" // 文本内容

    func addString(s: String): Unit {
        str = str + s
    }
}
