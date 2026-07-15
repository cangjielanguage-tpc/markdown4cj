import { CJHybridComponentV2 } from '@cangjie/cjhybridview'
import { getFileListStr, getFileContextStr } from '../utils/FileUtils'

@Entry
@Component
struct DemoDetailsPage {
  @StorageProp('safeTop') safeTop: number = 0
  @State content: string = ""
  @State ready: boolean = false

  aboutToAppear(): void {
    let rawfilePath = "000_Example/"
    let fileList = getFileListStr(rawfilePath)
    let allContent = ""
    for (let i = 0; i < fileList.length; i++) {
      let fileContent = getFileContextStr(rawfilePath + fileList[i])
      if (fileContent !== "") {
        allContent += fileContent + "\n\n---\n\n"
      }
    }
    this.content = allContent
    globalThis.markdownContent = this.content
    this.ready = true
  }

  build() {
    if (this.ready) {
      Column() {
        CJHybridComponentV2({
          library: 'ohos_app_cangjie_entry',
          component: 'DemoDetailsPage'
        })
      }
      .padding({ top: this.safeTop })
      .height('100%')
      .width('100%')
    }
  }
}
