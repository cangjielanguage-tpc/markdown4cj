// RESOURCES: spec.md
// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: pwsh -command "cp ../../../target/release/markdown_parser/*.dll ."
// EXEC: pwsh -command "cp ../../../target/release/commonmark4cj/*.dll ."
// EXEC: ./main --no-progress
import std.runtime.*

let markdown: Markdown = Markdown
    .builder()
    // HTML插件
    .usePlugin(HtmlPlugin.create())
    // 任务列表插件
    .usePlugin(TaskListPlugin.create())
    // 删除线插件
    .usePlugin(StrikethroughPlugin.create())
    // 表格插件
    .usePlugin(TablePlugin.create())
    // 数学公式
    .usePlugin(LatexMathPluginV2.create())
    // 音频
    .usePlugin(BlockAudioPlugin.create())
    // 视频
    .usePlugin(BlockVideoPlugin.create())
    // 链接
    // .usePlugin(LinkViewPlugin.create())
    // 脚注
    .usePlugin(FootnotePlugin.create())
    // 图片列表
    .usePlugin(ImageCollectPlugin.create())
    // .usePlugin(NodeIdPlugin.create())
    .usePlugin(LinkifyPlugin.create("123","asd"))
    .usePlugin(ImageTextMixPlugin.create())
    .usePlugin(TocPlugin.create())
    .usePlugin(IdHeadingPlugin.create())
    .usePlugin(DescListPlugin.create())
    .build()

@Test
public func test0(): Unit {
    var str = #"
已部署至https://7sncmf6ezkojw.ok.kimi.link，可直接访问查看 完
"#
    var node1 = markdown.parse(str)
    printNode(node1)
    let text1 = (node1.getFirstChild()().getFirstChild()() as Text)()
    @Assert(text1.getLiteral(), "已部署至")
    @Assert((text1.getNext()() as Link)().getDestination(), "https://7sncmf6ezkojw.ok.kimi.link")
    @Assert((node1.getFirstChild()().getLastChild()() as Text)().getLiteral(), "，可直接访问查看 完")
    var nv1 = markdown.render(node1)
    printNode(node1)
    printNode(nv1)
    @Assert((nv1[0][0] as Text)().getLiteral(), "已部署至")
    @Assert((nv1[0][1][0] as Text)().getLiteral(), "https://7sncmf6ezkojw.ok.kimi.link")
    @Assert((nv1[0][2] as Text)().getLiteral(), "，可直接访问查看 完")
}
@Test
public func test1(): Unit {
    var str = #"
已部署至https://7sncmf6ezkojw.ok.kimi.link，可直接访123问查看 asd完
"#
    var doc = markdown.parse(str)
    printNode(doc)
    var p = doc.getFirstChild()()
    @Assert((p[0] as Text)().getLiteral(), "已部署至")
    @Assert((p[1] as Link)().getDestination(), "https://7sncmf6ezkojw.ok.kimi.link")
    @Assert((p[2] as Text)().getLiteral(), "，可直接访")
    @Assert((p[3] as Link)().getDestination(), "123")
    @Assert((p[4] as Text)().getLiteral(), "问查看 ")
    @Assert((p[5] as Link)().getDestination(), "asd")
    @Assert((p[6] as Text)().getLiteral(), "完")
    var nv1 = markdown.render(doc)
    printNode(doc)
    printNode(nv1)
    p = nv1[0]
    @Assert((p[0] as Text)().getLiteral(), "已部署至")
    @Assert((p[1] as Link)().getDestination(), "https://7sncmf6ezkojw.ok.kimi.link")
    @Assert((p[2] as Text)().getLiteral(), "，可直接访")
    @Assert((p[3] as Link)().getDestination(), "123")
    @Assert((p[4] as Text)().getLiteral(), "问查看 ")
    @Assert((p[5] as Link)().getDestination(), "asd")
    @Assert((p[6] as Text)().getLiteral(), "完")
}

public class LinkifyPlugin1 <: AbstractMarkdownPlugin {
    // static let urlreg = Regex(#"https?://\S+"#)
    static let urlreg = Regex(#"https?://[!*'();:@&=+$,/?#[\]a-zA-Z0-9-_.~]+"#)
    public static func create(): LinkifyPlugin {
        return LinkifyPlugin()
    }

    public func configureParser(parser: ParserBuilder): Unit {
        parser.postProcessor(LinkifyPostProcessor())
    }

    public func getClassType(): String {
        "LinkifyPlugin"
    }
}

class LinkifyPostProcessor <: PostProcessor {
    public func process(node: Node): Node {
        let visitor = LinkifyVisitor()
        node.accept(visitor)
        return node
    }
}

class LinkifyVisitor <: AbstractVisitor {
    static let urlreg = Regex(#"https?://[!*'();:@&=+$,/?#[\]a-zA-Z0-9-_.~]+"#)
    public func visit(node: Text): Unit {
        if (let Some(_: Link) <- node.getParent()) {
            return
        }

        let originTextNode = (node as Text)()
        let fulltext = originTextNode.getLiteral()
        var i = 0
        for (data in urlreg.lazyFindAll(fulltext)) {
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
