package markdown.plugin

public class LinkifyPlugin <: AbstractMarkdownPlugin {
    var regs: Array<String> = EMPTY_STRING_ARRAY
    public static func create(regs: Array<String>): LinkifyPlugin {
        let plugin = LinkifyPlugin()
        plugin.regs = regs
        return plugin
    }

    public func configureParser(parser: ParserBuilder): Unit {
        let proc = LinkifyPostProcessor(regs)
        parser.postProcessor(proc)
    }

    public func getClassType(): String {
        "LinkifyPlugin"
    }
}

class LinkifyPostProcessor <: PostProcessor {
    static let urlreg = #"https?://[!*'();:@&=+$,/?#[\]a-zA-Z0-9-_.~]+"#
    let multiMatcher: Regex
    LinkifyPostProcessor(let regs: Array<String>) {
        var multi: String = regs |> map {s => "(${s})"} |> collectString(delimiter: "|")
        multi = if (multi.isEmpty()) {
            urlreg
        } else {
            "(${urlreg})|${multi}"
        }
        multiMatcher = Regex(multi, RegexFlag.Unicode) /* cjlint-ignore !G.CHK.04 */
    }
    public func process(node: Node): Node {
        let visitor = LinkifyVisitor(multiMatcher)
        node.accept(visitor)
        return node
    }
}

class LinkifyVisitor <: AbstractVisitor {
    LinkifyVisitor(let multiMatcher: Regex) {}
    public func visit(node: Text): Unit {
        if (let Some(_: Link) <- node.getParent()) {
            return
        }

        let originTextNode = (node as Text)()
        let fulltext = originTextNode.getLiteral()
        var i = 0
        for (data in multiMatcher.lazyFindAll(fulltext)) {
            // 处理正则前的文本
            if (i < data.matchPosition().start) {
                let snippet = fulltext[i..data.matchPosition().start]
                let text = Text(snippet)
                originTextNode.insertBefore(text)
            }

            // 处理正则区
            let snippet = data.matchString()
            let link = Link(snippet, snippet)
            link.appendChild(Text(snippet))
            originTextNode.insertBefore(link)
            i = data.matchPosition().end
        }
        // 处理剩余文本
        if (i < fulltext.size) {
            let snippet = fulltext[i..]
            originTextNode.setLiteral(snippet)
        } else {
            originTextNode.unlink()
        }
    }
}
