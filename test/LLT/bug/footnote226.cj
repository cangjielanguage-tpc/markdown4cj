// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main --no-progress
import markdown_parser.plugin.emoji.*
var markdownBase: Markdown = Markdown
    .builder()
    .usePlugin(BlockAudioPlugin.create())
    .usePlugin(BlockVideoPlugin.create())
    .usePlugin(CodeListPlugin.create())
    .usePlugin(DescListPlugin.create())
    .usePlugin(FootnotePlugin.create())
    .usePlugin(HtmlPlugin.create())
    .usePlugin(IdHeadingPlugin.create())
    .usePlugin(ImageCollectPlugin.create())
    .usePlugin(ImageSinglePlugin.create())
    .usePlugin(ImageSlidePlugin.create())
    .usePlugin(ImageStylePlugin.create())
    .usePlugin(ImageTextMixPlugin.create())
    .usePlugin(ImageVideoPlugin.create())
    .usePlugin(LatexMathPluginV2.create())
    .usePlugin(LinkifyPlugin.create())
    .usePlugin(NodeIdPlugin.create())
    .usePlugin(StrikethroughPlugin.create())
    .usePlugin(SubPlugin.create())
    .usePlugin(SupPlugin.create())
    .usePlugin(TablePlugin.create())
    .usePlugin(TaskListPlugin.create())
    .usePlugin(EmojiPlugin.create())
    .usePlugin(TocPlugin.create())
    .includeSourceSpans(2) // BLOCKS_AND_INLINES
    .build()
@Test
public func test3(): Unit {
    let node = markdownBase.parse(#"- [^2^]: [异环NTE：免费开放世界RPG封闭测试](https://cg.163.com/static/content/69895252326700b55b0d178b)"#)
    printNode(node)
    let nodeView = markdownBase.render(node)
    printNode(nodeView)
}
