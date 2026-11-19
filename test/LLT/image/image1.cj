// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
// --filter=t11

@Test
func t1(): Unit {
    let md: Markdown = Markdown.builder().usePlugin(ImageStylePlugin.create()).build()
    let str = #"![pic](./1.png){:style="text-align: center;"}"#
    let node = md.parse(str)
    let view = md.render(node)
    @Assert(view[0][0] is StyleImage)
}

@Test
func t2(): Unit {
    let md: Markdown = Markdown.builder().usePlugin(ImageSinglePlugin.create()).build()
    let str = #"![pic](./1.png)"#
    let node = md.parse(str)
    let view = md.render(node)
    @Assert(view[0][0] is Image)
}

@Test
func t3(): Unit {
    let md: Markdown = Markdown.builder().usePlugin(ImageSlidePlugin.create()).build()
    let str = #"<![图片名称1](图片地址1),![图片名称2](图片地址2),![图片名称3](图片地址3)>"#
    let node = md.parse(str)
    let view = md.render(node)
    @Assert(view[0] is SlideBlock)
    @Assert(view[0][0] is Image)
}

@Test
func t4(): Unit {
    let md: Markdown = Markdown.builder().usePlugin(ImageVideoPlugin.create()).build()
    let str = #"![pic](12345678-1234-1234-1234-123456789ABC)"#
    let node = md.parse(str)
    let view = md.render(node)
    @Assert(view[0][0] is ImgVideo)
}

@Test
func t5(): Unit {
    let md: Markdown = Markdown
        .builder()
        .usePlugin(ImageStylePlugin.create())
        .usePlugin(ImageSinglePlugin.create())
        .usePlugin(ImageSlidePlugin.create())
        .usePlugin(ImageVideoPlugin.create())
        .build()
    let str = #"![pic](./1.png){:style="text-align: center;"}

![pic](./1.png)

<![图片名称1](图片地址1),![图片名称2](图片地址2),![图片名称3](图片地址3)>

![pic](12345678-1234-1234-1234-123456789ABC)"#
    let node = md.parse(str)
    let view = md.render(node)
    printNode(node)
    @Assert(view[0][0] is StyleImage)
    @Assert(view[1][0] is Image)
    @Assert(view[2] is SlideBlock)
    @Assert(view[3][0] is ImgVideo)
}
