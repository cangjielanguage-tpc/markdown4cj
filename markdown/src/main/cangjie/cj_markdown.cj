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
import ohos.resource_manager.AppResource

/**
 * 设置markdown属性互操作函数
 *
 * @param runtime JSContext
 * @param callInfo 接口数据
 * @return JSValue 返回值
 */
public func getLoadCJPage(ctx: JSContext, callInfo: JSCallInfo): JSValue {
    let mdStr: String = callInfo[0].asString().toString()
    let isFull: Bool = callInfo[1].asBoolean().toBool()
    var cfg: ?CJMarkdownConfig = None
    if (callInfo[2].typeof() != JSType.UNDEFINED) {
        let cfgObj: JSObject = callInfo[2].asObject(ctx)
        let cfgExt: Option<JSExternal> = cfgObj.getAttachInfo()
        if (let Some(v) <- cfgExt) {
            cfg = v.cast<CJMarkdownConfig>()
        }
    }
    var plugin: ?CJMarkdownPlugin = None
    if (callInfo[3].typeof() != JSType.UNDEFINED) {
        let cfgObj: JSObject = callInfo[3].asObject(ctx)
        let cfgExt: Option<JSExternal> = cfgObj.getAttachInfo()
        if (let Some(v) <- cfgExt) {
            plugin = v.cast<CJMarkdownPlugin>()
        }
    }
    let elmetId = ViewStackProcessor.AllocateNewElmetIdForNextComponent()
    ViewStackProcessor.StartGetAccessRecordingFor(elmetId)
    let comp = CJMarkdownComponent(
        Option<CustomView>.None,
        mdStr: ObservedProperty<String>("", mdStr),
        isFull: ObservedProperty<Bool>("", isFull),
        cfg: ObservedProperty<Option<CJMarkdownConfig>>("", cfg),
        plugin: ObservedProperty<Option<CJMarkdownPlugin>>("", plugin)
    )
    CustomView.create(comp)
    ViewStackProcessor.StopGetAccessRecording()
    return ctx
        .function(
            {
                ctx1: JSContext, callInfo1: JSCallInfo =>
                let input = callInfo1[0].asString().toString()
                comp.updateMarkDown(input)
                return ctx.undefined().toJSValue()
            }
        )
        .toJSValue()
}

var codeFullScreenIcon: ?AppResource = None
var codeCopyIcon: ?AppResource = None
var audioIcon: ?AppResource = None
var videoImage: ?AppResource = None
var playCircleFillIcon: ?AppResource = None
var bannerImage: ?AppResource = None
var imageResource: ?AppResource = None

public func getCJResource(ctx: JSContext, callInfo: JSCallInfo): JSValue {
    if (callInfo[0].typeof() != JSType.UNDEFINED) {
        codeFullScreenIcon = arktsRes2CJResource(ctx, callInfo[0])
    }
    if (callInfo[1].typeof() != JSType.UNDEFINED) {
        codeCopyIcon = arktsRes2CJResource(ctx, callInfo[1])
    }
    if (callInfo[2].typeof() != JSType.UNDEFINED) {
        audioIcon = arktsRes2CJResource(ctx, callInfo[2])
    }
    if (callInfo[3].typeof() != JSType.UNDEFINED) {
        videoImage = arktsRes2CJResource(ctx, callInfo[3])
    }
    if (callInfo[4].typeof() != JSType.UNDEFINED) {
        playCircleFillIcon = arktsRes2CJResource(ctx, callInfo[4])
    }
    if (callInfo[5].typeof() != JSType.UNDEFINED) {
        bannerImage = arktsRes2CJResource(ctx, callInfo[5])
    }
    if (callInfo[6].typeof() != JSType.UNDEFINED) {
        imageResource = arktsRes2CJResource(ctx, callInfo[6])
    }
    return ctx.undefined().toJSValue()
}

func arktsRes2CJResource(ctx: JSContext, value: JSValue): AppResource {
    let obj = value.asObject()
    AppResource(
        String.fromJSValue(ctx, obj["bundleName"]),
        String.fromJSValue(ctx, obj["moduleName"]),
        Int32.fromJSValue(ctx, obj["id"]),
        params:[],
        resType: Int32.fromJSValue(ctx, obj["type"]),
    )
}
