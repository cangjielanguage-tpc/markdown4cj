// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main --no-progress
import std.runtime.*

//导入mock框架包
import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

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
    .usePlugin(LinkifyPlugin.create())
    .usePlugin(ImageTextMixPlugin.create())
    .usePlugin(TocPlugin.create())
    .usePlugin(IdHeadingPlugin.create())
    .usePlugin(DescListPlugin.create())
    .usePlugin(LooseDelimiterPlugin.create())
    .usePlugin(HighlightDelimeterPlugin.create())
    .build()

@Test
public func test0(): Unit {
    var str = #"
** 《2026年校园膳食经费管理专项检查表》 **
**《2026年校园膳食经费管理专项检查表》 **
** 《2026年校园膳食经费管理专项检查表》**
**《2026年校园膳食经费管理专项检查表》**
"#
    var doc = markdown.parse(str)
    printNode(doc)
    let p = doc[0]
    @Assert(p[0].getNodeType(), "StrongEmphasis")
    @Assert(p[2].getNodeType(), "StrongEmphasis")
    @Assert(p[4].getNodeType(), "StrongEmphasis")
    @Assert(p[6].getNodeType(), "StrongEmphasis")
}

/* 宽松分隔符插件 */
public class LooseDelimiterPlugin <: AbstractMarkdownPlugin {
    public static func create(): LooseDelimiterPlugin {
        return LooseDelimiterPlugin()
    }
    public func configureParser(parser: ParserBuilder): Unit {
        parser.delimiterOpenCloseProcessor(
            {ctx: DelimiterOpenCloseContext => ctx.defaultResultWith({_ => false}, {_ => false})})
    }

    public func getClassType(): String {
        "LooseDelimiterPlugin"
    }
}
/* 带白名单的宽松分隔符插件 */
public class WhitelistLooseDelimiterPlugin <: AbstractMarkdownPlugin {
    public WhitelistLooseDelimiterPlugin(let whitelist: Array<String>) {}
    public func configureParser(parser: ParserBuilder): Unit {
        parser.delimiterOpenCloseProcessor(
            {
                ctx: DelimiterOpenCloseContext =>
                    let delimiter: String = ctx.delimiterChar().toString() * ctx.delimiterCount()
                    if (whitelist.contains(delimiter)) {
                        // 白名单内的分隔符, 宽松判断: 忽略分隔符前后的空格与标点
                        ctx.defaultResultWith({_ => false}, {_ => false})
                    } else {
                        // 非白名单内的分隔符, 默认判断
                        ctx.defaultResult()
                    }
            }
        )
    }
    public func getClassType(): String {
        "WhitelistLooseDelimiterPlugin"
    }
}

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

@Test
public func test2(): Unit {
    var str = #"
== 《2026年校园膳食经费管理专项检查表》 ==
==《2026年校园膳食经费管理专项检查表》 ==
== 《2026年校园膳食经费管理专项检查表》==
==《2026年校园膳食经费管理专项检查表》==
"#
    var doc = markdown.parse(str)
    printNode(doc)
    let p = doc[0]
    @Assert(p[0].getNodeType(), "HighlightNode")
    @Assert(p[2].getNodeType(), "HighlightNode")
    @Assert(p[4].getNodeType(), "HighlightNode")
    @Assert(p[6].getNodeType(), "HighlightNode")
}
