// DEPENDENCE: ../z_test.cj
// DEPENDENCE: mdstr.cj
// EXEC: cjc %import-path %L %l %f z_test.cj mdstr.cj --test
// EXEC: ./main
// --filter=t11

let str = #"
![](https://qcdn3.zhaomi.cn/d/I2wUX6ipXBi_wUQzjKpWBQA_origin.png)
"#

@Test
func t1(): Unit {
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
        .usePlugin(BlockAudioPlugin())
        // 视频
        .usePlugin(BlockVideoPlugin())
        // 链接
        .usePlugin(LinkViewPlugin.create())
        // 脚注
        .usePlugin(FootnotePlugin.create())
        // 图片列表
        .usePlugin(ImageCollectPlugin())
        .usePlugin(ImageSinglePlugin.create())
        .build()
    let node = md.parse(str)
    printNode(node)
    let view = md.render(node)
    printNode(view)
    // @Assert(view[0][0] is StyleImage)
}
