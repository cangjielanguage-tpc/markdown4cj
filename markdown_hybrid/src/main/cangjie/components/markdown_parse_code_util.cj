/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 通过异步的方式将代码转换成带有颜色的列表 - 组合代码
 *
 * @param nodeView 传入围栏代码列表的Node
 * @param markdownConfiguration 传入MarkdownConfiguration
 * @param callback PrismNodesParseResState列表的列表回调接口
 * @param strText 代码列表数据
 * @return 返回PrismNodesParseResState列表的列表，返回代码类型的类型，返回代码内容列表，返回第一条数据内容
 */
func stringToResLists(nodeView: NodeView, markdownConfiguration: MarkdownConfiguration, strText: ArrayList<String>, callback: (ArrayList<ArrayList<PrismNodesParseResUI>>) -> Unit): Future<Unit> {
    let fut: Future<Unit> = spawn {
        if (Thread.currentThread.hasPendingCancellation) {
            return
        }
        var prismNodesParseResLists: ArrayList<ArrayList<PrismNodesParseResUI>> = ArrayList<ArrayList<PrismNodesParseResUI>>()
        try {
            for(node in nodeView.children){
                if (node.nodeType == "FencedCodeBlock") {
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    var psh: PrismSyntaxHighlight = PrismSyntaxHighlight.create(prism, markdownConfiguration.markdownTheme.prismTheme)
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    let res: ArrayList<PrismNodesParseResUI> = psh.highlight((node as FencedCodeBlock)().getInfo(), (node as FencedCodeBlock)().getLiteral())
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
