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
  textNumberListGeneralData,
  textSizeListGeneralData,
  textTypefaceListGeneralData,
  timeListGeneralData
} from '../model/GeneralData'
import { LatexMathData } from '../model/LatexMathData'

// import { LatexMathColorFormat } from '@cangjie-tpc/markdown_arkui'

@Entry
@Component
struct LatexMathPage {
  // ---------------- 通用
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "005_LatexMath"
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
  // LaTeX数学公式上外边距列表
  latexMathMarginTopList: Array<number> = marginListGeneralData
  @State // LaTeX数学公式上外边距
  latexMathMarginTop: number = 8
  // LaTeX数学公式右外边距列表
  latexMathMarginRightList: Array<number> = marginListGeneralData
  @State // LaTeX数学公式右外边距
  latexMathMarginRight: number = 8
  // LaTeX数学公式下外边距列表
  latexMathMarginBottomList: Array<number> = marginListGeneralData
  @State // LaTeX数学公式下外边距
  latexMathMarginBottom: number = 8
  // LaTeX数学公式左外边距列表
  latexMathMarginLeftList: Array<number> = marginListGeneralData
  @State // LaTeX数学公式左外边距
  latexMathMarginLeft: number = 8
  // LaTeX数学公式上内边距列表
  latexMathPaddingTopList: Array<number> = marginListGeneralData
  @State // LaTeX数学公式上内边距
  latexMathPaddingTop: number = 0
  // LaTeX数学公式右内边距列表
  latexMathPaddingRightList: Array<number> = marginListGeneralData
  @State // LaTeX数学公式右内边距
  latexMathPaddingRight: number = 0
  // LaTeX数学公式下内边距列表
  latexMathPaddingBottomList: Array<number> = marginListGeneralData
  @State // LaTeX数学公式下内边距
  latexMathPaddingBottom: number = 0
  // LaTeX数学公式左内边距列表
  latexMathPaddingLeftList: Array<number> = marginListGeneralData
  @State // LaTeX数学公式左内边距
  latexMathPaddingLeft: number = 0
  // 数学公式未加载状态是否显示文字列表
  latexMathDefaultTextList: Array<boolean> = booleanListGeneralData
  @State // 数学公式未加载状态是否显示文字
  latexMathDefaultText: boolean = true
  // 数学公式未加载状态文本颜色列表
  latexMathDefaultTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 数学公式未加载状态文本颜色
  latexMathDefaultTextFontColor: ResourceColor | undefined = undefined
  // 数学公式未加载状态文本尺寸列表
  latexMathDefaultTextFontSizeList: Array<number> = textSizeListGeneralData
  @State // 数学公式未加载状态文本尺寸
  latexMathDefaultTextFontSize: number = 14
  // 数学公式未加载状态文本字体样式列表
  latexMathDefaultTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 数学公式未加载状态文本字体样式
  latexMathDefaultTextFontStyle: FontStyle = FontStyle.Normal
  // 数学公式未加载状态文本字体粗细列表
  latexMathDefaultTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State // 数学公式未加载状态文本字体粗细
  latexMathDefaultTextFontWeight: FontWeight = FontWeight.Normal
  // 数学公式未加载状态文本字体列表
  latexMathDefaultTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // 数学公式未加载状态文本字体
  latexMathDefaultTextFontFamily: string = 'HarmonyOS Sans'
  // 数学公式文本大小列表
  latexMathTextSizeList: Array<number> = textSizeListGeneralData
  @State // 数学公式文本大小
  latexMathTextSize: number = 16
  // 数学公式背景色列表
  latexMathBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 数学公式背景色
  latexMathBackgroundColor: ResourceColor | undefined = undefined
  // 数学公式文本颜色列表
  latexMathTextColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 数学公式文本颜色
  latexMathTextColor: ResourceColor | undefined = undefined
  // 数学公式生成图片格式列表
  // latexMathColorFormatList: Array<number> = [LatexMathColorFormat.COLOR_FORMAT_BGRA_8888, LatexMathColorFormat.COLOR_FORMAT_RGB_565]
  @State // 数学公式生成图片格式
  // latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
  // 块结构的数学公式是否居中列表
  latexMathBlockCenterList: Array<boolean> = booleanListGeneralData
  @State // 块结构的数学公式是否居中
  latexMathBlockCenter: boolean = false
  // 数学公式字体路径列表
  latexMathResPathList: Array<string> = ["/data/storage/el1/bundle/entry/resources/resfile/res"]
  @State // 数学公式字体路径
  latexMathResPath: string = "/data/storage/el1/bundle/entry/resources/resfile/res"
  @State // 配置数据内容
  latexMathData: LatexMathData = new LatexMathData()
  @State isExpanded1: boolean = false // 控制展开/折叠状态 - 通用样式配置
  @State isExpanded2: boolean = false // 控制展开/折叠状态 - 边距设置
  @State isExpanded3: boolean = false // 控制展开/折叠状态 - 文本设置

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "数学公式配置页面",
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
                this.latexMathData._isFull = this.isFull
                this.latexMathData._incrementalAnalysis = this.incrementalAnalysis
                this.latexMathData._enableParseThrottle = this.enableParseThrottle
                this.latexMathData._parseThrottleMs = this.parseThrottleMs
                this.latexMathData._time = this.time
                this.latexMathData._textNumber = this.textNumber
                this.latexMathData._isMarkdownParserSync = this.isMarkdownParserSync
                this.latexMathData._isOnCopy = this.isOnCopy
                this.latexMathData._blockMarginTop = this.blockMarginTop
                this.latexMathData._blockMarginRight = this.blockMarginRight
                this.latexMathData._blockMarginBottom = this.blockMarginBottom
                this.latexMathData._blockMarginLeft = this.blockMarginLeft
                this.latexMathData._markdownBlockSpacing = this.markdownBlockSpacing
                this.latexMathData._isLineBreak = this.isLineBreak
                this.latexMathData._backgroundColor = this.globalBackgroundColor
                this.latexMathData._openGestureSwipe = this.openGestureSwipe
                this.latexMathData._openGestureSwipeTest = this.openGestureSwipeTest
                this.latexMathData._pagePath = `${this.rawFilePath}/${item}`

