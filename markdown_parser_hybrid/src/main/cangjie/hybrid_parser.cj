package markdown_parser_hybrid

import ohos.ark_interop_macro.Interop

public class HybridParser <: SharedObject & JSInteropType<HybridParser> {
    static init() {
        JSModule.registerClass("HybridParser") {
            context =>
                let clazz = context.clazz(jsConstructor)
                clazz.addMethod("parse", context.function(parse_ArkTS_Interop_Identifier))
                return clazz
        }
    }

    public HybridParser(let parser: Markdown, let jsNodeFactory: JSFunction) {}

    public static func jsConstructor(context: JSContext, callInfo: JSCallInfo): JSValue {
        JSCurrentJSContext.set(context)
        let opt = callInfo[0].asObject()
        let jsNodeFactory = opt['jsNodeFactory'].asFunction()
        let includeSourceSpans = Int64.fromJSValue(context, opt['includeSourceSpans'])
        let builder = Markdown.builder().includeSourceSpans(includeSourceSpans)
        if (opt.get('ADPlugin', false, context)) {
            builder.usePlugin(ADPlugin.create())
        }
        if (opt.get('BlockAudioPlugin', false, context)) {
            builder.usePlugin(BlockAudioPlugin.create())
        }
        if (opt.get('BlockVideoPlugin', false, context)) {
            builder.usePlugin(BlockVideoPlugin.create())
        }
        if (opt.get('CodeListPlugin', false, context)) {
            builder.usePlugin(CodeListPlugin.create())
        }
        if (opt.get('HtmlPlugin', false, context)) {
            builder.usePlugin(HtmlPlugin.create())
        }
        if (opt.get('TablePlugin', false, context)) {
            builder.usePlugin(TablePlugin.create())
        }
        if (opt.get('TaskListPlugin', false, context)) {
            builder.usePlugin(TaskListPlugin.create())
        }
        if (opt.get('StrikethroughPlugin', false, context)) {
            builder.usePlugin(StrikethroughPlugin.create())
        }
        if (opt.get('LinkifyPlugin', false, context)) {
            var LinkifyPlugin_regs: Array<String> = if (let Some(jsarray) <- opt.get<JSArrayEx<String>>(
                'LinkifyPlugin_regs', context)) {
                jsarray.toArray()
            } else {
                []
            }
            builder.usePlugin(LinkifyPlugin.create(LinkifyPlugin_regs))
        }
        if (opt.get('LinkViewPlugin', false, context)) {
            builder.usePlugin(LinkViewPlugin.create())
        }
        if (opt.get('LatexMathPluginV2', false, context)) {
            builder.usePlugin(LatexMathPluginV2.create())
        }
        if (opt.get('ImageStylePlugin', false, context)) {
            builder.usePlugin(ImageStylePlugin.create())
        }
        if (opt.get('ImageSlidePlugin', false, context)) {
            builder.usePlugin(ImageSlidePlugin.create())
        }
        if (opt.get('ImageTextMixPlugin', false, context)) {
            builder.usePlugin(ImageTextMixPlugin.create())
        }
        if (opt.get('DescListPlugin', false, context)) {
            builder.usePlugin(DescListPlugin.create())
        }
        if (opt.get('IdHeadingPlugin', false, context)) {
            builder.usePlugin(IdHeadingPlugin.create())
        }
        if (opt.get('FootnotePlugin', false, context)) {
            builder.usePlugin(FootnotePlugin.create())
        }
        if (opt.get('ImageCollectPlugin', false, context)) {
            builder.usePlugin(ImageCollectPlugin.create())
        }
        if (opt.get('SubPlugin', false, context)) {
            builder.usePlugin(SubPlugin.create())
        }
        if (opt.get('SupPlugin', false, context)) {
            builder.usePlugin(SupPlugin.create())
        }
        if (opt.get('EmojiPlugin', false, context)) {
            let EmojiPlugin_light = opt.get('EmojiPlugin_light', false, context)
            builder.usePlugin(EmojiPlugin.create(EmojiPlugin_light))
        }
        if (opt.get('HighlightDelimeterPlugin', false, context)) {
            builder.usePlugin(HighlightDelimeterPlugin.create())
        }
        if (opt.get('WhitelistLooseDelimiterPlugin', false, context)) {
            let jv = opt["WhitelistLooseDelimiterPlugin_DelimiterFilterMode"]
            let mode = if (jv.isUndefined() || jv.isNull()) {
                DelimiterFilterMode.Permissive
            } else if (jv.isString()) {
                match (String.fromJSValue(context, jv)) {
                    case "Strict" => DelimiterFilterMode.Strict
                    case _ => DelimiterFilterMode.Permissive
                }
            } else if (jv.isArray()) {
                DelimiterFilterMode.Selective(JSArrayEx<String>.fromJSValue(context, jv).toArray())
            } else {
                DelimiterFilterMode.Permissive
            }
            builder.usePlugin(WhitelistLooseDelimiterPlugin.create(mode))
        }
        if (opt.get('TocPlugin', false, context)) {
            builder.usePlugin(TocPlugin.create())
        }
        if (opt.get('BlockCustomCardPlugin', false, context)) {
            builder.usePlugin(createCustomCardPlugin(opt, context))
        }
        if (opt.get('NodeIdPlugin', false, context)) {
            builder.usePlugin(NodeIdPlugin.create())
        }

        let parser = builder.build()
        let clazz = HybridParser(parser, jsNodeFactory)

        JSCurrentJSContext.unset()
        let thisArg = callInfo.thisArg
        let thisObject = thisArg.asObject(context)
        let jsExternal = context.external(clazz)
        thisObject.attachCJObject(jsExternal)
        return thisObject.toJSValue()
    }

