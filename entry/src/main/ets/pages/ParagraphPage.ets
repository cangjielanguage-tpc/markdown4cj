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
  textLineHeightListGeneralData,
  textNumberListGeneralData,
  textSizeListGeneralData,
  textTypefaceListGeneralData,
  textWordSpaceListGeneralData,
  timeListGeneralData
} from '../model/GeneralData'
import { ParagraphData } from '../model/ParagraphData'

@Entry
@Component
struct ParagraphPage {
  // ---------------- 通用
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "002_Paragraph"
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
  // 段落背景颜色列表
  paragraphBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 段落背景颜色
  paragraphBackgroundColor: ResourceColor | undefined = undefined
  // 段落上外边距列表
  paragraphMarginTopList: Array<number> = marginListGeneralData
  @State // 段落上外边距
  paragraphMarginTop: number = 0
  // 段落右外边距列表
  paragraphMarginRightList: Array<number> = marginListGeneralData
  @State // 段落右外边距
  paragraphMarginRight: number = 0
  // 段落下外边距列表
  paragraphMarginBottomList: Array<number> = marginListGeneralData
  @State // 段落下外边距
  paragraphMarginBottom: number = 0
  // 段落左外边距列表
  paragraphMarginLeftList: Array<number> = marginListGeneralData
  @State // 段落左外边距
  paragraphMarginLeft: number = 0
  // 段落上内边距列表
  paragraphPaddingTopList: Array<number> = marginListGeneralData
  @State // 段落上内边距
  paragraphPaddingTop: number = 0
  // 段落右内边距列表
  paragraphPaddingRightList: Array<number> = marginListGeneralData
  @State // 段落右内边距
  paragraphPaddingRight: number = 0
  // 段落下内边距列表
  paragraphPaddingBottomList: Array<number> = marginListGeneralData
  @State // 段落下内边距
  paragraphPaddingBottom: number = 0
  // 段落左内边距列表
  paragraphPaddingLeftList: Array<number> = marginListGeneralData
  @State // 段落左内边距
  paragraphPaddingLeft: number = 0
  // 段落文本颜色列表
  paragraphTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 段落文本颜色
  paragraphTextFontColor: ResourceColor | undefined = undefined
  // 段落文本尺寸列表
  paragraphTextFontSizeList: Array<number> = textSizeListGeneralData
  @State // 段落文本尺寸
  paragraphTextFontSize: number = 14
  // 段落文本字体样式列表
  paragraphTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 段落文本字体样式
  paragraphTextFontStyle: FontStyle = FontStyle.Normal
  // 段落文本字体粗细列表
  paragraphTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State // 段落文本字体粗细
  paragraphTextFontWeight: FontWeight = FontWeight.Normal
  // 段落文本字体列表
  paragraphTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // 段落文本字体
  paragraphTextFontFamily: string = 'HarmonyOS Sans'
  // 段落文本行高列表
  paragraphTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State // 段落文本行高
  paragraphTextLineHeight: number = 22
  // 段落文本字符间距列表
  paragraphTextLetterSpacingList: Array<number> = textWordSpaceListGeneralData
  @State // 段落文本字符间距
  paragraphTextLetterSpacing: number = 0
  // 是否显示标题段落高亮效果
  showHighlightList: Array<boolean> = booleanListGeneralData
  @State showHighlight: boolean = true // 是否全量加载Markdown文本
  // 段落加载动画启用列表
  paragraphAnimationEnabledList: Array<boolean> = booleanListGeneralData
  @State paragraphAnimationEnabled: boolean = false // 段落加载动画是否启用
  // 段落加载动画时长列表
  paragraphAnimationDurationList: Array<number> = [0, 200, 500, 1000, 2000]
  @State paragraphAnimationDuration: number = 0 // 段落加载动画时长（ms）
  @State // 配置数据内容
  paragraphData: ParagraphData = new ParagraphData()
  @State isExpanded1: boolean = false // 控制展开/折叠状态
  @State isExpanded2: boolean = false // 控制展开/折叠状态
  @State isExpanded3: boolean = false // 控制展开/折叠状态

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "段落配置页面",
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
                  this.paragraphData._isFull = this.isFull
                  this.paragraphData._incrementalAnalysis = this.incrementalAnalysis
                  this.paragraphData._enableParseThrottle = this.enableParseThrottle
                  this.paragraphData._parseThrottleMs = this.parseThrottleMs
                  this.paragraphData._time = this.time
                  this.paragraphData._textNumber = this.textNumber
                  this.paragraphData._isMarkdownParserSync = this.isMarkdownParserSync
                  this.paragraphData._isOnCopy = this.isOnCopy
                  this.paragraphData._blockMarginTop = this.blockMarginTop
                  this.paragraphData._blockMarginRight = this.blockMarginRight
                  this.paragraphData._blockMarginBottom = this.blockMarginBottom
                  this.paragraphData._blockMarginLeft = this.blockMarginLeft
                  this.paragraphData._markdownBlockSpacing = this.markdownBlockSpacing
                  this.paragraphData._isLineBreak = this.isLineBreak
                  this.paragraphData._backgroundColor = this.globalBackgroundColor
                  this.paragraphData._openGestureSwipe = this.openGestureSwipe
                  this.paragraphData._openGestureSwipeTest = this.openGestureSwipeTest
                  this.paragraphData._pagePath = `${this.rawFilePath}/${item}`
                  this.paragraphData._showHighlight = this.showHighlight

