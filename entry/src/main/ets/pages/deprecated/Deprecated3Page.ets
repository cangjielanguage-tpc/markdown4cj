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

// 标题、段落、分割线、内联代码
@Entry
@Component
struct Deprecated3Page {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  // 顶部导航栏高度
  @StorageProp('safeTop') safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "103_Deprecated"
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

  // ---------------- 标题配置
  // H1、H2标题下分割线高度列表
  headingBreakHeightList: Array<number> = [0, 0.5, 1, 2, 3]
  @State headingBreakHeight: number = 0.5 // H1、H2标题下分割线高度
  // 一级标题文本大小列表
  headingTextSize1List: Array<number> = textNumberListGeneralData
  @State headingTextSize1: number = 20 // 一级标题文本大小
  // 二级标题文本大小列表
  headingTextSize2List: Array<number> = textNumberListGeneralData
  @State headingTextSize2: number = 17 // 二级标题文本大小
  // 三级标题文本大小列表
  headingTextSize3List: Array<number> = textNumberListGeneralData
  @State headingTextSize3: number = 16 // 三级标题文本大小
  // 标题文本字体列表
  headingTypefaceList: Array<string> = ["HarmonyOS Sans", "HarmonyOS Sans SC", "monospace"]
  @State headingTypeface: string = "HarmonyOS Sans" // 标题文本字体
  // 标题模块上间距列表
  headingTopMarginsList: Array<number> = marginListGeneralData
  @State headingTopMargins: number = 8 // 标题模块上间距
  // 标题模块下间距列表
  headingBottomMarginsList: Array<number> = marginListGeneralData
  @State headingBottomMargins: number = 8 // 标题模块下间距
  // 四级标题文本大小列表
  headingTextSize4List: Array<number> = textNumberListGeneralData
  @State headingTextSize4: number = 15 // 四级标题文本大小
  // 五级标题文本大小列表
  headingTextSize5List: Array<number> = textNumberListGeneralData
  @State headingTextSize5: number = 15 // 五级标题文本大小
  // 六级标题文本大小列表
  headingTextSize6List: Array<number> = textNumberListGeneralData
  @State headingTextSize6: number = 13 // 六级标题文本大小
  // 标题文本字间距列表
  headingTextWordSpaceList: Array<number> = [0, 1, 2, 3, 4]
  @State headingTextWordSpace: number = 0 // 标题文本字间距
  // 一级标题文本行高列表
  headingTextLineHeight1List: Array<number> = textNumberListGeneralData
  @State headingTextLineHeight1: number = 22 // 一级标题文本行高
  // 二级标题文本行高列表
  headingTextLineHeight2List: Array<number> = textNumberListGeneralData
  @State headingTextLineHeight2: number = 22 // 二级标题文本行高
  // 三级标题文本行高列表
  headingTextLineHeight3List: Array<number> = textNumberListGeneralData
  @State headingTextLineHeight3: number = 22 // 三级标题文本行高
  // 四级标题文本行高列表
  headingTextLineHeight4List: Array<number> = textNumberListGeneralData
  @State headingTextLineHeight4: number = 22 // 四级标题文本行高
  // 五级标题文本行高列表
  headingTextLineHeight5List: Array<number> = textNumberListGeneralData
  @State headingTextLineHeight5: number = 22 // 五级标题文本行高
  // 六级标题文本行高列表
  headingTextLineHeight6List: Array<number> = textNumberListGeneralData
  @State headingTextLineHeight6: number = 22 // 六级标题文本行高
  // 一级标题文本颜色列表
  headingTextColor1List: Array<ResourceColor | undefined> = colorListGeneralData
  @State headingTextColor1: number = 0xFF191919 // 一级标题文本颜色
  // H1标题下分割线颜色列表
  headingBreakColor1List: Array<ResourceColor | undefined> = colorListGeneralData
  @State headingBreakColor1: number = 0xFF191919 // H1标题下分割线颜色
  // 二级标题文本颜色列表
  headingTextColor2List: Array<ResourceColor | undefined> = colorListGeneralData
  @State headingTextColor2: number = 0xFF191919 // 二级标题文本颜色
  // H2标题下分割线颜色列表
  headingBreakColor2List: Array<ResourceColor | undefined> = colorListGeneralData
  @State headingBreakColor2: number = 0xFF191919 // H2标题下分割线颜色
  // 三级标题文本颜色列表
  headingTextColor3List: Array<ResourceColor | undefined> = colorListGeneralData
  @State headingTextColor3: number = 0xFF191919 // 三级标题文本颜色
  // 四级标题文本颜色列表
  headingTextColor4List: Array<ResourceColor | undefined> = colorListGeneralData
  @State headingTextColor4: number = 0xFF191919 // 四级标题文本颜色
  // 五级标题文本颜色列表
  headingTextColor5List: Array<ResourceColor | undefined> = colorListGeneralData
  @State headingTextColor5: number = 0xFF191919 // 五级标题文本颜色
  // 六级标题文本颜色列表
  headingTextColor6List: Array<ResourceColor | undefined> = colorListGeneralData
  @State headingTextColor6: number = 0xFF191919 // 六级标题文本颜色

