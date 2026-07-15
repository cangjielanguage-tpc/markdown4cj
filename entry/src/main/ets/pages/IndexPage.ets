import { CJHybridComponentV2 } from '@cangjie/cjhybridview'
import { router } from '@kit.ArkUI'
import { font } from '@kit.ArkUI'

@Entry
@Component
struct IndexPage {
  @StorageProp('safeTop') safeTop: number = 0

  aboutToAppear(): void {
    font.registerFont({
      "familyName": "Hei",
      "familySrc": "font/myfont.ttf"
    })
    globalThis.navigate = (page: string) => {
      if (page === 'demo') {
        router.pushUrl({ url: 'pages/demo_page' })
      } else {
        router.pushUrl({ url: 'pages/' + page })
      }
    }
  }

  build() {
    Column() {
      CJHybridComponentV2({
        library: 'ohos_app_cangjie_entry',
        component: 'IndexPage'
      })
    }
    .padding({ top: this.safeTop })
    .height('100%')
    .width('100%')
  }
}
