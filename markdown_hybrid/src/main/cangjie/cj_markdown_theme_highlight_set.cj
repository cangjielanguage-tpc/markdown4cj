package markdown

func setHighlightTheme(highlightTheme: CJMarkdownHighlightTheme): HighlightTheme {
    let theme: HighlightTheme = HighlightTheme()
    if (let Some(v) <- highlightTheme.highlightTextFontColor) {
        theme.setHighlightTextFontColor(v)
    }
    if (let Some(v) <- highlightTheme.highlightTextFontSize) {
        theme.setHighlightTextFontSize(v)
    }
    if (let Some(v) <- highlightTheme.highlightTextFontStyle) {
        theme.setHighlightTextFontStyle(v)
    }
    if (let Some(v) <- highlightTheme.highlightTextFontWeight) {
        theme.setHighlightTextFontWeight(v)
    }
    if (let Some(v) <- highlightTheme.highlightTextFontFamily) {
        theme.setHighlightTextFontFamily(v)
    }
    if (let Some(v) <- highlightTheme.highlightTextLineHeight) {
        theme.setHighlightTextLineHeight(v)
    }
    if (let Some(v) <- highlightTheme.highlightTextLetterSpacing) {
        theme.setHighlightTextLetterSpacing(v)
    }
    if (let Some(v) <- highlightTheme.highlightTextBackgroundColor) {
        theme.setHighlightTextBackgroundColor(v)
    }
    var highlightTextBackgroundRadiusTopLeft: Float64 = 0.0
    var highlightTextBackgroundRadiusTopRight: Float64 = 0.0
    var highlightTextBackgroundRadiusBottomLeft: Float64 = 0.0
    var highlightTextBackgroundRadiusBottomRight: Float64 = 0.0
    if (let Some(v) <- highlightTheme.highlightTextBackgroundRadiusTopLeft) { highlightTextBackgroundRadiusTopLeft = v }
    if (let Some(v) <- highlightTheme.highlightTextBackgroundRadiusTopRight) { highlightTextBackgroundRadiusTopRight = v }
    if (let Some(v) <- highlightTheme.highlightTextBackgroundRadiusBottomLeft) { highlightTextBackgroundRadiusBottomLeft = v }
    if (let Some(v) <- highlightTheme.highlightTextBackgroundRadiusBottomRight) { highlightTextBackgroundRadiusBottomRight = v }
    theme.setHighlightTextBackgroundRadius(topLeft: highlightTextBackgroundRadiusTopLeft, topRight: highlightTextBackgroundRadiusTopRight, bottomLeft: highlightTextBackgroundRadiusBottomLeft, bottomRight: highlightTextBackgroundRadiusBottomRight)

    return theme
}
