package markdown_parser.plugin

class MarkdownHtmlRendererNoOp <: MarkdownHtmlRenderer {
    init() {
        super()
    }

    public override func render(_: ?MarkdownVisitor, _: MarkdownHtmlParser, _: HtmlTag): Node {
        let ignoreNode = IgnoreBlockNode()
        return ignoreNode
    }

    public override func tagHandler(_: String): ?TagHandler {
        return None
    }
}
