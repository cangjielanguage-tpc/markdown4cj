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
        if (!builder.excludeDefaultsMethod()) {
            builder.addDefaultTagHandler(ImageHandler())
            builder.addDefaultTagHandler(LinkHandler())
            builder.addDefaultTagHandler(BlockquoteHandler())
            //             builder.addDefaultTagHandler(SubScriptHandler())
            //             builder.addDefaultTagHandler(SuperScriptHandler())
            builder.addDefaultTagHandler(StrongEmphasisHandler())
            builder.addDefaultTagHandler(StrikeHandler())
            //             builder.addDefaultTagHandler(UnderlineHandler())
            builder.addDefaultTagHandler(ListItemHandler())
            builder.addDefaultTagHandler(BulletListHandler())
            builder.addDefaultTagHandler(OrderedListHandler())
            builder.addDefaultTagHandler(EmphasisHandler())
            builder.addDefaultTagHandler(HeadingHandler())
            builder.addDefaultTagHandler(BrHandler())
            builder.addDefaultTagHandler(ThematicBreakHandler())
            builder.addDefaultTagHandler(FontHandler())
            builder.addDefaultTagHandler(HeadingHandler())
        }
        htmlParser = MarkdownHtmlParserImpl.create(_emptyTagReplacement)
        htmlRenderer = builder.build()
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

    public override func afterRender(node: Node, visitor: MarkdownVisitor): Unit {
        /* let htmlRenderer = this.htmlRenderer
        if (htmlRenderer.isSome()) {
            htmlRenderer?.render(visitor, htmlParser)
        } else {
            throw IllegalStateException("Unexpected state, html-renderer is not defined")
        } */
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
                    visitHtml(visitor, node, htmlInline.getLiteral())
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
                    buildView(node, true)
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

        // replace htmlNode with tagNode
        node.replaceWith(tagNode)

        // CommonMarkNode -> NodeView
        buildView(tagNode, false)

        // visit Children
        visitor.visitChildren(tagNode)
    }

    public override func getClassType(): String {
        "HtmlPlugin"
    }
}
