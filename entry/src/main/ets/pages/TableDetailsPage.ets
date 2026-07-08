import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  MarkdownScrollController,
  // MarkdownScroller,
  MarkdownTheme,
  TableTheme} from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { TableData } from '../model/TableData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct TableDetailsPage {
  // ---------- 通用
  scroller: Scroller = new Scroller() // 滑动控制器
  markdownScroller: Scroller = new Scroller() // Markdown的控制器
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  @StorageProp('currentColorMode') // 深浅色模式
  currentColorMode: ConfigurationConstant.ColorMode = ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT
  @State // 文件文本
  fileStr: string = ""
  @State // markdown文本
  content: string = ""
  @State // 是否全量加载Markdown文本
  isFull: boolean = true
  @State // 是否增量解析Markdown文本
  incrementalAnalysis: boolean = false
  @State // 是否启用解析节流
  enableParseThrottle: boolean = false
  @State // 解析节流间隔（ms）
  parseThrottleMs: number = 200
  @State // 增量加载每次间隔时间
  time: number = 50
  @State // 增量每次增量文本数量
  textNumber: number = 10
  @State // 是否同步解析Markdown文本
  isMarkdownParserSync: boolean = false
  @State // 是否打开长按复制粘贴效果
  isOnCopy: boolean = false
  @State // Markdown块上边距
  blockMarginTop: number = 8
  @State // Markdown块右边距
  blockMarginRight: number = 8
  @State // Markdown块下边距
  blockMarginBottom: number = 8
  @State // Markdown块左边距
  blockMarginLeft: number = 8
  @State // Markdown块间距样式
  markdownBlockSpacing: number = 8
  @State // 是否换行
  isLineBreak: boolean = false
  @State // 全局背景色
  globalBackgroundColor: ResourceColor | undefined = undefined
  @State // 是否允许markdown控件自身响应滑动
  openGestureSwipe: boolean = false
  @State // 是否开启响应滑动测试
  openGestureSwipeTest: boolean = false
  @State // 流式输入是否输入结束(true:结束输入,false:持续输入)
  isInputEnded: boolean = false

  // ---------- 专有
  @State // 表格标题背景颜色
  tableTitleBackgroundColor: ResourceColor | undefined = undefined
  @State // 表格内容奇数行背景颜色
  tableContentOddRowBackgroundColor: ResourceColor | undefined = undefined
  @State // 表格内容偶数行背景颜色
  tableContentEvenRowBackgroundColor: ResourceColor | undefined = undefined
  @State // 表格上外边距
  tableMarginTop: Length = 0.0
  @State // 表格右外边距
  tableMarginRight: Length = 0.0
  @State // 表格下外边距
  tableMarginBottom: Length = 0.0
  @State // 表格左外边距
  tableMarginLeft: Length = 0.0
  @State // 表格上内边距
  tablePaddingTop: Length = 0.0
  @State // 表格右内边距
  tablePaddingRight: Length = 0.0
  @State // 表格下内边距
  tablePaddingBottom: Length = 0.0
  @State // 表格左内边距
  tablePaddingLeft: Length = 0.0
  @State // 表格内容上内边距
  tableCellPaddingTop: Length = 4.0
  @State // 表格内容右内边距
  tableCellPaddingRight: Length = 4.0
  @State // 表格内容下内边距
  tableCellPaddingBottom: Length = 4.0
  @State // 表格内容左内边距
  tableCellPaddingLeft: Length = 4.0
  @State // 表格边框样式
  tableBorderStyle: BorderStyle = BorderStyle.Solid
  @State // 表格边框宽度
  tableBorderWidth: Length = 1.0
  @State // 表格边框颜色
  tableBorderColor: ResourceColor | undefined = undefined
  @State // 表格边框左上圆角
  tableRadiusTopLeft: Length = 5.0
  @State // 表格边框右上圆角
  tableRadiusTopRight: Length = 5.0
  @State // 表格边框左下圆角
  tableRadiusBottomLeft: Length = 5.0
  @State // 表格边框右下圆角
  tableRadiusBottomRight: Length = 5.0
  @State // 表格滚动条状态
  tableScrollBarState: BarState = BarState.Off
  @State // 表格滚动条颜色
  tableScrollBarColor: ResourceColor | undefined = undefined
  @State // 表格一格最小宽度
  tableMinCellWidth: Length = 50.0
  @State // 表格一格最大宽度
  tableMaxCellWidth: Length = 300.0
  @State // 表格第一列是否加粗
  tableFirstColumnIsBold: boolean = false
  @State // 表格标题文本颜色
  tableTitleTextFontColor: ResourceColor | undefined = undefined
  @State // 表格标题文本尺寸
  tableTitleTextFontSize: number | string | Resource = 14.0
  @State // 表格标题文本字体样式
  tableTitleTextFontStyle: FontStyle = FontStyle.Normal
  @State // 表格标题文本字体粗细
  tableTitleTextFontWeight: number | FontWeight = FontWeight.Bold
  @State // 表格标题文本字体
  tableTitleTextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 表格标题文本行高
  tableTitleTextLineHeight: number | string | Resource = 22.0
  @State // 表格标题文本字符间距
  tableTitleTextLetterSpacing: number = 0.0
  @State // 表格内容文本颜色
  tableContentTextFontColor: ResourceColor | undefined = undefined
  @State // 表格内容文本尺寸
  tableContentTextFontSize: number | string | Resource = 14.0
  @State // 表格内容文本字体样式
  tableContentTextFontStyle: FontStyle = FontStyle.Normal
  @State // 表格内容文本字体粗细
  tableContentTextFontWeight: number | FontWeight = FontWeight.Normal
  @State // 表格内容文本字体
  tableContentTextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 表格内容文本行高
  tableContentTextLineHeight: number | string | Resource = 22.0
  @State // 表格内容文本字符间距
  tableContentTextLetterSpacing: number = 0.0

  @State tableStickyHeader: boolean = false // 表格标题行是否吸顶
  @State
  tableHeaderIsShow: boolean = false // 表格头部是否显示

  @State // 表头标题文本颜色
  tableHeadTitleTextFontColor: ResourceColor | undefined = undefined
  @State // 表头标题文本尺寸
  tableHeadTitleTextFontSize: number | string | Resource = 14.0
  @State // 表头标题文本字体样式
  tableHeadTitleTextFontStyle: FontStyle = FontStyle.Normal
  @State // 表头标题文本字体粗细
  tableHeadTitleTextFontWeight: number | FontWeight = FontWeight.Bold
  @State // 表头标题文本字体
  tableHeadTitleTextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 表头标题文本行高
  tableHeadTitleTextLineHeight: number | string | Resource = 22.0
  @State // 表头标题文本左边距
  tableHeadTitleTextMarginLeft: Length = 8.0 // 表格头标题类型文本左边距

  @State // 表头复制文本颜色
  tableHeadCopyTextFontColor: ResourceColor | undefined = undefined
  @State // 表头复制文本尺寸
  tableHeadCopyTextFontSize: number | string | Resource = 14.0
  @State // 表头复制文本字体样式
  tableHeadCopyTextFontStyle: FontStyle = FontStyle.Normal
  @State // 表头复制文本字体粗细
  tableHeadCopyTextFontWeight: number | FontWeight = FontWeight.Bold
  @State // 表头复制文本字体
  tableHeadCopyTextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 表头复制文本行高
  tableHeadCopyTextLineHeight: number | string | Resource = 22.0
  @State // 表头复制文本是否显示
  tableHeadCopyTextIsShow: boolean = false
  @State // 表头复制按钮是否显示
  tableHeadCopyButtonIsShow: boolean = true
  @State // 表格头复制图标
  tableHeadCopyIcon: boolean = true
  @State // 表格头复制图标宽度
  tableHeadCopyIconWidth: number = 24
  @State // 表格头复制图标高度
  tableHeadCopyIconHeight: number = 24
  @State // 表格头复制图标文本间距
  tableHeadCopyTextSpacing: number = 5

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  private mdScrollController: MarkdownScrollController = new MarkdownScrollController()
  private outerScroller: Scroller = new Scroller()
  private contentHeight: number = 0 // Scroll 内容高度（Column 高度）
  private viewportHeight: number = 0 // Scroll 视口高度

  aboutToAppear(): void {
    try {
      let tableData: TableData = router.getParams() as TableData
      this.fileStr = getFileContextStr(tableData._pagePath)
      // ---------- 通用
      this.isFull = tableData._isFull
      this.incrementalAnalysis = tableData._incrementalAnalysis
      this.enableParseThrottle = tableData._enableParseThrottle
      this.parseThrottleMs = tableData._parseThrottleMs
      this.time = tableData._time
      this.textNumber = tableData._textNumber
      this.isMarkdownParserSync = tableData._isMarkdownParserSync
      this.isOnCopy = tableData._isOnCopy
      this.blockMarginTop = tableData._blockMarginTop
      this.blockMarginRight = tableData._blockMarginRight
      this.blockMarginBottom = tableData._blockMarginBottom
      this.blockMarginLeft = tableData._blockMarginLeft
      this.markdownBlockSpacing = tableData._markdownBlockSpacing
      this.isLineBreak = tableData._isLineBreak
      this.globalBackgroundColor = tableData._backgroundColor
      this.openGestureSwipe = tableData._openGestureSwipe
      this.openGestureSwipeTest = tableData._openGestureSwipeTest
      // ---------- 专有
      this.tableTitleBackgroundColor = tableData._tableTitleBackgroundColor
      this.tableContentOddRowBackgroundColor = tableData._tableContentOddRowBackgroundColor
      this.tableContentEvenRowBackgroundColor = tableData._tableContentEvenRowBackgroundColor
      this.tableMarginTop = tableData._tableMarginTop
      this.tableMarginRight = tableData._tableMarginRight
      this.tableMarginBottom = tableData._tableMarginBottom
      this.tableMarginLeft = tableData._tableMarginLeft
      this.tablePaddingTop = tableData._tablePaddingTop
      this.tablePaddingRight = tableData._tablePaddingRight
      this.tablePaddingBottom = tableData._tablePaddingBottom
      this.tablePaddingLeft = tableData._tablePaddingLeft
      this.tableCellPaddingTop = tableData._tableCellPaddingTop
      this.tableCellPaddingRight = tableData._tableCellPaddingRight
      this.tableCellPaddingBottom = tableData._tableCellPaddingBottom
      this.tableCellPaddingLeft = tableData._tableCellPaddingLeft
      this.tableBorderStyle = tableData._tableBorderStyle
      this.tableBorderWidth = tableData._tableBorderWidth
      this.tableBorderColor = tableData._tableBorderColor
      this.tableRadiusTopLeft = tableData._tableRadiusTopLeft
      this.tableRadiusTopRight = tableData._tableRadiusTopRight
      this.tableRadiusBottomLeft = tableData._tableRadiusBottomLeft
      this.tableRadiusBottomRight = tableData._tableRadiusBottomRight
      this.tableScrollBarState = tableData._tableScrollBarState
      this.tableScrollBarColor = tableData._tableScrollBarColor
      this.tableMinCellWidth = tableData._tableMinCellWidth
      this.tableMaxCellWidth = tableData._tableMaxCellWidth
      this.tableFirstColumnIsBold = tableData._tableFirstColumnIsBold
      this.tableTitleTextFontColor = tableData._tableTitleTextFontColor
      this.tableTitleTextFontSize = tableData._tableTitleTextFontSize
      this.tableTitleTextFontStyle = tableData._tableTitleTextFontStyle
      this.tableTitleTextFontWeight = tableData._tableTitleTextFontWeight
      this.tableTitleTextFontFamily = tableData._tableTitleTextFontFamily
      this.tableTitleTextLineHeight = tableData._tableTitleTextLineHeight
      this.tableTitleTextLetterSpacing = tableData._tableTitleTextLetterSpacing
      this.tableContentTextFontColor = tableData._tableContentTextFontColor
      this.tableContentTextFontSize = tableData._tableContentTextFontSize
      this.tableContentTextFontStyle = tableData._tableContentTextFontStyle
      this.tableContentTextFontWeight = tableData._tableContentTextFontWeight
      this.tableContentTextFontFamily = tableData._tableContentTextFontFamily
      this.tableContentTextLineHeight = tableData._tableContentTextLineHeight
      this.tableContentTextLetterSpacing = tableData._tableContentTextLetterSpacing
      this.tableStickyHeader = tableData._tableStickyHeader
      this.tableHeaderIsShow = tableData._tableHeaderIsShow
      this.tableHeadTitleTextFontColor = tableData._tableHeaderTitleTextFontColor
      this.tableHeadTitleTextFontSize = tableData._tableHeaderTitleTextFontSize
      this.tableHeadTitleTextFontStyle = tableData._tableHeaderTitleTextFontStyle
      this.tableHeadTitleTextFontWeight = tableData._tableHeaderTitleTextFontWeight
      this.tableHeadTitleTextFontFamily = tableData._tableHeaderTitleTextFontFamily
      this.tableHeadTitleTextLineHeight = tableData._tableHeaderTitleTextLineHeight
      this.tableHeadTitleTextMarginLeft = tableData._tableHeaderTitleTextMarginLeft
      this.tableHeadCopyTextFontColor = tableData._tableHeaderCopyTextFontColor
      this.tableHeadCopyTextFontSize = tableData._tableHeaderCopyTextFontSize
      this.tableHeadCopyTextFontStyle = tableData._tableHeaderCopyTextFontStyle
      this.tableHeadCopyTextFontWeight = tableData._tableHeaderCopyTextFontWeight
      this.tableHeadCopyTextFontFamily = tableData._tableHeaderCopyTextFontFamily
      this.tableHeadCopyTextLineHeight = tableData._tableHeaderCopyTextLineHeight
      this.tableHeadCopyTextIsShow = tableData._tableHeaderCopyTextIsShow
      this.tableHeadCopyButtonIsShow = tableData._tableHeaderCopyButtonIsShow
      this.tableHeadCopyIcon = tableData._tableHeadCopyIcon
      this.tableHeadCopyIconWidth = tableData._tableHeadCopyIconWidth
      this.tableHeadCopyIconHeight = tableData._tableHeadCopyIconHeight
      this.tableHeadCopyTextSpacing = tableData._tableHeadCopyTextSpacing
    } catch (e) {
    }
    this.markdownPlugin = this.setPlugin()
    this.markdownTheme = this.setMarkdownTheme()
    this.markdownConfiguration = this.setMarkdownConfig()
    this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)

    if (this.isFull) {
      this.isInputEnded = true
      this.content = this.fileStr
    } else {
      this.isInputEnded = false
      let index = 0
      let id = setInterval(() => {
        this.content = this.content + this.fileStr.substring(this.content.length, index)
        this.scroller.scrollEdge(Edge.Bottom)
        if (index >= this.fileStr.length) {
          this.isInputEnded = true
          clearInterval(id)
        }
        if (this.fileStr.length > index + this.textNumber) {
          index = index + this.textNumber
        } else {
          index = this.fileStr.length
        }
      }, this.time)
    }
  }

  build() {
    Column() {
      titleComponent(
        "表格测试用例",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Scroll(this.scroller) {
        if (this.openGestureSwipeTest) { // 允许滑动响应测试,生效前提高度设置为100%
          Column() {
            CJMarkdown({
              content: this.content,
              // isInputEnded: this.isInputEnded,
              // incrementalAnalysis: this.incrementalAnalysis,
              scroller: this.markdownScroller,
              config: this.markdownConfiguration,
              plugin: this.markdownPlugin
            })
          }.height("100%")
        } else {
          Column() {
            CJMarkdown({
              content: this.content,
              // isInputEnded: this.isInputEnded,
              scroller: this.markdownScroller,
              config: this.markdownConfiguration,
              plugin: this.markdownPlugin,
              // scroller: this.scroller,
              scrollController: this.mdScrollController  // ← 传入控制器
            })
          }
          .onAreaChange((oldValue: Area, newValue: Area) => {
            this.contentHeight = newValue.height as number
          })
        }
      }
      .align(Alignment.TopStart)
      .edgeEffect(EdgeEffect.None) // 禁用弹跳，防止 overscroll 时 header 跟随内容弹跳
      .onAreaChange((oldValue: Area, newValue: Area) => {
        this.viewportHeight = newValue.height as number
      })
      .onScrollFrameBegin((offset: number, scrollState: ScrollState) => {
        // 滚动前预测（消除一帧延迟，同帧渲染）
        const currentY = this.scroller.currentOffset().yOffset
        let newY = currentY + offset
        // clamp 到有效范围 [0, maxScrollY]，防止边界过冲
        if (newY < 0) newY = 0
        const maxScrollY = this.contentHeight > this.viewportHeight
          ? this.contentHeight - this.viewportHeight : 0
        if (maxScrollY > 0 && newY > maxScrollY) {
          newY = maxScrollY
        }
        this.mdScrollController.notifyScrollY(newY)
        return { offsetRemain: offset }
      })
      .onDidScroll((xOffset: number, yOffset: number, scrollState: ScrollState) => {
        // 滚动后用实际位置修正（解决预测偏差）
        this.mdScrollController.notifyScrollY(this.scroller.currentOffset().yOffset)
      })
      .layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    config.setTableCopyCallback(this.tableCopyCallBack)
    return config
  }


  tableCopyCallBack(tableStr: string): void {
    hilog.error(1, "copyTable", `---tableStr = ${tableStr}`)
  }

  setMarkdownTheme(): MarkdownTheme {
    let theme = new MarkdownTheme()
    if (this.currentColorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
      theme.setDefaultTheme()
    } else {
      theme.setDarculaTheme()
    }
    // ---------- 通用 - Global
    let globalTheme: GlobalTheme = new GlobalTheme()
    if (this.globalBackgroundColor !== undefined) {
      globalTheme.setBackgroundColor(this.globalBackgroundColor)
    }
    globalTheme.setGlobalMargin({top: this.blockMarginTop, right: this.blockMarginRight, bottom: this.blockMarginBottom, left: this.blockMarginLeft})
    globalTheme.setBlockSpacing(this.markdownBlockSpacing)
    globalTheme.setIsLineBreak(this.isLineBreak)
    globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    globalTheme.setIsOnCopy(this.isOnCopy)
    globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
    globalTheme.setEnableParseThrottle(this.enableParseThrottle)
    globalTheme.setParseThrottleMs(this.parseThrottleMs)
    theme.setGlobalTheme(globalTheme)
    
    // ---------- 专有 - Table
    let tableTheme = new TableTheme()

    if (this.tableTitleBackgroundColor !== undefined) {
      tableTheme.setTableTitleBackgroundColor(this.tableTitleBackgroundColor)
    }
    if (this.tableContentOddRowBackgroundColor !== undefined) {
      tableTheme.setTableContentOddRowBackgroundColor(this.tableContentOddRowBackgroundColor)
    }
    if (this.tableContentEvenRowBackgroundColor !== undefined) {
      tableTheme.setTableContentEvenRowBackgroundColor(this.tableContentEvenRowBackgroundColor)
    }
    tableTheme.setTableMargin({top: this.tableMarginTop, right: this.tableMarginRight, bottom: this.tableMarginBottom, left: this.tableMarginLeft})
    tableTheme.setTablePadding({top: this.tablePaddingTop, right: this.tablePaddingRight, bottom: this.tablePaddingBottom, left: this.tablePaddingLeft})
    tableTheme.setTableCellPadding({top: this.tableCellPaddingTop, right: this.tableCellPaddingRight, bottom: this.tableCellPaddingBottom, left: this.tableCellPaddingLeft})
    tableTheme.setTableBorderStyle(this.tableBorderStyle)
    tableTheme.setTableBorderWidth(this.tableBorderWidth)
    if (this.tableBorderColor !== undefined) {
      tableTheme.setTableBorderColor(this.tableBorderColor)
    }
    tableTheme.setTableRadius({topLeft: this.tableRadiusTopLeft, topRight: this.tableRadiusTopRight, bottomLeft: this.tableRadiusBottomLeft, bottomRight: this.tableRadiusBottomRight})
    tableTheme.setTableScrollBarState(this.tableScrollBarState)
    if (this.tableScrollBarColor !== undefined) {
      tableTheme.setTableScrollBarColor(this.tableScrollBarColor.toString())
    }
    tableTheme.setTableMinCellWidth(this.tableMinCellWidth)
    tableTheme.setTableMaxCellWidth(this.tableMaxCellWidth)
    tableTheme.setTableFirstColumnIsBold(this.tableFirstColumnIsBold)
    if (this.tableTitleTextFontColor !== undefined) {
      tableTheme.setTableTitleTextFontColor(this.tableTitleTextFontColor)
    }
    tableTheme.setTableTitleTextFontSize(this.tableTitleTextFontSize)
    tableTheme.setTableTitleTextFontStyle(this.tableTitleTextFontStyle)
    tableTheme.setTableTitleTextFontWeight(this.tableTitleTextFontWeight)
    tableTheme.setTableTitleTextFontFamily(this.tableTitleTextFontFamily)
    tableTheme.setTableTitleTextLineHeight(this.tableTitleTextLineHeight)
    tableTheme.setTableTitleTextLetterSpacing(this.tableTitleTextLetterSpacing)
    if (this.tableContentTextFontColor !== undefined) {
      tableTheme.setTableContentTextFontColor(this.tableContentTextFontColor)
    }
    tableTheme.setTableContentTextFontSize(this.tableContentTextFontSize)
    tableTheme.setTableContentTextFontStyle(this.tableContentTextFontStyle)
    tableTheme.setTableContentTextFontWeight(this.tableContentTextFontWeight)
    tableTheme.setTableContentTextFontFamily(this.tableContentTextFontFamily)
    tableTheme.setTableContentTextLineHeight(this.tableContentTextLineHeight)
    tableTheme.setTableContentTextLetterSpacing(this.tableContentTextLetterSpacing)

    tableTheme.setTableStickyHeader(this.tableStickyHeader)
    tableTheme.setTableHeadIsShow(this.tableHeaderIsShow)
    tableTheme.setTableHeadTitleTextFontColor(this.tableHeadTitleTextFontColor)
    tableTheme.setTableHeadTitleTextFontSize(this.tableHeadTitleTextFontSize)
    tableTheme.setTableHeadTitleTextFontFamily(this.tableHeadTitleTextFontFamily)
    tableTheme.setTableHeadTitleTextFontWeight(this.tableHeadTitleTextFontWeight)
    tableTheme.setTableHeadTitleTextFontStyle(this.tableHeadTitleTextFontStyle)
    tableTheme.setTableHeadTitleTextLineHeight(this.tableHeadTitleTextLineHeight)
    tableTheme.setTableHeadTitleTextMarginLeft(this.tableHeadTitleTextMarginLeft)
    tableTheme.setTableHeadCopyTextFontColor(this.tableHeadCopyTextFontColor)
    tableTheme.setTableHeadCopyTextFontSize(this.tableHeadCopyTextFontSize)
    tableTheme.setTableHeadCopyTextFontFamily(this.tableHeadCopyTextFontFamily)
    tableTheme.setTableHeadCopyTextFontWeight(this.tableHeadCopyTextFontWeight)
    tableTheme.setTableHeadCopyTextFontStyle(this.tableHeadCopyTextFontStyle)
    tableTheme.setTableHeadCopyTextLineHeight(this.tableHeadCopyTextLineHeight)
    tableTheme.setTableHeadCopyTextIsShow(this.tableHeadCopyTextIsShow)
    tableTheme.setTableHeadCopyButtonIsShow(this.tableHeadCopyButtonIsShow)
    tableTheme.setTableHeadCopyIcon(this.tableHeadCopyIcon ? $r('app.media.startIcon') : undefined)
    tableTheme.setTableHeadCopyIconWidth(this.tableHeadCopyIconWidth)
    tableTheme.setTableHeadCopyIconHeight(this.tableHeadCopyIconHeight)
    tableTheme.setTableHeadCopyTextSpacing(this.tableHeadCopyTextSpacing)
    theme.setTableTheme(tableTheme)
    
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsLatexMathPlugin(true) // 数学公式插件
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    plugin.setIsHtmlPlugin(true) // HTML插件
    return plugin
  }
}