                // ---------- 专有
                this.latexMathData._latexMathMarginTop = this.latexMathMarginTop
                this.latexMathData._latexMathMarginRight = this.latexMathMarginRight
                this.latexMathData._latexMathMarginBottom = this.latexMathMarginBottom
                this.latexMathData._latexMathMarginLeft = this.latexMathMarginLeft
                this.latexMathData._latexMathPaddingTop = this.latexMathPaddingTop
                this.latexMathData._latexMathPaddingRight = this.latexMathPaddingRight
                this.latexMathData._latexMathPaddingBottom = this.latexMathPaddingBottom
                this.latexMathData._latexMathPaddingLeft = this.latexMathPaddingLeft
                this.latexMathData._latexMathDefaultText = this.latexMathDefaultText
                this.latexMathData._latexMathDefaultTextFontColor = this.latexMathDefaultTextFontColor
                this.latexMathData._latexMathDefaultTextFontSize = this.latexMathDefaultTextFontSize
                this.latexMathData._latexMathDefaultTextFontStyle = this.latexMathDefaultTextFontStyle
                this.latexMathData._latexMathDefaultTextFontWeight = this.latexMathDefaultTextFontWeight
                this.latexMathData._latexMathDefaultTextFontFamily = this.latexMathDefaultTextFontFamily
                this.latexMathData._latexMathTextSize = this.latexMathTextSize
                this.latexMathData._latexMathBackgroundColor = this.latexMathBackgroundColor
                this.latexMathData._latexMathTextColor = this.latexMathTextColor
                // this.latexMathData._latexMathColorFormat = this.latexMathColorFormat
                this.latexMathData._latexMathBlockCenter = this.latexMathBlockCenter
                this.latexMathData._latexMathResPath = this.latexMathResPath
                // ---------- 跳转到详情
                router.pushUrl({ url: "pages/LatexMathDetailsPage", params: this.latexMathData })
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
                  titleStr: "Markdown全局上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginTopList,
                  allData: this.blockMarginTop
                })
                BaseTabComponent({
                  titleStr: "Markdown全局右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginRightList,
                  allData: this.blockMarginRight
                })
                BaseTabComponent({
                  titleStr: "Markdown全局下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginBottomList,
                  allData: this.blockMarginBottom
                })
                BaseTabComponent({
                  titleStr: "Markdown全局左外边距 - ",
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
              Text("边距和其他设置")
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
                  titleStr: "LaTeX数学公式上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.latexMathMarginTopList,
                  allData: this.latexMathMarginTop
                })
                BaseTabComponent({
                  titleStr: "LaTeX数学公式右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.latexMathMarginRightList,
                  allData: this.latexMathMarginRight
                })
                BaseTabComponent({
                  titleStr: "LaTeX数学公式下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.latexMathMarginBottomList,
                  allData: this.latexMathMarginBottom
                })
                BaseTabComponent({
                  titleStr: "LaTeX数学公式左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.latexMathMarginLeftList,
                  allData: this.latexMathMarginLeft
                })
                BaseTabComponent({
                  titleStr: "LaTeX数学公式上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.latexMathPaddingTopList,
                  allData: this.latexMathPaddingTop
                })
                BaseTabComponent({
                  titleStr: "LaTeX数学公式右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.latexMathPaddingRightList,
                  allData: this.latexMathPaddingRight
                })
                BaseTabComponent({
                  titleStr: "LaTeX数学公式下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.latexMathPaddingBottomList,
                  allData: this.latexMathPaddingBottom
                })
                BaseTabComponent({
                  titleStr: "LaTeX数学公式左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.latexMathPaddingLeftList,
                  allData: this.latexMathPaddingLeft
                })
                // BaseTabComponent({
                //   titleStr: "数学公式生成图片格式 - ",
                //   typeEnum: TypeEnum.IS_LATEX_FORMAT,
                //   allListData: this.latexMathColorFormatList,
                //   allData: this.latexMathColorFormat
                // })
                BaseTabComponent({
                  titleStr: "块结构的数学公式是否居中 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.latexMathBlockCenterList,
                  allData: this.latexMathBlockCenter
                })
                // BaseTabComponent({
                //           titleStr: "数学公式字体路径 - ",
                //           typeEnum: TypeEnum.IS_STRING,
                //           allListData: this.latexMathResPathList,
                //           allData: this.latexMathResPath
                // })
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

          // 文本设置
          Column() {
            Row() {
              Text("文本设置")
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
                  titleStr: "数学公式未加载状态是否显示文字 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.latexMathDefaultTextList,
                  allData: this.latexMathDefaultText
                })
                BaseTabComponent({
                  titleStr: "数学公式未加载状态文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.latexMathDefaultTextFontColorList,
                  allData: this.latexMathDefaultTextFontColor
                })
                BaseTabComponent({
                  titleStr: "数学公式未加载状态文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.latexMathDefaultTextFontSizeList,
                  allData: this.latexMathDefaultTextFontSize
                })
                BaseTabComponent({
                  titleStr: "数学公式未加载状态文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.latexMathDefaultTextFontStyleList,
                  allData: this.latexMathDefaultTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "数学公式未加载状态文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.latexMathDefaultTextFontWeightList,
                  allData: this.latexMathDefaultTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "数学公式未加载状态文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.latexMathDefaultTextFontFamilyList,
                  allData: this.latexMathDefaultTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "数学公式文本大小 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.latexMathTextSizeList,
                  allData: this.latexMathTextSize
                })
                BaseTabComponent({
                  titleStr: "数学公式背景色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.latexMathBackgroundColorList,
                  allData: this.latexMathBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "数学公式文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.latexMathTextColorList,
                  allData: this.latexMathTextColor
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