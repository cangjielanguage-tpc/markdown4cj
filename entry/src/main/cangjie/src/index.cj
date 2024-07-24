/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.concurrency.*
@Entry
@Component
class Index {
    func build() {
        Column {
            Text("hello world")
                // 宽度
                .width(100.percent)
                // 文本颜色
                .fontColor(0x000000)
                // 背景颜色
                .backgroundColor(0xFFFFFF)
                // 内容对齐方式
                .align(Alignment.Center)
                // 字体大小
                .fontSize(25)
                // 设置多行文本的文本对齐方式
                .textAlign(TextAlign.Center)
        }
    }
}
