package markdown_parser.plugin.emoji

internal import std.collection.*

/**
 * 快捷方式匹配器。
 *
 * normalize_opts 原先把 emoji 名与快捷方式拼成一个巨型正则:
 * 模式按字典序降序排列, 同一位置能同时命中的模式必然互为前缀,
 * 降序排列保证更长的前缀优先, 因此等价于"最长前缀匹配"。
 * 这里用字节 trie 实现同一语义, 避免每个 Text 节点执行巨型 alternation。
 */
class EmojiMatcher {
    private let nodes: ArrayList<HashMap<UInt8, Int64>> = ArrayList<HashMap<UInt8, Int64>>()
    private let terminal: ArrayList<Bool> = ArrayList<Bool>()
    private let firstByte: Array<Bool> = Array<Bool>(256, repeat: false)

    init(shortcuts: HashMap<String, String>) {
        nodes.add(HashMap<UInt8, Int64>())
        terminal.add(false)
        for ((alias, _name) in shortcuts) {
            if (alias.isEmpty()) {
                continue
            }
            let bytes = alias.toArray()
            var cur: Int64 = 0
            for (b in bytes) {
                var next: Int64 = -1
                if (let Some(child) <- nodes[cur].get(b)) {
                    next = child
                } else {
                    next = nodes.size
                    nodes.add(HashMap<UInt8, Int64>())
                    terminal.add(false)
                    nodes[cur].add(b, next)
                }
                cur = next
            }
            terminal[cur] = true
            firstByte[Int64(bytes[0])] = true
        }
    }

    /*
     * 返回以 start 开头的最长快捷方式结束位置(字节偏移, 左闭右开); 无匹配返回 -1。
     */
    func matchEnd(src: Array<Byte>, start: Int64): Int64 {
        if (!firstByte[Int64(src[start])]) {
            return -1
        }
        var cur: Int64 = 0
        var i = start
        var best: Int64 = -1
        while (i < src.size) {
            if (let Some(child) <- nodes[cur].get(src[i])) {
                cur = child
                i += 1
                if (terminal[cur]) {
                    best = i
                }
            } else {
                break
            }
        }
        return best
    }
}
