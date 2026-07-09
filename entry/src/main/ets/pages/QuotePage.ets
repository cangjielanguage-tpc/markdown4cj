import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseTabComponent } from '../component/BaseTabComponent'
import { TypeEnum } from '../model/TypeEnum'
import {
  booleanListGeneralData,
  colorListGeneralData,
  lineOrBorderWidthListGeneraData,
  marginListGeneralData,
  radiusListGeneraData,
  textNumberListGeneralData,
  timeListGeneralData
} from '../model/GeneralData'
import { QuoteData } from '../model/QuoteData'

@Entry
@Component
struct QuotePage {
  // ---------------- 通用
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "008_BlockQuote"
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
  // 块引用背景颜色列表
  blockQuoteBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 块引用背景颜色
  blockQuoteBackgroundColor: ResourceColor | undefined = undefined
  // 块引用上外边距列表
  blockQuoteMarginTopList: Array<number> = marginListGeneralData
  @State // 块引用上外边距
  blockQuoteMarginTop: number = 0
  // 块引用右外边距列表
  blockQuoteMarginRightList: Array<number> = marginListGeneralData
  @State // 块引用右外边距
  blockQuoteMarginRight: number = 0
  // 块引用下外边距列表
  blockQuoteMarginBottomList: Array<number> = marginListGeneralData
  @State // 块引用下外边距
  blockQuoteMarginBottom: number = 0
  // 块引用左外边距列表
  blockQuoteMarginLeftList: Array<number> = marginListGeneralData
  @State // 块引用左外边距
  blockQuoteMarginLeft: number = 8
  // 块引用上内边距列表
  blockQuotePaddingTopList: Array<number> = marginListGeneralData
  @State // 块引用上内边距
  blockQuotePaddingTop: number = 0
  // 块引用右内边距列表
  blockQuotePaddingRightList: Array<number> = marginListGeneralData
  @State // 块引用右内边距
  blockQuotePaddingRight: number = 0
  // 块引用下内边距列表
  blockQuotePaddingBottomList: Array<number> = marginListGeneralData
  @State // 块引用下内边距
  blockQuotePaddingBottom: number = 0
  // 块引用左内边距列表
  blockQuotePaddingLeftList: Array<number> = marginListGeneralData
  @State // 块引用左内边距
  blockQuotePaddingLeft: number = 0
  // 块引用边框左上圆角列表
  blockQuoteRadiusTopLeftList: Array<number> = radiusListGeneraData
  @State // 块引用边框左上圆角
  blockQuoteRadiusTopLeft: number = 0
  // 块引用边框右上圆角列表
  blockQuoteRadiusTopRightList: Array<number> = radiusListGeneraData
  @State // 块引用边框右上圆角
  blockQuoteRadiusTopRight: number = 0
  // 块引用边框左下圆角列表
  blockQuoteRadiusBottomLeftList: Array<number> = radiusListGeneraData
  @State // 块引用边框左下圆角
  blockQuoteRadiusBottomLeft: number = 0
  // 块引用边框右下圆角列表
  blockQuoteRadiusBottomRightList: Array<number> = radiusListGeneraData
  @State // 块引用边框右下圆角
  blockQuoteRadiusBottomRight: number = 0
  // 块引用左侧边框宽度列表
  blockQuoteLeftBorderWidthList: Array<number> = lineOrBorderWidthListGeneraData
  @State // 块引用左侧边框宽度
  blockQuoteLeftBorderWidth: number = 1
  // 块引用左侧边框颜色列表
  blockQuoteLeftBorderColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 块引用左侧边框颜色
  blockQuoteLeftBorderColor: ResourceColor | undefined = undefined
  // 块引用子模块上下间距列表
  blockQuoteChildSpacingList: Array<number> = marginListGeneralData
  @State // 块引用子模块上下间距
  blockQuoteChildSpacing: number = 8
  @State // 配置数据内容
  quoteData: QuoteData = new QuoteData()
  @State isExpanded1: boolean = false // 控制展开/折叠状态
  @State isExpanded2: boolean = false // 控制展开/折叠状态

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "块引用配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )

