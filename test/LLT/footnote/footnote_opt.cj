// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main --no-progress

// 脚注专项用例: 覆盖 "[^" 前置过滤的命中/不命中两侧, 以及引用与定义的关联
let footnoteMd: Markdown = Markdown
    .builder()
    .usePlugin(FootnotePlugin.create())
    .build()

@Test
public class FootnoteOptTest {
    @TestCase
    public func referenceAndDefinitionLinked(): Unit {
        let doc = footnoteMd.parse("正文[^1]。\n\n[^1]: 脚注内容。\n")
        let p = doc.getFirstChild().getOrThrow()
        let t = (p.getFirstChild().getOrThrow() as Text)()
        @Assert(t.getLiteral(), "正文")
        let fn = (t.getNext().getOrThrow() as Footnote)()
        @Assert(fn.noteid, "1")
        // 引用节点必须关联到定义块, 定义块是第二个顶层节点
        let block = fn.block.getOrThrow()
        @Assert(block.noteid, "1")
        @Assert(block.blockIndex, 1)
        let tail = (fn.getNext().getOrThrow() as Text)()
        @Assert(tail.getLiteral(), "。")
        @Assert(tail.getNext().isNone())
    }

    @TestCase
    public func plainTextUntouched(): Unit {
        // 不含 "[^" -> 文本与节点结构都不能变化
        let doc = footnoteMd.parse("普通段落，没有任何脚注。")
        let p = doc.getFirstChild().getOrThrow()
        let t = (p.getFirstChild().getOrThrow() as Text)()
        @Assert(t.getLiteral(), "普通段落，没有任何脚注。")
        @Assert(t.getNext().isNone())
    }

    @TestCase
    public func unclosedBracketUntouched(): Unit {
        // 含 "[^" 但不构成引用: 不能丢字符, 也不能产生 Footnote 节点
        let doc = footnoteMd.parse("这里是 [^abc 未闭合")
        let p = doc.getFirstChild().getOrThrow()
        let t = (p.getFirstChild().getOrThrow() as Text)()
        @Assert(t.getLiteral(), "这里是 [^abc 未闭合")
        @Assert(t.getNext().isNone())
    }

    @TestCase
    public func definitionMustStartLine(): Unit {
        // 非行首的 "[^1]:" 不会生成 FootnoteBlock(定义必须行首),
        // 但引用本身仍按既有语义转为 Footnote, 且无对应定义块
        let doc = footnoteMd.parse("前缀 [^1]: 不是脚注定义")
        let p = doc.getFirstChild().getOrThrow()
        @Assert(p.getNodeType(), "Paragraph")
        let t = (p.getFirstChild().getOrThrow() as Text)()
        @Assert(t.getLiteral(), "前缀 ")
        let fn = (t.getNext().getOrThrow() as Footnote)()
        @Assert(fn.noteid, "1")
        @Assert(fn.block.isNone())
        let tail = (fn.getNext().getOrThrow() as Text)()
        @Assert(tail.getLiteral(), ": 不是脚注定义")
        // 顶层只有该段落, 没有定义块
        @Assert(p.getNext().isNone())
    }

    @TestCase
    public func emptyTextAfterReferenceUnlinked(): Unit {
        // 纯引用段落: 原 Text 被清空后必须 unlink, 段落内只留 Footnote
        let doc = footnoteMd.parse("[^1]\n\n[^1]: x\n")
        let p = doc.getFirstChild().getOrThrow()
        let fn = (p.getFirstChild().getOrThrow() as Footnote)()
        @Assert(fn.noteid, "1")
        @Assert(fn.getNext().isNone())
    }
}
