/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown

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
        throw BusinessException(10000, "Cannot excute the ${funcName} function")
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
        jsObj
            .getOrThrow()
            .toJSValue()
    }

    static func fromJSValue(_: JSContext, input: JSValue): InteropObjectBase {
        InteropObjectBase(input.asObject())
    }
}

public class CJArkRectResult <: InteropObjectBase {
    public CJArkRectResult(x: Float64, y: Float64, width: Float64, height: Float64) {
        super(getCtx().object())
        setProp("x", x.toJSValue(getCtx()))
        setProp("y", y.toJSValue(getCtx()))
        setProp("width", width.toJSValue(getCtx()))
        setProp("height", height.toJSValue(getCtx()))
    }

    public prop x: Float64 {
        get() {
            Float64.fromJSValue(getCtx(), getProp("x"))
        }
    }

    public prop y: Float64 {
        get() {
            Float64.fromJSValue(getCtx(), getProp("y"))
        }
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

    static func fromJSValue(context: JSContext, input: JSValue): CJArkRectResult {
        let x = Float64.fromJSValue(context, input.getProperty(context, "x"))
        let y = Float64.fromJSValue(context, input.getProperty(context, "y"))
        let width = Float64.fromJSValue(context, input.getProperty(context, "width"))
        let height = Float64.fromJSValue(context, input.getProperty(context, "height"))
        CJArkRectResult(x, y, width, height)
    }
}

extend Scroller {
    func interopGetItemRect(index: Int64): CJArkRectResult {
        try {
            let global = context.getOrThrow().global
            let ctx = context.getOrThrow()
            let scroller = global["Scroller"].asObject(ctx)
            let getItemRect = scroller["getItemRect"].asFunction(ctx)
            let jsValue = getItemRect.call(index.toJSValue(ctx))
            return CJArkRectResult.fromJSValue(ctx, jsValue)
        } catch (e: Exception) {
            return CJArkRectResult(0.0, 0.0, 0.0, 0.0)
        }
    }
}
