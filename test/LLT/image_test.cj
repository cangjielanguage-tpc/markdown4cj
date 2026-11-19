// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public class Tester {
    @TestCase
    public func testImgList(): Unit {
        let md = Markdown.builder()
            .usePlugin(ImageStylePlugin.create())
            .usePlugin(ImageSlidePlugin.create())
            .usePlugin(ImageVideoPlugin.create())
            .build()
        let node = md.parse("""
![力扣](https://pic.leetcode-cn.com/image.png){:style="width:100px"}
[图片名称a](图片地址a)
<![图片名称1](图片地址1),![图片名称2](图片地址2){:style="width:宽度像素px"},![图片名称3](图片地址3)>
[图片名称b](图片地址b){:align=center}

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

    @TestCase
    public func testImgVedio(): Unit {
        let md = Markdown.builder()
            .usePlugin(ImageStylePlugin.create())
            .usePlugin(ImageSlidePlugin.create())
            .usePlugin(ImageVideoPlugin.create())
            .build()
        let node = md.parse("""
![力扣视频](562986b1-46d8-48ef-bac6-82685bcedcd8)
![力扣视频style](562986b1-46d8-48ef-bac6-82685bcedcd8){:style="width:100px"}
[图片名称a](图片地址a)
<![图片名称1](图片地址1),![图片名称2](562986b1-46d8-48ef-bac6-82685bcedcd8){:style="width:宽度像素px"},![图片名称3](562986b1-46d8-48ef-bac6-82685bcedcd8)>
""")
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }

    @TestCase
    public func testList(): Unit {
        let md = Markdown.builder()
            .usePlugin(ImageStylePlugin.create())
            .usePlugin(ImageSlidePlugin.create())
            .usePlugin(ImageVideoPlugin.create())
            .build()
        let node = md.parse("""
<br>

<![图片名称1](562986b1),![图片名称2](562986b1-46d8-48ef-bac6-82685bcedcd8){:style="width:宽度像素px"},![图片名称3](562986b1-46d8-48ef-bac6-82685bcedcd8)>

<br>
""")
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }

    @TestCase
    public func testuuid(): Unit {
        let md = Markdown.builder()
            .usePlugin(ImageStylePlugin.create())
            .usePlugin(ImageSlidePlugin.create())
            .usePlugin(ImageVideoPlugin.create())
            .build()
        let node = md.parse("""
<br>

<![图片名称1](562986b1-46d8-48ef-bac6-82685bcedcd91),![图片名称2](562986b1-46d8-48ef-bac6-82685bcedcd8){:style="width:宽度像素px"},![图片名称3](562986b1-46d8-48ef-bac6-82685bcedcd9)>

<br>
""")
        // printNode(node)
        let nodeView = md.render(node)
        // printNode(node)
        // println(nodeView.childrenSize)
        // printNode(nodeView)
    }

    @TestCase
    public func testuuid1(): Unit {
        let md = Markdown.builder()
            .usePlugin(ImageStylePlugin.create())
            .usePlugin(ImageSlidePlugin.create())
            .usePlugin(ImageVideoPlugin.create())
            .build()
        let node = md.parse("""

![图片名称1](562986b1-46d8-48ef-bac6-82685bcedcd91)

![图片名称2](562986b1-46d8-48ef-bac6-82685bcedcd8){:style="width:宽度像素px"}

![图片名称3](562986b1-46d8-48ef-bac6-82685bcedcd9)>
""")
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }
}
