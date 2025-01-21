/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 */
package markdown.plugin

public class HtmlPlugin <: AbstractMarkdownPlugin {
    public static func create(): HtmlPlugin {
        return HtmlPlugin()
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

            builder.addDefaultTagHandler(TableHandler())
            builder.addDefaultTagHandler(TableHeadHandler())
            builder.addDefaultTagHandler(TableBodyHandler())
            builder.addDefaultTagHandler(TableRowHandler())
            builder.addDefaultTagHandler(TableCellHandler())

            builder.addDefaultTagHandler(CodeHandler())
            builder.addDefaultTagHandler(IndentedCodeBlockHandler())
            builder.addDefaultTagHandler(TextHandler())
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
                    view.props?.put("FontNode", node)
                    visitor.visitChildren(node)
                }
            )
            .on(
                "IgnoreNode",
                {
                    visitor, node =>
                    buildView(node, false)
                    visitor.visitChildren(node)
                }
            )
    }

    public func visitHtml(visitor: MarkdownVisitor, node: Node, html: String): Unit {
        let htmlParser = htmlParser.getOrThrow()
        let rootTag = BlockImpl.root()

        // htmlString -> HtmlTag
        htmlParser.processFragment(StringBuilder(), html, rootTag)

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

    public func visitHtmlInline(visitor: MarkdownVisitor, htmlInline: HtmlInline): Unit {
        // 保存锚点
        let anchorNode = Paragraph()
        htmlInline.insertBefore(anchorNode)

        visitHtmlInline(visitor, StringBuilder(), htmlInline, anchorNode)
        var resNode: ?Node = anchorNode.getFirstChild().getOrThrow()

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
        // printNode(node)
        match (node) {
            case htmlInline: HtmlInline =>
                let htmlString = htmlInline.getLiteral()
                let tag = htmlParser.processFragmentInline(appender, htmlString, None)
                // printTag(tag)
                // println("1.2 ${tag} ${tag is EndTag} ${tag.isClosed()} ${parentNode}")
                if (tag is EndTag) {
                    // end tag
                    parentNode = parentNode.getParent().getOrThrow()
                } else if (tag.isClosed() == true) {
                    // self close tag
                    let tagNode = htmlRenderer.render(visitor, htmlParser, tag)
                    parentNode.appendChild(tagNode)
                } else if (tag.isClosed() == false) {
                    // start tag
                    let tagNode = htmlRenderer.render(visitor, htmlParser, tag)
                    parentNode.appendChild(tagNode)
                    parentNode = tagNode
                }
                node.unlink()
            case _ =>
                // 普通markdownNode
                node.unlink()
                parentNode.appendChild(node)
        }

        // printNode(node)
        // println("1.5 ${nextNode} ${parentNode}")
        if (let Some(n) <- nextNode) {
            visitHtmlInline(visitor, appender, n, parentNode)
        }
    }

    public override func getClassType(): String {
        "HtmlPlugin"
    }
}
