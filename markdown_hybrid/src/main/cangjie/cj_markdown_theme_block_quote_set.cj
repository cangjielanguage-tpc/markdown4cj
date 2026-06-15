package markdown

func setBlockQuoteTheme(blockQuoteTheme: CJMarkdownBlockQuoteTheme): BlockQuoteTheme {
    let theme: BlockQuoteTheme = BlockQuoteTheme()
    if (let Some(v) <- blockQuoteTheme.blockQuoteBackgroundColor) {
        theme.setBlockQuoteBackgroundColor(v)
    }
    var blockQuoteMarginTop: Float64 = 0.0
    var blockQuoteMarginRight: Float64 = 0.0
    var blockQuoteMarginBottom: Float64 = 0.0
    var blockQuoteMarginLeft: Float64 = 8.0
    if (let Some(v) <- blockQuoteTheme.blockQuoteMarginTop) { blockQuoteMarginTop = v }
    if (let Some(v) <- blockQuoteTheme.blockQuoteMarginRight) { blockQuoteMarginRight = v }
    if (let Some(v) <- blockQuoteTheme.blockQuoteMarginBottom) { blockQuoteMarginBottom = v }
    if (let Some(v) <- blockQuoteTheme.blockQuoteMarginLeft) { blockQuoteMarginLeft = v }
    theme.setBlockQuoteMargin(top: blockQuoteMarginTop, right: blockQuoteMarginRight, bottom: blockQuoteMarginBottom, left: blockQuoteMarginLeft)

    var blockQuotePaddingTop: Float64 = 0.0
    var blockQuotePaddingRight: Float64 = 0.0
    var blockQuotePaddingBottom: Float64 = 0.0
    var blockQuotePaddingLeft: Float64 = 0.0
    if (let Some(v) <- blockQuoteTheme.blockQuotePaddingTop) { blockQuotePaddingTop = v }
    if (let Some(v) <- blockQuoteTheme.blockQuotePaddingRight) { blockQuotePaddingRight = v }
    if (let Some(v) <- blockQuoteTheme.blockQuotePaddingBottom) { blockQuotePaddingBottom = v }
    if (let Some(v) <- blockQuoteTheme.blockQuotePaddingLeft) { blockQuotePaddingLeft = v }
    theme.setBlockQuotePadding(top: blockQuotePaddingTop, right: blockQuotePaddingRight, bottom: blockQuotePaddingBottom, left: blockQuotePaddingLeft)

    var blockQuoteRadiusTopLeft: Float64 = 0.0
    var blockQuoteRadiusTopRight: Float64 = 0.0
    var blockQuoteRadiusBottomLeft: Float64 = 0.0
    var blockQuoteRadiusBottomRight: Float64 = 0.0
    if (let Some(v) <- blockQuoteTheme.blockQuoteRadiusTopLeft) { blockQuoteRadiusTopLeft = v }
    if (let Some(v) <- blockQuoteTheme.blockQuoteRadiusTopRight) { blockQuoteRadiusTopRight = v }
    if (let Some(v) <- blockQuoteTheme.blockQuoteRadiusBottomLeft) { blockQuoteRadiusBottomLeft = v }
    if (let Some(v) <- blockQuoteTheme.blockQuoteRadiusBottomRight) { blockQuoteRadiusBottomRight = v }
    theme.setBlockQuoteRadius(topLeft: blockQuoteRadiusTopLeft, topRight: blockQuoteRadiusTopRight, bottomLeft: blockQuoteRadiusBottomLeft, bottomRight: blockQuoteRadiusBottomRight)

    if (let Some(v) <- blockQuoteTheme.blockQuoteLeftBorderWidth) {
        theme.setBlockQuoteLeftBorderWidth(v)
    }
    if (let Some(v) <- blockQuoteTheme.blockQuoteLeftBorderColor) {
        theme.setBlockQuoteLeftBorderColor(v)
    }
    if (let Some(v) <- blockQuoteTheme.blockQuoteChildSpacing) {
        theme.setBlockQuoteChildSpacing(Int64(v))
    }
    return theme
}
