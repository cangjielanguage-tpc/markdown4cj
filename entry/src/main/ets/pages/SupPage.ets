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
  offsetListGeneralData,
  textNumberListGeneralData,
  textSizeListGeneralData,
  textTypefaceListGeneralData,
  textWordSpaceListGeneralData,
  timeListGeneralData
} from '../model/GeneralData'
import { SupData } from '../model/SupData'

@Entry
@Component
struct SupPage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "027_Sup"
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
  // 上标文本颜色列表
  supTextFontColorList: Array<number | undefined> = colorListGeneralData
  @State // 上标文本颜色
  supTextFontColor: number | undefined = undefined
  // 上标文本尺寸列表
  supTextFontSizeList: Array<number> = textSizeListGeneralData
  @State // 上标文本尺寸
  supTextFontSize: number = 8
  // 上标文本字体样式列表
  supTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 上标文本字体样式
  supTextFontStyle: FontStyle = FontStyle.Normal
  // 上标文本字体粗细列表
  supTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State // 上标文本字体粗细
  supTextFontWeight: FontWeight = FontWeight.Normal
  // 上标文本字体列表
  supTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // 上标文本字体
  supTextFontFamily: string = 'HarmonyOS Sans'
  // 上标文本字符间距列表
  supTextLetterSpacingList: Array<number> = textWordSpaceListGeneralData
  @State // 上标文本字符间距
  supTextLetterSpacing: number = 0
  // 上标文本基线的偏移量列表
  supTextBaselineOffsetList: Array<number> = offsetListGeneralData
  @State // 上标文本基线的偏移量
  supTextBaselineOffset: number = 6

  @State // 配置数据内容
  supData: SupData = new SupData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "上标配置页面",
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
            titleStr: "上标文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.supTextFontColorList,
            allData: this.supTextFontColor
          })
          BaseTabComponent({
            titleStr: "上标文本尺寸 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.supTextFontSizeList,
            allData: this.supTextFontSize
          })
          BaseTabComponent({
            titleStr: "上标文本字体样式 - ",
            typeEnum: TypeEnum.IS_FONT_STYLE,
            allListData: this.supTextFontStyleList,
            allData: this.supTextFontStyle
          })
          BaseTabComponent({
            titleStr: "上标文本字体粗细 - ",
            typeEnum: TypeEnum.IS_FONT_WEIGHT,
            allListData: this.supTextFontWeightList,
            allData: this.supTextFontWeight
          })
          BaseTabComponent({
            titleStr: "上标文本字体 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.supTextFontFamilyList,
            allData: this.supTextFontFamily
          })
          BaseTabComponent({
            titleStr: "上标文本字符间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.supTextLetterSpacingList,
            allData: this.supTextLetterSpacing
          })
          BaseTabComponent({
            titleStr: "上标文本基线的偏移量 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.supTextBaselineOffsetList,
            allData: this.supTextBaselineOffset
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
                    this.supData.isFull = this.isFull
                    this.supData.incrementalAnalysis = this.incrementalAnalysis
                    this.supData.time = this.time
                    this.supData.textNumber = this.textNumber
                    this.supData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.supData.isOnCopy = this.isOnCopy
                    this.supData.blockMarginTop = this.blockMarginTop
                    this.supData.blockMarginRight = this.blockMarginRight
                    this.supData.blockMarginBottom = this.blockMarginBottom
                    this.supData.blockMarginLeft = this.blockMarginLeft
                    this.supData.markdownBlockSpacing = this.markdownBlockSpacing
                    this.supData.isLineBreak = this.isLineBreak
                    this.supData.backgroundColor = this.globalBackgroundColor
                    this.supData.openGestureSwipe = this.openGestureSwipe
                    this.supData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.supData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.supData.supTextFontColor = this.supTextFontColor
                    this.supData.supTextFontSize = this.supTextFontSize
                    this.supData.supTextFontStyle = this.supTextFontStyle
                    this.supData.supTextFontWeight = this.supTextFontWeight
                    this.supData.supTextFontFamily = this.supTextFontFamily
                    this.supData.supTextLetterSpacing = this.supTextLetterSpacing
                    this.supData.supTextBaselineOffset = this.supTextBaselineOffset
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/SupDetailsPage", params: this.supData })
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
