/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { booleanToString, numberToColorString, stringToBoolean } from '../utils/BaseUtils'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct VideoPage {
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
  rawFilePath: string = "015_视频"
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
   * 视频圆角列表
   */
  videoBorderRadiusList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 视频圆角
   */
  @State
  videoBorderRadius: number = 22
  /**
   * 视频时间文本颜色列表
   */
  videoTimeTextColorList: Array<number> = [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 视频时间文本颜色
   */
  @State
  videoTimeTextColor: number = 0xFFFFFFFF
  /**
   * 视频时间文本大小列表
   */
  videoTimeTextSizeList: Array<number> = [10, 11, 12, 14, 15, 16, 18, 20, 22, 24, 26, 28, 30]
  /**
   * 视频时间文本大小
   */
  @State
  videoTimeTextSize: number = 14
  /**
   * 视频上边距列表
   */
  videoTimeTextMarginRightList: Array<number> = [0, 5, 10, 15, 20, 25, 30, 35, 40]
  /**
   * 视频上边距
   */
  @State
  videoTimeTextMarginRight: number = 10
  /**
   * 视频下边距列表
   */
  videoTimeTextMarginBottomList: Array<number> = [0, 5, 10, 15, 20, 25, 30, 35, 40]
  /**
   * 视频下边距
   */
  @State
  videoTimeTextMarginBottom: number = 10
  /**
   * 视频上边距列表
   */
  videoMarginTopList: Array<number> = [0, 5, 10, 15, 20, 25, 30, 35, 40]
  /**
   * 视频上边距
   */
  @State
  videoMarginTop: number = 10
  /**
   * 视频下边距列表
   */
  videoMarginBottomList: Array<number> = [0, 5, 10, 15, 20, 25, 30, 35, 40]
  /**
   * 视频下边距
   */
  @State
  videoMarginBottom: number = 10
  /**
   * 视频发布/下载按钮布局是否显示列表
   */
  isVideoBottomLayoutList: Array<boolean> = [true, false]
  /**
   * 视频发布/下载按钮布局是否显示
   */
  @State
  isVideoBottomLayout: boolean = false
  /**
   * 视频发布按钮图片宽度和高度列表
   */
  videoReleaseImageWidthHeightList: Array<number> = [10, 15, 18, 20, 25, 30, 35, 40]
  /**
   * 视频发布按钮图片宽度和高度
   */
  @State
  videoReleaseImageWidthHeight: number = 18
  /**
   * 视频发布按钮宽度列表
   */
  videoReleaseWidthList: Array<number> = [100, 120, 130, 144, 150, 160, 180, 200]
  /**
   * 视频发布按钮宽度
   */
  @State
  videoReleaseWidth: number = 144
  /**
   * 视频发布按钮高度列表
   */
  videoReleaseHeightList: Array<number> = [25, 30, 35, 40, 44, 50, 60, 70, 80]
  /**
   * 视频发布按钮高度
   */
  @State
  videoReleaseHeight: number = 44
  /**
   * 视频发布按钮圆角列表
   */
  videoReleaseRadiusList: Array<number> = [10, 12, 15, 18, 20, 22, 25, 28, 30,35,40]
  /**
   * 视频发布按钮圆角
   */
  @State
  videoReleaseRadius: number = 22
  /**
   * 视频发布按钮文本内容列表
   */
  videoReleaseTextList: Array<string> = ["发布", "提交", "发布视频"]
  /**
   * 视频发布按钮文本内容
   */
  @State
  videoReleaseText: string = "发布视频"
  /**
   * 视频发布按钮文本大小列表
   */
  videoReleaseTexSizeList: Array<number> = [10, 12, 16, 18, 20, 22, 26, 28, 30,35,40]
  /**
   * 视频发布按钮文本大小
   */
  @State
  videoReleaseTexSize: number = 16
  /**
   * 视频发布按钮文本颜色列表
   */
  videoReleaseTexColorList: Array<number> = [0xE6000000, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 视频发布按钮文本颜色
   */
  @State
  videoReleaseTexColor: number = 0xE6000000
  /**
   * 视频发布按钮背景颜色列表
   */
  videoReleaseBackgroundColorList: Array<number> = [0xFFF5F5F5, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 视频发布按钮背景颜色
   */
  @State
  videoReleaseBackgroundColor: number = 0xFFF5F5F5
  /**
   * 视频下载按钮图片宽度和高度列表
   */
  videoDownloadImageWidthHeightList: Array<number> = [10, 15, 18, 20, 25, 30, 35, 40]
  /**
   * 视频下载按钮图片宽度和高度
   */
  @State
  videoDownloadImageWidthHeight: number = 18
  /**
   * 视频下载按钮宽度列表
   */
  videoDownloadWidthList: Array<number> = [100, 120, 130, 144, 150, 160, 180, 200]
  /**
   * 视频下载按钮宽度
   */
  @State
  videoDownloadWidth: number = 144
  /**
   * 视频下载按钮高度列表
   */
  videoDownloadHeightList: Array<number> = [25, 30, 35, 40, 44, 50, 60, 70, 80]
  /**
   * 视频下载按钮高度
   */
  @State
  videoDownloadHeight: number = 44
  /**
   * 视频下载按钮圆角列表
   */
  videoDownloadRadiusList: Array<number> = [10, 12, 15, 18, 20, 22, 25, 28, 30,35,40]
  /**
   * 视频下载按钮圆角
   */
  @State
  videoDownloadRadius: number = 22
  /**
   * 视频下载按钮文本内容列表
   */
  videoDownloadTextList: Array<string> = ["下载", "提交", "下载视频"]
  /**
   * 视频下载按钮文本内容
   */
  @State
  videoDownloadText: string = "下载视频"
  /**
   * 视频下载按钮文本大小列表
   */
  videoDownloadTexSizeList: Array<number> = [10, 12, 16, 18, 20, 22, 26, 28, 30,35,40]
  /**
   * 视频下载按钮文本大小
   */
  @State
  videoDownloadTexSize: number = 16
  /**
   * 视频下载按钮文本颜色列表
   */
  videoDownloadTexColorList: Array<number> = [0xE6000000, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 视频下载按钮文本颜色
   */
  @State
  videoDownloadTexColor: number = 0xE6000000
  /**
   * 视频下载按钮背景颜色列表
   */
  videoDownloadBackgroundColorList: Array<number> = [0xFFF5F5F5, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 视频下载按钮背景颜色
   */
  @State
  videoDownloadBackgroundColor: number = 0xFFF5F5F5
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
   * 配置数据内容
   */
  @State
  videoData: VideoData = new VideoData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "视频配置页面",
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
                    this.videoData.isFull = this.isFull
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
                    this.videoData.incrementalAnalysis = this.incrementalAnalysis
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
                    this.videoData.time = this.time
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
                    this.videoData.textNumber = this.textNumber
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频圆角 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.videoBorderRadius}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoBorderRadiusList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoBorderRadius = item
                    this.videoData.videoBorderRadius = this.videoBorderRadius
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频时间文本颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.videoTimeTextColor))
                .fontSize(16)
                .fontColor(this.videoTimeTextColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoTimeTextColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoTimeTextColor = item
                    this.videoData.videoTimeTextColor = this.videoTimeTextColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频时间文本大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.videoTimeTextSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoTimeTextSizeList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoTimeTextSize = item
                    this.videoData.videoTimeTextSize = this.videoTimeTextSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频时间文本居右边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.videoTimeTextMarginRight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoTimeTextMarginRightList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoTimeTextMarginRight = item
                    this.videoData.videoTimeTextMarginRight = this.videoTimeTextMarginRight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频时间文本居底边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.videoTimeTextMarginBottom}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoTimeTextMarginBottomList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoTimeTextMarginBottom = item
                    this.videoData.videoTimeTextMarginBottom = this.videoTimeTextMarginBottom
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频上边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.videoMarginTop}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoMarginTopList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoMarginTop = item
                    this.videoData.videoMarginTop = this.videoMarginTop
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频下边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.videoMarginBottom}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoMarginBottomList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoMarginBottom = item
                    this.videoData.videoMarginBottom = this.videoMarginBottom
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频发布/下载按钮布局是否显示 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.isVideoBottomLayout}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isVideoBottomLayoutList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isVideoBottomLayout = item
                    this.videoData.isVideoBottomLayout = this.isVideoBottomLayout
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频发布按钮图片宽度和高度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.videoReleaseImageWidthHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoReleaseImageWidthHeightList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoReleaseImageWidthHeight = item
                    this.videoData.videoReleaseImageWidthHeight = this.videoReleaseImageWidthHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频发布按钮宽度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.videoReleaseWidth}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoReleaseWidthList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoReleaseWidth = item
                    this.videoData.videoReleaseWidth = this.videoReleaseWidth
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频发布按钮高度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.videoReleaseHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoReleaseHeightList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoReleaseHeight = item
                    this.videoData.videoReleaseHeight = this.videoReleaseHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频发布按钮圆角 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.videoReleaseRadius}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoReleaseRadiusList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoReleaseRadius = item
                    this.videoData.videoReleaseRadius = this.videoReleaseRadius
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频发布按钮文本内容 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.videoReleaseText}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoReleaseTextList, (item: string, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoReleaseText = item
                    this.videoData.videoReleaseText = this.videoReleaseText
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频发布按钮文本大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.videoReleaseTexSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoReleaseTexSizeList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoReleaseTexSize = item
                    this.videoData.videoReleaseTexSize = this.videoReleaseTexSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频发布按钮文本颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${numberToColorString(this.videoReleaseTexColor)}`)
                .fontSize(16)
                .fontColor(this.videoReleaseTexColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoReleaseTexColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoReleaseTexColor = item
                    this.videoData.videoReleaseTexColor = this.videoReleaseTexColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频发布按钮背景颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${numberToColorString(this.videoReleaseBackgroundColor)}`)
                .fontSize(16)
                .fontColor(this.videoReleaseBackgroundColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoReleaseBackgroundColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoReleaseBackgroundColor = item
                    this.videoData.videoReleaseBackgroundColor = this.videoReleaseBackgroundColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频下载按钮图片宽度和高度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.videoDownloadImageWidthHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoDownloadImageWidthHeightList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoDownloadImageWidthHeight = item
                    this.videoData.videoDownloadImageWidthHeight = this.videoDownloadImageWidthHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频下载按钮宽度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.videoDownloadWidth}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoDownloadWidthList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoDownloadWidth = item
                    this.videoData.videoDownloadWidth = this.videoDownloadWidth
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频下载按钮高度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.videoDownloadHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoDownloadHeightList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoDownloadHeight = item
                    this.videoData.videoDownloadHeight = this.videoDownloadHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频下载按钮圆角 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.videoDownloadRadius}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoDownloadRadiusList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoDownloadRadius = item
                    this.videoData.videoDownloadRadius = this.videoDownloadRadius
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频下载按钮文本内容 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.videoDownloadText}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoDownloadTextList, (item: string, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoDownloadText = item
                    this.videoData.videoDownloadText = this.videoDownloadText
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频下载按钮文本大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.videoDownloadTexSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoDownloadTexSizeList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoDownloadTexSize = item
                    this.videoData.videoDownloadTexSize = this.videoDownloadTexSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频下载按钮文本颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${numberToColorString(this.videoDownloadTexColor)}`)
                .fontSize(16)
                .fontColor(this.videoDownloadTexColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoDownloadTexColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoDownloadTexColor = item
                    this.videoData.videoDownloadTexColor = this.videoDownloadTexColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`视频下载按钮背景颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${numberToColorString(this.videoDownloadBackgroundColor)}`)
                .fontSize(16)
                .fontColor(this.videoDownloadBackgroundColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.videoDownloadBackgroundColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.videoDownloadBackgroundColor = item
                    this.videoData.videoDownloadBackgroundColor = this.videoDownloadBackgroundColor
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
                    this.videoData.isMarkdownParserSync = this.isMarkdownParserSync
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
                    this.videoData.typeWriterOpen = this.typeWriterOpen
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
                    this.videoData.typeWriterColor = this.typeWriterColor
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
                    this.videoData.isOnCopy = this.isOnCopy
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
                    this.videoData.blockFirstTopMargin = this.blockFirstTopMargin
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
                    this.videoData.blockLastBottomMargin = this.blockLastBottomMargin
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
                    this.videoData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
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
                    this.videoData.pagePath = `${this.rawFilePath}/${item}`
                    router.pushUrl({ url: "pages/VideoDetailsPage", params: this.videoData })
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

export class VideoData {
  _isFull: boolean = true
  _incrementalAnalysis: boolean = false
  _time: number = 50
  _textNumber: number = 10
  _videoBorderRadius: number = 10
  _videoTimeTextColor: number = 0xFFFFFFFF
  _videoTimeTextSize: number = 14
  _videoTimeTextMarginRight: number = 10
  _videoTimeTextMarginBottom: number = 10
  _videoMarginTop: number = 10
  _videoMarginBottom: number = 10
  _isVideoBottomLayout: boolean = false
  _videoReleaseImageWidthHeight: number = 18
  _videoReleaseWidth: number = 144
  _videoReleaseHeight: number = 44
  _videoReleaseRadius: number = 22
  _videoReleaseText: string = "发布视频"
  _videoReleaseTexSize: number = 16
  _videoReleaseTexColor: number = 0xE6000000
  _videoReleaseBackgroundColor: number = 0xFFF5F5F5
  _videoDownloadImageWidthHeight: number = 18
  _videoDownloadWidth: number = 144
  _videoDownloadHeight: number = 44
  _videoDownloadRadius: number = 22
  _videoDownloadText: string = "下载视频"
  _videoDownloadTexSize: number = 16
  _videoDownloadTexColor: number = 0xE6000000
  _videoDownloadBackgroundColor: number = 0xFFF5F5F5
  _isMarkdownParserSync: boolean = false
  _typeWriterOpen: boolean = false
  _typeWriterColor: number = 0xFFFF0000
  _isOnCopy: boolean = false
  _blockFirstTopMargin: number = 8
  _blockLastBottomMargin: number = 8
  _blockTopAndBottomMargins: number = 8
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

  public set videoBorderRadius(value: number) {
    this._videoBorderRadius = value
  }

  public set videoTimeTextColor(value: number) {
    this._videoTimeTextColor = value
  }

  public set videoTimeTextSize(value: number) {
    this._videoTimeTextSize = value
  }

  public set videoTimeTextMarginRight(value: number) {
    this._videoTimeTextMarginRight = value
  }

  public set videoTimeTextMarginBottom(value: number) {
    this._videoTimeTextMarginBottom = value
  }

  public set videoMarginTop(value: number) {
    this._videoMarginTop = value
  }

  public set videoMarginBottom(value: number) {
    this._videoMarginBottom = value
  }

  public set isVideoBottomLayout(value: boolean) {
    this._isVideoBottomLayout = value
  }

  public set videoReleaseImageWidthHeight(value: number) {
    this._videoReleaseImageWidthHeight = value
  }

  public set videoReleaseWidth(value: number) {
    this._videoReleaseWidth = value
  }

  public set videoReleaseHeight(value: number) {
    this._videoReleaseHeight = value
  }

  public set videoReleaseRadius(value: number) {
    this._videoReleaseRadius = value
  }

  public set videoReleaseText(value: string) {
    this._videoReleaseText = value
  }

  public set videoReleaseTexSize(value: number) {
    this._videoReleaseTexSize = value
  }

  public set videoReleaseTexColor(value: number) {
    this._videoReleaseTexColor = value
  }

  public set videoReleaseBackgroundColor(value: number) {
    this._videoReleaseBackgroundColor = value
  }

  public set videoDownloadImageWidthHeight(value: number) {
    this._videoDownloadImageWidthHeight = value
  }

  public set videoDownloadWidth(value: number) {
    this._videoDownloadWidth = value
  }

  public set videoDownloadHeight(value: number) {
    this._videoDownloadHeight = value
  }

  public set videoDownloadRadius(value: number) {
    this._videoDownloadRadius = value
  }

  public set videoDownloadText(value: string) {
    this._videoDownloadText = value
  }

  public set videoDownloadTexSize(value: number) {
    this._videoDownloadTexSize = value
  }

  public set videoDownloadTexColor(value: number) {
    this._videoDownloadTexColor = value
  }

  public set videoDownloadBackgroundColor(value: number) {
    this._videoDownloadBackgroundColor = value
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

  public set pagePath(value: string) {
    this._pagePath = value
  }

  constructor() {
  }
}
