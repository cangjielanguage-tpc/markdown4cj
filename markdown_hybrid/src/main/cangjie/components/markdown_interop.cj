/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.ark_interop.*
import ohos.ark_interop_helper.*

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
        jsObj.getOrThrow().toJSValue()
    }

    static func fromJSValue(_: JSContext, input: JSValue): InteropObjectBase {
        InteropObjectBase(input.asObject())
    }
}

public class ImageLoadResultInterop <: InteropObjectBase {
    public ImageLoadResultInterop(width: Float64, height: Float64, componentWidth: Float64, componentHeight: Float64,
        loadingStatus: Int64, contentWidth: Float64, contentHeight: Float64, contentOffsetX: Float64,
        contentOffsetY: Float64) {
        super(getCtx().object())
        setProp("width", width.toJSValue(getCtx()))
        setProp("height", height.toJSValue(getCtx()))
        setProp("componentWidth", componentWidth.toJSValue(getCtx()))
        setProp("componentHeight", componentHeight.toJSValue(getCtx()))
        setProp("loadingStatus", loadingStatus.toJSValue(getCtx()))
        setProp("contentWidth", contentWidth.toJSValue(getCtx()))
        setProp("contentHeight", contentHeight.toJSValue(getCtx()))
        setProp("contentOffsetX", contentOffsetX.toJSValue(getCtx()))
        setProp("contentOffsetY", contentOffsetY.toJSValue(getCtx()))
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

    public prop componentWidth: Float64 {
        get() {
            Float64.fromJSValue(getCtx(), getProp("componentWidth"))
        }
    }

    public prop componentHeight: Float64 {
        get() {
            Float64.fromJSValue(getCtx(), getProp("componentHeight"))
        }
    }

    public prop loadingStatus: Int64 {
        get() {
            Int64.fromJSValue(getCtx(), getProp("loadingStatus"))
        }
    }

    public prop contentWidth: Float64 {
        get() {
            Float64.fromJSValue(getCtx(), getProp("contentWidth"))
        }
    }

    public prop contentHeight: Float64 {
        get() {
            Float64.fromJSValue(getCtx(), getProp("contentHeight"))
        }
    }

    public prop contentOffsetX: Float64 {
        get() {
            Float64.fromJSValue(getCtx(), getProp("contentOffsetX"))
        }
    }

    public prop contentOffsetY: Float64 {
        get() {
            Float64.fromJSValue(getCtx(), getProp("contentOffsetY"))
        }
    }

    static func fromJSValue(context: JSContext, input: JSValue): ImageLoadResultInterop {
        let width = Float64.fromJSValue(context, input.getProperty(context, "width"))
        let height = Float64.fromJSValue(context, input.getProperty(context, "height"))
        let componentWidth = Float64.fromJSValue(context, input.getProperty(context, "componentWidth"))
        let componentHeight = Float64.fromJSValue(context, input.getProperty(context, "componentHeight"))
        let loadingStatus = Int64.fromJSValue(context, input.getProperty(context, "loadingStatus"))
        let contentWidth = Float64.fromJSValue(context, input.getProperty(context, "contentWidth"))
        let contentHeight = Float64.fromJSValue(context, input.getProperty(context, "contentHeight"))
        let contentOffsetX = Float64.fromJSValue(context, input.getProperty(context, "contentOffsetX"))
        let contentOffsetY = Float64.fromJSValue(context, input.getProperty(context, "contentOffsetY"))
        ImageLoadResultInterop(width, height, componentWidth, componentHeight, loadingStatus, contentWidth, contentHeight, contentOffsetX, contentOffsetY)
    }
}

public class CJImageErrorInterop <: InteropObjectBase {
    public CJImageErrorInterop(componentWidth: Float64, componentHeight: Float64, message: String) {
        super(getCtx().object())
        setProp("componentWidth", componentWidth.toJSValue(getCtx()))
        setProp("componentHeight", componentHeight.toJSValue(getCtx()))
        setProp("message", message.toJSValue(getCtx()))
    }

