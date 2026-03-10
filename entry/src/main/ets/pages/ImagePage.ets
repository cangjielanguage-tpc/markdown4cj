/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { booleanToString, numberToColorString, stringToBoolean } from '../utils/BaseUtils'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct ImagePage {
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
  rawFilePath: string = "016_图片"
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
   * 是否触发图片替换事件列表
   */
  callbackList: Array<boolean> = [true, false]
  /**
   * 是否触发图片替换事件
   */
  @State
  callback: boolean = false
  /**
   * 图片默认占位图选项列表
   */
  imageResourceList: Array<Resource | null> = [null, $r('app.media.startIcon')]
  /**
   * 图片默认占位图
   */
  @State
  imageResource: Resource | null = null
  /**
   * 网络图片是否压缩列表
   */
  isAutoResizeList: Array<boolean> = [true, false]
  /**
   * 网络图片是否压缩
   */
  @State
  isAutoResize: boolean = true
  /**
   * 图片上边距列表
   */
  imageMarginTopList: Array<number> = [0, 5, 10, 20, 25, 30, 40, 50, 55, 60, 65, 70, 75, 80, 100]
  /**
   * 图片上边距
   */
  @State
  imageMarginTop: number = 10
  /**
   * 图片下边距列表
   */
  imageMarginBottomList: Array<number> = [0, 5, 10, 20, 25, 30, 40, 50, 55, 60, 65, 70, 75, 80, 100]
  /**
   * 图片下边距
   */
  @State
  imageMarginBottom: number = 10
  /**
   * 图片圆角列表
   */
  imageBorderRadiusList: Array<number> = [0, 5, 10, 20, 25, 30, 40, 50, 55, 60, 65, 70, 75, 80, 100]
  /**
   * 图片圆角
   */
  @State
  imageBorderRadius: number = 0
  /**
   * 图片基于自身宽度缩放百分比列表
   */
  imageMaximumWidthList: Array<number> = [0, 0.2, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8, 1.0]
  /**
   * 图片基于自身宽度缩放百分比
   */
  @State
  imageMaximumWidth: number = 1.0
  /**
   * 图片基于父布局宽度缩放百分比列表
   */
  imageFixedRatioWidthList: Array<number| null> = [null,0, 0.2, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8, 1.0]
  /**
   * 图片基于父布局宽度缩放百分比
   */
  @State
  imageFixedRatioWidth: number| null = null
  /**
   * 图片最大高度列表
   */
  imageMaxHeightList: Array<number | null> = [null, 50.0, 80.0, 100.0, 120.0, 150.0, 180.0, 200.0, 250.0, 300.0, 500.0]
  /**
   * 图片最大高度
   */
  @State
  imageMaxHeight: number | null = null
  /**
   * 图片是否有下载按钮列表
   */
  isImageDownloadList: Array<boolean> = [true, false]
  /**
   * 图片是否有下载按钮
   */
  @State
  isImageDownload: boolean = false
  /**
   * 是否图文混排列表
   */
  isImageMixedLayoutList: Array<boolean> = [true, false]
  /**
   * 是否图文混排
   */
  @State
  isImageMixedLayout: boolean = true
  /**
   * 图片下载按钮图片宽度和高度列表
   */
  imageDownloadImageWidthHeightList: Array<number> = [10, 15, 18, 20, 25, 30, 35, 40]
  /**
   * 图片下载按钮图片宽度和高度
   */
  @State
  imageDownloadImageWidthHeight: number = 18
  /**
   * 图片下载按钮宽度列表
   */
  imageDownloadWidthList: Array<number> = [100, 120, 130, 144, 150, 160, 180, 200]
  /**
   * 图片下载按钮宽度
   */
  @State
  imageDownloadWidth: number = 144
  /**
   * 图片下载按钮高度列表
   */
  imageDownloadHeightList: Array<number> = [25, 30, 35, 40, 44, 50, 60, 70, 80]
  /**
   * 图片下载按钮高度
   */
  @State
  imageDownloadHeight: number = 44
  /**
   * 图片下载按钮圆角列表
   */
  imageDownloadRadiusList: Array<number> = [10, 12, 15, 18, 20, 22, 25, 28, 30,35,40]
  /**
   * 图片下载按钮圆角
   */
  @State
  imageDownloadRadius: number = 22
  /**
   * 图片下载按钮文本内容列表
   */
  imageDownloadTextList: Array<string> = ["下载", "提交", "下载图片"]
  /**
   * 图片下载按钮文本内容
   */
  @State
  imageDownloadText: string = "下载图片"
  /**
   * 图片下载按钮文本大小列表
   */
  imageDownloadTexSizeList: Array<number> = [10, 12, 16, 18, 20, 22, 26, 28, 30,35,40]
  /**
   * 图片下载按钮文本大小
   */
  @State
  imageDownloadTexSize: number = 16
  /**
   * 图片下载按钮文本颜色列表
   */
  imageDownloadTexColorList: Array<number> = [0xE6000000, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 图片下载按钮文本颜色
   */
  @State
  imageDownloadTexColor: number = 0xE6000000
  /**
   * 图片下载按钮背景颜色列表
   */
  imageDownloadBackgroundColorList: Array<number> = [0xFFF5F5F5, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 图片下载按钮背景颜色
   */
  @State
  imageDownloadBackgroundColor: number = 0xFFF5F5F5
  /**
   * 配置数据内容
   */
  @State
  imageDataMD: ImageDataMD = new ImageDataMD()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "图片配置页面",
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
                    this.imageDataMD.isFull = this.isFull
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
                    this.imageDataMD.incrementalAnalysis = this.incrementalAnalysis
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
                    this.imageDataMD.time = this.time
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
                    this.imageDataMD.textNumber = this.textNumber
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`是否触发图片替换事件 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.callback}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.callbackList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.callback = item
                    this.imageDataMD.callback = this.callback
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`是否设置默认占位图 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(this.resToString(this.imageResource))
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.imageResourceList, (item: Resource | null, index: number) => {
                Button(this.resToString(item))
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    if (item === undefined) {
                      this.imageResource = null
                    } else {
                      this.imageResource = item
                    }
                    this.imageDataMD.imageResource = this.imageResource
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`图片上边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.imageMarginTop}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.imageMarginTopList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.imageMarginTop = item
                    this.imageDataMD.imageMarginTop = this.imageMarginTop
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`图片下边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.imageMarginBottom}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.imageMarginBottomList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.imageMarginBottom = item
                    this.imageDataMD.imageMarginBottom = this.imageMarginBottom
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`图片圆角 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.imageBorderRadius}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.imageBorderRadiusList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.imageBorderRadius = item
                    this.imageDataMD.imageBorderRadius = this.imageBorderRadius
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`图片基于自身宽度缩放百分比 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.imageMaximumWidth}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.imageMaximumWidthList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.imageMaximumWidth = item
                    this.imageDataMD.imageMaximumWidth = this.imageMaximumWidth
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`图片基于父布局宽度缩放百分比 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.imageFixedRatioWidth}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.imageFixedRatioWidthList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.imageFixedRatioWidth = item
                    this.imageDataMD.imageFixedRatioWidth = this.imageFixedRatioWidth
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`图片最大高度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.imageMaxHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.imageMaxHeightList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.imageMaxHeight = item
                    this.imageDataMD.imageMaxHeight = this.imageMaxHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`图片是否有下载按钮 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.isImageDownload}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isImageDownloadList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isImageDownload = item
                    this.imageDataMD.isImageDownload = this.isImageDownload
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`是否图文混排 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.isImageMixedLayout}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isImageMixedLayoutList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isImageMixedLayout = item
                    this.imageDataMD.isImageMixedLayout = this.isImageMixedLayout
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`图片下载按钮图片宽度和高度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.imageDownloadImageWidthHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.imageDownloadImageWidthHeightList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.imageDownloadImageWidthHeight = item
                    this.imageDataMD.imageDownloadImageWidthHeight = this.imageDownloadImageWidthHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`图片下载按钮宽度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.imageDownloadWidth}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.imageDownloadWidthList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.imageDownloadWidth = item
                    this.imageDataMD.imageDownloadWidth = this.imageDownloadWidth
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`图片下载按钮高度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.imageDownloadHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.imageDownloadHeightList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.imageDownloadHeight = item
                    this.imageDataMD.imageDownloadHeight = this.imageDownloadHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`图片下载按钮圆角 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.imageDownloadRadius}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.imageDownloadRadiusList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.imageDownloadRadius = item
                    this.imageDataMD.imageDownloadRadius = this.imageDownloadRadius
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`图片下载按钮文本内容 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.imageDownloadText}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.imageDownloadTextList, (item: string, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.imageDownloadText = item
                    this.imageDataMD.imageDownloadText = this.imageDownloadText
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`图片下载按钮文本大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.imageDownloadTexSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.imageDownloadTexSizeList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.imageDownloadTexSize = item
                    this.imageDataMD.imageDownloadTexSize = this.imageDownloadTexSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`图片下载按钮文本颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${numberToColorString(this.imageDownloadTexColor)}`)
                .fontSize(16)
                .fontColor(this.imageDownloadTexColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.imageDownloadTexColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.imageDownloadTexColor = item
                    this.imageDataMD.imageDownloadTexColor = this.imageDownloadTexColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`图片下载按钮背景颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${numberToColorString(this.imageDownloadBackgroundColor)}`)
                .fontSize(16)
                .fontColor(this.imageDownloadBackgroundColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.imageDownloadBackgroundColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.imageDownloadBackgroundColor = item
                    this.imageDataMD.imageDownloadBackgroundColor = this.imageDownloadBackgroundColor
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
                    this.imageDataMD.pagePath = `${this.rawFilePath}/${item}`
                    router.pushUrl({ url: "pages/ImageDetailsPage", params: this.imageDataMD })
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

  resToString(item: Resource | null): string {
    if (item !== null) {
      return "app.media.startIcon"
    } else {
      return "null"
    }
  }
}

