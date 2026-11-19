// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main 
//--filter=*.t4
@Test
public class Tester {
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
    @TestCase
    public func t1(): Unit {
        var str = #"asd$$123$$zxc"#
        let node = md.parse(str)
        // printNode(node)
        let nodeView = md.render(node)
        // printNode(node)
        // println(nodeView.childrenSize)
        // printNode(nodeView)
        @Assert((nodeView[0][0] as Text)?.getLiteral(), "asd")
        @Assert((nodeView[0][1] as LatexMathNode)?.latex, "123")
        @Assert((nodeView[0][2] as Text)?.getLiteral(), "zxc")
    }
    @TestCase
    public func t2(): Unit {
        var str = #"asd$123$zxc"#
        let node = md.parse(str)
        // printNode(node)
        let nodeView = md.render(node)
        // printNode(node)
        // println(nodeView.childrenSize)
        // printNode(nodeView)
        @Assert((nodeView[0][0] as Text)?.getLiteral(), "asd")
        @Assert((nodeView[0][1] as LatexMathNode)?.latex, "123")
        @Assert((nodeView[0][2] as Text)?.getLiteral(), "zxc")
    }
    @TestCase
    public func t3(): Unit {
        var str = #"$123$"#
        let node = md.parse(str)
        // printNode(node)
        let nodeView = md.render(node)
        // printNode(node)
        // println(nodeView.childrenSize)
        // printNode(nodeView)
        @Assert((nodeView[0][0] as LatexMathNode)?.latex, "123")
    }
    @TestCase
    public func t4(): Unit {
        var str = #"asd$123\$$"#
        let node = md.parse(str)
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        // println(nodeView.childrenSize)
        // printNode(nodeView)
        @Assert((nodeView[0][1] as LatexMathNode)?.latex, #"123\$"#)
    }
    @TestCase
    public func t5(): Unit {
        var str = #"\[123\]"#
        let node = md.parse(str)
        printNode(node)
        let nodeView = md.render(node)
        @Assert((nodeView[0] as LatexMathBlock)?.latex, "123")
    }
    @TestCase
    public func t6(): Unit {
        var str = #"\(123\)"#
        let node = md.parse(str)
        let nodeView = md.render(node)
        @Assert((nodeView[0][0] as LatexMathNode)?.latex, "123")
    }
    @TestCase
    public func t7(): Unit {
        var str = #"asd\[123\]zxc"#
        let node = md.parse(str)
        let nodeView = md.render(node)
        @Assert((nodeView[0][0] as Text)?.getLiteral(), "asd")
        @Assert((nodeView[0][1] as LatexMathNode)?.latex, "123")
        @Assert((nodeView[0][2] as Text)?.getLiteral(), "zxc")
    }
    @TestCase
    public func t8(): Unit {
        var str = #"asd\(123\)zxc"#
        let node = md.parse(str)
        let nodeView = md.render(node)
        @Assert((nodeView[0][0] as Text)?.getLiteral(), "asd")
        @Assert((nodeView[0][1] as LatexMathNode)?.latex, "123")
        @Assert((nodeView[0][2] as Text)?.getLiteral(), "zxc")
    }
}
