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
  textSizeListGeneralData,
  textTypefaceListGeneralData,
  timeListGeneralData
} from '../model/GeneralData'
import { CodeLineData } from '../model/CodeLineData'

@Entry
@Component
struct CodeLinePage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "010_内联代码"
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
  @State codeLineData: CodeLineData = new CodeLineData() // 配置数据内容

  // ---------------- 专有
  // 内联代码文本颜色列表
  inlineCodeTextFontColorList: Array<number | undefined> = colorListGeneralData
  @State // 内联代码文本颜色
  inlineCodeTextFontColor: number | undefined = undefined
  // 内联代码文本尺寸列表
  inlineCodeTextFontSizeList: Array<number> = textSizeListGeneralData
  @State // 内联代码文本尺寸
  inlineCodeTextFontSize: number = 13
  // 内联代码文本字体样式列表
  inlineCodeTextFontStyleList: Array<FontStyle> = [FontStyle.Normal, FontStyle.Italic]
  @State // 内联代码文本字体样式
  inlineCodeTextFontStyle: FontStyle = FontStyle.Normal
  // 内联代码文本字体粗细列表
  inlineCodeTextFontWeightList: Array<FontWeight> = [FontWeight.Normal, FontWeight.Bold, FontWeight.Medium]
  @State // 内联代码文本字体粗细
  inlineCodeTextFontWeight: FontWeight = FontWeight.Normal
  // 内联代码文本字体列表
  inlineCodeTextFontFamilyList: Array<string> = ['HarmonyOS Sans', 'Arial', 'Times New Roman']
  @State // 内联代码文本字体
  inlineCodeTextFontFamily: string = 'HarmonyOS Sans'
  // 内联代码文本行高列表
  inlineCodeTextLineHeightList: Array<number> = [16, 18, 20, 22, 24, 26, 28, 30]
  @State // 内联代码文本行高
  inlineCodeTextLineHeight: number = 20
  // 内联代码文本字符间距列表
  inlineCodeTextLetterSpacingList: Array<number> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  @State // 内联代码文本字符间距
  inlineCodeTextLetterSpacing: number = 0
  // 内联代码文本背景颜色列表
  inlineCodeTextBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State // 内联代码文本背景颜色
  inlineCodeTextBackgroundColor: number | undefined = undefined
  // 内联代码文本背景左上圆角列表
  inlineCodeTextBackgroundRadiusTopLeftList: Array<number> = [0, 2, 4, 6, 8, 10, 12, 14, 16]
  @State // 内联代码文本背景左上圆角
  inlineCodeTextBackgroundRadiusTopLeft: number = 4
  // 内联代码文本背景右上圆角列表
  inlineCodeTextBackgroundRadiusTopRightList: Array<number> = [0, 2, 4, 6, 8, 10, 12, 14, 16]
  @State // 内联代码文本背景右上圆角
  inlineCodeTextBackgroundRadiusTopRight: number = 4
  // 内联代码文本背景左下圆角列表
  inlineCodeTextBackgroundRadiusBottomLeftList: Array<number> = [0, 2, 4, 6, 8, 10, 12, 14, 16]
  @State // 内联代码文本背景左下圆角
  inlineCodeTextBackgroundRadiusBottomLeft: number = 4
  // 内联代码文本背景右下圆角列表
  inlineCodeTextBackgroundRadiusBottomRightList: Array<number> = [0, 2, 4, 6, 8, 10, 12, 14, 16]
  @State // 内联代码文本背景右下圆角
  inlineCodeTextBackgroundRadiusBottomRight: number = 4

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "内联代码配置页面",
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
            titleStr: "内联代码文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.inlineCodeTextFontColorList,
            allData: this.inlineCodeTextFontColor
          })
          BaseTabComponent({
            titleStr: "内联代码文本尺寸 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.inlineCodeTextFontSizeList,
            allData: this.inlineCodeTextFontSize
          })
          BaseTabComponent({
            titleStr: "内联代码文本字体样式 - ",
            typeEnum: TypeEnum.IS_FONT_STYLE,
            allListData: this.inlineCodeTextFontStyleList,
            allData: this.inlineCodeTextFontStyle
          })
          BaseTabComponent({
            titleStr: "内联代码文本字体粗细 - ",
            typeEnum: TypeEnum.IS_FONT_WEIGHT,
            allListData: this.inlineCodeTextFontWeightList,
            allData: this.inlineCodeTextFontWeight
          })
          BaseTabComponent({
            titleStr: "内联代码文本字体 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.inlineCodeTextFontFamilyList,
            allData: this.inlineCodeTextFontFamily
          })
          BaseTabComponent({
            titleStr: "内联代码文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.inlineCodeTextLineHeightList,
            allData: this.inlineCodeTextLineHeight
          })
          BaseTabComponent({
            titleStr: "内联代码文本字符间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.inlineCodeTextLetterSpacingList,
            allData: this.inlineCodeTextLetterSpacing
          })
          BaseTabComponent({
            titleStr: "内联代码文本背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.inlineCodeTextBackgroundColorList,
            allData: this.inlineCodeTextBackgroundColor
          })
          BaseTabComponent({
            titleStr: "内联代码文本背景左上圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.inlineCodeTextBackgroundRadiusTopLeftList,
            allData: this.inlineCodeTextBackgroundRadiusTopLeft
          })
          BaseTabComponent({
            titleStr: "内联代码文本背景右上圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.inlineCodeTextBackgroundRadiusTopRightList,
            allData: this.inlineCodeTextBackgroundRadiusTopRight
          })
          BaseTabComponent({
            titleStr: "内联代码文本背景左下圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.inlineCodeTextBackgroundRadiusBottomLeftList,
            allData: this.inlineCodeTextBackgroundRadiusBottomLeft
          })
          BaseTabComponent({
            titleStr: "内联代码文本背景右下圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.inlineCodeTextBackgroundRadiusBottomRightList,
            allData: this.inlineCodeTextBackgroundRadiusBottomRight
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
                    this.codeLineData.isFull = this.isFull
                    this.codeLineData.incrementalAnalysis = this.incrementalAnalysis
                    this.codeLineData.time = this.time
                    this.codeLineData.textNumber = this.textNumber
                    this.codeLineData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.codeLineData.isOnCopy = this.isOnCopy
                    this.codeLineData.blockMarginTop = this.blockMarginTop
                    this.codeLineData.blockMarginRight = this.blockMarginRight
                    this.codeLineData.blockMarginBottom = this.blockMarginBottom
                    this.codeLineData.blockMarginLeft = this.blockMarginLeft
                    this.codeLineData.markdownBlockSpacing = this.markdownBlockSpacing
                    this.codeLineData.isLineBreak = this.isLineBreak
                    this.codeLineData.backgroundColor = this.globalBackgroundColor
                    this.codeLineData.openGestureSwipe = this.openGestureSwipe
                    this.codeLineData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.codeLineData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.codeLineData.inlineCodeTextFontColor = this.inlineCodeTextFontColor
                    this.codeLineData.inlineCodeTextFontSize = this.inlineCodeTextFontSize
                    this.codeLineData.inlineCodeTextFontStyle = this.inlineCodeTextFontStyle
                    this.codeLineData.inlineCodeTextFontWeight = this.inlineCodeTextFontWeight
                    this.codeLineData.inlineCodeTextFontFamily = this.inlineCodeTextFontFamily
                    this.codeLineData.inlineCodeTextLineHeight = this.inlineCodeTextLineHeight
                    this.codeLineData.inlineCodeTextLetterSpacing = this.inlineCodeTextLetterSpacing
                    this.codeLineData.inlineCodeTextBackgroundColor = this.inlineCodeTextBackgroundColor
                    this.codeLineData.inlineCodeTextBackgroundRadiusTopLeft = this.inlineCodeTextBackgroundRadiusTopLeft
                    this.codeLineData.inlineCodeTextBackgroundRadiusTopRight = this.inlineCodeTextBackgroundRadiusTopRight
                    this.codeLineData.inlineCodeTextBackgroundRadiusBottomLeft = this.inlineCodeTextBackgroundRadiusBottomLeft
                    this.codeLineData.inlineCodeTextBackgroundRadiusBottomRight = this.inlineCodeTextBackgroundRadiusBottomRight
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/CodeLineDetailsPage", params: this.codeLineData })
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


