package markdown.plugin

import commonmark4cj.commonmark.*
import commonmark4cj.table.*
import markdown.core.*
import std.collection.*

/**
 * 增量解析方案实现
 *
 * 核心流程：
 * 1. 如果是例外情况 → 拼接全量文本并解析
 * 2. 否则 → 解析(firstDirtyBlock.文本 + 增量文本)
 *
 * 然后根据情况更新 Document、SourceSpan 和 NodeHash
 */
public class IncreaseParserV2 {
    var currentDocument: Node
    var fullContent: String = ""
    var firstDirtyBlock: Node // currentDocument子结点中有可能受影响的第一个Block
    var strategy: Int = -1 // 当前解析策略 小于0:必须全文解析 0:无影响 大于0:须解析粘连文本
    var continueText: String = "" // 粘连文本
    var continueDoc: Node // 解析粘连文本得到的document
    var newmd: String = "" // 新全量文本

    public IncreaseParserV2(let markdown: Markdown) {
        this.currentDocument = Document() // 初始化为空 Document
        this.firstDirtyBlock = currentDocument // firstDirtyBlock一定会被重新计算
        this.continueDoc = currentDocument // continueDoc一定会被重新计算
    }

    /**
     * 主解析方法：增量解析新内容
     *
     * 流程：
     * 1. 判断增量文本的归属
     * 2. 根据判断结果选择解析策略
     * 3. 更新 Document、SourceSpan 和 NodeHash
     * 4. 返回更新后的 Document
     */
    public func parseIncremental(newmd: String): Node {
        this.newmd = newmd
        if (newmd.isEmpty()) {
            return currentDocument
        }

        // 判断增量文本的归属
        this.strategy = detectDirtyBlocks()

        // 根据策略执行解析
        parseByStrategy()

        if (this.strategy < 0) {
            return currentDocument
        }

        // 更新 InputIndex
        updateNodeInputIndex()

        // 更新 fullContent
        updateFullContent()

        // 更新 NodeHash
        updateNodeHash()

        // 更新 links
        updateLinks()

        // 更新 Document
        updateDocument()

        return currentDocument
    }

    /**
     * 检测可能受影响的尾部Block数量
     * 不求精准 只求覆盖
     * 底线条件：往前找第一个有 SourceSpan 的 Block
     * 保底退化：全量解析
     */
    func detectDirtyBlocks(): Int {
        this.firstDirtyBlock = currentDocument.getLastChild() ?? return -1
        let continueBlock1 = firstDirtyBlock.getPrevious() ?? return -1
        var depth = 1
        if (continueBlock1 is TableBlock || continueBlock1 is ListBlock || continueBlock1 is FencedCodeBlockListBlock) {
            this.firstDirtyBlock = continueBlock1
            depth = 2
        } else if (firstDirtyBlock is TableBlock || firstDirtyBlock is ListBlock) {
            depth = 1
        }
        while (firstDirtyBlock.getSourceSpans().isEmpty()) {
            this.firstDirtyBlock = firstDirtyBlock.getPrevious() ?? return -1
            depth++
        }
        return depth
    }

    /**
     * 步骤2: 根据策略执行解析
     */
    func parseByStrategy(): Unit {
        if (strategy < 0) {
            parseFullText()
        } else {
            parseContinuation()
        }
    }

    /**
     * 步骤2.2: 解析全量文本
     *
     * 使用场景：
     * - 例外情况
     * - 无法确定归属
     *
     * 用例：
     * - 代码块闭合：拼接全量文本解析，确保代码块正确闭合
     * - Setext 标题下划线：拼接全量文本解析，确保正确转换为标题
     * - 复杂结构：当无法确定归属时，使用全量解析确保正确性
     */
    func parseFullText(): Unit {
        this.fullContent = newmd
        this.currentDocument = markdown.toMarkdown(fullContent)
    }

    /**
     * 解析延续段
     * 延续段: 将可能受影响的段落和增量文本拼接
     */
    func parseContinuation(): Unit {
        // 通过 SourceSpan 获取 firstDirtyBlock 的原文
        let startIndex = getInputIndex(firstDirtyBlock)

        // 步骤3: 解析(firstDirtyBlock.文本 + 增量文本)
        this.continueText = newmd[startIndex..]
        this.continueDoc = markdown.toMarkdown(continueText)
    }

    /**
     * 更新 Document
     *
     * 根据解析策略更新 Document 结构
     */
    func updateDocument(): Unit {
        var n: ?Node = firstDirtyBlock
        while (let Some(v) <- n) {
            n = v.getNext()
            v.unlink()
        }
        for (n in this
                .continueDoc
                .iterateChildren()) {
            currentDocument.appendChild(n)
        }
    }

    /**
     * 更新 links
     *
     * 根据解析策略更新 Document 结构
     */
    func updateLinks(): Unit {
        let new = continueDoc.getProp<HashSet<String>>("links")
        if (let Some(new) <- new) {
            // merge
            if (let Some(old) <- currentDocument.getProp<HashSet<String>>("links")) {
                old.add(all: new)
            } else {
                currentDocument.addProp("links", new)
            }
        }
    }

    /**
     * 更新 continueDoc 相关节点的起始坐标信息
     */
    func updateNodeInputIndex(): Unit {
        // 更新 SourceSpan
        let offset = getInputIndex(firstDirtyBlock)
        // 只更新doc.children
        for (node in continueDoc.iterateChildren()) {
            let spans = node.getSourceSpans()
            if (spans.size > 0) {
                // 计算新的输入索引
                let newInputIndex = spans[0].getInputIndex() + offset
                node.addProp("inputIndex", newInputIndex)
            }
        }
    }

    // 预定义 document NodeHashCalculator
    static let docHasher: NodeHashCalculator = NodeHashCalculator(Document(), None, 0, true, true)
    let stack = ArrayList<NodeHashCalculator>()
    /**
     * 更新Continuation内容的NodeHash
     */
    func updateNodeHash(): Unit {
        var index = 0
        var docContentHasher = DefaultHasher()
        docContentHasher.write(currentDocument.toString())
        for (block in currentDocument.iterateChildren()) {
            if (block == firstDirtyBlock) {
                break
            }
            docContentHasher.write(block
                .getProp<Int>("contentHash")
                .getOrThrow())
            index++
        }
        for (block in continueDoc.iterateChildren()) {
            docContentHasher.write(block
                .getProp<Int>("contentHash")
                .getOrThrow())
            let blockHasher = NodeHashCalculator(block, docHasher, index, true, false)
            stack.add(blockHasher)
            calcNodeIdWithStack(stack, true, false)
            index++
        }
        currentDocument.addProp("contentHash", docContentHasher.finish())
    }

    /**
     * 更新 fullContent
     */
    func updateFullContent(): Unit {
        fullContent = newmd
    }

    // ==================== 辅助方法 ====================
    func getInputIndex(_: Node): Int {
        return if (let Some(i) <- firstDirtyBlock.getProp<Int>("inputIndex")) {
            i // 增量parse Node会计算inputIndex
        } else if (let Some(firstSpan) <- firstDirtyBlock
            .getSourceSpans()
            .get(0)) {
            firstSpan.getInputIndex() // 全量parse Node未计算inputIndex
        } else {
            0 // 空
        }
    }

    /**
     * 获取当前文档
     */
    public func getCurrentDocument(): Node {
        return currentDocument
    }
}
