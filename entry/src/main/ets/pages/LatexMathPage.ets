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
import { LatexMathColorFormat } from '@cangjie-tpc/markdown_hybrid'

@Entry
@Component
struct LatexMathPage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "005_数学公式"
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
  // LaTeX数学公式上外边距列表
  latexMathMarginTopList: Array<number> = marginListGeneralData
  @State // LaTeX数学公式上外边距
  latexMathMarginTop: number = 0
  // LaTeX数学公式右外边距列表
  latexMathMarginRightList: Array<number> = marginListGeneralData
  @State // LaTeX数学公式右外边距
  latexMathMarginRight: number = 0
  // LaTeX数学公式下外边距列表
  latexMathMarginBottomList: Array<number> = marginListGeneralData
  @State // LaTeX数学公式下外边距
  latexMathMarginBottom: number = 0
  // LaTeX数学公式左外边距列表
  latexMathMarginLeftList: Array<number> = marginListGeneralData
  @State // LaTeX数学公式左外边距
  latexMathMarginLeft: number = 0
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
  latexMathDefaultTextFontColorList: Array<number | undefined> = colorListGeneralData
  @State // 数学公式未加载状态文本颜色
  latexMathDefaultTextFontColor: number | undefined = undefined
  // 数学公式未加载状态文本尺寸列表
  latexMathDefaultTextFontSizeList: Array<number> = textSizeListGeneralData
  @State // 数学公式未加载状态文本尺寸
  latexMathDefaultTextFontSize: number = 16
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
  latexMathBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State // 数学公式背景色
  latexMathBackgroundColor: number | undefined = undefined
  // 数学公式文本颜色列表
  latexMathTextColorList: Array<number | undefined> = colorListGeneralData
  @State // 数学公式文本颜色
  latexMathTextColor: number | undefined = undefined
  // 数学公式生成图片格式列表
  latexMathColorFormatList: Array<number> =
    [LatexMathColorFormat.COLOR_FORMAT_BGRA_8888, LatexMathColorFormat.COLOR_FORMAT_RGB_565]
  @State // 数学公式生成图片格式
  latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
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

          // ---------------- 专有
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
          BaseTabComponent({
            titleStr: "数学公式生成图片格式 - ",
            typeEnum: TypeEnum.IS_LATEX_FORMAT,
            allListData: this.latexMathColorFormatList,
            allData: this.latexMathColorFormat
          })
          BaseTabComponent({
            titleStr: "块结构的数学公式是否居中 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.latexMathBlockCenterList,
            allData: this.latexMathBlockCenter
          })
          // BaseTabComponent({
          //   titleStr: "数学公式字体路径 - ",
          //   typeEnum: TypeEnum.IS_STRING,
          //   allListData: this.latexMathResPathList,
          //   allData: this.latexMathResPath
          // })

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
                    this.latexMathData.isFull = this.isFull
                    this.latexMathData.incrementalAnalysis = this.incrementalAnalysis
                    this.latexMathData.time = this.time
                    this.latexMathData.textNumber = this.textNumber
                    this.latexMathData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.latexMathData.isOnCopy = this.isOnCopy
                    this.latexMathData.blockMarginTop = this.blockMarginTop
                    this.latexMathData.blockMarginRight = this.blockMarginRight
                    this.latexMathData.blockMarginBottom = this.blockMarginBottom
                    this.latexMathData.blockMarginLeft = this.blockMarginLeft
                    this.latexMathData.markdownBlockSpacing = this.markdownBlockSpacing
                    this.latexMathData.isLineBreak = this.isLineBreak
                    this.latexMathData.backgroundColor = this.globalBackgroundColor
                    this.latexMathData.openGestureSwipe = this.openGestureSwipe
                    this.latexMathData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.latexMathData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.latexMathData.latexMathMarginTop = this.latexMathMarginTop
                    this.latexMathData.latexMathMarginRight = this.latexMathMarginRight
                    this.latexMathData.latexMathMarginBottom = this.latexMathMarginBottom
                    this.latexMathData.latexMathMarginLeft = this.latexMathMarginLeft
                    this.latexMathData.latexMathPaddingTop = this.latexMathPaddingTop
                    this.latexMathData.latexMathPaddingRight = this.latexMathPaddingRight
                    this.latexMathData.latexMathPaddingBottom = this.latexMathPaddingBottom
                    this.latexMathData.latexMathPaddingLeft = this.latexMathPaddingLeft
                    this.latexMathData.latexMathDefaultText = this.latexMathDefaultText
                    this.latexMathData.latexMathDefaultTextFontColor = this.latexMathDefaultTextFontColor
                    this.latexMathData.latexMathDefaultTextFontSize = this.latexMathDefaultTextFontSize
                    this.latexMathData.latexMathDefaultTextFontStyle = this.latexMathDefaultTextFontStyle
                    this.latexMathData.latexMathDefaultTextFontWeight = this.latexMathDefaultTextFontWeight
                    this.latexMathData.latexMathDefaultTextFontFamily = this.latexMathDefaultTextFontFamily
                    this.latexMathData.latexMathTextSize = this.latexMathTextSize
                    this.latexMathData.latexMathBackgroundColor = this.latexMathBackgroundColor
                    this.latexMathData.latexMathTextColor = this.latexMathTextColor
                    this.latexMathData.latexMathColorFormat = this.latexMathColorFormat
                    this.latexMathData.latexMathBlockCenter = this.latexMathBlockCenter
                    this.latexMathData.latexMathResPath = this.latexMathResPath
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/LatexMathDetailsPage", params: this.latexMathData })
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


