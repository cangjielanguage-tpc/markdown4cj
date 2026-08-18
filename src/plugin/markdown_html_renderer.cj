package markdown_parser.plugin

public abstract class MarkdownHtmlRenderer {
    public func render(
        visitor: ?MarkdownVisitor,
        parser: MarkdownHtmlParser,
        tag: HtmlTag
    ): Node

    public func tagHandler(tagName: String): ?TagHandler
}
