import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseTabComponent } from '../component/BaseTabComponent'
import { TypeEnum } from '../model/TypeEnum'
import {
  booleanListGeneralData,
  colorListGeneralData,
  marginListGeneralData,
  textNumberListGeneralData,
  timeListGeneralData
} from '../model/GeneralData'
import { ParagraphData } from '../model/ParagraphData'

@Entry
@Component
struct ParagraphPage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "002_段落"
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
  // 段落背景颜色列表
  paragraphBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State // 段落背景颜色
  paragraphBackgroundColor: number | undefined = undefined
  // 段落上外边距列表
  paragraphMarginTopList: Array<number> = marginListGeneralData
  @State // 段落上外边距
  paragraphMarginTop: number = 8
  // 段落右外边距列表
  paragraphMarginRightList: Array<number> = marginListGeneralData
  @State // 段落右外边距
  paragraphMarginRight: number = 8
  // 段落下外边距列表
  paragraphMarginBottomList: Array<number> = marginListGeneralData
  @State // 段落下外边距
  paragraphMarginBottom: number = 8
  // 段落左外边距列表
  paragraphMarginLeftList: Array<number> = marginListGeneralData
  @State // 段落左外边距
  paragraphMarginLeft: number = 8
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
  paragraphTextFontColorList: Array<number | undefined> = colorListGeneralData
  @State // 段落文本颜色
  paragraphTextFontColor: number | undefined = undefined
  // 段落文本尺寸列表
  paragraphTextFontSizeList: Array<number> = [12, 13, 14, 15, 16, 17, 18, 19, 20]
  @State // 段落文本尺寸
  paragraphTextFontSize: number = 14
  // 段落文本字体样式列表
  paragraphTextFontStyleList: Array<FontStyle> = [FontStyle.Normal, FontStyle.Italic]
  @State // 段落文本字体样式
  paragraphTextFontStyle: FontStyle = FontStyle.Normal
  // 段落文本字体粗细列表
  paragraphTextFontWeightList: Array<FontWeight> = [FontWeight.Normal, FontWeight.Bold]
  @State // 段落文本字体粗细
  paragraphTextFontWeight: FontWeight = FontWeight.Normal
  // 段落文本字体列表
  paragraphTextFontFamilyList: Array<string> = ["HarmonyOS Sans", "Arial", "Times New Roman"]
  @State // 段落文本字体
  paragraphTextFontFamily: string = 'HarmonyOS Sans'
  // 段落文本行高列表
  paragraphTextLineHeightList: Array<number> = [18, 19, 20, 21, 22, 23, 24, 25, 26]
  @State // 段落文本行高
  paragraphTextLineHeight: number = 22
  // 段落文本字符间距列表
  paragraphTextLetterSpacingList: Array<number> = [-2, -1, 0, 1, 2, 3, 4, 5]
  @State // 段落文本字符间距
  paragraphTextLetterSpacing: number = 0

  @State // 配置数据内容
  paragraphData: ParagraphData = new ParagraphData()

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
            titleStr: "段落背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.paragraphBackgroundColorList,
            allData: this.paragraphBackgroundColor
          })
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
                    this.paragraphData.isFull = this.isFull
                    this.paragraphData.incrementalAnalysis = this.incrementalAnalysis
                    this.paragraphData.time = this.time
                    this.paragraphData.textNumber = this.textNumber
                    this.paragraphData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.paragraphData.isOnCopy = this.isOnCopy
                    this.paragraphData.blockMarginTop = this.blockMarginTop
                    this.paragraphData.blockMarginRight = this.blockMarginRight
                    this.paragraphData.blockMarginBottom = this.blockMarginBottom
                    this.paragraphData.blockMarginLeft = this.blockMarginLeft
                    this.paragraphData.markdownBlockSpacing = this.markdownBlockSpacing
                    this.paragraphData.isLineBreak = this.isLineBreak
                    this.paragraphData.backgroundColor = this.globalBackgroundColor
                    this.paragraphData.openGestureSwipe = this.openGestureSwipe
                    this.paragraphData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.paragraphData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.paragraphData.paragraphBackgroundColor = this.paragraphBackgroundColor
                    this.paragraphData.paragraphMarginTop = this.paragraphMarginTop
                    this.paragraphData.paragraphMarginRight = this.paragraphMarginRight
                    this.paragraphData.paragraphMarginBottom = this.paragraphMarginBottom
                    this.paragraphData.paragraphMarginLeft = this.paragraphMarginLeft
                    this.paragraphData.paragraphPaddingTop = this.paragraphPaddingTop
                    this.paragraphData.paragraphPaddingRight = this.paragraphPaddingRight
                    this.paragraphData.paragraphPaddingBottom = this.paragraphPaddingBottom
                    this.paragraphData.paragraphPaddingLeft = this.paragraphPaddingLeft
                    this.paragraphData.paragraphTextFontColor = this.paragraphTextFontColor
                    this.paragraphData.paragraphTextFontSize = this.paragraphTextFontSize
                    this.paragraphData.paragraphTextFontStyle = this.paragraphTextFontStyle
                    this.paragraphData.paragraphTextFontWeight = this.paragraphTextFontWeight
                    this.paragraphData.paragraphTextFontFamily = this.paragraphTextFontFamily
                    this.paragraphData.paragraphTextLineHeight = this.paragraphTextLineHeight
                    this.paragraphData.paragraphTextLetterSpacing = this.paragraphTextLetterSpacing
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/ParagraphDetailsPage", params: this.paragraphData })
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
