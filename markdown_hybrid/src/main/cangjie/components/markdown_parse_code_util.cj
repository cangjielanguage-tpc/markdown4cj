package markdown.components

class MarkdownParseCodeUtil {
    /**
     * 通过异步的方式将代码转换成带有颜色的列表 - 组合代码
     *
     * @param nodeView 传入围栏代码列表的Node
     * @param markdownConfiguration 传入MarkdownConfiguration
     * @param strText 代码列表数据
     * @param psh PrismSyntaxHighlight对象
     * @param callback 回调接口
     * @return 线程
     */
    static func stringToResLists(
        nodeView: NodeView,
        markdownConfiguration: MarkdownConfiguration,
        strText: ArrayList<String>,
        psh: ?PrismSyntaxHighlight,
        callback: (ArrayList<ArrayList<PrismNodesParseResUI>>) -> Unit
    ): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var prismNodesParseResLists: ArrayList<ArrayList<PrismNodesParseResUI>> = ArrayList<ArrayList<PrismNodesParseResUI>>()
            try (codeLoadLimiter = CodeLoadLimiter()) {
                for (node in nodeView.children) {
                    if (node.nodeType == "FencedCodeBlock") {
                        if (Thread.currentThread.hasPendingCancellation) {
                            return
                        }
                        if (let Some(v) <- psh) {
                            let res: ArrayList<PrismNodesParseResUI> = v.highlight((node as FencedCodeBlock)().getInfo(), (node as FencedCodeBlock)().getLiteral())
                            prismNodesParseResLists.add(res)
                        }
                    }
                }
            } catch (e: Exception) {
                for (str in strText) {
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    let prismNodesParseResList: ArrayList<PrismNodesParseResUI> = ArrayList<PrismNodesParseResUI>()
                    let prismNodesParseRes: PrismNodesParseResUI = PrismNodesParseResUI(types: "", text: str, alias: Option<String>.None, color: Option<Color>.None)
                    prismNodesParseResList.add(prismNodesParseRes)
                    prismNodesParseResLists.add(prismNodesParseResList)
                }
            } finally {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                callback(prismNodesParseResLists)
            }
        }
        return fut
    }

    /**
     * 通过异步的方式将代码转换成带有颜色的列表 - 围栏代码
     *
     * @param code 代码文本
     * @param info 代码类型
     * @param markdownConfiguration MarkdownConfiguration对象
     * @param formatConfig FormatConfig对象
     * @param psh PrismSyntaxHighlight对象
     * @param callback 回调接口
     * @return 线程
     */
    static func stringToResList(
        code: String,
        info: ?String,
        markdownConfiguration: MarkdownConfiguration,
        formatConfig: FormatConfig,
        psh: ?PrismSyntaxHighlight,
        callback: (ArrayList<PrismNodesParseResUI>, Int64) -> Unit
    ): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var lines = 0
            var prismNodesParseResUIList: ArrayList<PrismNodesParseResUI> = ArrayList<PrismNodesParseResUI>()
            try (codeLoadLimiter = CodeLoadLimiter()){
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                let codeTextStr = if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockIsCodeFormat) {
                    codeFormat(info, code, formatConfig)
                } else {
                    code
                }
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                let arr = codeTextStr.split("\n") // 代码块数据分割
                lines = arr.size
                if (let Some(v) <- psh) {
                    prismNodesParseResUIList = v.highlight(info, codeTextStr)
                }
            } catch (e: Exception) {
                let arr = code.split("\n") // 代码块数据分割
                lines = arr.size
                let prismNodesParseResUI: PrismNodesParseResUI = PrismNodesParseResUI(types: "", text: code, alias: Option<String>.None, color: Option<Color>.None)
                prismNodesParseResUIList.add(prismNodesParseResUI)
            } finally {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                callback(prismNodesParseResUIList, lines)
            }
        }
        return fut
    }

    /**
     * 通过异步的方式将代码转换成带有颜色的列表 - 单独代码块
     *
     * @param codeText 代码文本
     * @param info 代码类型
     * @param psh PrismSyntaxHighlight对象
     * @param callback 回调接口
     * @return 线程
     */
    static func stringToResList(
        codeText: String,
        info: ?String,
        psh: ?PrismSyntaxHighlight,
        callback: (ArrayList<PrismNodesParseResUI>) -> Unit
    ): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var prismNodesParseResUIList: ArrayList<PrismNodesParseResUI> = ArrayList<PrismNodesParseResUI>()
            try (codeLoadLimiter = CodeLoadLimiter()) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                if (let Some(v) <- psh) {
                    prismNodesParseResUIList = v.highlight(info, codeText)
                }
            } catch (e: Exception) {
                let prismNodesParseResUI: PrismNodesParseResUI = PrismNodesParseResUI(types: "", text: codeText, alias: Option<String>.None, color: Option<Color>.None)
                prismNodesParseResUIList.add(prismNodesParseResUI)
            } finally {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                callback(prismNodesParseResUIList)
            }
        }
        return fut
    }
}

let semaphoreCode: Semaphore = Semaphore(50)

class CodeLoadLimiter <: Resource {
    let closed = AtomicBool(false)

    init() {
        semaphoreCode.acquire()
    }

    public override func isClosed(): Bool {
        return closed.load()
    }

    public override func close(): Unit {
        if (isClosed()) {
            return
        }
        semaphoreCode.release()
        closed.store(true)
    }
}
