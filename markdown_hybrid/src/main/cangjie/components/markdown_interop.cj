package markdown.components

/**
 * JSContext
 */
public var context: ?JSContext = None

let _ = {
    => JSModule.registerModule(
        {
            ctx, exports =>
                context = ctx
                exports
        }
    )
}()

public func getCtx(): JSContext {
    let content = context ?? throw JSInteropNativeError("Component InterOp: get global context failed.")
    return content
}

public func jsObjApiCall(obj: JSObject, funcName: String, args: (JSContext) -> Array<JSValue>): Unit {
    try {
        obj.callMethod(funcName, args(getCtx()))
    } catch (e: Exception) {
        throw BusinessException(10000, "Cannot find the ${funcName}")
    }
}

public func jsObjApiCall(obj: JSObject, funcName: String): Unit {
    try {
        obj.callMethod(funcName)
    } catch (e: JSCodeError) {
        throw BusinessException(10000, "Cannot execute the ${funcName} function")
    }
}

public open class InteropObjectBase {
    protected var jsObj: ?JSObject = None
    private let globalThis = getCtx().global

    init() {}

    protected init(obj: JSObject) {
        jsObj = obj
    }

    protected init(objName: JSKeyable) {
        if (!globalThis.hasProperty(objName)) {
            throw IllegalArgumentException("there is no ${objName} in globalThis")
        }
        jsObj = globalThis[objName].asClass().new().asObject()
    }

    protected init(objName: JSKeyable, args: Array<JSValue>) {
        if (!globalThis.hasProperty(objName)) {
            throw IllegalArgumentException("there is no ${objName} in globalThis")
        }
        jsObj = globalThis[objName].asClass().new(args).asObject()
    }

    protected func getObjectName(): String {
        let constructor = jsObj.getOrThrow()["constructor"]
        if (constructor.isUndefined()) {
            "object"
        } else {
            String.fromJSValue(getCtx(), constructor.asObject()["name"])
        }
    }

    protected func callMethod(key: JSKeyable, args: (JSContext) -> Array<JSValue>): JSValue {
        jsObj.getOrThrow().callMethod(key, args(getCtx()))
    }

    protected func callMethod(key: JSKeyable): JSValue {
        jsObj.getOrThrow().callMethod(key)
    }

    protected func getObj(): JSObject {
        jsObj.getOrThrow()
    }

    protected func getProp(key: JSKeyable): JSValue {
        jsObj.getOrThrow()[key]
    }

    protected func setProp(key: JSKeyable, value: JSValue) {
        jsObj.getOrThrow()[key] = value
    }

    protected open func toJSValue(_: JSContext): JSValue {
        jsObj.getOrThrow().toJSValue()
    }

    public static func fromJSValue(_: JSContext, input: JSValue): InteropObjectBase {
        InteropObjectBase(input.asObject())
    }
}

public class CJSizeOptions <: InteropObjectBase {
    public CJSizeOptions(width: Float64, height: Float64) {
        super(getCtx().object())
        setProp("width", width.toJSValue(getCtx()))
        setProp("height", height.toJSValue(getCtx()))
    }

    public prop width: Float64 {
        get() {
            Float64.fromJSValue(getCtx(), getProp("width"))
        }
    }

    public prop height: Float64 {
        get() {
            Float64.fromJSValue(getCtx(), getProp("height"))
        }
    }

    public static func fromJSValue(context: JSContext, input: JSValue): CJSizeOptions {
        let width = Float64.fromJSValue(context, input.getProperty(context, "width"))
        let height = Float64.fromJSValue(context, input.getProperty(context, "height"))
        CJSizeOptions(width, height)
    }
}

extend Span {
    func interopDecorationStyle(decorationStyle: (TextDecorationType, Color, Int32)): Span {
        try {
            let dType: Float64 = match (decorationStyle[0]) {
                case Underline => 1.0
                case Overline => 2.0
                case LineThrough => 3.0
                case _ => 0.0
            }

            let dColor: UInt32 = decorationStyle[1].toUInt32()
            let colorString: String = dColor.format("08X")

            let dStyle: Float64 = if (decorationStyle[2] < 0 || decorationStyle[2] > 4) {
                0.0 // 负数和超出枚举范围，设置为0
            } else {
                Float64(decorationStyle[2])
            }

            let global = context.getOrThrow().global
            let ctx = context.getOrThrow()
            let span = global["Span"].asObject(ctx)

            let decoration = span["decoration"].asFunction(ctx)
            let param: JSObject = ctx.object()
            param["type"] = ctx.number(dType).toJSValue()
            param["color"] = ctx.string("#${colorString}").toJSValue()
            param["style"] = ctx.number(dStyle).toJSValue()
            decoration.call(param.toJSValue())
        } catch (e: Exception) {
        }
        return this
    }
}

extend Column {
    func interopOnSizeChange(callback: (CJSizeOptions, CJSizeOptions) -> Unit): Column {
        try {
            let global = context.getOrThrow().global
            let ctx = context.getOrThrow()
            let column = global["Column"].asObject(ctx)
            let callBackFunc = getCtx().function {
                ctx, callInfo => callback(CJSizeOptions.fromJSValue(ctx, callInfo[0]), CJSizeOptions.fromJSValue(ctx, callInfo[1])).toJSValue(ctx)
            }
            column.callMethod("onSizeChange", [callBackFunc.toJSValue()])
        } catch (e: Exception) {
        }
        return this
    }
}

extend List {
    func interopOnSizeChange(callback: (CJSizeOptions, CJSizeOptions) -> Unit): List {
        try {
            let global = context.getOrThrow().global
            let ctx = context.getOrThrow()
            let list = global["List"].asObject(ctx)
            let callBackFunc = getCtx().function {
                ctx, callInfo => callback(CJSizeOptions.fromJSValue(ctx, callInfo[0]), CJSizeOptions.fromJSValue(ctx, callInfo[1])).toJSValue(ctx)
            }
            list.callMethod("onSizeChange", [callBackFunc.toJSValue()])
        } catch (e: Exception) {
        }
        return this
    }
}
