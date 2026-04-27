/**
 * Created on 2026/4/20
 */
package markdown

func setFootnoteDefTheme(footnoteDefTheme: CJMarkdownFootnoteDefTheme): FootnoteDefTheme {
    let theme: FootnoteDefTheme = FootnoteDefTheme()
    if (let Some(v) <- footnoteDefTheme.footnoteDefBackgroundColor) {
        theme.setFootnoteDefBackgroundColor(v)
    }
    var footnoteDefMarginTop: Float64 = 0.0
    var footnoteDefMarginRight: Float64 = 0.0
    var footnoteDefMarginBottom: Float64 = 0.0
    var footnoteDefMarginLeft: Float64 = 0.0
    if (let Some(v) <- footnoteDefTheme.footnoteDefMarginTop) { footnoteDefMarginTop = v }
    if (let Some(v) <- footnoteDefTheme.footnoteDefMarginRight) { footnoteDefMarginRight = v }
    if (let Some(v) <- footnoteDefTheme.footnoteDefMarginBottom) { footnoteDefMarginBottom = v }
    if (let Some(v) <- footnoteDefTheme.footnoteDefMarginLeft) { footnoteDefMarginLeft = v }
    theme.setFootnoteDefMargin(top: footnoteDefMarginTop, right: footnoteDefMarginRight, bottom: footnoteDefMarginBottom, left: footnoteDefMarginLeft)

    var footnoteDefPaddingTop: Float64 = 0.0
    var footnoteDefPaddingRight: Float64 = 0.0
    var footnoteDefPaddingBottom: Float64 = 0.0
    var footnoteDefPaddingLeft: Float64 = 0.0
    if (let Some(v) <- footnoteDefTheme.footnoteDefPaddingTop) { footnoteDefPaddingTop = v }
    if (let Some(v) <- footnoteDefTheme.footnoteDefPaddingRight) { footnoteDefPaddingRight = v }
    if (let Some(v) <- footnoteDefTheme.footnoteDefPaddingBottom) { footnoteDefPaddingBottom = v }
    if (let Some(v) <- footnoteDefTheme.footnoteDefPaddingLeft) { footnoteDefPaddingLeft = v }
    theme.setFootnoteDefPadding(top: footnoteDefPaddingTop, right: footnoteDefPaddingRight, bottom: footnoteDefPaddingBottom, left: footnoteDefPaddingLeft)

    return theme
}
