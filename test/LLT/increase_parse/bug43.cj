// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public class Tester {
    @TestCase
    public func t1(): Unit {
        let md: Markdown = Markdown
            .builder()
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
            .usePlugin(FootnotePlugin.create())
            .build()
        var str = #"
> $$
> asd1
> $$


>    \[
>    asd2
>    \]


>     \[
>     asd3
>     \]


> $$
  asd5
  $$

"#
        let node = md.parse(str)
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
        @Assert((nodeView[0][0] as LatexMathBlock)?.latex, "asd1")
        @Assert((nodeView[1][0] as LatexMathBlock)?.latex, "   asd2")
        let literal = #"\[
asd3
\]
"#
        @Assert((nodeView[2][0] as IndentedCodeBlock)?.getLiteral()==literal)
        @Assert(nodeView[3][0] is LatexMathBlock)
        @Assert(nodeView[4] is Paragraph)
        @Assert(nodeView[5] is LatexMathBlock)
    }
}
