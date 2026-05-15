import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseMDData } from '../model/BaseMDData'
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
import { BoldData } from '../model/BoldData'

@Entry
@Component
struct BoldPage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "017_加粗"
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
  @State // 配置数据内容
  boldData: BoldData = new BoldData()

  // ---------------- 专有
  // 加粗文本颜色列表
  boldTextFontColorList: Array<number | undefined> = colorListGeneralData
  @State // 加粗文本颜色
  boldTextFontColor: number | undefined = undefined
  // 加粗文本尺寸列表
  boldTextFontSizeList: Array<number> = textSizeListGeneralData
  @State // 加粗文本尺寸
  boldTextFontSize: number | undefined = undefined
  // 加粗文本字体样式列表
  boldTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 加粗文本字体样式
  boldTextFontStyle: FontStyle | undefined = undefined
  // 加粗文本字体粗细列表
  boldTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State // 加粗文本字体粗细
  boldTextFontWeight: FontWeight = FontWeight.Bold
  // 加粗文本字体列表
  boldTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // 加粗文本字体
  boldTextFontFamily: string | undefined = undefined
  // 加粗文本行高列表
  boldTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State // 加粗文本行高
  boldTextLineHeight: number | undefined = undefined
  // 加粗文本字符间距列表
  boldTextLetterSpacingList: Array<number> = textWordSpaceListGeneralData
  @State // 加粗文本字符间距
  boldTextLetterSpacing: number | undefined = undefined

  build() {
    Column() {
      titleComponent(
        "演示样例配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Scroll() {
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

          // ---------------- 专有
          BaseTabComponent({
            titleStr: "加粗文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.boldTextFontColorList,
            allData: this.boldTextFontColor
          })
          BaseTabComponent({
            titleStr: "加粗文本尺寸 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.boldTextFontSizeList,
            allData: this.boldTextFontSize
          })
          BaseTabComponent({
            titleStr: "加粗文本字体样式 - ",
            typeEnum: TypeEnum.IS_FONT_STYLE,
            allListData: this.boldTextFontStyleList,
            allData: this.boldTextFontStyle
          })
          BaseTabComponent({
            titleStr: "加粗文本字体粗细 - ",
            typeEnum: TypeEnum.IS_FONT_WEIGHT,
            allListData: this.boldTextFontWeightList,
            allData: this.boldTextFontWeight
          })
          BaseTabComponent({
            titleStr: "加粗文本字体 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.boldTextFontFamilyList,
            allData: this.boldTextFontFamily
          })
          BaseTabComponent({
            titleStr: "加粗文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.boldTextLineHeightList,
            allData: this.boldTextLineHeight
          })
          BaseTabComponent({
            titleStr: "加粗文本字符间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.boldTextLetterSpacingList,
            allData: this.boldTextLetterSpacing
          })

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
                    this.boldData.isFull = this.isFull
                    this.boldData.incrementalAnalysis = this.incrementalAnalysis
                    this.boldData.time = this.time
                    this.boldData.textNumber = this.textNumber
                    this.boldData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.boldData.isOnCopy = this.isOnCopy
                    this.boldData.blockMarginTop = this.blockMarginTop
                    this.boldData.blockMarginRight = this.blockMarginRight
                    this.boldData.blockMarginBottom = this.blockMarginBottom
                    this.boldData.blockMarginLeft = this.blockMarginLeft
                    this.boldData.markdownBlockSpacing = this.markdownBlockSpacing
                    this.boldData.isLineBreak = this.isLineBreak
                    this.boldData.backgroundColor = this.globalBackgroundColor
                    this.boldData.openGestureSwipe = this.openGestureSwipe
                    this.boldData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.boldData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.boldData.boldTextFontColor = this.boldTextFontColor
                    this.boldData.boldTextFontSize = this.boldTextFontSize
                    this.boldData.boldTextFontStyle = this.boldTextFontStyle
                    this.boldData.boldTextFontWeight = this.boldTextFontWeight
                    this.boldData.boldTextFontFamily = this.boldTextFontFamily
                    this.boldData.boldTextLineHeight = this.boldTextLineHeight
                    this.boldData.boldTextLetterSpacing = this.boldTextLetterSpacing

                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/BoldDetailsPage", params: this.boldData })
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