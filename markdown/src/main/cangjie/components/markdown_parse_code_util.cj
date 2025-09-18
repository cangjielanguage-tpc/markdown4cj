/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 通过异步的方式将代码转换成带有颜色的列表 - 围栏代码、缩进代码
 *
 * @param code 传入代码内容
 * @param info 传入代码类型
 * @param prismTheme 传入的高亮样式
 * @param callback PrismNodesParseRes列表回调接口
 */
func stringToResList(code: String, info: ?String, prismTheme: PrismTheme,
    callback: (ArrayList<PrismNodesParseRes>) -> Unit): Future<Unit> {
    let fut: Future<Unit> = spawn {
        var prismNodesParseResList: ArrayList<PrismNodesParseRes> = ArrayList<PrismNodesParseRes>()
        try {
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            var psh: PrismSyntaxHighlight = PrismSyntaxHighlight.create(prism, prismTheme)
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            prismNodesParseResList = psh.highlight(info, code.trimEnd("\n"))
        } catch (e: Exception) {
            let prismNodesParseRes: PrismNodesParseRes = PrismNodesParseRes("", code, Option<String>.None, Option<Color>.None)
            prismNodesParseResList.add(prismNodesParseRes)
        } finally {
            try {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                callback(prismNodesParseResList)
            } catch (_) {
            }
        }
    }
    return fut
}


/**
 * 通过异步的方式将代码转换成带有颜色的列表 - 组合代码
 *
 * @param codeBlockListNodeView 传入围栏代码列表的NodeView
 * @param markdownConfiguration 传入MarkdownConfiguration
 * @param callback PrismNodesParseResState列表的列表回调接口
 * @param strText 代码列表数据
 * @return 返回PrismNodesParseResState列表的列表，返回代码类型的类型，返回代码内容列表，返回第一条数据内容
 */
func stringToResLists(codeBlockListNodeView: NodeView, markdownConfiguration: MarkdownConfiguration, strText: ArrayList<String>, callback: (ArrayList<ArrayList<PrismNodesParseRes>>) -> Unit): Future<Unit> {
    let fut: Future<Unit> = spawn {
        var prismNodesParseResLists: ArrayList<ArrayList<PrismNodesParseRes>> = ArrayList<ArrayList<PrismNodesParseRes>>()
        try {
            for (nodeView in codeBlockListNodeView.children) {
                if (nodeView.node is FencedCodeBlock) {
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    var prism: Prism = Prism(GrammarLocatorGrammarUtils())
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    var psh: PrismSyntaxHighlight = PrismSyntaxHighlight.create(prism, markdownConfiguration.markdownTheme.prismTheme)
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    let res: ArrayList<PrismNodesParseRes> = psh.highlight((nodeView.node as FencedCodeBlock)().getInfo(), (nodeView.node as FencedCodeBlock)().getLiteral().trimEnd("\n"))
                    prismNodesParseResLists.add(res)
                }
            }
        } catch (e: Exception) {
            for(str in  strText){
                let prismNodesParseResList:ArrayList<PrismNodesParseRes> = ArrayList<PrismNodesParseRes>()
                let prismNodesParseRes:PrismNodesParseRes = PrismNodesParseRes("", str, Option<String>.None, Option<Color>.None)
                prismNodesParseResList.add(prismNodesParseRes)
                prismNodesParseResLists.add(prismNodesParseResList)
            }
        } finally {
            try {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                callback(prismNodesParseResLists)
            } catch (_) {
            }
        }
    }
    return fut
}

class MarkdownParseCodeUtil {
    static func codeStrToRectPixelMap(strText: String, markdownConfiguration: MarkdownConfiguration, isFakeBoldText: Bool, callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var imageHeight: ?Float64 = Option<Float64>.None
            var imageWidth: ?Float64 = Option<Float64>.None
            var arr: ?Array<UInt8> = Option<Array<UInt8>>.None
            try (codeLoadLimiter = CodeLoadLimiter()) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                arr = drawRectImageButton(
                    strText,
                    markdownConfiguration.markdownTheme.codeTextSize,
                    markdownConfiguration.markdownTheme.codeTextColor.toUInt32(),
                    markdownConfiguration.markdownTheme.codeBackgroundColor.toUInt32(),
                    markdownConfiguration.markdownTheme.codeBackgroundColor.toUInt32(),
                    markdownConfiguration.markdownTheme.codeHeight,
                    ColorFormatEnum.COLOR_FORMAT_BGRA_8888,
                    markdownConfiguration.markdownTheme.codeLeftAndRightPadding,
                    0.0,
                    isFakeBoldText
                )
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var imageSource: ImageSource = createImageSource(arr())
                if (Thread.currentThread.hasPendingCancellation) {
                    imageSource.Release()
                    return
                }
                pixelMap = imageSource.createPixelMap()
                imageSource.Release()
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var size: Size = pixelMap().getImageInfo().size
                imageWidth = Float64(size.width)
                imageHeight = Float64(size.height)
                callback(pixelMap, imageHeight, imageWidth, arr)
            } catch (e: Exception) {
                callback(pixelMap, imageHeight, imageWidth, arr)
            }
        }
        return fut
    }
}

let codeSemaphore: Semaphore = Semaphore(1)

class CodeLoadLimiter <: Resource {
    let closed = AtomicBool(false)

    init() {
        codeSemaphore.acquire()
    }

    public override func isClosed(): Bool {
        return closed.load()
    }

    public override func close(): Unit {
        if (isClosed()) {
            return
        }
        codeSemaphore.release()
        closed.store(true)
    }
}
