// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
// > ../../1.log
@Test
public func test3(): Unit {
    let md: Markdown = Markdown
        .builder()
        // HTML插件
        .usePlugin(HtmlPlugin.create())
        // 任务列表插件
        .usePlugin(TaskListPlugin.create())
        // 删除线插件
        .usePlugin(StrikethroughPlugin.create())
        // 表格插件
        .usePlugin(TablePlugin.create())
        // 数学公式
        .usePlugin(LatexMathPluginV2.create())
        // 音频
        .usePlugin(BlockAudioPlugin.create())
        // 视频
        .usePlugin(BlockVideoPlugin.create())
        // 链接
        // .usePlugin(LinkViewPlugin.create())
        // 脚注
        .usePlugin(FootnotePlugin.create())
        // 图片列表
        .usePlugin(ImageCollectPlugin.create())
        .build()
    let str = """
Markdown 是一种轻量级标记语言[^1]，由约翰·格鲁伯（John Gruber）于 2004 年创建。

它的设计目标是让文本易读易写，同时支持转换为 HTML 等格式[^2]。

1. [^1]:  *轻量级标*记语言是一类用简单标记代替复杂 HTML 标签的语言。
[^2]: 常见的转换工具包括 Pandoc、Markdown-it 等。

"""
    let node = md.parse(str)
    printNode(node)
    let nodeView = md.render(node)
    printNode(node)
    // printNode(nodeView)
    @Assert(nodeView[2][0][0] is FootnoteBlock)
    @Assert(nodeView[3] is FootnoteBlock)
}

public class FootnotePlugin1 <: AbstractMarkdownPlugin {
    public static func create(): FootnotePlugin1 {
        return FootnotePlugin1()
    }

    public func configureParser(builder: ParserBuilder): Unit {
        builder.customBlockParserFactory(FootnoteBlockParserFactory())
        builder.postProcessor(FootnotePostProcessor())
    }

    public func configureVisitor(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            "Footnote",
            {
                visitor, node => ()
            }
        )
    }

    public func getClassType(): String {
        "FootnotePlugin1"
    }
}

public class Footnote1 <: CustomNode {
    Footnote1(public let noteid: String) {}
    public var block: ?FootnoteBlock1 = None
    public func getNodeType(): String {
        "Footnote"
    }
    protected func toStringAttributes(): String {
        return "noteid=${noteid},blockIndex=${block?.blockIndex}"
    }
}

public class FootnoteBlock1 <: CustomBlock {
    FootnoteBlock1(public let noteid: String) {}
    public var blockIndex = -1
    public func getNodeType(): String {
        "FootnoteBlock1"
    }
    protected func toStringAttributes(): String {
        return "noteid=${noteid},blockIndex=${blockIndex}"
    }
}

class FootnoteBlockParser <: AbstractBlockParser {
    FootnoteBlockParser(let title: String, let line: SourceLine) {
        block = FootnoteBlock1(title)
        block.appendChild(paragraph)
    }
    private let block: FootnoteBlock1
    private let paragraph: Paragraph = Paragraph()

    public func getBlock(): Block {
        //        println("FootnoteBlockParser getBlock ")
        block
    }

    public func tryContinue(parserState: ParserState): ?BlockContinue {
        let line = parserState.getLine()
        //        println("FootnoteBlockParser tryContinue ${line}")
        None
    }

    public func addLine(line: String): Unit {
        //        println("FootnoteBlockParser addLine ${line}")
    }
    public func parseInlines(inlineParser: InlineParser): Unit {
        //        println("FootnoteBlockParser parseInlines ")
        inlineParser.parse(SourceLines.of(line), paragraph)
    }

    public func closeBlock(): Unit {
        //        println("FootnoteBlockParser closeBlock ")
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
    let notes = ArrayList<Footnote1>()
    let blockMap = HashMap<String, FootnoteBlock1>()
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
            case f: FootnoteBlock1 =>
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
        if (let Some(ds) <- FOOTNOTE.matcher(line).findAll()) {
            for (data in ds) {
                let pos = data.matchPosition()
                if (i < pos.start) {
                    let text = Text(line[i..pos.start])
                    n.insertBefore(text)
                }
                let footnote = Footnote1(line[pos.start + 2..pos.end - 1])
                n.insertBefore(footnote)
                notes.add(footnote)
                i = pos.end
            }
            n.setLiteral(line[i..])
        }
        if (n.getLiteral().isEmpty()) {
            n.unlink()
        }
    }
}
