package markdown_parser.plugin

import std.collection.*

/* public class Debuger {
    static var _logger: ?Logger = None
    mut static prop logger: Logger {
        get() {
            _logger ?? {
                =>
                let logger = getGlobalLogger([("name", "main")])
                _logger = logger
                logger
            }()
        }
        set(v) {
            _logger = v
        }
    }
} */
public func printTag(tag: HtmlTag): Unit {
    let appender = StringBuilder()
    var root: HtmlTag = tag
    while (let Some(p) <- root.parentTag) {
        root = p
    }
    printTag(root, 0, appender)
    println(appender)
}

public func printTag(tag: HtmlTag, depth: Int, appender: StringBuilder): Unit {
    // 显式栈迭代，避免深嵌套标签树递归栈溢出
    let stack = ArrayList<(HtmlTag, Int)>()
    stack.add((tag, depth))
    while (!stack.isEmpty()) {
        let (t, d) = stack.remove(at: stack.size - 1)
        appender.append("${" " * d}${t} ${t.isClosed()}\n")
        // 逆序入栈保证输出顺序与递归版一致
        let children = t.getChildren()
        var i = children.size - 1
        while (i >= 0) {
            stack.add((children[i], d + 1))
            i--
        }
    }
}

public func printNode(node: ?Node): Unit {
    if (let Some(v) <- node) {
        var current = v
        while (let Some(p) <- (current.getParent())) {
            current = p
        }
        let builder = StringBuilder()
        printNode(current, 0, builder)
        println(builder)
    }
}

public func printNode(node: ?Node, depth: Int, builder: StringBuilder): Unit {
    // 调试输出大小上限：防御超大 AST 输出无界增长导致 OOM
    let MAX_DEBUG_PRINT_SIZE: Int64 = 4 * 1024 * 1024
    // 显式栈迭代，避免深 AST 双向递归导致栈溢出
    let stack = ArrayList<(Node, Int)>()
    if (let Some(v) <- node) {
        stack.add((v, depth))
    }
    while (!stack.isEmpty()) {
        if (builder.size >= MAX_DEBUG_PRINT_SIZE) {
            builder.append("... (output truncated)\n")
            break
        }
        let (n, d) = stack.remove(at: stack.size - 1)
        let str = n.toString().replace("\n", "\\n")
        builder.append("${" " * d}${str}\n")
        // 先压入后继兄弟再压入首孩子，保证出栈顺序与递归版一致
        if (let Some(next) <- n.getNext()) {
            stack.add((next, d))
        }
        if (let Some(child) <- n.getFirstChild()) {
            stack.add((child, d + 4))
        }
    }
}
