// import { ImageFitType, LatexMathColorFormat } from "@cangjie-tpc/markdown_hybrid"

export class DeprecatedData {
  // 是否全量加载Markdown文本
  _isFull: boolean = true
  // 是否增量解析Markdown文本
  _incrementalAnalysis: boolean = false
  // 增量加载每次间隔时间
  _time: number = 50
  // 增量每次增量文本数量
  _textNumber: number = 10
  // 是否同步解析Markdown文本
  _isMarkdownParserSync: boolean = false
  // 是否打开长按复制粘贴效果
  _isOnCopy: boolean = false
  // Markdown文本第一个模块上边距
  _blockFirstTopMargin: number = 8
  // Markdown文本最后一个模块下边距
  _blockLastBottomMargin: number = 8
  // Markdown文本模块间上下间距
  _blockTopAndBottomMargins: number = 8
  // 是否开启响应滑动测试
  _openGestureSwipeTest: boolean = false
  // 是否允许markdown控件自身响应滑动
  _openGestureSwipe: boolean = false
  // Markdown文本rawfile路径
  _pagePath: string = ""
  // 上下文
  _context: Context | undefined = undefined
  // 代码块全屏图片icon
  _codeFullScreenIcon: Resource | undefined = undefined
  // 代码块复制图片icon
  _codeCopyIcon: Resource | undefined = undefined
  // 音频图片icon
  _audioIcon: Resource | undefined = undefined
  // 视频默认占位图
  _videoImage: Resource | undefined = undefined
  // 视频播放按钮icon
  _playCircleFillIcon: Resource | undefined = undefined
  // banner默认占位图
  _bannerImage: Resource | undefined = undefined
  // 图片默认占位图
  _imageResource: Resource | undefined = undefined
  // 视频发布默认图标
  _videoReleaseImage: Resource | undefined = undefined
  // 视频下载默认图标
  _videoDownloadImage: Resource | undefined = undefined
  // 图片下载默认图标
  _imageDownloadImage: Resource | undefined = undefined

