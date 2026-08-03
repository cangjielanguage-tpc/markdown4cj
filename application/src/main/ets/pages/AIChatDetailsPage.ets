import { CJHybridComponentV2 } from '@cangjie/cjhybridview'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct AIChatDetailsPage {
  @StorageProp('safeTop') safeTop: number = 0
  @State ready: boolean = false

  aboutToAppear(): void {
    globalThis.safeTop = this.safeTop.toString()
    this.ready = true
  }

  build() {
    if (this.ready) {
      Column() {
        Row() {
          Text("‹")
            .fontSize(24)
            .fontColor(Color.White)
            .margin({ left: 15, right: 15 })
            .onClick(() => router.back())
          Text("AI聊天全量加载")
            .fontSize(18)
            .fontColor(Color.White)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Text("")
            .width(24)
            .margin({ left: 15, right: 15 })
        }
        .height(44 + this.safeTop)
        .padding({ top: this.safeTop })
        .backgroundColor(0xFF317AFF)

        CJHybridComponentV2({
          library: 'ohos_app_cangjie_entry',
          component: 'AIChatDetailsPage'
        })
          .layoutWeight(1)
          .width('100%')
      }
      .height('100%')
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
    }
  }
}
