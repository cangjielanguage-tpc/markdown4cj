/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.plugin

class MarkdownHtmlRendererImpl <: MarkdownHtmlRenderer {
    private let allowNonClosedTags: Bool

    private let tagHandlers: Map<String, TagHandler>

    init(allowNonClosedTags: Bool, tagHandlers: Map<String, TagHandler>) {
        super()
        this.allowNonClosedTags = allowNonClosedTags
        this.tagHandlers = tagHandlers
    }

    public override func render(visitor: MarkdownVisitor, parser: MarkdownHtmlParser, rootTag: HtmlTag): Node {
        let end: Int64
        // TODO
        if (!allowNonClosedTags) {
            end = NO_END
        } else {
            end = NO_END
        }
        //        parser.flushInlineTags(end, FlushAction1(this,visitor))
        //        parser.flushBlockTags(end, FlushAction2(this,visitor))
        parser.reset()
        throw Exception("TODO")
    }

    public override func tagHandler(tagName: String): ?TagHandler {
        return tagHandlers.get(tagName) ?? None
    }
}

class FlushAction1 <: FlushAction<InlineHtmlTag> {
    var markdownHtmlRendererImpl: MarkdownHtmlRendererImpl
    var visitor: MarkdownVisitor
    public init(markdownHtmlRendererImpl: MarkdownHtmlRendererImpl, visitor: MarkdownVisitor) {
        this.markdownHtmlRendererImpl = markdownHtmlRendererImpl
        this.visitor = visitor
    }

    public override func apply(tags: Collection<InlineHtmlTag>): Unit {
        var handler: ?TagHandler
        for (inline in tags) {
            if (!inline.isClosed()) {
                continue
            }
            handler = markdownHtmlRendererImpl.tagHandler(inline.name())
            if (handler.isSome()) {
               // handler?.handle(visitor, markdownHtmlRendererImpl, inline)
            }
        }
    }
}

class FlushAction2 <: FlushAction<BlockHtmlTag> {
    var markdownHtmlRendererImpl: MarkdownHtmlRendererImpl
    var visitor: MarkdownVisitor
    public init(markdownHtmlRendererImpl: MarkdownHtmlRendererImpl, visitor: MarkdownVisitor) {
        this.markdownHtmlRendererImpl = markdownHtmlRendererImpl
        this.visitor = visitor
    }

    public override func apply(tags: Collection<BlockHtmlTag>): Unit {
        var handler: ?TagHandler
        for (block in tags) {
            if (!block.isClosed()) {
                continue
            }
            handler = markdownHtmlRendererImpl.tagHandler(block.name())
            if (handler.isSome()) {
                // handler?.handle(visitor, markdownHtmlRendererImpl, block)
            } else {
                apply(block.children())
            }
        }
    }
}

public class MarkdownHtmlRendererImplBuilder {
    init() {}

    private let tagHandlers: Map<String, TagHandler> = HashMap<String, TagHandler>(2)

    private var allowNonClosedTags: Bool = false

    private var excludeDefaults: Bool = false

    private var isBuilt: Bool = false

    public func allowNonClosedTagsMethod(allowNonClosedTags: Bool): Unit {
        checkState()
        this.allowNonClosedTags = allowNonClosedTags
    }

    public func addHandler(tagHandler: TagHandler): Unit {
        checkState()
        for (tag in tagHandler.supportedTags()) {
            tagHandlers.put(tag, tagHandler)
        }
    }

    public func getHandler(tagName: String): ?TagHandler {
        checkState()
        return tagHandlers.get(tagName) ?? None
    }

    public func excludeDefaultsMethod(excludeDefaults: Bool): Unit {
        checkState()
        this.excludeDefaults = excludeDefaults
    }

    public func excludeDefaultsMethod(): Bool {
        return excludeDefaults
    }

    public func build(): MarkdownHtmlRenderer {
        checkState()
        isBuilt = true
        return if (Int64(tagHandlers.size) > 0) {
            MarkdownHtmlRendererImpl(allowNonClosedTags, tagHandlers)
        } else {
            MarkdownHtmlRendererNoOp()
        }
    }

    private func checkState(): Unit {
        if (isBuilt) {
            throw Exception("Builder has been already built")
        }
    }

    public func addDefaultTagHandler(tagHandler: TagHandler): Unit {
        for (tag in tagHandler.supportedTags()) {
            if (!tagHandlers.contains(tag)) {
                tagHandlers.put(tag, tagHandler)
            }
        }
    }
}
