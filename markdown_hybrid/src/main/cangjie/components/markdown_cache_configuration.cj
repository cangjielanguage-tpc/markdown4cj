/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

/**
 * 缓存控件列表数据
 */
public class MarkdownCacheConfiguration {
    let headingComponents: HashMap<Int64, MarkdownHeadingComponent> = HashMap<Int64, MarkdownHeadingComponent>()

    let paragraphComponents: HashMap<Int64, MarkdownParagraphComponent> = HashMap<Int64, MarkdownParagraphComponent>()

    let listComponents: HashMap<Int64, MarkdownListComponent> = HashMap<Int64, MarkdownListComponent>()

    let listItemComponents: HashMap<Int64, MarkdownListItemComponent> = HashMap<Int64, MarkdownListItemComponent>()

    let quoteComponents: HashMap<Int64, MarkdownQuoteComponent> = HashMap<Int64, MarkdownQuoteComponent>()

    let tableComponents: HashMap<Int64, MarkdownTableBlockComponent> = HashMap<Int64, MarkdownTableBlockComponent>()

    let tableRowComponents: HashMap<Int64, MarkdownTableBlockRowComponent> = HashMap<Int64, MarkdownTableBlockRowComponent>()

    let tableCellComponents: HashMap<Int64, MarkdownTableBlockCellComponent> = HashMap<Int64, MarkdownTableBlockCellComponent>()

    let indentedCodeComponents: HashMap<Int64, MarkdownIndentedCodeBlockComponent> = HashMap<Int64, MarkdownIndentedCodeBlockComponent>()

    let fencedCodeComponents: HashMap<Int64, MarkdownFencedCodeBlockComponent> = HashMap<Int64, MarkdownFencedCodeBlockComponent>()

    let codeComponents: HashMap<Int64, MarkdownCodeComponent> = HashMap<Int64, MarkdownCodeComponent>()

    let codeTextComponents: HashMap<Int64, MarkdownCodeTextComponent> = HashMap<Int64, MarkdownCodeTextComponent>()

    let descListComponent: HashMap<Int64, MarkdownDescListComponent> = HashMap<Int64, MarkdownDescListComponent>()

    let descTermComponent: HashMap<Int64, MarkdownDescTermComponent> = HashMap<Int64, MarkdownDescTermComponent>()

    let descDefComponent: HashMap<Int64, MarkdownDescDefComponent> = HashMap<Int64, MarkdownDescDefComponent>()

    let footnoteComponent: HashMap<Int64, MarkdownFootnoteComponent> = HashMap<Int64, MarkdownFootnoteComponent>()

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
        footnoteComponent.clear()
    }
}
