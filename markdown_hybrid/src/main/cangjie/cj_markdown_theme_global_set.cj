package markdown

func setGlobalTheme(globalTheme: CJMarkdownGlobalTheme): GlobalTheme {
    let theme: GlobalTheme = GlobalTheme()
    if (let Some(v) <- GlobalContext.getContext()) {
        theme.setStageContext(v) // 设置markdown上下文 - 互操作
    }
    if (let Some(v) <- globalTheme.isMarkdownParserSync) {
        theme.setIsMarkdownParserSync(v) // 设置markdown是否同步解析
    }
    if (let Some(v) <- globalTheme.isOnCopy) {
        theme.setIsOnCopy(v)
    }
    var blockMarginTop: Float64 = 0.0 // markdown全局上外边距
    var blockMarginRight: Float64 = 0.0 // markdown全局右外边距
    var blockMarginBottom: Float64 = 0.0 // markdown全局下外边距
    var blockMarginLeft: Float64 = 0.0 // markdown全局左外边距
    if (let Some(v) <- globalTheme.blockMarginTop) {
        blockMarginTop = v
    }
    if (let Some(v) <- globalTheme.blockMarginRight) {
        blockMarginRight = v
    }
    if (let Some(v) <- globalTheme.blockMarginBottom) {
        blockMarginBottom = v
    }
    if (let Some(v) <- globalTheme.blockMarginLeft) {
        blockMarginLeft = v
    }
    theme.setMargin(top: blockMarginTop, right: blockMarginRight, bottom: blockMarginBottom, left: blockMarginLeft)

    if (let Some(v) <- globalTheme.markdownBlockSpacing) {
        theme.setMarkdownBlockSpacing(v)
    }
    if (let Some(v) <- globalTheme.isLineBreak) {
        theme.setIsLineBreak(v)
    }
    if (let Some(v) <- globalTheme.openGestureSwipe) {
        theme.setOpenGestureSwipe(v)
    }
    if (let Some(v) <- globalTheme.backgroundColor) {
        theme.setBackgroundColor(v)
    }
    return theme
}
