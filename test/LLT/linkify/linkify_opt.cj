// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main --no-progress

// 默认规则(oUrl)路径专项用例: 覆盖 onlyUrl 前置过滤的命中/不命中两侧
let linkifyMd: Markdown = Markdown
    .builder()
    .usePlugin(LinkifyPlugin.create([]))
    .build()

func firstParagraph(md: Markdown, str: String): Node {
    return md.parse(str).getFirstChild().getOrThrow()
}

@Test
public class LinkifyOptTest {
    @TestCase
    public func noSchemeTextUntouched(): Unit {
        // 不含 "://" -> 走前置过滤快路径, 文本必须原样保留
        let p = firstParagraph(linkifyMd, "完全纯文本，没有任何链接")
        let t = (p.getFirstChild().getOrThrow() as Text)()
        @Assert(t.getLiteral(), "完全纯文本，没有任何链接")
        @Assert(t.getNext().isNone())
    }

    @TestCase
    public func schemeButNotUrlUntouched(): Unit {
        // 含 "://" 但不是 http(s) URL: 不跳过过滤, 正则不命中, 文本仍须原样保留
        let p = firstParagraph(linkifyMd, "a://b 和 c://d")
        let t = (p.getFirstChild().getOrThrow() as Text)()
        @Assert(t.getLiteral(), "a://b 和 c://d")
        @Assert(t.getNext().isNone())
    }

    @TestCase
    public func defaultUrlStillLinked(): Unit {
        let p = firstParagraph(linkifyMd, "访问 https://example.com 查看")
        let t = (p.getFirstChild().getOrThrow() as Text)()
        @Assert(t.getLiteral(), "访问 ")
        let link = (t.getNext().getOrThrow() as Link)()
        @Assert(link.getDestination(), "https://example.com")
        let tail = (link.getNext().getOrThrow() as Text)()
        @Assert(tail.getLiteral(), " 查看")
        @Assert(tail.getNext().isNone())
    }

    @TestCase
    public func multipleUrlsInOneText(): Unit {
        let p = firstParagraph(linkifyMd, "https://a.com 和 http://b.com")
        let l1 = (p.getFirstChild().getOrThrow() as Link)()
        @Assert(l1.getDestination(), "https://a.com")
        let mid = (l1.getNext().getOrThrow() as Text)()
        @Assert(mid.getLiteral(), " 和 ")
        let l2 = (mid.getNext().getOrThrow() as Link)()
        @Assert(l2.getDestination(), "http://b.com")
        @Assert(l2.getNext().isNone())
    }

    @TestCase
    public func urlAdjacentToCjk(): Unit {
        // 中文紧邻 URL: 前后文本切分与链接目标都要正确
        let p = firstParagraph(linkifyMd, "已部署至https://x.com，可直接访问")
        let head = (p.getFirstChild().getOrThrow() as Text)()
        @Assert(head.getLiteral(), "已部署至")
        let link = (head.getNext().getOrThrow() as Link)()
        @Assert(link.getDestination(), "https://x.com")
        let tail = (link.getNext().getOrThrow() as Text)()
        @Assert(tail.getLiteral(), "，可直接访问")
    }
}
