/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

/**
 * 缓存控件列表数据
 */
public class MarkdownAICacheConfiguration {
    let headingComponents: ArrayList<MarkdownAIHeadingComponent> = ArrayList<MarkdownAIHeadingComponent>()

    let paragraphComponents: ArrayList<MarkdownAIParagraphComponent> = ArrayList<MarkdownAIParagraphComponent>()

    let listComponents: ArrayList<MarkdownAIListComponent> = ArrayList<MarkdownAIListComponent>()

    let listItemComponents: ArrayList<MarkdownAIListItemComponent> = ArrayList<MarkdownAIListItemComponent>()

    let quoteComponents: ArrayList<MarkdownAIQuoteComponent> = ArrayList<MarkdownAIQuoteComponent>()

    let tableComponents: ArrayList<MarkdownAITableBlockComponent> = ArrayList<MarkdownAITableBlockComponent>()

    let tableRowComponents: ArrayList<MarkdownAITableBlockRowComponent> = ArrayList<MarkdownAITableBlockRowComponent>()

    let tableCellComponents: ArrayList<MarkdownAITableBlockCellComponent> = ArrayList<MarkdownAITableBlockCellComponent>()

    let indentedCodeComponents: ArrayList<MarkdownAIIndentedCodeBlockComponent> = ArrayList<MarkdownAIIndentedCodeBlockComponent>()

    let fencedCodeComponents: ArrayList<MarkdownAIFencedCodeBlockComponent> = ArrayList<MarkdownAIFencedCodeBlockComponent>()

    let aiCodeComponents: ArrayList<MarkdownAICodeComponent> = ArrayList<MarkdownAICodeComponent>()

    let aiCodeTextComponents: ArrayList<MarkdownAICodeTextComponent> = ArrayList<MarkdownAICodeTextComponent>()

    func clearAll(): Unit {
        listComponents.clear()
        listItemComponents.clear()
        quoteComponents.clear()
        paragraphComponents.clear()
        headingComponents.clear()
        tableComponents.clear()
        tableRowComponents.clear()
        tableCellComponents.clear()
        indentedCodeComponents.clear()
        fencedCodeComponents.clear()
        aiCodeComponents.clear()
        aiCodeTextComponents.clear()
    }
}
