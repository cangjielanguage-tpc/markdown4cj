package markdown

func setItalicTheme(italicTheme: CJMarkdownItalicTheme): ItalicTheme {
    let theme: ItalicTheme = ItalicTheme()
    if (let Some(v) <- italicTheme.italicTextFontColor) {
        theme.setItalicTextFontColor(v)
    }
    if (let Some(v) <- italicTheme.italicTextFontSize) {
        theme.setItalicTextFontSize(v)
    }
    if (let Some(v) <- italicTheme.italicTextFontWeight) {
        theme.setItalicTextFontWeight(v)
    }
    if (let Some(v) <- italicTheme.italicTextFontFamily) {
        theme.setItalicTextFontFamily(v)
    }
    if (let Some(v) <- italicTheme.italicTextLineHeight) {
        theme.setItalicTextLineHeight(v)
    }
    if (let Some(v) <- italicTheme.italicTextLetterSpacing) {
        theme.setItalicTextLetterSpacing(v)
    }
    return theme
}
