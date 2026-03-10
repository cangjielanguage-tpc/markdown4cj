/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { booleanToString, numberToColorString, stringToBoolean } from '../utils/BaseUtils'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct SupPage {
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
  rawFilePath: string = "027_上标"
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
   * 上标字体颜色列表
   */
  supTextColorList: Array<number> = [0xFF191919, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 上标字体颜色
   */
  @State
  supTextColor: number = 0xFF191919
  /**
   * 上标字体大小列表
   */
  supTextSizeList: Array<number> = [4, 6, 8, 10, 12, 14, 16, 18, 20, 22]
  /**
   * 上标字体大小
   */
  @State
  supTextSize: number = 8
  /**
   * 上标偏移距离列表
   */
  supOffsetDistList: Array<number> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
  /**
   * 上标偏移距离
   */
  @State
  supOffsetDist: number = 6
  /**
   * 配置数据内容
   */
  @State
  supData: SupData = new SupData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "上标配置页面",
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
                    this.supData.isFull = this.isFull
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`上标字体颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.supTextColor))
                .fontSize(16)
                .fontColor(this.supTextColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.supTextColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.supTextColor = item
                    this.supData.supTextColor = this.supTextColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`上标字体大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.supTextSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.supTextSizeList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.supTextSize = item
                    this.supData.supTextSize = this.supTextSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`上标偏移距离 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.supOffsetDist}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.supOffsetDistList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.supOffsetDist = item
                    this.supData.supOffsetDist = this.supOffsetDist
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
                    this.supData.pagePath = `${this.rawFilePath}/${item}`
                    router.pushUrl({ url: "pages/SupDetailsPage", params: this.supData })
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

export class SupData {
  _isFull: boolean = true
  _supTextColor: number = 0xFF191919
  _supTextSize: number = 8
  _supOffsetDist: number = 6
  _pagePath: string = ""

  public set isFull(value: boolean) {
    this._isFull = value
  }

  public set supTextColor(value: number) {
    this._supTextColor = value
  }

  public set supTextSize(value: number) {
    this._supTextSize = value
  }

  public set supOffsetDist(value: number) {
    this._supOffsetDist = value
  }

  public set pagePath(value: string) {
    this._pagePath = value
  }

  constructor() {
  }
}