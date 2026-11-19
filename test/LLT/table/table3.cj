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
以下是结合中国法定节假日规律推测的**2025年放假安排**（注：实际安排需以国务院最终通知为准）：
 
| 节假日      | 放假时间               | 调休安排                      | 天数 |
|-------------|------------------------|-----------------------------|------
| **元旦**    | 2025年1月1日-1月3日    | 无调休（1月1日为法定假日，连带周末） | 3天  |
| **春节**    | 1月28日（除夕）-2月3日 | 2月1日（周六）、2月15日（周日）补班 | 7天  |
| **清明节**  | 4月4日-4月6日          | 无调休（4月4日法定假日，连周末）   | 3天  |
| **劳动节**  | 5月1日-5月5日          | 4月27日（周日）、5月10日（周六）补班 | 5天  |
| **端午节**  | 5月31日-6月2日         | 无调休（5月31日法定假日，连周末）   | 3天  |
| **中秋节**  | 9月6日-9月8日          | 9月13日（周六）补班              | 3天  |
| **国庆节**  | 10月1日-10月7日        | 9月28日（周日）、10月11日（周六）补班 | 7天  |
 
---
 
### 说明与补充
1. **春节调休特殊性**：推测除夕（1月28日）纳入假期，实际是否放假需以官方通知为准。
2. **劳动节小长假**：可能形成“5天长假”模式，延续近年调休惯例。
3. **中秋国庆间隔**：2025年中秋与国庆间隔约3周，调休压力相对较小。
4. **补班标注**：表格中补班日期为推测周末调换的工作日。
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
