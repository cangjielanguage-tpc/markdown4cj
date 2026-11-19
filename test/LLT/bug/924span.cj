// DEPENDENCE: ../z_test.cj
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
    let str = """
<font style="color: red;"> 红色标签 </font> 

<span style="color: green; font-weight: bold;" > 绿色加粗标签 </span>

# <span style="color: pink;"> 标题1 </span> 
## <span style="color: yellow;"> 标题2 </span> 
### <span style="color: blue;"> 标题3 </span>
"""
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
