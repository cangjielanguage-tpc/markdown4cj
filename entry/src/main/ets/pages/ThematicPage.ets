/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { booleanToString, numberToColorString, stringToBoolean } from '../utils/BaseUtils'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct ThematicPage {
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
  rawFilePath: string = "003_分割线"
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
   * 分割线高度列表
   */
  thematicBreakHeightList: Array<number> = [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  /**
   * 分割线高度
   */
  @State
  thematicBreakHeight: number = 0.5
  /**
   * 分割线颜色列表
   */
  thematicBreakColorList: Array<number> = [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 分割线颜色
   */
  @State
  thematicBreakColor: number = 0xFF000000
  /**
   * 分割线上部外边距列表
   */
  thematicBreakTopMarginList: Array<number> =
    [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
  /**
   * 分割线上部外边距
   */
  @State
  thematicBreakTopMargin: number = 0
  /**
   * 分割线下部外边距列表
   */
  thematicBreakBottomMarginList: Array<number> =
    [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
  /**
   * 分割线下部外边距
   */
  @State
  thematicBreakBottomMargin: number = 0
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
  blockFirstTopMargin: number = 8.0
  /**
   * markdown第一个模块上边距
   */
  blockFirstTopMarginList: Array<number> = [0, 5, 8, 10, 15, 20, 25, 30, 35, 40]
  /**
   * markdown最后一个模块下边距
   */
  @State
  blockLastBottomMargin: number = 8.0
  /**
   * markdown最后一个模块下边距
   */
  blockLastBottomMarginList: Array<number> = [0, 5, 8, 10, 15, 20, 25, 30, 35, 40]
  /**
   * 模块间上下间距
   */
  @State
  blockTopAndBottomMargins: number = 8.0
  /**
   * 模块间上下间距
   */
  blockTopAndBottomMarginsList: Array<number> = [0, 5, 8, 10, 15, 20, 25, 30, 35, 40]
  /**
   * 配置数据内容
   */
  @State
  thematicData: ThematicData = new ThematicData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "分割线配置页面",
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
                    this.thematicData.isFull = this.isFull
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
                    this.thematicData.incrementalAnalysis = this.incrementalAnalysis
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
                    this.thematicData.time = this.time
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
                    this.thematicData.textNumber = this.textNumber
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`分割线高度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.thematicBreakHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.thematicBreakHeightList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.thematicBreakHeight = item
                    this.thematicData.thematicBreakHeight = this.thematicBreakHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`分割线颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.thematicBreakColor))
                .fontSize(16)
                .fontColor(this.thematicBreakColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.thematicBreakColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.thematicBreakColor = item
                    this.thematicData.thematicBreakColor = this.thematicBreakColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`分割线上部外边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.thematicBreakTopMargin}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.thematicBreakTopMarginList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.thematicBreakTopMargin = item
                    this.thematicData.thematicBreakTopMargin = this.thematicBreakTopMargin
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`分割线下部外边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.thematicBreakBottomMargin}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.thematicBreakBottomMarginList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.thematicBreakBottomMargin = item
                    this.thematicData.thematicBreakBottomMargin = this.thematicBreakBottomMargin
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
                    this.thematicData.isMarkdownParserSync = this.isMarkdownParserSync
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
                    this.thematicData.typeWriterOpen = this.typeWriterOpen
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
                    this.thematicData.typeWriterColor = this.typeWriterColor
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
                    this.thematicData.isOnCopy = this.isOnCopy
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
                    this.thematicData.blockFirstTopMargin = this.blockFirstTopMargin
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
                    this.thematicData.blockLastBottomMargin = this.blockLastBottomMargin
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
                    this.thematicData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
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
                    this.thematicData.pagePath = `${this.rawFilePath}/${item}`
                    router.pushUrl({ url: "pages/ThematicDetailsPage", params: this.thematicData })
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

export class ThematicData {
  _isFull: boolean = true
  _incrementalAnalysis: boolean = false
  _time: number = 50
  _textNumber: number = 10
  _thematicBreakHeight: number = 0.5
  _thematicBreakColor: number = 0xFF000000
  _thematicBreakTopMargin: number = 0
  _thematicBreakBottomMargin: number = 0
  _isMarkdownParserSync: boolean = false
  _typeWriterOpen: boolean = false
  _typeWriterColor: number = 0xFFFF0000
  _isOnCopy: boolean = false
  _blockFirstTopMargin: number = 8.0
  _blockLastBottomMargin: number = 8.0
  _blockTopAndBottomMargins: number = 8.0
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

  public set thematicBreakHeight(value: number) {
    this._thematicBreakHeight = value
  }

  public set thematicBreakColor(value: number) {
    this._thematicBreakColor = value
  }


  public set thematicBreakTopMargin(value: number) {
    this._thematicBreakTopMargin = value
  }

  public set thematicBreakBottomMargin(value: number) {
    this._thematicBreakBottomMargin = value
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
