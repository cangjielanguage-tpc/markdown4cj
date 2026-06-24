package markdown.plugin

public class TablePlugin <: AbstractMarkdownPlugin {
    public static func create(): TablePlugin {
        return TablePlugin()
    }

    public func configureParser(builder: ParserBuilder): Unit {
        builder.extensions([TablesExtension.create()])
    }

    public func configureVisitor(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            "TableBlock",
            {
                visitor, node => visitor.visitChildren(node)
            }
        ).on(
            "TableRow",
            {
                visitor, node => visitor.visitChildren(node)
            }
        ).on(
            "TableCell",
            {
                visitor, node => visitor.visitChildren(node)
            }
        ).on("TableHead", tableNodeVisitor).on("TableBody", tableNodeVisitor)
    }

    func tableNodeVisitor(visitor: MarkdownVisitor, node: Node) {
        visitor.visitChildren(node)
    }

    public func getClassType(): String {
        "TablePlugin"
    }
}
