/**
 * Created on 2026/4/20
 */
package markdown

func setSubTheme(subTheme: CJMarkdownSubTheme): SubTheme {
    let theme: SubTheme = SubTheme()
    if (let Some(v) <- subTheme.subTextFontColor) {
        theme.setSubTextFontColor(v)
    }
    if (let Some(v) <- subTheme.subTextFontSize) {
        theme.setSubTextFontSize(v)
    }
    if (let Some(v) <- subTheme.subTextFontStyle) {
        theme.setSubTextFontStyle(v)
    }
    if (let Some(v) <- subTheme.subTextFontWeight) {
        theme.setSubTextFontWeight(v)
    }
    if (let Some(v) <- subTheme.subTextFontFamily) {
        theme.setSubTextFontFamily(v)
    }
    if (let Some(v) <- subTheme.subTextLetterSpacing) {
        theme.setSubTextLetterSpacing(v)
    }
    if (let Some(v) <- subTheme.subTextBaselineOffset) {
        theme.setSubTextBaselineOffset(v)
    }
    return theme
}
