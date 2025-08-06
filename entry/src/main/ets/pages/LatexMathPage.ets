/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { getFileListStr } from './FileUtils'
import { booleanToString, enumToString, numberToColorString, stringToBoolean } from './BaseUtils'
import { router } from '@kit.ArkUI'
import { LatexMathColorFormat } from '@cangjie-tpc/markdown'

@Entry
@Component
struct LatexMathPage {
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
  rawFilePath: string = "005_数学公式"
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
   * 数学公式文本大小列表
   */
  latexMathTextSizeList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 数学公式文本大小
   */
  @State
  latexMathTextSize: number = 16
  /**
   * 数学公式背景色列表
   */
  latexMathBackGroupColorList: Array<number> = [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 数学公式背景色
   */
  @State
  latexMathBackGroupColor: number = 0xFFFFFFFF
  /**
   * 数学公式文本颜色列表
   */
  latexMathTextColorList: Array<number> = [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 数学公式文本颜色
   */
  @State
  latexMathTextColor: number = 0xFF000000
  /**
   * 块结构的数学公式是否居中列表
   */
  latexMathBlockCenterList: Array<boolean> = [true, false]
  /**
   * 块结构的数学公式是否居中
   */
  @State
  latexMathBlockCenter: boolean = false
  /**
   * 数学公式生成图片格式列表
   */
  latexMathColorFormatList: Array<number> =
    [LatexMathColorFormat.COLOR_FORMAT_BGRA_8888, LatexMathColorFormat.COLOR_FORMAT_RGB_565]
  /**
   * 数学公式生成图片格式
   */
  @State
  latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
  /**
   * 数学公式字体路径列表
   */
  latexMathResStrList: Array<string> = ["/data/storage/el1/bundle/entry/resources/resfile/res"]
  /**
   * 数学公式字体路径
   */
  @State
  latexMathResStr: string = "/data/storage/el1/bundle/entry/resources/resfile/res"
  /**
   * 配置数据内容
   */
  @State
  latexMathData: LatexMathData = new LatexMathData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "数学公式配置页面",
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
                    this.latexMathData.isFull = this.isFull
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`数学公式文本大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.latexMathTextSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.latexMathTextSizeList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.latexMathTextSize = item
                    this.latexMathData.latexMathTextSize = this.latexMathTextSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`数学公式背景色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.latexMathBackGroupColor))
                .fontSize(16)
                .fontColor(this.latexMathBackGroupColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.latexMathBackGroupColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.latexMathBackGroupColor = item
                    this.latexMathData.latexMathBackGroupColor = this.latexMathBackGroupColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`数学公式文本颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.latexMathTextColor))
                .fontSize(16)
                .fontColor(this.latexMathTextColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.latexMathTextColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.latexMathTextColor = item
                    this.latexMathData.latexMathTextColor = this.latexMathTextColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`数学公式生成图片格式 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${enumToString(this.latexMathColorFormat)}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.latexMathColorFormatList, (item: LatexMathColorFormat, index: number) => {
                Button(`${enumToString(item)}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.latexMathColorFormat = item
                    this.latexMathData.latexMathColorFormat = this.latexMathColorFormat
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`块结构的数学公式是否居中 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.latexMathBlockCenter}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.latexMathBlockCenterList, (item: boolean, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.latexMathBlockCenter = item
                    this.latexMathData.latexMathBlockCenter = this.latexMathBlockCenter
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`数学公式字体路径 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.latexMathResStr}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.latexMathResStrList, (item: string, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.latexMathResStr = item
                    this.latexMathData.latexMathResStr = this.latexMathResStr
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
                    this.latexMathData.pagePath = `${this.rawFilePath}/${item}`
                    router.pushUrl({ url: "pages/LatexMathDetailsPage", params: this.latexMathData })
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

export class LatexMathData {
  _isFull: boolean = true
  _latexMathTextSize: number = 16
  _latexMathBackGroupColor: number = 0xFFFFFFFF
  _latexMathTextColor: number = 0xFF000000
  _latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
  _latexMathBlockCenter: boolean = false
  _latexMathResStr: string = "/data/storage/el1/bundle/entry/resources/resfile/res"
  _pagePath: string = ""

  public set isFull(value: boolean) {
    this._isFull = value
  }

  public set latexMathTextSize(value: number) {
    this._latexMathTextSize = value
  }

  public set latexMathBackGroupColor(value: number) {
    this._latexMathBackGroupColor = value
  }

  public set latexMathTextColor(value: number) {
    this._latexMathTextColor = value
  }

  public set latexMathColorFormat(value: LatexMathColorFormat) {
    this._latexMathColorFormat = value
  }

  public set latexMathBlockCenter(value: boolean) {
    this._latexMathBlockCenter = value
  }

  public set latexMathResStr(value: string) {
    this._latexMathResStr = value
  }

  public set pagePath(value: string) {
    this._pagePath = value
  }

  constructor() {
  }
}
