/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */

package markdown.codeformat

//python要用 记录try if新旧位置，然后匹配对应的except和elif和else
class FlagBean {
    var flagName: String = ""
    var flagIndent: Int64 = 0

    init(flagName: String, flagIndent: Int64) {
        this.flagName = flagName
        this.flagIndent = flagIndent
    }
}
