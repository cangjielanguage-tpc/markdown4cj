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

// 代码块配置
@Entry
@Component
struct Deprecated5Page {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  // 顶部导航栏高度
  @StorageProp('safeTop') safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "105_Deprecated"
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

  // ---------------- 代码配置
  // 代码块全屏图片icon
  codeFullScreenIconList: Array<Resource | undefined> = [undefined]
  @State codeFullScreenIcon: Resource | undefined = undefined // 代码块全屏图片icon
  // 代码块复制图片icon
  codeCopyIconList: Array<Resource | undefined> = [undefined]
  @State codeCopyIcon: Resource | undefined = undefined // 代码块复制图片icon
  // 设置是否格式化代码块内容列表
  isCodeFormatList: Array<boolean> = booleanListGeneralData
  @State isCodeFormat: boolean = false // 设置是否格式化代码块内容
  // codeformat是否用制表符列表
  useTabList: Array<boolean> = booleanListGeneralData
  @State useTab: boolean = false // codeformat是否用制表符
  // codeformat空格缩进数量列表
  indentWidthList: Array<number> = [2, 3, 4, 5, 6]
  @State indentWidth: number = 4 // codeformat空格缩进数量，默认4空格
  // 代码深浅色模式列表
  isDarkList: Array<boolean> = booleanListGeneralData
  @State isDark: boolean = false // 代码深浅色模式
  // 代码块代码文本颜色列表
  codeBlockTextColorList: Array<number | undefined> = colorListGeneralData
  @State codeBlockTextColor: number | undefined = undefined // 代码块代码文本颜色
  // 围栏代码块代码高亮是否同步解析列表
  isCodeBlockParserSyncList: Array<boolean> = booleanListGeneralData
  @State isCodeBlockParserSync: boolean = false // 围栏代码块代码高亮是否同步解析
  // 代码块代码行号是否显示列表
  codeBlockLineNumberHideList: Array<boolean> = booleanListGeneralData
  @State codeBlockLineNumberHide: boolean = true // 代码块代码行号是否显示
  // 代码块代码全屏按钮是否显示列表
  isCodeFullScreenList: Array<boolean> = booleanListGeneralData
  @State isCodeFullScreen: boolean = true // 代码块代码全屏按钮是否显示
  // 代码块代码类型文本颜色列表
  codeBlockTypeTextColorList: Array<number | undefined> = colorListGeneralData
  @State codeBlockTypeTextColor: number | undefined = undefined // 代码块代码类型文本颜色
  // 代码块代码类型文本列表
  codeBlockTypeTextStrList: Array<string> = ["", "Code", "JavaScript", "Python"]
  @State codeBlockTypeTextStr: string = "" // 代码块代码类型文本
  // 代码类型和代码块距离列表
  codeBlockTypeTextPaddingList: Array<number> = [0, 2, 4, 6, 8]
  @State codeBlockTypeTextPadding: number = 0 // 代码类型和代码块距离
  // 代码块复制、全屏图片文字是否显示列表
  codeBlockIconTextHideList: Array<boolean> = booleanListGeneralData
  @State codeBlockIconTextHide: boolean = true // 代码块复制、全屏图片文字是否显示
  // 代码块背景颜色列表
  codeBlockBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State codeBlockBackgroundColor: number | undefined = undefined // 代码块背景颜色
  // 代码块左边距列表
  codeMultilineMarginList: Array<number> = marginListGeneralData
  @State codeMultilineMargin: number = 8 // 代码块左边距
  // 代码块字体列表
  codeBlockTypefaceList: Array<string> = ["HarmonyOS Sans", "HarmonyOS Sans SC", "monospace"]
  @State codeBlockTypeface: string = "HarmonyOS Sans" // 代码块字体
  // 代码块代码文本大小列表
  codeBlockTextSizeList: Array<number> = textNumberListGeneralData
  @State codeBlockTextSize: number = 13 // 代码块代码文本大小
  // 代码块代码文本行高列表
  codeBlockLineHeightList: Array<number> = textNumberListGeneralData
  @State codeBlockLineHeight: number = 22 // 代码块代码文本行高
  // 代码块控件圆角大小列表
  codeBlockRadiusList: Array<number> = [4, 6, 8, 10, 12]
  @State codeBlockRadius: number = 8 // 代码块控件圆角大小
  // 代码块代码全屏、代码复制按钮宽高列表
  iconWidthAndHeightList: Array<number> = [20, 22, 24, 26, 28]
  @State iconWidthAndHeight: number = 24 // 代码块代码全屏、代码复制按钮宽高
  // 组合代码未选中标题字体大小列表
  codeListTitleTextSizeList: Array<number> = textNumberListGeneralData
  @State codeListTitleTextSize: number = 13 // 组合代码未选中标题字体大小
  // 组合代码选中标题字体大小列表
  codeListTitleSelectTextSizeList: Array<number> = textNumberListGeneralData
  @State codeListTitleSelectTextSize: number = 13 // 组合代码选中标题字体大小
  // 组合代码选中标题文本颜色列表
  codeListTitleSelectTextColorList: Array<number | undefined> = colorListGeneralData
  @State codeListTitleSelectTextColor: number = 0xFFFF0000 // 组合代码选中标题文本颜色
  // 组合代码未选中标题文本颜色列表
  codeListTitleUnSelectTextColorList: Array<number | undefined> = colorListGeneralData
  @State codeListTitleUnSelectTextColor: number = 0xFF000000 // 组合代码未选中标题文本颜色
  // 组合代码选中标题背景颜色列表
  codeListTitleSelectBackGroupColorList: Array<number | undefined> = colorListGeneralData
  @State codeListTitleSelectBackGroupColor: number = 0xFF808080 // 组合代码选中标题背景颜色
  // 组合代码未选中标题背景颜色列表
  codeListTitleUnSelectBackGroupColorList: Array<number | undefined> = colorListGeneralData
  @State codeListTitleUnSelectBackGroupColor: number = 0x00000000 // 组合代码未选中标题背景颜色
  // 是否单独代码块显示列表
  isSeparateCodeBlockList: Array<boolean> = booleanListGeneralData
  @State isSeparateCodeBlock: boolean = false // 是否单独代码块显示
  // 单独代码块行号宽度列表
  separateCodeBlockWidthList: Array<number> = [30, 40, 50, 60, 70]
  @State separateCodeBlockWidth: number = 50 // 单独代码块行号宽度
  // 单独代码块是否居底显示列表
  separateCodeIsBottomList: Array<boolean> = booleanListGeneralData
  @State separateCodeIsBottom: boolean = false // 单独代码块是否居底显示