  // 链接是否是图片显示
  _isLinkStyle: boolean = false
  // 列表中的单行链接是否是图片显示
  _isListLinkStyle: boolean = false
  // 文本格式链接文本颜色
  _linkColor: number = 0xFF0000FF
  // 文本格式链接文字大小
  _isLinkSize: boolean = true
  // 文本格式链接文字大小
  _linkSize: number = 14
  // 文本格式链接文字行高
  _linkLineHeight: number = 20
  // 文本格式链接背景颜色
  _linkBackGroupColor: number = 0x00000000
  // 文本格式是否显示链接下划线
  _isLinkUnderlined: boolean = true
  // 圆形图片格式链接主题背景颜色
  _linkCircleImageBackGroupColor: number = 0x00000000
  // 圆形图片格式链接控件背景颜色
  _linkCircleImageButtonBackGroupColor: number = 0xFF000000
  // 圆形图片格式链接文字大小
  _linkCircleImageTextSize: number = 14
  // 圆形图片格式链接文字颜色
  _linkCircleImageTextColor: number = 0xFFFFFFFF
  // 圆形图片格式链接半径
  _linkCircleImageRadius: number = 20
  // 圆形图片格式链接左右外边距
  _linkCircleImageMargin: number = 6
  // 圆角矩形图片格式链接主题背景颜色
  _linkRectImageBackGroupColor: number = 0x00000000
  // 圆角矩形图片格式链接控件背景颜色
  _linkRectImageButtonBackGroupColor: number = 0xFF000000
  // 圆角矩形图片格式链接文字大小
  _linkRectImageTextSize: number = 14
  // 圆角矩形图片格式链接文字颜色
  _linkRectImageTextColor: number = 0xFFFFFFFF
  // 圆角矩形图片格式链接控件高度
  _linkRectImageHeight: number = 20
  // 圆角矩形图片格式链接左右内边距
  _linkRectImagePadding: number = 6
  // 圆角矩形图片格式链接圆角半径
  _linkRectImageRadius: number = 6
  // 圆角矩形图片格式链接左右外边距
  _linkRectImageMargin: number = 6
  // 空心圆角矩形图片格式链接主题背景颜色
  _linkRectToolImageBackGroupColor: number = 0x00000000
  // 空心圆角矩形图片格式链接控件背景颜色
  _linkRectToolImageButtonBackGroupColor: number = 0xFFFFFFFF
  // 空心圆角矩形图片格式链接文字大小
  _linkRectToolImageTextSize: number = 14
  // 空心圆角矩形图片格式链接控件高度
  _linkRectToolImageHeight: number = 21
  // 空心圆角矩形图片格式链接左右内边距
  _linkRectToolImagePadding: number = 6
  // 空心圆角矩形图片格式链接边框宽度
  _linkRectToolImageBorderWidth: number = 1
  // 空心圆角矩形图片格式链接分割线宽度
  _linkRectToolImageDividingLineWidth: number = 1
  // 空心圆角矩形图片格式链接左右外边距
  _linkRectToolImageMargin: number = 6
  // 空心圆角矩形图片格式分割线和文本左边距
  _linkRectToolImageLineLeftPadding: number = 3
  // 空心圆角矩形图片格式分割线和文本右边距
  _linkRectToolImageLineRightPadding: number = 3
  // 块引用左边距
  _blockQuoteLeftMargin: number = 8
  // 块引用右边距
  _blockQuoteRightMargin: number = 8
  // 块引用左边线条宽度
  _blockQuoteWidth: number = 1
  // 块引用左边线条颜色
  _blockQuoteColor: number = 0xFF191919
  // 块引用背景颜色
  _blockQuoteBackGroupColor: number = 0xFFEAEAEA
  // 块引用子模块上下间距
  _blockQuoteTopAndBottomMargins: number = 0
  // 有序列表、无序列表、任务列表子模块上下间距
  _blockOrderedAndBulletTopAndBottomMargins: number = 0
  // 有序列表、无序列表、任务列表左边距
  _blockLeftMargin: number = 8
  // 有序列表、无序列表、任务列表右边距
  _blockRightMargin: number = 8
  // 有序列表前缀文本是否加粗
  _orderedListItemPrefixBold: boolean = false
  // 有序列表前缀文本颜色
  _orderedListItemColor: number = 0xFF191919
  // 有序列表前缀文本大小
  _orderedListItemSize: number = 14
  // 有序列表前缀文本行高
  _orderedListItemLineHeight: number = 22
  // 无序列表前缀是否全部是实心圆型
  _bulletListItemCircle: boolean = false
  // 无序列表前缀文本颜色
  _bulletListItemColor: number = 0xFF191919
  // 无序列表前缀文本大小
  _bulletListItemSize: number = 4
  // 无序列表前缀文本行高
  _bulletListItemLineHeight: number = 18
  // 任务列表选择框宽高
  _taskListItemLength: number = 15
  // 设置是否格式化代码块内容
  _isCodeFormat: boolean = false
  // 内联代码文本颜色
  _codeTextColor: number = 0xFF000000
  // 内联代码背景颜色
  _codeBackgroundColor: number = 0xFFEAEAEA
  // 内联代码文本大小
  _codeTextSize: number = 13
  // 内联代码文本字体
  _codeTypeface: string = "HarmonyOS Sans"
  // 围栏代码块代码高亮是否同步解析
  _isCodeBlockParserSync: boolean = false
  // 代码块代码文本颜色
  _codeBlockTextColor: number | undefined = undefined
  // 代码块代码类型文本颜色
  _codeBlockTypeTextColor: number | undefined = undefined
  // 代码块代码类型文本
  _codeBlockTypeTextStr: string = ""
  // 代码类型和代码块距离
  _codeBlockTypeTextPadding: number = 0
  // 代码块复制、全屏图片文字是否显示
  _codeBlockIconTextHide: boolean = true
  // 代码块代码行号是否显示
  _codeBlockLineNumberHide: boolean = true
  // 代码块背景颜色
  _codeBlockBackgroundColor: number | undefined = undefined
  // 代码块左边距
  _codeMultilineMargin: number = 8
  // 代码块字体
  _codeBlockTypeface: string = "HarmonyOS Sans"
  // 代码块代码文本大小
  _codeBlockTextSize: number = 13
  // 代码块代码文本行高
  _codeBlockLineHeight: number = 22
  // 代码块控件圆角大小
  _codeBlockRadius: number = 8
  // 代码块代码全屏按钮是否显示
  _isCodeFullScreen: boolean = true
  // 代码块代码全屏、代码复制按钮宽高
  _iconWidthAndHeight: number = 24
  // 组合代码未选中标题字体大小
  _codeListTitleTextSize: number = 13
  // 组合代码选中标题字体大小
  _codeListTitleSelectTextSize: number = 13
  // 组合代码选中标题文本颜色
  _codeListTitleSelectTextColor: number = 0xFFFF0000
  // 组合代码未选中标题文本颜色
  _codeListTitleUnSelectTextColor: number = 0xFF000000
  // 组合代码选中标题背景颜色
  _codeListTitleSelectBackGroupColor: number = 0xFF808080
  // 组合代码未选中标题背景颜色
  _codeListTitleUnSelectBackGroupColor: number = 0x00000000
  // 是否单独代码块显示
  _isSeparateCodeBlock: boolean = false
  // 单独代码块行号宽度
  _separateCodeBlockWidth: number = 50
  // 单独代码块是否居底显示
  _separateCodeIsBottom: boolean = false
  // H1、H2标题下分割线高度
  _headingBreakHeight: number = 0.5
  // 标题文本字体
  _headingTypeface: string = "HarmonyOS Sans"
  // 标题模块上间距
  _headingTopMargins: number = 8
  // 标题模块下间距
  _headingBottomMargins: number = 8
  // 一级标题文本大小
  _headingTextSize1: number = 20
  // 二级标题文本大小
  _headingTextSize2: number = 17
  // 三级标题文本大小
  _headingTextSize3: number = 16
  // 四级标题文本大小
  _headingTextSize4: number = 15
  // 五级标题文本大小
  _headingTextSize5: number = 15
  // 六级标题文本大小
  _headingTextSize6: number = 13
  // 标题文本字间距
  _headingTextWordSpace: number = 0
  // 一级标题文本行高
  _headingTextLineHeight1: number = 22
  // 二级标题文本行高
  _headingTextLineHeight2: number = 22
  // 三级标题文本行高
  _headingTextLineHeight3: number = 22
  // 四级标题文本行高
  _headingTextLineHeight4: number = 22
  // 五级标题文本行高
  _headingTextLineHeight5: number = 22
  // 六级标题文本行高
  _headingTextLineHeight6: number = 22
  // 一级标题文本颜色
  _headingTextColor1: number = 0xFF191919
  // H1标题下分割线颜色
  _headingBreakColor1: number = 0xFF191919
  // 二级标题文本颜色
  _headingTextColor2: number = 0xFF191919
  // H2标题下分割线颜色
  _headingBreakColor2: number = 0xFF191919
  // 三级标题文本颜色
  _headingTextColor3: number = 0xFF191919
  // 四级标题文本颜色
  _headingTextColor4: number = 0xFF191919
  // 五级标题文本颜色
  _headingTextColor5: number = 0xFF191919
  // 六级标题文本颜色
  _headingTextColor6: number = 0xFF191919
  // 段落模块上间距
  _paragraphTopMargins: number = 8
  // 段落模块下间距
  _paragraphBottomMargins: number = 8
  // 段落文本大小
  _paragraphTextSize: number = 14
  // 段落文本颜色
  _paragraphTextColor: number = 0xFF191919
  // 段落文本字间距
  _paragraphTextWordSpace: number = 0
  // 段落文本行高
  _paragraphTextLineHeight: number = 22
  // 段落文本字体
  _paragraphTypeface: string = "HarmonyOS Sans"
  // 分割线颜色
  _thematicBreakColor: number = 0xFF191919
  // 分割线高度
  _thematicBreakHeight: number = 0.5
  // 分割线上部外边距
  _thematicBreakTopMargin: number = 0
  // 分割线下部外边距
  _thematicBreakBottomMargin: number = 0
  // 软换行是否换行
  _isLineBreak: boolean = false
  // 数学公式未加载状态是否显示文字
  _latexDefaultText: boolean = true
  // 数学公式文本大小
  _latexMathTextSize: number = 16
  // 数学公式背景色
  _latexMathBackGroupColor: number = 0x00000000
  // 数学公式文本颜色
  _latexMathTextColor: number = 0xFF000000
  // 数学公式生成图片格式
  // _latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
  // 块结构的数学公式是否居中
  _latexMathBlockCenter: boolean = false
  // 数学公式字体路径
  _latexMathResStr: string = "/data/storage/el1/bundle/entry/resources/resfile/res"
  // 音频阴影颜色值
  _audioShadowColor: number = 0x1A000000
  // 音频边框颜色
  _audioBorderColor: number = 0x33000000
  // 音频边框粗细
  _audioBorderWidth: number = 0.5
  // 音频边框圆角
  _audioBorderRadius: number = 12
  // 音频按钮背景颜色
  _audioButtonBackgroundColor: number = 0xFF000000
  // 音频按钮文字颜色
  _audioButtonTextColor: number = 0xFFFFFFFF
  // 音频按钮文字大小
  _audioButtonTextSize: number = 14
  // 音频按钮文字内容
  _audioButtonText: string = "立即播放"
  // 音频按钮圆角
  _audioButtonBorderRadius: number = 16
  // 音频标题文字大小
  _audioTitleTextSize: number = 15
  // 音频标题文字颜色
  _audioTitleTextColor: number = 0xFF000000
  // 音频标题文字行高
  _audioTitleTextLineHeight: number = 20
  // 音频类型文字大小
  _audioTypeTextSize: number = 11
  // 音频类型文字颜色
  _audioTypeTextColor: number = 0x80000000
  // 音频类型文字行高
  _audioTypeTextLineHeight: number = 15
  // 音频上边距
  _audioMarginTop: number = 10
  // 音频下边距
  _audioMarginBottom: number = 10
  // 视频圆角
  _videoBorderRadius: number = 10
  // 视频时间文本颜色
  _videoTimeTextColor: number = 0xFFFFFFFF
  // 视频时间文本大小
  _videoTimeTextSize: number = 14
  // 视频时间文本居右边距
  _videoTimeTextMarginRight: number = 10
  // 视频时间文本居底边距
  _videoTimeTextMarginBottom: number = 10
  // 视频上边距
  _videoMarginTop: number = 10
  // 视频下边距
  _videoMarginBottom: number = 10
  // 视频发布/下载按钮布局是否显示
  _isVideoBottomLayout: boolean = false
  // 视频发布按钮图片宽度和高度
  _videoReleaseImageWidthHeight: number = 18
  // 视频发布按钮宽度
  _videoReleaseWidth: number = 144
  // 视频发布按钮高度
  _videoReleaseHeight: number = 44
  // 视频发布按钮圆角
  _videoReleaseRadius: number = 22
  // 视频发布按钮文本内容
  _videoReleaseText: string = "发布视频"
  // 视频发布按钮文本大小
  _videoReleaseTexSize: number = 16
  // 视频发布按钮文本颜色
  _videoReleaseTexColor: number = 0xE6000000
  // 视频发布按钮背景颜色
  _videoReleaseBackgroundColor: number = 0xFFF5F5F5
  // 视频下载按钮图片宽度和高度
  _videoDownloadImageWidthHeight: number = 18
  // 视频下载按钮宽度
  _videoDownloadWidth: number = 144
  // 视频下载按钮高度
  _videoDownloadHeight: number = 44
  // 视频下载按钮圆角
  _videoDownloadRadius: number = 22
  // 视频下载按钮文本内容
  _videoDownloadText: string = "下载视频"
  // 视频下载按钮文本大小
  _videoDownloadTexSize: number = 16
  // 视频下载按钮文本颜色
  _videoDownloadTexColor: number = 0xE6000000
  // 视频下载按钮背景颜色
  _videoDownloadBackgroundColor: number = 0xFFF5F5F5
  // 图片缩放类型
  _imageFitType: ImageFit = ImageFit.Contain
  // 图片最大宽度百分比
  _imageMaximumWidth: number = 1
  // 图片固定宽度百分比
  _imageFixedRatioWidth: number | undefined = undefined
  // 图片最大高度
  _imageMaxHeight: number | undefined = undefined
  // 图片最大宽度
  _imageMaxWidth: number | undefined = undefined
  // 图片圆角大小
  _imageBorderRadius: number = 0
  // 图片圆角大小
  _imageBorderWidth: number = 0
  // 图片圆角大小
  _imageBorderColor: number = 0xFF000000
  // 网络图片是否压缩
  _isAutoResize: boolean = true
  // 图片上边距
  _imageMarginTop: number = 10
  // 图片下边距
  _imageMarginBottom: number = 10
  // 图片是否有下载按钮
  _isImageDownload: boolean = false
  // 是否图文混排
  _isImageMixedLayout: boolean = true
  // 图片下载按钮图片宽度和高度
  _imageDownloadImageWidthHeight: number = 18
  // 图片下载按钮宽度
  _imageDownloadWidth: number = 296
  // 图片下载按钮高度
  _imageDownloadHeight: number = 44
  // 图片下载按钮圆角
  _imageDownloadRadius: number = 22
  // 图片下载按钮文本内容
  _imageDownloadText: string = "下载图片"
  // 图片下载按钮文本大小
  _imageDownloadTexSize: number = 16
  // 图片下载按钮文本颜色
  _imageDownloadTexColor: number = 0xE6000000
  // 图片下载按钮背景颜色
  _imageDownloadBackgroundColor: number = 0xFFF5F5F5
  // 表格内容内边距
  _tableCellPadding: number = 4
  // 表格边框颜色
  _tableBorderColor: number = 0xFF000000
  // 表格边框宽度
  _tableBorderWidth: number = 1
  // 表格奇数行背景色
  _tableOddRowBackgroundColor: number = 0xFFFFFFFF
  // 表格偶数行背景色
  _tableEvenRowBackgroundColor: number = 0xFFE0E0E0
  // 表格标题背景色
  _tableHeaderRowBackgroundColor: number = 0xFFFFFFFF
  // 表格标题文本颜色
  _tableTitleTextColor: number = 0xFF191919
  // 表格标题文本大小
  _tableTitleTextSize: number = 14
  // 表格标题文本行高
  _tableTitleLineHeight: number = 22
  // 表格内容文本颜色
  _tableContentTextColor: number = 0xFF191919
  // 表格内容文本大小
  _tableContentTextSize: number = 14
  // 表格文本行高
  _tableTextLineHeight: number = 22
  // 表格圆角
  _tableRadius: number = 5
  // 表格最小宽度
  _tableMinTextWidth: number = 50
  // 表格最大宽度
  _tableMaxTextWidth: number = 300
  // 表格第一列是否加粗
  _tableFirstColumnBold: boolean = false
  // 表格是否显示滚动条
  _tableScrollBarShow: boolean = false
  // 表格滚动条颜色
  _tableScrollBarColor: number = 0xFF191919
  // 代码深浅色模式
  _isDark: boolean = false
  // 删除线颜色
  _strikethroughColor: number = 0xFF191919
  // 删除线样式
  _strikethroughStyle: TextDecorationStyle = TextDecorationStyle.SOLID
  // 定义列表定义行缩进
  _descListTermAndDefMargins: number = 8
  // 定义列表定义行缩进
  _descListDefIndentation: number = 8
  // 定义列表定义行间距
  _descListDefMargins: number = 8
  // 下标字体颜色
  _subTextColor: number = 0xFF191919
  // 下标字体大小
  _subTextSize: number = 8
  // 下标偏移距离
  _subOffsetDist: number = 0
  // 上标字体颜色
  _supTextColor: number = 0xFF191919
  // 上标字体大小
  _supTextSize: number = 8
  // 上标偏移距离
  _supOffsetDist: number = 6
  // 下划线颜色
  _underlineColor: number = 0xFF191919
  // 下划线样式
  _underlineStyle: TextDecorationStyle = TextDecorationStyle.SOLID

