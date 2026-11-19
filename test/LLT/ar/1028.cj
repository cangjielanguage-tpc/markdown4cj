// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main 
//--help
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
    .usePlugin(LinkifyPlugin.create())
    .usePlugin(ImageTextMixPlugin.create())
    .usePlugin(TocPlugin.create())
    .usePlugin(IdHeadingPlugin.create())
    .build()

@Test
public func test0(): Unit {
    var str = #"
[toc]


   [toc]


    [toc]

---

       [toc]


- [toc]
    - [toc]
    -   [toc]
    -    [toc]
    -     [toc]


1. [toc]

## asd{#h1}
[1](#h1)
[2](h2)
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
/* 
public class HeadLink <: Link {
    static let typeInfo = "HeadLink"
    public var headIndex: Int
    init(headIndex: Int, dest: String, title: ?String) {
        super(dest, title)
        this.headIndex = headIndex
    }

    protected func toStringAttributes(): String {
        return "headIndex=${headIndex},destination=${getDestination()},title=${getTitle()}"
    }

    public func getNodeType(): String {
        return typeInfo
    }
}

class HeadTextCollector <: AbstractVisitor {
    let text = StringBuilder()
    public func visit(node: Text): Unit {
        text.append(node.getLiteral())
    }
    public func visit(node: Code): Unit {
        text.append(node.getLiteral())
    }
    func reset(): String {
        let str = text.toString()
        text.reset()
        return str
    }
}
 */