  @State deprecatedData: DeprecatedData = new DeprecatedData() // 配置数据内容

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "代码块配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Scroll() {
        Column() {
          // ------------ 通用配置
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
            titleStr: "Markdown文本第一个模块上边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockFirstTopMarginList,
            allData: this.blockFirstTopMargin
          })
          BaseTabComponent({
            titleStr: "Markdown文本最后一个模块下边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockLastBottomMarginList,
            allData: this.blockLastBottomMargin
          })
          BaseTabComponent({
            titleStr: "Markdown文本模块间上下间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockTopAndBottomMarginsList,
            allData: this.blockTopAndBottomMargins
          })
          BaseTabComponent({
            titleStr: "是否允许markdown控件自身响应滑动 - ",
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

          // ------------ 代码配置
          BaseTabComponent({
            titleStr: "设置是否格式化代码块内容 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isCodeFormatList,
            allData: this.isCodeFormat
          })
          BaseTabComponent({
            titleStr: "codeformat是否用制表符 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.useTabList,
            allData: this.useTab
          })
          BaseTabComponent({
            titleStr: "codeformat空格缩进数量 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.indentWidthList,
            allData: this.indentWidth
          })
          BaseTabComponent({
            titleStr: "代码深浅色模式 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isDarkList,
            allData: this.isDark
          })
          BaseTabComponent({
            titleStr: "围栏代码块代码高亮是否同步解析 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isCodeBlockParserSyncList,
            allData: this.isCodeBlockParserSync
          })
          BaseTabComponent({
            titleStr: "代码块代码文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.codeBlockTextColorList,
            allData: this.codeBlockTextColor
          })
          BaseTabComponent({
            titleStr: "代码块代码类型文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.codeBlockTypeTextColorList,
            allData: this.codeBlockTypeTextColor
          })
          BaseTabComponent({
            titleStr: "代码块代码类型文本 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.codeBlockTypeTextStrList,
            allData: this.codeBlockTypeTextStr
          })
          BaseTabComponent({
            titleStr: "代码类型和代码块距离 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.codeBlockTypeTextPaddingList,
            allData: this.codeBlockTypeTextPadding
          })
          BaseTabComponent({
            titleStr: "代码块复制、全屏图片文字是否显示 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.codeBlockIconTextHideList,
            allData: this.codeBlockIconTextHide
          })
          BaseTabComponent({
            titleStr: "代码块背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.codeBlockBackgroundColorList,
            allData: this.codeBlockBackgroundColor
          })
          BaseTabComponent({
            titleStr: "代码块左边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.codeMultilineMarginList,
            allData: this.codeMultilineMargin
          })
          BaseTabComponent({
            titleStr: "代码块字体 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.codeBlockTypefaceList,
            allData: this.codeBlockTypeface
          })
          BaseTabComponent({
            titleStr: "代码块代码文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.codeBlockTextSizeList,
            allData: this.codeBlockTextSize
          })
          BaseTabComponent({
            titleStr: "代码块代码文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.codeBlockLineHeightList,
            allData: this.codeBlockLineHeight
          })
          BaseTabComponent({
            titleStr: "代码块控件圆角大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.codeBlockRadiusList,
            allData: this.codeBlockRadius
          })
          BaseTabComponent({
            titleStr: "代码块代码全屏、代码复制按钮宽高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.iconWidthAndHeightList,
            allData: this.iconWidthAndHeight
          })
          // 组合代码配置
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
          // 单独代码块配置
          BaseTabComponent({
            titleStr: "是否单独代码块显示 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isSeparateCodeBlockList,
            allData: this.isSeparateCodeBlock
          })
          BaseTabComponent({
            titleStr: "单独代码块行号宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.separateCodeBlockWidthList,
            allData: this.separateCodeBlockWidth
          })
          BaseTabComponent({
            titleStr: "单独代码块是否居底显示 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.separateCodeIsBottomList,
            allData: this.separateCodeIsBottom
          })
          BaseTabComponent({
            titleStr: "代码块代码行号是否显示 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.codeBlockLineNumberHideList,
            allData: this.codeBlockLineNumberHide
          })
          BaseTabComponent({
            titleStr: "代码块代码全屏按钮是否显示 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isCodeFullScreenList,
            allData: this.isCodeFullScreen
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
                    // ---------- 通用配置
                    this.deprecatedData.isFull = this.isFull
                    this.deprecatedData.incrementalAnalysis = this.incrementalAnalysis
                    this.deprecatedData.time = this.time
                    this.deprecatedData.textNumber = this.textNumber
                    this.deprecatedData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.deprecatedData.isOnCopy = this.isOnCopy
                    this.deprecatedData.blockFirstTopMargin = this.blockFirstTopMargin
                    this.deprecatedData.blockLastBottomMargin = this.blockLastBottomMargin
                    this.deprecatedData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
                    this.deprecatedData.openGestureSwipe = this.openGestureSwipe
                    this.deprecatedData.openGestureSwipeTest = this.openGestureSwipeTest

                    // ---------- 代码配置
                    this.deprecatedData.codeFullScreenIcon = this.codeFullScreenIcon
                    this.deprecatedData.codeCopyIcon = this.codeCopyIcon
                    this.deprecatedData.isCodeFormat = this.isCodeFormat
                    this.deprecatedData.useTab = this.useTab
                    this.deprecatedData.indentWidth = this.indentWidth
                    this.deprecatedData.isDark = this.isDark
                    this.deprecatedData.isCodeBlockParserSync = this.isCodeBlockParserSync
                    this.deprecatedData.codeBlockTextColor = this.codeBlockTextColor
                    this.deprecatedData.codeBlockTypeTextColor = this.codeBlockTypeTextColor
                    this.deprecatedData.codeBlockTypeTextStr = this.codeBlockTypeTextStr
                    this.deprecatedData.codeBlockTypeTextPadding = this.codeBlockTypeTextPadding
                    this.deprecatedData.codeBlockIconTextHide = this.codeBlockIconTextHide
                    this.deprecatedData.codeBlockBackgroundColor = this.codeBlockBackgroundColor
                    this.deprecatedData.codeMultilineMargin = this.codeMultilineMargin
                    this.deprecatedData.codeBlockTypeface = this.codeBlockTypeface
                    this.deprecatedData.codeBlockTextSize = this.codeBlockTextSize
                    this.deprecatedData.codeBlockLineHeight = this.codeBlockLineHeight
                    this.deprecatedData.codeBlockRadius = this.codeBlockRadius
                    this.deprecatedData.iconWidthAndHeight = this.iconWidthAndHeight
                    this.deprecatedData.codeBlockLineNumberHide = this.codeBlockLineNumberHide
                    this.deprecatedData.isCodeFullScreen = this.isCodeFullScreen
                    // 组合代码配置
                    this.deprecatedData.codeListTitleTextSize = this.codeListTitleTextSize
                    this.deprecatedData.codeListTitleSelectTextSize = this.codeListTitleSelectTextSize
                    this.deprecatedData.codeListTitleSelectTextColor = this.codeListTitleSelectTextColor
                    this.deprecatedData.codeListTitleUnSelectTextColor = this.codeListTitleUnSelectTextColor
                    this.deprecatedData.codeListTitleSelectBackGroupColor = this.codeListTitleSelectBackGroupColor
                    this.deprecatedData.codeListTitleUnSelectBackGroupColor = this.codeListTitleUnSelectBackGroupColor
                    // 单独代码块配置
                    this.deprecatedData.isSeparateCodeBlock = this.isSeparateCodeBlock
                    this.deprecatedData.separateCodeBlockWidth = this.separateCodeBlockWidth
                    this.deprecatedData.separateCodeIsBottom = this.separateCodeIsBottom

                    this.deprecatedData.pagePath = `${this.rawFilePath}/${item}`

                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/deprecated/Deprecated5DetailsPage", params: this.deprecatedData })
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
