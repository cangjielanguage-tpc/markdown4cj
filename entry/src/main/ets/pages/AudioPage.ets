/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { booleanToString, numberToColorString, stringToBoolean } from '../utils/BaseUtils'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct AudioPage {
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
  rawFilePath: string = "014_音频"
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
   * 音频阴影颜色值列表
   */
  audioShadowColorList: Array<number> =
    [0x1A000000, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 音频阴影颜色值
   */
  @State
  audioShadowColor: number = 0x1A000000
  /**
   * 音频边框颜色列表
   */
  audioBorderColorList: Array<number> =
    [0x33000000, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 音频边框颜色
   */
  @State
  audioBorderColor: number = 0x33000000
  /**
   * 音频边框粗细列表
   */
  audioBorderWidthList: Array<number> = [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  /**
   * 音频边框粗细
   */
  @State
  audioBorderWidth: number = 0.5
  /**
   * 音频边框圆角列表
   */
  audioBorderRadiusList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 音频边框圆角
   */
  @State
  audioBorderRadius: number = 12
  /**
   * 音频按钮背景颜色列表
   */
  audioButtonBackgroundColorList: Array<number> =
    [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 音频按钮背景颜色
   */
  @State
  audioButtonBackgroundColor: number = 0xFF000000
  /**
   * 音频按钮文字颜色列表
   */
  audioButtonTextColorList: Array<number> = [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 音频按钮文字颜色
   */
  @State
  audioButtonTextColor: number = 0xFFFFFFFF
  /**
   * 音频按钮文字大小列表
   */
  audioButtonTextSizeList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 音频按钮文字大小
   */
  @State
  audioButtonTextSize: number = 14
  /**
   * 音频按钮文字内容列表
   */
  audioButtonTextList: Array<string> = [`立即播放`, `超长长长长长长长的按钮`]
  /**
   * 音频按钮文字内容
   */
  @State
  audioButtonText: string = `立即播放`
  /**
   * 音频按钮圆角列表
   */
  audioButtonBorderRadiusList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 音频按钮圆角
   */
  @State
  audioButtonBorderRadius: number = 16
  /**
   * 音频标题文字大小列表
   */
  audioTitleTextSizeList: Array<number> = [12, 14, 15, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 音频标题文字大小
   */
  @State
  audioTitleTextSize: number = 15
  /**
   * 音频标题文字颜色列表
   */
  audioTitleTextColorList: Array<number> = [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 音频标题文字颜色
   */
  @State
  audioTitleTextColor: number = 0xFF000000
  /**
   * 音频标题文字行高列表
   */
  audioTitleTextLineHeightList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 音频标题文字行高
   */
  @State
  audioTitleTextLineHeight: number = 20
  /**
   * 音频类型文字大小列表
   */
  audioTypeTextSizeList: Array<number> = [10, 11, 12, 14, 15, 16, 18, 20, 22, 24, 26, 28, 30]
  /**
   * 音频类型文字大小
   */
  @State
  audioTypeTextSize: number = 11
  /**
   * 音频类型文字颜色列表
   */
  audioTypeTextColorList: Array<number> =
    [0x80000000, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 音频类型文字颜色
   */
  @State
  audioTypeTextColor: number = 0x80000000
  /**
   * 音频类型文字行高列表
   */
  audioTypeTextLineHeightList: Array<number> = [10, 11, 12, 14, 15, 16, 18, 20, 22, 24, 26, 28, 30]
  /**
   * 音频类型文字行高
   */
  @State
  audioTypeTextLineHeight: number = 15
  /**
   * 音频上边距列表
   */
  audioMarginTopList: Array<number> = [0, 5, 10, 15, 20, 25, 30, 35, 40]
  /**
   * 音频上边距
   */
  @State
  audioMarginTop: number = 10
  /**
   * 音频下边距列表
   */
  audioMarginBottomList: Array<number> = [0, 5, 10, 15, 20, 25, 30, 35, 40]
  /**
   * 音频下边距
   */
  @State
  audioMarginBottom: number = 10
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
  audioData: AudioDataMD = new AudioDataMD()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "音频配置页面",
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
                    this.audioData.isFull = this.isFull
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
                    this.audioData.isMarkdownParserSync = this.isMarkdownParserSync
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
                    this.audioData.isOnCopy = this.isOnCopy
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
                    this.audioData.blockFirstTopMargin = this.blockFirstTopMargin
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
                    this.audioData.blockLastBottomMargin = this.blockLastBottomMargin
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
                    this.audioData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`音频阴影颜色值 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.audioShadowColor))
                .fontSize(16)
                .fontColor(this.audioShadowColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.audioShadowColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.audioShadowColor = item
                    this.audioData.audioShadowColor = this.audioShadowColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`音频边框颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.audioBorderColor))
                .fontSize(16)
                .fontColor(this.audioBorderColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.audioBorderColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.audioBorderColor = item
                    this.audioData.audioBorderColor = this.audioBorderColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`音频边框粗细 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.audioBorderWidth}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.audioBorderWidthList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.audioBorderWidth = item
                    this.audioData.audioBorderWidth = this.audioBorderWidth
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`音频边框圆角 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.audioBorderRadius}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.audioBorderRadiusList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.audioBorderRadius = item
                    this.audioData.audioBorderRadius = this.audioBorderRadius
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`音频按钮背景颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.audioButtonBackgroundColor))
                .fontSize(16)
                .fontColor(this.audioButtonBackgroundColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.audioButtonBackgroundColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.audioButtonBackgroundColor = item
                    this.audioData.audioButtonBackgroundColor = this.audioButtonBackgroundColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`音频按钮文字颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.audioButtonTextColor))
                .fontSize(16)
                .fontColor(this.audioButtonTextColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.audioButtonTextColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.audioButtonTextColor = item
                    this.audioData.audioButtonTextColor = this.audioButtonTextColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`音频按钮文字大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.audioButtonTextSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.audioButtonTextSizeList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.audioButtonTextSize = item
                    this.audioData.audioButtonTextSize = this.audioButtonTextSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`音频按钮文字内容 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.audioButtonText}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.audioButtonTextList, (item: string, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.audioButtonText = item
                    this.audioData.audioButtonText = this.audioButtonText
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`音频按钮圆角 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.audioButtonBorderRadius}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.audioButtonBorderRadiusList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.audioButtonBorderRadius = item
                    this.audioData.audioButtonBorderRadius = this.audioButtonBorderRadius
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`音频标题文字大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.audioTitleTextSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.audioTitleTextSizeList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.audioTitleTextSize = item
                    this.audioData.audioTitleTextSize = this.audioTitleTextSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`音频标题文字颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.audioTitleTextColor))
                .fontSize(16)
                .fontColor(this.audioTitleTextColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.audioTitleTextColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .width(150)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.audioTitleTextColor = item
                    this.audioData.audioTitleTextColor = this.audioTitleTextColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`音频标题文字行高 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.audioTitleTextLineHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.audioTitleTextLineHeightList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)

                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.audioTitleTextLineHeight = item
                    this.audioData.audioTitleTextLineHeight = this.audioTitleTextLineHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`音频类型文字大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.audioTypeTextSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.audioTypeTextSizeList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)

                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.audioTypeTextSize = item
                    this.audioData.audioTypeTextSize = this.audioTypeTextSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`音频类型文字颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.audioTypeTextColor))
                .fontSize(16)
                .fontColor(this.audioTypeTextColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.audioTypeTextColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .width(150)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.audioTypeTextColor = item
                    this.audioData.audioTypeTextColor = this.audioTypeTextColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`音频类型文字行高 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.audioTypeTextLineHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.audioTypeTextLineHeightList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)

                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.audioTypeTextLineHeight = item
                    this.audioData.audioTypeTextLineHeight = this.audioTypeTextLineHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`音频上边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.audioMarginTop}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.audioMarginTopList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)

                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.audioMarginTop = item
                    this.audioData.audioMarginTop = this.audioMarginTop
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`音频下边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.audioMarginBottom}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.audioMarginBottomList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)

                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.audioMarginBottom = item
                    this.audioData.audioMarginBottom = this.audioMarginBottom
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
                    this.audioData.pagePath = `${this.rawFilePath}/${item}`
                    router.pushUrl({ url: "pages/AudioDetailsPage", params: this.audioData })
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

export class AudioDataMD {
  _isFull: boolean = true
  _audioShadowColor: number = 0x1A000000
  _audioBorderColor: number = 0x33000000
  _audioBorderWidth: number = 0.5
  _audioBorderRadius: number = 12
  _audioButtonBackgroundColor: number = 0xFF000000
  _audioButtonTextColor: number = 0xFFFFFFFF
  _audioButtonTextSize: number = 14.0
  _audioButtonText: string = "立即播放"
  _audioButtonBorderRadius: number = 16.0
  _audioTitleTextSize: number = 15.0
  _audioTitleTextColor: number = 0xFF000000
  _audioTitleTextLineHeight: number = 20.0
  _audioTypeTextSize: number = 11.0
  _audioTypeTextColor: number = 0x80000000
  _audioTypeTextLineHeight: number = 15.0
  _audioMarginTop: number = 10.0
  _audioMarginBottom: number = 10.0
  _isMarkdownParserSync: boolean = false
  _isOnCopy: boolean = false
  _blockFirstTopMargin: number = 8
  _blockLastBottomMargin: number = 8
  _blockTopAndBottomMargins: number = 8
  _pagePath: string = ""

  public set audioShadowColor(value: number) {
    this._audioShadowColor = value
  }

  public set audioBorderColor(value: number) {
    this._audioBorderColor = value
  }


  public set audioBorderWidth(value: number) {
    this._audioBorderWidth = value
  }

  public set audioBorderRadius(value: number) {
    this._audioBorderRadius = value
  }


  public set audioButtonBackgroundColor(value: number) {
    this._audioButtonBackgroundColor = value
  }


  public set audioButtonTextColor(value: number) {
    this._audioButtonTextColor = value
  }

  public set audioButtonTextSize(value: number) {
    this._audioButtonTextSize = value
  }


  public set audioButtonText(value: string) {
    this._audioButtonText = value
  }

  public set audioButtonBorderRadius(value: number) {
    this._audioButtonBorderRadius = value
  }


  public set audioTitleTextSize(value: number) {
    this._audioTitleTextSize = value
  }


  public set audioTitleTextColor(value: number) {
    this._audioTitleTextColor = value
  }


  public set audioTitleTextLineHeight(value: number) {
    this._audioTitleTextLineHeight = value
  }

  public set audioTypeTextSize(value: number) {
    this._audioTypeTextSize = value
  }

  public set audioTypeTextColor(value: number) {
    this._audioTypeTextColor = value
  }


  public set audioTypeTextLineHeight(value: number) {
    this._audioTypeTextLineHeight = value
  }

  public set audioMarginTop(value: number) {
    this._audioMarginTop = value
  }


  public set audioMarginBottom(value: number) {
    this._audioMarginBottom = value
  }

  public set isFull(value: boolean) {
    this._isFull = value
  }

  public set isMarkdownParserSync(value: boolean) {
    this._isMarkdownParserSync = value
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
