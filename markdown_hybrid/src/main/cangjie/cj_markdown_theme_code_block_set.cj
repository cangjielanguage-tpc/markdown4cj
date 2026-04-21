/**
 * Created on 2026/4/20
 */
package markdown

func setCodeBlockTheme(codeBlockTheme: CJMarkdownCodeBlockTheme): CodeBlockTheme {
    let theme: CodeBlockTheme = CodeBlockTheme()
    if (let Some(v) <- codeBlockTheme.codeBlockIsCodeFormat) {
        theme.setCodeBlockIsCodeFormat(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockUseTab) {
        theme.setCodeBlockUseTab(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockIndentWidth) {
        theme.setCodeBlockIndentWidth(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockParserSync) {
        theme.setCodeBlockParserSync(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockBackgroundColor) {
        theme.setCodeBlockBackgroundColor(v)
    }
    var codeBlockMarginTop: Float64 = 8.0
    var codeBlockMarginRight: Float64 = 0.0
    var codeBlockMarginBottom: Float64 = 8.0
    var codeBlockMarginLeft: Float64 = 0.0
    if (let Some(v) <- codeBlockTheme.codeBlockMarginTop) { codeBlockMarginTop = v }
    if (let Some(v) <- codeBlockTheme.codeBlockMarginRight) { codeBlockMarginRight = v }
    if (let Some(v) <- codeBlockTheme.codeBlockMarginBottom) { codeBlockMarginBottom = v }
    if (let Some(v) <- codeBlockTheme.codeBlockMarginLeft) { codeBlockMarginLeft = v }
    theme.setCodeBlockMargin(top: codeBlockMarginTop, right: codeBlockMarginRight, bottom: codeBlockMarginBottom, left: codeBlockMarginLeft)

    var codeBlockPaddingTop: Float64 = 0.0
    var codeBlockPaddingRight: Float64 = 8.0
    var codeBlockPaddingBottom: Float64 = 0.0
    var codeBlockPaddingLeft: Float64 = 8.0
    if (let Some(v) <- codeBlockTheme.codeBlockPaddingTop) { codeBlockPaddingTop = v }
    if (let Some(v) <- codeBlockTheme.codeBlockPaddingRight) { codeBlockPaddingRight = v }
    if (let Some(v) <- codeBlockTheme.codeBlockPaddingBottom) { codeBlockPaddingBottom = v }
    if (let Some(v) <- codeBlockTheme.codeBlockPaddingLeft) { codeBlockPaddingLeft = v }
    theme.setCodeBlockPadding(top: codeBlockPaddingTop, right: codeBlockPaddingRight, bottom: codeBlockPaddingBottom, left: codeBlockPaddingLeft)

    if (let Some(v) <- codeBlockTheme.codeBlockBorderStyle) {
        theme.setCodeBlockBorderStyle(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockBorderWidth) {
        theme.setCodeBlockBorderWidth(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockBorderColor) {
        theme.setCodeBlockBorderColor(v)
    }
    var codeBlockRadiusTopLeft: Float64 = 8.0
    var codeBlockRadiusTopRight: Float64 = 8.0
    var codeBlockRadiusBottomLeft: Float64 = 8.0
    var codeBlockRadiusBottomRight: Float64 = 8.0
    if (let Some(v) <- codeBlockTheme.codeBlockRadiusTopLeft) { codeBlockRadiusTopLeft = v }
    if (let Some(v) <- codeBlockTheme.codeBlockRadiusTopRight) { codeBlockRadiusTopRight = v }
    if (let Some(v) <- codeBlockTheme.codeBlockRadiusBottomLeft) { codeBlockRadiusBottomLeft = v }
    if (let Some(v) <- codeBlockTheme.codeBlockRadiusBottomRight) { codeBlockRadiusBottomRight = v }
    theme.setCodeBlockRadius(topLeft: codeBlockRadiusTopLeft, topRight: codeBlockRadiusTopRight, bottomLeft: codeBlockRadiusBottomLeft, bottomRight: codeBlockRadiusBottomRight)

    if (let Some(v) <- codeBlockTheme.codeBlockTitleLayoutMarginBottom) {
        theme.setCodeBlockTitleLayoutMarginBottom(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockTypeTextMarginLeft) {
        theme.setCodeBlockTypeTextMarginLeft(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockTypeText) {
        theme.setCodeBlockTypeText(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockTypeTextFontColor) {
        theme.setCodeBlockTypeTextFontColor(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockTypeTextFontSize) {
        theme.setCodeBlockTypeTextFontSize(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockTypeTextFontStyle) {
        theme.setCodeBlockTypeTextFontStyle(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockTypeTextFontWeight) {
        theme.setCodeBlockTypeTextFontWeight(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockTypeTextFontFamily) {
        theme.setCodeBlockTypeTextFontFamily(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockTypeTextLineHeight) {
        theme.setCodeBlockTypeTextLineHeight(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockCopyFullScreenSpacing) {
        theme.setCodeBlockCopyFullScreenSpacing(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockCopyButtonIsShow) {
        theme.setCodeBlockCopyButtonIsShow(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockCopyTextIsShow) {
        theme.setCodeBlockCopyTextIsShow(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockCopyIconWidth) {
        theme.setCodeBlockCopyIconWidth(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockCopyIconHeight) {
        theme.setCodeBlockCopyIconHeight(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockCopyIconTextSpacing) {
        theme.setCodeBlockCopyIconTextSpacing(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockCopyText) {
        theme.setCodeBlockCopyText(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockCopyTextFontColor) {
        theme.setCodeBlockCopyTextFontColor(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockCopyTextFontSize) {
        theme.setCodeBlockCopyTextFontSize(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockCopyTextFontStyle) {
        theme.setCodeBlockCopyTextFontStyle(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockCopyTextFontWeight) {
        theme.setCodeBlockCopyTextFontWeight(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockCopyTextFontFamily) {
        theme.setCodeBlockCopyTextFontFamily(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockCopyTextLineHeight) {
        theme.setCodeBlockCopyTextLineHeight(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockFullScreenButtonIsShow) {
        theme.setCodeBlockFullScreenButtonIsShow(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockFullScreenTextIsShow) {
        theme.setCodeBlockFullScreenTextIsShow(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockFullScreenIconWidth) {
        theme.setCodeBlockFullScreenIconWidth(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockFullScreenIconHeight) {
        theme.setCodeBlockFullScreenIconHeight(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockFullScreenIconTextSpacing) {
        theme.setCodeBlockFullScreenIconTextSpacing(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockFullScreenText) {
        theme.setCodeBlockFullScreenText(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockFullScreenTextFontColor) {
        theme.setCodeBlockFullScreenTextFontColor(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockFullScreenTextFontSize) {
        theme.setCodeBlockFullScreenTextFontSize(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockFullScreenTextFontStyle) {
        theme.setCodeBlockFullScreenTextFontStyle(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockFullScreenTextFontWeight) {
        theme.setCodeBlockFullScreenTextFontWeight(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockFullScreenTextFontFamily) {
        theme.setCodeBlockFullScreenTextFontFamily(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockFullScreenTextLineHeight) {
        theme.setCodeBlockFullScreenTextLineHeight(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockLineNumberIsShow) {
        theme.setCodeBlockLineNumberIsShow(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockLineNumberTextPaddingLeft) {
        theme.setCodeBlockLineNumberTextPaddingLeft(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockLineNumberTextFontColor) {
        theme.setCodeBlockLineNumberTextFontColor(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockLineNumberTextFontSize) {
        theme.setCodeBlockLineNumberTextFontSize(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockLineNumberTextFontStyle) {
        theme.setCodeBlockLineNumberTextFontStyle(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockLineNumberTextFontWeight) {
        theme.setCodeBlockLineNumberTextFontWeight(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockLineNumberTextFontFamily) {
        theme.setCodeBlockLineNumberTextFontFamily(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockLineNumberTextLineHeight) {
        theme.setCodeBlockLineNumberTextLineHeight(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockDividerColor) {
        theme.setCodeBlockDividerColor(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockDividerStrokeWidth) {
        theme.setCodeBlockDividerStrokeWidth(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockLineNumberDividerSpacing) {
        theme.setCodeBlockLineNumberDividerSpacing(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockTextFontColor) {
        theme.setCodeBlockTextFontColor(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockTextMarginRight) {
        theme.setCodeBlockTextMarginRight(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockTextMarginLeft) {
        theme.setCodeBlockTextMarginLeft(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockTextFontSize) {
        theme.setCodeBlockTextFontSize(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockTextFontStyle) {
        theme.setCodeBlockTextFontStyle(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockTextFontWeight) {
        theme.setCodeBlockTextFontWeight(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockTextFontFamily) {
        theme.setCodeBlockTextFontFamily(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockTextLineHeight) {
        theme.setCodeBlockTextLineHeight(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockTextLetterSpacing) {
        theme.setCodeBlockTextLetterSpacing(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockListTitleTextSize) {
        theme.setCodeBlockListTitleTextSize(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockListTitleSelectTextSize) {
        theme.setCodeBlockListTitleSelectTextSize(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockListTitleSelectTextColor) {
        theme.setCodeBlockListTitleSelectTextColor(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockListTitleUnSelectTextColor) {
        theme.setCodeBlockListTitleUnSelectTextColor(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockListTitleSelectBackgroupColor) {
        theme.setCodeBlockListTitleSelectBackgroupColor(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockListTitleUnSelectBackgroupColor) {
        theme.setCodeBlockListTitleUnSelectBackgroupColor(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockIsSeparate) {
        theme.setCodeBlockIsSeparate(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockSeparateWidth) {
        theme.setCodeBlockSeparateWidth(v)
    }
    if (let Some(v) <- codeBlockTheme.codeBlockSeparateIsBottom) {
        theme.setCodeBlockSeparateIsBottom(v)
    }
    return theme
}
