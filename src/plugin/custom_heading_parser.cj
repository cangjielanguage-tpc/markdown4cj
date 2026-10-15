package markdown_parser.plugin

/**
 * 自定义标题解析插件。
 *
 * - 默认（setextEnabled = true）完全 no-op：不注册任何东西，完全沿用 commonmark 内置
 *   HeadingParser / HeadingParserFactory 流程（ATX + setext 均由内置处理）。
 * - setextEnabled = false 时关闭 setext：内置 HeadingParserFactory 同时负责 ATX 与 setext，
 *   无法单独摘除 setext，因此这里移除内置 Heading 工厂（enabledBlockTypes 去掉 "Heading"），
 *   改用只处理 ATX 的 CustomHeadingParserFactory 替换。
 *
 * 关闭 setext 后的行为：
 * - "# Title"     -> Heading level 1（ATX 保留）
 * - "Title\n==="  -> Paragraph（"===" 作为段落文本）
 * - "Title\n---"  -> Paragraph "Title" + ThematicBreak
 */
public class CustomHeadingParserPlugin <: AbstractMarkdownPlugin {
    private let setextEnabled: Bool

    // 传 true 即"默认不做任何事"，沿用内置 HeadingParser 流程；传 false 关闭 setext。
    public init(setextEnabled: Bool) {
        this.setextEnabled = setextEnabled
    }

    public func configureParser(builder: ParserBuilder): Unit {
        if (setextEnabled) {
            // 默认 no-op：走内置 HeadingParser 流程
            return
        }
        // 注意：enabledBlockTypes 是整集替换，会覆盖此前的设置。
        // 拷贝 CorePlugin 的默认块类型并剔除 "Heading"，避免硬编码漂移。
        let types = HashSet<String>()
        for (t in CorePlugin.enabledBlockTypes) {
            if (t != "Heading") {
                types.add(t)
            }
        }
        builder.enabledBlockTypes(types)
        builder.customBlockParserFactory(CustomHeadingParserFactory())
    }

    public func getClassType(): String {
        return "CustomHeadingParserPlugin"
    }
}

/**
 * 改造自 commonmark 的 HeadingParserFactory：只处理 ATX，不再处理 setext。
 */
class CustomHeadingParserFactory <: BlockParserFactory {
    public func tryStart(state: ParserState, _: MatchedBlockParser): Option<BlockStart> {
        if (state.getIndent() >= Parsing.CODE_BLOCK_INDENT) {
            return BlockStart.none()
        }

        let line = state.getLine()
        let nextNonSpace = state.getNextNonSpaceIndex()
        if (line.getContent()[nextNonSpace] == b'#') {
            let atxHeading = CustomHeadingParser.getAtxHeading(line.substring(nextNonSpace, line.getContent().size))
            if (let Some(heading) <- atxHeading) {
                return BlockStart.of(heading).atIndex(line.getContent().size)
            }
        }

        // 不处理 setext 下划线行：交给内置 ThematicBreak（---）或段落续行（===）
        return BlockStart.none()
    }
}

/**
 * 改造自 commonmark 的 HeadingParser：保留 ATX 解析，去掉 setext 分支。
 */
class CustomHeadingParser <: AbstractBlockParser {
    private let block: Heading = Heading()
    private let content: SourceLines

    public init(level: Int64, content: SourceLines) {
        block.setLevel(level)
        this.content = content
    }

    public func getBlock(): Block {
        return block
    }

    public func tryContinue(_: ParserState): Option<BlockContinue> {
        // ATX 标题只有一行，标记解析完后没有更多内容可解析
        return BlockContinue.none()
    }

    public func parseInlines(inlineParser: InlineParser): Unit {
        inlineParser.parse(content, block)
    }

    // spec: An ATX heading consists of a string of characters, parsed as inline content, between an opening sequence of
    // 1-6 unescaped # characters and an optional closing sequence of any number of unescaped # characters. The opening
    // sequence of # characters must be followed by a space or by the end of line. The optional closing sequence of #s
    // must be preceded by a space and may be followed by spaces only.
    public static func getAtxHeading(line: SourceLine): Option<CustomHeadingParser> {
        let scanner = Scanner.of(SourceLines.of(line))
        var level: Int64 = scanner.matchMultiple(b'#')

        if (level == 0 || level > 6) {
            return None
        }

        if (!scanner.hasNext()) {
            // End of line after markers is an empty heading
            return CustomHeadingParser(level, SourceLines.empty())
        }

        var next = scanner.peek()
        if (!(next == b' ' || next == b'\t')) {
            return None
        }

        scanner.whitespace()
        let start = scanner.position()
        var end = start
        var hashCanEnd = true

        while (scanner.hasNext()) {
            let c = scanner.peek()
            match (c) {
                case b'#' =>
                    if (hashCanEnd) {
                        scanner.matchMultiple(b'#')
                        let whitespace = scanner.whitespace()
                        // If there's other characters, the hashes and spaces were part of the heading
                        if (scanner.hasNext()) {
                            end = scanner.position()
                        }
                        hashCanEnd = whitespace > 0
                    } else {
                        scanner.next()
                        end = scanner.position()
                    }
                case b' ' | '\t' =>
                    hashCanEnd = true
                    scanner.next()
                case _ =>
                    hashCanEnd = false
                    scanner.next()
                    end = scanner.position()
            }
        }

        let source = scanner.getSource(start, end)
        let content = source.getContent()
        if (content.isEmpty()) {
            return CustomHeadingParser(level, SourceLines.empty())
        }
        return CustomHeadingParser(level, source)
    }
}
