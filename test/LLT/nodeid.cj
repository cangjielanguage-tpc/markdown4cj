// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
internal import markdown_parser.core.*
internal import markdown_parser.plugin.*
internal import commonmark4cj.commonmark.*
internal import commonmark4cj.table.*
internal import commonmark4cj.strikethrough.*

@Test
public func nodeid1(): Unit {
    let md: Markdown = Markdown
        .builder()
        // 任务列表插件
        .usePlugin(TaskListPlugin.create())
        // 删除线插件
        .usePlugin(StrikethroughPlugin.create())
        // 表格插件
        .usePlugin(TablePlugin.create())
        // 幻灯片、视频、ImageStyle插件
        .usePlugin(ImageStylePlugin.create())
        .usePlugin(ImageSlidePlugin.create())
        .usePlugin(ImageVideoPlugin.create())
        // 代码标签
        .usePlugin(CodeListPlugin.create())
        // 数学公式
        .usePlugin(LatexMathPluginV2.create())
        // TOC列表插件
        .usePlugin(TocPlugin.create())
        // 链接
        .usePlugin(LinkifyPlugin.create())
        .usePlugin(NodeIdPlugin.create())
        .build()
    // let mdstr = String.fromUtf8(File.readFrom("spec.md"))
    let mdstr = """
foo
asd

foo
asd1

foo
asd
"""
    for (_ in 0..1) {
        let node = md.parse(mdstr)
        let view = md.render(node)
        for (v in view.children) {
            println(v)
            caclNodeId(v)
        }
        printNode(view)
        @Assert(view[0].toString(),view[2].toString())
        @Assert(view[0].toStr()!=view[1].toStr())
        @Assert(view[0][0].toString(),view[1][0].toString())
        @Assert(view[0][1].toString(),view[1][1].toString())
        @Assert(view[0][2].toStr()!=view[1][2].toStr())
    }
}

func caclNodeId(instance: Node): String {
    let str = match (instance) {
        case v: NodeHash => v.propString()
        case v: HtmlInline => v.propString()
        case v: Code => v.propString()
        case v: LinkReferenceDefinition => v.propString()
        case v: StrongEmphasis => v.propString()
        case v: Emphasis => v.propString()
        case v: HtmlBlock => v.propString()
        case v: IndentedCodeBlock => v.propString()
        case v: FencedCodeBlock => v.propString()
        case v: Heading => v.propString()
        case v: BulletList => v.propString()
        case v: OrderedList => v.propString()
        case v: Strikethrough => v.propString()
        case v: TableCell => v.propString()
        case v: ImageHtmlNode => v.propString()
        case v: FontNode => v.propString()
        // case v: HeadTree => v.propString()
        case _ => instance.toString()
    }
    println("2.1 ${str.size}")
    str
}

// extend FencedCodeBlock <: NodeHash {
//     public func nodeHash(): String {
//         toString() + "${getFenceChar()}${getFenceLength()}${getFenceIndent()}${getInfo()}${getLiteral()}"
//     }
// }

@Test
public func t2(): Unit {
    var h3 = DefaultHasher()
    let str = Document().toString()
    println(str)
    h3.write(str)
    println(h3.finish()) //9172718462497589386
}
