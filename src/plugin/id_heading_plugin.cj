package markdown_parser.plugin

/**
 * 标题编号
 */
public class IdHeadingPlugin <: AbstractMarkdownPlugin {
    public static func create(): IdHeadingPlugin {
        return IdHeadingPlugin()
    }
    public func configureParser(parser: ParserBuilder): Unit {
        parser.postProcessor(IdHeadingProcessor())
    }

    public func getClassType(): String {
        "IdHeadingPlugin"
    }
}

public class IdHeading <: Heading {
    public var id: String = ''
    public func toStringAttributes(): String {
        return "id=${id},level=${getLevel()}"
    }
    public func getNodeType(): String {
        "IdHeading"
    }
}

class IdHeadingProcessor <: PostProcessor {
    public func process(node: Node): Node {
        node.accept(IdHeadingVisitor())
        return node
    }
}

class IdHeadingVisitor <: AbstractVisitor {
    let links = ArrayList<HeadLink>()
    let headings = HashMap<String, Int>()
    let collector = HeadTextCollector()
    public func visit(n: Document): Unit {
        var blockIndex = -1
        for (block in n.iterateChildren()) {
            blockIndex++
            match (block) {
                case h: Heading =>
                    if (let Some(t: Text) <- h.getLastChild()) {
                        let text = t.getLiteral()
                        for (i in 0..text.size - 3) {
                            if (text[i] == b'{' && text[i + 1] == b'#' && text[text.size - 1] == b'}') {
                                let id = text[i + 2..text.size - 1]
                                let idh = IdHeading()
                                idh.id = id
                                idh.setLevel(h.getLevel())
                                h.replaceWith(idh)
                                t.setLiteral(text[0..i])
                                headings.add(id, blockIndex)
                                continue
                            }
                        }
                    }
                    h.accept(collector)
                    let id = collector.reset()
                    headings.add(id, blockIndex)
                case _ => visitChildren(block)
            }
        }
        for (link in links) {
            let id = link.getDestination()[1..]
            if (let Some(i) <- headings.get(id)) {
                link.headIndex = i
            }
        }
    }
    public func visit(n: Link): Unit {
        let dest = n.getDestination()
        if (dest.startsWith("#")) {
            let hl = HeadLink(-1, dest, n.getTitle())
            n.replaceWith(hl)
            links.add(hl)
        }
    }
}
