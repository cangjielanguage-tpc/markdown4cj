/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { getFileListStr } from './FileUtils'
import { booleanToString, numberToColorString, stringToBoolean } from './BaseUtils'
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
   * 音频上边距列表
   */
  videoTimeTextMarginRightList: Array<number> = [0, 5, 10, 15, 20, 25, 30, 35, 40]
  /**
   * 音频上边距
   */
  @State
  videoTimeTextMarginRight: number = 10
  /**
   * 音频下边距列表
   */
  videoTimeTextMarginBottomList: Array<number> = [0, 5, 10, 15, 20, 25, 30, 35, 40]
  /**
   * 音频下边距
   */
  @State
  videoTimeTextMarginBottom: number = 10
  /**
   * 音频上边距列表
   */
  videoMarginTopList: Array<number> = [0, 5, 10, 15, 20, 25, 30, 35, 40]
  /**
   * 音频上边距
   */
  @State
  videoMarginTop: number = 10
  /**
   * 音频下边距列表
   */
  videoMarginBottomList: Array<number> = [0, 5, 10, 15, 20, 25, 30, 35, 40]
  /**
   * 音频下边距
   */
  @State
  videoMarginBottom: number = 10
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
  _videoBorderRadius: number = 10
  _videoTimeTextColor: number = 0xFFFFFFFF
  _videoTimeTextSize: number = 14
  _videoTimeTextMarginRight: number = 10
  _videoTimeTextMarginBottom: number = 10
  _videoMarginTop: number = 10
  _videoMarginBottom: number = 10
  _pagePath: string = ""

  public set isFull(value: boolean) {
    this._isFull = value
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

  public set pagePath(value: string) {
    this._pagePath = value
  }

  constructor() {
  }
}
