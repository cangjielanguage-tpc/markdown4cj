import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BannerData } from '../model/BannerData'
import { BaseTabComponent } from '../component/BaseTabComponent'
import { TypeEnum } from '../model/TypeEnum'
import {
  booleanListGeneralData,
  colorListGeneralData,
  marginListGeneralData,
  textNumberListGeneralData,
  timeListGeneralData
} from '../model/GeneralData'

@Entry
@Component
struct BannerPage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') safeTop: number = 0 // 顶部导航栏高度
  // rawfile路径
  rawFilePath: string = "030_Banner"
  @State folderList: Array<string> = new Array<string>() // rawfile文件夹列表
  // 是否全量加载Markdown文本列表
  isFullList: Array<boolean> = booleanListGeneralData
  @State isFull: boolean = true // 是否全量加载Markdown文本
  // 是否增量解析Markdown文本列表
  incrementalAnalysisList: Array<boolean> = booleanListGeneralData
  @State incrementalAnalysis: boolean = false // 是否增量解析Markdown文本
  // 增量加载每次间隔时间列表
  timeList: Array<number> = timeListGeneralData
  @State time: number = 50 // 增量加载每次间隔时间
  // 增量每次增量文本数量列表
  textNumberList: Array<number> = textNumberListGeneralData
  @State textNumber: number = 10 // 增量每次增量文本数量
  // 是否同步解析Markdown文本列表
  isMarkdownParserSyncList: Array<boolean> = booleanListGeneralData
  @State isMarkdownParserSync: boolean = false // 是否同步解析Markdown文本
  // 是否打开长按复制粘贴效果列表
  isOnCopyList: Array<boolean> = booleanListGeneralData
  @State isOnCopy: boolean = false // 是否打开长按复制粘贴效果
  // markdown全局上外边距列表
  blockMarginTopList: Array<number> = marginListGeneralData
  @State blockMarginTop: number = 0 // markdown全局上外边距
  // markdown全局右外边距列表
  blockMarginRightList: Array<number> = marginListGeneralData
  @State blockMarginRight: number = 0 // markdown全局右外边距
  // markdown全局下外边距列表
  blockMarginBottomList: Array<number> = marginListGeneralData
  @State blockMarginBottom: number = 0 // markdown全局下外边距
  // markdown全局左外边距列表
  blockMarginLeftList: Array<number> = marginListGeneralData
  @State blockMarginLeft: number = 0 // markdown全局左外边距
  // 模块间上下间距列表
  markdownBlockSpacingList: Array<number> = marginListGeneralData
  @State markdownBlockSpacing: number = 8 // 模块间上下间距
  // 软换行是否换行列表
  isLineBreakList: Array<boolean> = booleanListGeneralData
  @State isLineBreak: boolean = false // 软换行是否换行
  // 背景颜色列表
  globalBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State globalBackgroundColor: ResourceColor | undefined = undefined // 背景颜色
  // 是否允许markdown控件自身响应滑动列表
  openGestureSwipeList: Array<boolean> = booleanListGeneralData
  @State openGestureSwipe: boolean = false // 是否允许markdown控件自身响应滑动
  // 是否开启响应滑动测试列表
  openGestureSwipeTestList: Array<boolean> = booleanListGeneralData
  @State openGestureSwipeTest: boolean = false // 是否开启响应滑动测试
  // ---------------- Banner专有配置
  // banner上外边距列表
  bannerMarginTopList: Array<number> = marginListGeneralData
  @State bannerMarginTop: number = 0 // banner上外边距
  // banner右外边距列表
  bannerMarginRightList: Array<number> = marginListGeneralData
  @State bannerMarginRight: number = 0 // banner右外边距
  // banner下外边距列表
  bannerMarginBottomList: Array<number> = marginListGeneralData
  @State bannerMarginBottom: number = 0 // banner下外边距
  // banner左外边距列表
  bannerMarginLeftList: Array<number> = marginListGeneralData
  @State bannerMarginLeft: number = 0 // banner左外边距
  // banner上内边距列表
  bannerPaddingTopList: Array<number> = marginListGeneralData
  @State bannerPaddingTop: number = 0 // banner上内边距
  // banner右内边距列表
  bannerPaddingRightList: Array<number> = marginListGeneralData
  @State bannerPaddingRight: number = 0 // banner右内边距
  // banner下内边距列表
  bannerPaddingBottomList: Array<number> = marginListGeneralData
  @State bannerPaddingBottom: number = 0 // banner下内边距
  // banner左内边距列表
  bannerPaddingLeftList: Array<number> = marginListGeneralData
  @State bannerPaddingLeft: number = 0 // banner左内边距
  @State bannerData: BannerData = new BannerData() // 配置数据内容
  heightMD: number = 30 * 1 // 乘以行数
  @State isExpanded1: boolean = false // 控制展开/折叠状态
  @State isExpanded2: boolean = false // 控制展开/折叠状态

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "Banner配置页面",
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
            GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 }, offset: 0, order: 0 }) {
              Text(`${item}`)
                .fontSize(12)
                .fontColor('#FFFFFFFF')
                .backgroundColor('#FFEE82EE')
                .height(25).width('100%')
                .padding(5)
                .borderRadius(5)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Clip })
                .onClick(() => {
                  // ---------- 通用
                  this.bannerData._isFull = this.isFull
                  this.bannerData._incrementalAnalysis = this.incrementalAnalysis
                  this.bannerData._time = this.time
                  this.bannerData._textNumber = this.textNumber
                  this.bannerData._isMarkdownParserSync = this.isMarkdownParserSync
                  this.bannerData._isOnCopy = this.isOnCopy
                  this.bannerData._blockMarginTop = this.blockMarginTop
                  this.bannerData._blockMarginRight = this.blockMarginRight
                  this.bannerData._blockMarginBottom = this.blockMarginBottom
                  this.bannerData._blockMarginLeft = this.blockMarginLeft
                  this.bannerData._markdownBlockSpacing = this.markdownBlockSpacing
                  this.bannerData._isLineBreak = this.isLineBreak
                  this.bannerData._backgroundColor = this.globalBackgroundColor
                  this.bannerData._openGestureSwipe = this.openGestureSwipe
                  this.bannerData._openGestureSwipeTest = this.openGestureSwipeTest
                  this.bannerData._pagePath = `${this.rawFilePath}/${item}`
                  // ---------- 专有
                  this.bannerData.bannerMarginTop = this.bannerMarginTop
                  this.bannerData.bannerMarginRight = this.bannerMarginRight
                  this.bannerData.bannerMarginBottom = this.bannerMarginBottom
                  this.bannerData.bannerMarginLeft = this.bannerMarginLeft
                  this.bannerData.bannerPaddingTop = this.bannerPaddingTop
                  this.bannerData.bannerPaddingRight = this.bannerPaddingRight
                  this.bannerData.bannerPaddingBottom = this.bannerPaddingBottom
                  this.bannerData.bannerPaddingLeft = this.bannerPaddingLeft
                  // ---------- 跳转到详情
                  router.pushUrl({ url: "pages/BannerDetailsPage", params: this.bannerData })
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

          // 专有样式配置
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
                  titleStr: "banner上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bannerMarginTopList,
                  allData: this.bannerMarginTop
                })
                BaseTabComponent({
                  titleStr: "banner右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bannerMarginRightList,
                  allData: this.bannerMarginRight
                })
                BaseTabComponent({
                  titleStr: "banner下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bannerMarginBottomList,
                  allData: this.bannerMarginBottom
                })
                BaseTabComponent({
                  titleStr: "banner左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bannerMarginLeftList,
                  allData: this.bannerMarginLeft
                })
                BaseTabComponent({
                  titleStr: "banner上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bannerPaddingTopList,
                  allData: this.bannerPaddingTop
                })
                BaseTabComponent({
                  titleStr: "banner右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bannerPaddingRightList,
                  allData: this.bannerPaddingRight
                })
                BaseTabComponent({
                  titleStr: "banner下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bannerPaddingBottomList,
                  allData: this.bannerPaddingBottom
                })
                BaseTabComponent({
                  titleStr: "banner左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bannerPaddingLeftList,
                  allData: this.bannerPaddingLeft
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
    .backgroundColor($r('app.color.page_background'))
    .height("90%")
  }
}