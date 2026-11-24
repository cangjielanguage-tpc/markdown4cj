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
    // 脚注
    .usePlugin(FootnotePlugin.create())
    // 图片列表
    .usePlugin(ImageCollectPlugin.create())
    .usePlugin(NodeIdPlugin.create())
    .usePlugin(LinkifyPlugin.create())
    // .usePlugin(ImageTextMixPlugin.create())
    .usePlugin(TocPlugin.create())
    .usePlugin(IdHeadingPlugin.create())
    .usePlugin(DescListPlugin.create())
    .usePlugin(ImageStylePlugin.create())
    .usePlugin(HighlightDelimeterPlugin.create())
    .usePlugin(WhitelistLooseDelimiterPlugin.create(DelimiterFilterMode.Permissive))
    .build()

@Test
public func test0(): Unit {
    var str = #""#
    str = #"1111![示例图](https://markdown.com.cn/images/blue.jpg){:width=200}1111"#
    let doc = markdown.toMarkdown(str)
    printNode(doc)
    @Assert(doc[0].getNodeType(), "Paragraph")
    @Assert(doc[0][0].getNodeType(), "Text")
    @Assert(doc[0][1].getNodeType(), "StyleImage")
    @Assert(doc[0][2].getNodeType(), "Text")
}
