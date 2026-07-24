import { CJHybridComponentV2 } from '@cangjie/cjhybridview'
import { router } from '@kit.ArkUI'
import { getFileListStr } from '../utils/FileUtils'

@Entry
@Component
struct BigDataPage {
  @StorageProp('safeTop') safeTop: number = 0
  @State fileList: string = ""
  @State ready: boolean = false

  aboutToAppear(): void {
    let files = getFileListStr("034_LargeData/")
    this.fileList = files.join(",")
    globalThis.fileList = this.fileList
    globalThis.rawFilePath = "034_LargeData"
    globalThis.markdownContent = ""
    this.ready = true
    globalThis.safeTop = this.safeTop.toString()
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
          Text("超大数据配置页面")
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
          component: 'BigDataPage'
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
