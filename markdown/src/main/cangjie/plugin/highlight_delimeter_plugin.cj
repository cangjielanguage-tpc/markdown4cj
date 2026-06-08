package markdown.plugin

public class HighlightDelimeterPlugin <: AbstractMarkdownPlugin {
    public static func create(): HighlightDelimeterPlugin {
        return HighlightDelimeterPlugin()
    }
    public func configureParser(parser: ParserBuilder): Unit {
        parser.customDelimiterProcessor(HighlightDelimiterProcessor())
    }

    public func getClassType(): String {
        "HighlightDelimeterPlugin"
    }
}

class HighlightDelimiterProcessor <: DelimiterProcessor {
    public override func getOpeningCharacter(): Rune {
        return r'='
    }
    public override func getClosingCharacter(): Rune {
        return r'='
    }
    public override func getMinLength(): Int64 {
        return 2
    }
    public override func process(openingRun: DelimiterRun, closingRun: DelimiterRun): Int {
        if (openingRun.getLength() != closingRun.getLength() || openingRun.getLength() != 2) {
            return 0
        }
        let opener = openingRun.getOpener()
        let delimiter = if (openingRun.getLength() == 1) {
            opener.getLiteral()
        } else {
            opener.getLiteral() + opener.getLiteral()
        }
        let hl = HighlightNode()
        let sourceSpans = SourceSpans()
        sourceSpans.addAllFromTexts(openingRun.getOpeners(openingRun.getLength()))
        for (node in Nodes.between(opener, closingRun.getCloser())) {
            hl.appendChild(node)
            sourceSpans.addAll(node.getSourceSpans())
        }
        sourceSpans.addAllFromTexts(closingRun.getClosers(closingRun.getLength()))
        hl.setSourceSpans(sourceSpans.getSourceSpans())
        opener.insertAfter(hl)
        return 2
    }
}

public class HighlightNode <: CustomNode {
    public func getNodeType(): String {
        "HighlightNode"
    }
}
