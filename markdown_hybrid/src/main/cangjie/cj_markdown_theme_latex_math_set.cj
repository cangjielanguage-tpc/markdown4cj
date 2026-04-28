package markdown

func setLatexMathTheme(latexMathTheme: CJMarkdownLatexMathTheme): LatexMathTheme {
    let theme: LatexMathTheme = LatexMathTheme()
    var latexMathMarginTop: Float64 = 0.0
    var latexMathMarginRight: Float64 = 0.0
    var latexMathMarginBottom: Float64 = 0.0
    var latexMathMarginLeft: Float64 = 0.0
    if (let Some(v) <- latexMathTheme.latexMathMarginTop) { latexMathMarginTop = v }
    if (let Some(v) <- latexMathTheme.latexMathMarginRight) { latexMathMarginRight = v }
    if (let Some(v) <- latexMathTheme.latexMathMarginBottom) { latexMathMarginBottom = v }
    if (let Some(v) <- latexMathTheme.latexMathMarginLeft) { latexMathMarginLeft = v }
    theme.setLatexMathMargin(top: latexMathMarginTop, right: latexMathMarginRight, bottom: latexMathMarginBottom, left: latexMathMarginLeft)

    var latexMathPaddingTop: Float64 = 0.0
    var latexMathPaddingRight: Float64 = 0.0
    var latexMathPaddingBottom: Float64 = 0.0
    var latexMathPaddingLeft: Float64 = 0.0
    if (let Some(v) <- latexMathTheme.latexMathPaddingTop) { latexMathPaddingTop = v }
    if (let Some(v) <- latexMathTheme.latexMathPaddingRight) { latexMathPaddingRight = v }
    if (let Some(v) <- latexMathTheme.latexMathPaddingBottom) { latexMathPaddingBottom = v }
    if (let Some(v) <- latexMathTheme.latexMathPaddingLeft) { latexMathPaddingLeft = v }
    theme.setLatexMathPadding(top: latexMathPaddingTop, right: latexMathPaddingRight, bottom: latexMathPaddingBottom, left: latexMathPaddingLeft)

    if (let Some(v) <- latexMathTheme.latexMathDefaultText) {
        theme.setLatexMathDefaultText(v)
    }
    if (let Some(v) <- latexMathTheme.latexMathDefaultTextFontColor) {
        theme.setLatexMathDefaultTextFontColor(v)
    }
    if (let Some(v) <- latexMathTheme.latexMathDefaultTextFontSize) {
        theme.setLatexMathDefaultTextFontSize(v)
    }
    if (let Some(v) <- latexMathTheme.latexMathDefaultTextFontStyle) {
        theme.setLatexMathDefaultTextFontStyle(v)
    }
    if (let Some(v) <- latexMathTheme.latexMathDefaultTextFontWeight) {
        theme.setLatexMathDefaultTextFontWeight(v)
    }
    if (let Some(v) <- latexMathTheme.latexMathDefaultTextFontFamily) {
        theme.setLatexMathDefaultTextFontFamily(v)
    }
    if (let Some(v) <- latexMathTheme.latexMathTextSize) {
        theme.setLatexMathTextSize(v)
    }
    if (let Some(v) <- latexMathTheme.latexMathBackgroundColor) {
        theme.setLatexMathBackgroundColor(v)
    }
    if (let Some(v) <- latexMathTheme.latexMathTextColor) {
        theme.setLatexMathTextColor(v)
    }
    if (let Some(v) <- latexMathTheme.latexMathColorFormat) {
        theme.setLatexMathColorFormat(v)
    }
    if (let Some(v) <- latexMathTheme.latexMathBlockCenter) {
        theme.setLatexMathBlockCenter(v)
    }
    if (let Some(v) <- latexMathTheme.latexMathResPath) {
        theme.setLatexMathResPath(v)
    }
    return theme
}
