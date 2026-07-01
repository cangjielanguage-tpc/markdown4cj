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
  timeListGeneralData
} from '../model/GeneralData'
import { DescListData } from '../model/DescListData'

@Entry
@Component
struct DescListPage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "023_DefinitionList"
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
  @State descListData: DescListData = new DescListData() // 配置数据内容
  // ---------------- 专有
  // 定义列表背景颜色列表
  definitionListBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 定义列表背景颜色
  definitionListBackgroundColor: ResourceColor | undefined = undefined
  // 定义列表上外边距列表
  definitionListMarginTopList: Array<number> = marginListGeneralData
  @State // 定义列表上外边距
  definitionListMarginTop: number = 0
  // 定义列表右外边距列表
  definitionListMarginRightList: Array<number> = marginListGeneralData
  @State // 定义列表右外边距
  definitionListMarginRight: number = 0
  // 定义列表下外边距列表
  definitionListMarginBottomList: Array<number> = marginListGeneralData
  @State // 定义列表下外边距
  definitionListMarginBottom: number = 0
  // 定义列表左外边距列表
  definitionListMarginLeftList: Array<number> = marginListGeneralData
  @State // 定义列表左外边距
  definitionListMarginLeft: number = 0
  // 定义列表上内边距列表
  definitionListPaddingTopList: Array<number> = marginListGeneralData
  @State // 定义列表上内边距
  definitionListPaddingTop: number = 0
  // 定义列表右内边距列表
  definitionListPaddingRightList: Array<number> = marginListGeneralData
  @State // 定义列表右内边距
  definitionListPaddingRight: number = 0
  // 定义列表下内边距列表
  definitionListPaddingBottomList: Array<number> = marginListGeneralData
  @State // 定义列表下内边距
  definitionListPaddingBottom: number = 0
  // 定义列表左内边距列表
  definitionListPaddingLeftList: Array<number> = marginListGeneralData
  @State // 定义列表左内边距
  definitionListPaddingLeft: number = 0
  // 定义列表术语和定义行之间间距列表
  definitionListTermToDescriptionSpacingList: Array<number> = marginListGeneralData
  @State // 定义列表术语和定义行之间间距
  definitionListTermToDescriptionSpacing: number = 8
  // 定义列表术语文本字体粗细列表
  definitionListTermTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State // 定义列表术语文本字体粗细
  definitionListTermTextFontWeight: FontWeight = FontWeight.Bold
  // 定义列表术语文本字体样式列表
  definitionListTermTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 定义列表术语文本字体样式
  definitionListTermTextFontStyle: FontStyle = FontStyle.Italic
  // 定义列表定义行之间间距列表
  definitionListDescriptionItemSpacingList: Array<number> = marginListGeneralData
  @State // 定义列表定义行之间间距
  definitionListDescriptionItemSpacing: number = 8
  // 定义列表定义行左缩进距离列表
  definitionListDescriptionIndentList: Array<number> = marginListGeneralData
  @State // 定义列表定义行左缩进距离
  definitionListDescriptionIndent: number = 8
  heightMD: number = 30 * 1 // 乘以行数
  @State isExpanded1: boolean = false // 控制展开/折叠状态
  @State isExpanded2: boolean = false // 控制展开/折叠状态

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "定义列表配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )

      // md文档展示部分
      Column() {
        GridRow({
          columns: 4,
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
                .backgroundColor('#FF2196F3')
                .height(25).width('100%')
                .padding(5)
                .borderRadius(5)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Clip })
                .onClick(() => {
                  // ---------- 通用
                  this.descListData._isFull = this.isFull
                  this.descListData._incrementalAnalysis = this.incrementalAnalysis
                  this.descListData._time = this.time
                  this.descListData._textNumber = this.textNumber
                  this.descListData._isMarkdownParserSync = this.isMarkdownParserSync
                  this.descListData._isOnCopy = this.isOnCopy
                  this.descListData._blockMarginTop = this.blockMarginTop
                  this.descListData._blockMarginRight = this.blockMarginRight
                  this.descListData._blockMarginBottom = this.blockMarginBottom
                  this.descListData._blockMarginLeft = this.blockMarginLeft
                  this.descListData._markdownBlockSpacing = this.markdownBlockSpacing
                  this.descListData._isLineBreak = this.isLineBreak
                  this.descListData._backgroundColor = this.globalBackgroundColor
                  this.descListData._openGestureSwipe = this.openGestureSwipe
                  this.descListData._openGestureSwipeTest = this.openGestureSwipeTest
                  this.descListData._pagePath = `${this.rawFilePath}/${item}`

                  // ---------- 专有
                  this.descListData.definitionListBackgroundColor = this.definitionListBackgroundColor
                  this.descListData.definitionListMarginTop = this.definitionListMarginTop
                  this.descListData.definitionListMarginRight = this.definitionListMarginRight
                  this.descListData.definitionListMarginBottom = this.definitionListMarginBottom
                  this.descListData.definitionListMarginLeft = this.definitionListMarginLeft
                  this.descListData.definitionListPaddingTop = this.definitionListPaddingTop
                  this.descListData.definitionListPaddingRight = this.definitionListPaddingRight
                  this.descListData.definitionListPaddingBottom = this.definitionListPaddingBottom
                  this.descListData.definitionListPaddingLeft = this.definitionListPaddingLeft
                  this.descListData.definitionListTermToDescriptionSpacing = this.definitionListTermToDescriptionSpacing
                  this.descListData.definitionListTermTextFontWeight = this.definitionListTermTextFontWeight
                  this.descListData.definitionListTermTextFontStyle = this.definitionListTermTextFontStyle
                  this.descListData.definitionListDescriptionItemSpacing = this.definitionListDescriptionItemSpacing
                  this.descListData.definitionListDescriptionIndent = this.definitionListDescriptionIndent
                  // ---------- 跳转到详情
                  router.pushUrl({ url: "pages/DescListDetailsPage", params: this.descListData })
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
                  titleStr: "定义列表上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.definitionListMarginTopList,
                  allData: this.definitionListMarginTop
                })
                BaseTabComponent({
                  titleStr: "定义列表右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.definitionListMarginRightList,
                  allData: this.definitionListMarginRight
                })
                BaseTabComponent({
                  titleStr: "定义列表下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.definitionListMarginBottomList,
                  allData: this.definitionListMarginBottom
                })
                BaseTabComponent({
                  titleStr: "定义列表左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.definitionListMarginLeftList,
                  allData: this.definitionListMarginLeft
                })
                BaseTabComponent({
                  titleStr: "定义列表上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.definitionListPaddingTopList,
                  allData: this.definitionListPaddingTop
                })
                BaseTabComponent({
                  titleStr: "定义列表右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.definitionListPaddingRightList,
                  allData: this.definitionListPaddingRight
                })
                BaseTabComponent({
                  titleStr: "定义列表下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.definitionListPaddingBottomList,
                  allData: this.definitionListPaddingBottom
                })
                BaseTabComponent({
                  titleStr: "定义列表左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.definitionListPaddingLeftList,
                  allData: this.definitionListPaddingLeft
                })
                BaseTabComponent({
                  titleStr: "定义列表术语和定义行之间间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.definitionListTermToDescriptionSpacingList,
                  allData: this.definitionListTermToDescriptionSpacing
                })
                BaseTabComponent({
                  titleStr: "定义列表术语文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.definitionListTermTextFontWeightList,
                  allData: this.definitionListTermTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "定义列表术语文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.definitionListTermTextFontStyleList,
                  allData: this.definitionListTermTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "定义列表定义行之间间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.definitionListDescriptionItemSpacingList,
                  allData: this.definitionListDescriptionItemSpacing
                })
                BaseTabComponent({
                  titleStr: "定义列表定义行左缩进距离 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.definitionListDescriptionIndentList,
                  allData: this.definitionListDescriptionIndent
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