// RESOURCES: spec.md
// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main 
//> 1.log
import markdown_parser.*
import markdown_parser.core.*
import markdown_parser.plugin.*
import markdown_parser.plugin.emoji.*
import commonmark4cj.*
import commonmark4cj.commonmark.*
import commonmark4cj.strikethrough.*
import commonmark4cj.table.*
import std.reflect.*

let markdown: Markdown = Markdown
    .builder()
    .usePlugin(BlockAudioPlugin.create())
    .usePlugin(BlockVideoPlugin.create())
    .usePlugin(CodeListPlugin.create())
    .usePlugin(DescListPlugin.create())
    .usePlugin(FootnotePlugin.create())
    .usePlugin(HtmlPlugin.create())
    .usePlugin(IdHeadingPlugin.create())
    .usePlugin(ImageCollectPlugin.create())
    .usePlugin(ImageSinglePlugin.create())
    .usePlugin(ImageSlidePlugin.create())
    .usePlugin(ImageStylePlugin.create())
    .usePlugin(ImageTextMixPlugin.create())
    .usePlugin(ImageVideoPlugin.create())
    .usePlugin(LatexMathPluginV2.create())
    .usePlugin(LinkifyPlugin.create())
    .usePlugin(NodeIdPlugin.create())
    .usePlugin(StrikethroughPlugin.create())
    .usePlugin(SubPlugin.create())
    .usePlugin(SupPlugin.create())
    .usePlugin(TablePlugin.create())
    .usePlugin(TaskListPlugin.create())
    .usePlugin(EmojiPlugin.create())
    .usePlugin(TocPlugin.create())
    .build()
var str = String.fromUtf8(File.readFrom("spec.md"))

// @Test
public func test0(): Unit {
    let node = markdown.parse(str)
    printNode(node)
}

@Test
public func getAllNode(): Unit {
    printNode("commonmark4cj")
    printNode("markdown_parser")
}

let node_type_info = TypeInfo.of<Node>()

func printNode(pkg_name: String): Unit {
    let pkg_root = PackageInfo.get(pkg_name)
    for (pkg in pkg_root.subPackages) {
        for (typ in pkg.typeInfos) {
            let cti = (typ as ClassTypeInfo) ?? continue
            let top = getTopSuperClass(cti)
            if (top.toString() == node_type_info.toString()) {
                println(typ)
            }
        }
    }
}

func getTopSuperClass(cls: ClassTypeInfo): ClassTypeInfo {
    var c: ClassTypeInfo = cls
    while (let Some(v) <- c.superClass) {
        c = v
        if (c == node_type_info) {
            break
        }
    }
    return c
}
