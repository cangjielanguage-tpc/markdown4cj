// DEPENDENCE: 003big24000.md
// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main --no-progress 
internal import markdown_parser.core.*
internal import markdown_parser.plugin.*
internal import markdown_parser.plugin.emoji.*
internal import commonmark4cj.commonmark.*
internal import std.collection.*

var markdownBase: Markdown = Markdown
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
    .includeSourceSpans(2) // BLOCKS_AND_INLINES
    .build()

@Test
public func inc(): Unit {
    // let str = ["```", "md", "\n", "asdf", "\n", "```", "\n", "\n"]
    // let str = ["\\[\nE=mc^2\n\\]"]
    var str = """
### 123

asd

### 456

qwe"""
    str = #"# asd
# asd
# asd
# asd
$$
asd
$$"#
    let inc = IncreaseParser(markdownBase)
    for (i in 0..str.size) {
        var node = inc.parseIncremental(String.fromUtf8(str[i]))
        // var nodeView = inc.docView
        // println(getProp(nodeView[0], "closed", true))
        printNode(node)
        // printNode(nodeView)
        // println((node.getLastChild().getOrThrow() as IndentedCodeBlock)?.getLiteral())
    }
}

@Test
public func incbig(): Unit {
    let str = String.fromUtf8(File.readFrom("003big24000.md"))
    let inc = IncreaseParser(markdownBase)
    println(DateTime.now())
    var node = inc.parseIncremental(str)
    println(DateTime.now())
}

@Test
public func nodeid_slow(): Unit {
    let str = #"# asd
# asd
# asd
# asd
$$
asd
$$"#
    let inc = IncreaseParser(markdownBase)
    var node = inc.parseIncremental(str)
    printNode(node)
    let node0 = markdownBase.parse(str)
    markdownBase.render(node0)
    printNode(node0)
}

@Test
public func reflink(): Unit {
    let str = #"### 2. 引用式链接（分离写法）
[鸿蒙开发者官网][dev]
[华为主页][huawei]

[dev]: https://developer.huawei.com/consumer/cn/ "开发者中心"
[huawei]: https://www.huawei.com "华为官方""#
    var strinc = ""
    let inc = IncreaseParser(markdownBase)
    for (r in str.runes()) {
        strinc += r.toString()
        var node = inc.parseIncremental(r.toString())
        println(strinc)
        printNode(node)
    }
    
    var doc = IncreaseParser(markdownBase).parseIncremental(str)
    printNode(doc)
    @Assert(doc.getLastChild()?.getNodeType() == "LinkReferenceDefinition")
}

@Test
public func link2(): Unit {
    let str = #"[![鸿蒙图标](https://developer.huawei.com/favicon.ico)](https://www.harmonyos.com)"#
    var strinc = ""
    let inc = IncreaseParser(markdownBase)
    for (r in str.runes()) {
        strinc += r.toString()
        var node = inc.parseIncremental(r.toString())
        println(strinc)
        printNode(node)
    }
    
    var doc = IncreaseParser(markdownBase).parseIncremental(str)
    printNode(doc)
    @Assert(doc.getLastChild()?.getLastChild()?.getNodeType() == "Link")
}

