/**
 * Created on 2026/4/20
 */
package markdown

func setInlineCodeTheme(inlineCodeTheme: CJMarkdownInlineCodeTheme): InlineCodeTheme {
    let theme: InlineCodeTheme = InlineCodeTheme()
    if (let Some(v) <- inlineCodeTheme.inlineCodeTextFontColor) {
        theme.setInlineCodeTextFontColor(v)
    }
    if (let Some(v) <- inlineCodeTheme.inlineCodeTextFontSize) {
        theme.setInlineCodeTextFontSize(v)
    }
    if (let Some(v) <- inlineCodeTheme.inlineCodeTextFontStyle) {
        theme.setInlineCodeTextFontStyle(v)
    }
    if (let Some(v) <- inlineCodeTheme.inlineCodeTextFontWeight) {
        theme.setInlineCodeTextFontWeight(v)
    }
    if (let Some(v) <- inlineCodeTheme.inlineCodeTextFontFamily) {
        theme.setInlineCodeTextFontFamily(v)
    }
    if (let Some(v) <- inlineCodeTheme.inlineCodeTextLineHeight) {
        theme.setInlineCodeTextLineHeight(v)
    }
    if (let Some(v) <- inlineCodeTheme.inlineCodeTextLetterSpacing) {
        theme.setInlineCodeTextLetterSpacing(v)
    }
    if (let Some(v) <- inlineCodeTheme.inlineCodeTextBackgroundColor) {
        theme.setInlineCodeTextBackgroundColor(v)
    }
    var inlineCodeTextBackgroundRadiusTopLeft: Float64 = 0.0
    var inlineCodeTextBackgroundRadiusTopRight: Float64 = 0.0
    var inlineCodeTextBackgroundRadiusBottomLeft: Float64 = 0.0
    var inlineCodeTextBackgroundRadiusBottomRight: Float64 = 0.0
    if (let Some(v) <- inlineCodeTheme.inlineCodeTextBackgroundRadiusTopLeft) { inlineCodeTextBackgroundRadiusTopLeft = v }
    if (let Some(v) <- inlineCodeTheme.inlineCodeTextBackgroundRadiusTopRight) { inlineCodeTextBackgroundRadiusTopRight = v }
    if (let Some(v) <- inlineCodeTheme.inlineCodeTextBackgroundRadiusBottomLeft) { inlineCodeTextBackgroundRadiusBottomLeft = v }
    if (let Some(v) <- inlineCodeTheme.inlineCodeTextBackgroundRadiusBottomRight) { inlineCodeTextBackgroundRadiusBottomRight = v }
    theme.setInlineCodeTextBackgroundRadius(topLeft: inlineCodeTextBackgroundRadiusTopLeft, topRight: inlineCodeTextBackgroundRadiusTopRight, bottomLeft: inlineCodeTextBackgroundRadiusBottomLeft, bottomRight: inlineCodeTextBackgroundRadiusBottomRight)

    return theme
}
