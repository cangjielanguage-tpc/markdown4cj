import { CJHybridComponent } from '@cangjie/cjhybridcomponent';

@Entry
@Component
struct Demo_page {
  build() {
    Column() {
      CJHybridComponent({
        library: 'ohos_app_cangjie_entry',
        component: 'Demo_page'
      })
    }
    .height('100%')
    .width('100%')
  }
}
