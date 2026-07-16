import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseTabComponent } from '../component/BaseTabComponent'
import { TypeEnum } from '../model/TypeEnum'
import {
  booleanListGeneralData,
  colorListGeneralData,
  fontStyleListGeneraData,
  fontWeightListGeneraData,
  marginListGeneralData,
  textDecorationStyleListGeneralData,
  textLineHeightListGeneralData,
  textNumberListGeneralData,
  textSizeListGeneralData,
  textTypefaceListGeneralData,
  textWordSpaceListGeneralData,
  timeListGeneralData
} from '../model/GeneralData'
import { HTMLData } from '../model/HTMLData'

@Entry
@Component
struct HTMLPage {
  // ---------------- 通用
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "025_HTML"
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
  // Markdown全局上外边距列表
  blockMarginTopList: Array<number> = marginListGeneralData
  @State // Markdown全局上外边距
  blockMarginTop: number = 8
  // Markdown全局右外边距列表
  blockMarginRightList: Array<number> = marginListGeneralData
  @State // Markdown全局右外边距
  blockMarginRight: number = 8
  // Markdown全局下外边距列表
  blockMarginBottomList: Array<number> = marginListGeneralData
  @State // Markdown全局下外边距
  blockMarginBottom: number = 8
  // Markdown全局左外边距列表
  blockMarginLeftList: Array<number> = marginListGeneralData
  @State // Markdown全局左外边距
  blockMarginLeft: number = 8
  // 模块间上下间距列表
  markdownBlockSpacingList: Array<number> = marginListGeneralData
  @State // 模块间上下间距
  markdownBlockSpacing: number = 8
  // 软换行是否换行列列表
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
  // 是否启用解析节流列表
  enableParseThrottleList: Array<boolean> = booleanListGeneralData
  @State // 是否启用解析节流
  enableParseThrottle: boolean = false
  // 解析节流间隔列表
  parseThrottleMsList: Array<number> = timeListGeneralData
  @State // 解析节流间隔（ms）
  parseThrottleMs: number = 200
  // ---------------- 专有
  // HTML下划线文本颜色列表
  htmlUnderlineTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // HTML下划线文本颜色
  htmlUnderlineTextFontColor: ResourceColor | undefined = undefined
  // HTML下划线文本尺寸列表
  htmlUnderlineTextFontSizeList: Array<number> = textSizeListGeneralData
  @State // HTML下划线文本尺寸
  htmlUnderlineTextFontSize: number | undefined = undefined
  // HTML下划线文本字体样式列表
  htmlUnderlineTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // HTML下划线文本字体样式
  htmlUnderlineTextFontStyle: FontStyle | undefined = undefined
  // HTML下划线文本字体粗细列表
  htmlUnderlineTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State // HTML下划线文本字体粗细
  htmlUnderlineTextFontWeight: FontWeight | undefined = undefined
  // HTML下划线文本字体列表
  htmlUnderlineTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // HTML下划线文本字体
  htmlUnderlineTextFontFamily: string | undefined = undefined
  // HTML下划线文本行高列表
  htmlUnderlineTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State // HTML下划线文本行高
  htmlUnderlineTextLineHeight: number | undefined = undefined
  // HTML下划线文本字符间距列表
  htmlUnderlineTextLetterSpacingList: Array<number> = textWordSpaceListGeneralData
  @State // HTML下划线文本字符间距
  htmlUnderlineTextLetterSpacing: number | undefined = undefined
  // HTML下划线文本装饰线颜色列表
  htmlUnderlineTextDecorationColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // HTML下划线文本装饰线颜色
  htmlUnderlineTextDecorationColor: ResourceColor | undefined = undefined
  // HTML下划线文本装饰线样式列表
  htmlUnderlineTextDecorationStyleList: Array<TextDecorationStyle> = textDecorationStyleListGeneralData
  @State // HTML下划线文本装饰线样式
  htmlUnderlineTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID
  @State htmlData: HTMLData = new HTMLData() // 配置数据内容
  @State isExpanded1: boolean = false // 控制展开/折叠状态
  @State isExpanded2: boolean = false // 控制展开/折叠状态

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "HTML配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )

