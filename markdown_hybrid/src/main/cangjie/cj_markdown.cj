package markdown

var arkImgPreprocessFunc: ?(String) -> ?Array<Byte> = None

class cbRet {
    var value: ?Array<UInt8> = None
    var sem: Semaphore = Semaphore(1)
}

public func registerImgPreprocessCallback(context: JSContext, callInfo: JSCallInfo): JSValue {
    if (callInfo[0].typeof() == JSType.UNDEFINED) {
        arkImgPreprocessFunc = None
        return context.undefined().toJSValue()
    }
    let arktsCB = callInfo[0].asFunction(context)
    if (let Some(c) <- ctx) {
        arkImgPreprocessFunc = {
            url =>
                let ret: cbRet = cbRet()
                ret.sem.acquire()
                c.postJSTask {
                    newScope(context) {
                        let _url = url.toJSValue(context)
                        let _ret = arktsCB.call([_url]).asPromise()
                        let onFulfilled = context.function {
                            context, callInfo =>
                                let bufferValue = Option<Array<Byte>>.fromJSValue(context, callInfo[0])
                                if (let Some(v) <- bufferValue) {
                                    ret.value = v
                                }
                                ret.sem.release()
                                context.undefined().toJSValue()
                        }
                        _ret.then(onFulfilled)
                    }
                }
                ret.sem.acquire()
                let retValue = ret.value
                ret.sem.release()
                retValue
        }
    } else {
        arkImgPreprocessFunc = None
    }
    context.undefined().toJSValue()
}

/**
 * 获取加载仓颉页面互操作函数
 *
 * @param runtime JSContext
 * @param callInfo 接口数据
 * @return JSValue 返回更新函数
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
    var listScroller: ?CJMarkdownScroller = None
    if (callInfo[5].typeof() != JSType.UNDEFINED) {
        let scrollerObj: JSObject = callInfo[5].asObject()
        let scrollerExt: Option<JSExternal> = scrollerObj.getAttachInfo()
        if (let Some(v) <- scrollerExt) {
            listScroller = v.cast<CJMarkdownScroller>()
        }
    }
    let elementId = ViewStackProcessor.AllocateNewElmetIdForNextComponent()
    ViewStackProcessor.StartGetAccessRecordingFor(elementId)
    let comp = CJMarkdownComponent(
        Option<CustomView>.None,
        mdStr: ObservedProperty<String>("", mdStr),
        isInputEnded: ObservedProperty<Bool>("", isInputEnded),
        incrementalAnalysis: ObservedProperty<Bool>("", incrementalAnalysis),
        cfg: ObservedProperty<Option<CJMarkdownConfig>>("", cfg),
        plugin: ObservedProperty<Option<CJMarkdownPlugin>>("", plugin),
        listScroller: ObservedProperty<Option<CJMarkdownScroller>>("", listScroller)
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
 * 互操作透明颜色处理
 *
 * @param value 颜色值
 * @return Color Color对象
 *
 */
func transColorForTransparent(value: UInt32): Color {
    if (value >> 24 == 0) {
        Color.TRANSPARENT
    } else {
        Color(value)
    }
}

/**
 * 将Int64转换为FontStyle
 *
 * @param style 字体样式代码
 * @return FontStyle枚举值
 */
func convertFontStyle(style: Int64): FontStyle {
    match (style) {
        case 0 => FontStyle.Normal
        case 1 => FontStyle.Italic
        case _ => FontStyle.Normal
    }
}

/**
 * 将Int64转换为FontWeight
 *
 * @param weight 字体粗细代码
 * @return FontWeight枚举值
 */
func convertFontWeight(weight: Int64): FontWeight {
    match (weight) {
        case 0 => FontWeight.Lighter
        case 1 => FontWeight.Normal
        case 2 => FontWeight.Regular
        case 3 => FontWeight.Medium
        case 4 => FontWeight.Bold
        case 5 => FontWeight.Bolder
        case 100 => FontWeight.W100
        case 200 => FontWeight.W200
        case 300 => FontWeight.W300
        case 400 => FontWeight.W400
        case 500 => FontWeight.W500
        case 600 => FontWeight.W600
        case 700 => FontWeight.W700
        case 800 => FontWeight.W800
        case 900 => FontWeight.W900
        case _ => FontWeight.Normal
    }
}

/**
 * 将Int64转换为BorderStyle
 *
 * @param style 字体样式代码
 * @return BorderStyle枚举值
 */
func convertBorderStyle(style: Int64): BorderStyle {
    match (style) {
        case 0 => BorderStyle.Solid
        case 1 => BorderStyle.Dashed
        case 2 => BorderStyle.Dotted
        case _ => BorderStyle.Solid
    }
}

/**
 * 将Int64转换为LineCapStyle
 *
 * @param style 分割线端点样式
 * @return LineCapStyle枚举值
 */
func convertLineCapStyle(style: Int64): LineCapStyle {
    match (style) {
        case 0 => LineCapStyle.Butt
        case 1 => LineCapStyle.Round
        case 2 => LineCapStyle.Square
        case _ => LineCapStyle.Butt
    }
}

/**
 * 将Int64转换为TextDecorationType
 *
 * @param decorationType 文本装饰线类型
 * @return TextDecorationType枚举值
 */
func convertTextDecorationType(decorationType: Int64): TextDecorationType {
    match (decorationType) {
        case 0 => TextDecorationType.None // 无装饰线
        case 1 => TextDecorationType.Overline // 上划线
        case 2 => TextDecorationType.Underline // 下划线
        case 3 => TextDecorationType.LineThrough // 中划线
        case _ => TextDecorationType.None // 默认无装饰线
    }
}

/**
 * 将Int64转换为CheckBoxShape
 *
 * @param style 多选框形状
 * @return CheckBoxShape枚举值
 */
func convertCheckBoxShape(style: Int64): CheckBoxShape {
    match (style) {
        case 0 => CheckBoxShape.CIRCLE
        case 1 => CheckBoxShape.ROUNDED_SQUARE
        case _ => CheckBoxShape.ROUNDED_SQUARE
    }
}

/**
 * 将Int64转换为BarState
 *
 * @param style 滚动条状态
 * @return BarState枚举值
 */
func convertBarState(style: Int64): BarState {
    match (style) {
        case 0 => BarState.On
        case 1 => BarState.Off
        case 2 => BarState.Auto
        case _ => BarState.Off
    }
}

/**
 * 将Int64转换为ImageFit
 *
 * @param imageFitType 图片缩放类型
 * @return ImageFit枚举值
 */
func convertImageFitType(imageFitType: Int64): ImageFit {
    match (imageFitType) {
        case 0 => ImageFit.Contain
        case 1 => ImageFit.Cover
        case 2 => ImageFit.Fill
        case _ => ImageFit.Contain
    }
}
