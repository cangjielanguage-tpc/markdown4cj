/**
 * Created on 2026/4/20
 */
package markdown

func setHeadingTheme(headingTheme: CJMarkdownHeadingTheme): HeadingTheme {
    let theme: HeadingTheme = HeadingTheme()
    // H1
    if (let Some(v) <- headingTheme.heading1BackgroundColor) { theme.setBackgroundColorForDesignateHeading(1, v) }
    var h1MarginTop: Float64 = 0.0
    var h1MarginRight: Float64 = 0.0
    var h1MarginBottom: Float64 = 0.0
    var h1MarginLeft: Float64 = 0.0
    if (let Some(v) <- headingTheme.heading1MarginTop) { h1MarginTop = v }
    if (let Some(v) <- headingTheme.heading1MarginRight) { h1MarginRight = v }
    if (let Some(v) <- headingTheme.heading1MarginBottom) { h1MarginBottom = v }
    if (let Some(v) <- headingTheme.heading1MarginLeft) { h1MarginLeft = v }
    theme.setMarginForDesignateHeading(1, top: h1MarginTop, right: h1MarginRight, bottom: h1MarginBottom, left: h1MarginLeft)

    var h1PaddingTop: Float64 = 0.0
    var h1PaddingRight: Float64 = 0.0
    var h1PaddingBottom: Float64 = 0.0
    var h1PaddingLeft: Float64 = 0.0
    if (let Some(v) <- headingTheme.heading1PaddingTop) { h1PaddingTop = v }
    if (let Some(v) <- headingTheme.heading1PaddingRight) { h1PaddingRight = v }
    if (let Some(v) <- headingTheme.heading1PaddingBottom) { h1PaddingBottom = v }
    if (let Some(v) <- headingTheme.heading1PaddingLeft) { h1PaddingLeft = v }
    theme.setPaddingForDesignateHeading(1, top: h1PaddingTop, right: h1PaddingRight, bottom: h1PaddingBottom, left: h1PaddingLeft)

    if (let Some(v) <- headingTheme.heading1TextFontColor) { theme.setTextFontColorForDesignateHeading(1, v) }
    if (let Some(v) <- headingTheme.heading1TextFontSize) { theme.setTextFontSizeForDesignateHeading(1, v) }
    if (let Some(v) <- headingTheme.heading1TextFontStyle) { theme.setTextFontStyleForDesignateHeading(1, v) }
    if (let Some(v) <- headingTheme.heading1TextFontWeight) { theme.setTextFontWeightForDesignateHeading(1, v) }
    if (let Some(v) <- headingTheme.heading1TextFontFamily) { theme.setTextFontFamilyForDesignateHeading(1, v) }
    if (let Some(v) <- headingTheme.heading1TextLineHeight) { theme.setTextLineHeightForDesignateHeading(1, v) }
    if (let Some(v) <- headingTheme.heading1TextLetterSpacing) { theme.setTextLetterSpacingForDesignateHeading(1, v) }
    if (let Some(v) <- headingTheme.heading1UnderlineHeight) { theme.setUnderlineHeightForDesignateHeading(1, v) }
    if (let Some(v) <- headingTheme.heading1UnderlineColor) { theme.setUnderlineColorForDesignateHeading(1, v) }
    if (let Some(v) <- headingTheme.heading1UnderlineSpacing) { theme.setUnderlineSpacingForDesignateHeading(1, v) }

    // H2
    if (let Some(v) <- headingTheme.heading2BackgroundColor) { theme.setBackgroundColorForDesignateHeading(2, v) }
    var h2MarginTop: Float64 = 0.0
    var h2MarginRight: Float64 = 0.0
    var h2MarginBottom: Float64 = 0.0
    var h2MarginLeft: Float64 = 0.0
    if (let Some(v) <- headingTheme.heading2MarginTop) { h2MarginTop = v }
    if (let Some(v) <- headingTheme.heading2MarginRight) { h2MarginRight = v }
    if (let Some(v) <- headingTheme.heading2MarginBottom) { h2MarginBottom = v }
    if (let Some(v) <- headingTheme.heading2MarginLeft) { h2MarginLeft = v }
    theme.setMarginForDesignateHeading(2, top: h2MarginTop, right: h2MarginRight, bottom: h2MarginBottom, left: h2MarginLeft)

    var h2PaddingTop: Float64 = 0.0
    var h2PaddingRight: Float64 = 0.0
    var h2PaddingBottom: Float64 = 0.0
    var h2PaddingLeft: Float64 = 0.0
    if (let Some(v) <- headingTheme.heading2PaddingTop) { h2PaddingTop = v }
    if (let Some(v) <- headingTheme.heading2PaddingRight) { h2PaddingRight = v }
    if (let Some(v) <- headingTheme.heading2PaddingBottom) { h2PaddingBottom = v }
    if (let Some(v) <- headingTheme.heading2PaddingLeft) { h2PaddingLeft = v }
    theme.setPaddingForDesignateHeading(2, top: h2PaddingTop, right: h2PaddingRight, bottom: h2PaddingBottom, left: h2PaddingLeft)

    if (let Some(v) <- headingTheme.heading2TextFontColor) { theme.setTextFontColorForDesignateHeading(2, v) }
    if (let Some(v) <- headingTheme.heading2TextFontSize) { theme.setTextFontSizeForDesignateHeading(2, v) }
    if (let Some(v) <- headingTheme.heading2TextFontStyle) { theme.setTextFontStyleForDesignateHeading(2, v) }
    if (let Some(v) <- headingTheme.heading2TextFontWeight) { theme.setTextFontWeightForDesignateHeading(2, v) }
    if (let Some(v) <- headingTheme.heading2TextFontFamily) { theme.setTextFontFamilyForDesignateHeading(2, v) }
    if (let Some(v) <- headingTheme.heading2TextLineHeight) { theme.setTextLineHeightForDesignateHeading(2, v) }
    if (let Some(v) <- headingTheme.heading2TextLetterSpacing) { theme.setTextLetterSpacingForDesignateHeading(2, v) }
    if (let Some(v) <- headingTheme.heading2UnderlineHeight) { theme.setUnderlineHeightForDesignateHeading(2, v) }
    if (let Some(v) <- headingTheme.heading2UnderlineColor) { theme.setUnderlineColorForDesignateHeading(2, v) }
    if (let Some(v) <- headingTheme.heading2UnderlineSpacing) { theme.setUnderlineSpacingForDesignateHeading(2, v) }

    // H3
    if (let Some(v) <- headingTheme.heading3BackgroundColor) { theme.setBackgroundColorForDesignateHeading(3, v) }
    var h3MarginTop: Float64 = 0.0
    var h3MarginRight: Float64 = 0.0
    var h3MarginBottom: Float64 = 0.0
    var h3MarginLeft: Float64 = 0.0
    if (let Some(v) <- headingTheme.heading3MarginTop) { h3MarginTop = v }
    if (let Some(v) <- headingTheme.heading3MarginRight) { h3MarginRight = v }
    if (let Some(v) <- headingTheme.heading3MarginBottom) { h3MarginBottom = v }
    if (let Some(v) <- headingTheme.heading3MarginLeft) { h3MarginLeft = v }
    theme.setMarginForDesignateHeading(3, top: h3MarginTop, right: h3MarginRight, bottom: h3MarginBottom, left: h3MarginLeft)

    var h3PaddingTop: Float64 = 0.0
    var h3PaddingRight: Float64 = 0.0
    var h3PaddingBottom: Float64 = 0.0
    var h3PaddingLeft: Float64 = 0.0
    if (let Some(v) <- headingTheme.heading3PaddingTop) { h3PaddingTop = v }
    if (let Some(v) <- headingTheme.heading3PaddingRight) { h3PaddingRight = v }
    if (let Some(v) <- headingTheme.heading3PaddingBottom) { h3PaddingBottom = v }
    if (let Some(v) <- headingTheme.heading3PaddingLeft) { h3PaddingLeft = v }
    theme.setPaddingForDesignateHeading(3, top: h3PaddingTop, right: h3PaddingRight, bottom: h3PaddingBottom, left: h3PaddingLeft)

    if (let Some(v) <- headingTheme.heading3TextFontColor) { theme.setTextFontColorForDesignateHeading(3, v) }
    if (let Some(v) <- headingTheme.heading3TextFontSize) { theme.setTextFontSizeForDesignateHeading(3, v) }
    if (let Some(v) <- headingTheme.heading3TextFontStyle) { theme.setTextFontStyleForDesignateHeading(3, v) }
    if (let Some(v) <- headingTheme.heading3TextFontWeight) { theme.setTextFontWeightForDesignateHeading(3, v) }
    if (let Some(v) <- headingTheme.heading3TextFontFamily) { theme.setTextFontFamilyForDesignateHeading(3, v) }
    if (let Some(v) <- headingTheme.heading3TextLineHeight) { theme.setTextLineHeightForDesignateHeading(3, v) }
    if (let Some(v) <- headingTheme.heading3TextLetterSpacing) { theme.setTextLetterSpacingForDesignateHeading(3, v) }

    // H4
    if (let Some(v) <- headingTheme.heading4BackgroundColor) { theme.setBackgroundColorForDesignateHeading(4, v) }
    var h4MarginTop: Float64 = 0.0
    var h4MarginRight: Float64 = 0.0
    var h4MarginBottom: Float64 = 0.0
    var h4MarginLeft: Float64 = 0.0
    if (let Some(v) <- headingTheme.heading4MarginTop) { h4MarginTop = v }
    if (let Some(v) <- headingTheme.heading4MarginRight) { h4MarginRight = v }
    if (let Some(v) <- headingTheme.heading4MarginBottom) { h4MarginBottom = v }
    if (let Some(v) <- headingTheme.heading4MarginLeft) { h4MarginLeft = v }
    theme.setMarginForDesignateHeading(4, top: h4MarginTop, right: h4MarginRight, bottom: h4MarginBottom, left: h4MarginLeft)

    var h4PaddingTop: Float64 = 0.0
    var h4PaddingRight: Float64 = 0.0
    var h4PaddingBottom: Float64 = 0.0
    var h4PaddingLeft: Float64 = 0.0
    if (let Some(v) <- headingTheme.heading4PaddingTop) { h4PaddingTop = v }
    if (let Some(v) <- headingTheme.heading4PaddingRight) { h4PaddingRight = v }
    if (let Some(v) <- headingTheme.heading4PaddingBottom) { h4PaddingBottom = v }
    if (let Some(v) <- headingTheme.heading4PaddingLeft) { h4PaddingLeft = v }
    theme.setPaddingForDesignateHeading(4, top: h4PaddingTop, right: h4PaddingRight, bottom: h4PaddingBottom, left: h4PaddingLeft)

    if (let Some(v) <- headingTheme.heading4TextFontColor) { theme.setTextFontColorForDesignateHeading(4, v) }
    if (let Some(v) <- headingTheme.heading4TextFontSize) { theme.setTextFontSizeForDesignateHeading(4, v) }
    if (let Some(v) <- headingTheme.heading4TextFontStyle) { theme.setTextFontStyleForDesignateHeading(4, v) }
    if (let Some(v) <- headingTheme.heading4TextFontWeight) { theme.setTextFontWeightForDesignateHeading(4, v) }
    if (let Some(v) <- headingTheme.heading4TextFontFamily) { theme.setTextFontFamilyForDesignateHeading(4, v) }
    if (let Some(v) <- headingTheme.heading4TextLineHeight) { theme.setTextLineHeightForDesignateHeading(4, v) }
    if (let Some(v) <- headingTheme.heading4TextLetterSpacing) { theme.setTextLetterSpacingForDesignateHeading(4, v) }

    // H5
    if (let Some(v) <- headingTheme.heading5BackgroundColor) { theme.setBackgroundColorForDesignateHeading(5, v) }
    var h5MarginTop: Float64 = 0.0
    var h5MarginRight: Float64 = 0.0
    var h5MarginBottom: Float64 = 0.0
    var h5MarginLeft: Float64 = 0.0
    if (let Some(v) <- headingTheme.heading5MarginTop) { h5MarginTop = v }
    if (let Some(v) <- headingTheme.heading5MarginRight) { h5MarginRight = v }
    if (let Some(v) <- headingTheme.heading5MarginBottom) { h5MarginBottom = v }
    if (let Some(v) <- headingTheme.heading5MarginLeft) { h5MarginLeft = v }
    theme.setMarginForDesignateHeading(5, top: h5MarginTop, right: h5MarginRight, bottom: h5MarginBottom, left: h5MarginLeft)

    var h5PaddingTop: Float64 = 0.0
    var h5PaddingRight: Float64 = 0.0
    var h5PaddingBottom: Float64 = 0.0
    var h5PaddingLeft: Float64 = 0.0
    if (let Some(v) <- headingTheme.heading5PaddingTop) { h5PaddingTop = v }
    if (let Some(v) <- headingTheme.heading5PaddingRight) { h5PaddingRight = v }
    if (let Some(v) <- headingTheme.heading5PaddingBottom) { h5PaddingBottom = v }
    if (let Some(v) <- headingTheme.heading5PaddingLeft) { h5PaddingLeft = v }
    theme.setPaddingForDesignateHeading(5, top: h5PaddingTop, right: h5PaddingRight, bottom: h5PaddingBottom, left: h5PaddingLeft)

    if (let Some(v) <- headingTheme.heading5TextFontColor) { theme.setTextFontColorForDesignateHeading(5, v) }
    if (let Some(v) <- headingTheme.heading5TextFontSize) { theme.setTextFontSizeForDesignateHeading(5, v) }
    if (let Some(v) <- headingTheme.heading5TextFontStyle) { theme.setTextFontStyleForDesignateHeading(5, v) }
    if (let Some(v) <- headingTheme.heading5TextFontWeight) { theme.setTextFontWeightForDesignateHeading(5, v) }
    if (let Some(v) <- headingTheme.heading5TextFontFamily) { theme.setTextFontFamilyForDesignateHeading(5, v) }
    if (let Some(v) <- headingTheme.heading5TextLineHeight) { theme.setTextLineHeightForDesignateHeading(5, v) }
    if (let Some(v) <- headingTheme.heading5TextLetterSpacing) { theme.setTextLetterSpacingForDesignateHeading(5, v) }

    // H6
    if (let Some(v) <- headingTheme.heading6BackgroundColor) { theme.setBackgroundColorForDesignateHeading(6, v) }
    var h6MarginTop: Float64 = 0.0
    var h6MarginRight: Float64 = 0.0
    var h6MarginBottom: Float64 = 0.0
    var h6MarginLeft: Float64 = 0.0
    if (let Some(v) <- headingTheme.heading6MarginTop) { h6MarginTop = v }
    if (let Some(v) <- headingTheme.heading6MarginRight) { h6MarginRight = v }
    if (let Some(v) <- headingTheme.heading6MarginBottom) { h6MarginBottom = v }
    if (let Some(v) <- headingTheme.heading6MarginLeft) { h6MarginLeft = v }
    theme.setMarginForDesignateHeading(6, top: h6MarginTop, right: h6MarginRight, bottom: h6MarginBottom, left: h6MarginLeft)

    var h6PaddingTop: Float64 = 0.0
    var h6PaddingRight: Float64 = 0.0
    var h6PaddingBottom: Float64 = 0.0
    var h6PaddingLeft: Float64 = 0.0
    if (let Some(v) <- headingTheme.heading6PaddingTop) { h6PaddingTop = v }
    if (let Some(v) <- headingTheme.heading6PaddingRight) { h6PaddingRight = v }
    if (let Some(v) <- headingTheme.heading6PaddingBottom) { h6PaddingBottom = v }
    if (let Some(v) <- headingTheme.heading6PaddingLeft) { h6PaddingLeft = v }
    theme.setPaddingForDesignateHeading(6, top: h6PaddingTop, right: h6PaddingRight, bottom: h6PaddingBottom, left: h6PaddingLeft)

    if (let Some(v) <- headingTheme.heading6TextFontColor) { theme.setTextFontColorForDesignateHeading(6, v) }
    if (let Some(v) <- headingTheme.heading6TextFontSize) { theme.setTextFontSizeForDesignateHeading(6, v) }
    if (let Some(v) <- headingTheme.heading6TextFontStyle) { theme.setTextFontStyleForDesignateHeading(6, v) }
    if (let Some(v) <- headingTheme.heading6TextFontWeight) { theme.setTextFontWeightForDesignateHeading(6, v) }
    if (let Some(v) <- headingTheme.heading6TextFontFamily) { theme.setTextFontFamilyForDesignateHeading(6, v) }
    if (let Some(v) <- headingTheme.heading6TextLineHeight) { theme.setTextLineHeightForDesignateHeading(6, v) }
    if (let Some(v) <- headingTheme.heading6TextLetterSpacing) { theme.setTextLetterSpacingForDesignateHeading(6, v) }

    return theme
}
