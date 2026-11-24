// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main --no-progress
import std.runtime.*

//导入mock框架包
import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

// 默认：setextEnabled = true，完全 no-op，沿用内置 HeadingParser 流程
let mdDefault: Markdown = Markdown
    .builder()
    .usePlugin(CorePlugin.create())
    .usePlugin(CustomHeadingParserPlugin(true))
    .build()

// 关闭 setext：移除内置 Heading 工厂，改用只处理 ATX 的自定义工厂
let mdNoSetext: Markdown = Markdown
    .builder()
    .usePlugin(CorePlugin.create())
    .usePlugin(CustomHeadingParserPlugin(false))
    .build()

@Test
public func testDefaultKeepsSetext(): Unit {
    // setext "=" -> H1
    let doc1 = mdDefault.parse("Title\n===\n")
    @Assert(doc1[0].getNodeType(), "Heading")
    @Assert((doc1[0] as Heading)?.getLevel(), 1)

    // setext "-" -> H2
    let doc2 = mdDefault.parse("Title\n---\n")
    @Assert(doc2[0].getNodeType(), "Heading")
    @Assert((doc2[0] as Heading)?.getLevel(), 2)

    // ATX 仍为 H1
    let doc3 = mdDefault.parse("# Title\n")
    @Assert(doc3[0].getNodeType(), "Heading")
    @Assert((doc3[0] as Heading)?.getLevel(), 1)
}

@Test
public func testDisableSetext(): Unit {
    // ATX 保留
    let doc1 = mdNoSetext.parse("# Title\n")
    @Assert(doc1[0].getNodeType(), "Heading")
    @Assert((doc1[0] as Heading)?.getLevel(), 1)

    // "===" 不再构成标题，退回段落
    let doc2 = mdNoSetext.parse("Title\n===\n")
    @Assert(doc2[0].getNodeType(), "Paragraph")

    // "---" 不再构成标题，变成分隔线
    let doc3 = mdNoSetext.parse("Title\n---\n")
    @Assert(doc3[0].getNodeType(), "Paragraph")
    @Assert(doc3[1].getNodeType(), "ThematicBreak")
}
