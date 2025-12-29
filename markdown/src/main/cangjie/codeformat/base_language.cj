/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */

package markdown.codeformat

interface BaseLanguage {

    func dealWithNewLine(stateBean: StateBean): Unit

    func dealWithAccessPublic(stateBean: StateBean): Bool

    func dealWithAccessPrivate(stateBean: StateBean): Bool

    func dealWithMultiLineComment(stateBean: StateBean): Unit

    func dealWithSingleLineComment(stateBean: StateBean): Unit

    func dealWithLeftBigBracket(stateBean: StateBean): Unit

    func dealWithRightBigBracket(stateBean: StateBean): Unit

    func dealWithMacro(stateBean: StateBean): Unit

    func dealWithString(stateBean: StateBean): Unit

    func dealWithFor(stateBean: StateBean): Unit

    func dealWithSemicolon(stateBean: StateBean): Unit
}
