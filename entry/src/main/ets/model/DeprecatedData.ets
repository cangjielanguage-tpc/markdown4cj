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
  _codeBlockTextColor: ResourceColor | undefined = undefined
  // 代码块代码类型文本颜色
  _codeBlockTypeTextColor: ResourceColor | undefined = undefined
  // 代码块代码类型文本
  _codeBlockTypeTextStr: string = ""
  // 代码类型和代码块距离
  _codeBlockTypeTextPadding: number = 0
  // 代码块复制、全屏图片文字是否显示
  _codeBlockIconTextHide: boolean = true
  // 代码块代码行号是否显示
  _codeBlockLineNumberHide: boolean = true
  // 代码块背景颜色
  _codeBlockBackgroundColor: ResourceColor | undefined = undefined
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

  constructor() {
  }
}