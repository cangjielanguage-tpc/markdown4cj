/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 标题全量加载
 */
@Entry
@Component
class TitleCompletePage {
    let mdStr: String = getFileContextStr("title.md")

    func build() {
        Scroll() {
            Column {
                MarkdownAIComponent(output: mdStr, isFull: true)
            }
        }
        // 设置滚动方法
        .scrollable(ScrollDirection.Vertical)
    }
}
