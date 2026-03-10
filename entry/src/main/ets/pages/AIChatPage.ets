/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
import { itemListComponent, titleComponent } from '../component/BaseComponent'

@Entry
@Component
struct AIChatPage {
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop') safeTop: number = 0

  build() {
    Column() {
      titleComponent(
        "综合配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )

      itemListComponent(
        "AI聊天全量加载",
        0xFF317AFF,
        "pages/AIChatDetailsPage"
      )

      itemListComponent(
        "AI聊天懒加载",
        0xFF317AFF,
        "pages/AIChatLazyDetailsPage"
      )
    }
    .backgroundColor(0xFFEAEAEA)
    .height("100%")
  }
}