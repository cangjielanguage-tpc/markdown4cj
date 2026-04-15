package markdown.components

/**
 * 缓存控件列表数据
 */
public class MarkdownCacheConfiguration {
    let headingComponents: HashMap<Int64, MarkdownHeadingComponent> = HashMap<Int64, MarkdownHeadingComponent>() // 标题

    let paragraphComponents: HashMap<Int64, MarkdownParagraphComponent> = HashMap<Int64, MarkdownParagraphComponent>() // 段落

    let listComponents: HashMap<Int64, MarkdownListComponent> = HashMap<Int64, MarkdownListComponent>() // 列表

    let listItemComponents: HashMap<Int64, MarkdownListItemComponent> = HashMap<Int64, MarkdownListItemComponent>() // 列表项

    let quoteComponents: HashMap<Int64, MarkdownQuoteComponent> = HashMap<Int64, MarkdownQuoteComponent>() // 块引用

    let tableComponents: HashMap<Int64, MarkdownTableBlockComponent> = HashMap<Int64, MarkdownTableBlockComponent>() // 表格

    let tableRowComponents: HashMap<Int64, MarkdownTableBlockRowComponent> = HashMap<Int64, MarkdownTableBlockRowComponent>() // 表格行

    let tableCellComponents: HashMap<Int64, MarkdownTableBlockCellComponent> = HashMap<Int64, MarkdownTableBlockCellComponent>() // 表格列

    let indentedCodeComponents: HashMap<Int64, MarkdownCodeIndentedBlockComponent> = HashMap<Int64, MarkdownCodeIndentedBlockComponent>() // 缩进代码块

    let fencedCodeComponents: HashMap<Int64, MarkdownCodeFencedBlockComponent> = HashMap<Int64, MarkdownCodeFencedBlockComponent>() // 围栏代码块

    let codeComponents: HashMap<Int64, MarkdownCodeComponent> = HashMap<Int64, MarkdownCodeComponent>() // 单独代码块

    let codeTextComponents: HashMap<Int64, MarkdownCodeTextComponent> = HashMap<Int64, MarkdownCodeTextComponent>() // 单独代码块的代码

    let descListComponent: HashMap<Int64, MarkdownDescListComponent> = HashMap<Int64, MarkdownDescListComponent>() // 定义列表

    let descTermComponent: HashMap<Int64, MarkdownDescTermComponent> = HashMap<Int64, MarkdownDescTermComponent>() // 定义列表术语

    let descDefComponent: HashMap<Int64, MarkdownDescDefComponent> = HashMap<Int64, MarkdownDescDefComponent>() // 定义列表定义行

    let footnoteComponent: HashMap<Int64, MarkdownFootnoteComponent> = HashMap<Int64, MarkdownFootnoteComponent>() // 脚注

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
