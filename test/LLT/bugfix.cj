// DEPENDENCE: z_test.cj
// RESOURCES: latex.md
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public class Tester {
    // let md: Markdown = Markdown.builder()
    //     // 任务列表插件
    //     .usePlugin(TaskListPlugin.create())
    //     // TOC列表插件
    //     .usePlugin(TocPlugin.create())
    //     // 删除线插件
    //     .usePlugin(StrikethroughPlugin.create())
    //     // 表格插件
    //     .usePlugin(TablePlugin.create())
    //     // 数学公式
    //     .usePlugin(LatexMathPluginV2.create())
    //     // 幻灯片、视频、ImageStyle插件
    //     .usePlugin(ImageStylePlugin.create()).usePlugin(ImageSlidePlugin.create()).usePlugin(ImageVideoPlugin.create())
    //     // 代码标签
    //     .usePlugin(CodeListPlugin.create())
    //     .build()

    // @TestCase
    public func testTaskList(): Unit {
        let node = md.parse("""
![image.png](https://pic.lingkou.xyz/1697707152-SaQbJz-image.png){:width=100}{:height=200}{:align="left"}{:style="border-radius: 10px"}

```md [-Markdown 语法]
# heading 1
## heading 2
### heading 3
#### heading 4
##### heading 5
###### heading 6
```

```md [-Markdown 语法]
1. 文本一
2. 文本二
3. 文本三
```

行内 Latex 支持：
""")
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }

    @TestCase
    public func testlatex1(): Unit {
        // let str = "# Latex\n\n## 内联 Latex\n\n$O(n^2)$\n\n算法复杂度 $O(n^2)$\n$O(n^2)$ 算法复杂度\n无空格$O(n^2)$接触\n$ 内含 O(n^2) 空格 $\n一行多个 $O(n^2)$ $O(n^2)$\n\n$转译 \\$$\n\n很长的内联公式 $O(n^2) + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1$\n\n连续字母的内联公式 $nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn$\n\n黑板粗体 $\\mathbb{ABCD abcd}$ \n正粗体 $\\mathbf{ABCD abcd}$ \n斜体数字 $\\mathit{1234567890}$\n罗马体 $\\mathrm{ABCD abcd}$ \n不支持的罗马体 $\\mbox{ABCD abcd}$\n哥特体 $\\mathfrak{ABCD abcd}$\n手写体 $\\mathcal{ABCD abcd}$\n\n\n分数 $\\frac{a}{b}$ $\\frac{x^2}{y^3}$\n括号 $\\left( \\frac{a}{b} \\right)$ $\\left[ \\frac{x^2}{y^3} \\right]$ $\\left\\{ \\frac{a}{b} \\right\\}$\n指数和下标 $x^2$ $x_{ij}$\n根号 $\\sqrt{x}$ $\\sqrt[n]{x}$\n三角函数 $\\sin(x)$ $\\cos(x)$ $\\tan(x)$\n对数和指数函数 $\\log(x)$ $\\ln(x)$ $e^x$\n求和、积分和极限 $\\sum_{i=1}^{n} x_i$ $\\int_{a}^{b} f(x) \\, dx$ $\\lim_{x \\to \\infty} f(x)$\n矩阵 $\\begin{matrix} 1 & 2 \\\\ 3 & 4 \\end{matrix}$ $\\begin{pmatrix} 1 & 2 \\\\ 3 & 4 \\end{pmatrix}$ $\\begin{bmatrix} 1 & 2 \\\\ 3 & 4 \\end{bmatrix}$\n矢量 $\\vec{v}$ $\\mathbf{F}$\n\n\n$\n符号不在一行 O(n^2)\n$\n\n```md [-Markdown 语法]\n$O(n^2)$\n\n算法复杂度 $O(n^2)$\n$O(n^2)$ 算法复杂度\n无空格$O(n^2)$接触\n$ 内含 O(n^2) 空格 $\n一行多个 $O(n^2)$ $O(n^2)$\n\n$转译 \\$$\n\n很长的内联公式 $O(n^2) + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1$\n\n连续字母的内联公式 $nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn$\n\n黑板粗体 $\\mathbb{ABCD abcd}$ \n正粗体 $\\mathbf{ABCD abcd}$ \n斜体数字 $\\mathit{1234567890}$\n罗马体 $\\mathrm{ABCD abcd}$ \n不支持的罗马体 $\\mbox{ABCD abcd}$\n哥特体 $\\mathfrak{ABCD abcd}$\n手写体 $\\mathcal{ABCD abcd}$\n\n\n分数 $\\frac{a}{b}$ $\\frac{x^2}{y^3}$\n括号 $\\left( \\frac{a}{b} \\right)$ $\\left[ \\frac{x^2}{y^3} \\right]$ $\\left\\{ \\frac{a}{b} \\right\\}$\n指数和下标 $x^2$ $x_{ij}$\n根号 $\\sqrt{x}$ $\\sqrt[n]{x}$\n三角函数 $\\sin(x)$ $\\cos(x)$ $\\tan(x)$\n对数和指数函数 $\\log(x)$ $\\ln(x)$ $e^x$\n求和、积分和极限 $\\sum_{i=1}^{n} x_i$ $\\int_{a}^{b} f(x) \\, dx$ $\\lim_{x \\to \\infty} f(x)$\n矩阵 $\\begin{matrix} 1 & 2 \\\\ 3 & 4 \\end{matrix}$ $\\begin{pmatrix} 1 & 2 \\\\ 3 & 4 \\end{pmatrix}$ $\\begin{bmatrix} 1 & 2 \\\\ 3 & 4 \\end{bmatrix}$\n矢量 $\\vec{v}$ $\\mathbf{F}$\n\n$\n符号不在一行 O(n^2)\n$\n```\n\n## Latex 块\n\n方程组 align\n$$\n\\begin{align}\nx + y &= 5 \\\\\n2x - 3y &= 7\n\\end{align}\n$$\n\n方程组 align*\n$$\n\\begin{align*}\nx + y &= 5 \\\\\n2x - 3y &= 7\n\\end{align*}\n$$\n\n矩阵方程\n$$\n\\mathbf{A} \\mathbf{x} = \\mathbf{b}\n$$\n\n其中，\n\n$$\n\\mathbf{A} = \\begin{pmatrix} 1 & 2 \\\\ 3 & 4 \\end{pmatrix}, \\quad\n\\mathbf{x} = \\begin{pmatrix} x \\\\ y \\end{pmatrix}, \\quad\n\\mathbf{b} = \\begin{pmatrix} 5 \\\\ 7 \\end{pmatrix}\n$$\n\n分步函数\n$$\nf(x) = \\begin{cases}\nx^2 & \\text{if } x \\geq 0 \\\\\n-x^2 & \\text{if } x < 0\n\\end{cases}\n$$\n\n多项式展开\n$$\n(x + y)^2 = x^2 + 2xy + y^2\n$$\n\n微分方程\n$$\n\\frac{d^2 y}{dx^2} + \\omega^2 y = 0\n$$\n\n求和\n$$\n\\sum_{i=1}^{n} i^2 = 1^2 + 2^2 + \\cdots + n^2\n$$\n\n积分\n$$\n\\int_{0}^{1} x^2 \\, dx\n$$\n\n多项式展开 tag\n$$\n(x + y)^2 = x^2 + 2xy + y^2 \\tag{1}\n$$\n\n$$\n(x + y)^2 = x^2 + 2xy + y^2 \\tag{2}\n$$\n\n复杂的公式 aligned\n$$\n\\begin{aligned} \n\\frac{1}{n}\\times \\sum_{x \\in list}(x^2 - 2\\times x\\times mean_{list}+mean_{list}^2) \\\\\n& = \\frac{1}{n}\\times (\\sum_{x \\in list}x^2 - \\sum_{x \\in list}2\\times x\\times mean_{list}+\\sum_{x \\in list}mean_{list}^2) \\\\\n& = \\frac{1}{n}\\times (\\sum_{x \\in list}x^2 - 2\\times sum_{list}\\times mean_{list}+mean_{list}^2\\times n) \\\\\n& = \\frac{1}{n}\\times (\\sum_{x \\in list}x^2 - \\frac{2 \\times sum_{list}^2}{n}+\\frac{sum_{list}^2}{n}) \\\\\n& = \\frac{1}{n}\\times (\\sum_{x \\in list}x^2 - \\frac{sum_{list}^2}{n}) \n\\end{aligned} \n$$\n\n符号在同一行\n$$(x + y)^2 = x^2 + 2xy + y^2$$\n\n```md [-Markdown 语法]\n方程组\n$$\n\\begin{align}\nx + y &= 5 \\\\\n2x - 3y &= 7\n\\end{align}\n$$\n\n$$\n\\begin{align*}\nx + y &= 5 \\\\\n2x - 3y &= 7\n\\end{align*}\n$$\n\n矩阵方程\n$$\n\\mathbf{A} \\mathbf{x} = \\mathbf{b}\n$$\n\n其中，\n\n$$\n\\mathbf{A} = \\begin{pmatrix} 1 & 2 \\\\ 3 & 4 \\end{pmatrix}, \\quad\n\\mathbf{x} = \\begin{pmatrix} x \\\\ y \\end{pmatrix}, \\quad\n\\mathbf{b} = \\begin{pmatrix} 5 \\\\ 7 \\end{pmatrix}\n$$\n\n分步函数\n$$\nf(x) = \\begin{cases}\nx^2 & \\text{if } x \\geq 0 \\\\\n-x^2 & \\text{if } x < 0\n\\end{cases}\n$$\n\n多项式展开\n$$\n(x + y)^2 = x^2 + 2xy + y^2\n$$\n\n微分方程\n$$\n\\frac{d^2 y}{dx^2} + \\omega^2 y = 0\n$$\n\n求和\n$$\n\\sum_{i=1}^{n} i^2 = 1^2 + 2^2 + \\cdots + n^2\n$$\n\n积分\n$$\n\\int_{0}^{1} x^2 \\, dx\n$$\n\n多项式展开 tag\n$$\n(x + y)^2 = x^2 + 2xy + y^2 \\tag{1}\n$$\n\n$$\n(x + y)^2 = x^2 + 2xy + y^2 \\tag{2}\n$$\n\n复杂的公式\n$$\n\\begin{aligned} \n\\frac{1}{n}\\times \\sum_{x \\in list}(x^2 - 2\\times x\\times mean_{list}+mean_{list}^2) \\\\\n& = \\frac{1}{n}\\times (\\sum_{x \\in list}x^2 - \\sum_{x \\in list}2\\times x\\times mean_{list}+\\sum_{x \\in list}mean_{list}^2) \\\\\n& = \\frac{1}{n}\\times (\\sum_{x \\in list}x^2 - 2\\times sum_{list}\\times mean_{list}+mean_{list}^2\\times n) \\\\\n& = \\frac{1}{n}\\times (\\sum_{x \\in list}x^2 - \\frac{2 \\times sum_{list}^2}{n}+\\frac{sum_{list}^2}{n}) \\\\\n& = \\frac{1}{n}\\times (\\sum_{x \\in list}x^2 - \\frac{sum_{list}^2}{n}) \n\\end{aligned} \n$$\n\n符号在同一行\n$$(x + y)^2 = x^2 + 2xy + y^2$$\n```\n\n\n## 坏格式\n$sadas $$\n\n$$$\nsadasd\n$$\n\n```md [-Markdown 语法]\n$sadas $$\n\n$$$\nsadasd\n$$\n```\n"
        // let str = "111 align\n$$\n\\begin{align}\nx + y &= 5 \\\\\n2x - 3y &= 7\n\\end{align}\n$$\n\n111 align*"
        let str = String.fromUtf8(File.readFrom("latex.md"))
        let node = md.parse(str)
        printNode(node)
        let latexstr = (node.listChildren()[0].listChildren()[0] as LatexMathNode)?.latex ?? "None"
        println("latexstr")
        println(str)
        println(latexstr)
        println(latexstr.size)
        println(latexstr.toArray())
        println(latexstr[latexstr.size - 1])
        println(latexstr[latexstr.size - 2])
        println("latexstr")
        // let nodeView = md.render(node)
        // printNode(node)
        // println(nodeView.childrenSize)
        // printNode(nodeView)
    }

    @TestCase
    public func testlatex2(): Unit {
        let str = "$\\mathbb{ABCD abcd}$"
        // let str = "$$\n\\mathbb{ABCD abcd}\n$$"
        let node = md.parse(str)
        printNode(node)
        println((node.listChildren()[0].listChildren()[0] as LatexMathNode)?.latex)
        println(str)
        // let nodeView = md.render(node)
        // printNode(node)
        // println(nodeView.childrenSize)
        // printNode(nodeView)
    }
}
