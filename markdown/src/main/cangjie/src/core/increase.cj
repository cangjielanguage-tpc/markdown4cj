/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.core

public class IncreaseParser {
    public IncreaseParser(let md: Markdown) {}

    public var input: String = ""
    public var doc: Node = Document()
    public var docView: NodeView = NodeView(doc)
    public var lazy = true
    public var incBuffer = StringBuilder()
    var inc: String = ""

    /**
     * 增量解析markdown
     * 当前增量文本具有一些特点:
     * 1. 多字符语法分隔符 不会截断
     * 1. 软换行\n总在末尾
     * 1. 段落分隔符\n\n总在末尾
     * 粘连场景:
     * 1. 行内 通过lazy机制 incBuffer积攒出一行 再执行增量解析
     * 1. 跨行 当前列表涉及层级不好解决
     * 常用语法:
     * 1. 加粗
     * 1. 文本
     * 1. 标题
     * 1. 高亮代码块
     * 1. 缩进代码块
     * 1. 有序列表
     * 1. 无序列表
     * 1. 表格
     * @param input 增量文本
     */
    public func append(inc_str: String): Unit {
        inc = inc_str

        if (lazy) {
            incBuffer.append(inc)
            if (inc.endsWith("\n")) {
                inc = incBuffer.toString()
                incBuffer.reset()
            } else {
                return
            }
        }

        parse()

        this.input += inc
    }
    func parse(): Unit {
        if (input.size == 0) {
            return parseNewBlock()
        }
        let block = doc.getLastChild().getOrThrow()
        parseBlock(block)
    }
    func parseBlock(block: Node): Unit {
        match (block) {
            case _: Heading =>
                if (input.endsWith('\n')) {
                    parseNewBlock()
                }
            case block: FencedCodeBlock =>
                // 高亮代码块
                if (input.endsWith("```\n\n")) {
                    parseNewBlock()
                } else {
                    block.setLiteral(block.getLiteral() + inc)
                }
            case block: IndentedCodeBlock =>
                // 缩进代码块
                if (inc.startsWith("    ")) {
                    block.setLiteral(block.getLiteral() + inc[4..])
                } else {
                    parseNewBlock()
                }
            case block: Paragraph =>
                if (input.endsWith("\n\n")) {
                    parseNewBlock()
                } else {
                    appendNewLine(block)
                }
            case block: ListBlock =>
                if (input.endsWith("\n\n")) {
                    parseNewBlock()
                } else {
                    let newBlock = getNewBlock()
                    match (newBlock) {
                        case n: ListItem => block.appendChild(n)
                        case n: Paragraph =>
                            if (let Some(Some(p: Paragraph)) <- block.getFirstChild()?.getFirstChild()) {
                                for (n in newBlock.iterateChildren()) {
                                    p.appendChild(n)
                                }
                            }
                        case _ => ()
                    }
                    md.render(block)
                }
            case _: BlockQuote =>
                // 块引用
                let lastblock = block.getLastChild().getOrThrow()
                if (input.endsWith("\n\n")) {
                    parseNewBlock()
                }
            case _ => ()
        }
    }
    func parseNewBlock(): Unit {
        let block = getNewBlock()
        doc.appendChild(block)
        md.render(block)
    }
    func appendNewLine(block: Node): Unit {
        let newBlock = getNewBlock()
        for (n in newBlock.iterateChildren()) {
            block.appendChild(n)
        }
        md.render(block)
    }
    func getNewBlock(): Node {
        let doc1 = md.parse(inc)
        let block = doc1.getFirstChild().getOrThrow()
        block.unlink()
        block
    }
}
