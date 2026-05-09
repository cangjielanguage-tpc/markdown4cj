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
  timeListGeneralData
} from '../model/GeneralData'
import { CodeListData } from '../model/CodeListData'

@Entry
@Component
struct CodeListPage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "012_组合代码块"
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
  @State codeListData: CodeListData = new CodeListData() // 配置数据内容

  // ---------------- 专有
  // 组合代码未选中标题字体大小列表
  codeListTitleTextSizeList: Array<number> = textSizeListGeneralData
  @State // 组合代码未选中标题字体大小
  codeListTitleTextSize: number = 13
  // 组合代码选中标题字体大小列表
  codeListTitleSelectTextSizeList: Array<number> = textSizeListGeneralData
  @State // 组合代码选中标题字体大小
  codeListTitleSelectTextSize: number = 13
  // 组合代码选中标题文本颜色列表
  codeListTitleSelectTextColorList: Array<number | undefined> = colorListGeneralData
  @State // 组合代码选中标题文本颜色
  codeListTitleSelectTextColor: number | undefined = undefined
  // 组合代码未选中标题文本颜色列表
  codeListTitleUnSelectTextColorList: Array<number | undefined> = colorListGeneralData
  @State // 组合代码未选中标题文本颜色
  codeListTitleUnSelectTextColor: number | undefined = undefined
  // 组合代码选中标题背景颜色列表
  codeListTitleSelectBackGroupColorList: Array<number | undefined> = colorListGeneralData
  @State // 组合代码选中标题背景颜色
  codeListTitleSelectBackGroupColor: number | undefined = undefined
  // 组合代码未选中标题背景颜色列表
  codeListTitleUnSelectBackGroupColorList: Array<number | undefined> = colorListGeneralData
  @State // 组合代码未选中标题背景颜色
  codeListTitleUnSelectBackGroupColor: number | undefined = undefined

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "组合代码块配置页面",
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
            titleStr: "组合代码未选中标题字体大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.codeListTitleTextSizeList,
            allData: this.codeListTitleTextSize
          })
          BaseTabComponent({
            titleStr: "组合代码选中标题字体大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.codeListTitleSelectTextSizeList,
            allData: this.codeListTitleSelectTextSize
          })
          BaseTabComponent({
            titleStr: "组合代码选中标题文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.codeListTitleSelectTextColorList,
            allData: this.codeListTitleSelectTextColor
          })
          BaseTabComponent({
            titleStr: "组合代码未选中标题文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.codeListTitleUnSelectTextColorList,
            allData: this.codeListTitleUnSelectTextColor
          })
          BaseTabComponent({
            titleStr: "组合代码选中标题背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.codeListTitleSelectBackGroupColorList,
            allData: this.codeListTitleSelectBackGroupColor
          })
          BaseTabComponent({
            titleStr: "组合代码未选中标题背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.codeListTitleUnSelectBackGroupColorList,
            allData: this.codeListTitleUnSelectBackGroupColor
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
                    this.codeListData.isFull = this.isFull
                    this.codeListData.incrementalAnalysis = this.incrementalAnalysis
                    this.codeListData.time = this.time
                    this.codeListData.textNumber = this.textNumber
                    this.codeListData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.codeListData.isOnCopy = this.isOnCopy
                    this.codeListData.blockMarginTop = this.blockMarginTop
                    this.codeListData.blockMarginRight = this.blockMarginRight
                    this.codeListData.blockMarginBottom = this.blockMarginBottom
                    this.codeListData.blockMarginLeft = this.blockMarginLeft
                    this.codeListData.markdownBlockSpacing = this.markdownBlockSpacing
                    this.codeListData.isLineBreak = this.isLineBreak
                    this.codeListData.backgroundColor = this.globalBackgroundColor
                    this.codeListData.openGestureSwipe = this.openGestureSwipe
                    this.codeListData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.codeListData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.codeListData.codeListTitleTextSize = this.codeListTitleTextSize
                    this.codeListData.codeListTitleSelectTextSize = this.codeListTitleSelectTextSize
                    this.codeListData.codeListTitleSelectTextColor = this.codeListTitleSelectTextColor
                    this.codeListData.codeListTitleUnSelectTextColor = this.codeListTitleUnSelectTextColor
                    this.codeListData.codeListTitleSelectBackGroupColor = this.codeListTitleSelectBackGroupColor
                    this.codeListData.codeListTitleUnSelectBackGroupColor = this.codeListTitleUnSelectBackGroupColor
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/CodeListDetailsPage", params: this.codeListData })
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