/* 
Document{}{links:[],nodeHash:1196699542444348329,contentHash:-4234397896949043322}
    Heading{}{nodeHash:-3152830491539139129,contentHash:5504731745031194023}1:[SourceSpan{line=0, column=0, input=0, length=40}]
        Text{literal=2. 引用式链接（分离写法）}{nodeHash:8991912243166585552,contentHash:-8381655526667686774}1:[SourceSpan{line=0, column=4, input=4, length=36}]
    Paragraph{}{nodeHash:9163402405107432457,contentHash:-5958006439390769541}2:[SourceSpan{line=1, column=0, input=41, length=28},SourceSpan{line=2, column=0, input=70, length=22}]
        Link{destination=https://developer.huawei.com/consumer/cn/, title=Some(开发者中心)}{nodeHash:2617484211596076455,contentHash:826322297136595698}1:[SourceSpan{line=1, column=0, input=41, length=28}]
            Text{literal=鸿蒙开发者官网}{nodeHash:-3721970042792044329,contentHash:1468887159398250187}1:[SourceSpan{line=1, column=1, input=42, length=21}]
        SoftLineBreak{}{nodeHash:-3694003287670979909,contentHash:4455430970467660341}
        Link{destination=https://www.huawei.com, title=Some(华为官方)}{nodeHash:2617484211596076322,contentHash:-1363563998915705537}1:[SourceSpan{line=2, column=0, input=70, length=22}]
            Text{literal=华为主页}{nodeHash:-3721970042792019026,contentHash:-8503398233058136696}1:[SourceSpan{line=2, column=1, input=71, length=12}]
    Paragraph{}{nodeHash:9163402405107432130,contentHash:-912823395697200897}
        LinkReferenceDefinition{}{nodeHash:4451696186475047967,contentHash:-6333449994759152690}1:[SourceSpan{line=4, column=0, input=94, length=66}]
    Paragraph{}{nodeHash:9163402405107432065,contentHash:-3304530175192383344}
        LinkReferenceDefinition{}{nodeHash:4451696186475052526,contentHash:-8695864643144766561}1:[SourceSpan{line=5, column=0, input=161, length=47}]


Document{}{links:[],nodeHash:1196699542444348329,contentHash:7185898654586563977}
    Heading{}{nodeHash:-3152830491539139129,contentHash:-2689610211954721531}1:[SourceSpan{line=0, column=0, input=0, length=5}]
        Text{literal=asd}{nodeHash:8991912243166585552,contentHash:-8880335525230622876}1:[SourceSpan{line=0, column=2, input=2, length=3}]
    Heading{}{nodeHash:-3152830491539139143,contentHash:-2689610211954721531}1:[SourceSpan{line=1, column=0, input=6, length=5}]
        Text{literal=asd}{nodeHash:8991912243166595740,contentHash:-8880335525230622876}1:[SourceSpan{line=1, column=2, input=8, length=3}]
    Heading{}{nodeHash:-3152830491539139982,contentHash:-2689610211954721531}1:[SourceSpan{line=2, column=0, input=12, length=5}]
        Text{literal=asd}{nodeHash:8991912243166518007,contentHash:-8880335525230622876}1:[SourceSpan{line=2, column=2, input=14, length=3}]
    Heading{}{nodeHash:-3152830491539140047,contentHash:-2689610211954721531}1:[SourceSpan{line=3, column=0, input=18, length=5}]
        Text{literal=asd}{nodeHash:8991912243166521926,contentHash:-8880335525230622876}1:[SourceSpan{line=3, column=2, input=20, length=3}]
    LatexMathBlock{latex=asd,isClosed=true}{nodeHash:1660741686517391524,contentHash:3735880419921314287}3:[SourceSpan{line=4, column=0, input=24, length=2},SourceSpan{line=5, column=0, input=27, length=3},SourceSpan{line=6, column=0, input=31, length=2}]

Document{}{links:[],nodeHash:1196699542444348329,contentHash:7185898654586563977}
    Heading{}{nodeHash:-3152830491539139129,contentHash:-2689610211954721531}1:[SourceSpan{line=0, column=0, input=0, length=5}]
        Text{literal=asd}{nodeHash:8991912243166585552,contentHash:-8880335525230622876}1:[SourceSpan{line=0, column=2, input=2, length=3}]
    Heading{}{nodeHash:-3152830491539139143,contentHash:-2689610211954721531}1:[SourceSpan{line=1, column=0, input=6, length=5}]
        Text{literal=asd}{nodeHash:8991912243166595740,contentHash:-8880335525230622876}1:[SourceSpan{line=1, column=2, input=8, length=3}]
    Heading{}{nodeHash:-3152830491539139982,contentHash:-2689610211954721531}1:[SourceSpan{line=2, column=0, input=12, length=5}]
        Text{literal=asd}{nodeHash:8991912243166518007,contentHash:-8880335525230622876}1:[SourceSpan{line=2, column=2, input=14, length=3}]
    Heading{}{nodeHash:-3152830491539140047,contentHash:-2689610211954721531}1:[SourceSpan{line=3, column=0, input=18, length=5}]
        Text{literal=asd}{nodeHash:8991912243166521926,contentHash:-8880335525230622876}1:[SourceSpan{line=3, column=2, input=20, length=3}]
    LatexMathBlock{latex=asd,isClosed=true}{nodeHash:1660741686517391524,contentHash:3735880419921314287}3:[SourceSpan{line=4, column=0, input=24, length=2},SourceSpan{line=5, column=0, input=27, length=3},SourceSpan{line=6, column=0, input=31, length=2}]
 */
