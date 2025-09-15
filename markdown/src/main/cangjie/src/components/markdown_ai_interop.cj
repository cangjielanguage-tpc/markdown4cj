/**
 * Created on 2025/9/13
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
                let global = context.getOrThrow().global
                let ctx = context.getOrThrow()
                let list = global["Span"].asObject(ctx)
                let textBackgroundStyle = list["textBackgroundStyle"].asFunction(ctx)
                let param: JSObject = ctx.object()
                param["color"] = ctx.string("#7F007dff").toJSValue()
                param["radius"] = ctx.string("0vp").toJSValue()
                textBackgroundStyle.call(param.toJSValue())
            } catch (e: Exception) {
            }
        }
        return this
    }
}
