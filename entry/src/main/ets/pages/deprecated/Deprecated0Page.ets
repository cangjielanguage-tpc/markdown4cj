import { titleComponent } from '../../component/BaseComponent'
import { getFileListStr } from '../../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseTabComponent } from '../../component/BaseTabComponent'
import { TypeEnum } from '../../model/TypeEnum'
import {
  booleanListGeneralData,
  colorListGeneralData,
  marginListGeneralData,
  textNumberListGeneralData,
  timeListGeneralData
} from '../../model/GeneralData'
import { DeprecatedData } from '../../model/DeprecatedData'

@Entry
@Component
struct Deprecated0Page {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  // 顶部导航栏高度
  @StorageProp('safeTop') safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "100_Deprecated"
  // rawfile文件夹列表
  @State folderList: Array<string> = new Array<string>()
  // 是否全量加载Markdown文本列表
  isFullList: Array<boolean> = booleanListGeneralData
  // 是否全量加载Markdown文本
  @State isFull: boolean = true
  // 是否增量解析Markdown文本列表
  incrementalAnalysisList: Array<boolean> = booleanListGeneralData
  // 是否增量解析Markdown文本
  @State incrementalAnalysis: boolean = false
  // 增量加载每次间隔时间列表
  timeList: Array<number> = timeListGeneralData
  // 增量加载每次间隔时间
  @State time: number = 50
  // 增量每次增量文本数量列表
  textNumberList: Array<number> = textNumberListGeneralData
  // 增量每次增量文本数量
  @State textNumber: number = 10
  // 是否同步解析Markdown文本列表
  isMarkdownParserSyncList: Array<boolean> = booleanListGeneralData
  // 是否同步解析Markdown文本
  @State isMarkdownParserSync: boolean = false
  // 是否打开长按复制粘贴效果列表
  isOnCopyList: Array<boolean> = booleanListGeneralData
  // 是否打开长按复制粘贴效果
  @State isOnCopy: boolean = false
  // Markdown文本第一个模块上边距列表
  blockFirstTopMarginList: Array<number> = marginListGeneralData
  // Markdown文本第一个模块上边距
  @State blockFirstTopMargin: number = 8
  // Markdown文本最后一个模块下边距列表
  blockLastBottomMarginList: Array<number> = marginListGeneralData
  // Markdown文本最后一个模块下边距
  @State blockLastBottomMargin: number = 8
  // Markdown文本模块间上下间距列表
  blockTopAndBottomMarginsList: Array<number> = marginListGeneralData
  // Markdown文本模块间上下间距
  @State blockTopAndBottomMargins: number = 8
  // 是否允许markdown控件自身响应滑动列表
  openGestureSwipeList: Array<boolean> = booleanListGeneralData
  // 是否允许markdown控件自身响应滑动
  @State openGestureSwipe: boolean = false
  // 是否开启响应滑动测试列表
  openGestureSwipeTestList: Array<boolean> = booleanListGeneralData
  @State openGestureSwipeTest: boolean = false // 是否开启响应滑动测试

  // ---------------- 其他配置
  // 删除线颜色列表
  strikethroughColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State strikethroughColor: number = 0xFF191919 // 删除线颜色
  // 删除线样式列表
  strikethroughStyleList: Array<TextDecorationStyle> = [TextDecorationStyle.SOLID, TextDecorationStyle.DOUBLE, TextDecorationStyle.DASHED, TextDecorationStyle.DOTTED, TextDecorationStyle.WAVY]
  @State strikethroughStyle: TextDecorationStyle = TextDecorationStyle.SOLID // 删除线样式
  // 定义列表定义行缩进列表
  descListTermAndDefMarginsList: Array<number> = marginListGeneralData
  @State descListTermAndDefMargins: number = 8 // 定义列表定义行缩进
  // 定义列表定义行缩进列表
  descListDefIndentationList: Array<number> = marginListGeneralData
  @State descListDefIndentation: number = 8 // 定义列表定义行缩进
  // 定义列表定义行间距列表
  descListDefMarginsList: Array<number> = marginListGeneralData
  @State descListDefMargins: number = 8 // 定义列表定义行间距
  // 下标字体颜色列表
  subTextColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State subTextColor: number = 0xFF191919 // 下标字体颜色
  // 下标字体大小列表
  subTextSizeList: Array<number> = [6, 7, 8, 9, 10]
  @State subTextSize: number = 8 // 下标字体大小
  // 下标偏移距离列表
  subOffsetDistList: Array<number> = [0, 1, 2, 3, 4]
  @State subOffsetDist: number = 0 // 下标偏移距离
  // 上标字体颜色列表
  supTextColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State supTextColor: number = 0xFF191919 // 上标字体颜色
  // 上标字体大小列表
  supTextSizeList: Array<number> = [6, 7, 8, 9, 10]
  @State supTextSize: number = 8 // 上标字体大小
  // 上标偏移距离列表
  supOffsetDistList: Array<number> = [4, 5, 6, 7, 8]
  @State supOffsetDist: number = 6 // 上标偏移距离

