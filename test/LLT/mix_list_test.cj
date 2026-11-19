// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public class Tester {
    @TestCase
    public func testTaskList(): Unit {
        let md = Markdown.builder().build()
        let node = md.parse("""
> asd
>> aaa

- 1. > - 2. > asd - _斜体_



""")
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }
}
