// RESOURCES: spec.md
// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test --debug-macro
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
    .usePlugin(LatexMathPluginV3.create())
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

let sb = StringBuilder()

@Test
public func test3(): Unit {
    var str = #"
设 $V$ 是三维空间中的有界闭区域，其边界 $\\partial V$ 是光滑
"#
    var nv2 = markdown.render(markdown.parse(str))
    printNode(nv2)
    println(sb)

}

public class LatexMathPluginV3 <: AbstractMarkdownPlugin {
    public static func create(): LatexMathPluginV3 {
        return LatexMathPluginV3()
    }

    public func configureParser(builder: ParserBuilder): Unit {
        builder.customBlockParserFactory(LatexBlockParserFactory()) // 块解析
        builder.customInlineContentParserFactory(LatexInlineParserFactory()) // 行内解析
    }

    public func configureVisitor(builder: MarkdownVisitorBuilder): Unit {
        addBlockVisitor(builder)
        addInlineVisitor(builder)
    }

    private func addBlockVisitor(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            "LatexMathBlock",
            {
                visitor, node => ()
            }
        )
    }

    private func addInlineVisitor(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            "LatexMathNode",
            {
                visitor, node => ()
            }
        )
    }

    // @VisibleForTesting
    static func prepareLatexTextPlaceholder(latex: String): String {
        return latex.replace("\n", " ").trimAscii()
    }

    public func getClassType(): String {
        "LatexMathPluginV3"
    }
}

public class LatexInlineParser <: InlineContentParser {
    public func tryParse(inlineParserState: InlineParserState): ParsedInline {
        let scanner: Scanner = inlineParserState.getScanner()
        let p0: SourcePosition = scanner.position()

        let open = scanner.matchMultiple(b'$')
        if (open > 0) {
            let p1 = scanner.position()
            if (scanner.find(b'$') > 0) {
                let p2 = scanner.position()
                let close = scanner.matchMultiple(b'$')
                if (close > 0) {
                    let content = scanner.getSource(p1, p2).getContent()
                    // scanner.next()
                    return ParsedInline.of(LatexMathNode(content), scanner.position())
                }
            }
        } else if (scanner.next('\\(') || scanner.next('\\[')) {
            let p1 = scanner.position()
            var p2 = scanner.position()
            while (scanner.hasNext()) {
                if (scanner.next('\\)') || scanner.next('\\]')) {
                    let content = scanner.getSource(p1, p2).getContent()
                    return ParsedInline.of(LatexMathNode(content), scanner.position())
                } else {
                    scanner.next()
                    p2 = scanner.position()
                }
            }
        }

        scanner.setPosition(p0)
        return ParsedInline.none()
    }
}

public class LatexInlineParserFactory <: InlineContentParserFactory {
    // @Override
    public func getTriggerCharacters(): HashSet<Rune> {
        return HashSet([r'$', r'\\'])
    }

    // @Override
    public func create(): InlineContentParser {
        return LatexInlineParser()
    }
}

class LatexBlockParser <: AbstractBlockParser {
    private let block: LatexMathBlock = LatexMathBlock()
    let builder: StringBuilder = StringBuilder()
    var isSingleLineLatex = false // 处理单行的情况 ^\[latex\]$

    public func getBlock(): Block {
        block
    }

    public func tryContinue(parserState: ParserState): ?BlockContinue {
        let line = parserState.getLine().getContent()[parserState.getIndex()..]
        sb.append("1.1 {${parserState.getLine().getContent()}} {${line}}\n")
        if (isSingleLineLatex) {
            sb.append("1.2\n")
            block.isClosed = true
            return BlockContinue.none()
        }
        if (isLatexLine(line)) {
            sb.append("1.3\n")
        }
        if (isLatexEnd(line)) {
            sb.append("1.4\n")
            block.isClosed = true
        }
        return if (block.isClosed) {
            BlockContinue.finished()
        } else {
            BlockContinue.atIndex(parserState.getIndex())
        }
    }

    public func addLine(sl: SourceLine): Unit {
        let line = sl.getContent()
        sb.append("2.1 {${line}}\n")
        if (isSingleLineLatex) {
            sb.append("2.2\n")
            return
        }
        if (builder.size > 0) {
            sb.append("2.3\n")
            builder.append('\n')
        }
        if (block.isClosed) {
            sb.append("2.4\n")
            let str = line.trimAsciiEnd()
            builder.append(str[..str.size - 2])
        } else {
            sb.append("2.5\n")
            builder.append(line)
        }
    }

    public func closeBlock(): Unit {
        sb.append("3.1\n")
        Exception().printStackTrace()
        block.isClosed = true
        block.latex = builder.toString()
    }
}

class LatexBlockParserFactory <: AbstractBlockParserFactory {
    public func tryStart(state: ParserState, _: MatchedBlockParser): ?BlockStart {
        var line: String = state.getLine().getContent()[state.getIndex()..]
        if (line == "$$" || line == "\\[") {
            return BlockStart.of(LatexBlockParser()).atIndex(state.getIndex() + 2)
        }
        line = line.trim()
        if (line.startsWith(#"\["#) && line.endsWith(#"\]"#) || (line.startsWith(#"$$"#) && line.size > 3 &&
            line.endsWith(#"$$"#))) {
            let parser = LatexBlockParser()
            parser.builder.append(line[2..line.size - 2])
            parser.isSingleLineLatex = true
            return BlockStart.of(parser).atIndex(state.getIndex() + 2)
        }
        return BlockStart.none()
    }
}

func isLatexLine(line: String): Bool {
    let str = line.replace(#"\$"#, "")
    if (let Some(i) <- str.indexOf("$")) {
        if (i != str.size - 2) {
            return false
        }
    }
    if (let Some(i) <- str.indexOf("$$")) {
        if (i != str.size - 2) {
            return false
        }
    }
    return true
}

func isLatexEnd(lineStr: String): Bool {
    // let reg = Regex(#"[^\\]?\$\$$"#)
    let line = lineStr.trimAscii()
    let size = line.size
    return match {
        case size < 2 => false
        case size == 2 && line == "$$" || line == "\\]" => true
        case size > 2 && line[size - 1] == b'$' && line[size - 2] == b'$' && line[size - 3] != b'\\' => true
        case size > 2 && line[size - 1] == b']' && line[size - 2] == b'\\' && line[size - 3] != b'\\' => true
        case _ => false
    }
}

let LATEX_IN_LIST = Regex(#"\s{0,3}(\$\$|\\\[)"#)

func isLatexInList(line: String): ?Int {
    return LATEX_IN_LIST.find(line)?.matchPosition().end
}

type CharSequence = String

type CharSeqCell = Byte
