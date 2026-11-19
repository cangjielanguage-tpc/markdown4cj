// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public class Tester {
    @TestCase
    public func t1(): Unit {
        /* let md: Markdown = Markdown.builder()
        // 任务列表插件
        .usePlugin(TaskListPlugin.create())
        // TOC列表插件
        .usePlugin(TocPlugin.create())
        // 删除线插件
        .usePlugin(StrikethroughPlugin.create())
        // 表格插件
        .usePlugin(TablePlugin.create())
        // 幻灯片、视频、ImageStyle插件
        // .usePlugin(ImageStylePlugin.create()).usePlugin(ImageSlidePlugin.create()).usePlugin(ImageVideoPlugin.create())
        // 代码标签
        .usePlugin(CodeListPlugin.create())
        // 数学公式
        .usePlugin(LatexMathPluginV2.create())
        // 链接
        .usePlugin(LinkifyPlugin.create())
        .build() */
        var str = #"对于一般的二次方程\( ax^2 +bx + = 0 \),其根可以通过一下公式求得"#
        let node = md.parse(str)
        printNode(node)
        // @Assert(node.getFirstChild()() is OrderedList)
        // @Assert(node.getFirstChild()().getFirstChild()() is ListItem)
        // @Assert(node.getFirstChild()().getFirstChild()().getFirstChild()() is Paragraph)
        // @Assert(node.getFirstChild()().getFirstChild()().getFirstChild()().getNext()() is LatexMathBlock)
        // @Assert(node.getFirstChild()().getFirstChild()().getFirstChild()().getNext()().getNext()() is Paragraph)
        // @Assert(node.getFirstChild()().getFirstChild()().getFirstChild()().getNext()().getNext()().getFirstChild()() is Text)
        // @Assert((node.getFirstChild()().getFirstChild()().getFirstChild()().getNext()().getNext()().getFirstChild()() as Text)().getLiteral(), "表示函数 ")
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }
}
