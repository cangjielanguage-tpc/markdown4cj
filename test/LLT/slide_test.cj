// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public class Tester {
    @TestCase
    public func testTaskList(): Unit {
        let md = Markdown.builder().usePlugin(ImageStylePlugin.create()).usePlugin(ImageSlidePlugin.create()).usePlugin(ImageVideoPlugin.create()).build()
        let node = md.parse("""
![力扣](https://pic.leetcode-cn.com/image.png){:style="width:100px"}

<![图片名称1](图片地址1),![图片名称2](图片地址2),![图片名称3](图片地址3)>

```
- 1. > - 2. > asd - _斜体_
```
""")
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }
}
