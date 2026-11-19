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
<img src="https://picsum.photos/seed/responsive/1200/600" alt="响应式图片" style="max-width: 100%; height: auto;"/>

<div style="text-align: center;">
  <img src="https://picsum.photos/seed/responsive/1200/600" alt="响应式图片" style="max-width: 100%; height: auto;"/>
</div>  
<div style="position: relative; display: inline-block;">
  <img src="https://picsum.photos/seed/watermark/800/400" alt="带水印的图片" />
  <div style="position: absolute; bottom: 10px; right: 100px; background: rgba(0,0,0,0.5); color: white; padding: 5px 10px;">
    © 示例版权
  </div>
</div> 

<figure>
  <img src="https://picsum.photos/seed/mountain/800/500"/>
  <figcaption>图2：壮丽的山脉日落景色</figcaption>
</figure>
"#
//         str = #"
// <div style="text-align: center;">
//   <img src="https://picsum.photos/seed/responsive/1200/600" alt="响应式图片" style="max-width: 100%; height: auto;"/>
// </div>  "#
        let node = md.parse(str)
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
        // @Assert(nodeView[0][1][0][0].strongEmphasis)
        // @Assert(nodeView[0][2][0][0].emphasis)
        // @Assert(nodeView[1][0].strongEmphasis)
        // @Assert(nodeView[2][0].strongEmphasis)
        // @Assert(nodeView[3][0].emphasis)
        // @Assert(nodeView[4][0].emphasis)
    }
}
