package markdown

/**
 * JSContext
 */
public var ctx: ?JSContext = None

let EXPORT_MODULE = JSModule.registerModule {
    runtime, exports =>
    ctx = runtime
    exports["setGlobalContext"] = runtime.function(setGlobalContext).toJSValue()
    exports["getCJResource"] = runtime.function(getCJResource).toJSValue()
    exports["getLoadCJPage"] = runtime.function(getLoadCJPage).toJSValue()
    exports["registerImgPreprocessCallback"] = runtime.function(registerImgPreprocessCallback).toJSValue()
}
