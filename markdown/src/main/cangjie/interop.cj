/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.ark_interop.*
import ohos.ark_interop_helper.*
import std.collection.*

let EXPORT_MODULE = JSModule.registerModule {
    runtime, exports =>
    ctx = runtime
    exports["setGlobalContext"] = runtime.function(setGlobalContext).toJSValue()
    exports["getCJResource"] = runtime.function(getCJResource).toJSValue()
    exports["getLoadCJPage"] = runtime.function(getLoadCJPage).toJSValue()
}
