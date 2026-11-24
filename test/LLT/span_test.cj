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
    // .usePlugin(ImageTextMixPlugin.create())
    .usePlugin(TocPlugin.create())
    .usePlugin(IdHeadingPlugin.create())
    .usePlugin(DescListPlugin.create())
    .usePlugin(HighlightDelimeterPlugin.create())
    .usePlugin(WhitelistLooseDelimiterPlugin.create(DelimiterFilterMode.Permissive))
    .build()

@Test
public func test0(): Unit {
    var str = #""#
    str = #"<span style="color: red;"> 红色标签 </span>"#
    // str = #"<p style="color: red;"> 红色标签 </p>"#
    // str = #"1111![示例图](https://markdown.com.cn/images/blue.jpg){:width=200}1111"#
    let doc = markdown.toMarkdown(str)
    printNode(doc)
    @Assert(doc[0][0].getNodeType(), "SpanNode")
}

@Test
public func test1(): Unit {
    var str = #""#
    str = #"<div>
  <p>html块内文本 ==markdown高亮测试==</p>
  <span style="color:red">==html标签包裹高亮==</span>
</div>
"#
    let doc = markdown.toMarkdown(str)
    printNode(doc)
    @Assert(doc[0].getNodeType(), "Paragraph")
    @Assert(doc[1].getNodeType(), "Paragraph")
    @Assert(doc[1][0].getNodeType(), "SpanNode")
}

@Test
public func test2(): Unit {
    var str = #""#
    str = #"内文本 ==markdown高亮测试==$asdasd
    </p>
  style="color:red">==html标签包裹高亮==</span>
div>
"#
    let doc = markdown.toMarkdown(str)
    printNode(doc)
}

