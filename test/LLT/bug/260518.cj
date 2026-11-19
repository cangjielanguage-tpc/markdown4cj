// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main --no-progress
//--help

let markdown: Markdown = Markdown
    .builder()
    // // HTML插件
    // .usePlugin(HtmlPlugin.create())
    // // 任务列表插件
    // .usePlugin(TaskListPlugin.create())
    // // 删除线插件
    .usePlugin(StrikethroughPlugin.create())
    // // 表格插件
    // .usePlugin(TablePlugin.create())
    // // 数学公式
    // .usePlugin(LatexMathPluginV2.create())
    // // 音频
    // .usePlugin(BlockAudioPlugin.create())
    // // 视频
    // .usePlugin(BlockVideoPlugin.create())
    // // 链接
    // // .usePlugin(LinkViewPlugin.create())
    // // 脚注
    // .usePlugin(FootnotePlugin.create())
    // // 图片列表
    // .usePlugin(ImageCollectPlugin.create())
    // .usePlugin(NodeIdPlugin.create())
    // .usePlugin(LinkifyPlugin.create())
    // .usePlugin(ImageTextMixPlugin.create())
    .build()

@Test
public func test0(): Unit {
    var str = #"
~~删除线嵌套 [失效链接](https://invalid.com)~~
"#
    let node = markdown.parse(str)
    printNode(node)
    try {
        let nodeView = markdown.render(node)
        printNode(node)
        printNode(nodeView)
    } catch (e: Exception) {
        println(e)
        e.printStackTrace()
    } catch (e: Error) {
        println(e)
        e.printStackTrace()
    }
}