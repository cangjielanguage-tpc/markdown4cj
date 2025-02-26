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

        this.input += inc
        parse()
    }
    func parse(): Unit {
        let doc1 = md.parse(inc)
        let newLastBlock = doc1.getLastChild().getOrThrow()
        newLastBlock.unlink()
        if (let Some(oldLastBlock) <- doc.getLastChild()) {
            oldLastBlock.replaceWith(newLastBlock)
        } else {
            doc.appendChild(newLastBlock)
        }
        md.render(newLastBlock)
    }
}
