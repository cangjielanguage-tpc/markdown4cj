/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 */
package markdown.plugin

public abstract class TagHandler {
    public func handle(visitor: MarkdownVisitor, renderer: MarkdownHtmlRenderer, tag: HtmlTag): Node

    public func supportedTags(): Collection<String>

    protected static func visitChildren(visitor: MarkdownVisitor, renderer: MarkdownHtmlRenderer, block: HtmlTag,
        nodeParent: Node): Unit {
        var handler: ?TagHandler
        for (child in block.getChildren()) {
            handler = renderer.tagHandler(child.name())
            if (let Some(v) <- handler) {
                nodeParent.appendChild(v.handle(visitor, renderer, child))
            } else {
                var node: Node = IgnoreNode()
                nodeParent.appendChild(node)
                visitChildren(visitor, renderer, child, node)
            }
        }
    }
}

public class BrHandler <: TagHandler {
    public init() {
    }

    public override func handle(visitor: MarkdownVisitor, renderer: MarkdownHtmlRenderer, tag: HtmlTag): Node {
        return HardLineBreak()
    }

    public override func supportedTags(): Collection<String> {
        return ArrayList<String>(["br"])
    }
}

public class ThematicBreakHandler <: TagHandler {
    public init() {
    }

    public override func handle(visitor: MarkdownVisitor, renderer: MarkdownHtmlRenderer, tag: HtmlTag): Node {
        return ThematicBreak()
    }

    public override func supportedTags(): Collection<String> {
        return ArrayList<String>(["hr"])
    }
}

public class FontHandler <: TagHandler {
    public init() {
    }

    public override func handle(visitor: MarkdownVisitor, renderer: MarkdownHtmlRenderer, tag: HtmlTag): Node {
        let attributes: Map<String, String> = tag.attributes()
        let color: ?String = attributes.get("color")
        let size: ?String = attributes.get("size")
        let fontNode: FontNode = FontNode(color, size)
        visitChildren(visitor, renderer, tag, fontNode)
        return fontNode
    }

    public override func supportedTags(): Collection<String> {
        return ArrayList<String>(["font"])
    }
}

public class HeadingHandler <: TagHandler {
    public init() {
    }

    public override func handle(visitor: MarkdownVisitor, renderer: MarkdownHtmlRenderer, tag: HtmlTag): Node {
        var level: Int64
        try {
            level = Int64(tag.name()[1])
        } catch (e: Exception) {
            level = 0
        }
        if (level < 1 || level > 6) {
            return IgnoreNode()
        }
        let heading: Heading = Heading()
        heading.setLevel(level)
        visitChildren(visitor, renderer, tag, heading)
        return heading
    }

    public override func supportedTags(): Collection<String> {
        return ArrayList<String>(["h1", "h2", "h3", "h4", "h5", "h6"])
    }
}

public class ImageHandler <: TagHandler {
    public init() {
    }

    public override func handle(visitor: MarkdownVisitor, renderer: MarkdownHtmlRenderer, tag: HtmlTag): Node {
        let attributes: Map<String, String> = tag.attributes()
        let src: ?String = attributes.get("src")
        let width: ?String = attributes.get("width")
        let height: ?String = attributes.get("height")

        if (let Some(v) <- src) {
            let imageHtmlNode: ImageHtmlNode = ImageHtmlNode(v, width, height)
            visitChildren(visitor, renderer, tag, imageHtmlNode)
            return imageHtmlNode
        } else {
            let ignoreNode: IgnoreNode = IgnoreNode()
            visitChildren(visitor, renderer, tag, ignoreNode)
            return ignoreNode
        }
    }

    public override func supportedTags(): Collection<String> {
        return ArrayList<String>(["img"])
    }
}

public class LinkHandler <: TagHandler {
    public init() {
    }

