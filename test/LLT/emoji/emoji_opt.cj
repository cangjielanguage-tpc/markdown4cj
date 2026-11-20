// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main --no-progress
import markdown_parser.plugin.emoji.*

// Emoji 匹配引擎改造(正则 -> 字节 trie)专项用例:
// 覆盖连续匹配、词内边界、标点边界、未知名称等 trie 路径特有场景
let emojiMd: Markdown = Markdown
    .builder()
    .usePlugin(HtmlPlugin.create())
    .usePlugin(EmojiPlugin.create())
    .build()
let emojiHtml: HtmlRenderer = HtmlRenderer.builder().build()

func emojiRender(str: String): String {
    return emojiHtml.render(emojiMd.parse(str))
}

@Test
public class EmojiOptTest {
    @TestCase
    public func adjacentMatches(): Unit {
        // 连续两个 emoji 中间无分隔: 两次匹配都不能被吞掉
        @Assert(emojiRender(":smile::smile:"), "<p>😄😄</p>\n")
    }

    @TestCase
    public func fullNameInsideWordStillReplaced(): Unit {
        // 全名(:name:)不做左右边界校验, 词内同样替换(与改造前语义一致)
        @Assert(emojiRender("a:smile:b"), "<p>a😄b</p>\n")
    }

    @TestCase
    public func shortcutBoundaryRejected(): Unit {
        // 快捷方式(:D)左右必须是标点/边界, 词内不替换
        @Assert(emojiRender("a:D b"), "<p>a:D b</p>\n")
    }

    @TestCase
    public func punctuationBoundary(): Unit {
        // 标点边界允许替换
        @Assert(emojiRender("(:smile:)"), "<p>(😄)</p>\n")
    }

    @TestCase
    public func unknownNameUntouched(): Unit {
        // 未登记的 emoji 名称保持字面量
        @Assert(emojiRender(":not_a_real_emoji:"), "<p>:not_a_real_emoji:</p>\n")
    }

    @TestCase
    public func mixedTextWithEmoji(): Unit {
        // 前后普通文本与 emoji 共存
        @Assert(emojiRender("发送 :smile: 给朋友"), "<p>发送 😄 给朋友</p>\n")
    }
}
