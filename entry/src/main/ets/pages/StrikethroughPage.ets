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
import { StrikethroughData } from '../model/StrikethroughData'

@Entry
@Component
struct StrikethroughPage {
  // ---------------- 通用
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "019_Strikethrough"
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
  // 删除线文本颜色列表
  strikethroughTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 删除线文本颜色
  strikethroughTextFontColor: ResourceColor | undefined = undefined
  // 删除线文本尺寸列表
  strikethroughTextFontSizeList: Array<number> = textSizeListGeneralData
  @State // 删除线文本尺寸
  strikethroughTextFontSize: number | undefined = undefined
  // 删除线文本字体样式列表
  strikethroughTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 删除线文本字体样式
  strikethroughTextFontStyle: FontStyle | undefined = undefined
  // 删除线文本字体粗细列表
  strikethroughTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State // 删除线文本字体粗细
  strikethroughTextFontWeight: FontWeight | undefined = undefined
  // 删除线文本字体列表
  strikethroughTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // 删除线文本字体
  strikethroughTextFontFamily: string | undefined = undefined
  // 删除线文本行高列表
  strikethroughTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State // 删除线文本行高
  strikethroughTextLineHeight: number | undefined = undefined
  // 删除线文本字符间距列表
  strikethroughTextLetterSpacingList: Array<number> = textWordSpaceListGeneralData
  @State // 删除线文本字符间距
  strikethroughTextLetterSpacing: number | undefined = undefined
  // 删除线文本装饰线颜色列表
  strikethroughTextDecorationColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 删除线文本装饰线颜色
  strikethroughTextDecorationColor: ResourceColor | undefined = undefined
  // 删除线文本装饰线样式列表
  strikethroughTextDecorationStyleList: Array<TextDecorationStyle> = textDecorationStyleListGeneralData
  @State // 删除线文本装饰线样式
  strikethroughTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID
  @State // 配置数据内容
  strikethroughData: StrikethroughData = new StrikethroughData()
  @State isExpanded1: boolean = false // 控制展开/折叠状态
  @State isExpanded2: boolean = false // 控制展开/折叠状态

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "删除线配置页面",
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
                  this.strikethroughData._isFull = this.isFull
                  this.strikethroughData._incrementalAnalysis = this.incrementalAnalysis
                  this.strikethroughData._enableParseThrottle = this.enableParseThrottle
                  this.strikethroughData._parseThrottleMs = this.parseThrottleMs
                  this.strikethroughData._time = this.time
                  this.strikethroughData._textNumber = this.textNumber
                  this.strikethroughData._isMarkdownParserSync = this.isMarkdownParserSync
                  this.strikethroughData._isOnCopy = this.isOnCopy
                  this.strikethroughData._blockMarginTop = this.blockMarginTop
                  this.strikethroughData._blockMarginRight = this.blockMarginRight
                  this.strikethroughData._blockMarginBottom = this.blockMarginBottom
                  this.strikethroughData._blockMarginLeft = this.blockMarginLeft
                  this.strikethroughData._markdownBlockSpacing = this.markdownBlockSpacing
                  this.strikethroughData._isLineBreak = this.isLineBreak
                  this.strikethroughData._backgroundColor = this.globalBackgroundColor
                  this.strikethroughData._openGestureSwipe = this.openGestureSwipe
                  this.strikethroughData._openGestureSwipeTest = this.openGestureSwipeTest
                  this.strikethroughData._pagePath = `${this.rawFilePath}/${item}`

                  // ---------- 专有
                  this.strikethroughData._strikethroughTextFontColor = this.strikethroughTextFontColor
                  this.strikethroughData._strikethroughTextFontSize = this.strikethroughTextFontSize
                  this.strikethroughData._strikethroughTextFontStyle = this.strikethroughTextFontStyle
                  this.strikethroughData._strikethroughTextFontWeight = this.strikethroughTextFontWeight
                  this.strikethroughData._strikethroughTextFontFamily = this.strikethroughTextFontFamily
                  this.strikethroughData._strikethroughTextLineHeight = this.strikethroughTextLineHeight
                  this.strikethroughData._strikethroughTextLetterSpacing = this.strikethroughTextLetterSpacing
                  this.strikethroughData._strikethroughTextDecorationColor = this.strikethroughTextDecorationColor
                  this.strikethroughData._strikethroughTextDecorationStyle = this.strikethroughTextDecorationStyle
                  // ---------- 跳转到详情
                  router.pushUrl({ url: "pages/StrikethroughDetailsPage", params: this.strikethroughData })
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
                  titleStr: "删除线文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.strikethroughTextFontColorList,
                  allData: this.strikethroughTextFontColor
                })
                BaseTabComponent({
                  titleStr: "删除线文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.strikethroughTextFontSizeList,
                  allData: this.strikethroughTextFontSize
                })
                BaseTabComponent({
                  titleStr: "删除线文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.strikethroughTextFontStyleList,
                  allData: this.strikethroughTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "删除线文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.strikethroughTextFontWeightList,
                  allData: this.strikethroughTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "删除线文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.strikethroughTextFontFamilyList,
                  allData: this.strikethroughTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "删除线文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.strikethroughTextLineHeightList,
                  allData: this.strikethroughTextLineHeight
                })
                BaseTabComponent({
                  titleStr: "删除线文本字符间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.strikethroughTextLetterSpacingList,
                  allData: this.strikethroughTextLetterSpacing
                })
                BaseTabComponent({
                  titleStr: "删除线文本装饰线颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.strikethroughTextDecorationColorList,
                  allData: this.strikethroughTextDecorationColor
                })
                BaseTabComponent({
                  titleStr: "删除线文本装饰线样式 - ",
                  typeEnum: TypeEnum.IS_DECORATION_STYLE,
                  allListData: this.strikethroughTextDecorationStyleList,
                  allData: this.strikethroughTextDecorationStyle
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