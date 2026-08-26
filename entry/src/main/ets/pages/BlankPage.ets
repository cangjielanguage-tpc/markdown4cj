import { titleComponent } from '../component/BaseComponent'
import { ConfigurationConstant } from '@kit.AbilityKit'

/**
 * 预订空白页
 *
 * SDUI 卡片「立即预订」按钮的跳转目标页（003 用例验证）。
 */
@Entry
@Component
struct BlankPage {
  @StorageProp('safeTop')
  safeTop: number = 0
  @StorageProp('currentColorMode')
  currentColorMode: ConfigurationConstant.ColorMode = ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT

  build() {
    Column() {
      titleComponent(
        "预订页",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Column() {
        Text('预订页（空白）')
          .fontSize(16)
          .fontColor('#FF6B7280')
        Text('来自 SDUI 卡片「立即预订」按钮跳转')
          .fontSize(12)
          .fontColor('#FF9CA3AF')
          .margin({ top: 8 })
      }
      .justifyContent(FlexAlign.Center)
      .layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Center)
    .height('100%')
  }
}
