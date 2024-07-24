/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
/**
 * 空数据
 */
@Entry
@Component
class EmptyPage {
    func build() {
        Scroll() {
            Column {
                MarkdownComponent(mdStr: mdStr)
            }
        }
        // 设置滚动方法
        .scrollable(ScrollDirection.Vertical)
    }

    let mdStr: String = ""
}
