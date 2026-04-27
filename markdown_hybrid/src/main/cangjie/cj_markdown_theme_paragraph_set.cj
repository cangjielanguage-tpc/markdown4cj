/**
 * Created on 2026/4/20
 */
package markdown

func setParagraphTheme(paragraphTheme: CJMarkdownParagraphTheme): ParagraphTheme {
    let theme: ParagraphTheme = ParagraphTheme()
    if (let Some(v) <- paragraphTheme.paragraphBackgroundColor) {
        theme.setParagraphBackgroundColor(v)
    }
    var paragraphMarginTop: Float64 = 0.0
    var paragraphMarginRight: Float64 = 0.0
    var paragraphMarginBottom: Float64 = 0.0
    var paragraphMarginLeft: Float64 = 0.0
    if (let Some(v) <- paragraphTheme.paragraphMarginTop) {
        paragraphMarginTop = v
    }
    if (let Some(v) <- paragraphTheme.paragraphMarginRight) {
        paragraphMarginRight = v
    }
    if (let Some(v) <- paragraphTheme.paragraphMarginBottom) {
        paragraphMarginBottom = v
    }
    if (let Some(v) <- paragraphTheme.paragraphMarginLeft) {
        paragraphMarginLeft = v
    }
    theme.setParagraphMargin(top: paragraphMarginTop, right: paragraphMarginRight, bottom: paragraphMarginBottom, left: paragraphMarginLeft)

    var paragraphPaddingTop: Float64 = 0.0
    var paragraphPaddingRight: Float64 = 0.0
    var paragraphPaddingBottom: Float64 = 0.0
    var paragraphPaddingLeft: Float64 = 0.0
    if (let Some(v) <- paragraphTheme.paragraphPaddingTop) {
        paragraphPaddingTop = v
    }
    if (let Some(v) <- paragraphTheme.paragraphPaddingRight) {
        paragraphPaddingRight = v
    }
    if (let Some(v) <- paragraphTheme.paragraphPaddingBottom) {
        paragraphPaddingBottom = v
    }
    if (let Some(v) <- paragraphTheme.paragraphPaddingLeft) {
        paragraphPaddingLeft = v
    }
    theme.setParagraphPadding(top: paragraphPaddingTop, right: paragraphPaddingRight, bottom: paragraphPaddingBottom, left: paragraphPaddingLeft)

    if (let Some(v) <- paragraphTheme.paragraphTextFontColor) {
        theme.setParagraphTextFontColor(v)
    }
    if (let Some(v) <- paragraphTheme.paragraphTextFontSize) {
        theme.setParagraphTextFontSize(v)
    }
    if (let Some(v) <- paragraphTheme.paragraphTextFontStyle) {
        theme.setParagraphTextFontStyle(v)
    }
    if (let Some(v) <- paragraphTheme.paragraphTextFontWeight) {
        theme.setParagraphTextFontWeight(v)
    }
    if (let Some(v) <- paragraphTheme.paragraphTextFontFamily) {
        theme.setParagraphTextFontFamily(v)
    }
    if (let Some(v) <- paragraphTheme.paragraphTextLineHeight) {
        theme.setParagraphTextLineHeight(v)
    }
    if (let Some(v) <- paragraphTheme.paragraphTextLetterSpacing) {
        theme.setParagraphTextLetterSpacing(v)
    }
    return theme
}
