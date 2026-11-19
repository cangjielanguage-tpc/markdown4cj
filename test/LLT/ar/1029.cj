// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: pwsh -command "cp ../../../target/release/markdown_parser/*.dll ."
// EXEC: pwsh -command "cp ../../../target/release/commonmark4cj/*.dll ."
// EXEC: ./main
import std.runtime.*

let markdown: Markdown = Markdown
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
    .usePlugin(NodeIdPlugin.create())
    .usePlugin(LinkifyPlugin.create())
    .usePlugin(ImageTextMixPlugin.create())
    .usePlugin(TocPlugin.create())
    .usePlugin(IdHeadingPlugin.create())
    .usePlugin(DescListPlugin.create())
    .build()

@Test
public func test0(): Unit {
    var str = #"

dt0
dt1
: dd1
dd11
: dd2

dt3
: dd3
"#
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
/* 
public class DescListPlugin <: AbstractMarkdownPlugin {
    public static func create(): DescListPlugin {
        return DescListPlugin()
    }
    public func configureParser(builder: ParserBuilder): Unit {
        builder.customBlockParserFactory(DescListParserFactory())
    }

    public func configureVisitor(builder: MarkdownVisitorBuilder): Unit {
    }

    public func getClassType(): String {
        "DescListPlugin"
    }
}

class DescListParserFactory <: BlockParserFactory {
    public func tryStart(state: ParserState, matchedBlockParser: MatchedBlockParser): Option<BlockStart> {
        var indent: Int64 = state.getIndent()
        if (state.getIndent() >= Parsing.CODE_BLOCK_INDENT) {
            return BlockStart.none()
        }
        let paragraphLines = matchedBlockParser.getParagraphContent() ?? return None
        let line = state.getLine().trimLeft()
        var matched: AbstractBlockParser = matchedBlockParser.getMatchedBlockParser()
        println(
            "1.0 matchedBlockParser.getMatchedBlockParser():${TypeInfo.of(matchedBlockParser.getMatchedBlockParser())}")
        println("1.1 matchedBlockParser.getParagraphContent():${paragraphLines}")
        println("1.2 state.getLine():${state.getLine()}")
        println("1.3 matchedBlockParser:${TypeInfo.of(matched)}")
        if (line.startsWith(": ")) {
            return BlockStart.of(DescListParser(paragraphLines)).replaceActiveBlockParser()
        }
        return BlockStart.none()
    }
}

class DescListParser <: AbstractBlockParser {
    let block = DescList()
    let ddstr = ArrayList<String>()
    DescListParser(let dt: String) {}
    public func getBlock(): Block {
        return block
    }
    public func addLine(line: String): Unit {
        println('3.3 ${line}')
        let lineTrim = line.trimLeft()
        if (lineTrim.size > 2 && lineTrim.startsWith(": ")) {
            ddstr.append(lineTrim[2..])
        } else if (!line.isBlank()) {
            let lastIndex = ddstr.size - 1
            var str = ddstr[lastIndex]
            ddstr[lastIndex] = "${str}\n${lineTrim}"
        }
    }
    public func tryContinue(state: ParserState): Option<BlockContinue> {
        println('3.4 ${state.getLine()}')
        if (state.isBlank()) {
            return BlockContinue.none()
        } else {
            return BlockContinue.atIndex(state.getIndex())
        }
    }
    public func closeBlock(): Unit {
        println('3.5')
    }
    public func parseInlines(inlineParser: InlineParser): Unit {
        let p = Paragraph()
        inlineParser.parse(dt, p)
        let dtNode = DescTerm()
        dtNode.appendChild(p)
        block.appendChild(dtNode)
        for (dd in ddstr) {
            let p = Paragraph()
            inlineParser.parse(dd, p)
            let ddNode = DescDef()
            ddNode.appendChild(p)
            block.appendChild(ddNode)
        }
        println('3.6')
    }
}

/* dl */
class DescList <: CustomBlock {
    public func getNodeType(): String {
        return "DescList"
    }
}
/* dt */
class DescTerm <: CustomBlock {
    public func getNodeType(): String {
        return "DescTerm"
    }
}
/* dd */
class DescDef <: CustomBlock {
    public func getNodeType(): String {
        return "DescDef"
    }
}
 */