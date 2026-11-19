// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main 
import std.runtime.*

let markdown: Markdown = Markdown
    .builder()
    // HTML插件
    .usePlugin(HtmlPlugin.create())
    // 任务列表插件
    .usePlugin(TaskListPlugin.create())
    .usePlugin(SubPlugin())
    // 删除线插件
    .usePlugin(StrikethroughPlugin.create())
    .usePlugin(SupPlugin())
    // 表格插件
    .usePlugin(TablePlugin.create())
    // 数学公式
    .usePlugin(LatexMathPluginV2.create())
    // 音频
    .usePlugin(BlockAudioPlugin.create())
    // 视频
    .usePlugin(BlockVideoPlugin.create())
    // 链接
    .usePlugin(LinkViewPlugin.create())
    // 脚注
    .usePlugin(FootnotePlugin.create())
    // 图片列表
    .usePlugin(ImageCollectPlugin.create())
    // .usePlugin(NodeIdPlugin.create())
    .usePlugin(LinkifyPlugin.create())
    .usePlugin(ImageTextMixPlugin.create())
    .usePlugin(TocPlugin.create())
    .usePlugin(IdHeadingPlugin.create())
    .build()

@Test
public func test0(): Unit {
    var str = #"
<u>underline</u><sub>2</sub><sup>3</sup>~4~^5^
"#
    let node = markdown.parse(str)
    printNode(node)
    let nodeView = markdown.render(node)
    printNode(node)
    printNode(nodeView)

    @Assert(nodeView[0][0] is UnderlineNode)
    @Assert(nodeView[0][1] is SubNode)
    @Assert(nodeView[0][2] is SupNode)
    @Assert(nodeView[0][3] is SubNode)
    @Assert(nodeView[0][4] is SupNode)
}

/* 

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
                    view.props?.add("SubNode", node)
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
            println("SubDelimiterProcessor getDelimiterUse 1 ${opener.canOpen()} ${opener.canClose()} ${opener.getLength()} ${opener.getOriginalLength()}")
            return 1
        } else {
            println("SubDelimiterProcessor getDelimiterUse 0")
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
                    view.props?.add("SupNode", node)
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

 */
