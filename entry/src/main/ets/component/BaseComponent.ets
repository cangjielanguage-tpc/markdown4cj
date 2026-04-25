/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { router } from '@kit.ArkUI'

@Builder
export function itemListComponent(text: string, backGroupColor: number, routerStr: string) {
  Button(text)
    .height(40)// 高度
    .width('80%')// 宽度
    .type(ButtonType.Capsule)// 圆角
    .fontColor(0xFFFFFFFF)// 文本颜色
    .backgroundColor(backGroupColor)// 背景颜色
    .margin({ top: 5, bottom: 5 })// 外边距
    .align(Alignment.Center)// 内容对齐方式
    .fontSize(16)// 字体大小
    .onClick(() => {
      // 点击动作触发该方法调用
      router.pushUrl({ url: routerStr })
    })
}

@Builder
export function itemListComponentParams(text: string, backGroupColor: number, routerStr: string, params: string) {
  Button(text)
    .height(40)// 高度
    .width('80%')// 宽度
    .type(ButtonType.Capsule)// 圆角
    .fontColor(0xFFFFFFFF)// 文本颜色
    .backgroundColor(backGroupColor)// 背景颜色
    .margin({ top: 5, bottom: 5 })// 外边距
    .align(Alignment.Center)// 内容对齐方式
    .fontSize(16)// 字体大小
    .onClick(() => {
      // 点击动作触发该方法调用
      router.pushUrl({ url: routerStr, params: params })
    })
}

@Builder
export function titleComponent(title: string, titleColor: number, isBack: boolean, safeTop: number) {
  Column() {
    Text("")
      .height(safeTop)// 高度
      .width("100%") // 宽度
    Row() {
      if (isBack) {
        Image($r("app.media.return_icon"))
          .width(20)// 高度
          .height(20)// 宽度
          .margin({ right: 20, left: 20 })// 外边距
          .objectFit(ImageFit.Cover)// 设置图片的缩放类型
          .onClick(e => {
            router.back()
          })
      }
      Text(title)
        .height(40)// 高度
        .layoutWeight(1)// 宽度
        .fontColor(0xFFFFFFFF)// 文本颜色
        .align(Alignment.Center)// 设置容器元素绘制区域内的子元素的对齐方式
        .textAlign(TextAlign.Center)// 设置文本段落在水平方向的对齐方式
        .fontSize(16) // 字体大小
      if (isBack) {
        Text("")
          .width(20)// 高度
          .height(20)// 宽度
          .margin({ right: 20, left: 20 }) // 外边距
      }
    }
  }
  // 背景颜色
  .backgroundColor(titleColor)
}

