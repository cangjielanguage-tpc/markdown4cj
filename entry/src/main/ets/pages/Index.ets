import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = '跳转markdown';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('跳转markdown')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          router.pushUrl({ url: "pages/demo_page"})
        })
    }
    .height('100%')
    .width('100%')
  }
}