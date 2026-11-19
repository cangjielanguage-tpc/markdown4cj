// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main --show-all-output
import std.runtime.*

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
    .usePlugin(NodeIdPlugin.create())
    .usePlugin(ImageTextMixPlugin.create())
    .build()

@Test
public func test0(): Unit {
    var str = """
asd![替代文字](图片路径 "可选标题")zxc
"""
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

@Test
public func test1(): Unit {
    var str = """
![替代文字](图片路径 "可选标题")
"""
    let node = markdown.parse(str)
    let nodeView = markdown.render(node)
    @Assert(nodeView.childrenSize,1)
    @Assert(nodeView[0].children.size,1)
}

@Test
public func test2(): Unit {
    var str = """
asd![替代文字](图片路径 "可选标题")
"""
    let node = markdown.parse(str)
    let nodeView = markdown.render(node)
    @Assert(nodeView.childrenSize,2)
    @Assert(nodeView[0].children.size,1)
    @Assert(nodeView[1].children.size,1)
}

@Test
public func test3(): Unit {
    var str = """
asd![替代文字](图片路径 "可选标题")zxc
"""
    let node = markdown.parse(str)
    let nodeView = markdown.render(node)
    @Assert(nodeView.childrenSize,3)
    @Assert(nodeView[0].children.size,1)
    @Assert(nodeView[1].children.size,1)
    @Assert(nodeView[2].children.size,1)
}

@Test
public func test4(): Unit {
    var str = """
asd<br>[z](z)![替代文字](图片路径 "可选标题")`ass`zxc![替代文字](图片路径 "可选标题")
"""
    let node = markdown.parse(str)
    printNode(node)
    let nodeView = markdown.render(node)
    @Assert(nodeView.childrenSize,4)
}

@Test
public func test5(): Unit {
    var str = """
## asd<br>[z](z)![替代文字](图片路径 "可选标题")`ass`zxc![替代文字](图片路径 "可选标题")
"""
    let node = markdown.parse(str)
    printNode(node)
    let nodeView = markdown.render(node)
    @Assert(nodeView.childrenSize,4)
    @Assert((nodeView[0] as Heading)().getLevel(),2)
    @Assert((nodeView[1] as Heading)().getLevel(),2)
    @Assert((nodeView[2] as Heading)().getLevel(),2)
    @Assert((nodeView[3] as Heading)().getLevel(),2)
}

@Test
public func test6(): Unit {
    var str = """
 ![](https://qcdn3.zhaomi.cn/d/I2wUX6ipXBi_wUQzjKpWBQA_origin.png) ![](https://qcdn3.zhaomi.cn/d/wUBmCpvd2Qm_BwnBUbXpcXB_origin.png)![](https://qcdn3.zhaomi.cn/d/pBs25HVkcwU_RtwBpromCUY_origin.png)
"""
    let node = markdown.parse(str)
    printNode(node)
    let nodeView = markdown.render(node)
    printNode(nodeView)
    // @Assert(nodeView.childrenSize,4)
    @Assert((nodeView[0][0] as Image)().getDestination(),"https://qcdn3.zhaomi.cn/d/I2wUX6ipXBi_wUQzjKpWBQA_origin.png")
    @Assert((nodeView.children[nodeView.childrenSize-2][0] as Image)().getDestination(),"https://qcdn3.zhaomi.cn/d/wUBmCpvd2Qm_BwnBUbXpcXB_origin.png")
    @Assert((nodeView.children[nodeView.childrenSize-1][0] as Image)().getDestination(),"https://qcdn3.zhaomi.cn/d/pBs25HVkcwU_RtwBpromCUY_origin.png")
}
