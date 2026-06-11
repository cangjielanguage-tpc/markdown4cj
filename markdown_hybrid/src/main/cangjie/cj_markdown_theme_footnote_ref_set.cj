package markdown

func setFootnoteRefTheme(footnoteRefTheme: CJMarkdownFootnoteRefTheme): FootnoteRefTheme {
    let theme: FootnoteRefTheme = FootnoteRefTheme()
    if (let Some(v) <- footnoteRefTheme.footnoteRefTextFontColor) {
        theme.setFootnoteRefTextFontColor(v)
    }
    if (let Some(v) <- footnoteRefTheme.footnoteRefTextFontSize) {
        theme.setFootnoteRefTextFontSize(v)
    }
    if (let Some(v) <- footnoteRefTheme.footnoteRefTextFontStyle) {
        theme.setFootnoteRefTextFontStyle(v)
    }
    if (let Some(v) <- footnoteRefTheme.footnoteRefTextFontWeight) {
        theme.setFootnoteRefTextFontWeight(v)
    }
    if (let Some(v) <- footnoteRefTheme.footnoteRefTextFontFamily) {
        theme.setFootnoteRefTextFontFamily(v)
    }
    if (let Some(v) <- footnoteRefTheme.footnoteRefTextLineHeight) {
        theme.setFootnoteRefTextLineHeight(v)
    }
    if (let Some(v) <- footnoteRefTheme.footnoteRefTextLetterSpacing) {
        theme.setFootnoteRefTextLetterSpacing(v)
    }
    if (let Some(v) <- footnoteRefTheme.footnoteRefTextDecorationType) {
        theme.setFootnoteRefTextDecorationType(v)
    }
    if (let Some(v) <- footnoteRefTheme.footnoteRefTextDecorationColor) {
        theme.setFootnoteRefTextDecorationColor(v)
    }
    if (let Some(v) <- footnoteRefTheme.footnoteRefTextDecorationStyle) {
        theme.setFootnoteRefTextDecorationStyle(v)
    }
    if (let Some(v) <- footnoteRefTheme.footnoteRefTextBackgroundColor) {
        theme.setFootnoteRefTextBackgroundColor(v)
    }
    var footnoteRefTextBackgroundRadiusTopLeft: Float64 = 0.0
    var footnoteRefTextBackgroundRadiusTopRight: Float64 = 0.0
    var footnoteRefTextBackgroundRadiusBottomLeft: Float64 = 0.0
    var footnoteRefTextBackgroundRadiusBottomRight: Float64 = 0.0
    if (let Some(v) <- footnoteRefTheme.footnoteRefTextBackgroundRadiusTopLeft) { footnoteRefTextBackgroundRadiusTopLeft = v }
    if (let Some(v) <- footnoteRefTheme.footnoteRefTextBackgroundRadiusTopRight) { footnoteRefTextBackgroundRadiusTopRight = v }
    if (let Some(v) <- footnoteRefTheme.footnoteRefTextBackgroundRadiusBottomLeft) { footnoteRefTextBackgroundRadiusBottomLeft = v }
    if (let Some(v) <- footnoteRefTheme.footnoteRefTextBackgroundRadiusBottomRight) { footnoteRefTextBackgroundRadiusBottomRight = v }
    theme.setFootnoteRefTextBackgroundRadius(topLeft: footnoteRefTextBackgroundRadiusTopLeft, topRight: footnoteRefTextBackgroundRadiusTopRight, bottomLeft: footnoteRefTextBackgroundRadiusBottomLeft, bottomRight: footnoteRefTextBackgroundRadiusBottomRight)

    return theme
}
