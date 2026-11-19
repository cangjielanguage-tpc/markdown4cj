// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public class Tester {
    @TestCase
    public func testTable(): Unit {
        let parser = Parser.builder().extensions([TablesExtension.create()]).build()
        let md = Markdown.builder().usePlugin(TablePlugin.create()).build()

        let node = md.parse("""
| abc |  | asd
| --- | --- | --- 
| *abc* | **def** |
| abc | def |


| abc | asd
| --- | --- 
| abc | def |


| abc | | | asd
| --- | --- | --- | --- 
| abc | def |
""")
        printNode(node)

        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }
}
