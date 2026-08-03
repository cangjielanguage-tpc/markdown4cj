import { CJHybridComponentV2 } from '@cangjie/cjhybridview';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Demo_page {
  @StorageProp('safeTop') safeTop: number = 0

  build() {
    Column() {
      Row() {
        Text("‹")
          .fontSize(24)
          .fontColor(Color.White)
          .margin({ left: 15, right: 15 })
          .onClick(() => router.back())
        Text("演示样例")
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
        component: 'Demo_page'
      })
    }
    .height('100%')
    .width('100%')
  }
}
