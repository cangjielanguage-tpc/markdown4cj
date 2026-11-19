// RESOURCES: ordered_list_test1.md
// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main

@Test
public class Tester {
    @TestCase
    public func zUITest1(): Unit {
        let md = Markdown.builder().build()
        let node = md.parse(String.fromUtf8(File.readFrom("ordered_list_test1.md")))
        let nodeView = md.render(node)
        println("----------------------")
        println(node)
        println("----------------------")
        printNode(node)
        println("----------------------")
        println(nodeView)
        println("----------------------")
        printNode(nodeView)
        println("----------------------")
        println(nodeView.childrenSize)
        println("----------------------")
        println(nodeView)
        println("----------------------")
        printNode(nodeView)
        println("----------------------")
    }
}