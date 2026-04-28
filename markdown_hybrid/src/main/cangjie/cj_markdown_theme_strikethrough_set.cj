package markdown

func setStrikethroughTheme(strikethroughTheme: CJMarkdownStrikethroughTheme): StrikethroughTheme {
    let theme: StrikethroughTheme = StrikethroughTheme()
    if (let Some(v) <- strikethroughTheme.strikethroughTextFontColor) {
        theme.setStrikethroughTextFontColor(v)
    }
    if (let Some(v) <- strikethroughTheme.strikethroughTextFontSize) {
        theme.setStrikethroughTextFontSize(v)
    }
    if (let Some(v) <- strikethroughTheme.strikethroughTextFontStyle) {
        theme.setStrikethroughTextFontStyle(v)
    }
    if (let Some(v) <- strikethroughTheme.strikethroughTextFontWeight) {
        theme.setStrikethroughTextFontWeight(v)
    }
    if (let Some(v) <- strikethroughTheme.strikethroughTextFontFamily) {
        theme.setStrikethroughTextFontFamily(v)
    }
    if (let Some(v) <- strikethroughTheme.strikethroughTextLineHeight) {
        theme.setStrikethroughTextLineHeight(v)
    }
    if (let Some(v) <- strikethroughTheme.strikethroughTextLetterSpacing) {
        theme.setStrikethroughTextLetterSpacing(v)
    }
    if (let Some(v) <- strikethroughTheme.strikethroughTextDecorationColor) {
        theme.setStrikethroughTextDecorationColor(v)
    }
    if (let Some(v) <- strikethroughTheme.strikethroughTextDecorationStyle) {
        theme.setStrikethroughTextDecorationStyle(v)
    }
    return theme
}
