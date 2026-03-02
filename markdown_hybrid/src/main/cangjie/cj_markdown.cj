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
import std.sync.*

var arkImgPreprocessFunc: ?(String) -> ?Array<Byte> = None

class cbRet {
    var value: ?Array<UInt8> = None
    var sem: Semaphore = Semaphore(1)
}

public func registerImgPreprocessCallback(context: JSContext, callInfo: JSCallInfo): JSValue {
    let arktsCB = callInfo[0].asFunction(context)
    arkImgPreprocessFunc = {
        url =>
            let ret: cbRet = cbRet()
            ret.sem.acquire()
            ctx.getOrThrow().postJSTask {
                    let _url = url.toJSValue(context)
                    let _ret = arktsCB.call([_url]).asPromise()
                    let onFulfilled = context.function {
                        context, callInfo =>
                            let bufferVale = Option<Array<Byte>>.fromJSValue(context, callInfo[0])
                            if (bufferVale.isSome()) {
                                ret.value = bufferVale.getOrThrow()
                            }
                            ret.sem.release()
                            context.undefined().toJSValue()
                    }
                    _ret.then(onFulfilled)
                }
            ret.sem.acquire()
            let retValue = ret.value
            ret.sem.release()
            retValue
    }
    context.undefined().toJSValue()
}

/**
 * 设置markdown属性互操作函数
 *
 * @param runtime JSContext
 * @param callInfo 接口数据
 * @return JSValue 返回值
 */
public func getLoadCJPage(ctx: JSContext, callInfo: JSCallInfo): JSValue {
    let mdStr: String = callInfo[0].asString().toString()
    let isInputEnded: Bool = callInfo[1].asBoolean().toBool()
    let incrementalAnalysis: Bool = callInfo[2].asBoolean().toBool()
    var cfg: ?CJMarkdownConfig = None
    if (callInfo[3].typeof() != JSType.UNDEFINED) {
        let cfgObj: JSObject = callInfo[3].asObject(ctx)
        let cfgExt: Option<JSExternal> = cfgObj.getAttachInfo()
        if (let Some(v) <- cfgExt) {
            cfg = v.cast<CJMarkdownConfig>()
        }
    }
    var plugin: ?CJMarkdownPlugin = None
    if (callInfo[4].typeof() != JSType.UNDEFINED) {
        let cfgObj: JSObject = callInfo[4].asObject(ctx)
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
        isInputEnded: ObservedProperty<Bool>("", isInputEnded),
        incrementalAnalysis: ObservedProperty<Bool>("", incrementalAnalysis),
        cfg: ObservedProperty<Option<CJMarkdownConfig>>("", cfg),
        plugin: ObservedProperty<Option<CJMarkdownPlugin>>("", plugin)
    )
    CustomView.create(comp)
    ViewStackProcessor.StopGetAccessRecording()
    return ctx.function(
            {
                ctx1: JSContext, callInfo1: JSCallInfo =>
                    let mdStr = String.fromJSValue(ctx1, callInfo1[0])
                    let isInputEnded = Bool.fromJSValue(ctx1, callInfo1[1])
                    let incrementalAnalysis = Bool.fromJSValue(ctx1, callInfo1[2])
                    comp.updateMarkDown(mdStr, isInputEnded, incrementalAnalysis)
                    return ctx1.undefined().toJSValue()
            }
        ).toJSValue()
}

var codeFullScreenIcon: ?AppResource = None
var codeCopyIcon: ?AppResource = None
var audioIcon: ?AppResource = None
var videoImage: ?AppResource = None
var playCircleFillIcon: ?AppResource = None
var bannerImage: ?AppResource = None
var imageResource: ?AppResource = None
var videoReleaseImage: ?AppResource = None
var videoDownloadImage: ?AppResource = None
var imageDownloadImage: ?AppResource = None

public func getCJResource(ctx: JSContext, callInfo: JSCallInfo): JSValue {
    if (callInfo[0].typeof() != JSType.UNDEFINED) {
        codeFullScreenIcon = arktsRes2CJResource(ctx, callInfo[0])
    } else {
        codeFullScreenIcon = None
    }
    if (callInfo[1].typeof() != JSType.UNDEFINED) {
        codeCopyIcon = arktsRes2CJResource(ctx, callInfo[1])
    } else {
        codeCopyIcon = None
    }
    if (callInfo[2].typeof() != JSType.UNDEFINED) {
        audioIcon = arktsRes2CJResource(ctx, callInfo[2])
    } else {
        audioIcon = None
    }
    if (callInfo[3].typeof() != JSType.UNDEFINED) {
        videoImage = arktsRes2CJResource(ctx, callInfo[3])
    } else {
        videoImage = None
    }
    if (callInfo[4].typeof() != JSType.UNDEFINED) {
        playCircleFillIcon = arktsRes2CJResource(ctx, callInfo[4])
    } else {
        playCircleFillIcon = None
    }
    if (callInfo[5].typeof() != JSType.UNDEFINED) {
        bannerImage = arktsRes2CJResource(ctx, callInfo[5])
    } else {
        bannerImage = None
    }
    if (callInfo[6].typeof() != JSType.UNDEFINED) {
        imageResource = arktsRes2CJResource(ctx, callInfo[6])
    } else {
        imageResource = None
    }
    if (callInfo[7].typeof() != JSType.UNDEFINED) {
        videoReleaseImage = arktsRes2CJResource(ctx, callInfo[7])
    } else {
        videoReleaseImage = None
    }
    if (callInfo[8].typeof() != JSType.UNDEFINED) {
        videoDownloadImage = arktsRes2CJResource(ctx, callInfo[8])
    } else {
        videoDownloadImage = None
    }
    if (callInfo[9].typeof() != JSType.UNDEFINED) {
        imageDownloadImage = arktsRes2CJResource(ctx, callInfo[9])
    } else {
        imageDownloadImage = None
    }
    return ctx.undefined().toJSValue()
}

func arktsRes2CJResource(ctx: JSContext, value: JSValue): AppResource {
    let obj = value.asObject()
    AppResource(
        String.fromJSValue(ctx, obj["bundleName"]),
        String.fromJSValue(ctx, obj["moduleName"]),
        Int32.fromJSValue(ctx, obj["id"]),
        params: [],
        resType: Int32.fromJSValue(ctx, obj["type"]),
    )
}

/**
 * 互操作透明色颜色处理
 *
 * @param value 颜色值
 * @return Color Color对象
 *
 */
func transColorForTrasparent(value: UInt32): Color {
    if (value >> 24 == 0) {
        Color.TRANSPARENT
    } else {
        Color(value)
    }
}