  // ---------------- 段落配置
  // 段落文本大小列表
  paragraphTextSizeList: Array<number> = textNumberListGeneralData
  @State paragraphTextSize: number = 14 // 段落文本大小
  // 段落文本颜色列表
  paragraphTextColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State paragraphTextColor: number = 0xFF191919 // 段落文本颜色
  // 段落文本字体列表
  paragraphTypefaceList: Array<string> = ["HarmonyOS Sans", "HarmonyOS Sans SC", "monospace"]
  @State paragraphTypeface: string = "HarmonyOS Sans" // 段落文本字体
  // 段落模块上间距列表
  paragraphTopMarginsList: Array<number> = marginListGeneralData
  @State paragraphTopMargins: number = 8 // 段落模块上间距
  // 段落模块下间距列表
  paragraphBottomMarginsList: Array<number> = marginListGeneralData
  @State paragraphBottomMargins: number = 8 // 段落模块下间距
  // 段落文本字间距列表
  paragraphTextWordSpaceList: Array<number> = [0, 1, 2, 3, 4]
  @State paragraphTextWordSpace: number = 0 // 段落文本字间距
  // 段落文本行高列表
  paragraphTextLineHeightList: Array<number> = textNumberListGeneralData
  @State paragraphTextLineHeight: number = 22 // 段落文本行高

  // ---------------- 分割线配置
  // 分割线颜色列表
  thematicBreakColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State thematicBreakColor: number = 0xFF191919 // 分割线颜色
  // 分割线高度列表
  thematicBreakHeightList: Array<number> = [0, 0.5, 1, 2, 3]
  @State thematicBreakHeight: number = 0.5 // 分割线高度
  // 分割线上部外边距列表
  thematicBreakTopMarginList: Array<number> = marginListGeneralData
  @State thematicBreakTopMargin: number = 0 // 分割线上部外边距
  // 分割线下部外边距列表
  thematicBreakBottomMarginList: Array<number> = marginListGeneralData
  @State thematicBreakBottomMargin: number = 0 // 分割线下部外边距

  // ---------------- 内联代码配置
  // 内联代码文本颜色列表
  codeTextColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State codeTextColor: number = 0xFF000000 // 内联代码文本颜色
  // 内联代码背景颜色列表
  codeBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State codeBackgroundColor: number = 0xFFEAEAEA // 内联代码背景颜色
  // 内联代码文本大小列表
  codeTextSizeList: Array<number> = textNumberListGeneralData
  @State codeTextSize: number = 13 // 内联代码文本大小
  // 内联代码文本字体列表
  codeTypefaceList: Array<string> = ["HarmonyOS Sans", "HarmonyOS Sans SC", "monospace"]
  @State codeTypeface: string = "HarmonyOS Sans" // 内联代码文本字体

  @State deprecatedData: DeprecatedData = new DeprecatedData() // 配置数据内容

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "标题段落配置页面",
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

