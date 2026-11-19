// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public class Tester {
    @TestCase
    public func testTaskList(): Unit {
        let md = Markdown.builder().usePlugin(TaskListPlugin.create()).build()
        let node = md.parse("""
- [x] Write the press release
- line2
""")
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }
}
