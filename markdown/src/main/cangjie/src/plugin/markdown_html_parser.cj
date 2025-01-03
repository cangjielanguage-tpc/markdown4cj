/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 */
package markdown.plugin

public type FlushAction<T> = (tags: Collection<T>) -> Unit

public type Appendable = StringBuilder

/**
 */
public abstract class MarkdownHtmlParser {
    /* T extends Appendable & CharSequence */
    public func processFragment(output: Appendable, htmlFragment: String): Unit

    /**
     * After this method exists a {@link MarkdownHtmlParser} will clear internal state for stored tags.
     * If you wish to process them further after this method exists create own copy of supplied
     * collection.
     *
     * @param documentLength known document length. This value is used to close all non-closed tags.
     *                       If you wish to keep them open (do not force close at the end of a
     *                       document pass here {@link HtmlTag#NO_END}. Later non-closed tags
     *                       can be detected by calling {@link HtmlTag#isClosed()}
     * @param action         {@link FlushAction} to be called with resulting tags ({@link InlineHtmlTag})
     */
    public func flushInlineTags(documentLength: Int, action: FlushAction<InlineHtmlTag>): Unit

    /**
     * After this method exists a {@link MarkdownHtmlParser} will clear internal state for stored tags.
     * If you wish to process them further after this method exists create own copy of supplied
     * collection.
     *
     * @param documentLength known document length. This value is used to close all non-closed tags.
     *                       If you wish to keep them open (do not force close at the end of a
     *                       document pass here {@link HtmlTag#NO_END}. Later non-closed tags
     *                       can be detected by calling {@link HtmlTag#isClosed()}
     * @param action         {@link FlushAction} to be called with resulting tags ({@link BlockHtmlTag})
     */
    public func flushBlockTags(
        documentLength: Int,
        action: FlushAction<BlockHtmlTag>
    ): Unit

    public func reset(): Unit
}

/**
 */
public class MarkdownHtmlParserImpl <: MarkdownHtmlParser {
    public static func create(): MarkdownHtmlParserImpl {
        return create(HtmlEmptyTagReplacement.create())
    }

    public static func create(inlineTagReplacement: HtmlEmptyTagReplacement): MarkdownHtmlParserImpl {
        return MarkdownHtmlParserImpl(inlineTagReplacement, TrimmingAppender.create())
    }

    private static let INLINE_TAGS: Set<String>

    private static let VOID_TAGS: Set<String>

    private static let BLOCK_TAGS: Set<String>

    private static let TAG_PARAGRAPH = "p"

    private static let TAG_LIST_ITEM = "li"

    static init() {
        INLINE_TAGS = HashSet<String>(
            ["a", "abbr", "acronym", "b", "bdo", "big", "br", "button", "cite", "code", "dfn", "em", "i", "img", "input",
                "kbd", "label", "map", "object", "q", "samp", "script", "select", "small", "span", "strong", "sub",
                "sup", "textarea", "time", "tt", "var"])
        VOID_TAGS = HashSet<String>(
            ["area", "base", "br", "col", "embed", "hr", "img", "input", "keygen", "link", "meta", "param", "source",
                "track", "wbr"])
        BLOCK_TAGS = HashSet<String>(
            ["address", "article", "aside", "blockquote", "canvas", "dd", "div", "dl", "dt", "fieldset", "figcaption",
                "figure", "footer", "form", "h1", "h2", "h3", "h4", "h5", "h6", "header", "hgroup", "hr", "li", "main",
                "nav", "noscript", "ol", "output", "p", "pre", "section", "table", "tfoot", "ul", "video"])
    }

    private let emptyTagReplacement: HtmlEmptyTagReplacement

    private let trimmingAppender: TrimmingAppender

    private let inlineTags = ArrayList<InlineImpl>(0)

    private var currentBlock: ?BlockImpl = BlockImpl.root()

    private var isInsidePreTag: Bool = false

    private var previousIsBlock: Bool = false

