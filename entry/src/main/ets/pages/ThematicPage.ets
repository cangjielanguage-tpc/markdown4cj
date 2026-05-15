import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseTabComponent } from '../component/BaseTabComponent'
import { TypeEnum } from '../model/TypeEnum'
import {
  booleanListGeneralData,
  colorListGeneralData,
  lineOrBorderWidthListGeneraData,
  marginListGeneralData,
  textNumberListGeneralData,
  timeListGeneralData
} from '../model/GeneralData'
import { ThematicData } from '../model/ThematicData'

@Entry
@Component
struct ThematicPage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "003_分割线"
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
  // 分割线上外边距列表
  dividerMarginTopList: Array<number> = marginListGeneralData
  @State // 分割线上外边距
  dividerMarginTop: number = 0
  // 分割线右外边距列表
  dividerMarginRightList: Array<number> = marginListGeneralData
  @State // 分割线右外边距
  dividerMarginRight: number = 0
  // 分割线下外边距列表
  dividerMarginBottomList: Array<number> = marginListGeneralData
  @State // 分割线下外边距
  dividerMarginBottom: number = 0
  // 分割线左外边距列表
  dividerMarginLeftList: Array<number> = marginListGeneralData
  @State // 分割线左外边距
  dividerMarginLeft: number = 0
  // 分割线上内边距列表
  dividerPaddingTopList: Array<number> = marginListGeneralData
  @State // 分割线上内边距
  dividerPaddingTop: number = 0
  // 分割线右内边距列表
  dividerPaddingRightList: Array<number> = marginListGeneralData
  @State // 分割线右内边距
  dividerPaddingRight: number = 0
  // 分割线下内边距列表
  dividerPaddingBottomList: Array<number> = marginListGeneralData
  @State // 分割线下内边距
  dividerPaddingBottom: number = 0
  // 分割线左内边距列表
  dividerPaddingLeftList: Array<number> = marginListGeneralData
  @State // 分割线左内边距
  dividerPaddingLeft: number = 0
  // 分割线颜色列表
  dividerColorList: Array<number | undefined> = colorListGeneralData
  @State // 分割线颜色
  dividerColor: number | undefined = undefined
  // 分割线宽度列表
  dividerStrokeWidthList: Array<number> = lineOrBorderWidthListGeneraData
  @State // 分割线宽度
  dividerStrokeWidth: number = 0.5
  // 分割线端点样式列表
  dividerStyleList: Array<LineCapStyle> = [LineCapStyle.Butt, LineCapStyle.Round, LineCapStyle.Square]
  @State // 分割线端点样式
  dividerStyle: LineCapStyle = LineCapStyle.Butt

  @State // 配置数据内容
  thematicData: ThematicData = new ThematicData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "分割线配置页面",
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
            titleStr: "分割线上外边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.dividerMarginTopList,
            allData: this.dividerMarginTop
          })
          BaseTabComponent({
            titleStr: "分割线右外边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.dividerMarginRightList,
            allData: this.dividerMarginRight
          })
          BaseTabComponent({
            titleStr: "分割线下外边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.dividerMarginBottomList,
            allData: this.dividerMarginBottom
          })
          BaseTabComponent({
            titleStr: "分割线左外边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.dividerMarginLeftList,
            allData: this.dividerMarginLeft
          })
          BaseTabComponent({
            titleStr: "分割线上内边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.dividerPaddingTopList,
            allData: this.dividerPaddingTop
          })
          BaseTabComponent({
            titleStr: "分割线右内边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.dividerPaddingRightList,
            allData: this.dividerPaddingRight
          })
          BaseTabComponent({
            titleStr: "分割线下内边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.dividerPaddingBottomList,
            allData: this.dividerPaddingBottom
          })
          BaseTabComponent({
            titleStr: "分割线左内边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.dividerPaddingLeftList,
            allData: this.dividerPaddingLeft
          })
          BaseTabComponent({
            titleStr: "分割线颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.dividerColorList,
            allData: this.dividerColor
          })
          BaseTabComponent({
            titleStr: "分割线宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.dividerStrokeWidthList,
            allData: this.dividerStrokeWidth
          })
          BaseTabComponent({
            titleStr: "分割线端点样式 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.dividerStyleList,
            allData: this.dividerStyle
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
                    this.thematicData.isFull = this.isFull
                    this.thematicData.incrementalAnalysis = this.incrementalAnalysis
                    this.thematicData.time = this.time
                    this.thematicData.textNumber = this.textNumber
                    this.thematicData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.thematicData.isOnCopy = this.isOnCopy
                    this.thematicData.blockMarginTop = this.blockMarginTop
                    this.thematicData.blockMarginRight = this.blockMarginRight
                    this.thematicData.blockMarginBottom = this.blockMarginBottom
                    this.thematicData.blockMarginLeft = this.blockMarginLeft
                    this.thematicData.markdownBlockSpacing = this.markdownBlockSpacing
                    this.thematicData.isLineBreak = this.isLineBreak
                    this.thematicData.backgroundColor = this.globalBackgroundColor
                    this.thematicData.openGestureSwipe = this.openGestureSwipe
                    this.thematicData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.thematicData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.thematicData.dividerMarginTop = this.dividerMarginTop
                    this.thematicData.dividerMarginRight = this.dividerMarginRight
                    this.thematicData.dividerMarginBottom = this.dividerMarginBottom
                    this.thematicData.dividerMarginLeft = this.dividerMarginLeft
                    this.thematicData.dividerPaddingTop = this.dividerPaddingTop
                    this.thematicData.dividerPaddingRight = this.dividerPaddingRight
                    this.thematicData.dividerPaddingBottom = this.dividerPaddingBottom
                    this.thematicData.dividerPaddingLeft = this.dividerPaddingLeft
                    this.thematicData.dividerColor = this.dividerColor
                    this.thematicData.dividerStrokeWidth = this.dividerStrokeWidth
                    this.thematicData.dividerStyle = this.dividerStyle
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/ThematicDetailsPage", params: this.thematicData })
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
