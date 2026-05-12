package markdown.plugin

public class TocPlugin <: AbstractMarkdownPlugin {
    public static func create(): TocPlugin {
        return TocPlugin()
    }
    public func configureParser(builder: ParserBuilder): Unit {
        let needReplace = ArrayList<TocBlock>()
        builder.customBlockParserFactory(TocBlockParserFactory(needReplace))
        builder.postProcessor(TocPostProcessor(needReplace))
    }

    public func configureVisitor(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            HeadLink.typeInfo,
            {
                visitor, node =>
                visitor.visitChildren(node)
            }
        )
    }

    public func getClassType(): String {
        "TocPlugin"
    }
}

class TocPostProcessor <: PostProcessor {
    TocPostProcessor(let needReplace: ArrayList<TocBlock>) {}
    public func process(node: Node): Node {
        let tocNode = buildToc(node)
        if (let Some(v) <- needReplace.get(0)) {
            v.replaceWith(tocNode)
        }
        for (i in 1..needReplace.size) {
            needReplace[i].replaceWith(deepClone(tocNode))
        }
        needReplace.clear()
        return node
    }

    func buildToc(root: Node): Node {
        let collector = HeadTextCollector()

        let head0 = HeadTree(Heading(), "0", -1)
        var tree = head0
        var tmp: ?Node = root.getFirstChild()
        var index = -1
        while (let Some(v) <- tmp) {
            index++
            tmp = v.getNext()
            if (let Some(head) <- (v as Heading)) {
                head.accept(collector)
                let headText = collector.reset()
                let current = HeadTree(head, headText, index)
                let lastLevel = tree.head.getLevel()
                let thisLevel = head.getLevel()
                if (thisLevel > lastLevel) {
                    tree.appendChildTree(current)
                } else if (lastLevel == thisLevel) {
                    tree.insertAfterTree(current)
                } else if (thisLevel < lastLevel) {
                    while (let Some(v: HeadTree) <- tree.getParent()) {
                        if (thisLevel > v.head.getLevel()) {
                            v.appendChildTree(current)
                            break
                        }
                        tree = v
                    }
                }
                tree = current
            }
        }

        return head0.item_list
    }
}

class HeadTextCollector <: AbstractVisitor {
    let text = StringBuilder()
    public func visit(node: Text): Unit {
        text.append(node.getLiteral())
    }
    public func visit(node: Code): Unit {
        text.append(node.getLiteral())
    }
    func reset(): String {
        let str = text.toString()
        text.reset()
        return str
    }
}

public class HeadLink <: Link {
    static let typeInfo = "HeadLink"
    public var headIndex: Int
    init(headIndex: Int, dest: String, title: ?String) {
        super(dest, title)
        this.headIndex = headIndex
    }

    protected func toStringAttributes(): String {
        return "headIndex=${headIndex},destination=${getDestination()},title=${getTitle()}"
    }

    public func getNodeType(): String {
        return typeInfo
    }
}

class HeadTree <: CustomBlock {
    let item: ListItem = ListItem()
    let item_p = Paragraph()
    var item_list_v: ?OrderedList = None
    prop item_list: OrderedList {
        get() {
            if (let Some(v) <- item_list_v) {
                return v
            }  else {
                let v = OrderedList(1, r'.')
                this.item_list_v = v
                this.item.appendChild(v)
                return v
            }
        }
    }
    HeadTree(let head: Heading, let text: String, let headIndex: Int) {
        let link = HeadLink(headIndex, "#${text}", text)
        let textNode = Text(text)
        link.appendChild(textNode)
        item_p.appendChild(link)
        item.appendChild(item_p)
    }
    func appendChildTree(n: HeadTree): Unit {
        item_list.appendChild(n.item)
        appendChild(n)
    }
    func insertAfterTree(n: HeadTree): Unit {
        item.insertAfter(n.item)
        insertAfter(n)
    }
    public func getNodeType(): String {
        "HeadTree"
    }
}

func deepClone(node: Node): Node {
    let clone: Node = match (node) {
        case v: OrderedList => OrderedList(v.getStartNumber(), v.getDelimiter())
        case _: ListItem => ListItem()
        case _: Paragraph => Paragraph()
        case v: HeadLink => HeadLink(v.headIndex, v.getDestination(), v.getTitle())
        case v: Text => Text(v.getLiteral())
        case _ => throw Exception("unsupport")
    }
    for (n in node.iterateChildren()) {
        clone.appendChild(deepClone(n))
    }
    return clone
}

class TocBlockParserFactory <: BlockParserFactory {
    TocBlockParserFactory(let needReplace: ArrayList<TocBlock>) {}
    public func tryStart(state: ParserState, _: MatchedBlockParser): Option<BlockStart> {
        if (state.getIndent() >= Parsing.CODE_BLOCK_INDENT) {
            return BlockStart.none()
        }
        var line = state.getLine().getContent()
        let index = state.getIndex()
        line = line[index..]
        if (line.replace(' ', '').toAsciiUpper() == "[TOC]") {
            return BlockStart.of(TocBlockParser(needReplace))
        }
        return BlockStart.none()
    }
}

class TocBlockParser <: AbstractBlockParser {
    TocBlockParser(let needReplace: ArrayList<TocBlock>) {}
    let block = TocBlock()
    public func getBlock(): Block {
        return block
    }
    public func tryContinue(_: ParserState): Option<BlockContinue> {
        return None
    }
    public func closeBlock(): Unit {
        return needReplace.add(block)
    }
}

class TocBlock <: CustomBlock {
    public func getNodeType(): String {
        return "TocBlock"
    }
}
