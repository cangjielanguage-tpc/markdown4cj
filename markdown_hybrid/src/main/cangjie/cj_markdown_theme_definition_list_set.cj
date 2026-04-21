/**
 * Created on 2026/4/20
 */
package markdown

func setDefinitionListTheme(definitionListTheme: CJMarkdownDefinitionListTheme): DefinitionListTheme {
    let theme: DefinitionListTheme = DefinitionListTheme()
    if (let Some(v) <- definitionListTheme.definitionListBackgroundColor) {
        theme.setDefinitionListBackgroundColor(v)
    }
    var definitionListMarginTop: Float64 = 8.0
    var definitionListMarginRight: Float64 = 0.0
    var definitionListMarginBottom: Float64 = 8.0
    var definitionListMarginLeft: Float64 = 0.0
    if (let Some(v) <- definitionListTheme.definitionListMarginTop) { definitionListMarginTop = v }
    if (let Some(v) <- definitionListTheme.definitionListMarginRight) { definitionListMarginRight = v }
    if (let Some(v) <- definitionListTheme.definitionListMarginBottom) { definitionListMarginBottom = v }
    if (let Some(v) <- definitionListTheme.definitionListMarginLeft) { definitionListMarginLeft = v }
    theme.setDefinitionListMargin(top: definitionListMarginTop, right: definitionListMarginRight, bottom: definitionListMarginBottom, left: definitionListMarginLeft)

    var definitionListPaddingTop: Float64 = 0.0
    var definitionListPaddingRight: Float64 = 0.0
    var definitionListPaddingBottom: Float64 = 0.0
    var definitionListPaddingLeft: Float64 = 0.0
    if (let Some(v) <- definitionListTheme.definitionListPaddingTop) { definitionListPaddingTop = v }
    if (let Some(v) <- definitionListTheme.definitionListPaddingRight) { definitionListPaddingRight = v }
    if (let Some(v) <- definitionListTheme.definitionListPaddingBottom) { definitionListPaddingBottom = v }
    if (let Some(v) <- definitionListTheme.definitionListPaddingLeft) { definitionListPaddingLeft = v }
    theme.setDefinitionListPadding(top: definitionListPaddingTop, right: definitionListPaddingRight, bottom: definitionListPaddingBottom, left: definitionListPaddingLeft)

    if (let Some(v) <- definitionListTheme.definitionListTermToDescriptionSpacing) {
        theme.setDefinitionListTermToDescriptionSpacing(v)
    }
    if (let Some(v) <- definitionListTheme.definitionListTermTextFontWeight) {
        theme.setDefinitionListTermTextFontWeight(v)
    }
    if (let Some(v) <- definitionListTheme.definitionListTermTextFontStyle) {
        theme.setDefinitionListTermTextFontStyle(v)
    }
    if (let Some(v) <- definitionListTheme.definitionListDescriptionItemSpacing) {
        theme.setDefinitionListDescriptionItemSpacing(v)
    }
    if (let Some(v) <- definitionListTheme.definitionListDescriptionIndent) {
        theme.setDefinitionListDescriptionIndent(v)
    }
    return theme
}
