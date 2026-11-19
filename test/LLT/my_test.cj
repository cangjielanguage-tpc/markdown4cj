// DEPENDENCE: z_test.cj
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
    //     // 幻灯片、视频、ImageStyle插件
    //     .usePlugin(ImageStylePlugin.create()).usePlugin(ImageSlidePlugin.create()).usePlugin(ImageVideoPlugin.create())
    //     // 代码标签
    //     .usePlugin(CodeListPlugin.create())
    //     // 数学公式
    //     .usePlugin(LatexMathPluginV2.create())
    //     .build()

    @TestCase
    public func testTaskList(): Unit {
        let node = md.parse(#"""
```latex  [cangjie-链接-[直通蜀国](https://markdown.com.cn)]
% 设置代码的样式
\lstset{
    language=Python,      % 设置语言
    basicstyle=\ttfamily\small,  % 基本代码样式
    keywordstyle=\color{blue},  % 关键字样式
    stringstyle=\color{red},   % 字符串样式
}
```

```makefile [cangjie-链接 [直通蜀国](https://markdown.com.cn)]
# 源文件列表
SRCS = main.c helper.c
# 依赖关系，$@代表目标文件，$<代表第一个依赖文件
$(TARGET): $(SRCS)
    $(CC) $(CFLAGS) -o $@ $^
# 清理规则，清理生成的目标文件和临时文件
clean:
    rm -f $(TARGET) *.o *.d *.out
```

``` [cangjie-链接 [直通蜀国](https://markdown.com.cn)]
```
```[cangjie-链接 [直通蜀国](https://markdown.com.cn)]
```
```asd
```
```[cangjie]
```
"""#)
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }

    @TestCase
    public func test2(): Unit {
        let node = md.parse(#"""
- [x] ```latex [group-tab]

- line2
- [ ] line3
  - [x] line4
    - [ ] line5
"""#)
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }
}