      // md文档展示部分
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
                  this.htmlData._isFull = this.isFull
                  this.htmlData._incrementalAnalysis = this.incrementalAnalysis
                  this.htmlData._enableParseThrottle = this.enableParseThrottle
                  this.htmlData._parseThrottleMs = this.parseThrottleMs
                  this.htmlData._time = this.time
                  this.htmlData._textNumber = this.textNumber
                  this.htmlData._isMarkdownParserSync = this.isMarkdownParserSync
                  this.htmlData._isOnCopy = this.isOnCopy
                  this.htmlData._blockMarginTop = this.blockMarginTop
                  this.htmlData._blockMarginRight = this.blockMarginRight
                  this.htmlData._blockMarginBottom = this.blockMarginBottom
                  this.htmlData._blockMarginLeft = this.blockMarginLeft
                  this.htmlData._markdownBlockSpacing = this.markdownBlockSpacing
                  this.htmlData._isLineBreak = this.isLineBreak
                  this.htmlData._backgroundColor = this.globalBackgroundColor
                  this.htmlData._openGestureSwipe = this.openGestureSwipe
                  this.htmlData._openGestureSwipeTest = this.openGestureSwipeTest
                  this.htmlData._pagePath = `${this.rawFilePath}/${item}`

                  // ---------- 专有
                  this.htmlData._htmlUnderlineTextFontColor = this.htmlUnderlineTextFontColor
                  this.htmlData._htmlUnderlineTextFontSize = this.htmlUnderlineTextFontSize
                  this.htmlData._htmlUnderlineTextFontStyle = this.htmlUnderlineTextFontStyle
                  this.htmlData._htmlUnderlineTextFontWeight = this.htmlUnderlineTextFontWeight
                  this.htmlData._htmlUnderlineTextFontFamily = this.htmlUnderlineTextFontFamily
                  this.htmlData._htmlUnderlineTextLineHeight = this.htmlUnderlineTextLineHeight
                  this.htmlData._htmlUnderlineTextLetterSpacing = this.htmlUnderlineTextLetterSpacing
                  this.htmlData._htmlUnderlineTextDecorationColor = this.htmlUnderlineTextDecorationColor
                  this.htmlData._htmlUnderlineTextDecorationStyle = this.htmlUnderlineTextDecorationStyle
                  // ---------- 跳转到详情
                  router.pushUrl({ url: "pages/HTMLDetailsPage", params: this.htmlData })
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
                  titleStr: "Markdown块上边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginTopList,
                  allData: this.blockMarginTop
                })
                BaseTabComponent({
                  titleStr: "Markdown块右边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginRightList,
                  allData: this.blockMarginRight
                })
                BaseTabComponent({
                  titleStr: "Markdown块下边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginBottomList,
                  allData: this.blockMarginBottom
                })
                BaseTabComponent({
                  titleStr: "Markdown块左边距 - ",
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
                  titleStr: "是否换行 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.isLineBreakList,
                  allData: this.isLineBreak
                })
                BaseTabComponent({
                  titleStr: "全局背景色 - ",
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
                  titleStr: "HTML下划线文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.htmlUnderlineTextFontColorList,
                  allData: this.htmlUnderlineTextFontColor
                })
                BaseTabComponent({
                  titleStr: "HTML下划线文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.htmlUnderlineTextFontSizeList,
                  allData: this.htmlUnderlineTextFontSize
                })
                BaseTabComponent({
                  titleStr: "HTML下划线文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.htmlUnderlineTextFontStyleList,
                  allData: this.htmlUnderlineTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "HTML下划线文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.htmlUnderlineTextFontWeightList,
                  allData: this.htmlUnderlineTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "HTML下划线文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.htmlUnderlineTextFontFamilyList,
                  allData: this.htmlUnderlineTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "HTML下划线文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.htmlUnderlineTextLineHeightList,
                  allData: this.htmlUnderlineTextLineHeight
                })
                BaseTabComponent({
                  titleStr: "HTML下划线文本字符间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.htmlUnderlineTextLetterSpacingList,
                  allData: this.htmlUnderlineTextLetterSpacing
                })
                BaseTabComponent({
                  titleStr: "HTML下划线文本装饰线颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.htmlUnderlineTextDecorationColorList,
                  allData: this.htmlUnderlineTextDecorationColor
                })
                BaseTabComponent({
                  titleStr: "HTML下划线文本装饰线样式 - ",
                  typeEnum: TypeEnum.IS_DECORATION_STYLE,
                  allListData: this.htmlUnderlineTextDecorationStyleList,
                  allData: this.htmlUnderlineTextDecorationStyle
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