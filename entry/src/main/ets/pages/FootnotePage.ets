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
  radiusListGeneraData,
  textDecorationStyleListGeneralData,
  textDecorationTypeListGeneralData,
  textLineHeightListGeneralData,
  textNumberListGeneralData,
  textSizeListGeneralData,
  textTypefaceListGeneralData,
  textWordSpaceListGeneralData,
  timeListGeneralData
} from '../model/GeneralData'
import { FootnoteData } from '../model/FootnoteData'

@Entry
@Component
struct FootnotePage {
  // ---------------- 通用
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "022_Footnote"
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
  @State footnoteData: FootnoteData = new FootnoteData() // 配置数据内容
  // ---------------- 专有
  // 脚注定义背景颜色列表
  footnoteDefBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 脚注定义背景颜色
  footnoteDefBackgroundColor: ResourceColor | undefined = undefined
  // 脚注定义上外边距列表
  footnoteDefMarginTopList: Array<number> = marginListGeneralData
  @State // 脚注定义上外边距
  footnoteDefMarginTop: number = 0
  // 脚注定义右外边距列表
  footnoteDefMarginRightList: Array<number> = marginListGeneralData
  @State // 脚注定义右外边距
  footnoteDefMarginRight: number = 0
  // 脚注定义下外边距列表
  footnoteDefMarginBottomList: Array<number> = marginListGeneralData
  @State // 脚注定义下外边距
  footnoteDefMarginBottom: number = 0
  // 脚注定义左外边距列表
  footnoteDefMarginLeftList: Array<number> = marginListGeneralData
  @State // 脚注定义左外边距
  footnoteDefMarginLeft: number = 0
  // 脚注定义上内边距列表
  footnoteDefPaddingTopList: Array<number> = marginListGeneralData
  @State // 脚注定义上内边距
  footnoteDefPaddingTop: number = 0
  // 脚注定义右内边距列表
  footnoteDefPaddingRightList: Array<number> = marginListGeneralData
  @State // 脚注定义右内边距
  footnoteDefPaddingRight: number = 0
  // 脚注定义下内边距列表
  footnoteDefPaddingBottomList: Array<number> = marginListGeneralData
  @State // 脚注定义下内边距
  footnoteDefPaddingBottom: number = 0
  // 脚注定义左内边距列表
  footnoteDefPaddingLeftList: Array<number> = marginListGeneralData
  @State // 脚注定义左内边距
  footnoteDefPaddingLeft: number = 0
  // 脚注引用文本颜色列表
  footnoteRefTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 脚注引用文本颜色
  footnoteRefTextFontColor: ResourceColor | undefined = undefined
  // 脚注引用文本尺寸列表
  footnoteRefTextFontSizeList: Array<number> = textSizeListGeneralData
  @State // 脚注引用文本尺寸
  footnoteRefTextFontSize: number = 12
  // 脚注引用文本字体样式列表
  footnoteRefTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 脚注引用文本字体样式
  footnoteRefTextFontStyle: FontStyle = FontStyle.Normal
  // 脚注引用文本字体粗细列表
  footnoteRefTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State // 脚注引用文本字体粗细
  footnoteRefTextFontWeight: FontWeight = FontWeight.Normal
  // 脚注引用文本字体列表
  footnoteRefTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // 脚注引用文本字体
  footnoteRefTextFontFamily: string = 'HarmonyOS Sans'
  // 脚注引用文本行高列表
  footnoteRefTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State // 脚注引用文本行高
  footnoteRefTextLineHeight: number = 18
  // 脚注引用文本字符间距列表
  footnoteRefTextLetterSpacingList: Array<number> = textWordSpaceListGeneralData
  @State // 脚注引用文本字符间距
  footnoteRefTextLetterSpacing: number = 0
  // 脚注引用文本装饰线类型列表
  footnoteRefTextDecorationTypeList: Array<TextDecorationType> = textDecorationTypeListGeneralData
  @State // 脚注引用文本装饰线类型
  footnoteRefTextDecorationType: TextDecorationType = TextDecorationType.Underline
  // 脚注引用文本装饰线颜色列表
  footnoteRefTextDecorationColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 脚注引用文本装饰线颜色
  footnoteRefTextDecorationColor: ResourceColor | undefined = undefined
  // 脚注引用文本装饰线样式列表
  footnoteRefTextDecorationStyleList: Array<TextDecorationStyle> = textDecorationStyleListGeneralData
  @State // 脚注引用文本装饰线样式
  footnoteRefTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID
  // 脚注引用文本背景颜色列表
  footnoteRefTextBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 脚注引用文本背景颜色
  footnoteRefTextBackgroundColor: ResourceColor | undefined = undefined
  // 脚注引用文本背景左上圆角列表
  footnoteRefTextBackgroundRadiusTopLeftList: Array<number> = radiusListGeneraData
  @State // 脚注引用文本背景左上圆角
  footnoteRefTextBackgroundRadiusTopLeft: number = 0
  // 脚注引用文本背景右上圆角列表
  footnoteRefTextBackgroundRadiusTopRightList: Array<number> = radiusListGeneraData
  @State // 脚注引用文本背景右上圆角
  footnoteRefTextBackgroundRadiusTopRight: number = 0
  // 脚注引用文本背景左下圆角列表
  footnoteRefTextBackgroundRadiusBottomLeftList: Array<number> = radiusListGeneraData
  @State // 脚注引用文本背景左下圆角
  footnoteRefTextBackgroundRadiusBottomLeft: number = 0
  // 脚注引用文本背景右下圆角列表
  footnoteRefTextBackgroundRadiusBottomRightList: Array<number> = radiusListGeneraData
  @State // 脚注引用文本背景右下圆角
  footnoteRefTextBackgroundRadiusBottomRight: number = 0
  @State isExpanded1: boolean = false // 控制展开/折叠状态 - 通用样式配置
  @State isExpanded2: boolean = false // 控制展开/折叠状态 - 脚注定义
  @State isExpanded3: boolean = false // 控制展开/折叠状态 - 脚注引用

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "脚注配置页面",
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
                  this.footnoteData._isFull = this.isFull
                  this.footnoteData._incrementalAnalysis = this.incrementalAnalysis
                  this.footnoteData._enableParseThrottle = this.enableParseThrottle
                  this.footnoteData._parseThrottleMs = this.parseThrottleMs
                  this.footnoteData._time = this.time
                  this.footnoteData._textNumber = this.textNumber
                  this.footnoteData._isMarkdownParserSync = this.isMarkdownParserSync
                  this.footnoteData._isOnCopy = this.isOnCopy
                  this.footnoteData._blockMarginTop = this.blockMarginTop
                  this.footnoteData._blockMarginRight = this.blockMarginRight
                  this.footnoteData._blockMarginBottom = this.blockMarginBottom
                  this.footnoteData._blockMarginLeft = this.blockMarginLeft
                  this.footnoteData._markdownBlockSpacing = this.markdownBlockSpacing
                  this.footnoteData._isLineBreak = this.isLineBreak
                  this.footnoteData._backgroundColor = this.globalBackgroundColor
                  this.footnoteData._openGestureSwipe = this.openGestureSwipe
                  this.footnoteData._openGestureSwipeTest = this.openGestureSwipeTest
                  this.footnoteData._pagePath = `${this.rawFilePath}/${item}`

