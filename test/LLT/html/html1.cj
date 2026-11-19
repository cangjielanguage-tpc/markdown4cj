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
    .usePlugin(ImageStylePlugin.create()).usePlugin(ImageSlidePlugin.create()).usePlugin(ImageVideoPlugin.create())
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
public func code1(): Unit {
    let html = """
# 内联代码<code>内联代码</code>

# 内联代码<samp>内联代码</samp>

# 内联代码<var>内联代码</var>

# 内联代码<kbd>内联代码</kbd>

内联代码<code>内联代码</code>

内联代码<samp>内联代码</samp>

内联代码<var>内联代码</var>

内联代码<kbd>内联代码</kbd>

<code>内联代码</code>"""

    /* let html = """
# 图片<img src="https://pic.lingkou.xyz/1654138650-DZKWTJ-gif.gif" title="Pulpit rock" width="300" height="200">

图片<img src="https://pic.lingkou.xyz/1654138650-DZKWTJ-gif.gif" title="Pulpit rock" width="300" height="200">

<img src="https://pic.lingkou.xyz/1654138650-DZKWTJ-gif.gif" title="Pulpit rock" width="300" height="200">""" */

    /* let html = """
# 标题br换行<br>标题

段落br换行<br>段落
    
<br>""" */


    let node = mdhtml.parse(html)
    printNode(node)
    var nodeView = mdhtml.render(node)
    printNode(node)
    printNode(nodeView)
}

// @Test
public func hr1(): Unit {
    /* let html = """
<br>
""" */
    let html = """
<h1>一级标题</h1>

<h2>二级标题</h2>

<h3>三级标题</h3>

<h4>四级标题</h4>

<h5>五级标题</h5>

<h6>六级标题</h6>"""

    let node = mdhtml.parse(html)
    printNode(node)
    var nodeView = mdhtml.render(node)
    printNode(node)
    printNode(nodeView)
    // var a = node.getFirstChild()()
    // printNode(a)
    // printNode((a.custom as NodeView)())
    // println("1.1 ${a.getFirstChild()}")
    // a = node.getFirstChild()().getFirstChild()()
    // printNode(a)
    // printNode((a.custom as NodeView)())
    // println("1.2 ${a.getParent()}")
}
