import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseTabComponent } from '../component/BaseTabComponent'
import { TypeEnum } from '../model/TypeEnum'
import {
  booleanListGeneralData,
  colorListGeneralData,
  fontWeightListGeneraData,
  marginListGeneralData,
  textLineHeightListGeneralData,
  textNumberListGeneralData,
  textSizeListGeneralData,
  textTypefaceListGeneralData,
  textWordSpaceListGeneralData,
  timeListGeneralData
} from '../model/GeneralData'
import { ItalicData } from '../model/ItalicData'

@Entry
@Component
struct ItalicPage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "018_斜体"
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
  italicData: ItalicData = new ItalicData()

  // ---------------- 专有
  // 斜体文本颜色列表
  italicTextFontColorList: Array<number | undefined> = colorListGeneralData
  @State // 斜体文本颜色
  italicTextFontColor: number | undefined = undefined
  // 斜体文本尺寸列表
  italicTextFontSizeList: Array<number> = textSizeListGeneralData
  @State // 斜体文本尺寸
  italicTextFontSize: number | undefined = undefined
  // 斜体文本字体粗细列表
  italicTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State // 斜体文本字体粗细
  italicTextFontWeight: FontWeight | undefined = undefined
  // 斜体文本字体列表
  italicTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // 斜体文本字体
  italicTextFontFamily: string | undefined = undefined
  // 斜体文本行高列表
  italicTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State // 斜体文本行高
  italicTextLineHeight: number | undefined = undefined
  // 斜体文本字符间距列表
  italicTextLetterSpacingList: Array<number> = textWordSpaceListGeneralData
  @State // 斜体文本字符间距
  italicTextLetterSpacing: number | undefined = undefined

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

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
            titleStr: "斜体文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.italicTextFontColorList,
            allData: this.italicTextFontColor
          })
          BaseTabComponent({
            titleStr: "斜体文本尺寸 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.italicTextFontSizeList,
            allData: this.italicTextFontSize
          })
          BaseTabComponent({
            titleStr: "斜体文本字体粗细 - ",
            typeEnum: TypeEnum.IS_FONT_WEIGHT,
            allListData: this.italicTextFontWeightList,
            allData: this.italicTextFontWeight
          })
          BaseTabComponent({
            titleStr: "斜体文本字体 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.italicTextFontFamilyList,
            allData: this.italicTextFontFamily
          })
          BaseTabComponent({
            titleStr: "斜体文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.italicTextLineHeightList,
            allData: this.italicTextLineHeight
          })
          BaseTabComponent({
            titleStr: "斜体文本字符间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.italicTextLetterSpacingList,
            allData: this.italicTextLetterSpacing
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
                    this.italicData.isFull = this.isFull
                    this.italicData.incrementalAnalysis = this.incrementalAnalysis
                    this.italicData.time = this.time
                    this.italicData.textNumber = this.textNumber
                    this.italicData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.italicData.isOnCopy = this.isOnCopy
                    this.italicData.blockMarginTop = this.blockMarginTop
                    this.italicData.blockMarginRight = this.blockMarginRight
                    this.italicData.blockMarginBottom = this.blockMarginBottom
                    this.italicData.blockMarginLeft = this.blockMarginLeft
                    this.italicData.markdownBlockSpacing = this.markdownBlockSpacing
                    this.italicData.isLineBreak = this.isLineBreak
                    this.italicData.backgroundColor = this.globalBackgroundColor
                    this.italicData.openGestureSwipe = this.openGestureSwipe
                    this.italicData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.italicData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.italicData.italicTextFontColor = this.italicTextFontColor
                    this.italicData.italicTextFontSize = this.italicTextFontSize
                    this.italicData.italicTextFontWeight = this.italicTextFontWeight
                    this.italicData.italicTextFontFamily = this.italicTextFontFamily
                    this.italicData.italicTextLineHeight = this.italicTextLineHeight
                    this.italicData.italicTextLetterSpacing = this.italicTextLetterSpacing
                    router.pushUrl({ url: "pages/ItalicDetailsPage", params: this.italicData })
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