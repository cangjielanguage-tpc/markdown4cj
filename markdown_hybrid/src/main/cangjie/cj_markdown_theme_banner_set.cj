package markdown

func setBannerTheme(bannerTheme: CJMarkdownBannerTheme): BannerTheme {
    let theme: BannerTheme = BannerTheme()
    if (let Some(v) <- bannerImage) {
        theme.setBannerPlaceholder(v) // 设置图片banner默认占位图
    }
    var bannerMarginTop: Float64 = 0.0
    var bannerMarginRight: Float64 = 0.0
    var bannerMarginBottom: Float64 = 0.0
    var bannerMarginLeft: Float64 = 0.0
    if (let Some(v) <- bannerTheme.bannerMarginTop) { bannerMarginTop = v }
    if (let Some(v) <- bannerTheme.bannerMarginRight) { bannerMarginRight = v }
    if (let Some(v) <- bannerTheme.bannerMarginBottom) { bannerMarginBottom = v }
    if (let Some(v) <- bannerTheme.bannerMarginLeft) { bannerMarginLeft = v }
    theme.setBannerMargin(top: bannerMarginTop, right: bannerMarginRight, bottom: bannerMarginBottom, left: bannerMarginLeft)

    var bannerPaddingTop: Float64 = 0.0
    var bannerPaddingRight: Float64 = 0.0
    var bannerPaddingBottom: Float64 = 0.0
    var bannerPaddingLeft: Float64 = 0.0
    if (let Some(v) <- bannerTheme.bannerPaddingTop) { bannerPaddingTop = v }
    if (let Some(v) <- bannerTheme.bannerPaddingRight) { bannerPaddingRight = v }
    if (let Some(v) <- bannerTheme.bannerPaddingBottom) { bannerPaddingBottom = v }
    if (let Some(v) <- bannerTheme.bannerPaddingLeft) { bannerPaddingLeft = v }
    theme.setBannerPadding(top: bannerPaddingTop, right: bannerPaddingRight, bottom: bannerPaddingBottom, left: bannerPaddingLeft)

    return theme
}
