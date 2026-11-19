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
        var str = #"
### 表格1

| 题号 | 标题 | 难易度 |
| --- | ---| :--- |
| 1 | $a1$ | 简单 |
| 15 | $ a2 $ | 中等 |
| 262 | \(a3\) | 困难 |
| 262 | \( a4 \) | 困难 |

### 段落

1： $a5$ 
2： $ a6 $
3： \(a7\)
4： \( a8 \)
        "#
        /* 
                            true                     true                    false                   false             true                false
                            true                     true                    false                   true              false               false
        beforeIsPunctuation:false beforeIsWhitespace:true afterIsPunctuation:false afterIsWhitespace:true leftFlanking:false rightFlanking:false

                            false                    false                   true                    true              false               true
                            false                    true                    true                    true              false               false
        beforeIsPunctuation:false beforeIsWhitespace:true afterIsPunctuation:false afterIsWhitespace:true leftFlanking:false rightFlanking:false
         */
        /* str=#"
以下是一些常见的数学公式，用表格形式展示：

| 公式名称          | 公式表达式                                                                 |
|-------------------|---------------------------------------------------------------------------|
| 勾股定理          | \( a^2 + b^2 = c^2 \)                                                     |
| 二次方程求根公式  | \( x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a} \)                              |
| 圆的面积          | \( A = \pi r^2 \)                                                         |
| 圆的周长          | \( C = 2\pi r \)                                                          |
| 三角形面积        | \( A = \frac{1}{2} \times 底 \times 高 \)                                 |
| 两点间距离公式    | \( d = \sqrt{(x_2 - x_1)^2 + (y_2 - y_1)^2} \)                            |
| 等差数列求和公式  | \( S_n = \frac{n}{2} (a_1 + a_n) \)                                       |
| 等比数列求和公式  | \( S_n = a_1 \frac{1 - r^n}{1 - r} \) （\( r \neq 1 \)）                  |
| 指数函数          | \( f(x) = a^x \)                                                          |
| 对数函数          | \( f(x) = \log_a x \)                                                     |
| 导数定义          | \( f'(x) = \lim_{h \to 0} \frac{f(x+h) - f(x)}{h} \)                      |
| 积分定义          | \( \int_a^b f(x) \, dx = \lim_{n \to \infty} \sum_{i=1}^n f(x_i^*) \Delta x \) |
| 欧拉公式          | \( e^{i\pi} + 1 = 0 \)                                                    |
| 二项式定理        | \( (a + b)^n = \sum_{k=0}^n \binom{n}{k} a^{n-k} b^k \)                   |

如果需要更详细的解释或其他公式，请告诉我！
        "# */
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
