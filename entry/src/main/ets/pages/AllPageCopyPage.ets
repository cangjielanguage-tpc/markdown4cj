import { CJHybridComponentV2 } from '@cangjie/cjhybridview'
import { router } from '@kit.ArkUI'
import { getFileListStr } from '../utils/FileUtils'

@Entry
@Component
struct AllPageCopyPage {
  @StorageProp('safeTop') safeTop: number = 0
  @State fileList: string = ""
  @State ready: boolean = false

  aboutToAppear(): void {
    let allFiles: Array<string> = []
    let rootEntries = getFileListStr("")
    for (let entry of rootEntries) {
      if (entry.indexOf('.') === -1 && entry.indexOf('LargeData') === -1) {
        let subFiles = getFileListStr(`${entry}/`)
        for (let subFile of subFiles) {
          if (subFile.endsWith('.md')) {
            allFiles.push(`${entry}/${subFile}`)
          }
        }
      }
    }
    this.fileList = allFiles.join(",")
    globalThis.fileList = this.fileList
    globalThis.rawFilePath = ""
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
          Text("全局文本复制测试页面")
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
          component: 'AllPageCopyPage'
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
