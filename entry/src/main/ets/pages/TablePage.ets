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
  timeListGeneralData,
  widthOrHeightListGeneralData
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
  rawFilePath: string = "006_表格"
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
  globalBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State // 背景颜色
  globalBackgroundColor: number | undefined = undefined
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
  tableTitleBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State // 表格标题背景颜色
  tableTitleBackgroundColor: number | undefined = undefined
  // 表格内容奇数行背景颜色列表
  tableContentOddRowBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State // 表格内容奇数行背景颜色
  tableContentOddRowBackgroundColor: number | undefined = undefined
  // 表格内容偶数行背景颜色列表
  tableContentEvenRowBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State // 表格内容偶数行背景颜色
  tableContentEvenRowBackgroundColor: number | undefined = undefined
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
  tableBorderColorList: Array<number | undefined> = colorListGeneralData
  @State // 表格边框颜色
  tableBorderColor: number | undefined = undefined
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
  tableScrollBarColorList: Array<number | undefined> = colorListGeneralData
  @State // 表格滚动条颜色
  tableScrollBarColor: number | undefined = undefined
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
  tableTitleTextFontColorList: Array<number | undefined> = colorListGeneralData
  @State // 表格标题文本颜色
  tableTitleTextFontColor: number | undefined = undefined
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
  tableContentTextFontColorList: Array<number | undefined> = colorListGeneralData
  @State // 表格内容文本颜色
  tableContentTextFontColor: number | undefined = undefined
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
  @State // 配置数据内容
  tableData: TableData = new TableData()

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
      Scroll() {
        Column() {
          // ------------ 通用
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

          // ---------------- 专有
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

          // 列表显示
          List() {
            ForEach(this.folderList, (item: string, index: number) => {
              ListItem() {
                Button(`${index + 1}、${item}`)
                  .height(40)
                  .width('80%')
                  .type(ButtonType.Capsule)
                  .fontColor(0xFFFFFFFF)
                  .backgroundColor(0xFF317AFF)
                  .margin({ top: 5, bottom: 5 })
                  .align(Alignment.Center)
                  .fontSize(16)
                  .onClick(() => {
                    // ---------- 通用
                    this.tableData.isFull = this.isFull
                    this.tableData.incrementalAnalysis = this.incrementalAnalysis
                    this.tableData.time = this.time
                    this.tableData.textNumber = this.textNumber
                    this.tableData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.tableData.isOnCopy = this.isOnCopy
                    this.tableData.blockMarginTop = this.blockMarginTop
                    this.tableData.blockMarginRight = this.blockMarginRight
                    this.tableData.blockMarginBottom = this.blockMarginBottom
                    this.tableData.blockMarginLeft = this.blockMarginLeft
                    this.tableData.markdownBlockSpacing = this.markdownBlockSpacing
                    this.tableData.isLineBreak = this.isLineBreak
                    this.tableData.backgroundColor = this.globalBackgroundColor
                    this.tableData.openGestureSwipe = this.openGestureSwipe
                    this.tableData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.tableData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.tableData.tableTitleBackgroundColor = this.tableTitleBackgroundColor
                    this.tableData.tableContentOddRowBackgroundColor = this.tableContentOddRowBackgroundColor
                    this.tableData.tableContentEvenRowBackgroundColor = this.tableContentEvenRowBackgroundColor
                    this.tableData.tableMarginTop = this.tableMarginTop
                    this.tableData.tableMarginRight = this.tableMarginRight
                    this.tableData.tableMarginBottom = this.tableMarginBottom
                    this.tableData.tableMarginLeft = this.tableMarginLeft
                    this.tableData.tablePaddingTop = this.tablePaddingTop
                    this.tableData.tablePaddingRight = this.tablePaddingRight
                    this.tableData.tablePaddingBottom = this.tablePaddingBottom
                    this.tableData.tablePaddingLeft = this.tablePaddingLeft
                    this.tableData.tableCellPaddingTop = this.tableCellPaddingTop
                    this.tableData.tableCellPaddingRight = this.tableCellPaddingRight
                    this.tableData.tableCellPaddingBottom = this.tableCellPaddingBottom
                    this.tableData.tableCellPaddingLeft = this.tableCellPaddingLeft
                    this.tableData.tableBorderStyle = this.tableBorderStyle
                    this.tableData.tableBorderWidth = this.tableBorderWidth
                    this.tableData.tableBorderColor = this.tableBorderColor
                    this.tableData.tableRadiusTopLeft = this.tableRadiusTopLeft
                    this.tableData.tableRadiusTopRight = this.tableRadiusTopRight
                    this.tableData.tableRadiusBottomLeft = this.tableRadiusBottomLeft
                    this.tableData.tableRadiusBottomRight = this.tableRadiusBottomRight
                    this.tableData.tableScrollBarState = this.tableScrollBarState
                    this.tableData.tableScrollBarColor = this.tableScrollBarColor
                    this.tableData.tableMinCellWidth = this.tableMinCellWidth
                    this.tableData.tableMaxCellWidth = this.tableMaxCellWidth
                    this.tableData.tableFirstColumnIsBold = this.tableFirstColumnIsBold
                    this.tableData.tableTitleTextFontColor = this.tableTitleTextFontColor
                    this.tableData.tableTitleTextFontSize = this.tableTitleTextFontSize
                    this.tableData.tableTitleTextFontStyle = this.tableTitleTextFontStyle
                    this.tableData.tableTitleTextFontWeight = this.tableTitleTextFontWeight
                    this.tableData.tableTitleTextFontFamily = this.tableTitleTextFontFamily
                    this.tableData.tableTitleTextLineHeight = this.tableTitleTextLineHeight
                    this.tableData.tableTitleTextLetterSpacing = this.tableTitleTextLetterSpacing
                    this.tableData.tableContentTextFontColor = this.tableContentTextFontColor
                    this.tableData.tableContentTextFontSize = this.tableContentTextFontSize
                    this.tableData.tableContentTextFontStyle = this.tableContentTextFontStyle
                    this.tableData.tableContentTextFontWeight = this.tableContentTextFontWeight
                    this.tableData.tableContentTextFontFamily = this.tableContentTextFontFamily
                    this.tableData.tableContentTextLineHeight = this.tableContentTextLineHeight
                    this.tableData.tableContentTextLetterSpacing = this.tableContentTextLetterSpacing
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/TableDetailsPage", params: this.tableData })
                  })
              }
            })
          }
          .alignListItem(ListItemAlign.Center)
        }
        .padding({ bottom: 100 })
      }
    }
    .backgroundColor(0xFFEAEAEA)
    .height("100%")
  }
}


