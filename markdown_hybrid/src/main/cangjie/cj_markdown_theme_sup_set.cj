package markdown

func setSupTheme(supTheme: CJMarkdownSupTheme): SupTheme {
    let theme: SupTheme = SupTheme()
    if (let Some(v) <- supTheme.supTextFontColor) {
        theme.setSupTextFontColor(v)
    }
    if (let Some(v) <- supTheme.supTextFontSize) {
        theme.setSupTextFontSize(v)
    }
    if (let Some(v) <- supTheme.supTextFontStyle) {
        theme.setSupTextFontStyle(v)
    }
    if (let Some(v) <- supTheme.supTextFontWeight) {
        theme.setSupTextFontWeight(v)
    }
    if (let Some(v) <- supTheme.supTextFontFamily) {
        theme.setSupTextFontFamily(v)
    }
    if (let Some(v) <- supTheme.supTextLetterSpacing) {
        theme.setSupTextLetterSpacing(v)
    }
    if (let Some(v) <- supTheme.supTextBaselineOffset) {
        theme.setSupTextBaselineOffset(v)
    }
    return theme
}
