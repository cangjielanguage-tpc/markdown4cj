// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public class Tester {
    @TestCase
    public func testTaskList(): Unit {
        var mdStr: String = """
正文内容 ***加粗和斜体*** **`加粗和内联代码`** **~~加粗和删除线~~** [**链接和加粗**](https://huawei.com) *`斜体和内联代码`* *~~斜体和删除线~~* [*链接和斜体*](https://huawei.com) ~~删除线和`内联代码`~~ [~~链接和删除线~~](https://huawei.com) [`链接和内联代码`](https://huawei.com) ***`加粗和斜体和内联代码`*** ***~~加粗和斜体和删除线~~*** [***链接和加粗和斜体***](https://huawei.com) ~~**`加粗和内联代码和删除线`**~~ [**`链接和加粗和内联代码`**](https://huawei.com) ***`斜体和内联代码和删除线`*** [*`链接和斜体和内联代码`*](https://huawei.com) [~~`链接和内联代码和删除线`~~](https://huawei.com) ~~***`加粗和斜体和内联代码和删除线`***~~ [***`链接和加粗和斜体和内联代码`***](https://huawei.com) [~~*`链接和加粗和斜体和内联代码`*~~](https://huawei.com) [~~***链接和加粗和斜体和删除线***~~](https://huawei.com) [~~***`链接和加粗和斜体和删除线和内联代码`***~~](https://huawei.com)

"""
        // let md: Markdown = Markdown.builder()
        //     // 任务列表插件
        //     .usePlugin(TaskListPlugin.create())
        //     // TOC列表插件
        //     .usePlugin(TocPlugin.create())
        //     // 删除线插件
        //     .usePlugin(StrikethroughPlugin.create())
        //     // 表格插件
        //     .usePlugin(TablePlugin.create()).build()
        let node: Node = md.parse(mdStr)
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }
}
