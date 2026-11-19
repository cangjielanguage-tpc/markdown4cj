// DEPENDENCE: ../z_test.cj
// DEPENDENCE: fixtures/aliases.txt
// DEPENDENCE: fixtures/emojis.txt
// DEPENDENCE: fixtures/full.txt
// DEPENDENCE: fixtures/options.txt
// DEPENDENCE: fixtures/whitelist.txt
// DEPENDENCE: fixtures/autolinks.txt
// DEPENDENCE: fixtures/light.txt
// DEPENDENCE: fixtures/bare.txt
// DEPENDENCE: visible.txt
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main 
//--filter=markdown_it_emoji
import std.runtime.*
import markdown_parser.plugin.emoji.*

let markdownBuilder = {
    => Markdown
        .builder()
        // HTML插件
        .usePlugin(HtmlPlugin.create())
        // 任务列表插件
        .usePlugin(TaskListPlugin.create())
        .usePlugin(SubPlugin())
        // 删除线插件
        .usePlugin(StrikethroughPlugin.create())
        .usePlugin(SupPlugin())
        // 表格插件
        .usePlugin(TablePlugin.create())
        // 数学公式
        .usePlugin(LatexMathPluginV2.create())
        // 音频
        .usePlugin(BlockAudioPlugin.create())
        // 视频
        .usePlugin(BlockVideoPlugin.create())
        // 链接
        .usePlugin(LinkViewPlugin.create())
        // 脚注
        .usePlugin(FootnotePlugin.create())
        // 图片列表
        .usePlugin(ImageCollectPlugin.create())
        // .usePlugin(NodeIdPlugin.create())
        // .usePlugin(LinkifyPlugin.create())
        .usePlugin(ImageTextMixPlugin.create())
        .usePlugin(TocPlugin.create())
        .usePlugin(IdHeadingPlugin.create())
    // emoji插件
    // .usePlugin(EmojiPlugin.create())
}
let markdown: Markdown = markdownBuilder().usePlugin(EmojiPlugin.create()).build()
let htmlRender = HtmlRenderer.builder().build()

@Test
public func test0(): Unit {
    var str = #"
:smile:  123
"#
    let node = markdown.parse(str)
    printNode(node)
    let nodeView = markdown.render(node)
    printNode(node)
    printNode(nodeView)

    let html = htmlRender.render(node)
    println(html)

    // @Assert(nodeView[0][0].props.getOrThrow()["UnderlineNode"] is Bool)
}

class Render {
    let markdown: Markdown
    init(light: Bool) {
        markdown = markdownBuilder().usePlugin(EmojiPlugin.create(light)).build()
    }
    init() {
        this(Options())
    }
    init(defs: HashMap<String, String>) {
        this(Options(defs: defs))
    }
    init(light: Bool, defs: HashMap<String, String>) {
        this(Options(light: light, defs: defs))
    }
    init(light: Bool, defs: HashMap<String, String>, shortCutSrc: HashMap<String, Array<String>>) {
        this(Options(light: light, defs: defs, shortCutSrc: shortCutSrc))
    }
    init(defs: HashMap<String, String>, shortCutSrc: HashMap<String, Array<String>>) {
        this(Options(defs: defs, shortCutSrc: shortCutSrc))
    }
    init(light: Bool, enabled: Array<String>) {
        this(Options(light: light, enabled: enabled))
    }
    init(opts: Options, linkify!: Bool = false) {
        let builder = markdownBuilder()
        if (linkify) {
            builder.usePlugin(LinkifyPlugin.create())
        }
        builder.usePlugin(EmojiPlugin.create(opts))
        markdown = builder.build()
    }
    func render(str: String): String {
        let node = markdown.parse(str)
        let nodeView = markdown.render(node)
        let html = htmlRender.render(node)
        return html
    }
}

@Test
class dist {
    @TestCase
    func UMD_full(): Unit {
        var md = Render(false)

        @Assert(md.render(':100:'), '<p>💯</p>\n')
    }
    @TestCase
    func UMD_light(): Unit {
        var md = Render(true)
        // ignore non-base emoji
        @Assert(md.render(':100:'), '<p>:100:</p>\n')
        // convert base emoji
        @Assert(md.render(':smile:'), '<p>😄</p>\n')
    }
    @TestCase
    func UMD_bare(): Unit {
        var md = Render(HashMap(('one', '!!!one!!!')))
        // ignore non-base emoji
        @Assert(md.render(':100:'), '<p>:100:</p>\n')
        @Assert(md.render(':smile:'), '<p>:smile:</p>\n')

        @Assert(md.render(':one:'), '<p>!!!one!!!</p>\n')
    }
    @TestCase
    func CJS_full(): Unit {
        var md = Render(false)

        @Assert(md.render(':100:'), '<p>💯</p>\n')
    }
    @TestCase
    func CJS_light(): Unit {
        var md = Render(true)
        // ignore non-base emoji
        @Assert(md.render(':100:'), '<p>:100:</p>\n')
        // convert base emoji
        @Assert(md.render(':smile:'), '<p>😄</p>\n')
    }
    @TestCase
    func CJS_bare(): Unit {
        var md = Render(HashMap(('one', '!!!one!!!')))
        // ignore non-base emoji
        @Assert(md.render(':100:'), '<p>:100:</p>\n')
        @Assert(md.render(':smile:'), '<p>:smile:</p>\n')

        @Assert(md.render(':one:'), '<p>!!!one!!!</p>\n')
    }

