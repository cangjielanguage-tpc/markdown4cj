import { CJHybridComponentV2 } from '@cangjie/cjhybridview';

@Entry
@Component
struct Demo_page {
  @State message: string = 'Hello World';

  build() {
    Column() {
      CJHybridComponentV2({
        library: 'ohos_app_cangjie_entry',
        component: 'Demo_page'
      })
    }
    .height('100%')
    .width('100%')
  }
}
