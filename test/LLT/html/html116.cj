// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
internal import markdown_parser.core.*
internal import markdown_parser.plugin.*
internal import commonmark4cj.commonmark.*
internal import std.collection.*

func printTag(tag: HtmlTag): Unit {
    let appender = StringBuilder()
    var root: HtmlTag = tag
    while (let Some(p) <- root.parentTag) {
        root = p
    }
    printTag(root, 0, appender)
    println(appender)
}

func printTag(tag: HtmlTag, dep: Int, appender: StringBuilder): Unit {
    appender.append("${" "*dep}${tag} ${tag.isClosed()}\n")
    for (child in tag.getChildren()) {
        printTag(child, dep + 1, appender)
    }
}

public class RootTag <: HtmlTagImpl {
    private static let EMPTY_MAP: Map<String, String> = HashMap<String, String>()
    RootTag() {
        super("", -1, EMPTY_MAP)
    }
    public override func closeAt(end: Int): Unit {
        throw UnsupportedException()
    }
    public override func attributes(): Map<String, String> {
        throw UnsupportedException()
    }
    public override func isInline(): Bool {
        false
    }
    public override func isBlock(): Bool {
        false
    }
    public override func getAsInline(): InlineHtmlTag {
        throw UnsupportedException()
    }
    public override func getAsBlock(): BlockHtmlTag {
        throw UnsupportedException()
    }
    public override func toString(): String {
        "RootTag"
    }
}

let mdhtml: Markdown = Markdown
    .builder()
    // 任务列表插件
    .usePlugin(TaskListPlugin.create())
    // 删除线插件
    .usePlugin(StrikethroughPlugin.create())
    // 表格插件
    .usePlugin(TablePlugin.create())
    // 代码标签
    .usePlugin(CodeListPlugin.create())
    // 链接
    .usePlugin(LinkifyPlugin.create())
    // TOC列表插件
    .usePlugin(TocPlugin.create())
    .usePlugin(HtmlPlugin.create())
    .build()

@Test
public func br1(): Unit {
    let html = """
<a href=“myscheme://jump?target=aireportmini” >最小化</a>
<element.name>
"""

    let node = mdhtml.parse(html)
    printNode(node)
    var nodeView = mdhtml.render(node)
    printNode(node)
    printNode(nodeView)
}



/*
 * 自定义标签插件
 *   行内单标签:
 *     <cmtag.inline.mytag/>
 *     <cmtag.inline.mytag>
 *   行内开闭标签: 当前不支持
 *   属性:
 *     a
 *     a=true
 *     a="true"
 *     a='true'
 */
class CustomTagPlugin <: AbstractMarkdownPlugin {
    CustomTagPlugin() {}

    public func configureParser(builder: ParserBuilder): Unit {
        builder.customInlineContentParserFactory(CustomTagParser())
    }

    public func getClassType(): String {
        'CustomTagPlugin'
    }
}
interface InlineParserIntegration <: InlineContentParser & InlineContentParserFactory {}
class CustomTagParser <: InlineParserIntegration {
    private static let TAG_START = '<cmtag@inline@'
    private static let TAG_END = '>'

    public func create(): InlineContentParser {
        this
    }
    public func getTriggerCharacters(): HashSet<Rune> {
        return HashSet([r"<"]);
    }

    public func tryParse(inlineParserState: InlineParserState): ParsedInline {
        let scanner = inlineParserState.getScanner()
        var line = scanner.peekLine()
        if (line.startsWith('<cmtag.inline.')) {
            if (let Some(tag) <- TagReader(scanner).read()) {
                return ParsedInline.of(tag, scanner.position())
            }
        }
        return ParsedInline.none()
    }
}

class CustomTag <: CustomNode {
    CustomTag(public let tagName: String) {}
    public let tagAttrs: HashMap<String, String> = HashMap()
    public func getNodeType(): String {
        "CustomTag"
    }
    public func toStringAttributes(): String {
        "tagName:${tagName},tagAttrs:${tagAttrs}"
    }
}

class TagReader {
    TagReader(let scanner: Scanner) {}
    func read(): ?CustomTag {
        readTagStart() ?? return None
        scanner.whitespace()
        let name = readTagName() ?? return None
        let tag = CustomTag(name)
        while (true) {
            scanner.whitespace()
            match (scanner.peek()) {
                case b'/' | b'>' | 0 => break
                case _ => ()
            }
            let name = readPropName() ?? break
            let value = readPropValue()
            tag
                .tagAttrs
                .add(name, value)
        }
        readTagEnd() ?? return None
        return tag
    }
    /*读取 < </ */
    func readTagStart(): ?Bool {
        scanner.next()
        scanner.whitespace()
        scanner.next(b'/')
        readTagName()
        true
    }
    /*读取标签name*/
    func readTagName(): ?String {
        scanner.whitespace()
        return scanner.readUtil(b' ')
    }
    /*读取属性name*/
    func readPropName(): ?String {
        scanner.whitespace()
        return scanner.readUtil(b' ')
    }
    /*读取属性value*/
    func readPropValue(): String {
        if (scanner.next(b'=')) {
            return match {
                case scanner.next(b'"') => scanner.readUtil(b'"')
                case scanner.next(b'\'') => scanner.readUtil(b'"')
                case _ => scanner.readUtil(b' ')
            } ?? ""
        }
        return ""
    }
    /*读取 > /> */
    func readTagEnd(): ?Bool {
        if (scanner.next(b'/')) {
            scanner.whitespace()
            if (scanner.next(b'>')) {
                return true
            }
        }
        return false
    }
}

extend Scanner {
    func readUtil(b: Byte): ?String {
        let p0 = this.position()
        var len = 0
        while (true) {
            match (this.peek()) {
                case b'\n' | 0 => return None
                case v where v == b => break
                case _ =>
                    len++
                    continue
            }
        }
        let p1 = this.position()
        let name = this
            .getSource(p0, p1)
            .getContent()
        if (!name.isEmpty()) {
            return name
        }
        return None
    }
}
