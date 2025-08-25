/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.concurrency.*
import markdown.components.*

@Builder
func titleComponent(title: String, isBack: Bool) {
    Column() {
        Row() {
            if (isBack) {
                Image(@r(app.media.return_icon))
                    // 高度
                    .width(20)
                    // 宽度
                    .height(20)
                    // 外边距
                    .margin(right: 20, left: 20)
                    // 设置图片的缩放类型
                    .objectFit(ImageFit.Cover)
                    .onClick({
                        e => Router.back()
                    })
            }
            Text(title)
                // 高度
                .height(40)
                // 宽度
                .layoutWeight(1)
                // 文本颜色
                .fontColor(0xFFFFFF)
                // 设置容器元素绘制区域内的子元素的对齐方式
                .align(Alignment.Center)
                // 设置文本段落在水平方向的对齐方式
                .textAlign(TextAlign.Center)
                // 字体大小
                .fontSize(16)
            if (isBack) {
                Text("")
                    // 高度
                    .width(20)
                    // 宽度
                    .height(20)
                    // 外边距
                    .margin(right: 20, left: 20)
            }
        }
    }
    // 背景颜色
    .backgroundColor(0xFF0000)
}