    public prop componentWidth: Float64 {
        get() {
            Float64.fromJSValue(getCtx(), getProp("componentWidth"))
        }
    }

    public prop componentHeight: Float64 {
        get() {
            Float64.fromJSValue(getCtx(), getProp("componentHeight"))
        }
    }

    public prop message: String {
        get() {
            String.fromJSValue(getCtx(), getProp("message"))
        }
    }

    static func fromJSValue(context: JSContext, input: JSValue): CJImageErrorInterop {
        let componentWidth = Float64.fromJSValue(context, input.getProperty(context, "componentWidth"))
        let componentHeight = Float64.fromJSValue(context, input.getProperty(context, "componentHeight"))
        let message = String.fromJSValue(context, input.getProperty(context, "message"))
        CJImageErrorInterop(componentWidth, componentHeight, message)
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

    static func fromJSValue(context: JSContext, input: JSValue): CJSizeOptions {
        let width = Float64.fromJSValue(context, input.getProperty(context, "width"))
        let height = Float64.fromJSValue(context, input.getProperty(context, "height"))
        CJSizeOptions(width, height)
    }
}

public class CJPosition <: InteropObjectBase {
    public CJPosition(x: Float64, y: Float64) {
        super(getCtx().object())
        setProp("x", x.toJSValue(getCtx()))
        setProp("y", y.toJSValue(getCtx()))
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

    static func fromJSValue(context: JSContext, input: JSValue): CJPosition {
        let x = Float64.fromJSValue(context, input.getProperty(context, "x"))
        let y = Float64.fromJSValue(context, input.getProperty(context, "y"))
        CJPosition(x, y)
    }
}

public class CJArea <: InteropObjectBase {
    public CJArea(width: Float64, height: Float64, position: CJPosition, globalPosition: CJPosition) {
        super(getCtx().object())
        setProp("width", width.toJSValue(getCtx()))
        setProp("height", height.toJSValue(getCtx()))
        setProp("position", position.toJSValue(getCtx()))
        setProp("globalPosition", globalPosition.toJSValue(getCtx()))
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

    public prop position: CJPosition {
        get() {
            CJPosition.fromJSValue(getCtx(), getProp("position"))
        }
    }

    public prop globalPosition: CJPosition {
        get() {
            CJPosition.fromJSValue(getCtx(), getProp("globalPosition"))
        }
    }

    static func fromJSValue(context: JSContext, input: JSValue): CJArea {
        let width = Float64.fromJSValue(context, input.getProperty(context, "width"))
        let height = Float64.fromJSValue(context, input.getProperty(context, "height"))
        let position = CJPosition.fromJSValue(context, input.getProperty(context, "position"))
        let globalPosition = CJPosition.fromJSValue(context, input.getProperty(context, "globalPosition"))
        CJArea(width, height, position, globalPosition)
    }
}

public class CJLengthMetrics <: InteropObjectBase {
    public CJLengthMetrics(value: Float64, unit: Int64) {
        super(getCtx().object())
        setProp("value", value.toJSValue(getCtx()))
        setProp("unit", unit.toJSValue(getCtx()))
    }

    public prop value: Float64 {
        get() {
            Float64.fromJSValue(getCtx(), getProp("value"))
        }
    }

    public prop unit: Int64 {
        get() {
            Int64.fromJSValue(getCtx(), getProp("unit"))
        }
    }

