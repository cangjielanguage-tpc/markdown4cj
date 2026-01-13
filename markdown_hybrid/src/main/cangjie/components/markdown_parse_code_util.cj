/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.arkui.state_macro_manage.*

/**
 * 通过异步的方式将代码转换成带有颜色的列表 - 组合代码
 *
 * @param codeBlockListNodeView 传入围栏代码列表的NodeView
 * @param markdownConfiguration 传入MarkdownConfiguration
 * @param callback PrismNodesParseResState列表的列表回调接口
 * @param strText 代码列表数据
 * @return 返回PrismNodesParseResState列表的列表，返回代码类型的类型，返回代码内容列表，返回第一条数据内容
 */
func stringToResLists(codeBlockListNodeView: NodeView, markdownConfiguration: MarkdownConfiguration, strText: ArrayList<String>, callback: (ArrayList<ArrayList<PrismNodesParseResUI>>) -> Unit): Future<Unit> {
    let fut: Future<Unit> = spawn {
        var prismNodesParseResLists: ArrayList<ArrayList<PrismNodesParseResUI>> = ArrayList<ArrayList<PrismNodesParseResUI>>()
        try {
            for (nodeView in codeBlockListNodeView.children) {
                if (nodeView.node is FencedCodeBlock) {
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    var psh: PrismSyntaxHighlight = PrismSyntaxHighlight.create(prism, markdownConfiguration.markdownTheme.prismTheme)
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    let res: ArrayList<PrismNodesParseResUI> = psh.highlight((nodeView.node as FencedCodeBlock)().getInfo(), (nodeView.node as FencedCodeBlock)().getLiteral().trimEnd("\n"))
                    prismNodesParseResLists.add(res)
                }
            }
        } catch (e: Exception) {
            for(str in  strText){
                let prismNodesParseResList:ArrayList<PrismNodesParseResUI> = ArrayList<PrismNodesParseResUI>()
                let prismNodesParseRes:PrismNodesParseResUI = PrismNodesParseResUI(types: "", text: str, alias: Option<String>.None, color: Option<Color>.None)
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
    static func codeStrToRectPixelMap(codeTextSize: Float64, codeHeight: Float64, codeLeftAndRightPadding: Float64, strText: String, markdownConfiguration: MarkdownConfiguration, isFakeBoldText: Bool, callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit): Future<Unit> {
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
                    codeTextSize,
                    markdownConfiguration.markdownTheme.codeTextColor.toUInt32(),
                    markdownConfiguration.markdownTheme.codeBackgroundColor.toUInt32(),
                    markdownConfiguration.markdownTheme.codeBackgroundColor.toUInt32(),
                    codeHeight,
                    ColorFormatEnum.COLOR_FORMAT_BGRA_8888,
                    codeLeftAndRightPadding,
                    0.0,
                    isFakeBoldText
                )
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var imageSource: ImageSource = createImageSource(arr())
                if (Thread.currentThread.hasPendingCancellation) {
                    imageSource.release()
                    return
                }
                pixelMap = imageSource.createPixelMap()
                imageSource.release()
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var size = pixelMap().getImageInfo().size
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
