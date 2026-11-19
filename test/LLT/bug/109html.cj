// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main 
//--filter=test5
import std.runtime.*

class MyBlock <: CustomBlock {
    MyBlock() {}
    public func getNodeType(): String {
        "MyBlock"
    }
}

public class MyTagHandler <: TagHandler {
    public init() {
    }

    public override func handle(_: ?MarkdownVisitor, _: MarkdownHtmlRenderer, _: HtmlTag): Node {
        return MyBlock()
    }

    public override func supportedTags(): Collection<String> {
        return ["asd"]
    }
}

let htmlPlugin = {
    =>
        let html = HtmlPlugin.create()
        html.addHandler(MyTagHandler())
        html
}()
let markdown: Markdown = Markdown
    .builder()
    // HTML插件
    .usePlugin(htmlPlugin)
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
    // .usePlugin(NodeIdPlugin.create())
    .build()

@Test
public func test3(): Unit {
    var str = """
<font face="黑体"><h3>【M24+常规】</h3></font>
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

@Test
public func test4(): Unit {
    var str = """
`<h2>1</h2>`

- <asd>asd2</asd>
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

@Test
public func test5(): Unit {
    let markdown: Markdown = Markdown
        .builder()
        // 表格插件
        .usePlugin(TablePlugin.create())
        // HTML插件
        .usePlugin(HtmlPlugin.create())
        .build()
    var str = """
| b |
|---|
| <div>纯白</div> |
"""
    println('2.0 parse start')
    let node = markdown.parse(str)
    println('2.2 parse end')
    printNode(node)
    println('2.3 render start')
    let nodeView = markdown.render(node)
    println('2.4 render end')
    printNode1(node)
    @Assert(nodeView[0][1][0][0][0].getNodeType(),"Text")
    @Assert((nodeView[0][1][0][0][0] as Text).getOrThrow().getLiteral(),"纯白")
    println("                   ---")
}

@Test
public func testPre(): Unit {
    let markdown: Markdown = Markdown
        .builder()
        // 表格插件
        .usePlugin(TablePlugin.create())
        // HTML插件
        .usePlugin(HtmlPlugin.create())
        .build()
    var str = #"""
<pre>
// 弹窗提示函数
function showMessage(content) {
    // 缩进2个空格，格式完全保留
    if (content && typeof content === "string") {
        alert(`提示：${content}`);
    } else {
        alert("请输入有效文本！");
    }
}

// 调用示例
showMessage("pre 标签保留所有格式");
</pre>
"""#
//     str=#"""
// ```
// asd
// ```
// """#
    let node = markdown.parse(str)
    printNode(node)
    let nodeView = markdown.render(node)
    // printNode(node)
    printNode(nodeView)
    @Assert((nodeView[1] as IndentedCodeBlock).getOrThrow().getLiteral().contains("\n"))
}


public func printNode1(node: ?Node): Unit {
    if (let Some(v) <- node) {
        var current = v
        while (let Some(p) <- (current.getParent())) {
            current = p
        }
        let builder = StringBuilder()
        printNode1(current, 0, builder)
        println(builder)
    }
}

public func printNode1(node: ?Node, dep: Int, builder: StringBuilder): Unit {
    if (let Some(v) <- node) {
        let str = v.toPropStr()
        builder.append("${" "*dep}${str}\n")
        let child = v.getFirstChild()
        printNode1(child, dep + 4, builder)
        let next = v.getNext()
        printNode1(next, dep, builder)
    }
}






/* 
public class HtmlPlugin1 <: AbstractMarkdownPlugin {
    public static func create(): HtmlPlugin1 {
        return HtmlPlugin1()
    }

    public static let SCRIPT_DEF_TEXT_SIZE_RATIO = 0.75

    private let builder: MarkdownHtmlRendererImplBuilder

    private var htmlParser: ?MarkdownHtmlParserImpl = None
    private var htmlRenderer: ?MarkdownHtmlRenderer = None

    private var _emptyTagReplacement: HtmlEmptyTagReplacement = HtmlEmptyTagReplacement()

    init() {
        this.builder = MarkdownHtmlRendererImplBuilder()
    }

    /**
     * @param allowNonClosedTags whether or not non-closed tags should be closed
     *                           at the document end. By default `false`
     */
    public func allowNonClosedTags(allowNonClosedTags: Bool): HtmlPlugin {
        builder.allowNonClosedTagsMethod(allowNonClosedTags)
        return this
    }

    public func addHandler(tagHandler: TagHandler): HtmlPlugin {
        builder.addHandler(tagHandler)
        return this
    }

    public func getHandler(tagName: String): ?TagHandler {
        return builder.getHandler(tagName)
    }

    /**
     * Indicate if HtmlPlugin should register default HTML tag handlers. Pass `true` to <strong>not</strong>
     * include default handlers. By default default handlers are included. You can use
     * {@link TagHandlerNoOp} to no-op certain default tags.
     *
     * @see TagHandlerNoOp
     */
    public func excludeDefaults(excludeDefaults: Bool): HtmlPlugin {
        builder.excludeDefaultsMethod(excludeDefaults)
        return this
    }

    public func emptyTagReplacement(emptyTagReplacement: HtmlEmptyTagReplacement): HtmlPlugin {
        this._emptyTagReplacement = emptyTagReplacement
        return this
    }

    public override func configureParser(_: ParserBuilder): Unit {
        if (!builder.excludeDefaultsMethod()) {
            // builder.addDefaultTagHandler(SubScriptHandler())
            // builder.addDefaultTagHandler(SuperScriptHandler())
            // builder.addDefaultTagHandler(UnderlineHandler())
            builder.addDefaultTagHandler(ImageHandler())
            builder.addDefaultTagHandler(LinkHandler())
            builder.addDefaultTagHandler(StrongEmphasisHandler())
            builder.addDefaultTagHandler(EmphasisHandler())
            builder.addDefaultTagHandler(StrikeHandler())
            builder.addDefaultTagHandler(BlockquoteHandler())

            builder.addDefaultTagHandler(BulletListHandler())
            builder.addDefaultTagHandler(OrderedListHandler())
            builder.addDefaultTagHandler(ListItemHandler())

            builder.addDefaultTagHandler(HeadingHandler())
            builder.addDefaultTagHandler(BrHandler())
            builder.addDefaultTagHandler(ThematicBreakHandler())
            builder.addDefaultTagHandler(FontHandler())
            builder.addDefaultTagHandler(SpanHandler())

            builder.addDefaultTagHandler(TableHandler())
            builder.addDefaultTagHandler(TableHeadHandler())
            builder.addDefaultTagHandler(TableBodyHandler())
            builder.addDefaultTagHandler(TableRowHandler())
            builder.addDefaultTagHandler(TableCellHandler())

            builder.addDefaultTagHandler(CodeHandler())
            builder.addDefaultTagHandler(IndentedCodeBlockHandler())
            builder.addDefaultTagHandler(TextHandler())

            builder.addDefaultTagHandler(ParagraphHandler())
        }
        htmlParser = MarkdownHtmlParserImpl.create(_emptyTagReplacement)
        htmlRenderer = builder.build()
    }

    public override func configureVisitor(builder: MarkdownVisitorBuilder): Unit {
        builder
            .on(
                "HtmlBlock",
                {
                    visitor, node =>
                    let htmlBlock = (node as HtmlBlock).getOrThrow()
                    visitHtml(visitor, node, htmlBlock.getLiteral())
                }
            )
            .on(
                "HtmlInline",
                {
                    visitor, node =>
                    let htmlInline = (node as HtmlInline).getOrThrow()
                    visitHtmlInline(visitor, htmlInline)
                }
            )
            .on(
                "ImageHtmlNode",
                {
                    visitor, node =>
                    buildView(node, true)
                    visitor.visitChildren(node)
                }
            )
            .on(
                "FontNode",
                {
                    visitor, node =>
                    let view = buildView(node, false, needProps: true)
                    view.props?.add("FontNode", node)
                    visitor.visitChildren(node)
                }
            )
            .on(
                "SpanNode",
                {
                    visitor, node =>
                    let view = buildView(node, false, needProps: true)
                    view.props?.add("SpanNode", node)
                    visitor.visitChildren(node)
                }
            )
            .on(
                "IgnoreBlockNode",
                {
                    visitor, node =>
                    buildView(node, false)
                    visitor.visitChildren(node)
                }
            )
            .on(
                "IgnoreInlineNode",
                {
                    visitor, node =>
                    buildView(node, false)
                    visitor.visitChildren(node)
                }
            )
    }

    public func visitHtml(visitor: MarkdownVisitor, node: Node, html: String): Unit {
        let htmlParser = htmlParser.getOrThrow()
        var rootTag = BlockImpl.root()

        // htmlString -> HtmlTag
        htmlParser.processFragment(StringBuilder(), html, rootTag)
        // printTag(rootTag) // debug

        // rootTag.children分类
        rootTag = tagCategory(rootTag)

        // HtmlTag ---handler---> CommonMarkNode
        let tagNode = htmlRenderer.getOrThrow().render(visitor, htmlParser, rootTag)
        htmlParser.reset()

        // replace htmlNode with tagNode
        node.replaceWith(tagNode)

        // CommonMarkNode -> NodeView
        buildView(tagNode, false)

        // visit Children
        visitor.visitChildren(tagNode)
    }

    func tagCategory(rootTag: BlockImpl): BlockImpl {
        let newRoot = BlockImpl.root()
        var p: ?BlockImpl = None
        for (tag in rootTag.getChildren()) {
            if (tag.isBlock()) {
                newRoot.appendChild(tag)
                p = None
            } else if (tag.isInline()) {
                if (p.isNone()) {
                    p = BlockImpl.create("p", 0, HashMap<String, String>(), newRoot, newRoot)
                }
                p?.appendChild(tag)
            }
        }
        // printTag(newRoot) // debug
        newRoot
    }

    public func visitHtmlInline(visitor: MarkdownVisitor, htmlInline: HtmlInline): Unit {
        if (htmlInline.getParent().isNone() && htmlInline.getPrevious().isNone() && htmlInline.getNext().isNone()) {
            return
        }
        // 保存锚点
        let anchorNode = Paragraph1()
        htmlInline.insertBefore(anchorNode)

        visitHtmlInline(visitor, StringBuilder(), htmlInline, anchorNode)
        var resNode: ?Node = anchorNode.getFirstChild()

        htmlParser?.reset()

        // 保存解析结果
        anchorNode.flat()

        // 解析InlineHtml可能破坏后续兄弟节点结构
        // 手动遍历解析结果构建NodeView
        while (let Some(n) <- resNode) {
            n.accept(visitor)
            resNode = n.getNext()
        }
    }
    /*
     * html->HtmlTag->Node
     * 将开闭的tag组合起来
     */
    private func visitHtmlInline(visitor: MarkdownVisitor, appender: StringBuilder, node: Node, parent: Node): Unit {
        let htmlParser = htmlParser.getOrThrow()
        let htmlRenderer = htmlRenderer.getOrThrow()
        var parentNode = parent
        var nextNode: ?Node = node.getNext()
        // printNode(node) // debug
        match (node) {
            case htmlInline: HtmlInline =>
                let htmlString = htmlInline.getLiteral()
                let tag = htmlParser.processFragmentInline(appender, htmlString, None)
                match(tag){
                    case Some(end:EndTag) => 
                        if (end.startTag.isSome()) {
                            parentNode = parentNode.getParent().getOrThrow()
                        }
                    case Some(tag) where tag.isClosed() => 
                        let tagNode = htmlRenderer.render(visitor, htmlParser, tag)
                        parentNode.appendChild(tagNode)
                    case Some(tag) where !tag.isClosed() => 
                        var tagNode = htmlRenderer.render(visitor, htmlParser, tag)
                        if (!(parentNode is Block) && tagNode is Block) {
                            tagNode = IgnoreInlineNode()
                        }
                        parentNode.appendChild(tagNode)
                        parentNode = tagNode
                    case _ => ()
                }
                node.unlink()
            case t: Text =>
                // println("1.24 ") // debug
                node.unlink()
                match (parentNode) {
                    case v: Code => v.setLiteral(t.getLiteral())
                    case _ => parentNode.appendChild(node)
                }
            case _ =>
                // println("1.25 ") // debug
                // 普通markdownNode
                node.unlink()
                parentNode.appendChild(node)
        }

        // printNode(parentNode) // debug
        // println("1.5 ${nextNode} ${parentNode}") // debug
        if (let Some(n) <- nextNode) {
            visitHtmlInline(visitor, appender, n, parentNode)
        }
    }

    public override func afterRender(doc: Node, _: MarkdownVisitor): Unit {
        let docView = doc.getView()
        for (i in 0..docView.children.size) {
            let nv = docView.children[i]
            if(nv.node is Block){
                continue
            }
            let pv = NodeView(Paragraph())
            pv.children.add(nv)
            docView.children[i] = pv
        }
    }

    public override func getClassType(): String {
        "HtmlPlugin"
    }
}

class Paragraph1 <: Paragraph {
    let hash = DateTime.now().hashCode().toString()
    protected override func toStringAttributes(): String {
        return hash
    }
    public override func getParent(): ?Node {
        parent
    }
}
 */