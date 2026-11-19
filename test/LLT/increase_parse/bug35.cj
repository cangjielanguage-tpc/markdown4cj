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
            .build()
        var str = #"
- 函数 \(f(x)\) 在 \(x = a\) 处的泰勒展开：
  \[ f(x) = f(a) + \frac{f'(a)}{1!}(x-a) + \frac{f''(a)}{2!}(x-a)^2 + \cdots + \frac{f^{(n)}(a)}{n!}(x-a)^n + \cdots \]
  
  
- 函数 \(f(x)\) 的傅里叶级数展开：
  \[ f(x) = \frac{a_0}{2} + \sum_{n=1}^{\infty} \left( a_n \cos \frac{n\pi x}{L} + b_n \sin \frac{n\pi x}{L} \right) \]
  其中系数为：
  \[ a_n = \frac{1}{L} \int_{-L}^{L} f(x) \cos \frac{n\pi x}{L} \, dx \]
  \[ b_n = \frac{1}{L} \int_{-L}^{L} f(x) \sin \frac{n\pi x}{L} \, dx \]


- 二阶行列式：
  \[ \begin{vmatrix} a & b \\ c & d \end{vmatrix} = ad - bc \]
- 三阶行列式：
  \[ \begin{vmatrix} a & b & c \\ d & e & f \\ g & h & i \end{vmatrix} = a(ei - fh) - b(di - fg) + c(dh - eg) \]
- **矩阵的逆**
- 对于 \(2 \times 2\) 矩阵 \(A = \begin{pmatrix} a & b \\ c & d \end{pmatrix}\)，其逆为：
  \[ A^{-1} = \frac{1}{ad - bc} \begin{pmatrix} d & -b \\ -c & a \end{pmatrix} \]
  这些公式是高等数学中的基础，掌握它们有助于理解和解决更复杂的数学问题。
"#

        let node = md.parse(str)
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
        @Assert(nodeView[0] is BulletList)
        @Assert(nodeView[0][5] is ListItem)
        @Assert(nodeView[0][5][0] is Paragraph)
        @Assert(nodeView[0][5][0].children.size,5)
        @Assert(nodeView[0][5][0][0] is Text)
        @Assert(nodeView[0][5][0][1] is LatexMathNode)
        @Assert(nodeView[0][5][1] is LatexMathBlock)
        @Assert(nodeView[0][5][2] is Paragraph)
    }
}