    public override func handle(visitor: MarkdownVisitor, renderer: MarkdownHtmlRenderer, tag: HtmlTag): Node {
        let attributes: Map<String, String> = tag.attributes()
        let destination: ?String = attributes.get("href")
        let title: ?String = attributes.get("title")
        if (let Some(v) <- destination) {
            let link: Link = Link(v, title)
            visitChildren(visitor, renderer, tag, link)
            return link
        } else {
            let ignoreNode: IgnoreNode = IgnoreNode()
            visitChildren(visitor, renderer, tag, ignoreNode)
            return ignoreNode
        }
    }

    public override func supportedTags(): Collection<String> {
        return ArrayList<String>(["a"])
    }
}

public class StrongEmphasisHandler <: TagHandler {
    public init() {
    }

    public override func handle(visitor: MarkdownVisitor, renderer: MarkdownHtmlRenderer, tag: HtmlTag): Node {
        let strongEmphasis: StrongEmphasis = StrongEmphasis()
        visitChildren(visitor, renderer, tag, strongEmphasis)
        return strongEmphasis
    }

    public override func supportedTags(): Collection<String> {
        return ArrayList<String>(["b", "strong"])
    }
}

public class EmphasisHandler <: TagHandler {
    public init() {
    }

    public override func handle(visitor: MarkdownVisitor, renderer: MarkdownHtmlRenderer, tag: HtmlTag): Node {
        let emphasis: Emphasis = Emphasis()
        visitChildren(visitor, renderer, tag, emphasis)
        return emphasis
    }

    public override func supportedTags(): Collection<String> {
        return ArrayList<String>(["i", "em", "cite", "dfn"])
    }
}

public class StrikeHandler <: TagHandler {
    public init() {
    }

    public override func handle(visitor: MarkdownVisitor, renderer: MarkdownHtmlRenderer, tag: HtmlTag): Node {
        let strikethrough: Strikethrough = Strikethrough()
        visitChildren(visitor, renderer, tag, strikethrough)
        return strikethrough
    }

    public override func supportedTags(): Collection<String> {
        return ArrayList<String>(["s", "del"])
    }
}

public class BlockquoteHandler <: TagHandler {
    public init() {
    }

    public override func handle(visitor: MarkdownVisitor, renderer: MarkdownHtmlRenderer, tag: HtmlTag): Node {
        let blockQuote: BlockQuote = BlockQuote()
        visitChildren(visitor, renderer, tag, blockQuote)
        return blockQuote
    }

    public override func supportedTags(): Collection<String> {
        return ArrayList<String>(["blockquote"])
    }
}

public class BulletListHandler <: TagHandler {
    public init() {
    }

    public override func handle(visitor: MarkdownVisitor, renderer: MarkdownHtmlRenderer, tag: HtmlTag): Node {
        let bulletList: BulletList = BulletList(Rune(b'-'))
        visitChildren(visitor, renderer, tag, bulletList)
        return bulletList
    }

    public override func supportedTags(): Collection<String> {
        return ArrayList<String>(["ul"])
    }
}

public class OrderedListHandler <: TagHandler {
    public init() {
    }

    public override func handle(visitor: MarkdownVisitor, renderer: MarkdownHtmlRenderer, tag: HtmlTag): Node {
        let attributes: Map<String, String> = tag.attributes()
        let start: ?String = attributes.get("start")
        if (let Some(v) <- start) {
            let orderedList: OrderedList = OrderedList(Int64.parse(v), Rune(b'-'))
            visitChildren(visitor, renderer, tag, orderedList)
            return orderedList
        } else {
            let ignoreNode: IgnoreNode = IgnoreNode()
            visitChildren(visitor, renderer, tag, ignoreNode)
            return ignoreNode
        }
    }

    public override func supportedTags(): Collection<String> {
        return ArrayList<String>(["ol"])
    }
}

public class ListItemHandler <: TagHandler {
    public init() {
    }

    public override func handle(visitor: MarkdownVisitor, renderer: MarkdownHtmlRenderer, tag: HtmlTag): Node {
        let listItem: ListItem = ListItem()
        visitChildren(visitor, renderer, tag, listItem)
        return listItem
    }

    public override func supportedTags(): Collection<String> {
        return ArrayList<String>(["li"])
    }
}