    init(replacement: HtmlEmptyTagReplacement, trimmingAppender: TrimmingAppender) {
        this.emptyTagReplacement = replacement
        this.trimmingAppender = trimmingAppender
    }

    public func processFragment(output: Appendable, htmlFragment: String): Unit {
        let tokeniser = Tokeniser(CharacterReader(htmlFragment), ParseErrorList.noTracking())
        while (true) {
            let token = tokeniser.read()
            let tokenType = token.typ
            if (TokenType.EOFType == tokenType) {
                break
            }
            match (tokenType) {
                case StartTagType =>
                    let startTag = (token as StartTagToken).getOrThrow()
                    if (isInlineTag(startTag._normalName.getOrThrow())) {
                        processInlineTagStart(output, startTag)
                    } else {
                        processBlockTagStart(output, startTag)
                    }
                case EndTagType =>
                    let endTag = (token as EndTagToken).getOrThrow()
                    if (isInlineTag(endTag._normalName.getOrThrow())) {
                        processInlineTagEnd(output, endTag)
                    } else {
                        processBlockTagEnd(output, endTag)
                    }
                case CharacterType => processCharacter(output, (token as CharacterToken).getOrThrow())
                case _ => ()
            }
            token.reset()
        }
    }

    public func flushInlineTags(documentLength: Int64, action: FlushAction<InlineHtmlTag>): Unit {
        if (inlineTags.size > 0) {
            if (documentLength > NO_END) {
                for (inline in inlineTags) {
                    inline.closeAt(documentLength)
                }
            }
            let list: Collection<InlineHtmlTag> = inlineTags |> map<InlineImpl, InlineHtmlTag> {v => v} |> collectArray
            action(list)
            inlineTags.clear()
        } else {
            action([])
        }
    }

    public func flushBlockTags(documentLength: Int64, action: FlushAction<BlockHtmlTag>): Unit {
        var block = currentBlock.getOrThrow()
        while (let Some(v) <- block._parent) {
            block = v
        }
        if (documentLength > NO_END) {
            block.closeAt(documentLength)
        }
        let children = block.children()
        if (children.size > 0) {
            action(children)
        } else {
            action([])
        }
        currentBlock = BlockImpl.root()
    }

    public override func reset(): Unit {
        inlineTags.clear()
        currentBlock = BlockImpl.root()
    }

    protected func processInlineTagStart(output: Appendable, startTag: StartTagToken): Unit {
        let name = startTag._normalName.getOrThrow()
        let inline = InlineImpl(name, output.size, extractAttributes(startTag))
        ensureNewLineIfPreviousWasBlock(output)
        if (isVoidTag(name) || startTag.selfClosing) {
            let replacement = emptyTagReplacement.replace(inline)
            if (replacement.isSome() && replacement().size > 0) {
                AppendableUtils.appendQuietly(output, replacement())
            }
            inline.closeAt(output.size)
        }
        inlineTags.append(inline)
    }

    protected func processInlineTagEnd(output: Appendable, endTag: EndTagToken): Unit {
        let openInline = findOpenInlineTag(endTag._normalName.getOrThrow())
        if (let Some(openInline) <- openInline) {
            if (isEmpty(output, openInline)) {
                appendEmptyTagReplacement(output, openInline)
            }
            openInline.closeAt(output.size)
        }
    }

    protected func processBlockTagStart(output: Appendable, startTag: StartTagToken): Unit {
        let name = startTag._normalName.getOrThrow()
        if (currentBlock?._name == TAG_PARAGRAPH) {
            currentBlock?.closeAt(output.size)
            AppendableUtils.appendQuietly(output, r'\n')
            currentBlock = currentBlock?._parent ?? None
        } else {
            if (TAG_LIST_ITEM == name && currentBlock?._name == TAG_LIST_ITEM) {
                currentBlock?.closeAt(output.size)
                currentBlock = currentBlock?._parent ?? None
            }
        }
        if (isBlockTag(name)) {
            isInsidePreTag = "pre" == name
            ensureNewLine(output)
        } else {
            ensureNewLineIfPreviousWasBlock(output)
        }
        let start = output.size
        let block = BlockImpl.create(name, start, extractAttributes(startTag), currentBlock)
        let isVoid = isVoidTag(name) || startTag.selfClosing
        if (isVoid) {
            let replacement = emptyTagReplacement.replace(block)
            if (replacement.isSome() && replacement().size > 0) {
                AppendableUtils.appendQuietly(output, replacement())
            }
            block.closeAt(output.size)
        }
        appendBlockChild(block._parent.getOrThrow(), block)
        if (!isVoid) {
            this.currentBlock = block
        }
    }

