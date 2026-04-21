/**
 * Created on 2026/4/20
 */
package markdown

func setTableTheme(tableTheme: CJMarkdownTableTheme): TableTheme {
    let theme: TableTheme = TableTheme()
    if (let Some(v) <- tableTheme.tableTitleBackgroundColor) {
        theme.setTableTitleBackgroundColor(v)
    }
    if (let Some(v) <- tableTheme.tableContentOddRowBackgroundColor) {
        theme.setTableContentOddRowBackgroundColor(v)
    }
    if (let Some(v) <- tableTheme.tableContentEvenRowBackgroundColor) {
        theme.setTableContentEvenRowBackgroundColor(v)
    }
    var tableMarginTop: Float64 = 8.0
    var tableMarginRight: Float64 = 0.0
    var tableMarginBottom: Float64 = 8.0
    var tableMarginLeft: Float64 = 0.0
    if (let Some(v) <- tableTheme.tableMarginTop) { tableMarginTop = v }
    if (let Some(v) <- tableTheme.tableMarginRight) { tableMarginRight = v }
    if (let Some(v) <- tableTheme.tableMarginBottom) { tableMarginBottom = v }
    if (let Some(v) <- tableTheme.tableMarginLeft) { tableMarginLeft = v }
    theme.setTableMargin(top: tableMarginTop, right: tableMarginRight, bottom: tableMarginBottom, left: tableMarginLeft)

    var tablePaddingTop: Float64 = 0.0
    var tablePaddingRight: Float64 = 0.0
    var tablePaddingBottom: Float64 = 0.0
    var tablePaddingLeft: Float64 = 0.0
    if (let Some(v) <- tableTheme.tablePaddingTop) { tablePaddingTop = v }
    if (let Some(v) <- tableTheme.tablePaddingRight) { tablePaddingRight = v }
    if (let Some(v) <- tableTheme.tablePaddingBottom) { tablePaddingBottom = v }
    if (let Some(v) <- tableTheme.tablePaddingLeft) { tablePaddingLeft = v }
    theme.setTablePadding(top: tablePaddingTop, right: tablePaddingRight, bottom: tablePaddingBottom, left: tablePaddingLeft)

    var tableCellPaddingTop: Float64 = 4.0
    var tableCellPaddingRight: Float64 = 4.0
    var tableCellPaddingBottom: Float64 = 4.0
    var tableCellPaddingLeft: Float64 = 4.0
    if (let Some(v) <- tableTheme.tableCellPaddingTop) { tableCellPaddingTop = v }
    if (let Some(v) <- tableTheme.tableCellPaddingRight) { tableCellPaddingRight = v }
    if (let Some(v) <- tableTheme.tableCellPaddingBottom) { tableCellPaddingBottom = v }
    if (let Some(v) <- tableTheme.tableCellPaddingLeft) { tableCellPaddingLeft = v }
    theme.setTableCellPadding(top: tableCellPaddingTop, right: tableCellPaddingRight, bottom: tableCellPaddingBottom, left: tableCellPaddingLeft)

    if (let Some(v) <- tableTheme.tableBorderStyle) {
        theme.setTableBorderStyle(v)
    }
    if (let Some(v) <- tableTheme.tableBorderWidth) {
        theme.setTableBorderWidth(v)
    }
    if (let Some(v) <- tableTheme.tableBorderColor) {
        theme.setTableBorderColor(v)
    }
    var tableRadiusTopLeft: Float64 = 5.0
    var tableRadiusTopRight: Float64 = 5.0
    var tableRadiusBottomLeft: Float64 = 5.0
    var tableRadiusBottomRight: Float64 = 5.0
    if (let Some(v) <- tableTheme.tableRadiusTopLeft) { tableRadiusTopLeft = v }
    if (let Some(v) <- tableTheme.tableRadiusTopRight) { tableRadiusTopRight = v }
    if (let Some(v) <- tableTheme.tableRadiusBottomLeft) { tableRadiusBottomLeft = v }
    if (let Some(v) <- tableTheme.tableRadiusBottomRight) { tableRadiusBottomRight = v }
    theme.setTableRadius(topLeft: tableRadiusTopLeft, topRight: tableRadiusTopRight, bottomLeft: tableRadiusBottomLeft, bottomRight: tableRadiusBottomRight)

    if (let Some(v) <- tableTheme.tableScrollBarState) {
        theme.setTableScrollBarState(v)
    }
    if (let Some(v) <- tableTheme.tableScrollBarColor) {
        theme.setTableScrollBarColor(v)
    }
    if (let Some(v) <- tableTheme.tableMinCellWidth) {
        theme.setTableMinCellWidth(v)
    }
    if (let Some(v) <- tableTheme.tableMaxCellWidth) {
        theme.setTableMaxCellWidth(v)
    }
    if (let Some(v) <- tableTheme.tableFirstColumnIsBold) {
        theme.setTableFirstColumnIsBold(v)
    }
    // 表格标题文本样式
    if (let Some(v) <- tableTheme.tableTitleTextFontColor) { theme.setTableTitleTextFontColor(v) }
    if (let Some(v) <- tableTheme.tableTitleTextFontSize) { theme.setTableTitleTextFontSize(v) }
    if (let Some(v) <- tableTheme.tableTitleTextFontStyle) { theme.setTableTitleTextFontStyle(v) }
    if (let Some(v) <- tableTheme.tableTitleTextFontWeight) { theme.setTableTitleTextFontWeight(v) }
    if (let Some(v) <- tableTheme.tableTitleTextFontFamily) { theme.setTableTitleTextFontFamily(v) }
    if (let Some(v) <- tableTheme.tableTitleTextLineHeight) { theme.setTableTitleTextLineHeight(v) }
    if (let Some(v) <- tableTheme.tableTitleTextLetterSpacing) { theme.setTableTitleTextLetterSpacing(v) }

    // 表格内容文本样式
    if (let Some(v) <- tableTheme.tableContentTextFontColor) { theme.setTableContentTextFontColor(v) }
    if (let Some(v) <- tableTheme.tableContentTextFontSize) { theme.setTableContentTextFontSize(v) }
    if (let Some(v) <- tableTheme.tableContentTextFontStyle) { theme.setTableContentTextFontStyle(v) }
    if (let Some(v) <- tableTheme.tableContentTextFontWeight) { theme.setTableContentTextFontWeight(v) }
    if (let Some(v) <- tableTheme.tableContentTextFontFamily) { theme.setTableContentTextFontFamily(v) }
    if (let Some(v) <- tableTheme.tableContentTextLineHeight) { theme.setTableContentTextLineHeight(v) }
    if (let Some(v) <- tableTheme.tableContentTextLetterSpacing) { theme.setTableContentTextLetterSpacing(v) }

    return theme
}
