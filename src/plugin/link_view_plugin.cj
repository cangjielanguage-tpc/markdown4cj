package markdown_parser.plugin

/**
 * Link作为单独NodeView节点
 */
public class LinkViewPlugin <: AbstractMarkdownPlugin {
    public static func create(): LinkViewPlugin {
        return LinkViewPlugin()
    }

    public func configureVisitor(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            "Link",
            {
                visitor, node =>
                visitor.visitChildren(node)
            }
        )
    }

    public func getClassType(): String {
        "LinkViewPlugin"
    }
}
