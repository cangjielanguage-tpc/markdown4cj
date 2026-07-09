import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseTabComponent } from '../component/BaseTabComponent'
import { TypeEnum } from '../model/TypeEnum'
import {
  booleanListGeneralData,
  borderStyleListGeneraData,
  colorListGeneralData,
  fontStyleListGeneraData,
  fontWeightListGeneraData,
  lineOrBorderWidthListGeneraData,
  marginListGeneralData,
  radiusListGeneraData,
  textLineHeightListGeneralData,
  textNumberListGeneralData,
  textSizeListGeneralData,
  textTypefaceListGeneralData,
  textWordSpaceListGeneralData,
  widthOrHeightListGeneralData,
  timeListGeneralData
} from '../model/GeneralData'
import { TableData } from '../model/TableData'

@Entry
@Component
struct TablePage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "006_Table"
  @State // rawfile文件夹列表
  folderList: Array<string> = new Array<string>()
  // 是否全量加载Markdown文本列表
  isFullList: Array<boolean> = booleanListGeneralData
  @State // 是否全量加载Markdown文本
  isFull: boolean = true
  // 是否增量解析Markdown文本列表
  incrementalAnalysisList: Array<boolean> = booleanListGeneralData
  @State // 是否增量解析Markdown文本
  incrementalAnalysis: boolean = false
  // 是否启用解析节流列表
  enableParseThrottleList: Array<boolean> = booleanListGeneralData
  @State // 是否启用解析节流
  enableParseThrottle: boolean = false
  // 解析节流间隔列表
  parseThrottleMsList: Array<number> = timeListGeneralData
  @State // 解析节流间隔（ms）
  parseThrottleMs: number = 200
  // 增量加载每次间隔时间列表
  timeList: Array<number> = timeListGeneralData
  @State // 增量加载每次间隔时间
  time: number = 50
  // 增量每次增量文本数量列表
  textNumberList: Array<number> = textNumberListGeneralData
  @State // 增量每次增量文本数量
  textNumber: number = 10
  // 是否同步解析Markdown文本列表
  isMarkdownParserSyncList: Array<boolean> = booleanListGeneralData
  @State // 是否同步解析Markdown文本
  isMarkdownParserSync: boolean = false
  // 是否打开长按复制粘贴效果列表
  isOnCopyList: Array<boolean> = booleanListGeneralData
  @State // 是否打开长按复制粘贴效果
  isOnCopy: boolean = false
  // markdown全局上外边距列表
  blockMarginTopList: Array<number> = marginListGeneralData
  @State // markdown全局上外边距
  blockMarginTop: number = 0
  // markdown全局右外边距列表
  blockMarginRightList: Array<number> = marginListGeneralData
  @State // markdown全局右外边距
  blockMarginRight: number = 0
  // markdown全局下外边距列表
  blockMarginBottomList: Array<number> = marginListGeneralData
  @State // markdown全局下外边距
  blockMarginBottom: number = 0
  // markdown全局左外边距列表
  blockMarginLeftList: Array<number> = marginListGeneralData
  @State // markdown全局左外边距
  blockMarginLeft: number = 0
  // 模块间上下间距列表
  markdownBlockSpacingList: Array<number> = marginListGeneralData
  @State // 模块间上下间距
  markdownBlockSpacing: number = 8
  // 软换行是否换行列表
  isLineBreakList: Array<boolean> = booleanListGeneralData
  @State // 软换行是否换行
  isLineBreak: boolean = false
  // 背景颜色列表
  globalBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 背景颜色
  globalBackgroundColor: ResourceColor | undefined = undefined
  // 是否允许markdown控件自身响应滑动列表
  openGestureSwipeList: Array<boolean> = booleanListGeneralData
  @State // 是否允许markdown控件自身响应滑动
  openGestureSwipe: boolean = false
  // 是否开启响应滑动测试列表
  openGestureSwipeTestList: Array<boolean> = booleanListGeneralData
  @State // 是否开启响应滑动测试
  openGestureSwipeTest: boolean = false
  // ---------------- 专有

  // 表格标题背景颜色列表
  tableTitleBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 表格标题背景颜色
  tableTitleBackgroundColor: ResourceColor | undefined = undefined
  // 表格内容奇数行背景颜色列表
  tableContentOddRowBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 表格内容奇数行背景颜色
  tableContentOddRowBackgroundColor: ResourceColor | undefined = undefined
  // 表格内容偶数行背景颜色列表
  tableContentEvenRowBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 表格内容偶数行背景颜色
  tableContentEvenRowBackgroundColor: ResourceColor | undefined = undefined
  // 表格上外边距列表
  tableMarginTopList: Array<number> = marginListGeneralData
  @State // 表格上外边距
  tableMarginTop: number = 0
  // 表格右外边距列表
  tableMarginRightList: Array<number> = marginListGeneralData
  @State // 表格右外边距
  tableMarginRight: number = 0
  // 表格下外边距列表
  tableMarginBottomList: Array<number> = marginListGeneralData
  @State // 表格下外边距
  tableMarginBottom: number = 0
  // 表格左外边距列表
  tableMarginLeftList: Array<number> = marginListGeneralData
  @State // 表格左外边距
  tableMarginLeft: number = 0
  // 表格上内边距列表
  tablePaddingTopList: Array<number> = marginListGeneralData
  @State // 表格上内边距
  tablePaddingTop: number = 0
  // 表格右内边距列表
  tablePaddingRightList: Array<number> = marginListGeneralData
  @State // 表格右内边距
  tablePaddingRight: number = 0
  // 表格下内边距列表
  tablePaddingBottomList: Array<number> = marginListGeneralData
  @State // 表格下内边距
  tablePaddingBottom: number = 0
  // 表格左内边距列表
  tablePaddingLeftList: Array<number> = marginListGeneralData
  @State // 表格左内边距
  tablePaddingLeft: number = 0
  // 表格内容上内边距列表
  tableCellPaddingTopList: Array<number> = marginListGeneralData
  @State // 表格内容上内边距
  tableCellPaddingTop: number = 4
  // 表格内容右内边距列表
  tableCellPaddingRightList: Array<number> = marginListGeneralData
  @State // 表格内容右内边距
  tableCellPaddingRight: number = 4
  // 表格内容下内边距列表
  tableCellPaddingBottomList: Array<number> = marginListGeneralData
  @State // 表格内容下内边距
  tableCellPaddingBottom: number = 4
  // 表格内容左内边距列表
  tableCellPaddingLeftList: Array<number> = marginListGeneralData
  @State // 表格内容左内边距
  tableCellPaddingLeft: number = 4
  // 表格边框样式列表
  tableBorderStyleList: Array<BorderStyle> = borderStyleListGeneraData
  @State // 表格边框样式
  tableBorderStyle: BorderStyle = BorderStyle.Solid
  // 表格边框宽度列表
  tableBorderWidthList: Array<number> = lineOrBorderWidthListGeneraData
  @State // 表格边框宽度
  tableBorderWidth: number = 1
  // 表格边框颜色列表
  tableBorderColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 表格边框颜色
  tableBorderColor: ResourceColor | undefined = undefined
  // 表格边框左上圆角列表
  tableRadiusTopLeftList: Array<number> = radiusListGeneraData
  @State // 表格边框左上圆角
  tableRadiusTopLeft: number = 5
  // 表格边框右上圆角列表
  tableRadiusTopRightList: Array<number> = radiusListGeneraData
  @State // 表格边框右上圆角
  tableRadiusTopRight: number = 5
  // 表格边框左下圆角列表
  tableRadiusBottomLeftList: Array<number> = radiusListGeneraData
  @State // 表格边框左下圆角
  tableRadiusBottomLeft: number = 5
  // 表格边框右下圆角列表
  tableRadiusBottomRightList: Array<number> = radiusListGeneraData
  @State // 表格边框右下圆角
  tableRadiusBottomRight: number = 5
  // 表格滚动条状态列表
  tableScrollBarStateList: Array<BarState> = [BarState.Off, BarState.On, BarState.Auto]
  @State // 表格滚动条状态
  tableScrollBarState: BarState = BarState.Off
  // 表格滚动条颜色列表
  tableScrollBarColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 表格滚动条颜色
  tableScrollBarColor: ResourceColor | undefined = undefined
  // 表格一格最小宽度列表
  tableMinCellWidthList: Array<number> = widthOrHeightListGeneralData
  @State // 表格一格最小宽度
  tableMinCellWidth: number = 50
  // 表格一格最大宽度列表
  tableMaxCellWidthList: Array<number> = widthOrHeightListGeneralData
  @State // 表格一格最大宽度
  tableMaxCellWidth: number = 300
  // 表格第一列是否加粗列表
  tableFirstColumnIsBoldList: Array<boolean> = booleanListGeneralData
  @State // 表格第一列是否加粗
  tableFirstColumnIsBold: boolean = false
  // 表格标题文本颜色列表
  tableTitleTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 表格标题文本颜色
  tableTitleTextFontColor: ResourceColor | undefined = undefined
  // 表格标题文本尺寸列表
  tableTitleTextFontSizeList: Array<number> = textSizeListGeneralData
  @State // 表格标题文本尺寸
  tableTitleTextFontSize: number = 14
  // 表格标题文本字体样式列表
  tableTitleTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 表格标题文本字体样式
  tableTitleTextFontStyle: FontStyle = FontStyle.Normal
  // 表格标题文本字体粗细列表
  tableTitleTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State // 表格标题文本字体粗细
  tableTitleTextFontWeight: FontWeight = FontWeight.Bold
  // 表格标题文本字体列表
  tableTitleTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // 表格标题文本字体
  tableTitleTextFontFamily: string = 'HarmonyOS Sans'
  // 表格标题文本行高列表
  tableTitleTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State // 表格标题文本行高
  tableTitleTextLineHeight: number = 22
  // 表格标题文本字符间距列表
  tableTitleTextLetterSpacingList: Array<number> = textWordSpaceListGeneralData
  @State // 表格标题文本字符间距
  tableTitleTextLetterSpacing: number = 0
  // 表格内容文本颜色列表
  tableContentTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 表格内容文本颜色
  tableContentTextFontColor: ResourceColor | undefined = undefined
  // 表格内容文本尺寸列表
  tableContentTextFontSizeList: Array<number> = textSizeListGeneralData
  @State // 表格内容文本尺寸
  tableContentTextFontSize: number = 14
  // 表格内容文本字体样式列表
  tableContentTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 表格内容文本字体样式
  tableContentTextFontStyle: FontStyle = FontStyle.Normal
  // 表格内容文本字体粗细列表
  tableContentTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State // 表格内容文本字体粗细
  tableContentTextFontWeight: FontWeight = FontWeight.Normal
  // 表格内容文本字体列表
  tableContentTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // 表格内容文本字体
  tableContentTextFontFamily: string = 'HarmonyOS Sans'
  // 表格内容文本行高列表
  tableContentTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State // 表格内容文本行高
  tableContentTextLineHeight: number = 22
  // 表格内容文本字符间距列表
  tableContentTextLetterSpacingList: Array<number> = textWordSpaceListGeneralData
  @State // 表格内容文本字符间距
  tableContentTextLetterSpacing: number = 0
  tableStickyHeaderList: Array<boolean> = booleanListGeneralData // 表格标题行是否吸顶列表
  @State tableStickyHeader: boolean = false // 表格标题行是否吸顶
  tableHeaderIsShowList: Array<boolean> = booleanListGeneralData // 表格头部是否打开列表
  @State tableHeaderIsShow: boolean = false // 表格头部是否打开
  // 表头标题文本颜色列表
  tableHeaderTitleTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 表头标题文本颜色
  tableHeaderTitleTextFontColor: ResourceColor | undefined = undefined
  // 表头标题文本尺寸列表
  tableHeaderTitleTextFontSizeList: Array<number> = textSizeListGeneralData
  @State // 表头标题文本尺寸
  tableHeaderTitleTextFontSize: number = 14
  // 表头标题文本字体样式列表
  tableHeaderTitleTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 表头标题文本字体样式
  tableHeaderTitleTextFontStyle: FontStyle = FontStyle.Normal
  // 表头标题文本字体粗细列表
  tableHeaderTitleTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State // 表头标题文本字体粗细
  tableHeaderTitleTextFontWeight: FontWeight = FontWeight.Bold
  // 表头标题文本字体列表
  tableHeaderTitleTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // 表头标题文本字体
  tableHeaderTitleTextFontFamily: string = 'HarmonyOS Sans'
  // 表头标题文本行高列表
  tableHeaderTitleTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State // 表头标题文本行高
  tableHeaderTitleTextLineHeight: number = 22
  // 表头标题文本左边距列表
  tableHeaderTitleTextMarginLeftList: Array<number> = [0, 5, 8, 10, 15, 20, 40]
  @State // 表头标题文本左边距
  tableHeaderTitleTextMarginLeft: number = 0

  // 表格头复制图标列表
  tableHeadCopyIconList: Array<boolean> = booleanListGeneralData
  @State // 表格头复制图标
  tableHeadCopyIcon: boolean = true
  // 表格头复制图标宽度列表
  tableHeadCopyIconWidthList: Array<number> = [20, 22, 24, 26, 28, 30]
  @State // 表格头复制图标宽度
  tableHeadCopyIconWidth: number = 24
  // 表格头复制图标高度列表
  tableHeadCopyIconHeightList: Array<number> = [20, 22, 24, 26, 28, 30]
  @State // 表格头复制图标高度
  tableHeadCopyIconHeight: number = 24
  // 表格头复制图标右边距列表
  tableHeadCopyIconMarginRightList: Array<number> = [0, 5, 8, 10, 15, 20, 40]
  @State // 表格头复制图标右边距
  tableHeadCopyIconMarginRight: number = 0

  @State // 配置数据内容
  tableData: TableData = new TableData()
  heightMD: number = 30 * 1 // 乘以行数
  @State isExpanded1: boolean = false // 控制展开/折叠状态 - 通用样式配置
  @State isExpanded2: boolean = false // 控制展开/折叠状态 - 边距设置
  @State isExpanded3: boolean = false // 控制展开/折叠状态 - 边框设置
  @State isExpanded4: boolean = false // 控制展开/折叠状态 - 滚动条和其他设置
  @State isExpanded5: boolean = false // 控制展开/折叠状态 - 标题文本设置
  @State isExpanded6: boolean = false // 控制展开/折叠状态 - 内容文本设置
  @State isExpanded7: boolean = false // 控制展开/折叠状态 - 吸顶设置
  @State isExpanded8: boolean = false // 控制展开/折叠状态 - 表格复制栏设置
  @State isExpanded9: boolean = false // 控制展开/折叠状态 - 表头标题文本设置
  @State isExpanded10: boolean = false // 控制展开/折叠状态 - 表头复制文本设置
  @State isExpanded11: boolean = false // 控制展开/折叠状态 - 背景设置

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "表格配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )

      // md文档展示部分
      Column() {
        GridRow({
          columns: 3,
          gutter: { x: 5, y: 5 },
          breakpoints: {
            value: ['400vp', '600vp', '800vp'],
            reference: BreakpointsReference.ComponentSize
          },
          direction: GridRowDirection.Row
        }) {
          ForEach(this.folderList, (item: string, index: number) => {
            GridCol({
              span: {
                xs: 1,
                sm: 2,
                md: 3,
                lg: 4
              },
              offset: 0,
              order: 0
            }) {
              Text(`${item}`)
                .fontSize(12)
                .fontColor('#FFFFFFFF')
                .backgroundColor('#FF2196F3')
                .height(25)
                .width('100%')
                .padding(5)
                .borderRadius(5)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Clip })
                .onClick(() => {
                  // ---------- 通用
                  this.tableData._isFull = this.isFull
                  this.tableData._incrementalAnalysis = this.incrementalAnalysis
                  this.tableData._enableParseThrottle = this.enableParseThrottle
                  this.tableData._parseThrottleMs = this.parseThrottleMs
                  this.tableData._time = this.time
                  this.tableData._textNumber = this.textNumber
                  this.tableData._isMarkdownParserSync = this.isMarkdownParserSync
                  this.tableData._isOnCopy = this.isOnCopy
                  this.tableData._blockMarginTop = this.blockMarginTop
                  this.tableData._blockMarginRight = this.blockMarginRight
                  this.tableData._blockMarginBottom = this.blockMarginBottom
                  this.tableData._blockMarginLeft = this.blockMarginLeft
                  this.tableData._markdownBlockSpacing = this.markdownBlockSpacing
                  this.tableData._isLineBreak = this.isLineBreak
                  this.tableData._backgroundColor = this.globalBackgroundColor
                  this.tableData._openGestureSwipe = this.openGestureSwipe
                  this.tableData._openGestureSwipeTest = this.openGestureSwipeTest
                  this.tableData._pagePath = `${this.rawFilePath}/${item}`

                  // ---------- 专有
                  this.tableData._tableTitleBackgroundColor = this.tableTitleBackgroundColor
                  this.tableData._tableContentOddRowBackgroundColor = this.tableContentOddRowBackgroundColor
                  this.tableData._tableContentEvenRowBackgroundColor = this.tableContentEvenRowBackgroundColor
                  this.tableData._tableMarginTop = this.tableMarginTop
                  this.tableData._tableMarginRight = this.tableMarginRight
                  this.tableData._tableMarginBottom = this.tableMarginBottom
                  this.tableData._tableMarginLeft = this.tableMarginLeft
                  this.tableData._tablePaddingTop = this.tablePaddingTop
                  this.tableData._tablePaddingRight = this.tablePaddingRight
                  this.tableData._tablePaddingBottom = this.tablePaddingBottom
                  this.tableData._tablePaddingLeft = this.tablePaddingLeft
                  this.tableData._tableCellPaddingTop = this.tableCellPaddingTop
                  this.tableData._tableCellPaddingRight = this.tableCellPaddingRight
                  this.tableData._tableCellPaddingBottom = this.tableCellPaddingBottom
                  this.tableData._tableCellPaddingLeft = this.tableCellPaddingLeft
                  this.tableData._tableBorderStyle = this.tableBorderStyle
                  this.tableData._tableBorderWidth = this.tableBorderWidth
                  this.tableData._tableBorderColor = this.tableBorderColor
                  this.tableData._tableRadiusTopLeft = this.tableRadiusTopLeft
                  this.tableData._tableRadiusTopRight = this.tableRadiusTopRight
                  this.tableData._tableRadiusBottomLeft = this.tableRadiusBottomLeft
                  this.tableData._tableRadiusBottomRight = this.tableRadiusBottomRight
                  this.tableData._tableScrollBarState = this.tableScrollBarState
                  this.tableData._tableScrollBarColor = this.tableScrollBarColor
                  this.tableData._tableMinCellWidth = this.tableMinCellWidth
                  this.tableData._tableMaxCellWidth = this.tableMaxCellWidth
                  this.tableData._tableFirstColumnIsBold = this.tableFirstColumnIsBold
                  this.tableData._tableTitleTextFontColor = this.tableTitleTextFontColor
                  this.tableData._tableTitleTextFontSize = this.tableTitleTextFontSize
                  this.tableData._tableTitleTextFontStyle = this.tableTitleTextFontStyle
                  this.tableData._tableTitleTextFontWeight = this.tableTitleTextFontWeight
                  this.tableData._tableTitleTextFontFamily = this.tableTitleTextFontFamily
                  this.tableData._tableTitleTextLineHeight = this.tableTitleTextLineHeight
                  this.tableData._tableTitleTextLetterSpacing = this.tableTitleTextLetterSpacing
                  this.tableData._tableContentTextFontColor = this.tableContentTextFontColor
                  this.tableData._tableContentTextFontSize = this.tableContentTextFontSize
                  this.tableData._tableContentTextFontStyle = this.tableContentTextFontStyle
                  this.tableData._tableContentTextFontWeight = this.tableContentTextFontWeight
                  this.tableData._tableContentTextFontFamily = this.tableContentTextFontFamily
                  this.tableData._tableContentTextLineHeight = this.tableContentTextLineHeight
                  this.tableData._tableContentTextLetterSpacing = this.tableContentTextLetterSpacing
                  this.tableData._tableStickyHeader = this.tableStickyHeader
                  this.tableData._tableHeaderIsShow = this.tableHeaderIsShow
                  this.tableData._tableHeaderTitleTextFontColor = this.tableHeaderTitleTextFontColor
                  this.tableData._tableHeaderTitleTextFontSize = this.tableHeaderTitleTextFontSize
                  this.tableData._tableHeaderTitleTextFontStyle = this.tableHeaderTitleTextFontStyle
                  this.tableData._tableHeaderTitleTextFontWeight = this.tableHeaderTitleTextFontWeight
                  this.tableData._tableHeaderTitleTextFontFamily = this.tableHeaderTitleTextFontFamily
                  this.tableData._tableHeaderTitleTextLineHeight = this.tableHeaderTitleTextLineHeight
                  this.tableData._tableHeaderTitleTextMarginLeft = this.tableHeaderTitleTextMarginLeft
                  this.tableData._tableHeadCopyIcon = this.tableHeadCopyIcon
                  this.tableData._tableHeadCopyIconWidth = this.tableHeadCopyIconWidth
                  this.tableData._tableHeadCopyIconHeight = this.tableHeadCopyIconHeight
                  this.tableData._tableHeadCopyIconMarginRight = this.tableHeadCopyIconMarginRight

                  // ---------- 跳转到详情
                  router.pushUrl({ url: "pages/TableDetailsPage", params: this.tableData })
                })
            }
          })
        }.width('100%').height('100%')
      }.padding({ top: 5, bottom: 5 }).width('100%').height(this.heightMD)

      Scroll() {
        Column() {
          Column() {
            Row() {
              Text("通用样式配置")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded1 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded1 = !this.isExpanded1
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded1 = !this.isExpanded1
            })

            if (this.isExpanded1) {
              Column() {
                BaseTabComponent({
                  titleStr: "是否全量加载Markdown文本 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.isFullList,
                  allData: this.isFull
                })
                BaseTabComponent({
                  titleStr: "是否增量解析Markdown文本 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.incrementalAnalysisList,
                  allData: this.incrementalAnalysis
                })
                BaseTabComponent({
                  titleStr: "是否启用解析节流 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.enableParseThrottleList,
                  allData: this.enableParseThrottle
                })
                BaseTabComponent({
                  titleStr: "解析节流间隔(ms) - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.parseThrottleMsList,
                  allData: this.parseThrottleMs
                })
                BaseTabComponent({
                  titleStr: "增量加载每次间隔时间 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.timeList,
                  allData: this.time
                })
                BaseTabComponent({
                  titleStr: "增量每次增量文本数量 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.textNumberList,
                  allData: this.textNumber
                })
                BaseTabComponent({
                  titleStr: "是否同步解析Markdown文本 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.isMarkdownParserSyncList,
                  allData: this.isMarkdownParserSync
                })
                BaseTabComponent({
                  titleStr: "是否打开长按复制粘贴效果 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.isOnCopyList,
                  allData: this.isOnCopy
                })
                BaseTabComponent({
                  titleStr: "markdown全局上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginTopList,
                  allData: this.blockMarginTop
                })
                BaseTabComponent({
                  titleStr: "markdown全局右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginRightList,
                  allData: this.blockMarginRight
                })
                BaseTabComponent({
                  titleStr: "markdown全局下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginBottomList,
                  allData: this.blockMarginBottom
                })
                BaseTabComponent({
                  titleStr: "markdown全局左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginLeftList,
                  allData: this.blockMarginLeft
                })
                BaseTabComponent({
                  titleStr: "模块间上下间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.markdownBlockSpacingList,
                  allData: this.markdownBlockSpacing
                })
                BaseTabComponent({
                  titleStr: "软换行是否换行 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.isLineBreakList,
                  allData: this.isLineBreak
                })
                BaseTabComponent({
                  titleStr: "背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.globalBackgroundColorList,
                  allData: this.globalBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "是否开启响应滑动测试 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.openGestureSwipeTestList,
                  allData: this.openGestureSwipeTest
                })
                BaseTabComponent({
                  titleStr: "是否允许markdown控件自身响应滑动 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.openGestureSwipeList,
                  allData: this.openGestureSwipe
                })
              }
              .width('100%')
              .padding({ bottom: 5, left: 5, right: 5 })
              .margin({ bottom: 5, left: 5, right: 5 })
            }
          }
          .width('100%')
          .margin(5)
          .borderRadius(5)
          .backgroundColor(0xFF317AFF)

          // 边距设置
          Column() {
            Row() {
              Text("边距设置")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded2 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded2 = !this.isExpanded2
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded2 = !this.isExpanded2
            })

            if (this.isExpanded2) {
              Column() {
                BaseTabComponent({
                  titleStr: "表格上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableMarginTopList,
                  allData: this.tableMarginTop
                })
                BaseTabComponent({
                  titleStr: "表格右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableMarginRightList,
                  allData: this.tableMarginRight
                })
                BaseTabComponent({
                  titleStr: "表格下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableMarginBottomList,
                  allData: this.tableMarginBottom
                })
                BaseTabComponent({
                  titleStr: "表格左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableMarginLeftList,
                  allData: this.tableMarginLeft
                })
                BaseTabComponent({
                  titleStr: "表格上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tablePaddingTopList,
                  allData: this.tablePaddingTop
                })
                BaseTabComponent({
                  titleStr: "表格右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tablePaddingRightList,
                  allData: this.tablePaddingRight
                })
                BaseTabComponent({
                  titleStr: "表格下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tablePaddingBottomList,
                  allData: this.tablePaddingBottom
                })
                BaseTabComponent({
                  titleStr: "表格左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tablePaddingLeftList,
                  allData: this.tablePaddingLeft
                })
                BaseTabComponent({
                  titleStr: "表格内容上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableCellPaddingTopList,
                  allData: this.tableCellPaddingTop
                })
                BaseTabComponent({
                  titleStr: "表格内容右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableCellPaddingRightList,
                  allData: this.tableCellPaddingRight
                })
                BaseTabComponent({
                  titleStr: "表格内容下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableCellPaddingBottomList,
                  allData: this.tableCellPaddingBottom
                })
                BaseTabComponent({
                  titleStr: "表格内容左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableCellPaddingLeftList,
                  allData: this.tableCellPaddingLeft
                })
              }
              .width('100%')
              .padding({ bottom: 5, left: 5, right: 5 })
              .margin({ bottom: 5, left: 5, right: 5 })
            }
          }
          .width('100%')
          .margin(5)
          .borderRadius(5)
          .backgroundColor(0xFF317AFF)

          // 边框设置
          Column() {
            Row() {
              Text("边框设置")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded3 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded3 = !this.isExpanded3
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded3 = !this.isExpanded3
            })

            if (this.isExpanded3) {
              Column() {
                BaseTabComponent({
                  titleStr: "表格边框样式 - ",
                  typeEnum: TypeEnum.IS_BORDER_STYLE,
                  allListData: this.tableBorderStyleList,
                  allData: this.tableBorderStyle
                })
                BaseTabComponent({
                  titleStr: "表格边框宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableBorderWidthList,
                  allData: this.tableBorderWidth
                })
                BaseTabComponent({
                  titleStr: "表格边框颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.tableBorderColorList,
                  allData: this.tableBorderColor
                })
                BaseTabComponent({
                  titleStr: "表格边框左上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableRadiusTopLeftList,
                  allData: this.tableRadiusTopLeft
                })
                BaseTabComponent({
                  titleStr: "表格边框右上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableRadiusTopRightList,
                  allData: this.tableRadiusTopRight
                })
                BaseTabComponent({
                  titleStr: "表格边框左下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableRadiusBottomLeftList,
                  allData: this.tableRadiusBottomLeft
                })
                BaseTabComponent({
                  titleStr: "表格边框右下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableRadiusBottomRightList,
                  allData: this.tableRadiusBottomRight
                })
              }
              .width('100%')
              .padding({ bottom: 5, left: 5, right: 5 })
              .margin({ bottom: 5, left: 5, right: 5 })
            }
          }
          .width('100%')
          .margin(5)
          .borderRadius(5)
          .backgroundColor(0xFF317AFF)
          .backgroundColor(0xFF317AFF)

          // 背景设置
          Column() {
            Row() {
              Text("表格背景设置")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded11 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded11 = !this.isExpanded11
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded11 = !this.isExpanded11
            })

            if (this.isExpanded11) {
              Column() {
                BaseTabComponent({
                  titleStr: "表格标题背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.tableTitleBackgroundColorList,
                  allData: this.tableTitleBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "表格内容奇数行背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.tableContentOddRowBackgroundColorList,
                  allData: this.tableContentOddRowBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "表格内容偶数行背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.tableContentEvenRowBackgroundColorList,
                  allData: this.tableContentEvenRowBackgroundColor
                })
              }
              .width('100%')
              .padding({ bottom: 5, left: 5, right: 5 })
              .margin({ bottom: 5, left: 5, right: 5 })
            }
          }
          .width('100%')
          .margin(5)
          .borderRadius(5)
          .backgroundColor(0xFF317AFF)

          // 滚动条和其他设置
          Column() {
            Row() {
              Text("滚动条和其他设置")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded4 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded4 = !this.isExpanded4
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded4 = !this.isExpanded4
            })

            if (this.isExpanded4) {
              Column() {
                BaseTabComponent({
                  titleStr: "表格滚动条状态 - ",
                  typeEnum: TypeEnum.IS_BAR_STATE,
                  allListData: this.tableScrollBarStateList,
                  allData: this.tableScrollBarState
                })
                BaseTabComponent({
                  titleStr: "表格滚动条颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.tableScrollBarColorList,
                  allData: this.tableScrollBarColor
                })
                BaseTabComponent({
                  titleStr: "表格一格最小宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableMinCellWidthList,
                  allData: this.tableMinCellWidth
                })
                BaseTabComponent({
                  titleStr: "表格一格最大宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableMaxCellWidthList,
                  allData: this.tableMaxCellWidth
                })
                BaseTabComponent({
                  titleStr: "表格第一列是否加粗 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.tableFirstColumnIsBoldList,
                  allData: this.tableFirstColumnIsBold
                })
              }
              .width('100%')
              .padding({ bottom: 5, left: 5, right: 5 })
              .margin({ bottom: 5, left: 5, right: 5 })
            }
          }
          .width('100%')
          .margin(5)
          .borderRadius(5)
          .backgroundColor(0xFF317AFF)

          // 标题文本设置
          Column() {
            Row() {
              Text("标题文本设置")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded5 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded5 = !this.isExpanded5
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded5 = !this.isExpanded5
            })

            if (this.isExpanded5) {
              Column() {
                BaseTabComponent({
                  titleStr: "表格标题文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.tableTitleTextFontColorList,
                  allData: this.tableTitleTextFontColor
                })
                BaseTabComponent({
                  titleStr: "表格标题文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableTitleTextFontSizeList,
                  allData: this.tableTitleTextFontSize
                })
                BaseTabComponent({
                  titleStr: "表格标题文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.tableTitleTextFontStyleList,
                  allData: this.tableTitleTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "表格标题文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.tableTitleTextFontWeightList,
                  allData: this.tableTitleTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "表格标题文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.tableTitleTextFontFamilyList,
                  allData: this.tableTitleTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "表格标题文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableTitleTextLineHeightList,
                  allData: this.tableTitleTextLineHeight
                })
                BaseTabComponent({
                  titleStr: "表格标题文本字符间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableTitleTextLetterSpacingList,
                  allData: this.tableTitleTextLetterSpacing
                })
              }
              .width('100%')
              .padding({ bottom: 5, left: 5, right: 5 })
              .margin({ bottom: 5, left: 5, right: 5 })
            }
          }
          .width('100%')
          .margin(5)
          .borderRadius(5)
          .backgroundColor(0xFF317AFF)

          // 内容文本设置
          Column() {
            Row() {
              Text("内容文本设置")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded6 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded6 = !this.isExpanded6
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded6 = !this.isExpanded6
            })

            if (this.isExpanded6) {
              Column() {
                BaseTabComponent({
                  titleStr: "表格内容文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.tableContentTextFontColorList,
                  allData: this.tableContentTextFontColor
                })
                BaseTabComponent({
                  titleStr: "表格内容文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableContentTextFontSizeList,
                  allData: this.tableContentTextFontSize
                })
                BaseTabComponent({
                  titleStr: "表格内容文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.tableContentTextFontStyleList,
                  allData: this.tableContentTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "表格内容文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.tableContentTextFontWeightList,
                  allData: this.tableContentTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "表格内容文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.tableContentTextFontFamilyList,
                  allData: this.tableContentTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "表格内容文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableContentTextLineHeightList,
                  allData: this.tableContentTextLineHeight
                })
                BaseTabComponent({
                  titleStr: "表格内容文本字符间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableContentTextLetterSpacingList,
                  allData: this.tableContentTextLetterSpacing
                })
              }
              .width('100%')
              .padding({ bottom: 5, left: 5, right: 5 })
              .margin({ bottom: 5, left: 5, right: 5 })
            }
          }
          .width('100%')
          .margin(5)
          .borderRadius(5)
          .backgroundColor(0xFF317AFF)

          // 吸顶设置
          Column() {
            Row() {
              Text("吸顶设置")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded7 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded7 = !this.isExpanded7
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded7 = !this.isExpanded7
            })

            if (this.isExpanded7) {
              Column() {
                BaseTabComponent({
                  titleStr: "表格标题是否吸顶 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableStickyHeaderList,
                  allData: this.tableStickyHeader
                })
              }
              .width('100%')
              .padding({ bottom: 5, left: 5, right: 5 })
              .margin({ bottom: 5, left: 5, right: 5 })
            }
          }
          .width('100%')
          .margin(5)
          .borderRadius(5)
          .backgroundColor(0xFF317AFF)

          // 表头设置
          Column() {
            Row() {
              Text("表格复制栏设置")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded8 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded8 = !this.isExpanded8
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded8 = !this.isExpanded8
            })

            if (this.isExpanded8) {
              Column() {
                BaseTabComponent({
                  titleStr: "表格头部是否打开 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.tableHeaderIsShowList,
                  allData: this.tableHeaderIsShow
                })
              }
              .width('100%')
              .padding({ bottom: 5, left: 5, right: 5 })
              .margin({ bottom: 5, left: 5, right: 5 })
            }
          }
          .width('100%')
          .margin(5)
          .borderRadius(5)
          .backgroundColor(0xFF317AFF)

          // 表头标题文本设置
          Column() {
            Row() {
              Text("表头标题文本设置")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded9 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded9 = !this.isExpanded9
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded9 = !this.isExpanded9
            })

            if (this.isExpanded9) {
              Column() {
                BaseTabComponent({
                  titleStr: "表头标题文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.tableHeaderTitleTextFontColorList,
                  allData: this.tableHeaderTitleTextFontColor
                })
                BaseTabComponent({
                  titleStr: "表头标题文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableHeaderTitleTextFontSizeList,
                  allData: this.tableHeaderTitleTextFontSize
                })
                BaseTabComponent({
                  titleStr: "表头标题文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.tableHeaderTitleTextFontStyleList,
                  allData: this.tableHeaderTitleTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "表头标题文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.tableHeaderTitleTextFontWeightList,
                  allData: this.tableHeaderTitleTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "表头标题文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.tableHeaderTitleTextFontFamilyList,
                  allData: this.tableHeaderTitleTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "表头标题文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableHeaderTitleTextLineHeightList,
                  allData: this.tableHeaderTitleTextLineHeight
                })
                BaseTabComponent({
                  titleStr: "表头标题左边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableHeaderTitleTextMarginLeftList,
                  allData: this.tableHeaderTitleTextMarginLeft
                })
              }
              .width('100%')
              .padding({ bottom: 5, left: 5, right: 5 })
              .margin({ bottom: 5, left: 5, right: 5 })
            }
          }
          .width('100%')
          .margin(5)
          .borderRadius(5)
          .backgroundColor(0xFF317AFF)

          // 表头复制文本设置
          Column() {
            Row() {
              Text("表头复制文本设置")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded10 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded10 = !this.isExpanded10
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded10 = !this.isExpanded10
            })

            if (this.isExpanded10) {
              Column() {
                BaseTabComponent({
                  titleStr: "表格头复制图标 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.tableHeadCopyIconList,
                  allData: this.tableHeadCopyIcon
                })
                BaseTabComponent({
                  titleStr: "表格头复制图标宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableHeadCopyIconWidthList,
                  allData: this.tableHeadCopyIconWidth
                })
                BaseTabComponent({
                  titleStr: "表格头复制图标高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableHeadCopyIconHeightList,
                  allData: this.tableHeadCopyIconHeight
                })
                BaseTabComponent({
                  titleStr: "表格头复制图标右边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.tableHeadCopyIconMarginRightList,
                  allData: this.tableHeadCopyIconMarginRight
                })

              }
              .width('100%')
              .padding({ bottom: 5, left: 5, right: 5 })
              .margin({ bottom: 5, left: 5, right: 5 })
            }
          }
          .width('100%')
          .margin(5)
          .borderRadius(5)
          .backgroundColor(0xFF317AFF)
        }
        .padding({ top: 10, bottom: 100 })
      }
    }
    .backgroundColor('#FFEAEAEA')
    .height("90%")
  }
}