  // codeformat是否用制表符
  _useTab: boolean = false
  // codeformat空格缩进数量，默认4空格
  _indentWidth: number = 4

  public set context(value: Context | undefined) {
    this._context = value
  }

  public set pagePath(value: string) {
    this._pagePath = value
  }

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

  public set openGestureSwipeTest(value: boolean) {
    this._openGestureSwipeTest = value
  }

  public set codeFullScreenIcon(value: Resource | undefined) {
    this._codeFullScreenIcon = value
  }

  public set codeCopyIcon(value: Resource | undefined) {
    this._codeCopyIcon = value
  }

  public set audioIcon(value: Resource | undefined) {
    this._audioIcon = value
  }

  public set videoImage(value: Resource | undefined) {
    this._videoImage = value
  }

  public set playCircleFillIcon(value: Resource | undefined) {
    this._playCircleFillIcon = value
  }

  public set bannerImage(value: Resource | undefined) {
    this._bannerImage = value
  }

  public set imageResource(value: Resource | undefined) {
    this._imageResource = value
  }

  public set videoReleaseImage(value: Resource | undefined) {
    this._videoReleaseImage = value
  }

  public set videoDownloadImage(value: Resource | undefined) {
    this._videoDownloadImage = value
  }

  public set imageDownloadImage(value: Resource | undefined) {
    this._imageDownloadImage = value
  }

