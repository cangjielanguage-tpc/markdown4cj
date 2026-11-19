// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
import std.runtime.*
import std.collection.*

// 构造 a(b, c, d) 的树
func buildABC(): Document {
    let a = Paragraph()
    let b = Text("b")
    let c = Text("c")
    let d = Text("d")
    a.appendChild(b)
    a.appendChild(c)
    a.appendChild(d)
    let doc = Document()
    doc.appendChild(a)
    doc
}

// 断言 doc 的兄弟结构为: [a[b], c, a[d]]
func assertSplit1(doc: Document): Unit {
    let children = doc.listChildren()
    if (children.size != 3) {
        throw Exception("期望3个兄弟, 实际 ${children.size}")
    }
    // doc[0] = a[b]
    if (!(children[0] is Paragraph) || children[0].childrenSize != 1) {
        throw Exception("期望 a[b]")
    }
    if (!(children[0].getFirstChild().getOrThrow() is Text)) {
        throw Exception("首块子节点应为Text")
    }
    // doc[1] = c
    if (!(children[1] is Text)) {
        throw Exception("中间应为分裂出的c")
    }
    // doc[2] = a[d]
    if (!(children[2] is Paragraph) || children[2].childrenSize != 1) {
        throw Exception("期望 a[d]")
    }
}

@Test
public func testSplitParentSimple(): Unit {
    let doc = buildABC()
    let c = doc.getFirstChild().getOrThrow()[1]
    c.splitParent()
    assertSplit1(doc)
    printNode(doc)
}

// 多层嵌套: a(b, c(c1, c2, c3), d)
func buildNested(): Document {
    let a = Paragraph()
    let b = Text("b")
    let c = Paragraph()
    let c1 = Text("c1")
    let c2 = Text("c2")
    let c3 = Text("c3")
    let d = Text("d")
    c.appendChild(c1)
    c.appendChild(c2)
    c.appendChild(c3)
    a.appendChild(b)
    a.appendChild(c)
    a.appendChild(d)
    let doc = Document()
    doc.appendChild(a)
    doc
}

@Test
public func testSplitParentPropagate(): Unit {
    let doc = buildNested()
    // 找到 c2
    let a = doc.getFirstChild().getOrThrow()          // a
    let c = a[1]                                       // c
    let c2 = c[1]                                      // c2
    // 第一层: 分裂 c -> a(b, c(c1), c2, c(c3), d)
    c2.splitParent()
    if (a.childrenSize != 5) {
        throw Exception("第一层分裂后a应有5个子节点, 实际 ${a.childrenSize}")
    }
    // a[0]=b, a[1]=c(c1), a[2]=c2, a[3]=c(c3), a[4]=d
    if (!(a[2] is Text)) {
        throw Exception("a[2]应为分裂出的c2")
    }
    if (!(a[1] is Paragraph) || a[1].childrenSize != 1) {
        throw Exception("a[1]应为c(c1)")
    }
    if (!(a[3] is Paragraph) || a[3].childrenSize != 1) {
        throw Exception("a[3]应为c(c3)")
    }
    // 第二层: 分裂 a -> a(b, c(c1)) | c2 | a(c(c3), d)
    c2.splitParent()
    let docChildren = doc.listChildren()
    if (docChildren.size != 3) {
        throw Exception("第二层分裂后doc应有3个兄弟, 实际 ${docChildren.size}")
    }
    if (!(docChildren[1] is Text)) {
        throw Exception("中间应为分裂出的c2")
    }
    printNode(doc)
}