                  // ---------- 专有
                  this.footnoteData._footnoteDefBackgroundColor = this.footnoteDefBackgroundColor
                  this.footnoteData._footnoteDefMarginTop = this.footnoteDefMarginTop
                  this.footnoteData._footnoteDefMarginRight = this.footnoteDefMarginRight
                  this.footnoteData._footnoteDefMarginBottom = this.footnoteDefMarginBottom
                  this.footnoteData._footnoteDefMarginLeft = this.footnoteDefMarginLeft
                  this.footnoteData._footnoteDefPaddingTop = this.footnoteDefPaddingTop
                  this.footnoteData._footnoteDefPaddingRight = this.footnoteDefPaddingRight
                  this.footnoteData._footnoteDefPaddingBottom = this.footnoteDefPaddingBottom
                  this.footnoteData._footnoteDefPaddingLeft = this.footnoteDefPaddingLeft
                  this.footnoteData._footnoteRefTextFontColor = this.footnoteRefTextFontColor
                  this.footnoteData._footnoteRefTextFontSize = this.footnoteRefTextFontSize
                  this.footnoteData._footnoteRefTextFontStyle = this.footnoteRefTextFontStyle
                  this.footnoteData._footnoteRefTextFontWeight = this.footnoteRefTextFontWeight
                  this.footnoteData._footnoteRefTextFontFamily = this.footnoteRefTextFontFamily
                  this.footnoteData._footnoteRefTextLineHeight = this.footnoteRefTextLineHeight
                  this.footnoteData._footnoteRefTextLetterSpacing = this.footnoteRefTextLetterSpacing
                  this.footnoteData._footnoteRefTextDecorationType = this.footnoteRefTextDecorationType
                  this.footnoteData._footnoteRefTextDecorationColor = this.footnoteRefTextDecorationColor
                  this.footnoteData._footnoteRefTextDecorationStyle = this.footnoteRefTextDecorationStyle
                  this.footnoteData._footnoteRefTextBackgroundColor = this.footnoteRefTextBackgroundColor
                  this.footnoteData._footnoteRefTextBackgroundRadiusTopLeft = this.footnoteRefTextBackgroundRadiusTopLeft
                  this.footnoteData._footnoteRefTextBackgroundRadiusTopRight = this.footnoteRefTextBackgroundRadiusTopRight
                  this.footnoteData._footnoteRefTextBackgroundRadiusBottomLeft = this.footnoteRefTextBackgroundRadiusBottomLeft
                  this.footnoteData._footnoteRefTextBackgroundRadiusBottomRight = this.footnoteRefTextBackgroundRadiusBottomRight
                  // ---------- 跳转到详情
                  router.pushUrl({ url: "pages/FootnoteDetailsPage", params: this.footnoteData })
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
          // 通用样式配置
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