  public set isMarkdownParserSync(value: boolean) {
    this._isMarkdownParserSync = value
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

  public set isLinkStyle(value: boolean) {
    this._isLinkStyle = value
  }

  public set isListLinkStyle(value: boolean) {
    this._isListLinkStyle = value
  }

  public set linkColor(value: number) {
    this._linkColor = value
  }

  public set isLinkSize(value: boolean) {
    this._isLinkSize = value
  }

  public set linkSize(value: number) {
    this._linkSize = value
  }

  public set linkLineHeight(value: number) {
    this._linkLineHeight = value
  }

  public set linkBackGroupColor(value: number) {
    this._linkBackGroupColor = value
  }

  public set isLinkUnderlined(value: boolean) {
    this._isLinkUnderlined = value
  }

  public set linkCircleImageBackGroupColor(value: number) {
    this._linkCircleImageBackGroupColor = value
  }

  public set linkCircleImageButtonBackGroupColor(value: number) {
    this._linkCircleImageButtonBackGroupColor = value
  }

  public set linkCircleImageTextSize(value: number) {
    this._linkCircleImageTextSize = value
  }

  public set linkCircleImageTextColor(value: number) {
    this._linkCircleImageTextColor = value
  }

  public set linkCircleImageRadius(value: number) {
    this._linkCircleImageRadius = value
  }

  public set linkCircleImageMargin(value: number) {
    this._linkCircleImageMargin = value
  }

  public set linkRectImageBackGroupColor(value: number) {
    this._linkRectImageBackGroupColor = value
  }

  public set linkRectImageButtonBackGroupColor(value: number) {
    this._linkRectImageButtonBackGroupColor = value
  }

  public set linkRectImageTextSize(value: number) {
    this._linkRectImageTextSize = value
  }

  public set linkRectImageTextColor(value: number) {
    this._linkRectImageTextColor = value
  }

  public set linkRectImageHeight(value: number) {
    this._linkRectImageHeight = value
  }

  public set linkRectImagePadding(value: number) {
    this._linkRectImagePadding = value
  }

  public set linkRectImageRadius(value: number) {
    this._linkRectImageRadius = value
  }

  public set linkRectImageMargin(value: number) {
    this._linkRectImageMargin = value
  }

  public set linkRectToolImageBackGroupColor(value: number) {
    this._linkRectToolImageBackGroupColor = value
  }

  public set linkRectToolImageButtonBackGroupColor(value: number) {
    this._linkRectToolImageButtonBackGroupColor = value
  }

  public set linkRectToolImageTextSize(value: number) {
    this._linkRectToolImageTextSize = value
  }

  public set linkRectToolImageHeight(value: number) {
    this._linkRectToolImageHeight = value
  }

  public set linkRectToolImagePadding(value: number) {
    this._linkRectToolImagePadding = value
  }

  public set linkRectToolImageBorderWidth(value: number) {
    this._linkRectToolImageBorderWidth = value
  }

  public set linkRectToolImageDividingLineWidth(value: number) {
    this._linkRectToolImageDividingLineWidth = value
  }

  public set linkRectToolImageMargin(value: number) {
    this._linkRectToolImageMargin = value
  }

  public set linkRectToolImageLineLeftPadding(value: number) {
    this._linkRectToolImageLineLeftPadding = value
  }

  public set linkRectToolImageLineRightPadding(value: number) {
    this._linkRectToolImageLineRightPadding = value
  }

  public set blockQuoteLeftMargin(value: number) {
    this._blockQuoteLeftMargin = value
  }

  public set blockQuoteRightMargin(value: number) {
    this._blockQuoteRightMargin = value
  }

  public set blockQuoteWidth(value: number) {
    this._blockQuoteWidth = value
  }

  public set blockQuoteColor(value: number) {
    this._blockQuoteColor = value
  }

  public set blockQuoteBackGroupColor(value: number) {
    this._blockQuoteBackGroupColor = value
  }

  public set blockQuoteTopAndBottomMargins(value: number) {
    this._blockQuoteTopAndBottomMargins = value
  }

  public set blockOrderedAndBulletTopAndBottomMargins(value: number) {
    this._blockOrderedAndBulletTopAndBottomMargins = value
  }

  public set blockLeftMargin(value: number) {
    this._blockLeftMargin = value
  }

  public set blockRightMargin(value: number) {
    this._blockRightMargin = value
  }

  public set orderedListItemPrefixBold(value: boolean) {
    this._orderedListItemPrefixBold = value
  }

  public set orderedListItemColor(value: number) {
    this._orderedListItemColor = value
  }

  public set orderedListItemSize(value: number) {
    this._orderedListItemSize = value
  }

  public set orderedListItemLineHeight(value: number) {
    this._orderedListItemLineHeight = value
  }

  public set bulletListItemCircle(value: boolean) {
    this._bulletListItemCircle = value
  }

  public set bulletListItemColor(value: number) {
    this._bulletListItemColor = value
  }

  public set bulletListItemSize(value: number) {
    this._bulletListItemSize = value
  }

  public set bulletListItemLineHeight(value: number) {
    this._bulletListItemLineHeight = value
  }

  public set taskListItemLength(value: number) {
    this._taskListItemLength = value
  }

  public set isCodeFormat(value: boolean) {
    this._isCodeFormat = value
  }

  public set codeTextColor(value: number) {
    this._codeTextColor = value
  }

  public set codeBackgroundColor(value: number) {
    this._codeBackgroundColor = value
  }

  public set codeTextSize(value: number) {
    this._codeTextSize = value
  }

  public set codeTypeface(value: string) {
    this._codeTypeface = value
  }

  public set isCodeBlockParserSync(value: boolean) {
    this._isCodeBlockParserSync = value
  }

  public set codeBlockTextColor(value: number | undefined) {
    this._codeBlockTextColor = value
  }

  public set codeBlockTypeTextColor(value: number | undefined) {
    this._codeBlockTypeTextColor = value
  }

  public set codeBlockTypeTextStr(value: string) {
    this._codeBlockTypeTextStr = value
  }

  public set codeBlockTypeTextPadding(value: number) {
    this._codeBlockTypeTextPadding = value
  }

  public set codeBlockIconTextHide(value: boolean) {
    this._codeBlockIconTextHide = value
  }

  public set codeBlockLineNumberHide(value: boolean) {
    this._codeBlockLineNumberHide = value
  }

  public set codeBlockBackgroundColor(value: number | undefined) {
    this._codeBlockBackgroundColor = value
  }

  public set codeMultilineMargin(value: number) {
    this._codeMultilineMargin = value
  }

  public set codeBlockTypeface(value: string) {
    this._codeBlockTypeface = value
  }

  public set codeBlockTextSize(value: number) {
    this._codeBlockTextSize = value
  }

  public set codeBlockLineHeight(value: number) {
    this._codeBlockLineHeight = value
  }

  public set codeBlockRadius(value: number) {
    this._codeBlockRadius = value
  }

  public set isCodeFullScreen(value: boolean) {
    this._isCodeFullScreen = value
  }

  public set iconWidthAndHeight(value: number) {
    this._iconWidthAndHeight = value
  }

  public set codeListTitleTextSize(value: number) {
    this._codeListTitleTextSize = value
  }

  public set codeListTitleSelectTextSize(value: number) {
    this._codeListTitleSelectTextSize = value
  }

  public set codeListTitleSelectTextColor(value: number) {
    this._codeListTitleSelectTextColor = value
  }

  public set codeListTitleUnSelectTextColor(value: number) {
    this._codeListTitleUnSelectTextColor = value
  }

  public set codeListTitleSelectBackGroupColor(value: number) {
    this._codeListTitleSelectBackGroupColor = value
  }

  public set codeListTitleUnSelectBackGroupColor(value: number) {
    this._codeListTitleUnSelectBackGroupColor = value
  }

  public set isSeparateCodeBlock(value: boolean) {
    this._isSeparateCodeBlock = value
  }

  public set separateCodeBlockWidth(value: number) {
    this._separateCodeBlockWidth = value
  }

  public set separateCodeIsBottom(value: boolean) {
    this._separateCodeIsBottom = value
  }

  public set headingBreakHeight(value: number) {
    this._headingBreakHeight = value
  }

  public set headingTypeface(value: string) {
    this._headingTypeface = value
  }

  public set headingTopMargins(value: number) {
    this._headingTopMargins = value
  }

  public set headingBottomMargins(value: number) {
    this._headingBottomMargins = value
  }

  public set headingTextSize1(value: number) {
    this._headingTextSize1 = value
  }

  public set headingTextSize2(value: number) {
    this._headingTextSize2 = value
  }

  public set headingTextSize3(value: number) {
    this._headingTextSize3 = value
  }

  public set headingTextSize4(value: number) {
    this._headingTextSize4 = value
  }

  public set headingTextSize5(value: number) {
    this._headingTextSize5 = value
  }

  public set headingTextSize6(value: number) {
    this._headingTextSize6 = value
  }

  public set headingTextWordSpace(value: number) {
    this._headingTextWordSpace = value
  }

  public set headingTextLineHeight1(value: number) {
    this._headingTextLineHeight1 = value
  }

  public set headingTextLineHeight2(value: number) {
    this._headingTextLineHeight2 = value
  }

  public set headingTextLineHeight3(value: number) {
    this._headingTextLineHeight3 = value
  }

  public set headingTextLineHeight4(value: number) {
    this._headingTextLineHeight4 = value
  }

  public set headingTextLineHeight5(value: number) {
    this._headingTextLineHeight5 = value
  }

  public set headingTextLineHeight6(value: number) {
    this._headingTextLineHeight6 = value
  }

  public set headingTextColor1(value: number) {
    this._headingTextColor1 = value
  }

  public set headingBreakColor1(value: number) {
    this._headingBreakColor1 = value
  }

  public set headingTextColor2(value: number) {
    this._headingTextColor2 = value
  }

  public set headingBreakColor2(value: number) {
    this._headingBreakColor2 = value
  }

  public set headingTextColor3(value: number) {
    this._headingTextColor3 = value
  }

  public set headingTextColor4(value: number) {
    this._headingTextColor4 = value
  }

  public set headingTextColor5(value: number) {
    this._headingTextColor5 = value
  }

  public set headingTextColor6(value: number) {
    this._headingTextColor6 = value
  }

  public set paragraphTopMargins(value: number) {
    this._paragraphTopMargins = value
  }

  public set paragraphBottomMargins(value: number) {
    this._paragraphBottomMargins = value
  }

  public set paragraphTextSize(value: number) {
    this._paragraphTextSize = value
  }

  public set paragraphTextColor(value: number) {
    this._paragraphTextColor = value
  }

  public set paragraphTextWordSpace(value: number) {
    this._paragraphTextWordSpace = value
  }

  public set paragraphTextLineHeight(value: number) {
    this._paragraphTextLineHeight = value
  }

  public set paragraphTypeface(value: string) {
    this._paragraphTypeface = value
  }

  public set thematicBreakColor(value: number) {
    this._thematicBreakColor = value
  }

  public set thematicBreakHeight(value: number) {
    this._thematicBreakHeight = value
  }

  public set thematicBreakTopMargin(value: number) {
    this._thematicBreakTopMargin = value
  }

  public set thematicBreakBottomMargin(value: number) {
    this._thematicBreakBottomMargin = value
  }

  public set isLineBreak(value: boolean) {
    this._isLineBreak = value
  }

  public set latexDefaultText(value: boolean) {
    this._latexDefaultText = value
  }

  public set latexMathTextSize(value: number) {
    this._latexMathTextSize = value
  }

  public set latexMathBackGroupColor(value: number) {
    this._latexMathBackGroupColor = value
  }

  public set latexMathTextColor(value: number) {
    this._latexMathTextColor = value
  }

  // public set latexMathColorFormat(value: LatexMathColorFormat) {
  //   this._latexMathColorFormat = value
  // }

  public set latexMathBlockCenter(value: boolean) {
    this._latexMathBlockCenter = value
  }

  public set latexMathResStr(value: string) {
    this._latexMathResStr = value
  }

  public set audioShadowColor(value: number) {
    this._audioShadowColor = value
  }

  public set audioBorderColor(value: number) {
    this._audioBorderColor = value
  }

  public set audioBorderWidth(value: number) {
    this._audioBorderWidth = value
  }

  public set audioBorderRadius(value: number) {
    this._audioBorderRadius = value
  }

  public set audioButtonBackgroundColor(value: number) {
    this._audioButtonBackgroundColor = value
  }

  public set audioButtonTextColor(value: number) {
    this._audioButtonTextColor = value
  }

  public set audioButtonTextSize(value: number) {
    this._audioButtonTextSize = value
  }

  public set audioButtonText(value: string) {
    this._audioButtonText = value
  }

  public set audioButtonBorderRadius(value: number) {
    this._audioButtonBorderRadius = value
  }

  public set audioTitleTextSize(value: number) {
    this._audioTitleTextSize = value
  }

  public set audioTitleTextColor(value: number) {
    this._audioTitleTextColor = value
  }

  public set audioTitleTextLineHeight(value: number) {
    this._audioTitleTextLineHeight = value
  }

  public set audioTypeTextSize(value: number) {
    this._audioTypeTextSize = value
  }

  public set audioTypeTextColor(value: number) {
    this._audioTypeTextColor = value
  }

  public set audioTypeTextLineHeight(value: number) {
    this._audioTypeTextLineHeight = value
  }

  public set audioMarginTop(value: number) {
    this._audioMarginTop = value
  }

  public set audioMarginBottom(value: number) {
    this._audioMarginBottom = value
  }

  public set videoBorderRadius(value: number) {
    this._videoBorderRadius = value
  }

  public set videoTimeTextColor(value: number) {
    this._videoTimeTextColor = value
  }

  public set videoTimeTextSize(value: number) {
    this._videoTimeTextSize = value
  }

  public set videoTimeTextMarginRight(value: number) {
    this._videoTimeTextMarginRight = value
  }

  public set videoTimeTextMarginBottom(value: number) {
    this._videoTimeTextMarginBottom = value
  }

  public set videoMarginTop(value: number) {
    this._videoMarginTop = value
  }

  public set videoMarginBottom(value: number) {
    this._videoMarginBottom = value
  }

  public set isVideoBottomLayout(value: boolean) {
    this._isVideoBottomLayout = value
  }

  public set videoReleaseImageWidthHeight(value: number) {
    this._videoReleaseImageWidthHeight = value
  }

  public set videoReleaseWidth(value: number) {
    this._videoReleaseWidth = value
  }

  public set videoReleaseHeight(value: number) {
    this._videoReleaseHeight = value
  }

  public set videoReleaseRadius(value: number) {
    this._videoReleaseRadius = value
  }

  public set videoReleaseText(value: string) {
    this._videoReleaseText = value
  }

  public set videoReleaseTexSize(value: number) {
    this._videoReleaseTexSize = value
  }

  public set videoReleaseTexColor(value: number) {
    this._videoReleaseTexColor = value
  }

  public set videoReleaseBackgroundColor(value: number) {
    this._videoReleaseBackgroundColor = value
  }

  public set videoDownloadImageWidthHeight(value: number) {
    this._videoDownloadImageWidthHeight = value
  }

  public set videoDownloadWidth(value: number) {
    this._videoDownloadWidth = value
  }

  public set videoDownloadHeight(value: number) {
    this._videoDownloadHeight = value
  }

  public set videoDownloadRadius(value: number) {
    this._videoDownloadRadius = value
  }

  public set videoDownloadText(value: string) {
    this._videoDownloadText = value
  }

  public set videoDownloadTexSize(value: number) {
    this._videoDownloadTexSize = value
  }

  public set videoDownloadTexColor(value: number) {
    this._videoDownloadTexColor = value
  }

  public set videoDownloadBackgroundColor(value: number) {
    this._videoDownloadBackgroundColor = value
  }

  public set imageFitType(value: ImageFit) {
    this._imageFitType = value
  }

  public set imageMaximumWidth(value: number) {
    this._imageMaximumWidth = value
  }

  public set imageFixedRatioWidth(value: number | undefined) {
    this._imageFixedRatioWidth = value
  }

  public set imageMaxHeight(value: number | undefined) {
    this._imageMaxHeight = value
  }

  public set imageMaxWidth(value: number | undefined) {
    this._imageMaxWidth = value
  }

  public set imageBorderRadius(value: number) {
    this._imageBorderRadius = value
  }

  public set imageBorderWidth(value: number) {
    this._imageBorderWidth = value
  }

  public set imageBorderColor(value: number) {
    this._imageBorderColor = value
  }

  public set isAutoResize(value: boolean) {
    this._isAutoResize = value
  }

  public set imageMarginTop(value: number) {
    this._imageMarginTop = value
  }

  public set imageMarginBottom(value: number) {
    this._imageMarginBottom = value
  }

  public set isImageDownload(value: boolean) {
    this._isImageDownload = value
  }

  public set isImageMixedLayout(value: boolean) {
    this._isImageMixedLayout = value
  }

  public set imageDownloadImageWidthHeight(value: number) {
    this._imageDownloadImageWidthHeight = value
  }

  public set imageDownloadWidth(value: number) {
    this._imageDownloadWidth = value
  }

  public set imageDownloadHeight(value: number) {
    this._imageDownloadHeight = value
  }

  public set imageDownloadRadius(value: number) {
    this._imageDownloadRadius = value
  }

  public set imageDownloadText(value: string) {
    this._imageDownloadText = value
  }

  public set imageDownloadTexSize(value: number) {
    this._imageDownloadTexSize = value
  }

  public set imageDownloadTexColor(value: number) {
    this._imageDownloadTexColor = value
  }

  public set imageDownloadBackgroundColor(value: number) {
    this._imageDownloadBackgroundColor = value
  }

  public set tableCellPadding(value: number) {
    this._tableCellPadding = value
  }

  public set tableBorderColor(value: number) {
    this._tableBorderColor = value
  }

  public set tableBorderWidth(value: number) {
    this._tableBorderWidth = value
  }

  public set tableOddRowBackgroundColor(value: number) {
    this._tableOddRowBackgroundColor = value
  }

  public set tableEvenRowBackgroundColor(value: number) {
    this._tableEvenRowBackgroundColor = value
  }

  public set tableHeaderRowBackgroundColor(value: number) {
    this._tableHeaderRowBackgroundColor = value
  }

  public set tableTitleTextColor(value: number) {
    this._tableTitleTextColor = value
  }

  public set tableTitleTextSize(value: number) {
    this._tableTitleTextSize = value
  }

  public set tableTitleLineHeight(value: number) {
    this._tableTitleLineHeight = value
  }

  public set tableContentTextColor(value: number) {
    this._tableContentTextColor = value
  }

  public set tableContentTextSize(value: number) {
    this._tableContentTextSize = value
  }

  public set tableTextLineHeight(value: number) {
    this._tableTextLineHeight = value
  }

  public set tableRadius(value: number) {
    this._tableRadius = value
  }

  public set tableMinTextWidth(value: number) {
    this._tableMinTextWidth = value
  }

  public set tableMaxTextWidth(value: number) {
    this._tableMaxTextWidth = value
  }

  public set tableFirstColumnBold(value: boolean) {
    this._tableFirstColumnBold = value
  }

  public set tableScrollBarShow(value: boolean) {
    this._tableScrollBarShow = value
  }

  public set tableScrollBarColor(value: number) {
    this._tableScrollBarColor = value
  }

  public set isDark(value: boolean) {
    this._isDark = value
  }

  public set strikethroughColor(value: number) {
    this._strikethroughColor = value
  }

  public set strikethroughStyle(value: TextDecorationStyle) {
    this._strikethroughStyle = value
  }

  public set descListTermAndDefMargins(value: number) {
    this._descListTermAndDefMargins = value
  }

  public set descListDefIndentation(value: number) {
    this._descListDefIndentation = value
  }

  public set descListDefMargins(value: number) {
    this._descListDefMargins = value
  }

  public set subTextColor(value: number) {
    this._subTextColor = value
  }

  public set subTextSize(value: number) {
    this._subTextSize = value
  }

  public set subOffsetDist(value: number) {
    this._subOffsetDist = value
  }

  public set supTextColor(value: number) {
    this._supTextColor = value
  }

  public set supTextSize(value: number) {
    this._supTextSize = value
  }

  public set supOffsetDist(value: number) {
    this._supOffsetDist = value
  }

  public set underlineColor(value: number) {
    this._underlineColor = value
  }

  public set underlineStyle(value: TextDecorationStyle) {
    this._underlineStyle = value
  }

  public set openGestureSwipe(value: boolean) {
    this._openGestureSwipe = value
  }

  public set useTab(value: boolean) {
    this._useTab = value
  }

  public set indentWidth(value: number) {
    this._indentWidth = value
  }

  constructor() {
  }
}