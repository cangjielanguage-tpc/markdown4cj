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
func itemListComponent(text: String, routerStr: String) {
    Button(text)
        // 高度
        .height(40)
        // 宽度
        .width(80.percent)
        // 圆角
        .shape(ShapeType.Capsule)
        // 文本颜色
        .fontColor(0xFFFFFF)
        // 背景颜色
        .backgroundColor(0xFF0000)
        // 外边距
        .margin(top: 5, bottom: 5)
        // 内容对齐方式
        .align(Alignment.Center)
        // 字体大小
        .fontSize(16)
        // 点击动作触发该方法调用
        .onClick {Router.push(url: routerStr)}
}

@Builder
func itemListComponent(text: String, routerStr: String, params: String) {
    Button(text)
        // 高度
        .height(40)
        // 宽度
        .width(80.percent)
        // 圆角
        .shape(ShapeType.Capsule)
        // 文本颜色
        .fontColor(0xFFFFFF)
        // 背景颜色
        .backgroundColor(0xFF0000)
        // 外边距
        .margin(top: 5, bottom: 5)
        // 内容对齐方式
        .align(Alignment.Center)
        // 字体大小
        .fontSize(16)
        // 点击动作触发该方法调用
        .onClick {Router.push(url: routerStr, params: params)}
}
