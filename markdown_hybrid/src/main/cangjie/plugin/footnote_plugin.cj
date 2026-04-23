package markdown.plugin

public class FootnotePlugin <: AbstractMarkdownPlugin {
    public static func create(): FootnotePlugin {
        return FootnotePlugin()
    }

    public func configureParser(builder: ParserBuilder): Unit {
        builder.customBlockParserFactory(FootnoteBlockParserFactory())
        builder.postProcessor(FootnotePostProcessor())
    }

    public func configureVisitor(_: MarkdownVisitorBuilder): Unit {
    }

    public func getClassType(): String {
        "FootnotePlugin"
    }
}

public class Footnote <: CustomNode {
    Footnote(public let noteid: String) {}
    public var block: ?FootnoteBlock = None
    public func getNodeType(): String {
        "Footnote"
    }
    protected func toStringAttributes(): String {
        return "noteid=${noteid},blockIndex=${block?.blockIndex}"
    }
}

public class FootnoteBlock <: CustomBlock {
    FootnoteBlock(public let noteid: String) {}
    public var blockIndex: Int64 = -1
    public func getNodeType(): String {
        "FootnoteBlock"
    }
    protected func toStringAttributes(): String {
        return "noteid=${noteid},blockIndex=${blockIndex}"
    }
}

class FootnoteBlockParser <: AbstractBlockParser {
    FootnoteBlockParser(let title: String, let line: SourceLine) {
        block = FootnoteBlock(title)
        block.appendChild(paragraph)
    }
    private let block: FootnoteBlock
    private let paragraph: Paragraph = Paragraph()

    public func getBlock(): Block {
        block
    }

    public func tryContinue(_: ParserState): ?BlockContinue {
        None
    }

    public func addLine(_: SourceLine): Unit {}
    public func parseInlines(inlineParser: InlineParser): Unit {
        inlineParser.parse(SourceLines.of(line), paragraph)
    }

    public func closeBlock(): Unit {
    }
}

class FootnoteBlockParserFactory <: AbstractBlockParserFactory {
    static let FOOTNOTE_BLOCK = Regex(#"^\[\^.+?\]:"#)
    public func tryStart(state: ParserState, _: MatchedBlockParser): ?BlockStart {
        let sl = state.getLine()
        let sline = sl.getContent()
        let line: String = sline[state.getIndex()..]
        if (let Some(pos) <- FOOTNOTE_BLOCK.find(line)?.matchPosition()) {
            return BlockStart
                .of(FootnoteBlockParser(line[2..pos.end - 2], sl.substring(sline.size - line.size + pos.end, sline.size)))
                .atIndex(state.getIndex() + pos.end)
        }
        return BlockStart.none()
    }
}

class FootnotePostProcessor <: PostProcessor {
    public func process(node: Node): Node {
        node.accept(FootnoteVisitor())
        return node
    }
}

/* 生成Footnode 关联FootnodeBlock FootnodeBlock生成定位序号 */
class FootnoteVisitor <: AbstractVisitor {
    let notes = ArrayList<Footnote>()
    let blockMap = HashMap<String, FootnoteBlock>()
    static let FOOTNOTE = Regex(#"\[\^.+?\]"#)
    public func visit(n: Document): Unit {
        visitChildren(n)
        for (footnote in notes) {
            let block = blockMap.get(footnote.noteid) ?? continue
            footnote.block = block
        }
    }
    public func visit(n: CustomBlock): Unit {
        match (n) {
            case f: FootnoteBlock =>
                var preSize = 0
                var pnode: Node = f
                while (let Some(v) <- pnode.getPrevious()) {
                    preSize++
                    pnode = v
                }
                f.blockIndex = preSize
                blockMap.add(f.noteid, f)
            case _ => ()
        }
        visitChildren(n)
    }
    public func visit(n: Text): Unit {
        let line = n.getLiteral()
        var i = 0
        for (data in FOOTNOTE.findAll(line)) {
            let pos = data.matchPosition()
            if (i < pos.start) {
                let text = Text(line[i..pos.start])
                n.insertBefore(text)
            }
            let footnote = Footnote(line[pos.start + 2..pos.end - 1])
            n.insertBefore(footnote)
            notes.add(footnote)
            i = pos.end
        }
        n.setLiteral(line[i..])
        if (n.getLiteral().isEmpty()) {
            n.unlink()
        }
    }
}
