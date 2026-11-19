// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public class Tester {
    @TestCase
    public func t1(): Unit {
        let md: Markdown = Markdown.builder()
        // 任务列表插件
        .usePlugin(TaskListPlugin.create())
        // TOC列表插件
        .usePlugin(TocPlugin.create())
        // 删除线插件
        .usePlugin(StrikethroughPlugin.create())
        // 表格插件
        .usePlugin(TablePlugin.create())
        // 幻灯片、视频、ImageStyle插件
        .usePlugin(ImageStylePlugin.create()).usePlugin(ImageSlidePlugin.create()).usePlugin(ImageVideoPlugin.create())
        // 代码标签
        .usePlugin(CodeListPlugin.create())
        // 数学公式
        .usePlugin(LatexMathPluginV2.create())
        // 链接
        .usePlugin(LinkifyPlugin.create())
        .usePlugin(FootnotePlugin.create())
        .build()
        var str = #"
> 123
  345
"#
        for(i in 1..str.size){
            let node = md.parse(str[..i])
            // printNode(node)
            let nodeView = md.render(node)
            printNode(node)
            // println(nodeView.childrenSize)
            // printNode(nodeView)
            
            // @Assert(nodeView[0] is FencedCodeBlock)
            try{
                println((nodeView[0][0][1] as FencedCodeBlock)?.getInfo().replace("\r", "\\r").replace("\n", "\\n"))
            }catch(_){

            }
            // @Assert((nodeView[1] as FencedCodeBlock).getOrThrow().getInfo().replace("\r", "\\r").replace("\n", "\\n"),"qwe")
            // @Assert(nodeView[0][5][0] is Paragraph)
            // @Assert(nodeView[0][5][0].children.size,9)
            // @Assert(nodeView[0][5][0][0] is Text)
            // @Assert(nodeView[0][5][0][1] is LatexMathNode)
            // @Assert(nodeView[0][5][0][6] is LatexMathNode)
        }
    }
}

