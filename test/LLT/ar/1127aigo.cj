// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main --show-all-output
import std.runtime.*

let markdown: Markdown = Markdown
    .builder()
    // aigo
    .usePlugin(AigoPlugin.create())
    .build()

@Test
public func test0(): Unit {
    var str = """
- [aigo:ssssssssssssss]
    asdasd
"""
    let node = markdown.parse(str)
    printNode(node)
    try {
        let nodeView = markdown.render(node)
        printNode(node)
        printNode(nodeView)
    } catch (e: Exception) {
        println(e)
        e.printStackTrace()
    } catch (e: Error) {
        println(e)
        e.printStackTrace()
    }
}

public class AigoPlugin <: AbstractMarkdownPlugin {
    public static func create(): AigoPlugin {
        return AigoPlugin()
    }

    public func configureParser(builder: ParserBuilder): Unit {
        builder.customBlockParserFactory(AigoBlockParserFactory())
    }

    public func configureVisitor(builder: MarkdownVisitorBuilder): Unit {
    }

    public func getClassType(): String {
        "AigoPlugin"
    }
}

public class AigoBlock <: CustomBlock {
    AigoBlock(public let content: String) {}
    public func getNodeType(): String {
        "AigoBlock"
    }
    protected func toStringAttributes(): String {
        return "content=${content}"
    }
}

class AigoBlockParser <: AbstractBlockParser {
    AigoBlockParser(let content: String) {
        block = AigoBlock(content)
    }
    private let block: AigoBlock
    private let paragraph: Paragraph = Paragraph()

    public func getBlock(): Block {
        block
    }

    public func tryContinue(parserState: ParserState): ?BlockContinue {
        None
    }

    public func addLine(line: String): Unit {
    }

    public func closeBlock(): Unit {
    }
}

class AigoBlockParserFactory <: AbstractBlockParserFactory {
    public func tryStart(state: ParserState, _: MatchedBlockParser): ?BlockStart {
        let line: String = state.getLine().getContent()
        let stateLine: String = line[state.getIndex()..]
        println("line: ${line} stateLine:${stateLine} index:${state.getIndex()}")
        if (stateLine.trimAscii().startsWith("[aigo:")) {
            return BlockStart.of(AigoBlockParser(stateLine))//.atIndex(line.size)
        }
        return BlockStart.none()
    }
}

/* 
line: - [aigo:ssssssssssssss] stateLine:- [aigo:ssssssssssssss] index:0
line: - [aigo:ssssssssssssss] stateLine:[aigo:ssssssssssssss] index:2
Document{}
    BulletList{}
        ListItem{}
            AigoBlock{content=[aigo:ssssssssssssss]}
            Paragraph{}
                Text{literal=asdasd}

Document{} view:{Document{}}
    BulletList{} view:{BulletList{}{bulletListDepth:0}}
        ListItem{} view:{ListItem{}{bulletListDepth:0}}
            AigoBlock{content=[aigo:ssssssssssssss]} view:{AigoBlock{content=[aigo:ssssssssssssss]}{bulletListDepth:0}}
            Paragraph{} view:{Paragraph{}{bulletListDepth:0}}
                Text{literal=asdasd} view:{Text{literal=asdasd}{bulletListDepth:0}}

view:{Document{}}
    view:{BulletList{}{bulletListDepth:0}}
        view:{ListItem{}{bulletListDepth:0}}
            view:{AigoBlock{content=[aigo:ssssssssssssss]}{bulletListDepth:0}}
            view:{Paragraph{}{bulletListDepth:0}}
                view:{Text{literal=asdasd}{bulletListDepth:0}}
 */