                  // ---------- 专有
                  this.paragraphData._paragraphBackgroundColor = this.paragraphBackgroundColor
                  this.paragraphData._paragraphMarginTop = this.paragraphMarginTop
                  this.paragraphData._paragraphMarginRight = this.paragraphMarginRight
                  this.paragraphData._paragraphMarginBottom = this.paragraphMarginBottom
                  this.paragraphData._paragraphMarginLeft = this.paragraphMarginLeft
                  this.paragraphData._paragraphPaddingTop = this.paragraphPaddingTop
                  this.paragraphData._paragraphPaddingRight = this.paragraphPaddingRight
                  this.paragraphData._paragraphPaddingBottom = this.paragraphPaddingBottom
                  this.paragraphData._paragraphPaddingLeft = this.paragraphPaddingLeft
                  this.paragraphData._paragraphTextFontColor = this.paragraphTextFontColor
                  this.paragraphData._paragraphTextFontSize = this.paragraphTextFontSize
                  this.paragraphData._paragraphTextFontStyle = this.paragraphTextFontStyle
                  this.paragraphData._paragraphTextFontWeight = this.paragraphTextFontWeight
                  this.paragraphData._paragraphTextFontFamily = this.paragraphTextFontFamily
                  this.paragraphData._paragraphTextLineHeight = this.paragraphTextLineHeight
                  this.paragraphData._paragraphTextLetterSpacing = this.paragraphTextLetterSpacing
                  this.paragraphData._paragraphAnimationEnabled = this.paragraphAnimationEnabled
                  this.paragraphData._paragraphAnimationDuration = this.paragraphAnimationDuration
                  // ---------- 跳转到详情
                  router.pushUrl({ url: "pages/ParagraphDetailsPage", params: this.paragraphData })
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
                  titleStr: "段落上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.paragraphMarginTopList,
                  allData: this.paragraphMarginTop
                })
                BaseTabComponent({
                  titleStr: "段落右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.paragraphMarginRightList,
                  allData: this.paragraphMarginRight
                })
                BaseTabComponent({
                  titleStr: "段落下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.paragraphMarginBottomList,
                  allData: this.paragraphMarginBottom
                })
                BaseTabComponent({
                  titleStr: "段落左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.paragraphMarginLeftList,
                  allData: this.paragraphMarginLeft
                })
                BaseTabComponent({
                  titleStr: "段落上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.paragraphPaddingTopList,
                  allData: this.paragraphPaddingTop
                })
                BaseTabComponent({
                  titleStr: "段落右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.paragraphPaddingRightList,
                  allData: this.paragraphPaddingRight
                })
                BaseTabComponent({
                  titleStr: "段落下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.paragraphPaddingBottomList,
                  allData: this.paragraphPaddingBottom
                })
                BaseTabComponent({
                  titleStr: "段落左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.paragraphPaddingLeftList,
                  allData: this.paragraphPaddingLeft
                })
                BaseTabComponent({
                  titleStr: "段落文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.paragraphTextFontColorList,
                  allData: this.paragraphTextFontColor
                })
                BaseTabComponent({
                  titleStr: "段落文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.paragraphTextFontSizeList,
                  allData: this.paragraphTextFontSize
                })
                BaseTabComponent({
                  titleStr: "段落文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.paragraphTextFontStyleList,
                  allData: this.paragraphTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "段落文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.paragraphTextFontWeightList,
                  allData: this.paragraphTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "段落文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.paragraphTextFontFamilyList,
                  allData: this.paragraphTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "段落文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.paragraphTextLineHeightList,
                  allData: this.paragraphTextLineHeight
                })
                BaseTabComponent({
                  titleStr: "段落文本字符间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.paragraphTextLetterSpacingList,
                  allData: this.paragraphTextLetterSpacing
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
              Text("特殊设置")
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
                  titleStr: "是否开启标题段落高亮显示 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.showHighlightList,
                  allData: this.showHighlight
                })
                BaseTabComponent({
                  titleStr: "段落加载动画启用 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.paragraphAnimationEnabledList,
                  allData: this.paragraphAnimationEnabled
                })
                BaseTabComponent({
                  titleStr: "段落加载动画时长(ms) - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.paragraphAnimationDurationList,
                  allData: this.paragraphAnimationDuration
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