          // ------------ 标题配置
          BaseTabComponent({
            titleStr: "H1/H2标题下分割线高度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingBreakHeightList,
            allData: this.headingBreakHeight
          })
          BaseTabComponent({
            titleStr: "一级标题文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextSize1List,
            allData: this.headingTextSize1
          })
          BaseTabComponent({
            titleStr: "二级标题文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextSize2List,
            allData: this.headingTextSize2
          })
          BaseTabComponent({
            titleStr: "三级标题文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextSize3List,
            allData: this.headingTextSize3
          })
          BaseTabComponent({
            titleStr: "四级标题文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextSize4List,
            allData: this.headingTextSize4
          })
          BaseTabComponent({
            titleStr: "五级标题文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextSize5List,
            allData: this.headingTextSize5
          })
          BaseTabComponent({
            titleStr: "六级标题文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextSize6List,
            allData: this.headingTextSize6
          })
          BaseTabComponent({
            titleStr: "标题文本字体 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.headingTypefaceList,
            allData: this.headingTypeface
          })
          BaseTabComponent({
            titleStr: "标题模块上间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTopMarginsList,
            allData: this.headingTopMargins
          })
          BaseTabComponent({
            titleStr: "标题模块下间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingBottomMarginsList,
            allData: this.headingBottomMargins
          })
          BaseTabComponent({
            titleStr: "标题文本字间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextWordSpaceList,
            allData: this.headingTextWordSpace
          })
          BaseTabComponent({
            titleStr: "一级标题文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextLineHeight1List,
            allData: this.headingTextLineHeight1
          })
          BaseTabComponent({
            titleStr: "二级标题文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextLineHeight2List,
            allData: this.headingTextLineHeight2
          })
          BaseTabComponent({
            titleStr: "三级标题文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextLineHeight3List,
            allData: this.headingTextLineHeight3
          })
          BaseTabComponent({
            titleStr: "四级标题文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextLineHeight4List,
            allData: this.headingTextLineHeight4
          })
          BaseTabComponent({
            titleStr: "五级标题文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextLineHeight5List,
            allData: this.headingTextLineHeight5
          })
          BaseTabComponent({
            titleStr: "六级标题文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextLineHeight6List,
            allData: this.headingTextLineHeight6
          })
          BaseTabComponent({
            titleStr: "一级标题文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.headingTextColor1List,
            allData: this.headingTextColor1
          })
          BaseTabComponent({
            titleStr: "H1标题下分割线颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.headingBreakColor1List,
            allData: this.headingBreakColor1
          })
          BaseTabComponent({
            titleStr: "二级标题文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.headingTextColor2List,
            allData: this.headingTextColor2
          })
          BaseTabComponent({
            titleStr: "H2标题下分割线颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.headingBreakColor2List,
            allData: this.headingBreakColor2
          })
          BaseTabComponent({
            titleStr: "三级标题文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.headingTextColor3List,
            allData: this.headingTextColor3
          })
          BaseTabComponent({
            titleStr: "四级标题文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.headingTextColor4List,
            allData: this.headingTextColor4
          })
          BaseTabComponent({
            titleStr: "五级标题文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.headingTextColor5List,
            allData: this.headingTextColor5
          })
          BaseTabComponent({
            titleStr: "六级标题文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.headingTextColor6List,
            allData: this.headingTextColor6
          })

          // ------------ 段落配置
          BaseTabComponent({
            titleStr: "段落文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.paragraphTextSizeList,
            allData: this.paragraphTextSize
          })
          BaseTabComponent({
            titleStr: "段落文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.paragraphTextColorList,
            allData: this.paragraphTextColor
          })
          BaseTabComponent({
            titleStr: "段落文本字体 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.paragraphTypefaceList,
            allData: this.paragraphTypeface
          })
          BaseTabComponent({
            titleStr: "段落模块上间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.paragraphTopMarginsList,
            allData: this.paragraphTopMargins
          })
          BaseTabComponent({
            titleStr: "段落模块下间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.paragraphBottomMarginsList,
            allData: this.paragraphBottomMargins
          })
          BaseTabComponent({
            titleStr: "段落文本字间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.paragraphTextWordSpaceList,
            allData: this.paragraphTextWordSpace
          })
          BaseTabComponent({
            titleStr: "段落文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.paragraphTextLineHeightList,
            allData: this.paragraphTextLineHeight
          })

          // ------------ 分割线配置
          BaseTabComponent({
            titleStr: "分割线颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.thematicBreakColorList,
            allData: this.thematicBreakColor
          })
          BaseTabComponent({
            titleStr: "分割线高度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.thematicBreakHeightList,
            allData: this.thematicBreakHeight
          })
          BaseTabComponent({
            titleStr: "分割线上部外边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.thematicBreakTopMarginList,
            allData: this.thematicBreakTopMargin
          })
          BaseTabComponent({
            titleStr: "分割线下部外边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.thematicBreakBottomMarginList,
            allData: this.thematicBreakBottomMargin
          })

