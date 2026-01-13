/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown

import ohos.ark_interop.JSContext
import ohos.ark_interop.JSCallInfo
import ohos.ark_interop.JSValue
import kit.AbilityKit.Context
import kit.AbilityKit.createContextFromJSValue

/**
 * JSContext
 */
public var ctx: ?JSContext = None

/**
 * 定义一个全局的 Context 获取类，方便后续其他业务使用
 */
public class GlobalContext {
    static var _context: Option<Context> = None

    /**
     * 设置StageContext
     *
     * @param context StageContext
     */
    public static func setContext(context: Context): Unit {
        _context = context
    }

    /**
     * 获取StageContext
     *
     * @return Option<StageContext> StageContext
     */
    public static func getContext(): Option<Context> {
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
    let jsValue = callInfo[0]
    GlobalContext.setContext(createContextFromJSValue(runtime, jsValue))
    return runtime.undefined().toJSValue()
}