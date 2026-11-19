// RESOURCES: spec.md
// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: pwsh -command "cp ../../../target/release/markdown_parser/*.dll ."
// EXEC: pwsh -command "cp ../../../target/release/commonmark4cj/*.dll ."
// EXEC: ./main
import std.runtime.*

let markdown: Markdown = Markdown
    .builder()
    // HTML插件
    .usePlugin(HtmlPlugin.create())
    // 任务列表插件
    .usePlugin(TaskListPlugin.create())
    // 删除线插件
    .usePlugin(StrikethroughPlugin.create())
    // 表格插件
    .usePlugin(TablePlugin.create())
    // 数学公式
    .usePlugin(LatexMathPluginV2.create())
    // 音频
    .usePlugin(BlockAudioPlugin.create())
    // 视频
    .usePlugin(BlockVideoPlugin.create())
    // 链接
    // .usePlugin(LinkViewPlugin.create())
    // 脚注
    .usePlugin(FootnotePlugin.create())
    // 图片列表
    .usePlugin(ImageCollectPlugin.create())
    .usePlugin(NodeIdPlugin.create())
    .usePlugin(LinkifyPlugin.create())
    .usePlugin(ImageTextMixPlugin.create())
    .usePlugin(TocPlugin.create())
    .usePlugin(IdHeadingPlugin.create())
    .usePlugin(DescListPlugin.create())
    .usePlugin(ImageStylePlugin.create())
    .build()

let sb = StringBuilder()

@Test
public func test3(): Unit {
    var str = #"
# asd {:style="color:red"}
![pic](./1.png){:style="text-align: center;"}
"#
    var nv1 = markdown.render(markdown.parse(str))
    printNode(nv1)

    @Assert(nv1[0][0].toString().contains(#"asd {:style="color:red"}"#))
    @Assert(nv1[1][0].toString().contains("StyleImage"))
}


class StyleDelimiterProcessor <: DelimiterProcessor {
    public func getOpeningCharacter(): Rune {
        return r'{'
    }
    public func getClosingCharacter(): Rune {
        return r'}'
    }
    public func getMinLength(): Int {
        return 1
    }
    public func getDelimiterUse(_: DelimiterRun, _: DelimiterRun): Int {
        return 1
    }
    let reg = Regex("^:(style|align|width|height|border-radius)=")
    public func process(openingRun: DelimiterRun, closingRun: DelimiterRun): Int {
        let opener = openingRun.getOpener()
        let closer = closingRun.getCloser()
        println("opener ${opener}")
        println("closer ${closer}")
        if (!process(opener, closer)) {
            if (let Some(n: Text) <- opener.getNext()) {
                n.setLiteral("{" + n.getLiteral())
            }
            if (let Some(p: Text) <- closer.getPrevious()) {
                p.setLiteral(p.getLiteral() + "}")
            }
        }
        1
    }

    /*
     * 处理style
     * @return true 合法的style转换为Style节点
     *        false 非法的style降级为Text节点
     */
    func process(opener: Text, closer: Text): Bool {
        // 处理style
        if (let Some(style: Text) <- opener.getNext()) {
            if (style.getNext() != closer) {
                return false
            }
            let str = style.getLiteral()
            if (reg.matcher(str).find().isSome()) {
                // 处理style前的Image
                if (let Some(image: Image) <- opener.getPrevious()) {
                    match (image) {
                        case v: StyleImage => v.styles.add(str)
                        case _ =>
                            let styleImage = StyleImage(str, image)
                            image.replaceWith(styleImage)
                    }
                    style.unlink()
                    return true
                }
            }
        }
        return false
    }
}

/**
 * 图片style
 */
class ImageStylePlugin1 <: AbstractMarkdownPlugin {
    public static func create(): ImageStylePlugin {
        return ImageStylePlugin()
    }

    public func configureParser(builder: ParserBuilder): Unit {
        builder.customDelimiterProcessor(StyleDelimiterProcessor())
    }

    public func configureVisitor(_: MarkdownVisitorBuilder): Unit {}

    public func getClassType(): String {
        "ImageStylePlugin"
    }
}
class StyleImage <: Image {
    static let typeInfo = "StyleImage"
    public let styles: ArrayList<String> = ArrayList<String>()
    init(style: String, img: Image) {
        super(img.getDestination(), img.getTitle())
        this.styles.add(style)
    }
    protected func toStringAttributes(): String {
        return "${super.toStringAttributes()}, styles=${styles}"
    }
    public func getNodeType(): String {
        typeInfo
    }
}