/**
 * Markdown用户可设置的样式-全局样式
 */
export class MarkdownThemeGlobal {
  /**
   * markdown上下文 - 互操作
   */
  stageContext?: Object = undefined

  /**
   * markdown上下文 - 仓颉
   */
  uiAbilityContext?: Object = undefined

  /**
   * markdown是否同步解析
   */
  isMarkdownParserSync?: boolean = undefined

  /**
   * 是否打开长按复制粘贴
   */
  isOnCopy?: boolean = undefined

  /**
   * markdown全局上外边距
   */
  blockMarginTop?: number = undefined

  /**
   * markdown全局右外边距
   */
  blockMarginRight?: number = undefined

  /**
   * markdown全局下外边距
   */
  blockMarginBottom?: number = undefined

  /**
   * markdown全局左外边距
   */
  blockMarginLeft?: number = undefined

  /**
   * 模块间上下间距
   */
  markdownBlockSpacing?: number = undefined

  /**
   * 软换行是否换行
   */
  isLineBreak?: boolean = undefined

  /**
   * markdown是否允许滑动
   */
  openGestureSwipe?: boolean = undefined

  /**
   * 背景颜色
   */
  backgroundColor?: number = undefined

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
}
