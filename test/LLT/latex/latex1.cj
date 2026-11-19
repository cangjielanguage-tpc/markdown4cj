// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public class Tester {
    @TestCase
    public func t1(): Unit {
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
            // 链接
            .usePlugin(LinkViewPlugin.create())
            // 脚注
            .usePlugin(FootnotePlugin.create())
            .build()
        var str = #"
假设我们需要创建一个与股票分析相关的复杂指标公式，可以基于以下形式：
\[ \text{ComplexIndicator} = \text{FunctionA} \times (\text{Parameter1}) + \text{FunctionB} \times (\text{Parameter2}) - \text{FunctionC} \times (\text{Parameter3}) \]
这里，`FunctionA`, `FunctionB`, 和 `FunctionC` 代表不同的数据处理方式，而 `Parameter1`, `Parameter2`, 和 `Parameter3` 则是根据具体情境设定的数值
"#
        let node = md.parse(str)
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
//         @Assert((nodeView[0][0] as LatexMathBlock)?.latex, "asd1")
//         @Assert((nodeView[1][0] as LatexMathBlock)?.latex, "   asd2")
//         let literal = #"\[
// asd3
// \]
// "#
//         @Assert((nodeView[2][0] as IndentedCodeBlock)?.getLiteral()==literal)
//         @Assert(nodeView[3][0] is LatexMathBlock)
//         @Assert(nodeView[4] is Paragraph)
//         @Assert(nodeView[5] is LatexMathBlock)
    }
}
