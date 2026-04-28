package markdown

func setHtmlUnderlineTheme(htmlUnderlineTheme: CJMarkdownHtmlUnderlineTheme): HtmlUnderlineTheme {
    let theme: HtmlUnderlineTheme = HtmlUnderlineTheme()
    if (let Some(v) <- htmlUnderlineTheme.htmlUnderlineTextFontColor) {
        theme.setHtmlUnderlineTextFontColor(v)
    }
    if (let Some(v) <- htmlUnderlineTheme.htmlUnderlineTextFontSize) {
        theme.setHtmlUnderlineTextFontSize(v)
    }
    if (let Some(v) <- htmlUnderlineTheme.htmlUnderlineTextFontStyle) {
        theme.setHtmlUnderlineTextFontStyle(v)
    }
    if (let Some(v) <- htmlUnderlineTheme.htmlUnderlineTextFontWeight) {
        theme.setHtmlUnderlineTextFontWeight(v)
    }
    if (let Some(v) <- htmlUnderlineTheme.htmlUnderlineTextFontFamily) {
        theme.setHtmlUnderlineTextFontFamily(v)
    }
    if (let Some(v) <- htmlUnderlineTheme.htmlUnderlineTextLineHeight) {
        theme.setHtmlUnderlineTextLineHeight(v)
    }
    if (let Some(v) <- htmlUnderlineTheme.htmlUnderlineTextLetterSpacing) {
        theme.setHtmlUnderlineTextLetterSpacing(v)
    }
    if (let Some(v) <- htmlUnderlineTheme.htmlUnderlineTextDecorationColor) {
        theme.setHtmlUnderlineTextDecorationColor(v)
    }
    if (let Some(v) <- htmlUnderlineTheme.htmlUnderlineTextDecorationStyle) {
        theme.setHtmlUnderlineTextDecorationStyle(v)
    }
    return theme
}
