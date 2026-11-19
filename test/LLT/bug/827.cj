// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public func test3(): Unit {
    let md: Markdown = Markdown
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
        .build()
    let node = md.parse(#"123<!--asd-->我01+[citation:2]23α56α89"#)
    printNode(node)
    let nodeView = md.render(node)
    printNode(node)
    printNode(nodeView)
}
