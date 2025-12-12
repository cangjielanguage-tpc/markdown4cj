/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { getFileListStr } from './FileUtils'
import { booleanToString, stringToBoolean } from './BaseUtils'
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
  _pagePath: string = ""
  _imageResource: Resource | null = null
  _imageMarginTop: number = 10
  _imageMarginBottom: number = 10
  _imageBorderRadius: number = 0
  _imageMaximumWidth: number = 1.0
  _imageFixedRatioWidth: number| null = null

  public set isFull(value: boolean) {
    this._isFull = value
  }

  public set pagePath(value: string) {
    this._pagePath = value
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

  constructor() {
  }
}
