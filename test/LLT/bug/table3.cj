// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
// > ../../1.log
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
    .build()
// @Test
public func test1(): Unit {
    let str = """
> | 姓名   |
> |------|
> | 张三   |
> | 姓名 |
> |----|
> | 张三 |
"""
    let node = markdown.parse(str)
    printNode(node)
    let nodeView = markdown.render(node)
    printNode(node)
    printNode(nodeView)
    // @Assert(nodeView[2][0][0] is FootnoteBlock)
    // @Assert(nodeView[3] is FootnoteBlock)
}

@Test
public func test2(): Unit {
    let str = """
> | 姓名   |
> |------|
> | 张三   |
>> | 姓名 |
>> |----|
>> | 张三 |
"""
    let node = markdown.parse(str)
    printNode(node)
    let nodeView = markdown.render(node)
    printNode(node)
    printNode(nodeView)
    // @Assert(nodeView[2][0][0] is FootnoteBlock)
    // @Assert(nodeView[3] is FootnoteBlock)
}

