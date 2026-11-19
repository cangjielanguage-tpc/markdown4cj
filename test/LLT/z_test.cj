// internal import stdx.encoding.base64.*
// internal import stdx.encoding.hex.*
// internal import stdx.encoding.url.*
// internal import stdx.encoding.json.*
// internal import stdx.encoding.json.stream.*
// internal import stdx.net.http.*
// internal import stdx.net.tls.*
internal import std.collection.*
internal import std.collection.concurrent.*
internal import std.console.*
internal import std.convert.*
// internal import std.format.*
internal import std.fs.*
internal import std.io.*
// internal import std.log.*
internal import std.math.*
// internal import std.os.*
// internal import std.os.posix.*
internal import std.overflow.*
internal import std.random.*
internal import std.regex.*
internal import std.runtime.*
// internal import std.socket.*
internal import std.sync.*
internal import std.time.*
internal import std.unicode.*
internal import std.unittest.*
import std.unittest.testmacro.*
// internal import std.os.process.*
internal import std.reflect.*
internal import markdown_parser.core.*
internal import markdown_parser.plugin.*
internal import commonmark4cj.commonmark.*
internal import commonmark4cj.table.*

let md: Markdown = Markdown
    .builder()
    // 任务列表插件
    .usePlugin(TaskListPlugin.create())
    // TOC列表插件
    .usePlugin(TocPlugin.create())
    // 删除线插件
    .usePlugin(StrikethroughPlugin.create())
    // 表格插件
    .usePlugin(TablePlugin.create())
    // 代码标签
    .usePlugin(CodeListPlugin.create())
    // 链接
    .usePlugin(LinkifyPlugin.create())
    .build()

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

public func printNode(node: ?Node, dep: Int, builder: StringBuilder): Unit {
    if (let Some(v) <- node) {
        let str = "${v}{${v.toPropStr()}}"
        builder.append("${" " * dep}${str}")

        
        let sss = v.getSourceSpans() |> map{v => v.toString()} |> collectString(delimiter:',')
        let sssize = v.getSourceSpans().size
        if(sssize>0){
            builder.append("${sssize}:[${sss}]")
        }

        builder.append("\n")


        let child = v.getFirstChild()
        printNode(child, dep + 4, builder)
        let next = v.getNext()
        printNode(next, dep, builder)
    }
}
/* 
public func printNode(list: NodeView): Unit {
    let builder = StringBuilder()
    printNode(list, 0, builder)
    println(builder)
}

public func printNode(list: NodeView, dep: Int, builder: StringBuilder): Unit {
    builder.append("${"    "*dep}${list}\n")
    for (block in list.children) {
        printNode(block, dep + 1, builder)
    }
}
 */
/**
 * 扩展Option，getOrThrow()方法直接用()
 */
// extend<T> Option<T> {
//     operator func ()(): T {
//         this.getOrThrow()
//     }
// }

/**
 * 扩展Option，实现Option类型直接使用==和!=
 */
extend<T> Option<T> where T <: Equatable<T> {
    operator func ==(other: T): Bool {
        match (this) {
            case Some(v) => v == other
            case _ => false
        }
    }

    operator func !=(other: T): Bool {
        match (this) {
            case Some(v) => v != other
            case _ => true
        }
    }
}

extend Node {
    func toStr(): String {
        "${this}${toPropStr()}"
    }
    func toPropStr(): String {
        match (this.custom) {
            case m: HashMap<String, Any> => m |> map {kv => "${kv[0]}:${anyToString(kv[1])}"} |> collectString(
                delimiter: ",")
            case _ => ""
        }.replace("\n", "\\n")
    }
    // prop nodeHash: Int {
    //     get() {
    //         return this.getProp<Int>("nodeHash").getOrThrow()
    //     }
    // }
    prop children: ArrayList<Node> {
        get() {
            this.listChildren()
        }
    }
}

public func anyToString(obj: Any): String {
    let hash = match (obj) {
        case v: ToString => return v.toString()
        case v: Hashable => v.hashCode().toString()
        case v => ''
    }
    try {
        return "${TypeInfo.of(obj)}@${hash}"
    } catch (e: Exception) {
        return e.message
    }
}
