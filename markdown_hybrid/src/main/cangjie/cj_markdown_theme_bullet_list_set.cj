package markdown

func setBulletListTheme(bulletListTheme: CJMarkdownBulletListTheme): BulletListTheme {
    let theme: BulletListTheme = BulletListTheme()
    if (let Some(v) <- bulletListTheme.bulletListBackgroundColor) {
        theme.setBulletListBackgroundColor(v)
    }
    var bulletListMarginTop: Float64 = 0.0
    var bulletListMarginRight: Float64 = 0.0
    var bulletListMarginBottom: Float64 = 0.0
    var bulletListMarginLeft: Float64 = 8.0
    if (let Some(v) <- bulletListTheme.bulletListMarginTop) { bulletListMarginTop = v }
    if (let Some(v) <- bulletListTheme.bulletListMarginRight) { bulletListMarginRight = v }
    if (let Some(v) <- bulletListTheme.bulletListMarginBottom) { bulletListMarginBottom = v }
    if (let Some(v) <- bulletListTheme.bulletListMarginLeft) { bulletListMarginLeft = v }
    theme.setBulletListMargin(top: bulletListMarginTop, right: bulletListMarginRight, bottom: bulletListMarginBottom, left: bulletListMarginLeft)

    var bulletListPaddingTop: Float64 = 0.0
    var bulletListPaddingRight: Float64 = 0.0
    var bulletListPaddingBottom: Float64 = 0.0
    var bulletListPaddingLeft: Float64 = 0.0
    if (let Some(v) <- bulletListTheme.bulletListPaddingTop) { bulletListPaddingTop = v }
    if (let Some(v) <- bulletListTheme.bulletListPaddingRight) { bulletListPaddingRight = v }
    if (let Some(v) <- bulletListTheme.bulletListPaddingBottom) { bulletListPaddingBottom = v }
    if (let Some(v) <- bulletListTheme.bulletListPaddingLeft) { bulletListPaddingLeft = v }
    theme.setBulletListPadding(top: bulletListPaddingTop, right: bulletListPaddingRight, bottom: bulletListPaddingBottom, left: bulletListPaddingLeft)

    if (let Some(v) <- bulletListTheme.bulletListChildSpacing) {
        theme.setBulletListChildSpacing(v)
    }
    if (let Some(v) <- bulletListTheme.bulletListChildChildSpacing) {
        theme.setBulletListChildChildSpacing(v)
    }
    if (let Some(v) <- bulletListTheme.bulletListBulletSpacing) {
        theme.setBulletListBulletSpacing(v)
    }
    if (let Some(v) <- bulletListTheme.bulletListBulletIsCircle) {
        theme.setBulletListBulletIsCircle(v)
    }
    if (let Some(v) <- bulletListTheme.bulletListBulletTextFontColor) {
        theme.setBulletListBulletTextFontColor(v)
    }
    if (let Some(v) <- bulletListTheme.bulletListBulletTextFontSize) {
        theme.setBulletListBulletTextFontSize(v)
    }
    if (let Some(v) <- bulletListTheme.bulletListBulletTextFontStyle) {
        theme.setBulletListBulletTextFontStyle(v)
    }
    if (let Some(v) <- bulletListTheme.bulletListBulletTextFontWeight) {
        theme.setBulletListBulletTextFontWeight(v)
    }
    if (let Some(v) <- bulletListTheme.bulletListBulletTextFontFamily) {
        theme.setBulletListBulletTextFontFamily(v)
    }
    if (let Some(v) <- bulletListTheme.bulletListBulletTextLineHeight) {
        theme.setBulletListBulletTextLineHeight(v)
    }
    if (let Some(v) <- bulletListTheme.bulletListCheckboxSpacing) {
        theme.setBulletListCheckboxSpacing(v)
    }
    if (let Some(v) <- bulletListTheme.bulletListCheckboxWidth) {
        theme.setBulletListCheckboxWidth(v)
    }
    if (let Some(v) <- bulletListTheme.bulletListCheckboxHeight) {
        theme.setBulletListCheckboxHeight(v)
    }
    if (let Some(v) <- bulletListTheme.bulletListCheckboxSelectedColor) {
        theme.setBulletListCheckboxSelectedColor(v)
    }
    if (let Some(v) <- bulletListTheme.bulletListCheckboxShape) {
        theme.setBulletListCheckboxShape(v)
    }
    return theme
}
