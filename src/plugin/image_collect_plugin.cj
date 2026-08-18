package markdown_parser.plugin

public class ImageCollectPlugin <: AbstractMarkdownPlugin {
    public static func create(): ImageCollectPlugin {
        return ImageCollectPlugin()
    }

    public func getClassType(): String {
        "ImageCollectPlugin"
    }

    public override func afterRender(doc: Node, _: MarkdownVisitor): Unit {
        let visitor = ImageCollectVisitor()
        doc.accept(visitor)
        doc.addProp("links", visitor.links)
        return
    }
}

class ImageCollectVisitor <: AbstractVisitor {
    let links = HashSet<String>()
    public func visit(n: Image): Unit {
        links.add(n.getDestination())
    }
    public func visit(b: CustomBlock): Unit {
        if (b is BlockAudio) {
            return
        }
        visitChildren(b)
    }
}
