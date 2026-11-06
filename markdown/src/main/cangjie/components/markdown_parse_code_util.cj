package markdown.components

class MarkdownParseCodeUtil {
    /**
     * 将平铺高亮 token 按 \n 切分为按行分块
     * 对齐 ArkUI prism_hybrid 按行返回 PrismBlock 的结构（每行一个独立Text渲染）：
     * - token 内不含 \n：整 token 归入当前行
     * - token 内含 \n：按 \n 分段，段间换行；空行补空格占位避免Text行高塌陷导致行号错位
     *
     * @param tokens 平铺高亮 token 列表（PrismSyntaxHighlight.highlight 结果）
     * @return 按行分块列表，每个元素对应一行（行内 token 列表）
     */
    static func splitTokensByLines(tokens: ArrayList<PrismNodesParseResUI>): ArrayList<ArrayList<PrismNodesParseResUI>> {
        let rows = ArrayList<ArrayList<PrismNodesParseResUI>>()
        if (tokens.size == 0) {
            return rows
        }
        var current = ArrayList<PrismNodesParseResUI>()
        for (token in tokens) {
            let text = token.getText()
            if (!text.contains("\n")) {
                current.add(token)
                continue
            }
            let segments = text.split("\n")
            for (i in 0..segments.size) {
                if (i > 0) {
                    if (current.size == 0) {
                        // 空行补空格占位，保证该行Text有行高
                        current.add(PrismNodesParseResUI(types: "", text: " ", alias: Option<String>.None, color: Option<Color>.None))
                    }
                    rows.add(current)
                    current = ArrayList<PrismNodesParseResUI>()
                }
                let seg = segments[i]
                if (seg.size > 0) {
                    current.add(PrismNodesParseResUI(types: token.getType(), text: seg, alias: token.getAlias(), color: token.getColor()))
                }
            }
        }
        if (current.size == 0) {
            // 尾部残余空行（如 token 以 \n 结尾）补空格占位
            current.add(PrismNodesParseResUI(types: "", text: " ", alias: Option<String>.None, color: Option<Color>.None))
        }
        rows.add(current)
        return rows
    }

    /**
     * 拼接单行块内所有 token 文本（用作 ForEach key 的行内容签名，对齐 ArkUI block.getText()）
     *
     * @param row 单行 token 列表
     * @return 该行完整文本
     */
    static func rowText(row: ArrayList<PrismNodesParseResUI>): String {
        let sb = StringBuilder()
        for (token in row) {
            sb.append(token.getText())
        }
        return sb.toString()
    }

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
