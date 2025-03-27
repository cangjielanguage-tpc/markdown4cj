/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

public class MarkdownAICacheConfiguration {
    let list1Components: ArrayList<MarkdownAIList1Component> = ArrayList<MarkdownAIList1Component>()

    let list2Components: ArrayList<MarkdownAIList2Component> = ArrayList<MarkdownAIList2Component>()

    let list3Components: ArrayList<MarkdownAIList3Component> = ArrayList<MarkdownAIList3Component>()

    let listItem1Components: ArrayList<MarkdownAIListItem1Component> = ArrayList<MarkdownAIListItem1Component>()

    let listItem2Components: ArrayList<MarkdownAIListItem2Component> = ArrayList<MarkdownAIListItem2Component>()

    let listItem3Components: ArrayList<MarkdownAIListItem3Component> = ArrayList<MarkdownAIListItem3Component>()

    let quote1Components: ArrayList<MarkdownAIQuote1Component> = ArrayList<MarkdownAIQuote1Component>()

    let quote2Components: ArrayList<MarkdownAIQuote2Component> = ArrayList<MarkdownAIQuote2Component>()

    let quote3Components: ArrayList<MarkdownAIQuote3Component> = ArrayList<MarkdownAIQuote3Component>()

    let paragraph1Components: ArrayList<MarkdownAIParagraph1Component> = ArrayList<MarkdownAIParagraph1Component>()

    let paragraph2Components: ArrayList<MarkdownAIParagraph2Component> = ArrayList<MarkdownAIParagraph2Component>()

    let paragraph3Components: ArrayList<MarkdownAIParagraph3Component> = ArrayList<MarkdownAIParagraph3Component>()

    let paragraph4Components: ArrayList<MarkdownAIParagraph4Component> = ArrayList<MarkdownAIParagraph4Component>()

    let heading1Components: ArrayList<MarkdownAIHeading1Component> = ArrayList<MarkdownAIHeading1Component>()

    let heading2Components: ArrayList<MarkdownAIHeading2Component> = ArrayList<MarkdownAIHeading2Component>()

    let heading3Components: ArrayList<MarkdownAIHeading3Component> = ArrayList<MarkdownAIHeading3Component>()

    let heading4Components: ArrayList<MarkdownAIHeading4Component> = ArrayList<MarkdownAIHeading4Component>()

    let table1Components: ArrayList<MarkdownAITableBlock1Component> = ArrayList<MarkdownAITableBlock1Component>()

    let table2Components: ArrayList<MarkdownAITableBlock2Component> = ArrayList<MarkdownAITableBlock2Component>()

    let tableRow1Components: ArrayList<MarkdownAITableBlockRow1Component> = ArrayList<MarkdownAITableBlockRow1Component>()

    let tableRow2Components: ArrayList<MarkdownAITableBlockRow2Component> = ArrayList<MarkdownAITableBlockRow2Component>()

    let tableCell1Components: ArrayList<MarkdownAITableBlockCell1Component> = ArrayList<MarkdownAITableBlockCell1Component>()

    let tableCell2Components: ArrayList<MarkdownAITableBlockCell2Component> = ArrayList<MarkdownAITableBlockCell2Component>()

    let indentedCode1Components: ArrayList<MarkdownAIIndentedCodeBlock1Component> = ArrayList<MarkdownAIIndentedCodeBlock1Component>()

    let indentedCode2Components: ArrayList<MarkdownAIIndentedCodeBlock2Component> = ArrayList<MarkdownAIIndentedCodeBlock2Component>()

    func clear(): Unit {
        list1Components.clear()
        list2Components.clear()
        list3Components.clear()
        listItem1Components.clear()
        listItem2Components.clear()
        listItem3Components.clear()
        quote1Components.clear()
        quote2Components.clear()
        quote3Components.clear()
        paragraph1Components.clear()
        paragraph2Components.clear()
        paragraph3Components.clear()
        paragraph4Components.clear()
        heading1Components.clear()
        heading2Components.clear()
        heading3Components.clear()
        heading4Components.clear()
        table1Components.clear()
        tableRow1Components.clear()
        tableCell1Components.clear()
        indentedCode1Components.clear()
        indentedCode2Components.clear()
    }

    func clearList1(): Unit {
        list2Components.clear()
        list3Components.clear()
        listItem2Components.clear()
        listItem3Components.clear()
        quote2Components.clear()
        quote3Components.clear()
        paragraph2Components.clear()
        paragraph3Components.clear()
        paragraph4Components.clear()
        heading2Components.clear()
        heading3Components.clear()
        heading4Components.clear()
        table2Components.clear()
        tableRow2Components.clear()
        tableCell2Components.clear()
        indentedCode2Components.clear()
    }
}
