// RESOURCES: spec.md
// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: pwsh -command "cp ../../../target/release/markdown_parser/*.dll ."
// EXEC: pwsh -command "cp ../../../target/release/commonmark4cj/*.dll ."
// EXEC: ./main
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
    .usePlugin(DescListPlugin.create())
    .build()

@Test
public func test0(): Unit {
    var str = #"
# asd1
asd1.1
# asd2
dt0
dt1
: dd1
dd11
: dd2

dt3
: dd3

1. ol1
    1. ol1.2
1. ol2

- bl1
    - bl1.1
    - bl1.2
- bl2

> bq1
>> bq1.1
>            
> bq2

Abc|Def
-|-
|b11|b12|
# asd5
"#
    // str = "1. asd\n     1. ol1.1"
    // str = String.fromUtf8(File.readFrom("spec.md"))
    let node = markdown.parse(str)
    printNode(node)
    try {
        let nodeView = markdown.render(node)
        // printNode(node)
        // printNode(nodeView)
        let res = NodeViewStringBuilder(nodeView).toString()
        println(res)
    } catch (e: Exception) {
        println(e)
        e.printStackTrace()
    } catch (e: Error) {
        println(e)
        e.printStackTrace()
    }
}

/**
 * 节点树纯文本提取
 */
public class NodeViewStringBuilder <: ToString {
    public NodeViewStringBuilder(let root: Node) {}

    let builder = StringBuilder()

    /**
     * 提取纯文本
     * - 处理缩进
     * - 处理行内节点
     * - 处理行内节点间隔
     * - block: 尾插换行
     */
    public func toString(): String {
        if (builder.size == 0) {
            traverse(root)
        }
        return builder.toString()
    }

    // 使用深度优先遍历处理节点树
    func traverse(nodeView: Node): Unit {
        let node = nodeView

        if (leafNode(node)) {
            return
        }

        // 前处理节点: 前插缩进
        match (node) {
            // 处理列表
            case v: ListItem =>
                add("  " * v.listItemDepth())
                if (let Some(_: OrderedList) <- v.getParent()) {
                    add(v.listItemIndex()).add('. ')
                }
            case v: BlockQuote => add("  " * v.blockQuoteDepth())
            case _ => ()
        }

        // 处理子节点
        for (child in nodeView.iterateChildren()) {
            traverse(child)
        }

        // 后处理节点: 尾插换行/空格
        match (node) {
            case _: DescList => ()
            case _: DescTerm => ()
            case _: DescDef => ()
            case _: Paragraph => add("\n")
            case _: Heading => add("\n")
            case _: TableRow => add("\n")
            case _: TableCell => add(" ")
            case _ => ()
        }
    }

    /*
     * 处理不需要遍历children的节点
     */
    func leafNode(node: Node): Bool {
        match (node) {
            case v: Text => add(v.getLiteral())
            case _: HardLineBreak => add("\n")
            case _: SoftLineBreak => add(" ")
            // 处理Code节点
            case v: Code => add(v.getLiteral())
            case v: IndentedCodeBlock => add(v.getLiteral()).add("\n")
            case v: FencedCodeBlock => add(v.getLiteral()).add("\n")
            // 处理Html节点
            case v: HtmlInline => add(v.getLiteral())
            case v: HtmlBlock => add(v.getLiteral()).add("\n")
            // 处理latex
            case v: LatexMathNode => add(v.latex)
            case v: LatexMathBlock => add(v.latex).add("\n")
            case _ => return false
        }
        return true
    }

    func add(s: ToString): This {
        builder.append(s.toString())
        this
    }
}
