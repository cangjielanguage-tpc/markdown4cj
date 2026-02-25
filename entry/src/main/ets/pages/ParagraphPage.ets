/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { getFileListStr } from './FileUtils'
import { booleanToString, numberToColorString, stringToBoolean } from './BaseUtils'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct ParagraphPage {
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
  rawFilePath: string = "002_段落"
  /**
   * rawfile段落文件夹列表
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
   * 段落文本大小列表
   */
  paragraphTextSizeList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 段落文本大小
   */
  @State
  paragraphTextSize: number = 14
  /**
   * 段落文本颜色列表
   */
  paragraphTextColorList: Array<number> = [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 段落文本颜色
   */
  @State
  paragraphTextColor: number = 0xFF000000
  /**
   * 段落文本字间距列表
   */
  paragraphTextWordSpaceList: Array<number> = [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  /**
   * 段落文本字间距
   */
  @State
  paragraphTextWordSpace: number = 0
  /**
   * 段落文本行高列表
   */
  paragraphTextLineHeightList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 段落文本行高
   */
  @State
  paragraphTextLineHeight: number = 22
  /**
   * 段落文本字体列表
   */
  paragraphTypefaceList: Array<string> = ["HarmonyOS Sans", "Hei"]
  /**
   * 段落文本字体
   */
  @State
  paragraphTypeface: string = "HarmonyOS Sans"
  /**
   * 段落模块上间距列表
   */
  paragraphTopMarginsList: Array<number> = [0, 5, 8, 10, 15, 20, 25, 30, 35, 40]
  /**
   * 段落模块上间距
   */
  @State
  paragraphTopMargins: number = 8
  /**
   * 段落模块下间距列表
   */
  paragraphBottomMarginsList: Array<number> = [0, 5, 8, 10, 15, 20, 25, 30, 35, 40]
  /**
   * 段落模块下间距
   */
  @State
  paragraphBottomMargins: number = 8
  /**
   * 配置数据内容
   */
  @State
  paragraphData: ParagraphData = new ParagraphData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "段落配置页面",
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
                    this.paragraphData.isFull = this.isFull
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
                    this.paragraphData.incrementalAnalysis = this.incrementalAnalysis
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
                    this.paragraphData.time = this.time
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
                    this.paragraphData.textNumber = this.textNumber
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`段落文本大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.paragraphTextSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.paragraphTextSizeList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.paragraphTextSize = item
                    this.paragraphData.paragraphTextSize = this.paragraphTextSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`段落文本颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.paragraphTextColor))
                .fontSize(16)
                .fontColor(this.paragraphTextColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.paragraphTextColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.paragraphTextColor = item
                    this.paragraphData.paragraphTextColor = this.paragraphTextColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`段落文本字间距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.paragraphTextWordSpace}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.paragraphTextWordSpaceList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.paragraphTextWordSpace = item
                    this.paragraphData.paragraphTextWordSpace = this.paragraphTextWordSpace
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`段落文本行高 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.paragraphTextLineHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.paragraphTextLineHeightList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.paragraphTextLineHeight = item
                    this.paragraphData.paragraphTextLineHeight = this.paragraphTextLineHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`段落文本字体 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.paragraphTypeface}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.paragraphTypefaceList, (item: string, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.paragraphTypeface = item
                    this.paragraphData.paragraphTypeface = this.paragraphTypeface
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`段落模块上间距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.paragraphTopMargins}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.paragraphTopMarginsList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.paragraphTopMargins = item
                    this.paragraphData.paragraphTopMargins = this.paragraphTopMargins
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`段落模块下间距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.paragraphBottomMargins}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.paragraphBottomMarginsList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.paragraphBottomMargins = item
                    this.paragraphData.paragraphBottomMargins = this.paragraphBottomMargins
                  })
              })
            }
          }

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
                    this.paragraphData.pagePath = `${this.rawFilePath}/${item}`
                    router.pushUrl({ url: "pages/ParagraphDetailsPage", params: this.paragraphData })
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

export class ParagraphData {
  _isFull: boolean = true
  _incrementalAnalysis: boolean = false
  _time: number = 50
  _textNumber: number = 10
  _paragraphTextSize: number = 14
  _paragraphTextColor: number = 0xFF000000
  _paragraphTextWordSpace: number = 0
  _paragraphTextLineHeight: number = 22
  _paragraphTypeface: string = "HarmonyOS Sans"
  _paragraphTopMargins: number = 8
  _paragraphBottomMargins: number = 8
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

  public set paragraphTextSize(value: number) {
    this._paragraphTextSize = value
  }

  public set paragraphTextColor(value: number) {
    this._paragraphTextColor = value
  }


  public set paragraphTextWordSpace(value: number) {
    this._paragraphTextWordSpace = value
  }

  public set paragraphTextLineHeight(value: number) {
    this._paragraphTextLineHeight = value
  }

  public set paragraphTypeface(value: string) {
    this._paragraphTypeface = value
  }

  public set paragraphTopMargins(value: number) {
    this._paragraphTopMargins = value
  }

  public set paragraphBottomMargins(value: number) {
    this._paragraphBottomMargins = value
  }

  public set pagePath(value: string) {
    this._pagePath = value
  }

  constructor() {
  }
}