    // func CJS_index(): Unit {
    //     var idx = require('../dist/index.cjs.js')
    //     @Assert(typeof idx.full, 'function')
    //     @Assert(typeof idx.light, 'function')
    //     @Assert(typeof idx.bare, 'function')
    // }
}

@Test
func markdown_it_emoji(): Unit {
    var md = Render(false)
    generate('aliases.txt', md)
    generate('emojis.txt', md)

    generate('full.txt', md)

    md = Render(
        false,
        HashMap(
            ('one', '!!!one!!!'),
            ('fifty', '!!50!!')
        ),
        HashMap(
            ('fifty', [':50', '|50']),
            ('one', [':uno'])
        )
    )
    generate('options.txt', md)

    md = Render(false, ['smile', 'grin'])
    generate('whitelist.txt', md)

    md = Render(Options(light: false), linkify: true)
    generate('autolinks.txt', md)
}

@Test
func markdown_it_emoji_light(): Unit {
    var md = Render(true)
    generate('aliases.txt', md)
    generate('emojis.txt', md)

    generate('light.txt', md)

    md = Render(
        true,
        HashMap(
            ('one', '!!!one!!!'),
            ('fifty', '!!50!!')
        ),
        HashMap(
            ('fifty', [':50', '|50']),
            ('one', [':uno'])
        )
    )
    generate('options.txt', md)

    md = Render(true, ['smile', 'grin'])
    generate('whitelist.txt', md)

    md = Render(Options(light: false), linkify: true)
    generate('autolinks.txt', md)
}

@Test
func markdown_it_emoji_bare(): Unit {
    var md = Render()
    generate('bare.txt', md)

    md = Render(
        HashMap(
            ('one', '!!!one!!!'),
            ('fifty', '!!50!!')
        ),
        HashMap(
            ('fifty', [':50', '|50']),
            ('one', [':uno'])
        )
    )
    generate('options.txt', md)
}

@Test
class integrity {
    @TestCase
    func all_shortcuts_should_exist(): Unit {
        for (name in EMOJI_DATA_SHORTCUTS.keys()) {
            @Assert(EMOJI_DATA_FULL.contains(name) /* , "shortcut doesn't exist: " + name */ )
        }
    }
    @TestCase
    func no_chars_with_uXXXX_names_allowed(): Unit {
        let re = Regex("^u[0-9a-b]{4,}$")
        for (name in EMOJI_DATA_FULL.keys()) {
            if (re.matches(name)) {
                throw AssertException('Name ' + name + ' not allowed')
            }
        }
    }
    @TestCase
    func all_light_chars_should_exist(): Unit {
        var visible = String.fromUtf8(File.readFrom('visible.txt'))

        var missed = ''

        var available = EMOJI_DATA_LIGHT.values() |> map {
            v => v.replace("\u{FE0F}", '')
        } |> collectArray

        for (ch in visible.runes()) {
            if (available.indexOf(ch.toString()).isNone()) {
                missed += ch.toString()
            }
        }

        if (missed.size > 0) {
            throw AssertException('Characters ' + missed + ' missed.')
        }
    }
}

func generate(path: String, md: Render): Unit {
    let reader = StringReader(File(path, OpenMode.Read))
    let desc = readDesc(reader)
    while (let Some((caseDesc, caseInput, caseExpect)) <- readCase(reader)) {
        try {
            @Assert(md.render(caseInput), caseExpect)
        } catch (e: Exception) {
            println('Case ${caseDesc} failed. ${caseInput}')
            throw e
        }
    }
}

func readDesc(reader: StringReader<File>): String {
    let sb = StringBuilder()
    while (let Some(ln) <- reader.readln()) {
        if (ln.startsWith('---')) {
            break
        }
    }
    while (let Some(ln) <- reader.readln()) {
        if (ln.startsWith('---')) {
            break
        } else {
            sb.append("\n")
            sb.append(ln)
        }
    }
    return sb.toString()
}

func readCase(reader: StringReader<File>): ?(String, String, String) {
    var caseDesc = ""
    var caseInput = ""
    var caseExpect = ""
    var ln = reader.readln()
    // read case desc
    while (let Some(ln) <- reader.readln()) {
        if (ln == '.') {
            break
        }
        caseDesc += ln + "\n"
    }
    if (caseDesc.trim().isEmpty()) {
        return None
    }
    // read case input
    while (let Some(ln) <- reader.readln()) {
        if (ln == '.') {
            break
        }
        caseInput += ln + "\n"
    }
    // read case expect
    while (let Some(ln) <- reader.readln()) {
        if (ln == '.') {
            break
        }
        caseExpect += ln + "\n"
    }
    return (caseDesc, caseInput, caseExpect)
}
