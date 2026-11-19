// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public class Tester {
    /*
    @TestCase
    public func t1(): Unit {
        let md = Markdown.builder().build()
        let node = md.parse("inputString")
        printNode(node)
        let nodeView = md.render(node)
        printNode(nodeView)
    }
    @TestCase
    public func t2(): Unit {
        let md = Markdown.builder().build()
        let node = md.parse("inputString\n\nasd\n\n123")
        printNode(node)
        // let nodeView = md.render(node)
        // printNode(nodeView)
        println(node.getFirstChild())
        let arr = node.listChildren()
        println(arr.size)
        for (n in node.iterateChildren()) {
            println(n)
        }
    }
    @TestCase
    public func t3(): Unit {
        let md = Markdown.builder().build()
        // let node = md.parse(String.fromUtf8(File.readFrom("../../src/main/cangjie/commonmark4cj/test/resources/spec.txt")))
        let node = md.parse(String.fromUtf8(File.readFrom("test/resources/test.md")))
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
        // println(node.getFirstChild())
        // let arr = node.listChildren()
        // println(arr.size)
        // for(n in node.iterateChildren()){
        //     println(n)
        // }
    }
    @TestCase
    public func t4(): Unit {
        let md = Markdown.builder().usePlugin(StrikethroughPlugin.create()).build()
        let node = md.parse("123~~**asd**~~")
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        printNode(nodeView)
    }
    @TestCase
    public func t5(): Unit {
        let md = Parser.builder().extensions([StrikethroughExtension.create()]).build()
        // let node = md.parse("123~~**asd**~~")
        let str = """
# 阿斯顿`阿瑟东1`

## 阿斯顿`阿瑟东2`
"""
        let node = md.parse(str)
        printNode(node)
        // let nodeView = md.render(node)
        // printNode(node)
        // printNode(nodeView)
    }
    
    @TestCase
    public func t6(): Unit {
        let md = Markdown.builder().build()
        let node = md.parse(String.fromUtf8(File.readFrom("test/resources/test1.md")))
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }
    @TestCase
    public func t7(): Unit {
        let md = Markdown.builder().build()
        let node = md.parse("- 1. - 2. - asd")
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }
    @TestCase
    public func t8(): Unit {
        let md = Markdown.builder().build()
        let node = md.parse(#"- 11  
22

```adfaf```"#)
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }

    @TestCase
    public func testHtml():Unit{
        let md = Markdown.builder().build()
        let node = md.parse("""
asd<img alt="" src="https://img.shields.io/badge/release-v0.0.1-brightgreen" />111
""")
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }

    @TestCase
    public func testListMix(): Unit {
        let md = Markdown.builder().build()
        let node = md.parse("""
- 1. - 2. - > - > > >  3.  - - - asd
""")
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }
*/
    
    @TestCase
    public func t9(): Unit {
        let md = Markdown.builder().build()
        let node = md.parse("""
* 无序列表1
    * 1.1
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
