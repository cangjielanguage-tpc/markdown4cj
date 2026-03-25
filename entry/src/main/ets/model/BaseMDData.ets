/**
 * 基础数据
 */
export class BaseMDData {
  _isFull: boolean = true // 是否全量加载Markdown文本
  _incrementalAnalysis: boolean = false // 是否增量解析Markdown文本
  _time: number = 50 // 增量加载每次间隔时间
  _textNumber: number = 10 // 增量每次增量文本数量
  _isMarkdownParserSync: boolean = false // 是否同步解析Markdown文本
  _typeWriterOpen: boolean = false // 是否开启打字机效果
  _typeWriterColor: number = 0xFFFF0000 // 打字机效果颜色
  _isOnCopy: boolean = false // 是否打开长按复制粘贴效果
  _blockFirstTopMargin: number = 8 // Markdown文本第一个模块上边距
  _blockLastBottomMargin: number = 8 // Markdown文本最后一个模块下边距
  _blockTopAndBottomMargins: number = 8 // Markdown文本模块间上下间距
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

  public set typeWriterOpen(value: boolean) {
    this._typeWriterOpen = value
  }

  public set typeWriterColor(value: number) {
    this._typeWriterColor = value
  }

  public set isOnCopy(value: boolean) {
    this._isOnCopy = value
  }

  public set blockFirstTopMargin(value: number) {
    this._blockFirstTopMargin = value
  }

  public set blockLastBottomMargin(value: number) {
    this._blockLastBottomMargin = value
  }

  public set blockTopAndBottomMargins(value: number) {
    this._blockTopAndBottomMargins = value
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

  constructor() {
  }
}