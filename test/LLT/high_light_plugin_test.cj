// DEPENDENCE: z_test.cj
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
    .usePlugin(HighlightDelimeterPlugin.create())
    .usePlugin(WhitelistLooseDelimiterPlugin.create(DelimiterFilterMode.Permissive))
    .build()

@Test
public func test1(): Unit {
    var str = #""#
    str = "==**粗体==内嵌高亮==粗体结束**=="
    var doc = markdown.toMarkdown(str)
    @Assert(doc[0][0].getNodeType(), "HighlightNode")
    @Assert(doc[0][1].getNodeType(), "Text")
    @Assert(doc[0][2].getNodeType(), "HighlightNode")
    @Assert((doc[0][2][0] as Text)?.getLiteral(), "粗体结束**")
}

@Test
public func test0(): Unit {
    var str = #""#
    str = "_下横线1_"
    printNode(markdown.parse(str))
    str = "__下横线2__"
    printNode(markdown.parse(str))
    str = "___下横线3___"
    printNode(markdown.parse(str))

    str = "*星号1*"
    printNode(markdown.parse(str))
    str = "**星号2**"
    printNode(markdown.parse(str))
    str = "***星号3***"
    printNode(markdown.parse(str))

    str = "__第一组____第二组____第三组__"
    printNode(markdown.parse(str))
    str = "**第一组****第二组****第三组**"
    printNode(markdown.parse(str))
    
    str = "__第一组___"
    printNode(markdown.parse(str))
    str = "**第一组***"
    printNode(markdown.parse(str))
    str = "==第一组==="
    printNode(markdown.parse(str))
    str = "==第一组=="
    printNode(markdown.parse(str))
    str = "==带符号!@#==单元格"
    printNode(markdown.parse(str))
    
    str = "==`代==码`=="
    printNode(markdown.parse(str))
    str = "**`代**码`**"
    printNode(markdown.parse(str))
}
