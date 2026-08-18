package markdown_parser.plugin

public class HtmlPlugin <: AbstractMarkdownPlugin {
    public static func create(): HtmlPlugin {
        return HtmlPlugin()
    }

    public static let SCRIPT_DEF_TEXT_SIZE_RATIO: Float64 = 0.75

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

            builder.addDefaultTagHandler(SubHandler())
            builder.addDefaultTagHandler(SupHandler())
            builder.addDefaultTagHandler(UnderlineHandler())
            builder.addDefaultTagHandler(CardHandler())
        }
        htmlParser = MarkdownHtmlParserImpl.create(_emptyTagReplacement)
        htmlRenderer = builder.build()
    }

    public override func configureVisitor(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            "HtmlBlock",
            {
                visitor, node =>
                    let htmlBlock = (node as HtmlBlock).getOrThrow()
                    visitHtml(visitor, node, htmlBlock.getLiteral())
            }
        ).on(
            "HtmlInline",
            {
                visitor, node =>
                    let htmlInline = (node as HtmlInline).getOrThrow()
                    visitHtmlInline(visitor, htmlInline)
            }
        ).on(
            "ImageHtmlNode",
            {
                visitor, node => visitor.visitChildren(node)
            }
        ).on(
            "FontNode",
            {
                visitor, node => visitor.visitChildren(node)
            }
        ).on(
            "SpanNode",
            {
                visitor, node => visitor.visitChildren(node)
            }
        ).on(
            "IgnoreBlockNode",
            {
                visitor, node => visitor.visitChildren(node)
                node.flat()
            }
        ).on(
            "IgnoreInlineNode",
            {
                visitor, node => visitor.visitChildren(node)
            }
        ).on(
            "SubHtmlNode",
            {
                visitor, node => visitor.visitChildren(node)
            }
        ).on(
            "SupHtmlNode",
            {
                visitor, node => visitor.visitChildren(node)
            }
        ).on(
            "UnderlineNode",
            {
                visitor, node => visitor.visitChildren(node)
            }
        ).on(
             "CardNode",
             {
                 visitor, node =>
                 visitor.visitChildren(node)
             }
         )
    }

    public func visitHtml(visitor: MarkdownVisitor, node: Node, html: String): Unit {
        let htmlParser = htmlParser.getOrThrow()
        var rootTag = BlockImpl.root()

        // htmlString -> HtmlTag
        htmlParser.processFragment(StringBuilder(), html, rootTag)

        // rootTag.children分类
        rootTag = tagCategory(rootTag)

        // HtmlTag ---handler---> CommonMarkNode
        let tagNode = htmlRenderer.getOrThrow().render(visitor, htmlParser, rootTag)
        htmlParser.reset()
        tagNode.setSourceSpans(node.getSourceSpans())

        // replace htmlNode with tagNode
        node.replaceWith(tagNode)

        // visit tagNode
        visitor.visitNode(tagNode)
    }

    func tagCategory(rootTag: BlockImpl): BlockImpl {
        let childrenTags = rootTag.getChildren()
        if (childrenTags.size == 1) {
            match (childrenTags[0]) {
                case v: BlockImpl => return v
                case v =>
                    let p = BlockImpl.create("p", 0, HashMap<String, String>(), None, None)
                    p.appendChild(v)
                    return p
            }
        }
        let newRoot = BlockImpl.root()
        var p: ?BlockImpl = None
        for (tag in childrenTags) {
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
        match (node) {
            case htmlInline: HtmlInline =>
                let htmlString = htmlInline.getLiteral()
                let tag = htmlParser.processFragmentInline(appender, htmlString, None)
                match (tag) {
                    case Some(end: EndTag) =>
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
                node.unlink()
                match (parentNode) {
                    case v: Code => v.setLiteral(t.getLiteral())
                    case _ => parentNode.appendChild(node)
                }
            case _ =>
                // 普通markdownNode
                node.unlink()
                parentNode.appendChild(node)
        }

        if (let Some(n) <- nextNode) {
            visitHtmlInline(visitor, appender, n, parentNode)
        }
    }

    public override func afterRender(doc: Node, _: MarkdownVisitor): Unit {
        for (n in doc.iterateChildren()) {
            if (n is Block) {
                continue
            }
            let p = Paragraph()
            n.insertBefore(p)
            n.unlink()
            p.appendChild(n)
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
