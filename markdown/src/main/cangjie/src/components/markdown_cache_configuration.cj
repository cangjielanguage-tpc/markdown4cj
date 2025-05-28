/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

public class MarkdownCacheConfiguration {
    let headingComponents: ArrayList<MarkdownHeadingComponent> = ArrayList<MarkdownHeadingComponent>()

    let paragraphComponents: ArrayList<MarkdownParagraphComponent> = ArrayList<MarkdownParagraphComponent>()

    let listComponents: ArrayList<MarkdownListComponent> = ArrayList<MarkdownListComponent>()

    let listItemComponents: ArrayList<MarkdownListItemComponent> = ArrayList<MarkdownListItemComponent>()

    let quoteComponents: ArrayList<MarkdownQuoteComponent> = ArrayList<MarkdownQuoteComponent>()

    let tableComponents: ArrayList<MarkdownTableBlockComponent> = ArrayList<MarkdownTableBlockComponent>()

    let tableRowComponents: ArrayList<MarkdownTableBlockRowComponent> = ArrayList<MarkdownTableBlockRowComponent>()

    let tableCellComponents: ArrayList<MarkdownTableBlockCellComponent> = ArrayList<MarkdownTableBlockCellComponent>()

    let indentedCodeComponents: ArrayList<MarkdownIndentedCodeBlockComponent> = ArrayList<MarkdownIndentedCodeBlockComponent>()

    let fencedCodeComponents: ArrayList<MarkdownFencedCodeBlockComponent> = ArrayList<MarkdownFencedCodeBlockComponent>()

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
    }
}