          // ------------ 内联代码配置
          BaseTabComponent({
            titleStr: "内联代码文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.codeTextColorList,
            allData: this.codeTextColor
          })
          BaseTabComponent({
            titleStr: "内联代码背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.codeBackgroundColorList,
            allData: this.codeBackgroundColor
          })
          BaseTabComponent({
            titleStr: "内联代码文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.codeTextSizeList,
            allData: this.codeTextSize
          })
          BaseTabComponent({
            titleStr: "内联代码文本字体 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.codeTypefaceList,
            allData: this.codeTypeface
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

                    // ---------- 标题配置
                    this.deprecatedData.headingBreakHeight = this.headingBreakHeight
                    this.deprecatedData.headingTextSize1 = this.headingTextSize1
                    this.deprecatedData.headingTextSize2 = this.headingTextSize2
                    this.deprecatedData.headingTextSize3 = this.headingTextSize3
                    this.deprecatedData.headingTextSize4 = this.headingTextSize4
                    this.deprecatedData.headingTextSize5 = this.headingTextSize5
                    this.deprecatedData.headingTextSize6 = this.headingTextSize6
                    this.deprecatedData.headingTypeface = this.headingTypeface
                    this.deprecatedData.headingTopMargins = this.headingTopMargins
                    this.deprecatedData.headingBottomMargins = this.headingBottomMargins
                    this.deprecatedData.headingTextWordSpace = this.headingTextWordSpace
                    this.deprecatedData.headingTextLineHeight1 = this.headingTextLineHeight1
                    this.deprecatedData.headingTextLineHeight2 = this.headingTextLineHeight2
                    this.deprecatedData.headingTextLineHeight3 = this.headingTextLineHeight3
                    this.deprecatedData.headingTextLineHeight4 = this.headingTextLineHeight4
                    this.deprecatedData.headingTextLineHeight5 = this.headingTextLineHeight5
                    this.deprecatedData.headingTextLineHeight6 = this.headingTextLineHeight6
                    this.deprecatedData.headingTextColor1 = this.headingTextColor1
                    this.deprecatedData.headingBreakColor1 = this.headingBreakColor1
                    this.deprecatedData.headingTextColor2 = this.headingTextColor2
                    this.deprecatedData.headingBreakColor2 = this.headingBreakColor2
                    this.deprecatedData.headingTextColor3 = this.headingTextColor3
                    this.deprecatedData.headingTextColor4 = this.headingTextColor4
                    this.deprecatedData.headingTextColor5 = this.headingTextColor5
                    this.deprecatedData.headingTextColor6 = this.headingTextColor6

                    // ---------- 段落配置
                    this.deprecatedData.paragraphTextSize = this.paragraphTextSize
                    this.deprecatedData.paragraphTextColor = this.paragraphTextColor
                    this.deprecatedData.paragraphTypeface = this.paragraphTypeface
                    this.deprecatedData.paragraphTopMargins = this.paragraphTopMargins
                    this.deprecatedData.paragraphBottomMargins = this.paragraphBottomMargins
                    this.deprecatedData.paragraphTextWordSpace = this.paragraphTextWordSpace
                    this.deprecatedData.paragraphTextLineHeight = this.paragraphTextLineHeight

                    // ---------- 分割线配置
                    this.deprecatedData.thematicBreakColor = this.thematicBreakColor
                    this.deprecatedData.thematicBreakHeight = this.thematicBreakHeight
                    this.deprecatedData.thematicBreakTopMargin = this.thematicBreakTopMargin
                    this.deprecatedData.thematicBreakBottomMargin = this.thematicBreakBottomMargin

                    // ---------- 内联代码配置
                    this.deprecatedData.codeTextColor = this.codeTextColor
                    this.deprecatedData.codeBackgroundColor = this.codeBackgroundColor
                    this.deprecatedData.codeTextSize = this.codeTextSize
                    this.deprecatedData.codeTypeface = this.codeTypeface

                    this.deprecatedData.pagePath = `${this.rawFilePath}/${item}`

                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/deprecated/Deprecated3DetailsPage", params: this.deprecatedData })
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
