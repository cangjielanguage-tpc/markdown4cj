/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { getFileListStr } from './FileUtils'
import { booleanToString, numberToColorString, stringToBoolean } from './BaseUtils'
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
  _thematicBreakHeight: number = 0.5
  _thematicBreakColor: number = 0xFF000000
  _thematicBreakTopMargin: number = 0
  _thematicBreakBottomMargin: number = 0
  _pagePath: string = ""

  public set isFull(value: boolean) {
    this._isFull = value
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

  public set pagePath(value: string) {
    this._pagePath = value
  }

  constructor() {
  }
}
