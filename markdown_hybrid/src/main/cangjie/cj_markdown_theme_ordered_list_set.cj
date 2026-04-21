/**
 * Created on 2026/4/20
 */
package markdown

func setOrderedListTheme(orderedListTheme: CJMarkdownOrderedListTheme): OrderedListTheme {
    let theme: OrderedListTheme = OrderedListTheme()
    if (let Some(v) <- orderedListTheme.orderedListBackgroundColor) {
        theme.setOrderedListBackgroundColor(v)
    }
    var orderedListMarginTop: Float64 = 8.0
    var orderedListMarginRight: Float64 = 0.0
    var orderedListMarginBottom: Float64 = 8.0
    var orderedListMarginLeft: Float64 = 8.0
    if (let Some(v) <- orderedListTheme.orderedListMarginTop) { orderedListMarginTop = v }
    if (let Some(v) <- orderedListTheme.orderedListMarginRight) { orderedListMarginRight = v }
    if (let Some(v) <- orderedListTheme.orderedListMarginBottom) { orderedListMarginBottom = v }
    if (let Some(v) <- orderedListTheme.orderedListMarginLeft) { orderedListMarginLeft = v }
    theme.setOrderedListMargin(top: orderedListMarginTop, right: orderedListMarginRight, bottom: orderedListMarginBottom, left: orderedListMarginLeft)

    var orderedListPaddingTop: Float64 = 0.0
    var orderedListPaddingRight: Float64 = 0.0
    var orderedListPaddingBottom: Float64 = 0.0
    var orderedListPaddingLeft: Float64 = 0.0
    if (let Some(v) <- orderedListTheme.orderedListPaddingTop) { orderedListPaddingTop = v }
    if (let Some(v) <- orderedListTheme.orderedListPaddingRight) { orderedListPaddingRight = v }
    if (let Some(v) <- orderedListTheme.orderedListPaddingBottom) { orderedListPaddingBottom = v }
    if (let Some(v) <- orderedListTheme.orderedListPaddingLeft) { orderedListPaddingLeft = v }
    theme.setOrderedListPadding(top: orderedListPaddingTop, right: orderedListPaddingRight, bottom: orderedListPaddingBottom, left: orderedListPaddingLeft)

    if (let Some(v) <- orderedListTheme.orderedListChildSpacing) {
        theme.setOrderedListChildSpacing(v)
    }
    if (let Some(v) <- orderedListTheme.orderedListChildChildSpacing) {
        theme.setOrderedListChildChildSpacing(v)
    }
    if (let Some(v) <- orderedListTheme.orderedListMarkerSpacing) {
        theme.setOrderedListMarkerSpacing(v)
    }
    if (let Some(v) <- orderedListTheme.orderedListMarkerTextFontColor) {
        theme.setOrderedListMarkerTextFontColor(v)
    }
    if (let Some(v) <- orderedListTheme.orderedListMarkerTextFontSize) {
        theme.setOrderedListMarkerTextFontSize(v)
    }
    if (let Some(v) <- orderedListTheme.orderedListMarkerTextFontStyle) {
        theme.setOrderedListMarkerTextFontStyle(v)
    }
    if (let Some(v) <- orderedListTheme.orderedListMarkerTextFontWeight) {
        theme.setOrderedListMarkerTextFontWeight(v)
    }
    if (let Some(v) <- orderedListTheme.orderedListMarkerTextFontFamily) {
        theme.setOrderedListMarkerTextFontFamily(v)
    }
    if (let Some(v) <- orderedListTheme.orderedListMarkerTextLineHeight) {
        theme.setOrderedListMarkerTextLineHeight(v)
    }
    return theme
}
