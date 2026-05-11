/**
 * Markdown用户可设置的样式-全局样式
 */
export class MarkdownThemeGlobal {
  /**
   * markdown上下文 - 互操作
   */
  private stageContext?: Context = undefined

  /**
   * markdown是否同步解析
   */
  private isMarkdownParserSync?: boolean = undefined

  /**
   * 是否打开长按复制粘贴
   */
  private isOnCopy?: boolean = undefined

  /**
   * markdown全局上外边距
   */
  private blockMarginTop?: number = undefined

  /**
   * markdown全局右外边距
   */
  private blockMarginRight?: number = undefined

  /**
   * markdown全局下外边距
   */
  private blockMarginBottom?: number = undefined

  /**
   * markdown全局左外边距
   */
  private blockMarginLeft?: number = undefined

  /**
   * 模块间上下间距
   */
  private markdownBlockSpacing?: number = undefined

  /**
   * 软换行是否换行
   */
  private isLineBreak?: boolean = undefined

  /**
   * markdown是否允许滑动
   */
  private openGestureSwipe?: boolean = undefined

  /**
   * 背景颜色
   */
  private backgroundColor?: number = undefined

  /**
   * 设置上下文
   *
   * @param context 上下文
   */
  setStageContext(context: Context): void {
    this.stageContext = context
  }

  /**
   * 设置markdown是否同步解析
   *
   * @param isSync 是否同步解析
   */
  setIsMarkdownParserSync(isSync: boolean): void {
    this.isMarkdownParserSync = isSync
  }

  /**
   * 设置是否打开长按复制粘贴
   *
   * @param onCopy 是否打开
   */
  setIsOnCopy(onCopy: boolean): void {
    this.isOnCopy = onCopy
  }

  /**
   * 设置4个外边距为统一值
   *
   * @param margin 外边距
   */
  setGlobalAllMargin(margin: number): void {
    this.blockMarginTop = margin
    this.blockMarginRight = margin
    this.blockMarginBottom = margin
    this.blockMarginLeft = margin
  }

  /**
   * 分别设置4个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setGlobalMargin(top?: number, right?: number, bottom?: number, left?: number): void {
    this.blockMarginTop = top
    this.blockMarginRight = right
    this.blockMarginBottom = bottom
    this.blockMarginLeft = left
  }

  /**
   * 设置模块间上下间距
   *
   * @param spacing 模块间上下间距
   */
  setBlockSpacing(spacing: number): void {
    this.markdownBlockSpacing = spacing
  }

  /**
   * 设置软换行是否换行
   *
   * @param isLineBreak 是否换行
   */
  setIsLineBreak(isLineBreak: boolean): void {
    this.isLineBreak = isLineBreak
  }

  /**
   * 设置markdown是否允许滑动
   *
   * @param openGestureSwipe 是否允许滑动
   */
  setOpenGestureSwipe(openGestureSwipe: boolean): void {
    this.openGestureSwipe = openGestureSwipe
  }

  /**
   * 设置背景颜色
   *
   * @param color 背景颜色
   */
  setBackgroundColor(color: number): void {
    this.backgroundColor = color
  }

  /**
   * 获取stageContext
   *
   * @returns stageContext
   */
  getStageContext(): Context | undefined {
    return this.stageContext
  }

  /**
   * 获取isMarkdownParserSync
   *
   * @returns isMarkdownParserSync
   */
  getIsMarkdownParserSync(): boolean | undefined {
    return this.isMarkdownParserSync
  }

  /**
   * 获取isOnCopy
   *
   * @returns isOnCopy
   */
  getIsOnCopy(): boolean | undefined {
    return this.isOnCopy
  }

  /**
   * 获取blockMarginTop
   *
   * @returns blockMarginTop
   */
  getBlockMarginTop(): number | undefined {
    return this.blockMarginTop
  }

  /**
   * 获取blockMarginRight
   *
   * @returns blockMarginRight
   */
  getBlockMarginRight(): number | undefined {
    return this.blockMarginRight
  }

  /**
   * 获取blockMarginBottom
   *
   * @returns blockMarginBottom
   */
  getBlockMarginBottom(): number | undefined {
    return this.blockMarginBottom
  }

  /**
   * 获取blockMarginLeft
   *
   * @returns blockMarginLeft
   */
  getBlockMarginLeft(): number | undefined {
    return this.blockMarginLeft
  }

  /**
   * 获取markdownBlockSpacing
   *
   * @returns markdownBlockSpacing
   */
  getMarkdownBlockSpacing(): number | undefined {
    return this.markdownBlockSpacing
  }

  /**
   * 获取isLineBreak
   *
   * @returns isLineBreak
   */
  getIsLineBreak(): boolean | undefined {
    return this.isLineBreak
  }

  /**
   * 获取openGestureSwipe
   *
   * @returns openGestureSwipe
   */
  getOpenGestureSwipe(): boolean | undefined {
    return this.openGestureSwipe
  }

  /**
   * 获取backgroundColor
   *
   * @returns backgroundColor
   */
  getBackgroundColor(): number | undefined {
    return this.backgroundColor
  }
}
