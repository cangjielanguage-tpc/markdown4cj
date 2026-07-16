/**
 * 基础数据
 */
export class BaseMDData {
  _isFull: boolean = true // 是否全量加载Markdown文本
  _incrementalAnalysis: boolean = false // 是否增量解析Markdown文本
  _time: number = 50 // 增量加载每次间隔时间
  _enableParseThrottle: boolean = false // 是否启用解析节流，true为markdown控制节流，false为用户自行控制 - 默认false
  _parseThrottleMs: number = 200 // 解析节流间隔（ms），enableParseThrottle为true时生效，0表示不节流
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

  _showHighlight: boolean = false // 是否开启段落背景高亮功能
  _beforeSelectedParagraphBackgroundColor: ResourceColor | undefined = undefined // 当前长按未触发弹窗时段落前的背景色
  _selectedParagraphBackgroundColor: ResourceColor | undefined = undefined // 当前长按放手后选中文字的背景色

  constructor() {
  }
}