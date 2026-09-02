import { itemListComponent, titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct AIChatPage {
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop') safeTop: number = 0
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
   * 配置数据内容
   */
  @State
  aiChatDataMD: AIChatDataMD = new AIChatDataMD()

  build() {
    Column() {
      titleComponent(
        "AI聊天页面",
        0xFF317AFF,
        true,
        this.safeTop
      )

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
                this.aiChatDataMD.incrementalAnalysis = this.incrementalAnalysis
              })
          })
        }
      }

      Button("AI聊天全量加载")
        .height(40)// 高度
        .width('80%')// 宽度
        .type(ButtonType.Capsule)// 圆角
        .fontColor('#FFFFFFFF')// 文本颜色
        .backgroundColor(0xFF317AFF)// 背景颜色
        .margin({ top: 5, bottom: 5 })// 外边距
        .align(Alignment.Center)// 内容对齐方式
        .fontSize(16)// 字体大小
        .onClick(() => {
          // 点击动作触发该方法调用
          router.pushUrl({ url: "pages/AIChatDetailsPage", params: this.aiChatDataMD })
        })

      Button("AI聊天懒加载")
        .height(40)// 高度
        .width('80%')// 宽度
        .type(ButtonType.Capsule)// 圆角
        .fontColor('#FFFFFFFF')// 文本颜色
        .backgroundColor(0xFF317AFF)// 背景颜色
        .margin({ top: 5, bottom: 5 })// 外边距
        .align(Alignment.Center)// 内容对齐方式
        .fontSize(16)// 字体大小
        .onClick(() => {
          // 点击动作触发该方法调用
          router.pushUrl({ url: "pages/AIChatLazyDetailsPage", params: this.aiChatDataMD })
        })

      Button("AI聊天表格吸顶")
        .height(40)
        .width('80%')
        .type(ButtonType.Capsule)
        .fontColor('#FFFFFFFF')
        .backgroundColor(0xFF317AFF)
        .margin({ top: 5, bottom: 5 })
        .align(Alignment.Center)
        .fontSize(16)
        .onClick(() => {
          router.pushUrl({ url: "pages/AIChatTableStickyPage" })
        })

      Button("AI聊天表格吸顶懒加载")
        .height(40)
        .width('80%')
        .type(ButtonType.Capsule)
        .fontColor('#FFFFFFFF')
        .backgroundColor(0xFF317AFF)
        .margin({ top: 5, bottom: 5 })
        .align(Alignment.Center)
        .fontSize(16)
        .onClick(() => {
          router.pushUrl({ url: "pages/AIChatTableStickyLazyPage" })
        })
    }
    .backgroundColor('#FFEAEAEA')
    .height("100%")
  }
}

export class AIChatDataMD {
  _incrementalAnalysis: boolean = false

  public set incrementalAnalysis(value: boolean) {
    this._incrementalAnalysis = value
  }

  constructor() {
  }
}
