/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

/**
 * 缓存控件列表数据
 */
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

    let codeComponents: ArrayList<MarkdownCodeComponent> = ArrayList<MarkdownCodeComponent>()

    let codeTextComponents: ArrayList<MarkdownCodeTextComponent> = ArrayList<MarkdownCodeTextComponent>()

    let descListComponent: ArrayList<MarkdownDescListComponent> = ArrayList<MarkdownDescListComponent>()

    let descTermComponent: ArrayList<MarkdownDescTermComponent> = ArrayList<MarkdownDescTermComponent>()

    let descDefComponent: ArrayList<MarkdownDescDefComponent> = ArrayList<MarkdownDescDefComponent>()

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
        codeComponents.clear()
        codeTextComponents.clear()
        descListComponent.clear()
        descTermComponent.clear()
        descDefComponent.clear()
    }
}
