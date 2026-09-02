package markdown.components

class MarkdownParseCodeUtil {
    /**
     * 通过异步的方式将代码转换成带有颜色的列表 - 组合代码
     *
     * @param strText 代码文本列表（快照）
     * @param strInfoText 代码语言列表（与strText同源同索引，快照）
     * @param psh PrismSyntaxHighlight对象
     * @param callback 回调接口
     * @return 线程
     */
    static func stringToResLists(
        strText: ArrayList<String>,
        strInfoText: ArrayList<String>,
        psh: ?PrismSyntaxHighlight,
        callback: (ArrayList<ArrayList<PrismNodesParseResUI>>) -> Unit
    ): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var prismNodesParseResLists: ArrayList<ArrayList<PrismNodesParseResUI>> = ArrayList<ArrayList<PrismNodesParseResUI>>()
            // 直接使用strText逐个解析高亮，语言取自同源的strInfoText（索引严格对应）
            for (i in 0..strText.size) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                let code = strText[i]
                var info: ?String = Option<String>.None
                if (i < strInfoText.size) {
                    let v = strInfoText[i]
                    if (v.size > 0) {
                        info = Some(v)
                    }
                }
                var res: ArrayList<PrismNodesParseResUI> = ArrayList<PrismNodesParseResUI>()
                try (codeLoadLimiter = CodeLoadLimiter()) {
                    if (let Some(v) <- psh) {
                        res = v.highlight(info, code)
                    }
                } catch (e: Exception) {
                    res.add(PrismNodesParseResUI(types: "", text: code, alias: Option<String>.None, color: Option<Color>.None))
                }
                if (res.size == 0) {
                    res.add(PrismNodesParseResUI(types: "", text: code, alias: Option<String>.None, color: Option<Color>.None))
                }
                prismNodesParseResLists.add(res)
            }
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            callback(prismNodesParseResLists)
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
            }
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            callback(prismNodesParseResUIList, lines)
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
            }
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            callback(prismNodesParseResUIList)
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
