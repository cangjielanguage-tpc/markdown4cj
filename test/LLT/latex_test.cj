// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public class Tester {
    @TestCase
    public func testlatex(): Unit {
        // let config = LatexConfigBuilder()
        //     .inlinesEnabled(true)
        //     .blocksEnabled(true)
        //     .build()
        let md = Markdown.builder()
            // .usePlugin(InlineParserPlugin.create())
            // .usePlugin(LatexMathPlugin.create(config))
            .usePlugin(LatexMathPluginV2.create())
            .build()
        let node = md.parse("""
123$
# asd
asdasdasd$O(n^1)inline$    
asdasd$$asd1$$
aaa$asd2\$asd3$
$$O(n^2)$$
$O(n^9)$
$O(n^12)$
$$O(n^3)$$
$$
O(n^3.1)
$$
$$O(n^4)$$
asd
""")
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }

    @TestCase
    public func testinline(): Unit {
        // let config = LatexConfigBuilder()
        //     .inlinesEnabled(true)
        //     .blocksEnabled(true)
        //     .build()
        let md = Markdown.builder()
            // .usePlugin(InlineParserPlugin.create())
            // .usePlugin(LatexMathPlugin.create(config))
            .usePlugin(LatexMathPluginV2.create())
            .build()

        printNode(md.parse(#"n^1$"#))
        printNode(md.parse(#"$n^1$"#))
        printNode(md.parse(#"$n^1"#))
        printNode(md.parse(#"$$n^1$"#))
        printNode(md.parse(#"$n^1$$"#))
        printNode(md.parse(#"$$n^1$$"#))
    }

    @TestCase
    public func testblock(): Unit {
        // let config = LatexConfigBuilder()
        //     .inlinesEnabled(true)
        //     .blocksEnabled(true)
        //     .build()
        let md = Markdown.builder()
            // .usePlugin(InlineParserPlugin.create())
            // .usePlugin(LatexMathPlugin.create(config))
            .usePlugin(LatexMathPluginV2.create())
            .build()

        printNode(md.parse(#"$$block1$$"#))
        printNode(md.parse(#"$$block2$"#))
        printNode(md.parse(#"$$block3"#))

        printNode(md.parse(#"$block4$$"#))
        printNode(md.parse(#"block5$$"#))

        printNode(md.parse(#"$block6$"#))
        printNode(md.parse(#"$block7"#))
        printNode(md.parse(#"block8$"#))

        printNode(md.parse(#"$$block9$\$"#))
        printNode(md.parse(#"$$block10\$\$"#))
        printNode(md.parse(#"$$block11\$$"#))

        printNode(md.parse(#"$$block12\$$$"#))
        printNode(md.parse(#"$$block13$\$$"#))
        printNode(md.parse(#"$$block14$$\$"#))

        printNode(md.parse("$$block15\nasd\n$$"))

        printNode(md.parse("$$block16$\nasd$\nzxc"))
    }
/*
[04-28 16:19:01] INFO - view:{Document{}}
[04-28 16:19:01] INFO -     view:{Paragraph{}}
[04-28 16:19:01] INFO -         view:{Text{literal=asdasdasd}}
[04-28 16:19:01] INFO -         view:{LatexMathNode1{latex=O(n^1)}}
[04-28 16:19:01] INFO -         view:{Text{literal= asdasd}}
[04-28 16:19:01] INFO -         view:{LatexMathNode1{latex=asd}}
[04-28 16:19:01] INFO -         view:{SoftLineBreak{}}
[04-28 16:19:01] INFO -         view:{Text{literal=aaa}}
[04-28 16:19:01] INFO -     view:{LatexMathBlock{latex=O(n^2)}}
[04-28 16:19:01] INFO -     view:{Paragraph{}}
[04-28 16:19:01] INFO -         view:{LatexMathNode1{latex=O(n^12)}}
[04-28 16:19:01] INFO -     view:{LatexMathBlock{latex=O(n^3)}}
[04-28 16:19:01] INFO -     view:{Paragraph{}}
[04-28 16:19:01] INFO -         view:{Text{literal=asd}}
*/

    
    @TestCase
    public func testsome(): Unit {
        // let config = LatexConfigBuilder()
        //     .inlinesEnabled(false)
        //     .blocksEnabled(true)
        //     .build()
        let md = Markdown.builder()
            // 任务列表插件
            .usePlugin(TaskListPlugin.create())
            // TOC列表插件
            .usePlugin(TocPlugin.create())
            // 删除线插件
            .usePlugin(StrikethroughPlugin.create())
            // 表格插件
            .usePlugin(TablePlugin.create())
            // 幻灯片、视频、ImageStyle插件
            .usePlugin(ImageStylePlugin.create())
            .usePlugin(ImageSlidePlugin.create())
            .usePlugin(ImageVideoPlugin.create())
            //代码标签
            .usePlugin(CodeListPlugin.create())
            // .usePlugin(InlineParserPlugin.create())
            // .usePlugin(LatexMathPlugin.create(config))
            .usePlugin(LatexMathPluginV2.create())
            .build()
        let str = """
**line1**
line2
line3
line4
$asd$
$$zxc$$
"""
        printNode(md.parse(str))
    }
}
