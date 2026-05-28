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
  // 滑动控制器
  scroller: Scroller = new Scroller()
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
  // 块引用背景颜色列表
  blockQuoteBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State // 块引用背景颜色
  blockQuoteBackgroundColor: number | undefined = undefined
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
  blockQuoteLeftBorderColorList: Array<number | undefined> = colorListGeneralData
  @State // 块引用左侧边框颜色
  blockQuoteLeftBorderColor: number | undefined = undefined
  // 块引用子模块上下间距列表
  blockQuoteChildSpacingList: Array<number> = marginListGeneralData
  @State // 块引用子模块上下间距
  blockQuoteChildSpacing: number = 8

  @State // 配置数据内容
  quoteData: QuoteData = new QuoteData()

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
            titleStr: "块引用背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.blockQuoteBackgroundColorList,
            allData: this.blockQuoteBackgroundColor
          })
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
                    this.quoteData.isFull = this.isFull
                    this.quoteData.incrementalAnalysis = this.incrementalAnalysis
                    this.quoteData.time = this.time
                    this.quoteData.textNumber = this.textNumber
                    this.quoteData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.quoteData.isOnCopy = this.isOnCopy
                    this.quoteData.blockMarginTop = this.blockMarginTop
                    this.quoteData.blockMarginRight = this.blockMarginRight
                    this.quoteData.blockMarginBottom = this.blockMarginBottom
                    this.quoteData.blockMarginLeft = this.blockMarginLeft
                    this.quoteData.markdownBlockSpacing = this.markdownBlockSpacing
                    this.quoteData.isLineBreak = this.isLineBreak
                    this.quoteData.backgroundColor = this.globalBackgroundColor
                    this.quoteData.openGestureSwipe = this.openGestureSwipe
                    this.quoteData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.quoteData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.quoteData.blockQuoteBackgroundColor = this.blockQuoteBackgroundColor
                    this.quoteData.blockQuoteMarginTop = this.blockQuoteMarginTop
                    this.quoteData.blockQuoteMarginRight = this.blockQuoteMarginRight
                    this.quoteData.blockQuoteMarginBottom = this.blockQuoteMarginBottom
                    this.quoteData.blockQuoteMarginLeft = this.blockQuoteMarginLeft
                    this.quoteData.blockQuotePaddingTop = this.blockQuotePaddingTop
                    this.quoteData.blockQuotePaddingRight = this.blockQuotePaddingRight
                    this.quoteData.blockQuotePaddingBottom = this.blockQuotePaddingBottom
                    this.quoteData.blockQuotePaddingLeft = this.blockQuotePaddingLeft
                    this.quoteData.blockQuoteRadiusTopLeft = this.blockQuoteRadiusTopLeft
                    this.quoteData.blockQuoteRadiusTopRight = this.blockQuoteRadiusTopRight
                    this.quoteData.blockQuoteRadiusBottomLeft = this.blockQuoteRadiusBottomLeft
                    this.quoteData.blockQuoteRadiusBottomRight = this.blockQuoteRadiusBottomRight
                    this.quoteData.blockQuoteLeftBorderWidth = this.blockQuoteLeftBorderWidth
                    this.quoteData.blockQuoteLeftBorderColor = this.blockQuoteLeftBorderColor
                    this.quoteData.blockQuoteChildSpacing = this.blockQuoteChildSpacing
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/QuoteDetailsPage", params: this.quoteData })
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