export class ImageDataMD {
  _isFull: boolean = true
  _incrementalAnalysis: boolean = false
  _time: number = 50
  _textNumber: number = 10
  _callback: boolean = false
  _imageResource: Resource | null = null
  _imageMarginTop: number = 10
  _imageMarginBottom: number = 10
  _imageBorderRadius: number = 0
  _imageMaximumWidth: number = 1.0
  _imageFixedRatioWidth: number| null = null
  _imageMaxHeight: number | null = null
  _isImageDownload: boolean = false
  _isImageMixedLayout: boolean = true
  _imageDownloadImageWidthHeight: number = 18
  _imageDownloadWidth: number = 144
  _imageDownloadHeight: number = 44
  _imageDownloadRadius: number = 22
  _imageDownloadText: string = "下载图片"
  _imageDownloadTexSize: number = 16
  _imageDownloadTexColor: number = 0xE6000000
  _imageDownloadBackgroundColor: number = 0xFFF5F5F5
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

  public set callback(value: boolean) {
    this._callback = value
  }

  public set imageResource(value: Resource | null) {
    this._imageResource = value
  }

  public set imageMarginTop(value: number) {
    this._imageMarginTop = value
  }

  public set imageMarginBottom(value: number) {
    this._imageMarginBottom = value
  }