    protected func processBlockTagEnd(output: Appendable, endTag: EndTagToken): Unit {
        let name = endTag._normalName.getOrThrow()
        let block = findOpenBlockTag(endTag._normalName.getOrThrow())
        if (let Some(block) <- block) {
            if ("pre" == name) {
                isInsidePreTag = false
            }
            if (isEmpty(output, block)) {
                appendEmptyTagReplacement(output, block)
            }
            block.closeAt(output.size)
            if (!block.isEmpty()) {
                previousIsBlock = isBlockTag(block._name)
            }
            if (TAG_PARAGRAPH == name) {
                AppendableUtils.appendQuietly(output, r'\n')
            }
            this.currentBlock = block._parent
        }
    }

    protected func processCharacter(output: Appendable, character: CharacterToken): Unit {
        if (isInsidePreTag) {
            AppendableUtils.appendQuietly(output, character.getData())
        } else {
            ensureNewLineIfPreviousWasBlock(output)
            trimmingAppender.append(output, character.getData())
        }
    }

    protected func appendBlockChild(parent: BlockImpl, child: BlockImpl): Unit {
        var children = parent._children
        if (children.isNone()) {
            children = ArrayList<BlockImpl>(2)
            parent._children = children
        }
        children?.append(child)
    }

    protected func findOpenInlineTag(name: String): ?InlineImpl {
        var inline: InlineImpl
        for (i in inlineTags.size - 1..=-1 : -1) {
            inline = inlineTags[i]
            if (name == inline._name && inline._end < 0) {
                return inline
            }
        }
        return None
    }

    protected func findOpenBlockTag(name: String): ?BlockImpl {
        var blockTag = currentBlock
        while (blockTag.isSome() && !(blockTag()._name == name) && !blockTag().isClosed()) {
            blockTag = blockTag()._parent
        }
        return blockTag
    }

    protected func ensureNewLineIfPreviousWasBlock(output: Appendable): Unit {
        if (previousIsBlock) {
            ensureNewLine(output)
            previousIsBlock = false
        }
    }

    protected static func isInlineTag(name: String): Bool {
        return INLINE_TAGS.contains(name)
    }

    protected static func isVoidTag(name: String): Bool {
        return VOID_TAGS.contains(name)
    }

    protected static func isBlockTag(name: String): Bool {
        return BLOCK_TAGS.contains(name)
    }

    protected static func ensureNewLine(output: Appendable): Unit {
        let length = output.size
        if (length > 0 && b'\n' != output.toString()[length - 1]) {
            AppendableUtils.appendQuietly(output, r'\n')
        }
    }

    protected static func extractAttributes(startTag: StartTagToken): Map<String, String> {
        var map: Map<String, String>
        let attributes = startTag.attributes
        let size = attributes?.size ?? -1
        if (size > 0) {
            map = HashMap<String, String>(size)
            for (attribute in attributes()) {
                map.put(attribute.getKey().toAsciiLower(), attribute.getValue())
            }
        } else {
            map = HashMap<String, String>()
        }
        return map
    }

    protected static func isEmpty(output: Appendable, tag: HtmlTagImpl): Bool {
        return tag._start == output.size
    }

    protected func appendEmptyTagReplacement(output: Appendable, tag: HtmlTagImpl): Unit {
        let replacement = emptyTagReplacement.replace(tag)
        if (let Some(replacement) <- replacement) {
            AppendableUtils.appendQuietly(output, replacement)
        }
    }
}
