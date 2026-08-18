package markdown_parser.core

/**
 * @see CoreProps
 */
public class CorePlugin <: AbstractMarkdownPlugin {
    public func getClassType(): String {
        "CorePlugin"
    }

    public static func create(): CorePlugin {
        return CorePlugin()
    }

    /**
     * @return a set with enabled by default block types
     * Set<Class<? <: Block>>
     */
    public static let enabledBlockTypes: HashSet<String> = HashSet<String>(
        [
            "BlockQuote",
            "Heading",
            "FencedCodeBlock",
            "HtmlBlock",
            "ThematicBreak",
            "ListBlock",
            "IndentedCodeBlock"
        ]
    )

    private let onTextAddedListeners: ArrayList<OnTextAddedListener> = ArrayList<OnTextAddedListener>(0)

    private var _hasExplicitMovementMethod: Bool = false

    protected init() {
    }

    public func hasExplicitMovementMethod(hasExplicitMovementMethod: Bool): CorePlugin {
        this._hasExplicitMovementMethod = hasExplicitMovementMethod
        return this
    }

    /**
     * Can be useful to post-process text added. For example for auto-linking capabilities.
     * @see OnTextAddedListener
     */
    public func addOnTextAddedListener(onTextAddedListener: OnTextAddedListener): CorePlugin {
        onTextAddedListeners.add(onTextAddedListener)
        return this
    }

    public override func configureVisitor(builder: MarkdownVisitorBuilder): Unit {
        blockQuote(builder)
        bulletList(builder)
        code(builder)
        emphasis(builder)
        fencedCodeBlock(builder)
        hardLineBreak(builder)
        heading(builder)
        image(builder)
        indentedCodeBlock(builder)
        link(builder)
        listItem(builder)
        orderedList(builder)
        paragraph(builder)
        softLineBreak(builder)
        strongEmphasis(builder)
        text(builder)
        thematicBreak(builder)
    }

    private func text(_: MarkdownVisitorBuilder): Unit {
    }

    private static func strongEmphasis(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            "StrongEmphasis",
            {
                visitor, strongEmphasis => visitor.visitChildren(strongEmphasis)
            }
        )
    }

    private static func emphasis(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            "Emphasis",
            {
                visitor, emphasis => visitor.visitChildren(emphasis)
            }
        )
    }

    private static func blockQuote(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            "BlockQuote",
            {
                visitor, blockQuote => visitor.visitChildren(blockQuote)
            }
        )
    }

    private static func code(_: MarkdownVisitorBuilder): Unit {
    }

    private static func fencedCodeBlock(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            "FencedCodeBlock",
            {
                visitor, node =>
                    let fencedCodeBlock: FencedCodeBlock = (node as FencedCodeBlock)()
                    visitCodeBlock(visitor, fencedCodeBlock.getInfo(), fencedCodeBlock.getLiteral(), fencedCodeBlock)
            }
        )
    }

    private static func indentedCodeBlock(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            "IndentedCodeBlock",
            {
                visitor, node =>
                    let indentedCodeBlock: IndentedCodeBlock = (node as IndentedCodeBlock)()
                    visitCodeBlock(visitor, Option<String>.None, indentedCodeBlock.getLiteral(), indentedCodeBlock)
            }
        )
    }

    // This method is moved from ImagesPlugin. Alternative implementations must set SpanFactory
    // for Image node in order for this visitor to function
    private static func image(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            "Image",
            {
                visitor, image => visitor.visitChildren(image)
            }
        )
    }

    static func visitCodeBlock(_: MarkdownVisitor, _: ?String, _: String, _: Node): Unit {
    }

    private static func bulletList(builder: MarkdownVisitorBuilder): Unit {
        builder.on("BulletList", SimpleBlockNodeVisitor)
    }

    private static func orderedList(builder: MarkdownVisitorBuilder): Unit {
        builder.on("OrderedList", SimpleBlockNodeVisitor)
    }

    private static func listItem(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            "ListItem",
            {
                visitor, listItem => visitor.visitChildren(listItem)
            }
        )
    }

    private static func thematicBreak(_: MarkdownVisitorBuilder): Unit {
    }

    private static func heading(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            "Heading",
            {
                visitor, heading => visitor.visitChildren(heading)
            }
        )
    }

    private static func softLineBreak(_: MarkdownVisitorBuilder): Unit {
    }

    private static func hardLineBreak(_: MarkdownVisitorBuilder): Unit {
    }

    private static func paragraph(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            "Paragraph",
            {
                visitor, paragraph => visitor.visitChildren(paragraph)
            }
        )
    }

    private static func link(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            "Link",
            {
                visitor, link => visitor.visitChildren(link)
            }
        )
    }
}

/**
 * @see #addOnTextAddedListener(OnTextAddedListener)
 */
public interface OnTextAddedListener {

    /**
     * Will be called when text is added to resulting {@link SpannableBuilder}.
     * Please note that only text represented by {@link Text} node will trigger this callback
     * (text inside code and code-blocks won\'t trigger it).
     * <p>
     * Please note that if you wish to append spans you must use {@code start} parameter
     * in order to place spans correctly ({@code start} represents the index at which {@code text}
     * was added). So, to set a span for the whole length of the text added one should use:
     * <p>
     * {@code
     * visitor.builder().setSpan(MySpan(), start, start + text.length(), 0)
     * }
     *
     * @param visitor {@link MarkdownVisitor}
     * @param text    literal that had been added
     * @param start   index in {@code visitor} as which text had been added
     * @see #addOnTextAddedListener(OnTextAddedListener)
     */
    func onTextAdded(visitor: MarkdownVisitor, text: String, start: Int): Unit
}

func SimpleBlockNodeVisitor(visitor: MarkdownVisitor, node: Node): Unit {
    visitor.visitChildren(node)
}
