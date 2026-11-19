// RESOURCES: test2.md
// RESOURCES: test3.md
// RESOURCES: test4.md
// RESOURCES: test5.md
// RESOURCES: test6.md
// RESOURCES: test7.md
// RESOURCES: test8.md
// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main 
//--filter=*.zUITest4

@Test
public class Tester {
    @TestCase
    public func zUITest1(): Unit {
        let md = Markdown.builder().build()
        let node = md.parse(String.fromUtf8(File.readFrom("test2.md")))
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }

    @TestCase
    public func zUITest2(): Unit {
        let md = Markdown.builder().build()
        let node = md.parse(String.fromUtf8(File.readFrom("test3.md")))
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }

    @TestCase
    public func zUITest3(): Unit {
        let md = Markdown.builder().build()
        let node = md.parse(String.fromUtf8(File.readFrom("test4.md")))
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }

    @TestCase
    public func zUITest4(): Unit {
        let md = Markdown.builder().build()
        let node = md.parse(String.fromUtf8(File.readFrom("test5.md")))
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        println("----------------------")
        println(nodeView)
        println(nodeView)
        println("----------------------")
        println(nodeView[0])
        println(nodeView[0])
        println("----------------------")
        println(nodeView[0][0])
        println(nodeView[0][0][0])
        println((nodeView[0][0][0][0] as Code)().getLiteral())
        println("----------------------")

    }

    @TestCase
    public func zUITest5(): Unit {
        let md = Markdown.builder().build()
        let node = md.parse(String.fromUtf8(File.readFrom("test6.md")))
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }

    @TestCase
    public func zUITest6(): Unit {
        let md = Markdown.builder().build()
        let node = md.parse(String.fromUtf8(File.readFrom("test7.md")))
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
        println(nodeView.children)
        println(nodeView[0].children)
    }

    @TestCase
    public func zUITest7(): Unit {
        let md = Markdown.builder().usePlugin(StrikethroughPlugin.create()).build()
        let node = md.parse(String.fromUtf8(File.readFrom("test8.md")))
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        println("----------------------")
        println(nodeView)
        println(nodeView)
        println("----------------------")
        printNode(nodeView)
    }
}
