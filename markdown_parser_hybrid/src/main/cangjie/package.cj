package markdown_parser_hybrid

//internal import markdown.core.{Node as Node, Text as Text, HtmlInline as HtmlInline, Image as Image, Code as Code,
//    LinkReferenceDefinition as LinkReferenceDefinition, Link as Link, StrongEmphasis as StrongEmphasis, Emphasis as Emphasis,
//    HtmlBlock as HtmlBlock, IndentedCodeBlock as IndentedCodeBlock, FencedCodeBlock as FencedCodeBlock, Heading as Heading,
//    ListBlock as ListBlock, BulletList as BulletList, OrderedList as OrderedList}
internal import markdown.core.*
internal import markdown.plugin.*
internal import markdown.plugin.emoji.*
internal import std.collection.*
internal import ohos.ark_interop.*

func testCJ(runtime: JSContext, callInfo: JSCallInfo): JSValue {
    let result = "Hello ${callInfo[0].toString(runtime)}"
    runtime.string(result).toJSValue()
}

let EXPORT_MODULE = JSModule.registerModule {
    runtime, exports => exports["testCJ"] = runtime.function(testCJ).toJSValue()
}

func getStackTrace(thrown: ?Exception): String {
    var res: String = ""
    match (thrown) {
        case None => return res
        case Some(v) =>
            res = "\n${v.toString()}\n"
            var arr = v.getStackTrace()
            for (line in arr) {
                res += "      at ${line.declaringClass}.${line.methodName}(${line.fileName}:${line.lineNumber})\n"
            }
            return res
    }
}

func getStackTrace(thrown: ?Error): String {
    var res: String = ""
    match (thrown) {
        case None => return res
        case Some(v) =>
            res = "\n${v.toString()}\n"
            var arr = v.getStackTrace()
            for (line in arr) {
                res += "      at ${line.declaringClass}.${line.methodName}(${line.fileName}:${line.lineNumber})\n"
            }
            return res
    }
}

extend JSObject {
    func set<T>(name: String, value: Option<T>, context: JSContext): Unit {
        match (value) {
            case Some(v: String) => this[name] = context.string(v).toJSValue()
            case Some(v: Rune) => this[name] = context.string(v.toString()).toJSValue()
            case Some(v: Int64) => this[name] = context.number(Float64(v)).toJSValue()
            case Some(v: Bool) => this[name] = context.boolean(v).toJSValue()
            case Some(v: JSValue) => this[name] = v
            case _ => this[name] = context.undefined().toJSValue()
        }
    }
    func get<T>(name: String, defaultValue: T, context: JSContext): T where T <: JSInteropType<T> {
        let jsvalue = this[name]
        return if (jsvalue.isUndefined() || jsvalue.isNull()) {
            defaultValue
        } else {
            T.fromJSValue(context, jsvalue)
        }
    }
    func get<T>(name: String, context: JSContext): ?T where T <: JSInteropType<T> {
        let jsvalue = this[name]
        return if (jsvalue.isUndefined() || jsvalue.isNull()) {
            None
        } else {
            T.fromJSValue(context, jsvalue)
        }
    }
}
