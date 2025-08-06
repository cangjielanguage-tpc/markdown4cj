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
   * 标题文本字间距列表
   */
  paragraphTextWordSpaceList: Array<number> = [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  /**
   * 标题文本字间距
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
              Text(`标题文本字体 - `)
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
                    this.paragraphData.pagePath = `${this.rawFilePath}/${item}`
                    router.pushUrl({ url: "pages/ParagraphDetailsPage", params: this.paragraphData })
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

export class ParagraphData {
  _isFull: boolean = true
  _paragraphTextSize: number = 14
  _paragraphTextColor: number = 0xFF000000
  _paragraphTextWordSpace: number = 0
  _paragraphTextLineHeight: number = 22
  _paragraphTypeface: string = "HarmonyOS Sans"
  _pagePath: string = ""

  public set isFull(value: boolean) {
    this._isFull = value
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

  public set pagePath(value: string) {
    this._pagePath = value
  }

  constructor() {
  }
}
