/**
 * Created on 2026/4/20
 */
package markdown

func setLinkTheme(linkTheme: CJMarkdownLinkTheme): LinkTheme {
    let theme: LinkTheme = LinkTheme()
    if (let Some(v) <- linkTheme.linkIsIcon) {
        theme.setLinkIsIcon(v)
    }
    if (let Some(v) <- linkTheme.linkListIsIcon) {
        theme.setLinkListIsIcon(v)
    }
    if (let Some(v) <- linkTheme.linkTextFontColor) {
        theme.setLinkTextFontColor(v)
    }
    if (let Some(v) <- linkTheme.linkTextFontSize) {
        theme.setLinkTextFontSize(v)
    }
    if (let Some(v) <- linkTheme.linkTextFontStyle) {
        theme.setLinkTextFontStyle(v)
    }
    if (let Some(v) <- linkTheme.linkTextFontWeight) {
        theme.setLinkTextFontWeight(v)
    }
    if (let Some(v) <- linkTheme.linkTextFontFamily) {
        theme.setLinkTextFontFamily(v)
    }
    if (let Some(v) <- linkTheme.linkTextLineHeight) {
        theme.setLinkTextLineHeight(v)
    }
    if (let Some(v) <- linkTheme.linkTextLetterSpacing) {
        theme.setLinkTextLetterSpacing(v)
    }
    if (let Some(v) <- linkTheme.linkTextDecorationType) {
        theme.setLinkTextDecorationType(v)
    }
    if (let Some(v) <- linkTheme.linkTextDecorationColor) {
        theme.setLinkTextDecorationColor(v)
    }
    if (let Some(v) <- linkTheme.linkTextDecorationStyle) {
        theme.setLinkTextDecorationStyle(v)
    }
    if (let Some(v) <- linkTheme.linkTextBackgroundColor) {
        theme.setLinkTextBackgroundColor(v)
    }
    var linkTextBackgroundRadiusTopLeft: Float64 = 0.0
    var linkTextBackgroundRadiusTopRight: Float64 = 0.0
    var linkTextBackgroundRadiusBottomLeft: Float64 = 0.0
    var linkTextBackgroundRadiusBottomRight: Float64 = 0.0
    if (let Some(v) <- linkTheme.linkTextBackgroundRadiusTopLeft) { linkTextBackgroundRadiusTopLeft = v }
    if (let Some(v) <- linkTheme.linkTextBackgroundRadiusTopRight) { linkTextBackgroundRadiusTopRight = v }
    if (let Some(v) <- linkTheme.linkTextBackgroundRadiusBottomLeft) { linkTextBackgroundRadiusBottomLeft = v }
    if (let Some(v) <- linkTheme.linkTextBackgroundRadiusBottomRight) { linkTextBackgroundRadiusBottomRight = v }
    theme.setLinkTextBackgroundRadius(topLeft: linkTextBackgroundRadiusTopLeft, topRight: linkTextBackgroundRadiusTopRight, bottomLeft: linkTextBackgroundRadiusBottomLeft, bottomRight: linkTextBackgroundRadiusBottomRight)

    if (let Some(v) <- linkTheme.linkCircleIconBackgroundColor) {
        theme.setLinkCircleIconBackgroundColor(v)
    }
    if (let Some(v) <- linkTheme.linkCircleIconButtonBackgroundColor) {
        theme.setLinkCircleIconButtonBackgroundColor(v)
    }
    if (let Some(v) <- linkTheme.linkCircleIconTextSize) {
        theme.setLinkCircleIconTextSize(v)
    }
    if (let Some(v) <- linkTheme.linkCircleIconTextColor) {
        theme.setLinkCircleIconTextColor(v)
    }
    if (let Some(v) <- linkTheme.linkCircleIconRadius) {
        theme.setLinkCircleIconRadius(v)
    }
    if (let Some(v) <- linkTheme.linkCircleIconMargin) {
        theme.setLinkCircleIconMargin(v)
    }
    if (let Some(v) <- linkTheme.linkRectIconBackgroundColor) {
        theme.setLinkRectIconBackgroundColor(v)
    }
    if (let Some(v) <- linkTheme.linkRectIconButtonBackgroundColor) {
        theme.setLinkRectIconButtonBackgroundColor(v)
    }
    if (let Some(v) <- linkTheme.linkRectIconTextSize) {
        theme.setLinkRectIconTextSize(v)
    }
    if (let Some(v) <- linkTheme.linkRectIconTextColor) {
        theme.setLinkRectIconTextColor(v)
    }
    if (let Some(v) <- linkTheme.linkRectIconHeight) {
        theme.setLinkRectIconHeight(v)
    }
    if (let Some(v) <- linkTheme.linkRectIconPadding) {
        theme.setLinkRectIconPadding(v)
    }
    if (let Some(v) <- linkTheme.linkRectIconRadius) {
        theme.setLinkRectIconRadius(v)
    }
    if (let Some(v) <- linkTheme.linkRectIconMargin) {
        theme.setLinkRectIconMargin(v)
    }
    if (let Some(v) <- linkTheme.linkRectToolIconBackgroundColor) {
        theme.setLinkRectToolIconBackgroundColor(v)
    }
    if (let Some(v) <- linkTheme.linkRectToolIconButtonBackgroundColor) {
        theme.setLinkRectToolIconButtonBackgroundColor(v)
    }
    if (let Some(v) <- linkTheme.linkRectToolIconTextSize) {
        theme.setLinkRectToolIconTextSize(v)
    }
    if (let Some(v) <- linkTheme.linkRectToolIconHeight) {
        theme.setLinkRectToolIconHeight(v)
    }
    if (let Some(v) <- linkTheme.linkRectToolIconPadding) {
        theme.setLinkRectToolIconPadding(v)
    }
    if (let Some(v) <- linkTheme.linkRectToolIconBorderWidth) {
        theme.setLinkRectToolIconBorderWidth(v)
    }
    if (let Some(v) <- linkTheme.linkRectToolIconDividingLineWidth) {
        theme.setLinkRectToolIconDividingLineWidth(v)
    }
    if (let Some(v) <- linkTheme.linkRectToolIconMargin) {
        theme.setLinkRectToolIconMargin(v)
    }
    if (let Some(v) <- linkTheme.linkRectToolIconLineLeftPadding) {
        theme.setLinkRectToolIconLineLeftPadding(v)
    }
    if (let Some(v) <- linkTheme.linkRectToolIconLineRightPadding) {
        theme.setLinkRectToolIconLineRightPadding(v)
    }
    return theme
}
