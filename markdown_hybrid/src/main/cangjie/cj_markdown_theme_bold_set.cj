/**
 * Created on 2026/4/20
 */
package markdown

func setBoldTheme(boldTheme: CJMarkdownBoldTheme): BoldTheme {
    let theme: BoldTheme = BoldTheme()
    if (let Some(v) <- boldTheme.boldTextFontColor) {
        theme.setBoldTextFontColor(v)
    }
    if (let Some(v) <- boldTheme.boldTextFontSize) {
        theme.setBoldTextFontSize(v)
    }
    if (let Some(v) <- boldTheme.boldTextFontStyle) {
        theme.setBoldTextFontStyle(v)
    }
    if (let Some(v) <- boldTheme.boldTextFontWeight) {
        theme.setBoldTextFontWeight(v)
    }
    if (let Some(v) <- boldTheme.boldTextFontFamily) {
        theme.setBoldTextFontFamily(v)
    }
    if (let Some(v) <- boldTheme.boldTextLineHeight) {
        theme.setBoldTextLineHeight(v)
    }
    if (let Some(v) <- boldTheme.boldTextLetterSpacing) {
        theme.setBoldTextLetterSpacing(v)
    }
    return theme
}
