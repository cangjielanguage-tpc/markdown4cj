/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown

import ohos.ark_interop.*

let EXPORT_MODULE = JSModule.registerModule {
    runtime, exports =>
    ctx = runtime
    exports["setGlobalContext"] = runtime.function(setGlobalContext).toJSValue()
    exports["getCJResource"] = runtime.function(getCJResource).toJSValue()
    exports["getLoadCJPage"] = runtime.function(getLoadCJPage).toJSValue()
    exports["registerImgPreprocessCallback"] = runtime.function(registerImgPreprocessCallback).toJSValue()
}