    public func parse(md: String, context: JSContext): JSValue {
        let promise = context.promiseCapability()
        spawn {
            try {
                let doc: Node = parser.toMarkdown(md)
                context.postJSTask {
                    try {
                        let jsNodeTreeBuilder = JsNodeBuilder(jsNodeFactory, context)
                        let RET = jsNodeTreeBuilder.buildNode(doc).toJSValue()
                        promise.resolve(RET)
                    } catch (e: Exception) {
                        promise.reject(context.string(e.toString()).toJSValue())
                        Hilog.error(0, 'hybrid Exception 3.1', getStackTrace(e))
                    }
                }
            } catch (e: Exception) {
                throw e
                context.postJSTask {
                    promise.reject(context.string(e.toString()).toJSValue())
                    Hilog.error(0, 'hybrid Exception 2.1', getStackTrace(e))
                }
            }
        }
        return promise.toJSValue()
    }

    public static func parse_ArkTS_Interop_Identifier(context: JSContext, callInfo: JSCallInfo): JSValue {
        try {
            let thisArg = callInfo.thisArg
            let thisObject = thisArg.asObject(context)
            let jsExternal = thisObject.getAttachInfo() ?? throw Exception("class: get external failed.")
            let clazz = jsExternal.cast<HybridParser>() ?? throw Exception("class: get clazz failed.")

            let arg1754444626731223400 = String.fromJSValue(context, callInfo[0])

            JSCurrentJSContext.set(context)
            let RET = clazz.parse(arg1754444626731223400, context)
            JSCurrentJSContext.unset()
            return RET
        } catch (e: Exception) {
            Hilog.error(0, 'hybrid Exception 1.1', e.toString())
        }
        return context.undefined().toJSValue()
    }

    public func toJSValue(context: JSContext): JSValue {
        let ext = context.external(this)
        let obj = context.object()

        obj["parse"] = context.function(parse_ArkTS_Interop_Identifier).toJSValue()

        obj.attachCJObject(ext)
        obj.toJSValue()
    }

    public static func fromJSValue(context: JSContext, input: JSValue): HybridParser {
        let jsObj = input.asObject(context)
        let jsExt = jsObj.getAttachInfo() ?? throw Exception("class: get external failed.")
        let obj = jsExt.cast<HybridParser>() ?? throw Exception("class: get clazz failed.")
        return obj
    }
    public static func toArkTsType(): String {
        "class"
    }
}

/**
@Interop[ArkTS]
public class HybridParser1{
    public init() {

    }
    public func parse(md:String):String{
        throw Exception()
    }
}
 */
