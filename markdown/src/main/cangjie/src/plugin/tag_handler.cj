/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 */
package markdown.plugin

public abstract class TagHandler {
    public func handle(tag: HtmlTag): ?Node

    public func supportedTags(): Collection<String>

    protected static func visitChildren(visitor: MarkdownVisitor, renderer: MarkdownHtmlRenderer, block: BlockHtmlTag): Unit {
        var handler: ?TagHandler
        for (child in block.children()) {
            if (!child.isClosed()) {
                continue
            }
            handler = renderer.tagHandler(child.name())
            if (handler.isSome()) {
                handler?.handle(child)
            } else {
                visitChildren(visitor, renderer, child)
            }
        }
    }
}

public class BrHandler <: TagHandler {
    public init() {
    }

    public func handle(tag: HtmlTag): ?Node {
        return HardLineBreak()
    }

    public func supportedTags(): Collection<String> {
        return ArrayList<String>(["br"])
    }
}

public class FontHandler <: TagHandler {
    public init() {
    }

    public func handle(tag: HtmlTag): ?Node {
        let attributes: Map<String, String> = tag.attributes()
        let color: ?String = attributes.get("color")
        let size: ?String = attributes.get("size")
        return FontNode(color, size)
    }

    public func supportedTags(): Collection<String> {
        return ArrayList<String>(["font"])
    }
}

public class HeadingHandler <: TagHandler {
    public init() {
    }

    public func handle(tag: HtmlTag): ?Node {
        var level: Int64
        try {
            level = Int64(tag.name()[1])
        } catch (e: Exception) {
            level = 0
        }
        if (level < 1 || level > 6) {
            return None
        }
        let heading: Heading = Heading()
        heading.setLevel(level)
        return heading
    }

    public func supportedTags(): Collection<String> {
        return ArrayList<String>(["h1", "h2", "h3", "h4", "h5", "h6"])
    }
}

public class ThematicBreakHandler <: TagHandler {
    public init() {
    }

    public func handle(tag: HtmlTag): ?Node {
        return ThematicBreak()
    }

    public func supportedTags(): Collection<String> {
        return ArrayList<String>(["hr"])
    }
}

public class ImageHandler <: TagHandler {
    public init() {
    }

    public func handle(tag: HtmlTag): ?Node {
        let attributes: Map<String, String> = tag.attributes()
        let src: ?String = attributes.get("src")
        let width: ?String = attributes.get("width")
        let height: ?String = attributes.get("height")
        if (let Some(v) <- src) {
            return ImageHtmlNode(v, width, height)
        } else {
            return None
        }
    }

    public func supportedTags(): Collection<String> {
        return ArrayList<String>(["img"])
    }
}

public class LinkHandler <: TagHandler {
    public init() {
    }

    public func handle(tag: HtmlTag): ?Node {
        let attributes: Map<String, String> = tag.attributes()
        let destination: ?String = attributes.get("href")
        let title: ?String = attributes.get("title")
        if (let Some(v) <- destination) {
            return Link(v, title)
        } else {
            return None
        }
    }

    public func supportedTags(): Collection<String> {
        return ArrayList<String>(["a"])
    }
}

public class StrongEmphasisHandler <: TagHandler {
    public init() {
    }

    public func handle(tag: HtmlTag): ?Node {
        return StrongEmphasis()
    }

    public func supportedTags(): Collection<String> {
        return ArrayList<String>(["b","strong"])
    }
}

public class EmphasisHandler <: TagHandler {
    public init() {
    }

    public func handle(tag: HtmlTag): ?Node {
        return Emphasis()
    }

    public func supportedTags(): Collection<String> {
        return ArrayList<String>(["i", "em", "cite", "dfn"])
    }
}

