/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { booleanToString, numberToColorString, stringToBoolean } from '../utils/BaseUtils'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct CodeBlockPage {
  /**
   * 滑动控制器
   */
  scroller: Scroller = new Scroller()
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop') safeTop: number = 0
  /**
   * rawfile路径
   */
  rawFilePath: string = "011_代码块"
  /**
   * rawfile标题文件夹列表
   */
  @State
  folderList: Array<string> = new Array<string>()
  /**
   * 增量加载全量加载选项列表
   */
  isFullList: Array<string> = ["全量加载", "增量加载"]
  /**
   * 增量加载全量加载选项
   */
  @State
  isFull: boolean = true
  /**
   * markdown是否增量解析列表
   */
  incrementalAnalysisList: Array<boolean> = [true, false]
  /**
   * markdown是否增量解析(true:增量解析,false:全量解析)
   */
  @State
  incrementalAnalysis: boolean = false
  /**
   * 增量加载每次间隔时间列表
   */
  timeList: Array<number> = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 200, 300, 400, 500]
  /**
   * 增量加载每次间隔时间 - 毫秒
   */
  @State
  time: number = 50
  /**
   * 增量每次增量文本数量列表
   */
  textNumberList: Array<number> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25, 30, 35, 40, 45, 50, 100, 150, 200]
  /**
   * 增量每次增量文本数量
   */
  @State
  textNumber: number = 10
  /**
   * 是否格式化代码块内容列表
   */
  isCodeFormatList: Array<boolean> = [true, false]
  /**
   * 是否格式化代码块内容
   */
  @State
  isCodeFormat: boolean = false
  /**
   * 代码块代码文本颜色列表
   */
  codeBlockTextColorList: Array<number | undefined> =
    [0xFF191919, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0, undefined]
  /**
   * 代码块代码文本颜色
   */
  @State
  codeBlockTextColor: number | undefined = undefined
  /**
   * 代码块代码类型文本颜色列表
   */
  codeBlockTypeTextColorList: Array<number | undefined> =
    [0xFF191919, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0, undefined]
  /**
   * 代码块代码类型文本颜色
   */
  @State
  codeBlockTypeTextColor: number | undefined = undefined
  /**
   * 代码块代码类型文本列表
   */
  codeBlockTypeTextStrList: Array<string> = ["", "代码块", "默认文本"]
  /**
   * 代码块代码类型文本
   */
  @State
  codeBlockTypeTextStr: string = ""
  /**
   * 代码类型和代码块距离列表
   */
  codeBlockTypeTextPaddingList: Array<number> =
    [0, 1, 2, 4, 8, 10, 12, 14, 15, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 代码类型和代码块距离
   */
  @State
  codeBlockTypeTextPadding: number = 0
  /**
   * 代码块复制、全屏图片文字是否显示列表
   */
  codeBlockIconTextHideList: Array<boolean> = [true, false]
  /**
   * 代码块复制、全屏图片文字是否显示
   */
  @State
  codeBlockIconTextHide: boolean = true
  /**
   * 代码块代码行号是否显示列表
   */
  codeBlockLineNumberHideList: Array<boolean> = [true, false]
  /**
   * 代码块代码行号是否显示
   */
  @State
  codeBlockLineNumberHide: boolean = true
  /**
   * 代码块背景颜色列表
   */
  codeBlockBackgroundColorList: Array<number | undefined> =
    [0xFF191919, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0, undefined]
  /**
   * 代码块背景颜色
   */
  @State
  codeBlockBackgroundColor: number | undefined = undefined
  /**
   * 代码块左边距列表
   */
  codeMultilineMarginList: Array<number> = [1, 2, 4, 8, 10, 12, 14, 15, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 代码块左边距
   */
  @State
  codeMultilineMargin: number = 8
  /**
   * 代码块字体列表
   */
  codeBlockTypefaceList: Array<string> = ["HarmonyOS Sans", "Hei"]
  /**
   * 代码块字体
   */
  @State
  codeBlockTypeface: string = "HarmonyOS Sans"
  /**
   * 代码块代码文本大小列表
   */
  codeBlockTextSizeList: Array<number> = [12, 13, 14, 15, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 代码块代码文本大小
   */
  @State
  codeBlockTextSize: number = 13
  /**
   * 代码块代码文本行高列表
   */
  codeBlockLineHeightList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 代码块代码文本行高
   */
  @State
  codeBlockLineHeight: number = 22
  /**
   * 代码块控件圆角大小列表
   */
  codeBlockRadiusList: Array<number> = [0, 5, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 代码块控件圆角大小
   */
  @State
  codeBlockRadius: number = 8
  /**
   * 代码块代码全屏按钮是否显示列表
   */
  isCodeFullScreenList: Array<boolean> = [true, false]
  /**
   * 代码块代码全屏按钮是否显示
   */
  @State
  isCodeFullScreen: boolean = true
  /**
   * 代码块代码全屏、代码复制按钮宽高列表
   */
  iconWidthAndHeightList: Array<number> = [0, 5, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 代码块代码全屏、代码复制按钮宽高
   */
  @State
  iconWidthAndHeight: number = 24
  /**
   * 代码块深浅色模式列表
   */
  isDarkList: Array<boolean> = [true, false]
  /**
   * 代码块深浅色模式
   */
  @State
  isDark: boolean = true
  /**
   * markdown是否同步解析
   */
  @State
  isMarkdownParserSync: boolean = false
  /**
   * markdown是否同步解析
   */
  isMarkdownParserSyncList: Array<boolean> = [true, false]
  /**
   * 是否开启打字机效果
   */
  @State
  typeWriterOpen: boolean = false
  /**
   * 是否开启打字机效果
   */
  typeWriterOpenList: Array<boolean> = [true, false]
  /**
   * 打字机效果颜色
   */
  @State
  typeWriterColor: number = 0xFFFF0000
  /**
   * 打字机效果颜色列表
   */
  typeWriterColorList: Array<number> = [0xFFF5F5F5, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 是否打开长按复制粘贴
   */
  @State
  isOnCopy: boolean = false
  /**
   * 是否打开长按复制粘贴
   */
  isOnCopyList: Array<boolean> = [true, false]
  /**
   * markdown第一个模块上边距
   */
  @State
  blockFirstTopMargin: number = 8
  /**
   * markdown第一个模块上边距
   */
  blockFirstTopMarginList: Array<number> = [0, 5, 8, 10, 15, 20, 25, 30, 35, 40]
  /**
   * markdown最后一个模块下边距
   */
  @State
  blockLastBottomMargin: number = 8
  /**
   * markdown最后一个模块下边距
   */
  blockLastBottomMarginList: Array<number> = [0, 5, 8, 10, 15, 20, 25, 30, 35, 40]
  /**
   * 模块间上下间距
   */
  @State
  blockTopAndBottomMargins: number = 8
  /**
   * 模块间上下间距
   */
  blockTopAndBottomMarginsList: Array<number> = [0, 5, 8, 10, 15, 20, 25, 30, 35, 40]
  /**
   * codeformat是否使用制表符
   */
  @State
  useTab: boolean = false
  /**
   * codeformat是否使用制表符列表
   */
  useTabList: Array<boolean> = [true, false]
  /**
   * codeformat空格缩进数量
   */
  @State
  indentWidth: number = 4
  /**
   * codeformat空格缩进数量列表
   */
  indentWidthList: Array<number> = [0, 2, 4, 6, 8, 10]
  /**
   * 配置数据内容
   */
  @State
  codeBlockData: CodeBlockData = new CodeBlockData()

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
          Column() {
            Row() {
              Text(`是否增量加载 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${booleanToString(this.isFull)}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isFullList, (item: string, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isFull = stringToBoolean(item)
                    this.codeBlockData.isFull = this.isFull
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`markdown是否增量解析 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.incrementalAnalysis}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.incrementalAnalysisList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.incrementalAnalysis = item
                    this.codeBlockData.incrementalAnalysis = this.incrementalAnalysis
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`增量加载每次间隔时间 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.time}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.timeList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.time = item
                    this.codeBlockData.time = this.time
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`增量每次增量文本数量 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.textNumber}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.textNumberList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.textNumber = item
                    this.codeBlockData.textNumber = this.textNumber
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块代码文本颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.codeBlockTextColor))
                .fontSize(16)
                .fontColor(this.codeBlockTextColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockTextColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockTextColor = item
                    this.codeBlockData.codeBlockTextColor = this.codeBlockTextColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块代码类型文本颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.codeBlockTypeTextColor))
                .fontSize(16)
                .fontColor(this.codeBlockTypeTextColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockTypeTextColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockTypeTextColor = item
                    this.codeBlockData.codeBlockTypeTextColor = this.codeBlockTypeTextColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`设置代码块代码类型文本 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeBlockTypeTextStr}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockTypeTextStrList, (item: string, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockTypeTextStr = item
                    this.codeBlockData.codeBlockTypeTextStr = this.codeBlockTypeTextStr
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`设置代码类型和代码块距离 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeBlockTypeTextPadding}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockTypeTextPaddingList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockTypeTextPadding = item
                    this.codeBlockData.codeBlockTypeTextPadding = this.codeBlockTypeTextPadding
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块复制、全屏图片文字是否显示 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeBlockIconTextHide}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockIconTextHideList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockIconTextHide = item
                    this.codeBlockData.codeBlockIconTextHide = this.codeBlockIconTextHide
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块代码行号是否显示 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeBlockLineNumberHide}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockLineNumberHideList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockLineNumberHide = item
                    this.codeBlockData.codeBlockLineNumberHide = this.codeBlockLineNumberHide
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块背景颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.codeBlockBackgroundColor))
                .fontSize(16)
                .fontColor(this.codeBlockBackgroundColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockBackgroundColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockBackgroundColor = item
                    this.codeBlockData.codeBlockBackgroundColor = this.codeBlockBackgroundColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块左边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeMultilineMargin}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeMultilineMarginList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeMultilineMargin = item
                    this.codeBlockData.codeMultilineMargin = this.codeMultilineMargin
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块字体 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeBlockTypeface}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockTypefaceList, (item: string, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockTypeface = item
                    this.codeBlockData.codeBlockTypeface = this.codeBlockTypeface
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块代码文本大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeBlockTextSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockTextSizeList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockTextSize = item
                    this.codeBlockData.codeBlockTextSize = this.codeBlockTextSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块代码文本行高 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeBlockLineHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockLineHeightList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockLineHeight = item
                    this.codeBlockData.codeBlockLineHeight = this.codeBlockLineHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块控件圆角大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeBlockRadius}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockRadiusList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockRadius = item
                    this.codeBlockData.codeBlockRadius = this.codeBlockRadius
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块代码全屏按钮是否显示 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.isCodeFullScreen}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isCodeFullScreenList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isCodeFullScreen = item
                    this.codeBlockData.isCodeFullScreen = this.isCodeFullScreen
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块代码全屏、代码复制按钮宽高 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.iconWidthAndHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.iconWidthAndHeightList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.iconWidthAndHeight = item
                    this.codeBlockData.iconWidthAndHeight = this.iconWidthAndHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块深浅色模式 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.isDark}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isDarkList, (item: boolean, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isDark = item
                    this.codeBlockData.isDark = this.isDark
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`markdown是否同步解析 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.isMarkdownParserSync}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isMarkdownParserSyncList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isMarkdownParserSync = item
                    this.codeBlockData.isMarkdownParserSync = this.isMarkdownParserSync
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`是否开启打字机效果 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.typeWriterOpen}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.typeWriterOpenList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.typeWriterOpen = item
                    this.codeBlockData.typeWriterOpen = this.typeWriterOpen
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`打字机效果颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.typeWriterColor))
                .fontSize(16)
                .fontColor(this.typeWriterColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.typeWriterColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.typeWriterColor = item
                    this.codeBlockData.typeWriterColor = this.typeWriterColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`是否打开长按复制粘贴 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.isOnCopy}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isOnCopyList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isOnCopy = item
                    this.codeBlockData.isOnCopy = this.isOnCopy
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`markdown第一个模块上边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.blockFirstTopMargin}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.blockFirstTopMarginList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.blockFirstTopMargin = item
                    this.codeBlockData.blockFirstTopMargin = this.blockFirstTopMargin
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`markdown最后一个模块下边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.blockLastBottomMargin}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.blockLastBottomMarginList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.blockLastBottomMargin = item
                    this.codeBlockData.blockLastBottomMargin = this.blockLastBottomMargin
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`模块间上下间距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.blockTopAndBottomMargins}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.blockTopAndBottomMarginsList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.blockTopAndBottomMargins = item
                    this.codeBlockData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`是否格式化代码块内容 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.isCodeFormat}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isCodeFormatList, (item: boolean, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isCodeFormat = item
                    this.codeBlockData.isCodeFormat = this.isCodeFormat
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`codeformat是否使用制表符 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.useTab}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.useTabList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.useTab = item
                    this.codeBlockData.useTab = this.useTab
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`codeformat空格缩进数量 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.indentWidth}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.indentWidthList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.indentWidth = item
                    this.codeBlockData.indentWidth = this.indentWidth
                  })
              })
            }
          }

          List() {
            ForEach(this.folderList, (item: string, index: number) => {
              ListItem() {
                Button(`${index + 1}、${item}`)
                  .height(40)// 高度
                  .width('80%')// 宽度
                  .type(ButtonType.Capsule)// 圆角
                  .fontColor(0xFFFFFFFF)// 文本颜色
                  .backgroundColor(0xFF317AFF)// 背景颜色
                  .margin({ top: 5, bottom: 5 })// 外边距
                  .align(Alignment.Center)// 内容对齐方式
                  .fontSize(16)// 字体大小
                  .onClick(() => {
                    // 点击动作触发该方法调用
                    this.codeBlockData.pagePath = `${this.rawFilePath}/${item}`
                    router.pushUrl({ url: "pages/CodeBlockDetailsPage", params: this.codeBlockData })
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
    .backgroundColor(0xFFEAEAEA)
    .height("100%")
  }
}

export class CodeBlockData {
  _isFull: boolean = true
  _incrementalAnalysis: boolean = false
  _time: number = 50
  _textNumber: number = 10
  _isCodeFormat: boolean = false
  _codeBlockTextColor: number | undefined = undefined
  _codeBlockTypeTextColor: number | undefined = undefined
  _codeBlockTypeTextStr: string = ""
  _codeBlockTypeTextPadding: number = 0
  _codeBlockIconTextHide: boolean = true
  _codeBlockLineNumberHide: boolean = true
  _codeBlockBackgroundColor: number | undefined = undefined
  _codeMultilineMargin: number = 8
  _codeBlockTypeface: string = "HarmonyOS Sans"
  _codeBlockTextSize: number = 13
  _codeBlockLineHeight: number = 22
  _codeBlockRadius: number = 8
  _isCodeFullScreen: boolean = true
  _iconWidthAndHeight: number = 24
  _isDark: boolean = true
  _isMarkdownParserSync: boolean = false
  _typeWriterOpen: boolean = false
  _typeWriterColor: number = 0xFFFF0000
  _isOnCopy: boolean = false
  _blockFirstTopMargin: number = 8
  _blockLastBottomMargin: number = 8
  _blockTopAndBottomMargins: number = 8
  _useTab: boolean = false
  _indentWidth: number = 4
  _pagePath: string = ""

  public set isFull(value: boolean) {
    this._isFull = value
  }

  public set incrementalAnalysis(value: boolean) {
    this._incrementalAnalysis = value
  }

  public set time(value: number) {
    this._time = value
  }

  public set textNumber(value: number) {
    this._textNumber = value
  }

  public set isCodeFormat(value: boolean) {
    this._isCodeFormat = value
  }

  public set codeBlockTextColor(value: number | undefined) {
    this._codeBlockTextColor = value
  }

  public set codeBlockTypeTextColor(value: number | undefined) {
    this._codeBlockTypeTextColor = value
  }

  public set codeBlockTypeTextStr(value: string) {
    this._codeBlockTypeTextStr = value
  }

  public set codeBlockTypeTextPadding(value: number) {
    this._codeBlockTypeTextPadding = value
  }

  public set codeBlockIconTextHide(value: boolean) {
    this._codeBlockIconTextHide = value
  }

  public set codeBlockLineNumberHide(value: boolean) {
    this._codeBlockLineNumberHide = value
  }

  public set codeBlockBackgroundColor(value: number | undefined) {
    this._codeBlockBackgroundColor = value
  }

  public set codeMultilineMargin(value: number) {
    this._codeMultilineMargin = value
  }

  public set codeBlockTypeface(value: string) {
    this._codeBlockTypeface = value
  }

  public set codeBlockTextSize(value: number) {
    this._codeBlockTextSize = value
  }

  public set codeBlockLineHeight(value: number) {
    this._codeBlockLineHeight = value
  }

  public set codeBlockRadius(value: number) {
    this._codeBlockRadius = value
  }

  public set isCodeFullScreen(value: boolean) {
    this._isCodeFullScreen = value
  }

  public set iconWidthAndHeight(value: number) {
    this._iconWidthAndHeight = value
  }

  public set isDark(value: boolean) {
    this._isDark = value
  }

  public set isMarkdownParserSync(value: boolean) {
    this._isMarkdownParserSync = value
  }

  public set typeWriterOpen(value: boolean) {
    this._typeWriterOpen = value
  }

  public set typeWriterColor(value: number) {
    this._typeWriterColor = value
  }

  public set isOnCopy(value: boolean) {
    this._isOnCopy = value
  }

  public set blockFirstTopMargin(value: number) {
    this._blockFirstTopMargin = value
  }

  public set blockLastBottomMargin(value: number) {
    this._blockLastBottomMargin = value
  }

  public set blockTopAndBottomMargins(value: number) {
    this._blockTopAndBottomMargins = value
  }

  public set useTab(value: boolean) {
    this._useTab = value
  }

  public set indentWidth(value: number) {
    this._indentWidth = value
  }

  public set pagePath(value: string) {
    this._pagePath = value
  }

  constructor() {
  }
}
