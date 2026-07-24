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
        let opener = openingRun.getOpener()
        let closer = closingRun.getCloser()
        if (openingRun.getLength() < 2 || closingRun.getLength() < 2) {
            return 0
        }
        let hl = HighlightNode()
        let sourceSpans = SourceSpans()
        sourceSpans.addAllFromTexts(openingRun.getOpeners(openingRun.getLength()))
        for (node in Nodes.between(opener, closer)) {
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
