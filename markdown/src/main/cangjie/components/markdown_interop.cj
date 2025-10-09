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
}
