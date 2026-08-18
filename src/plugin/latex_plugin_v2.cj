package markdown_parser.plugin

/**
 * 使用inline
 */
public class LatexMathPluginV2 <: AbstractMarkdownPlugin {
    public static func create(): LatexMathPluginV2 {
        return LatexMathPluginV2()
    }

    public func configureParser(builder: ParserBuilder): Unit {
        builder.customBlockParserFactory(LatexBlockParserFactory()) // 块解析: $$ \[\]
        builder.customInlineContentParserFactory(LatexInlineParserFactory()) // 行内解析: $...$ \(...\) \[...\]
    }

    public func configureVisitor(_: MarkdownVisitorBuilder): Unit {
    }

    // @VisibleForTesting
    static func prepareLatexTextPlaceholder(latex: String): String {
        return latex.replace("\n", " ").trimAscii()
    }

    public func getClassType(): String {
        "LatexMathPluginV2"
    }
}

public class LatexInlineParser <: InlineContentParser {
    public func tryParse(inlineParserState: InlineParserState): ParsedInline {
        let scanner: Scanner = inlineParserState.getScanner()
        let p0: SourcePosition = scanner.position()

        let open = scanner.matchMultiple(b'$')
        if (open > 0) {
            let p1 = scanner.position()
            while (true) {
                if (scanner.find(b'$') < 0) {
                    break
                }
                if (scanner.peekPrev() == b'\\') {
                    scanner.next()
                    continue
                }
                let p2 = scanner.position()
                let close = scanner.matchMultiple(b'$')
                if (close > 0) {
                    let content = scanner.getSource(p1, p2).getContent()
                    return ParsedInline.of(LatexMathNode(content), scanner.position())
                }
            }
        } else if (scanner.next('\\(') || scanner.next('\\[')) {
            let p1 = scanner.position()
            var p2 = scanner.position()
            while (scanner.hasNext() && scanner.peek() != b'\n') {
                if (scanner.next('\\)') || scanner.next('\\]')) {
                    let content = scanner.getSource(p1, p2).getContent()
                    return ParsedInline.of(LatexMathNode(content), scanner.position())
                } else {
                    scanner.next()
                    p2 = scanner.position()
                }
            }
        }

        scanner.setPosition(p0)
        return ParsedInline.none()
    }
}

public class LatexInlineParserFactory <: InlineContentParserFactory {
    public override func getTriggerCharacters(): HashSet<Rune> {
        return HashSet([r'$', r'\\'])
    }

    public override func create(): InlineContentParser {
        return LatexInlineParser()
    }
}
