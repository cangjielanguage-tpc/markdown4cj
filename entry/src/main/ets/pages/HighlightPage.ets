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
import { HighlightData } from '../model/HighlightData'

@Entry
@Component
struct HighlightPage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "035_Highlight"
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
  highlightData: HighlightData = new HighlightData()

  // ---------------- 专有
  // 高亮文本颜色列表
  highlightTextFontColorList: Array<number | undefined> = colorListGeneralData
  @State // 高亮文本颜色
  highlightTextFontColor: number | undefined = undefined
  // 高亮文本尺寸列表
  highlightTextFontSizeList: Array<number> = textSizeListGeneralData
  @State // 高亮文本尺寸
  highlightTextFontSize: number | undefined = undefined
  // 高亮文本字体样式列表
  highlightTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 高亮文本字体样式
  highlightTextFontStyle: FontStyle | undefined = undefined
  // 高亮文本字体粗细列表
  highlightTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State // 高亮文本字体粗细
  highlightTextFontWeight: FontWeight = FontWeight.Bold
  // 高亮文本字体列表
  highlightTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // 高亮文本字体
  highlightTextFontFamily: string | undefined = undefined
  // 高亮文本行高列表
  highlightTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State // 高亮文本行高
  highlightTextLineHeight: number | undefined = undefined
  // 高亮文本字符间距列表
  highlightTextLetterSpacingList: Array<number> = textWordSpaceListGeneralData
  @State // 高亮文本字符间距
  highlightTextLetterSpacing: number | undefined = undefined
  // 高亮文本背景颜色列表
  highlightTextBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State // 高亮文本背景颜色
  highlightTextBackgroundColor: number | undefined = undefined
  // 高亮文本背景左上圆角列表
  highlightTextBackgroundRadiusTopLeftList: Array<number> = textSizeListGeneralData
  @State // 高亮文本背景左上圆角
  highlightTextBackgroundRadiusTopLeft: number | undefined = undefined
  // 高亮文本背景右上圆角列表
  highlightTextBackgroundRadiusTopRightList: Array<number> = textSizeListGeneralData
  @State // 高亮文本背景右上圆角
  highlightTextBackgroundRadiusTopRight: number | undefined = undefined
  // 高亮文本背景左下圆角列表
  highlightTextBackgroundRadiusBottomLeftList: Array<number> = textSizeListGeneralData
  @State // 高亮文本背景左下圆角
  highlightTextBackgroundRadiusBottomLeft: number | undefined = undefined
  // 高亮文本背景右下圆角列表
  highlightTextBackgroundRadiusBottomRightList: Array<number> = textSizeListGeneralData
  @State // 高亮文本背景右下圆角
  highlightTextBackgroundRadiusBottomRight: number | undefined = undefined

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "高亮配置页面",
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
            titleStr: "高亮文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.highlightTextFontColorList,
            allData: this.highlightTextFontColor
          })
          BaseTabComponent({
            titleStr: "高亮文本尺寸 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.highlightTextFontSizeList,
            allData: this.highlightTextFontSize
          })
          BaseTabComponent({
            titleStr: "高亮文本字体样式 - ",
            typeEnum: TypeEnum.IS_FONT_STYLE,
            allListData: this.highlightTextFontStyleList,
            allData: this.highlightTextFontStyle
          })
          BaseTabComponent({
            titleStr: "高亮文本字体粗细 - ",
            typeEnum: TypeEnum.IS_FONT_WEIGHT,
            allListData: this.highlightTextFontWeightList,
            allData: this.highlightTextFontWeight
          })
          BaseTabComponent({
            titleStr: "高亮文本字体 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.highlightTextFontFamilyList,
            allData: this.highlightTextFontFamily
          })
          BaseTabComponent({
            titleStr: "高亮文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.highlightTextLineHeightList,
            allData: this.highlightTextLineHeight
          })
          BaseTabComponent({
            titleStr: "高亮文本字符间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.highlightTextLetterSpacingList,
            allData: this.highlightTextLetterSpacing
          })
          BaseTabComponent({
            titleStr: "高亮文本背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.highlightTextBackgroundColorList,
            allData: this.highlightTextBackgroundColor
          })
          BaseTabComponent({
            titleStr: "高亮文本背景左上圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.highlightTextBackgroundRadiusTopLeftList,
            allData: this.highlightTextBackgroundRadiusTopLeft
          })
          BaseTabComponent({
            titleStr: "高亮文本背景右上圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.highlightTextBackgroundRadiusTopRightList,
            allData: this.highlightTextBackgroundRadiusTopRight
          })
          BaseTabComponent({
            titleStr: "高亮文本背景左下圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.highlightTextBackgroundRadiusBottomLeftList,
            allData: this.highlightTextBackgroundRadiusBottomLeft
          })
          BaseTabComponent({
            titleStr: "高亮文本背景右下圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.highlightTextBackgroundRadiusBottomRightList,
            allData: this.highlightTextBackgroundRadiusBottomRight
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
                    this.highlightData.isFull = this.isFull
                    this.highlightData.incrementalAnalysis = this.incrementalAnalysis
                    this.highlightData.time = this.time
                    this.highlightData.textNumber = this.textNumber
                    this.highlightData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.highlightData.isOnCopy = this.isOnCopy
                    this.highlightData.blockMarginTop = this.blockMarginTop
                    this.highlightData.blockMarginRight = this.blockMarginRight
                    this.highlightData.blockMarginBottom = this.blockMarginBottom
                    this.highlightData.blockMarginLeft = this.blockMarginLeft
                    this.highlightData.markdownBlockSpacing = this.markdownBlockSpacing
                    this.highlightData.isLineBreak = this.isLineBreak
                    this.highlightData.backgroundColor = this.globalBackgroundColor
                    this.highlightData.openGestureSwipe = this.openGestureSwipe
                    this.highlightData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.highlightData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.highlightData.highlightTextFontColor = this.highlightTextFontColor
                    this.highlightData.highlightTextFontSize = this.highlightTextFontSize
                    this.highlightData.highlightTextFontStyle = this.highlightTextFontStyle
                    this.highlightData.highlightTextFontWeight = this.highlightTextFontWeight
                    this.highlightData.highlightTextFontFamily = this.highlightTextFontFamily
                    this.highlightData.highlightTextLineHeight = this.highlightTextLineHeight
                    this.highlightData.highlightTextLetterSpacing = this.highlightTextLetterSpacing
                    this.highlightData.highlightTextBackgroundColor = this.highlightTextBackgroundColor
                    this.highlightData.highlightTextBackgroundRadiusTopLeft = this.highlightTextBackgroundRadiusTopLeft
                    this.highlightData.highlightTextBackgroundRadiusTopRight = this.highlightTextBackgroundRadiusTopRight
                    this.highlightData.highlightTextBackgroundRadiusBottomLeft = this.highlightTextBackgroundRadiusBottomLeft
                    this.highlightData.highlightTextBackgroundRadiusBottomRight = this.highlightTextBackgroundRadiusBottomRight

                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/HighlightDetailsPage", params: this.highlightData })
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