          // 脚注定义
          Column() {
            Row() {
              Text("脚注定义")
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
                  titleStr: "脚注定义背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.footnoteDefBackgroundColorList,
                  allData: this.footnoteDefBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "脚注定义上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.footnoteDefMarginTopList,
                  allData: this.footnoteDefMarginTop
                })
                BaseTabComponent({
                  titleStr: "脚注定义右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.footnoteDefMarginRightList,
                  allData: this.footnoteDefMarginRight
                })
                BaseTabComponent({
                  titleStr: "脚注定义下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.footnoteDefMarginBottomList,
                  allData: this.footnoteDefMarginBottom
                })
                BaseTabComponent({
                  titleStr: "脚注定义左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.footnoteDefMarginLeftList,
                  allData: this.footnoteDefMarginLeft
                })
                BaseTabComponent({
                  titleStr: "脚注定义上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.footnoteDefPaddingTopList,
                  allData: this.footnoteDefPaddingTop
                })
                BaseTabComponent({
                  titleStr: "脚注定义右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.footnoteDefPaddingRightList,
                  allData: this.footnoteDefPaddingRight
                })
                BaseTabComponent({
                  titleStr: "脚注定义下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.footnoteDefPaddingBottomList,
                  allData: this.footnoteDefPaddingBottom
                })
                BaseTabComponent({
                  titleStr: "脚注定义左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.footnoteDefPaddingLeftList,
                  allData: this.footnoteDefPaddingLeft
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

          // 脚注引用
          Column() {
            Row() {
              Text("脚注引用")
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
                  titleStr: "脚注引用文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.footnoteRefTextFontColorList,
                  allData: this.footnoteRefTextFontColor
                })
                BaseTabComponent({
                  titleStr: "脚注引用文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.footnoteRefTextFontSizeList,
                  allData: this.footnoteRefTextFontSize
                })
                BaseTabComponent({
                  titleStr: "脚注引用文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.footnoteRefTextFontStyleList,
                  allData: this.footnoteRefTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "脚注引用文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.footnoteRefTextFontWeightList,
                  allData: this.footnoteRefTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "脚注引用文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.footnoteRefTextFontFamilyList,
                  allData: this.footnoteRefTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "脚注引用文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.footnoteRefTextLineHeightList,
                  allData: this.footnoteRefTextLineHeight
                })
                BaseTabComponent({
                  titleStr: "脚注引用文本字符间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.footnoteRefTextLetterSpacingList,
                  allData: this.footnoteRefTextLetterSpacing
                })
                BaseTabComponent({
                  titleStr: "脚注引用文本装饰线类型 - ",
                  typeEnum: TypeEnum.IS_DECORATION_TYPE,
                  allListData: this.footnoteRefTextDecorationTypeList,
                  allData: this.footnoteRefTextDecorationType
                })
                BaseTabComponent({
                  titleStr: "脚注引用文本装饰线颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.footnoteRefTextDecorationColorList,
                  allData: this.footnoteRefTextDecorationColor
                })
                BaseTabComponent({
                  titleStr: "脚注引用文本装饰线样式 - ",
                  typeEnum: TypeEnum.IS_DECORATION_STYLE,
                  allListData: this.footnoteRefTextDecorationStyleList,
                  allData: this.footnoteRefTextDecorationStyle
                })
                BaseTabComponent({
                  titleStr: "脚注引用文本背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.footnoteRefTextBackgroundColorList,
                  allData: this.footnoteRefTextBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "脚注引用文本背景左上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.footnoteRefTextBackgroundRadiusTopLeftList,
                  allData: this.footnoteRefTextBackgroundRadiusTopLeft
                })
                BaseTabComponent({
                  titleStr: "脚注引用文本背景右上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.footnoteRefTextBackgroundRadiusTopRightList,
                  allData: this.footnoteRefTextBackgroundRadiusTopRight
                })
                BaseTabComponent({
                  titleStr: "脚注引用文本背景左下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.footnoteRefTextBackgroundRadiusBottomLeftList,
                  allData: this.footnoteRefTextBackgroundRadiusBottomLeft
                })
                BaseTabComponent({
                  titleStr: "脚注引用文本背景右下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.footnoteRefTextBackgroundRadiusBottomRightList,
                  allData: this.footnoteRefTextBackgroundRadiusBottomRight
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