      // md鏂囨。灞曠ず閮ㄥ垎
      Grid() {
        ForEach(this.folderList, (item: string, index: number) => {
          GridItem() {
            Text(`${item}`)
              .fontSize(12)
              .fontColor('#FFFFFFFF')
              .backgroundColor('#FF2196F3')
              .height(25)
              .padding(5)
              .borderRadius(5)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Clip })
              .onClick(() => {
                // ---------- 通用
                  this.quoteData._isFull = this.isFull
                  this.quoteData._incrementalAnalysis = this.incrementalAnalysis
                  this.quoteData._enableParseThrottle = this.enableParseThrottle
                  this.quoteData._parseThrottleMs = this.parseThrottleMs
                  this.quoteData._time = this.time
                  this.quoteData._textNumber = this.textNumber
                  this.quoteData._isMarkdownParserSync = this.isMarkdownParserSync
                  this.quoteData._isOnCopy = this.isOnCopy
                  this.quoteData._blockMarginTop = this.blockMarginTop
                  this.quoteData._blockMarginRight = this.blockMarginRight
                  this.quoteData._blockMarginBottom = this.blockMarginBottom
                  this.quoteData._blockMarginLeft = this.blockMarginLeft
                  this.quoteData._markdownBlockSpacing = this.markdownBlockSpacing
                  this.quoteData._isLineBreak = this.isLineBreak
                  this.quoteData._backgroundColor = this.globalBackgroundColor
                  this.quoteData._openGestureSwipe = this.openGestureSwipe
                  this.quoteData._openGestureSwipeTest = this.openGestureSwipeTest
                  this.quoteData._pagePath = `${this.rawFilePath}/${item}`

                  // ---------- 专有
                  this.quoteData._blockQuoteBackgroundColor = this.blockQuoteBackgroundColor
                  this.quoteData._blockQuoteMarginTop = this.blockQuoteMarginTop
                  this.quoteData._blockQuoteMarginRight = this.blockQuoteMarginRight
                  this.quoteData._blockQuoteMarginBottom = this.blockQuoteMarginBottom
                  this.quoteData._blockQuoteMarginLeft = this.blockQuoteMarginLeft
                  this.quoteData._blockQuotePaddingTop = this.blockQuotePaddingTop
                  this.quoteData._blockQuotePaddingRight = this.blockQuotePaddingRight
                  this.quoteData._blockQuotePaddingBottom = this.blockQuotePaddingBottom
                  this.quoteData._blockQuotePaddingLeft = this.blockQuotePaddingLeft
                  this.quoteData._blockQuoteRadiusTopLeft = this.blockQuoteRadiusTopLeft
                  this.quoteData._blockQuoteRadiusTopRight = this.blockQuoteRadiusTopRight
                  this.quoteData._blockQuoteRadiusBottomLeft = this.blockQuoteRadiusBottomLeft
                  this.quoteData._blockQuoteRadiusBottomRight = this.blockQuoteRadiusBottomRight
                  this.quoteData._blockQuoteLeftBorderWidth = this.blockQuoteLeftBorderWidth
                  this.quoteData._blockQuoteLeftBorderColor = this.blockQuoteLeftBorderColor
                  this.quoteData._blockQuoteChildSpacing = this.blockQuoteChildSpacing
                  // ---------- 跳转到详情
                  router.pushUrl({ url: "pages/QuoteDetailsPage", params: this.quoteData })
              })
          }
        })
      }
      .constraintSize({ maxHeight: 200 })
      .columnsGap(5)
      .rowsGap(5)
      .maxCount(5)
      .minCount(3)
      .cellLength(30)
      .layoutDirection(GridDirection.Row)
      .padding(5)
      .width('100%')
      .backgroundColor(0xFFEAEAEA)

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
                  titleStr: "解析节流间隔（ms） - ",
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

          Column() {
            Row() {
              Text("专有样式配置")
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
                  titleStr: "块引用上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockQuoteMarginTopList,
                  allData: this.blockQuoteMarginTop
                })
                BaseTabComponent({
                  titleStr: "块引用右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockQuoteMarginRightList,
                  allData: this.blockQuoteMarginRight
                })
                BaseTabComponent({
                  titleStr: "块引用下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockQuoteMarginBottomList,
                  allData: this.blockQuoteMarginBottom
                })
                BaseTabComponent({
                  titleStr: "块引用左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockQuoteMarginLeftList,
                  allData: this.blockQuoteMarginLeft
                })
                BaseTabComponent({
                  titleStr: "块引用上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockQuotePaddingTopList,
                  allData: this.blockQuotePaddingTop
                })
                BaseTabComponent({
                  titleStr: "块引用右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockQuotePaddingRightList,
                  allData: this.blockQuotePaddingRight
                })
                BaseTabComponent({
                  titleStr: "块引用下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockQuotePaddingBottomList,
                  allData: this.blockQuotePaddingBottom
                })
                BaseTabComponent({
                  titleStr: "块引用左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockQuotePaddingLeftList,
                  allData: this.blockQuotePaddingLeft
                })
                BaseTabComponent({
                  titleStr: "块引用边框左上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockQuoteRadiusTopLeftList,
                  allData: this.blockQuoteRadiusTopLeft
                })
                BaseTabComponent({
                  titleStr: "块引用边框右上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockQuoteRadiusTopRightList,
                  allData: this.blockQuoteRadiusTopRight
                })
                BaseTabComponent({
                  titleStr: "块引用边框左下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockQuoteRadiusBottomLeftList,
                  allData: this.blockQuoteRadiusBottomLeft
                })
                BaseTabComponent({
                  titleStr: "块引用边框右下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockQuoteRadiusBottomRightList,
                  allData: this.blockQuoteRadiusBottomRight
                })
                BaseTabComponent({
                  titleStr: "块引用左侧边框宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockQuoteLeftBorderWidthList,
                  allData: this.blockQuoteLeftBorderWidth
                })
                BaseTabComponent({
                  titleStr: "块引用左侧边框颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.blockQuoteLeftBorderColorList,
                  allData: this.blockQuoteLeftBorderColor
                })
                BaseTabComponent({
                  titleStr: "块引用子模块上下间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockQuoteChildSpacingList,
                  allData: this.blockQuoteChildSpacing
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