    static func fromJSValue(context: JSContext, input: JSValue): CJLengthMetrics {
        let value = Float64.fromJSValue(context, input.getProperty(context, "value"))
        let unit = Int64.fromJSValue(context, input.getProperty(context, "unit"))
        CJLengthMetrics(value, unit)
    }
}

extend Span {
    func interopStyle(isBool: Bool, backgroundColor: Color): Span {
        if (isBool) {
            try {
                let colorUInt32: UInt32 = backgroundColor.toUInt32()
                let str: String = colorUInt32.format("08X")
                let global = context.getOrThrow().global
                let ctx = context.getOrThrow()
                let span = global["Span"].asObject(ctx)
                let textBackgroundStyle = span["textBackgroundStyle"].asFunction(ctx)
                let param: JSObject = ctx.object()
                param["color"] = ctx.string("#${str}").toJSValue()
                param["radius"] = ctx.string("0vp").toJSValue()
                textBackgroundStyle.call(param.toJSValue())
            } catch (e: Exception) {
            }
        }
        return this
    }

    func interopBaselineOffset(value: CJLengthMetrics): Span {
        try {
            let global = context.getOrThrow().global
            let ctx = context.getOrThrow()
            let span = global["Span"].asObject(ctx)
            let baselineOffset = span["baselineOffset"].asFunction(ctx)
            baselineOffset.call(value.toJSValue(ctx))
        } catch (e: Exception) {
        }
        return this
    }

    func interopLineHeight(value: Float64): Span {
        try {
            let global = context.getOrThrow().global
            let ctx = context.getOrThrow()
            let span = global["Span"].asObject(ctx)
            let lineHeight = span["lineHeight"].asFunction(ctx)
            lineHeight.call(value.toJSValue(ctx))
        } catch (e: Exception) {
        }
        return this
    }

    func interopDecorationStyle(decorationType!: TextDecorationType = TextDecorationType.None, color!: Color = COLOR_FF191919, decorationStyle!: TextDecorationStyle = TextDecorationStyle.SOLID): Span {
        try {
            let dType: Int32 = match (decorationType) {
                case Underline => 1
                case Overline => 2
                case LineThrough => 3
                case _ => 0
            }

            let dColor: UInt32 = color.toUInt32()
            let colorString: String = dColor.format("08X")

            let dStyle: Int32 = match (decorationStyle) {
                case DOUBLE => 1
                case DOTTED => 2
                case DASHED => 3
                case WAVY => 4
                case _ => 0
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

extend Text {
    func interopCopyOption(isBool: Bool): Text {
        try {
            let global = context.getOrThrow().global
            let ctx = context.getOrThrow()
            let text = global["Text"].asObject(ctx)
            let copyOption = text["copyOption"].asFunction(ctx)
            let value: Int32 = if (isBool) {
                2
            } else {
                0
            }
            copyOption.call(value.toJSValue(ctx))
        } catch (e: Exception) {
        }
        return this
    }

    func interopOnCopy(callback: (String) -> Unit): Text {
        try {
            let global = context.getOrThrow().global
            let ctx = context.getOrThrow()
            let text = global["Text"].asObject(ctx)
            let onCopy = text["onCopy"].asFunction(ctx)
            let arg = ctx.function {
                context: JSContext, callInfo: JSCallInfo =>
                    let value1 = callInfo[0].toString()
                    callback(value1)
                    context.undefined().toJSValue()
            }
            onCopy.call(arg.toJSValue())
        } catch (e: Exception) {
        }
        return this
    }

    func interopHalfLeading(isBool: Bool): Text {
        try {
            let global = context.getOrThrow().global
            let ctx = context.getOrThrow()
            let text = global["Text"].asObject(ctx)
            let halfLeading = text["halfLeading"].asFunction(ctx)
            halfLeading.call(isBool.toJSValue(ctx))
        } catch (e: Exception) {
        }
        return this
    }

    func interopLineSpacing(value: CJLengthMetrics): Text {
        try {
            let global = context.getOrThrow().global
            let ctx = context.getOrThrow()
            let text = global["Text"].asObject(ctx)
            let lineSpacing = text["lineSpacing"].asFunction(ctx)
            lineSpacing.call(value.toJSValue(ctx))
        } catch (e: Exception) {
        }
        return this
    }
}

extend ImageSpan {
    func interopOnComplete(value: (result: ImageLoadResultInterop) -> Unit): ImageSpan {
        try {
            let global = context.getOrThrow().global
            let ctx = context.getOrThrow()
            let imageSpan = global["ImageSpan"].asObject(ctx)
            let argFunc = getCtx().function(
                    {
                        context: JSContext, callInfo: JSCallInfo =>
                            let ret = value(ImageLoadResultInterop.fromJSValue(context, callInfo[0]))
                            ret.toJSValue(context)
                    }
                )
                .toJSValue()
            jsObjApiCall(imageSpan, "onComplete", {ctx => [argFunc]})
        } catch (e: Exception) {
        }
        return this
    }

    func interopOnError(value: (error: CJImageErrorInterop) -> Unit): ImageSpan {
        try {
            let global = context.getOrThrow().global
            let ctx = context.getOrThrow()
            let imageSpan = global["ImageSpan"].asObject(ctx)
            let argFunc = getCtx().function(
                    {
                        context: JSContext, callInfo: JSCallInfo =>
                            let ret = value(CJImageErrorInterop.fromJSValue(context, callInfo[0]))
                            ret.toJSValue(context)
                    }
                )
                .toJSValue()
            jsObjApiCall(imageSpan, "onError", {ctx => [argFunc]})
        } catch (e: Exception) {
        }
        return this
    }

    func interopBorderRadius(value: Float64): ImageSpan {
        try {
            let global = context.getOrThrow().global
            let ctx = context.getOrThrow()
            let imageSpan = global["ImageSpan"].asObject(ctx)
            let radius = imageSpan["borderRadius"].asFunction(ctx)
            radius.call(value.toJSValue(ctx))
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

    func interopOnAreaChange(callback: (CJArea, CJArea) -> Unit): Column {
        try {
            let global = context.getOrThrow().global
            let ctx = context.getOrThrow()
            let column = global["Column"].asObject(ctx)
            let callBackFunc = getCtx().function {
                ctx, callInfo => callback(CJArea.fromJSValue(ctx, callInfo[0]), CJArea.fromJSValue(ctx, callInfo[1])).toJSValue(ctx)
            }
            column.callMethod("onAreaChange", [callBackFunc.toJSValue()])
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

    func interopEnableScrollInteraction(isBool: Bool): List {
        try {
            let global = context.getOrThrow().global
            let ctx = context.getOrThrow()
            let list = global["List"].asObject(ctx)
            let enableScrollInteraction = list["enableScrollInteraction"].asFunction(ctx)
            enableScrollInteraction.call(isBool.toJSValue(ctx))
        } catch (e: Exception) {
        }
        return this
    }
}

extend ListItem {
    func interopOnAreaChange(callback: (CJArea, CJArea) -> Unit): ListItem {
        try {
            let global = context.getOrThrow().global
            let ctx = context.getOrThrow()
            let listItem = global["ListItem"].asObject(ctx)
            let callBackFunc = getCtx().function {
                ctx, callInfo => callback(CJArea.fromJSValue(ctx, callInfo[0]), CJArea.fromJSValue(ctx, callInfo[1])).toJSValue(ctx)
            }
            listItem.callMethod("onAreaChange", [callBackFunc.toJSValue()])
        } catch (e: Exception) {
        }
        return this
    }

    func interopOnSizeChange(callback: (CJSizeOptions, CJSizeOptions) -> Unit): ListItem {
        try {
            let global = context.getOrThrow().global
            let ctx = context.getOrThrow()
            let listItem = global["ListItem"].asObject(ctx)
            let callBackFunc = getCtx().function {
                ctx, callInfo => callback(CJSizeOptions.fromJSValue(ctx, callInfo[0]), CJSizeOptions.fromJSValue(ctx, callInfo[1])).toJSValue(ctx)
            }
            listItem.callMethod("onSizeChange", [callBackFunc.toJSValue()])
        } catch (e: Exception) {
        }
        return this
    }
}
