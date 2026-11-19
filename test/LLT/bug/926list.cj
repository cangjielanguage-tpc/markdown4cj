// DEPENDENCE: ../z_test.cj
// DEPENDENCE: HTML_01.md
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
import std.runtime.*

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
        .usePlugin(NodeIdPlugin.create())
        .build()
    var str = """
<ul>
   <li><!-- 导航链接 --><a href="/"><!-- 导航链接 -->首页</a></li>
   <li><a <!-- 导航链接 -->href="/about">关于我们</a></li>
   <li><a href="/about">关于我们</a></li>
</ul>
"""
    str = String.fromUtf8(File.readFrom("HTML_01.md"))
    let node = md.parse(str)
    printNode(node)
    try {
        let nodeView = md.render(node)
        printNode(node)
        printNode(nodeView)
    } catch (e: Exception) {
        println(e)
        e.printStackTrace()
    } catch (e: Error) {
        println(e)
        e.printStackTrace()
    }


    let max = MemoryInfo.maxHeapSize / 1024 / 1024
    let allocated = MemoryInfo.allocatedHeapSize / 1024 / 1024
    let used = MemoryInfo.heapPhysicalMemory / 1024 / 1024
    println("""
max: ${max} mb 
allocate: ${allocated} mb
used: ${used} mb 
${Float64(used) / Float64(max)}
""")
}
