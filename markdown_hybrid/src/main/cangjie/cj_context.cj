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

/**
 * JSContext
 */
public var ctx: ?JSContext = None

/**
 * 定义一个全局的 Context 获取类，方便后续其他业务使用
 */
public class GlobalContext {
    static var _context: Option<StageContext> = None

    /**
     * 设置StageContext
     *
     * @param context StageContext
     */
    public static func setContext(context: StageContext): Unit {
        _context = context
    }

    /**
     * 获取StageContext
     *
     * @return Option<StageContext> StageContext
     */
    public static func getContext(): Option<StageContext> {
        return _context
    }
}

/**
 * 设置StageContext互操作函数
 *
 * @param runtime JSContext
 * @param callInfo 接口数据
 * @return JSValue 返回值
 */
func setGlobalContext(runtime: JSContext, callInfo: JSCallInfo): JSValue {
    let jsEnv = runtime.getNapiEnv()
    let jsValue = arkTsValuetoNapiValue(jsEnv, callInfo[0])
    if (isStageMode(jsEnv, jsValue)) {
        GlobalContext.setContext(getContextStageMode(jsEnv, jsValue))
    } else {
    }
    return runtime.undefined().toJSValue()
}