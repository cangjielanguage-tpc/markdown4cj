package markdown

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
