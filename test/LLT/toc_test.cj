// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public class Tester {
    @TestCase
    public func testToc(): Unit {
        let md = Markdown.builder().usePlugin(TocPlugin.create()).build()
        let node = md.parse("""
   [toc] asd
### woda
   [toc] asd
""")
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }
    
    @TestCase
    public func test2(): Unit {
        let md = Markdown.builder()
            .usePlugin(TocPlugin.create())
            .build()
        let node = md.parse("""
adasdsad
 [toc]  
dierhang

### title1
[toc]
1. [toc]

- [toc]

""")
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }
}
