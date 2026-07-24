import { CJHybridComponentV2 } from '@cangjie/cjhybridview'
import { getFileListStr } from '../utils/FileUtils'

@Entry
@Component
struct SwitchDataPage {
  @StorageProp('safeTop') safeTop: number = 0
  @State fileList: string = ""
  @State ready: boolean = false

  aboutToAppear(): void {
    let files = getFileListStr("033_FullTextSwitch/")
    this.fileList = files.join(",")
    globalThis.fileList = this.fileList
    globalThis.rawFilePath = "033_FullTextSwitch"
    this.ready = true
    globalThis.safeTop = this.safeTop.toString()
  }

  build() {
    if (this.ready) {
      Column() {
        CJHybridComponentV2({
          library: 'ohos_app_cangjie_entry',
          component: 'SwitchDataPage'
        })
      }
      .height('100%')
      .width('100%')
    }
  }
}