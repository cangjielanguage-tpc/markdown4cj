/**
 * 基础数据
 */
export class BaseMDData {
  _isFull: boolean = true // 是否全量加载Markdown文本
  _incrementalAnalysis: boolean = false // 是否增量解析Markdown文本
  _time: number = 50 // 增量加载每次间隔时间
  _textNumber: number = 10 // 增量每次增量文本数量
  _isMarkdownParserSync: boolean = false // 是否同步解析Markdown文本
  _isOnCopy: boolean = false // 是否打开长按复制粘贴效果
  _stageContext: Context | undefined = undefined // markdown上下文 - 互操作
  _blockMarginTop: number = 0 // markdown全局上外边距
  _blockMarginRight: number = 0 // markdown全局右外边距
  _blockMarginBottom: number = 0 // markdown全局下外边距
  _blockMarginLeft: number = 0 // markdown全局左外边距
  _markdownBlockSpacing: number = 8 // 模块间上下间距
  _isLineBreak: boolean = false // 软换行是否换行
  _backgroundColor: ResourceColor | undefined = undefined // 背景颜色
  _openGestureSwipeTest: boolean = false // 是否开启响应滑动测试
  _openGestureSwipe: boolean = false // 是否允许markdown控件自身响应滑动
  _pagePath: string = "" // Markdown文本rawfile路径

  public set isFull(value: boolean) {
    this._isFull = value
  }

  public set incrementalAnalysis(value: boolean) {
    this._incrementalAnalysis = value
  }

  public set time(value: number) {
    this._time = value
  }

  public set textNumber(value: number) {
    this._textNumber = value
  }

  public set isMarkdownParserSync(value: boolean) {
    this._isMarkdownParserSync = value
  }

  public set isOnCopy(value: boolean) {
    this._isOnCopy = value
  }

  public set openGestureSwipeTest(value: boolean) {
    this._openGestureSwipeTest = value
  }

  public set openGestureSwipe(value: boolean) {
    this._openGestureSwipe = value
  }

  public set pagePath(value: string) {
    this._pagePath = value
  }

  public set stageContext(value: Context | undefined) {
    this._stageContext = value
  }

  public set blockMarginTop(value: number) {
    this._blockMarginTop = value
  }

  public set blockMarginRight(value: number) {
    this._blockMarginRight = value
  }

  public set blockMarginBottom(value: number) {
    this._blockMarginBottom = value
  }

  public set blockMarginLeft(value: number) {
    this._blockMarginLeft = value
  }

  public set markdownBlockSpacing(value: number) {
    this._markdownBlockSpacing = value
  }

  public set isLineBreak(value: boolean) {
    this._isLineBreak = value
  }

  public set backgroundColor(value: ResourceColor | undefined) {
    this._backgroundColor = value
  }

  constructor() {
  }
}