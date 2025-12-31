/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 */
package markdown.plugin

public open class SubNode <: CustomNode {
    public open override func getNodeType(): NodeType {
        return "SubNode"
    }
}

public class SubHtmlNode <: SubNode {
    public override func getNodeType(): NodeType {
        return "SubHtmlNode"
    }
}

public open class SupNode <: CustomNode {
    public open override func getNodeType(): NodeType {
        return "SupNode"
    }
}

public class SupHtmlNode <: SupNode {
    public override func getNodeType(): NodeType {
        return "SupHtmlNode"
    }
}

public class UnderlineNode <: CustomNode {
    public override func getNodeType(): NodeType {
        return "UnderlineNode"
    }
}

public class SubHandler <: TagHandler {
    public override func handle(visitor: ?MarkdownVisitor, renderer: MarkdownHtmlRenderer, tag: HtmlTag): Node {
        let sub = SubHtmlNode()
        visitChildren(visitor, renderer, tag, sub)
        return sub
    }
    public override func supportedTags(): Collection<String> {
        return ["sub"]
    }
}

public class SupHandler <: TagHandler {
    public override func handle(visitor: ?MarkdownVisitor, renderer: MarkdownHtmlRenderer, tag: HtmlTag): Node {
        let sup = SupHtmlNode()
        visitChildren(visitor, renderer, tag, sup)
        return sup
    }
    public override func supportedTags(): Collection<String> {
        return ["sup"]
    }
}

public class UnderlineHandler <: TagHandler {
    public override func handle(visitor: ?MarkdownVisitor, renderer: MarkdownHtmlRenderer, tag: HtmlTag): Node {
        let underline = UnderlineNode()
        visitChildren(visitor, renderer, tag, underline)
        return underline
    }
    public override func supportedTags(): Collection<String> {
        return ["u"]
    }
}

public class SubPlugin <: AbstractMarkdownPlugin {
    public func configureParser(parser: ParserBuilder): Unit {
        parser.customDelimiterProcessor(SubDelimiterProcessor())
    }
    public func configureVisitor(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            "SubNode",
            {
                visitor, node =>
                    let view = buildView(node, false, needProps: true)
                    view.props?.add("SubNode", true)
                    visitor.visitChildren(node)
            }
        )
    }
    public func getClassType(): String {
        "SubPlugin"
    }
}

class SubDelimiterProcessor <: DelimiterProcessor {
    public func getOpeningCharacter(): Rune {
        return r'~'
    }
    public func getClosingCharacter(): Rune {
        return r'~'
    }
    public func getMinLength(): Int {
        return 1
    }
    public func getDelimiterUse(opener: DelimiterRun, closer: DelimiterRun): Int {
        if (opener.getLength() == 1 && closer.getLength() >= 1) {
            return 1
        } else {
            return 0
        }
    }
    public override func process(opener: Text, closer: Text, _: Int64): Unit {
        var sub: Node = SubNode()

        var tmp: ?Node = opener.getNext()
        while (let Some(v) <- tmp && v != closer) {
            tmp = v.getNext()
            sub.appendChild(v)
        }

        opener.insertAfter(sub)
    }
}

public class SupPlugin <: AbstractMarkdownPlugin {
    public func configureParser(parser: ParserBuilder): Unit {
        parser.customDelimiterProcessor(SupDelimiterProcessor())
    }
    public func configureVisitor(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            "SupNode",
            {
                visitor, node =>
                    let view = buildView(node, false, needProps: true)
                    view.props?.add("SupNode", true)
                    visitor.visitChildren(node)
            }
        )
    }
    public func getClassType(): String {
        "SupPlugin"
    }
}

class SupDelimiterProcessor <: DelimiterProcessor {
    public func getOpeningCharacter(): Rune {
        return r'^'
    }
    public func getClosingCharacter(): Rune {
        return r'^'
    }
    public func getMinLength(): Int {
        return 1
    }
    public func getDelimiterUse(opener: DelimiterRun, closer: DelimiterRun): Int {
        if (opener.getLength() >= 1 && closer.getLength() >= 1) {
            return 1
        } else {
            return 0
        }
    }
    public override func process(opener: Text, closer: Text, _: Int64): Unit {
        var sup: Node = SupNode()

        var tmp: ?Node = opener.getNext()
        while (let Some(v) <- tmp && v != closer) {
            tmp = v.getNext()
            sup.appendChild(v)
        }

        opener.insertAfter(sup)
    }
}
