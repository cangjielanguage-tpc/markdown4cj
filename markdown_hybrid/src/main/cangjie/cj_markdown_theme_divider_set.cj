/**
 * Created on 2026/4/20
 */
package markdown

func setDividerTheme(dividerTheme: CJMarkdownDividerTheme): DividerTheme {
    let theme: DividerTheme = DividerTheme()
    var dividerMarginTop: Float64 = 8.0
    var dividerMarginRight: Float64 = 0.0
    var dividerMarginBottom: Float64 = 8.0
    var dividerMarginLeft: Float64 = 0.0
    if (let Some(v) <- dividerTheme.dividerMarginTop) { dividerMarginTop = v }
    if (let Some(v) <- dividerTheme.dividerMarginRight) { dividerMarginRight = v }
    if (let Some(v) <- dividerTheme.dividerMarginBottom) { dividerMarginBottom = v }
    if (let Some(v) <- dividerTheme.dividerMarginLeft) { dividerMarginLeft = v }
    theme.setDividerMargin(top: dividerMarginTop, right: dividerMarginRight, bottom: dividerMarginBottom, left: dividerMarginLeft)

    var dividerPaddingTop: Float64 = 0.0
    var dividerPaddingRight: Float64 = 0.0
    var dividerPaddingBottom: Float64 = 0.0
    var dividerPaddingLeft: Float64 = 0.0
    if (let Some(v) <- dividerTheme.dividerPaddingTop) { dividerPaddingTop = v }
    if (let Some(v) <- dividerTheme.dividerPaddingRight) { dividerPaddingRight = v }
    if (let Some(v) <- dividerTheme.dividerPaddingBottom) { dividerPaddingBottom = v }
    if (let Some(v) <- dividerTheme.dividerPaddingLeft) { dividerPaddingLeft = v }
    theme.setDividerPadding(top: dividerPaddingTop, right: dividerPaddingRight, bottom: dividerPaddingBottom, left: dividerPaddingLeft)

    if (let Some(v) <- dividerTheme.dividerColor) {
        theme.setDividerColor(v)
    }
    if (let Some(v) <- dividerTheme.dividerStrokeWidth) {
        theme.setDividerStrokeWidth(v)
    }
    if (let Some(v) <- dividerTheme.dividerStyle) {
        theme.setDividerStyle(v)
    }
    return theme
}
