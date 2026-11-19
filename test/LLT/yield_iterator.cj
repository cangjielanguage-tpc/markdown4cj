// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public class Tester {
    @TestCase
    public func testListMix(): Unit {
        let md = Markdown.builder().build()
        let node = md.parse("""
* 无序列表1
    1. 1.1
* 无序列表2
* 无序列表3
""")
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }
}

// class YieldIterator<:Iterator<String> {
//     public YieldIterator(var current: Node) {}
//     let monitor =Monitor()
//     public func next(): ?String {
//         monitor.wait()
//     }

// }