  public set imageBorderRadius(value: number) {
    this._imageBorderRadius = value
  }

  public set imageMaximumWidth(value: number) {
    this._imageMaximumWidth = value
  }

  public set imageFixedRatioWidth(value: number) {
    this._imageFixedRatioWidth = value
  }

  public set imageMaxHeight(value: number) {
    this._imageMaxHeight = value
  }

  public set isImageDownload(value: boolean) {
    this._isImageDownload = value
  }

  public set isImageMixedLayout(value: boolean) {
    this._isImageMixedLayout = value
  }

  public set imageDownloadImageWidthHeight(value: number) {
    this._imageDownloadImageWidthHeight = value
  }

  public set imageDownloadWidth(value: number) {
    this._imageDownloadWidth = value
  }

  public set imageDownloadHeight(value: number) {
    this._imageDownloadHeight = value
  }

  public set imageDownloadRadius(value: number) {
    this._imageDownloadRadius = value
  }

  public set imageDownloadText(value: string) {
    this._imageDownloadText = value
  }

  public set imageDownloadTexSize(value: number) {
    this._imageDownloadTexSize = value
  }

  public set imageDownloadTexColor(value: number) {
    this._imageDownloadTexColor = value
  }

  public set imageDownloadBackgroundColor(value: number) {
    this._imageDownloadBackgroundColor = value
  }

  public set pagePath(value: string) {
    this._pagePath = value
  }

  constructor() {
  }
}
