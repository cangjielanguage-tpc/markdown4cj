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
在JavaScript中，可以使用`const greeting = \`Hello, ${name}!\``这样的模板字符串，其中 `${name}` 是一个变量占位符。在Python里，处理文件时可能会用到`with open('file.txt', 'r') as f: content = f.read().strip()`这样的代码。而在HTML中，`<div class="container">`标签需要正确闭合。

若要在代码中使用反引号，可采用`` `echo \`date\` > output.txt` ``这种形式。对于包含特殊字符的情况，例如正则表达式`/^[a-z0-9]+$/`，需要进行适当的转义处理。

在命令行中，可以通过`ls -la | grep "*.txt"`来查找所有的文本文件。在JSON格式里，`{"key": "value", "nested": {"key": "value"}}`是常见的嵌套结构。

对于复杂的函数定义，比如Python中的`def calculate_total(*args, **kwargs): return sum(args) + sum(kwargs.values())`，要留意参数的使用方式。
"#
        str = #"`asd\`123`"#
        str = #"_asd_"#
        str = #"# Markdown 文本格式指南

## 1. 加粗语法
使用双星号 `**` 或双下划线 `__` 包裹文本：
- **这是加粗文本**（使用双星号）
- __这也是加粗文本__（使用双下划线）

在句子中**强调重点内容**时很有用。"#
        str = #"- **这是加粗文本**（使用双星号）
- __这也是加粗文本__（使用双下划线）
- _这也是斜体_（使用下划线）"

 __4__（4）

__5__（5）

 _6_（6）

_7_（7）"#
        let node = md.parse(str)
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
        @Assert(nodeView[0][1][0][0].hasStrongEmphasis())
        @Assert(nodeView[0][2][0][0].hasEmphasis())
        @Assert(nodeView[1][0].hasStrongEmphasis())
        @Assert(nodeView[2][0].hasStrongEmphasis())
        @Assert(nodeView[3][0].hasEmphasis())
        @Assert(nodeView[4][0].hasEmphasis())
    }
}
