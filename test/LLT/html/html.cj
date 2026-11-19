// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test --debug-macro
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
    appender.append("${" " * dep}${tag} ${tag.isClosed()}\n")
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

// @Test
public func html1(): Unit {
    let appender = StringBuilder()
    // let html = "<div>asdasd<b>zxc</b></div><em>qwe</em>"
    // let html = "<br></br1>"
    // let html = "<a><b/><br><c></c>\n<code>a\nsd</code>"
    let html = "<font>"
    let rootTag = RootTag()
    let htmlParser = MarkdownHtmlParserImpl.create()
    htmlParser.processFragment(appender, html, rootTag)
    printTag(rootTag)
}

let mdhtml: Markdown = Markdown
    .builder()
    // 任务列表插件
    .usePlugin(TaskListPlugin.create())
    // 删除线插件
    .usePlugin(StrikethroughPlugin.create())
    // 表格插件
    .usePlugin(TablePlugin.create())
    // 幻灯片、视频、ImageStyle插件
    .usePlugin(ImageStylePlugin.create())
    .usePlugin(ImageSlidePlugin.create())
    .usePlugin(ImageVideoPlugin.create())
    // 代码标签
    .usePlugin(CodeListPlugin.create())
    // 数学公式
    .usePlugin(LatexMathPluginV2.create())
    // 链接
    .usePlugin(LinkifyPlugin.create())
    // TOC列表插件
    .usePlugin(TocPlugin.create())
    .usePlugin(HtmlPlugin.create())
    .build()

@Test
public func inline1(): Unit {
    // let html = "<div>asdasd<b>zxc</b></div><em>qwe</em>"
    // let html = "<br></br1>"
    // let html = "asd<font>aaa</font>"
    // let html = "<font color=#008000>**[21天]**</font>是由活动<font>222</font>"
    let html = "<font>**1**</font>"

    let node = mdhtml.parse(html)
    printNode(node)
    var nodeView = mdhtml.render(node)
    // printNode(node)
    printNode(nodeView)
    nodeView = nodeView[0]
    println(nodeView)
    nodeView = nodeView[0]
    println(nodeView)
    let font = nodeView
    println(font)
    @Assert(font is FontNode)
}

@Test
public func inline3(): Unit {
    // let html = "<div>asdasd<b>zxc</b></div><em>qwe</em>"
    // let html = "<br></br1>"
    // let html = "asd<font>aaa</font>"
    // let html = "<font color=#008000>**[21天]**</font>是由活动<font>222</font>"
    let html = "<font>**1**</font>"

    let node = md.parse(html)
    printNode(node)
    var nodeView = md.render(node)
    printNode(node)
    printNode(nodeView)
}

// @Test
public func inline2(): Unit {
    // let html = "<div>asdasd<b>zxc</b></div><em>qwe</em>"
    // let html = "<br></br1>"
    let html = "asd<font>aaa<font/>"
}

// @Test
public func handler1(): Unit {
    // let builder = MarkdownHtmlRendererImplBuilder()
    // builder.addDefaultTagHandler(FontHandler())
    // let handler = builder.getHandler("font")
    // let htmlRenderer = builder.build()
    // // let handler = htmlRenderer.tagHandler("font")
    // if(let Some(handler)<-handler){
    //     for(t in handler.supportedTags()){
    //         println(t)
    //     }
    // }
}
