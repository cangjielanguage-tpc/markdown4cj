/**
 * Created on 2026/4/20
 */
package markdown

func setAudioTheme(audioTheme: CJMarkdownAudioTheme): AudioTheme {
    let theme: AudioTheme = AudioTheme()
    if (let Some(v) <- audioTheme.audioBackgroundColor) {
        theme.setAudioBackgroundColor(v)
    }
    var audioMarginTop: Float64 = 10.0
    var audioMarginRight: Float64 = 0.0
    var audioMarginBottom: Float64 = 10.0
    var audioMarginLeft: Float64 = 0.0
    if (let Some(v) <- audioTheme.audioMarginTop) { audioMarginTop = v }
    if (let Some(v) <- audioTheme.audioMarginRight) { audioMarginRight = v }
    if (let Some(v) <- audioTheme.audioMarginBottom) { audioMarginBottom = v }
    if (let Some(v) <- audioTheme.audioMarginLeft) { audioMarginLeft = v }
    theme.setAudioMargin(top: audioMarginTop, right: audioMarginRight, bottom: audioMarginBottom, left: audioMarginLeft)

    var audioPaddingTop: Float64 = 0.0
    var audioPaddingRight: Float64 = 0.0
    var audioPaddingBottom: Float64 = 0.0
    var audioPaddingLeft: Float64 = 0.0
    if (let Some(v) <- audioTheme.audioPaddingTop) { audioPaddingTop = v }
    if (let Some(v) <- audioTheme.audioPaddingRight) { audioPaddingRight = v }
    if (let Some(v) <- audioTheme.audioPaddingBottom) { audioPaddingBottom = v }
    if (let Some(v) <- audioTheme.audioPaddingLeft) { audioPaddingLeft = v }
    theme.setAudioPadding(top: audioPaddingTop, right: audioPaddingRight, bottom: audioPaddingBottom, left: audioPaddingLeft)

    if (let Some(v) <- audioTheme.audioBorderStyle) {
        theme.setAudioBorderStyle(v)
    }
    if (let Some(v) <- audioTheme.audioBorderWidth) {
        theme.setAudioBorderWidth(v)
    }
    if (let Some(v) <- audioTheme.audioBorderColor) {
        theme.setAudioBorderColor(v)
    }
    var audioRadiusTopLeft: Float64 = 12.0
    var audioRadiusTopRight: Float64 = 12.0
    var audioRadiusBottomLeft: Float64 = 12.0
    var audioRadiusBottomRight: Float64 = 12.0
    if (let Some(v) <- audioTheme.audioRadiusTopLeft) { audioRadiusTopLeft = v }
    if (let Some(v) <- audioTheme.audioRadiusTopRight) { audioRadiusTopRight = v }
    if (let Some(v) <- audioTheme.audioRadiusBottomLeft) { audioRadiusBottomLeft = v }
    if (let Some(v) <- audioTheme.audioRadiusBottomRight) { audioRadiusBottomRight = v }
    theme.setAudioRadius(topLeft: audioRadiusTopLeft, topRight: audioRadiusTopRight, bottomLeft: audioRadiusBottomLeft, bottomRight: audioRadiusBottomRight)

    if (let Some(v) <- audioTheme.audioShadowColor) {
        theme.setAudioShadowColor(v)
    }
    if (let Some(v) <- audioTheme.audioShadowRadius) {
        theme.setAudioShadowRadius(v)
    }
    if (let Some(v) <- audioTheme.audioShadowOffsetX) {
        theme.setAudioShadowOffsetX(v)
    }
    if (let Some(v) <- audioTheme.audioShadowOffsetY) {
        theme.setAudioShadowOffsetY(v)
    }
    if (let Some(v) <- audioTheme.audioIconWidth) {
        theme.setAudioIconWidth(v)
    }
    if (let Some(v) <- audioTheme.audioIconHeight) {
        theme.setAudioIconHeight(v)
    }
    var audioIconRadiusTopLeft: Float64 = 0.0
    var audioIconRadiusTopRight: Float64 = 0.0
    var audioIconRadiusBottomLeft: Float64 = 0.0
    var audioIconRadiusBottomRight: Float64 = 0.0
    if (let Some(v) <- audioTheme.audioIconRadiusTopLeft) { audioIconRadiusTopLeft = v }
    if (let Some(v) <- audioTheme.audioIconRadiusTopRight) { audioIconRadiusTopRight = v }
    if (let Some(v) <- audioTheme.audioIconRadiusBottomLeft) { audioIconRadiusBottomLeft = v }
    if (let Some(v) <- audioTheme.audioIconRadiusBottomRight) { audioIconRadiusBottomRight = v }
    theme.setAudioIconRadius(topLeft: audioIconRadiusTopLeft, topRight: audioIconRadiusTopRight, bottomLeft: audioIconRadiusBottomLeft, bottomRight: audioIconRadiusBottomRight)

    if (let Some(v) <- audioTheme.audioIconFitType) {
        theme.setAudioIconFitType(v)
    }
    if (let Some(v) <- audioTheme.audioTitleToTypeSpacing) {
        theme.setAudioTitleToTypeSpacing(v)
    }
    if (let Some(v) <- audioTheme.audioButtonWidth) {
        theme.setAudioButtonWidth(v)
    }
    if (let Some(v) <- audioTheme.audioButtonHeight) {
        theme.setAudioButtonHeight(v)
    }
    if (let Some(v) <- audioTheme.audioButtonBackgroundColor) {
        theme.setAudioButtonBackgroundColor(v)
    }
    if (let Some(v) <- audioTheme.audioButtonBorderStyle) {
        theme.setAudioButtonBorderStyle(v)
    }
    if (let Some(v) <- audioTheme.audioButtonBorderWidth) {
        theme.setAudioButtonBorderWidth(v)
    }
    if (let Some(v) <- audioTheme.audioButtonBorderColor) {
        theme.setAudioButtonBorderColor(v)
    }
    var audioButtonRadiusTopLeft: Float64 = 16.0
    var audioButtonRadiusTopRight: Float64 = 16.0
    var audioButtonRadiusBottomLeft: Float64 = 16.0
    var audioButtonRadiusBottomRight: Float64 = 16.0
    if (let Some(v) <- audioTheme.audioButtonRadiusTopLeft) { audioButtonRadiusTopLeft = v }
    if (let Some(v) <- audioTheme.audioButtonRadiusTopRight) { audioButtonRadiusTopRight = v }
    if (let Some(v) <- audioTheme.audioButtonRadiusBottomLeft) { audioButtonRadiusBottomLeft = v }
    if (let Some(v) <- audioTheme.audioButtonRadiusBottomRight) { audioButtonRadiusBottomRight = v }
    theme.setAudioButtonRadius(topLeft: audioButtonRadiusTopLeft, topRight: audioButtonRadiusTopRight, bottomLeft: audioButtonRadiusBottomLeft, bottomRight: audioButtonRadiusBottomRight)

    if (let Some(v) <- audioTheme.audioButtonText) {
        theme.setAudioButtonText(v)
    }
    if (let Some(v) <- audioTheme.audioButtonTextFontColor) {
        theme.setAudioButtonTextFontColor(v)
    }
    if (let Some(v) <- audioTheme.audioButtonTextFontSize) {
        theme.setAudioButtonTextFontSize(v)
    }
    if (let Some(v) <- audioTheme.audioButtonTextFontStyle) {
        theme.setAudioButtonTextFontStyle(v)
    }
    if (let Some(v) <- audioTheme.audioButtonTextFontWeight) {
        theme.setAudioButtonTextFontWeight(v)
    }
    if (let Some(v) <- audioTheme.audioButtonTextFontFamily) {
        theme.setAudioButtonTextFontFamily(v)
    }
    if (let Some(v) <- audioTheme.audioButtonTextLineHeight) {
        theme.setAudioButtonTextLineHeight(v)
    }
    if (let Some(v) <- audioTheme.audioTitleTextFontColor) {
        theme.setAudioTitleTextFontColor(v)
    }
    if (let Some(v) <- audioTheme.audioTitleTextFontSize) {
        theme.setAudioTitleTextFontSize(v)
    }
    if (let Some(v) <- audioTheme.audioTitleTextFontStyle) {
        theme.setAudioTitleTextFontStyle(v)
    }
    if (let Some(v) <- audioTheme.audioTitleTextFontWeight) {
        theme.setAudioTitleTextFontWeight(v)
    }
    if (let Some(v) <- audioTheme.audioTitleTextFontFamily) {
        theme.setAudioTitleTextFontFamily(v)
    }
    if (let Some(v) <- audioTheme.audioTitleTextLineHeight) {
        theme.setAudioTitleTextLineHeight(v)
    }
    if (let Some(v) <- audioTheme.audioTypeTextFontColor) {
        theme.setAudioTypeTextFontColor(v)
    }
    if (let Some(v) <- audioTheme.audioTypeTextFontSize) {
        theme.setAudioTypeTextFontSize(v)
    }
    if (let Some(v) <- audioTheme.audioTypeTextFontStyle) {
        theme.setAudioTypeTextFontStyle(v)
    }
    if (let Some(v) <- audioTheme.audioTypeTextFontWeight) {
        theme.setAudioTypeTextFontWeight(v)
    }
    if (let Some(v) <- audioTheme.audioTypeTextFontFamily) {
        theme.setAudioTypeTextFontFamily(v)
    }
    if (let Some(v) <- audioTheme.audioTypeTextLineHeight) {
        theme.setAudioTypeTextLineHeight(v)
    }
    return theme
}