  // ---------------- 块引用配置
  // 块引用左边距列表
  blockQuoteLeftMarginList: Array<number> = marginListGeneralData
  @State blockQuoteLeftMargin: number = 8 // 块引用左边距
  // 块引用右边距列表
  blockQuoteRightMarginList: Array<number> = marginListGeneralData
  @State blockQuoteRightMargin: number = 8 // 块引用右边距
  // 块引用左边线条宽度列表
  blockQuoteWidthList: Array<number> = [0, 1, 2, 3, 4]
  @State blockQuoteWidth: number = 1 // 块引用左边线条宽度
  // 块引用左边线条颜色列表
  blockQuoteColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State blockQuoteColor: number = 0xFF191919 // 块引用左边线条颜色
  // 块引用背景颜色列表
  blockQuoteBackGroupColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State blockQuoteBackGroupColor: number = 0xFFEAEAEA // 块引用背景颜色
  // 块引用子模块上下间距列表
  blockQuoteTopAndBottomMarginsList: Array<number> = marginListGeneralData
  @State blockQuoteTopAndBottomMargins: number = 0 // 块引用子模块上下间距

  @State deprecatedData: DeprecatedData = new DeprecatedData() // 配置数据内容

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "废弃配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Scroll() {
        Column() {
          // ------------ 基础配置
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
            titleStr: "markdown是否同步解析 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isMarkdownParserSyncList,
            allData: this.isMarkdownParserSync
          })
          BaseTabComponent({
            titleStr: "是否打开长按复制粘贴 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isOnCopyList,
            allData: this.isOnCopy
          })
          BaseTabComponent({
            titleStr: "markdown第一个模块上边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockFirstTopMarginList,
            allData: this.blockFirstTopMargin
          })
          BaseTabComponent({
            titleStr: "markdown最后一个模块下边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockLastBottomMarginList,
            allData: this.blockLastBottomMargin
          })
          BaseTabComponent({
            titleStr: "模块间上下间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockTopAndBottomMarginsList,
            allData: this.blockTopAndBottomMargins
          })
          BaseTabComponent({
            titleStr: "markdown是否支持滚动手势 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.openGestureSwipeList,
            allData: this.openGestureSwipe
          })
          BaseTabComponent({
            titleStr: "是否开启响应滑动测试 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.openGestureSwipeTestList,
            allData: this.openGestureSwipeTest
          })

          // ------------ 其他配置
          BaseTabComponent({
            titleStr: "删除线颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.strikethroughColorList,
            allData: this.strikethroughColor
          })
          BaseTabComponent({
            titleStr: "删除线样式 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.strikethroughStyleList,
            allData: this.strikethroughStyle
          })
          BaseTabComponent({
            titleStr: "块引用左边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockQuoteLeftMarginList,
            allData: this.blockQuoteLeftMargin
          })
          BaseTabComponent({
            titleStr: "块引用右边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockQuoteRightMarginList,
            allData: this.blockQuoteRightMargin
          })
          BaseTabComponent({
            titleStr: "块引用宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockQuoteWidthList,
            allData: this.blockQuoteWidth
          })
          BaseTabComponent({
            titleStr: "块引用颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.blockQuoteColorList,
            allData: this.blockQuoteColor
          })
          BaseTabComponent({
            titleStr: "块引用背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.blockQuoteBackGroupColorList,
            allData: this.blockQuoteBackGroupColor
          })
          BaseTabComponent({
            titleStr: "块引用上下间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockQuoteTopAndBottomMarginsList,
            allData: this.blockQuoteTopAndBottomMargins
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
                    // ---------- 基础配置
                    this.deprecatedData._isFull = this.isFull
                    this.deprecatedData._incrementalAnalysis = this.incrementalAnalysis
                    this.deprecatedData._time = this.time
                    this.deprecatedData._textNumber = this.textNumber
                    this.deprecatedData._isMarkdownParserSync = this.isMarkdownParserSync
                    this.deprecatedData._isOnCopy = this.isOnCopy
                    this.deprecatedData._blockFirstTopMargin = this.blockFirstTopMargin
                    this.deprecatedData._blockLastBottomMargin = this.blockLastBottomMargin
                    this.deprecatedData._blockTopAndBottomMargins = this.blockTopAndBottomMargins
                    this.deprecatedData._openGestureSwipe = this.openGestureSwipe
                    this.deprecatedData._openGestureSwipeTest = this.openGestureSwipeTest

                    // ---------- 其他配置
                    this.deprecatedData._strikethroughColor = this.strikethroughColor
                    this.deprecatedData._strikethroughStyle = this.strikethroughStyle
                    
                    this.deprecatedData._blockQuoteLeftMargin = this.blockQuoteLeftMargin
                    this.deprecatedData._blockQuoteRightMargin = this.blockQuoteRightMargin
                    this.deprecatedData._blockQuoteWidth = this.blockQuoteWidth
                    this.deprecatedData._blockQuoteColor = this.blockQuoteColor
                    this.deprecatedData._blockQuoteBackGroupColor = this.blockQuoteBackGroupColor
                    this.deprecatedData._blockQuoteTopAndBottomMargins = this.blockQuoteTopAndBottomMargins

                    this.deprecatedData._pagePath = `${this.rawFilePath}/${item}`

                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/deprecated/Deprecated0DetailsPage", params: this.deprecatedData })
                  })
              }
            })
          }
          // 设置ListItem在List交叉轴方向的布局方式
          .alignListItem(ListItemAlign.Center)
        }
        .padding({ bottom: 100 })
      }
    }
    .backgroundColor($r('app.color.page_background'))
    .height("100%")
  }
}
