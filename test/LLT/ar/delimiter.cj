// RESOURCES: spec.md
// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: pwsh -command "cp ../../../target/release/markdown_parser/*.dll ."
// EXEC: pwsh -command "cp ../../../target/release/commonmark4cj/*.dll ."
// EXEC: ./main
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
    .build()

@Test
public func test0(): Unit {
    var str = #"
**WARNING,**DON'T
"#
    // @On(Characters.isPunctuationCodePoint(r'：')).returns(false)
    var node1 = markdown.parse(str)
    printNode(node1)
    str = #"
**WARNING：**DON'T
"#
    // @On(Characters.isPunctuationCodePoint(r'：')).returns(false)
    var node2 = markdown.parse(str)
    printNode(node2)
    // let text1 = (node1.getFirstChild()().getFirstChild()() as Text)()
    // @Assert(text1.getLiteral(), "已部署至")
    // @Assert((text1.getNext()() as Link)().getDestination(), "https://7sncmf6ezkojw.ok.kimi.link")
    // @Assert((node1.getFirstChild()().getLastChild()() as Text)().getLiteral(), "，可直接访问查看 完")
    // var nv1 = markdown.render(node1)
    // printNode(node1)
    // printNode(nv1)
    // @Assert((nv1[0][0] as Text)().getLiteral(), "已部署至")
    // @Assert((nv1[0][1] as Text)().getLiteral(), "https://7sncmf6ezkojw.ok.kimi.link")
    // @Assert((nv1[0][2] as Text)().getLiteral(), "，可直接访问查看 完")

    // var a = Characters.isPunctuationCodePoint(r'：')
    // println(a)
    // @On(Characters.isPunctuationCodePoint(r',')).returns(false)
    // a = Characters.isPunctuationCodePoint(r',')
    // println(a)
}
@Test
public func test1(): Unit {
    var str = #" **[阿克西奥斯]  ** 去（/ˈæksɪɒs/）"#
    var node1 = markdown.parse(str)
    printNode(node1)
}

