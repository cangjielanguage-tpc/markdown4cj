// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
import std.runtime.*
import std.collection.*

let cardMd: Markdown = Markdown.builder()
    .usePlugin(BlockCustomCardPlugin.create(blockImage: {_ => true}, blockLink: {_ => true}))
    .build()

// 直接子卡片: Paragraph -> Paragraph[before], CustomCardImage, Paragraph[after]
@Test
public func testCardSplitDirect(): Unit {
    let node = cardMd.parse(#"before ![card](https://x.png "t") after"#)
    printNode(node)
    let children = node.listChildren()
    if (children.size != 3) {
        throw Exception("期望3个块, 实际 ${children.size}")
    }
    if (!(children[0] is Paragraph)) {
        throw Exception("首块应为Paragraph")
    }
    if (!(children[1] is CustomCardImage)) {
        throw Exception("中间应为CustomCardImage")
    }
    if (!(children[2] is Paragraph)) {
        throw Exception("末块应为Paragraph")
    }
}

// 嵌套卡片: Emphasis[before, card] -> Paragraph 分裂出卡片
@Test
public func testCardSplitNested(): Unit {
    let node = cardMd.parse(#"*a ![card](https://x.png "t") b*"#)
    printNode(node)
    let children = node.listChildren()
    if (children.size != 3) {
        throw Exception("期望3个块, 实际 ${children.size}")
    }
    if (!(children[1] is CustomCardImage)) {
        throw Exception("中间应为CustomCardImage")
    }
}

// 2层嵌套: StrongEmphasis > Emphasis > [Text, card, Text]
@Test
public func testCardSplitNested2Layer(): Unit {
    let node = cardMd.parse(#"***a ![card](https://x.png "t") b***"#)
    printNode(node)
    let children = node.listChildren()
    if (children.size != 3) {
        throw Exception("期望3个块, 实际 ${children.size}")
    }
    if (!(children[1] is CustomCardImage)) {
        throw Exception("中间应为CustomCardImage")
    }
    // 首块应保留 StrongEmphasis>Emphasis>a
    if (!(children[0] is Paragraph)) {
        throw Exception("首块应为Paragraph")
    }
    let first = children[0].getFirstChild().getOrThrow()
    if (!(first is Emphasis)) {
        throw Exception("首块外层应为Emphasis")
    }
    let inner = first.getFirstChild().getOrThrow()
    if (!(inner is StrongEmphasis) || inner.getFirstChild().isNone()) {
        throw Exception("Emphasis内应保留StrongEmphasis")
    }
}

// 多个卡片
@Test
public func testCardSplitMultiple(): Unit {
    let node = cardMd.parse(#"a ![card1](https://x1.png "t") b ![card2](https://x2.png "t") c"#)
    printNode(node)
    let children = node.listChildren()
    // Paragraph[a], Card, Paragraph[b], Card, Paragraph[c]
    if (children.size != 5) {
        throw Exception("期望5个块, 实际 ${children.size}")
    }
    if (!(children[1] is CustomCardImage) || !(children[3] is CustomCardImage)) {
        throw Exception("卡片位置错误")
    }
}