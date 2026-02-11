/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */

package markdown.codeformat

class PythonFormat <: BaseLanguage {

    //这里的逻辑其实就是if行和try行记录，然后下面的else和except以最近的一个if和try为锚点确定indent,到except和else则销毁最近的flag
    let arrayListFlagTry: ArrayList<FlagBean> = ArrayList<FlagBean>()
    let arrayListFlagIf: ArrayList<FlagBean> = ArrayList<FlagBean>()

    func doTryFlag(lineBean: LineBean) {
        if (lineBean.codeLine.trimAscii().startsWith("try:")) {
            let flagBean = FlagBean("try", lineBean.indentLevel)
            arrayListFlagTry.add(flagBean)
        }
    }

    func doIfFlag(lineBean: LineBean) {
        if (lineBean.codeLine.trimAscii().startsWith("if ")) {
            let flagBean = FlagBean("if", lineBean.indentLevel)
            arrayListFlagIf.add(flagBean)
        }
    }

    public override func dealWithNewLine(stateBean: StateBean): Unit {
        if (stateBean.perLineOutput.size > 0) {
            let lineBean: LineBean = LineBean()
            lineBean.codeLine = stateBean.perLineOutput.toString()
            if (stateBean.isInExcept) {
                //获取最近的try
                if (arrayListFlagTry.size > 0) {
                    let tryflagBean = arrayListFlagTry.get(arrayListFlagTry.size - 1).getOrThrow()
                    stateBean.indentLevel = tryflagBean.flagIndent
                    lineBean.indentLevel = stateBean.indentLevel
                    arrayListFlagTry.remove(at: arrayListFlagTry.size - 1)
                } else {
                    lineBean.indentLevel = stateBean.indentLevel
                }
                stateBean.isInExcept = false
            } else if (stateBean.isInElif) {
                //跟上面的if一样的层级
                if (arrayListFlagIf.size > 0) {
                    let ifFlagBean = arrayListFlagIf.get(arrayListFlagIf.size - 1).getOrThrow()
                    stateBean.indentLevel = ifFlagBean.flagIndent
                    lineBean.indentLevel = stateBean.indentLevel
                } else {
                    lineBean.indentLevel = stateBean.indentLevel
                }
                stateBean.isInElif = false
            } else if (stateBean.isInElse) {
                if (arrayListFlagIf.size > 0) {
                    let ifFlagBean = arrayListFlagIf.get(arrayListFlagIf.size - 1).getOrThrow()
                    stateBean.indentLevel = ifFlagBean.flagIndent
                    lineBean.indentLevel = stateBean.indentLevel
                    arrayListFlagIf.remove(at: arrayListFlagIf.size - 1)
                } else {
                    lineBean.indentLevel = stateBean.indentLevel
                }
                stateBean.isInElse = false
            } else if (stateBean.isInDef) {
                if (stateBean.isHasClass) {
                    stateBean.indentLevel = 1
                } else {
                    stateBean.indentLevel = 0
                }
                lineBean.indentLevel = stateBean.indentLevel
                stateBean.isInDef = false
            } else if (stateBean.isInImport) {
                stateBean.indentLevel = 0
                lineBean.indentLevel = stateBean.indentLevel
                stateBean.isInImport = false
            } else if (stateBean.isInClass) {
                stateBean.indentLevel = 0
                lineBean.indentLevel = stateBean.indentLevel
                stateBean.isInClass = false
            } else if (stateBean.isInMain) {
                stateBean.indentLevel = 0
                lineBean.indentLevel = stateBean.indentLevel
                stateBean.isInMain = false
            } else {
                lineBean.indentLevel = stateBean.indentLevel
            }
            lineBean.smallBracketDouble = stateBean.smallBracketDouble
            lineBean.middleBracketDouble = stateBean.middleBracketDouble
            lineBean.sharpBracketDouble = stateBean.sharpBracketDouble
            lineBean.isInString = stateBean.isInString
            lineBean.isInMacro = stateBean.isInMacro
            //保存try变量和except对齐
            doTryFlag(lineBean)
            doIfFlag(lineBean)
            stateBean.linesList.add(lineBean) //这里保存了

            //如果这行有return,那么下一行的层级要减1
            if (stateBean.isInRetuen) {
                stateBean.indentLevel--
                stateBean.isInRetuen = false
            } else {
                //如果当前行是空的，那还保持这个状态
                if (lineBean.codeLine.trimAscii().size != 0) {
                    stateBean.isLastLineReturn = false
                }
            }
            //如果这行有return,那么下一行的层级要减1
            if (stateBean.isInContinue) {
                stateBean.indentLevel--
                stateBean.isInContinue = false
            }
            //如果这行有break,那么下一行的层级要减1
            if (stateBean.isInBreak) {
                stateBean.indentLevel--
                stateBean.isInBreak = false
            }
            stateBean.perLineOutput = StringBuilder()
            stateBean.perLineStartIndex = stateBean.currentIndex + 1
            stateBean.lastChar = r'\n'
        }
    }

    public func dealWithColon(stateBean: StateBean): Unit {
        //这里是先把一行选出来
        let lineBean: LineBean = LineBean()
        let lineStartIndex: Int64 = stateBean.perLineStartIndex
        let lineEndIndex: Int64 = stateBean.currentIndex
        let lineCode: String = String(
            stateBean.codeChars.getOrThrow().slice(lineStartIndex, lineEndIndex - lineStartIndex + 1))
        lineBean.codeLine = lineCode
        //记录上一行结束的index
        if (stateBean.isInExcept) {
            if (arrayListFlagTry.size > 0) {
                let tryflagBean = arrayListFlagTry.get(arrayListFlagTry.size - 1).getOrThrow()
                stateBean.indentLevel = tryflagBean.flagIndent
                lineBean.indentLevel = stateBean.indentLevel
                arrayListFlagTry.remove(at: arrayListFlagTry.size - 1)
            } else {
                lineBean.indentLevel = stateBean.indentLevel
            }
            stateBean.isInExcept = false
        } else if (stateBean.isInElif) {
            if (arrayListFlagIf.size > 0) {
                let ifFlagBean = arrayListFlagIf.get(arrayListFlagIf.size - 1).getOrThrow()
                stateBean.indentLevel = ifFlagBean.flagIndent
                lineBean.indentLevel = stateBean.indentLevel
            } else {
                lineBean.indentLevel = stateBean.indentLevel
            }
            stateBean.isInElif = false
        } else if (stateBean.isInElse) {
            if (arrayListFlagIf.size > 0) {
                let ifFlagBean = arrayListFlagIf.get(arrayListFlagIf.size - 1).getOrThrow()
                stateBean.indentLevel = ifFlagBean.flagIndent
                lineBean.indentLevel = stateBean.indentLevel
                arrayListFlagIf.remove(at: arrayListFlagIf.size - 1)
            } else {
                lineBean.indentLevel = stateBean.indentLevel
            }
            stateBean.isInElse = false
        } else if (stateBean.isInDef) {
            if (stateBean.isHasClass) {
                stateBean.indentLevel = 1
            } else {
                stateBean.indentLevel = 0
            }
            lineBean.indentLevel = stateBean.indentLevel
            stateBean.isInDef = false
        } else if (stateBean.isInImport) {
            stateBean.indentLevel = 0
            lineBean.indentLevel = stateBean.indentLevel
            stateBean.isInImport = false
        } else if (stateBean.isInClass) {
            stateBean.indentLevel = 0
            lineBean.indentLevel = stateBean.indentLevel
            stateBean.isInClass = false
        } else if (stateBean.isInMain) {
            stateBean.indentLevel = 0
            lineBean.indentLevel = stateBean.indentLevel
            stateBean.isInMain = false
        } else {
            lineBean.indentLevel = stateBean.indentLevel
        }
        lineBean.smallBracketDouble = stateBean.smallBracketDouble
        lineBean.middleBracketDouble = stateBean.middleBracketDouble
        lineBean.sharpBracketDouble = stateBean.sharpBracketDouble
        lineBean.isInString = stateBean.isInString
        lineBean.isInMacro = stateBean.isInMacro
        doTryFlag(lineBean)
        doIfFlag(lineBean)
        stateBean.linesList.add(lineBean) //这里保存了一个lineBean了

        //如果这行有return,那么下一行的层级要减1
        if (stateBean.isInRetuen) {
            stateBean.indentLevel--
            stateBean.isInRetuen = false
        } else {
            stateBean.isLastLineReturn = false
        }
        //如果这行有return,那么下一行的层级要减1
        if (stateBean.isInContinue) {
            stateBean.indentLevel--
            stateBean.isInContinue = false
        }
        //如果这行有break,那么下一行的层级要减1
        if (stateBean.isInBreak) {
            stateBean.indentLevel--
            stateBean.isInBreak = false
        }
        stateBean.perLineOutput = StringBuilder()
        stateBean.isLineStart = true
        stateBean.indentLevel++ //下一个层级才加1
        stateBean.perLineStartIndex = stateBean.currentIndex + 1
        stateBean.lastChar = r':'
        stateBean.currentIndex++
    }

    public override func dealWithLeftBigBracket(_: StateBean): Unit {
    }

    public override func dealWithRightBigBracket(_: StateBean): Unit {
    }

    public func dealWithMultiLineString(stateBean: StateBean): Bool {
        let notNullChar: Array<Rune> = stateBean.codeChars.getOrThrow()
        let currentIndex: Int64 = stateBean.currentIndex
        var currChar: Rune = notNullChar[currentIndex]
        if (currentIndex >= 2) {
            var lastChar = notNullChar[currentIndex - 1]
            var lastlastChar = notNullChar[currentIndex - 2]
            if (((lastlastChar == r'"' && lastChar == r'"' && currChar == r'"') || (lastlastChar == r'\'' && lastChar ==
                r'\'' && currChar == r'\''))) {
                if (!stateBean.isInMultiString) {
                    stateBean.isInMultiString = true
                    stateBean.multiStringQuote = currChar
                    var perStr = ""
                    if (currChar == r'"') {
                        perStr = stateBean.perLineOutput.toString().removeSuffix("\"\"\"")
                    } else {
                        perStr = stateBean.perLineOutput.toString().removeSuffix("'''")
                    }
                    //原因是python跟c和cpp不一样，有值得话就要单独弄个LineBean了
                    //进入了多行注释
                    //在python中 多行字符串不能和别的代码在一行，所以这里开始'''到换行为止单独一行
                    //多行注释的开头必进这里
                    if (notNullChar.size > currentIndex + 3) {
                        //这样至少完整
                        stateBean.currentIndex += 3
                        let newcurrentIndex = stateBean.currentIndex
                        lastlastChar = notNullChar[newcurrentIndex - 2]
                        lastChar = notNullChar[newcurrentIndex - 1]
                        currChar = notNullChar[newcurrentIndex]
                        //因为跳跃了 所以这里补上
                        stateBean.perLineOutput.append(lastlastChar)
                        stateBean.perLineOutput.append(lastChar)
                        while (!(lastlastChar == stateBean.multiStringQuote && lastChar == stateBean.multiStringQuote &&
                                currChar == stateBean.multiStringQuote)) {
                            if (stateBean.currentIndex == stateBean.codeChars.getOrThrow().size - 1) {
                                break
                            }
                            stateBean.currentIndex++
                            stateBean.perLineOutput.append(currChar)
                            currChar = stateBean.codeChars.getOrThrow()[stateBean.currentIndex]
                            lastChar = stateBean.codeChars.getOrThrow()[stateBean.currentIndex - 1]
                            lastlastChar = stateBean.codeChars.getOrThrow()[stateBean.currentIndex - 2]
                        }
                    } else {
                        //说明没内容了 """ab 其实这种情况就不符合多行注释那就返回吧
                        stateBean.isInMultiString = false
                        stateBean.multiStringQuote = r" "
                        return false
                    }

                    //到这里就是结束的Index了
                    let lineEndIndex: Int64 = stateBean.currentIndex
                    var lineCodeAll: String = String(
                        stateBean.codeChars.getOrThrow().slice(currentIndex - 2, lineEndIndex - currentIndex + 2 + 1))
                    if (perStr.trimAscii().size > 0) {
                        let lineBean: LineBean = LineBean()
                        lineBean.codeLine = perStr
                        lineBean.indentLevel = stateBean.indentLevel
                        lineBean.smallBracketDouble = stateBean.smallBracketDouble
                        lineBean.middleBracketDouble = stateBean.middleBracketDouble
                        lineBean.sharpBracketDouble = stateBean.sharpBracketDouble
                        lineBean.isInString = stateBean.isInString
                        lineBean.isInMacro = stateBean.isInMacro
                        doTryFlag(lineBean)
                        doIfFlag(lineBean)
                        stateBean.linesList.add(lineBean)
                        stateBean.perLineOutput = StringBuilder()
                    }

                    //然后这里面的内容根据\n分为几行 解析为几个LineBean
                    let lineCodeList: Array<String> = lineCodeAll.split("\n")
                    for (index in 0..lineCodeList.size) {
                        let lineBean: LineBean = LineBean()
                        lineBean.codeLine = lineCodeList[index]
                        if (index == 0) {
                            lineBean.isFirstMultiCommentLine = true
                            lineBean.mutlilineCommentisAfterChangline = true //python多行前面都是换行的，不然错误
                        }
                        //多行注释的缩进和StateBean一致
                        lineBean.indentLevel = stateBean.indentLevel
                        lineBean.smallBracketDouble = stateBean.smallBracketDouble
                        lineBean.middleBracketDouble = stateBean.middleBracketDouble
                        lineBean.sharpBracketDouble = stateBean.sharpBracketDouble
                        lineBean.isInString = stateBean.isInString
                        lineBean.isInMacro = stateBean.isInMacro
                        lineBean.isInMultiString = stateBean.isInMultiString
                        //多行的时候跟单行注释不一样 如果前面有内容就只加一个 空格
                        stateBean.linesList.add(lineBean)
                        stateBean.perLineOutput = StringBuilder()
                    }
                    //这些个判断要放到所有行处理完后
                    //如果这行有return,那么下一行的层级要减1
                    if (stateBean.isInRetuen) {
                        stateBean.indentLevel--
                        stateBean.isInRetuen = false
                    } else {
                        stateBean.isLastLineReturn = false
                    }
                    //如果这行有Continue,那么下一行的层级要减1
                    if (stateBean.isInContinue) {
                        stateBean.indentLevel--
                        stateBean.isInContinue = false
                    }
                    //如果这行有break,那么下一行的层级要减1
                    if (stateBean.isInBreak) {
                        stateBean.indentLevel--
                        stateBean.isInBreak = false
                    }
                    stateBean.isLineStart = true
                    stateBean.perLineStartIndex = stateBean.currentIndex + 1
                    stateBean.lastChar = r'\n'
                    stateBean.currentIndex++
                    stateBean.multiStringQuote = r" "
                    stateBean.isInMultiString = false
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        } else {
            return false
        }
    }

    public override func dealWithSingleLineComment(_: StateBean, _: String): Unit {
    }

    public override func dealWithMultiLineComment(_: StateBean, _: String): Unit {
    }

    public override func dealWithMacro(stateBean: StateBean): Unit {
        stateBean.isInMacro = true
        let lineBean: LineBean = LineBean()
        let lineStartIndex: Int64 = stateBean.currentIndex
        var currChar: Rune = stateBean.codeChars.getOrThrow()[stateBean.currentIndex] //#
        while (currChar != r'\n') {
            if (stateBean.currentIndex == stateBean.codeChars.getOrThrow().size - 1) {
                break
            }
            stateBean.currentIndex++
            currChar = stateBean.codeChars.getOrThrow()[stateBean.currentIndex]
            stateBean.perLineOutput.append(currChar)
        }
        let lineEndIndex: Int64 = stateBean.currentIndex
        let lineCode: String = String(
            stateBean.codeChars.getOrThrow().slice(lineStartIndex, lineEndIndex - lineStartIndex + 1))
        lineBean.codeLine = lineCode
        lineBean.indentLevel = stateBean.indentLevel //宏没有缩进
        lineBean.smallBracketDouble = stateBean.smallBracketDouble
        lineBean.middleBracketDouble = stateBean.middleBracketDouble
        lineBean.sharpBracketDouble = stateBean.sharpBracketDouble
        lineBean.isInString = stateBean.isInString
        lineBean.isInMacro = stateBean.isInMacro
        stateBean.linesList.add(lineBean) //这里保存了一个lineBean了

        //如果这行有return,那么下一行的层级要减1
        if (stateBean.isInRetuen) {
            stateBean.indentLevel--
            stateBean.isInRetuen = false
        } else {
            stateBean.isLastLineReturn = false
        }
        //如果这行有return,那么下一行的层级要减1
        if (stateBean.isInContinue) {
            stateBean.indentLevel--
            stateBean.isInContinue = false
        }
        //如果这行有break,那么下一行的层级要减1
        if (stateBean.isInBreak) {
            stateBean.indentLevel--
            stateBean.isInBreak = false
        }
        stateBean.perLineOutput = StringBuilder()
        stateBean.isLineStart = true
        stateBean.perLineStartIndex = stateBean.currentIndex + 1
        stateBean.lastChar = r'\n'
        stateBean.currentIndex++
        stateBean.isInMacro = false
    }

    public override func dealWithAccessPublic(_: StateBean): Bool {
        return false
    }

    public override func dealWithAccessPrivate(_: StateBean): Bool {
        return false
    }

    public override func dealWithAccessProtected(_: StateBean): Bool {
        return false
    }

    public override func dealWithString(stateBean: StateBean): Unit {
        let notNullChar: Array<Rune> = stateBean.codeChars.getOrThrow()
        let currentIndex: Int64 = stateBean.currentIndex
        let currChar: Rune = notNullChar[currentIndex]
        var lastChar: Rune = r' '
        if (currentIndex - 1 >= 0) {
            lastChar = notNullChar[currentIndex - 1]
        }
        if ((currChar == r'"' || currChar == r'\'') && !stateBean.isInString) {
            stateBean.stringQuote = currChar
            stateBean.isInString = true
            return
        }
        if (stateBean.isInString && currChar == stateBean.stringQuote && lastChar != r'\\') {
            stateBean.isInString = false
            stateBean.stringQuote = r' '
            return
        }
        //解决错误情况单个"号导致字符串没法关闭的情况
        if (stateBean.isInString && currChar == r'\n') {
            stateBean.isInString = false
            stateBean.stringQuote = r' '
            return
        }
    }

    public func dealWithReturn(stateBean: StateBean): Unit {
        let notNullChar: Array<Rune> = stateBean.codeChars.getOrThrow()
        let currentIndex: Int64 = stateBean.currentIndex
        if (currentIndex >= 5) {
            if (notNullChar[currentIndex - 5] == r'r' && notNullChar[currentIndex - 4] == r'e' &&
                notNullChar[currentIndex - 3] == r't' && notNullChar[currentIndex - 2] == r'u' &&
                notNullChar[currentIndex - 1] == r'r' && notNullChar[currentIndex] == r'n') {
                stateBean.isInRetuen = true
                stateBean.isLastLineReturn = true
                return
            }
        }
    }

    public func dealWithContinue(stateBean: StateBean): Unit {
        let notNullChar: Array<Rune> = stateBean.codeChars.getOrThrow()
        let currentIndex: Int64 = stateBean.currentIndex
        if (currentIndex >= 7) {
            if (notNullChar[currentIndex - 7] == r'c' && notNullChar[currentIndex - 6] == r'o' &&
                notNullChar[currentIndex - 5] == r'n' && notNullChar[currentIndex - 4] == r't' &&
                notNullChar[currentIndex - 3] == r'i' && notNullChar[currentIndex - 2] == r'n' &&
                notNullChar[currentIndex - 1] == r'u' && notNullChar[currentIndex] == r'e') {
                stateBean.isInContinue = true
                return
            }
        }
    }

    public func dealWithBreak(stateBean: StateBean): Unit {
        let notNullChar: Array<Rune> = stateBean.codeChars.getOrThrow()
        let currentIndex: Int64 = stateBean.currentIndex
        if (currentIndex >= 4) {
            if (notNullChar[currentIndex - 4] == r'b' && notNullChar[currentIndex - 3] == r'r' &&
                notNullChar[currentIndex - 2] == r'e' && notNullChar[currentIndex - 1] == r'a' &&
                notNullChar[currentIndex] == r'k') {
                stateBean.isInBreak = true
                return
            }
        }
    }

    public func dealWithExcept(stateBean: StateBean): Unit {
        let notNullChar: Array<Rune> = stateBean.codeChars.getOrThrow()
        let currentIndex: Int64 = stateBean.currentIndex
        if (currentIndex >= 5) {
            if (notNullChar[currentIndex - 5] == r'e' && notNullChar[currentIndex - 4] == r'x' &&
                notNullChar[currentIndex - 3] == r'c' && notNullChar[currentIndex - 2] == r'e' &&
                notNullChar[currentIndex - 1] == r'p' && notNullChar[currentIndex] == r't') {
                stateBean.isInExcept = true
                return
            }
        }
    }

    public func dealWithElif(stateBean: StateBean): Unit {
        let notNullChar: Array<Rune> = stateBean.codeChars.getOrThrow()
        let currentIndex: Int64 = stateBean.currentIndex
        if (currentIndex >= 3) {
            if (notNullChar[currentIndex - 3] == r'e' && notNullChar[currentIndex - 2] == r'l' &&
                notNullChar[currentIndex - 1] == r'i' && notNullChar[currentIndex] == r'f') {
                stateBean.isInElif = true
                return
            }
        }
    }

    public func dealWithElse(stateBean: StateBean): Unit {
        let notNullChar: Array<Rune> = stateBean.codeChars.getOrThrow()
        let currentIndex: Int64 = stateBean.currentIndex
        if (currentIndex >= 3) {
            if (notNullChar[currentIndex - 3] == r'e' && notNullChar[currentIndex - 2] == r'l' &&
                notNullChar[currentIndex - 1] == r's' && notNullChar[currentIndex] == r'e') {
                stateBean.isInElse = true
                return
            }
        }
    }

    public func dealWithDef(stateBean: StateBean): Unit {
        let notNullChar: Array<Rune> = stateBean.codeChars.getOrThrow()
        let currentIndex: Int64 = stateBean.currentIndex
        if (currentIndex >= 3) {
            if (notNullChar[currentIndex - 3] == r'd' && notNullChar[currentIndex - 2] == r'e' &&
                notNullChar[currentIndex - 1] == r'f' && notNullChar[currentIndex] == r' ') {
                stateBean.isInDef = true
                return
            }
        }
    }

    public func dealWithImport(stateBean: StateBean): Unit {
        let notNullChar: Array<Rune> = stateBean.codeChars.getOrThrow()
        let currentIndex: Int64 = stateBean.currentIndex
        if (currentIndex >= 6) {
            if (notNullChar[currentIndex - 6] == r'i' && notNullChar[currentIndex - 5] == r'm' &&
                notNullChar[currentIndex - 4] == r'p' && notNullChar[currentIndex - 3] == r'o' &&
                notNullChar[currentIndex - 2] == r'r' && notNullChar[currentIndex - 1] == r't' &&
                notNullChar[currentIndex] == r' ') {
                stateBean.isInImport = true
                return
            }
        }
    }

    public func dealWithClass(stateBean: StateBean): Unit {
        let notNullChar: Array<Rune> = stateBean.codeChars.getOrThrow()
        let currentIndex: Int64 = stateBean.currentIndex
        if (currentIndex >= 5) {
            if (notNullChar[currentIndex - 5] == r'c' && notNullChar[currentIndex - 4] == r'l' &&
                notNullChar[currentIndex - 3] == r'a' && notNullChar[currentIndex - 2] == r's' &&
                notNullChar[currentIndex - 1] == r's' && notNullChar[currentIndex] == r' ') {
                stateBean.isInClass = true
                stateBean.isHasClass = true
                return
            }
        }
    }

    public func dealWithMain(stateBean: StateBean): Unit {
        let notNullChar: Array<Rune> = stateBean.codeChars.getOrThrow()
        let currentIndex: Int64 = stateBean.currentIndex
        if (currentIndex >= 8) {
            if (notNullChar[currentIndex - 8] == r' ' && notNullChar[currentIndex - 7] == r'_' &&
                notNullChar[currentIndex - 6] == r'_' && notNullChar[currentIndex - 5] == r'n' &&
                notNullChar[currentIndex - 4] == r'a' && notNullChar[currentIndex - 3] == r'm' &&
                notNullChar[currentIndex - 2] == r'e' && notNullChar[currentIndex - 1] == r'_' &&
                notNullChar[currentIndex] == r'_') {
                stateBean.isInMain = true
                return
            }
        }
    }

    public override func dealWithFor(_: StateBean): Unit {
        //c和cpp处理这个主要是为了for中的; python没有这种情况
    }

    public func dealWithSmallBracket(stateBean: StateBean): Unit {
        let notNullChar: Array<Rune> = stateBean.codeChars.getOrThrow()
        let currentIndex: Int64 = stateBean.currentIndex
        let currChar: Rune = notNullChar[currentIndex]
        if (currChar == r'(') {
            stateBean.isInSmallBracket = true
            stateBean.smallBracketDoublepy++
            return
        }

        if (stateBean.isInSmallBracket) {
            let currChar: Rune = notNullChar[currentIndex]

            if (currChar == r'(') { //主要是用于for循环中的()成对
                stateBean.smallBracketDoublepy++
            }
            if (currChar == r')') {
                stateBean.smallBracketDoublepy--
                if (stateBean.smallBracketDoublepy == 0) { //这里表示走出了for的)括号
                    stateBean.isInSmallBracket = false
                }
            }
        }
    }

    public func dealWithBigBracket(stateBean: StateBean): Unit {
        let notNullChar: Array<Rune> = stateBean.codeChars.getOrThrow()
        let currentIndex: Int64 = stateBean.currentIndex
        let currChar: Rune = notNullChar[currentIndex]
        if (currChar == r'{') {
            stateBean.isInBigBracket = true
            stateBean.bigBracketDoublepy++
            return
        }

        if (stateBean.isInBigBracket) {
            let currChar: Rune = notNullChar[currentIndex]

            if (currChar == r'{') { //主要是用于for循环中的()成对
                stateBean.bigBracketDoublepy++
            }
            if (currChar == r'}') {
                stateBean.bigBracketDoublepy--
                if (stateBean.bigBracketDoublepy == 0) { //这里表示走出了for的)括号
                    stateBean.isInBigBracket = false
                }
            }
        }
    }

    public override func dealWithSemicolon(stateBean: StateBean): Unit {
        let lineBean: LineBean = LineBean()
        let lineStartIndex: Int64 = stateBean.perLineStartIndex
        let lineEndIndex: Int64 = stateBean.currentIndex
        let lineCode: String = String(
            stateBean.codeChars.getOrThrow().slice(lineStartIndex, lineEndIndex - lineStartIndex + 1))
        lineBean.codeLine = lineCode
        //记录上一行结束的index
        if (stateBean.isInExcept) {
            if (arrayListFlagTry.size > 0) {
                let tryflagBean = arrayListFlagTry.get(arrayListFlagTry.size - 1).getOrThrow()
                stateBean.indentLevel = tryflagBean.flagIndent
                lineBean.indentLevel = stateBean.indentLevel
                arrayListFlagTry.remove(at: arrayListFlagTry.size - 1)
            } else {
                lineBean.indentLevel = stateBean.indentLevel
            }
            stateBean.isInExcept = false
        } else if (stateBean.isInElif) {
            if (arrayListFlagIf.size > 0) {
                let ifFlagBean = arrayListFlagIf.get(arrayListFlagIf.size - 1).getOrThrow()
                stateBean.indentLevel = ifFlagBean.flagIndent
                lineBean.indentLevel = stateBean.indentLevel
            } else {
                lineBean.indentLevel = stateBean.indentLevel
            }
            stateBean.isInElif = false
        } else if (stateBean.isInElse) {
            if (arrayListFlagIf.size > 0) {
                let ifFlagBean = arrayListFlagIf.get(arrayListFlagIf.size - 1).getOrThrow()
                stateBean.indentLevel = ifFlagBean.flagIndent
                lineBean.indentLevel = stateBean.indentLevel
                arrayListFlagIf.remove(at: arrayListFlagIf.size - 1)
            } else {
                lineBean.indentLevel = stateBean.indentLevel
            }
            stateBean.isInElse = false
        } else if (stateBean.isInDef) {
            if (stateBean.isHasClass) {
                stateBean.indentLevel = 1
            } else {
                stateBean.indentLevel = 0
            }
            lineBean.indentLevel = stateBean.indentLevel
            stateBean.isInDef = false
        } else if (stateBean.isInImport) {
            stateBean.indentLevel = 0
            lineBean.indentLevel = stateBean.indentLevel
            stateBean.isInImport = false
        } else if (stateBean.isInClass) {
            stateBean.indentLevel = 0
            lineBean.indentLevel = stateBean.indentLevel
            stateBean.isInClass = false
        } else if (stateBean.isInMain) {
            stateBean.indentLevel = 0
            lineBean.indentLevel = stateBean.indentLevel
            stateBean.isInMain = false
        } else {
            lineBean.indentLevel = stateBean.indentLevel
        }
        lineBean.smallBracketDouble = stateBean.smallBracketDouble
        lineBean.middleBracketDouble = stateBean.middleBracketDouble
        lineBean.sharpBracketDouble = stateBean.sharpBracketDouble
        lineBean.isInString = stateBean.isInString
        lineBean.isInMacro = stateBean.isInMacro
        lineBean.isInFor = stateBean.isInFor
        doTryFlag(lineBean)
        doIfFlag(lineBean)
        stateBean.linesList.add(lineBean) //这里保存了一个lineBean了

        //如果这行有return,那么下一行的层级要减1
        if (stateBean.isInRetuen) {
            stateBean.indentLevel--
            stateBean.isInRetuen = false
        } else {
            stateBean.isLastLineReturn = false
        }
        //如果这行有return,那么下一行的层级要减1
        if (stateBean.isInContinue) {
            stateBean.indentLevel--
            stateBean.isInContinue = false
        }
        //如果这行有break,那么下一行的层级要减1
        if (stateBean.isInBreak) {
            stateBean.indentLevel--
            stateBean.isInBreak = false
        }
        //重置infor
        //防止这种情况 for square in squares_gen:
        if (stateBean.isInFor) {
            stateBean.isInFor = false
        }
        stateBean.perLineOutput = StringBuilder()
        stateBean.isLineStart = true
        stateBean.perLineStartIndex = stateBean.currentIndex + 1
        stateBean.lastChar = r';'
        stateBean.currentIndex++
    }

    // 核心格式化函数（整合缩进+换行规则）
    func formatCode(rawCode: String, cfg: FormatConfig): String {
        //每一次的状态变量
        let stateBean: StateBean = StateBean()
        //先把代码分割成诺干行
        stateBean.linesList = ArrayList<LineBean>()
        stateBean.codeChars = rawCode.toRuneArray()
        if (let Some(i) <- stateBean.codeChars) {
            let len = i.size
            if (len == 0) {
                return ""
            }
            while (stateBean.currentIndex < len) {
                let currChar = i[stateBean.currentIndex]
                //没解析完成的话保留在perLineOutput里 //这里相当于处理python的单行注释
                stateBean.perLineOutput.append(currChar)
                if (currChar == r'#' && stateBean.isLineStart) {
                    //处理python单行注释的逻辑
                    dealWithMacro(stateBean)
                    continue
                }

                //处理多行注释
                let res = dealWithMultiLineString(stateBean)
                if (res) {
                    //处理完重新一个字符下来
                    continue
                }

                dealWithString(stateBean)

                //在小括号里:不要换行
                if (!stateBean.isInString) {
                    dealWithSmallBracket(stateBean)
                    dealWithBigBracket(stateBean)
                }

                if (!stateBean.isInString) {
                    dealWithDef(stateBean)
                }
                if (!stateBean.isInString) {
                    dealWithImport(stateBean)
                }
                if (!stateBean.isInString) {
                    dealWithClass(stateBean)
                }
                if (!stateBean.isInString) {
                    dealWithMain(stateBean)
                }
                if (!stateBean.isInString) {
                    dealWithReturn(stateBean)
                }

                if (!stateBean.isInString) {
                    dealWithContinue(stateBean)
                }
                if (!stateBean.isInString) {
                    dealWithBreak(stateBean)
                }
                if (!stateBean.isInString) {
                    dealWithExcept(stateBean)
                }

                if (!stateBean.isInString) {
                    dealWithElif(stateBean)
                }

                if (!stateBean.isInString) {
                    dealWithElse(stateBean)
                }

                if (currChar == r':' && !stateBean.isInMacro && !stateBean.isInString && !stateBean.isInSmallBracket &&
                    !stateBean.isInBigBracket) {
                    //处理冒号逻辑
                    dealWithColon(stateBean)
                    continue
                }
                if (currChar == r';' && !stateBean.isInMacro && !stateBean.isInString) {
                    //处理分号逻辑
                    dealWithSemicolon(stateBean)
                    continue
                }
                if (currChar == r'\n' && !stateBean.isInString) {
                    //进入这里没有进入上面也要加到一行，不然会失去数据
                    dealWithNewLine(stateBean)
                    stateBean.isLineStart = true
                } else {
                    //如果LineStart为true,但是接下来是一些空格开头，那么不应该更改状态
                    if (stateBean.isLineStart && (currChar == r' ' || currChar == r'\t')) {
                        //这种情况依然是isLineStart = true
                        stateBean.isLineStart = true
                    } else {
                        stateBean.isLineStart = false
                    }
                }
                stateBean.lastChar = currChar
                stateBean.currentIndex++
            }
            //在这里处理stateBean.perLineOutput还有剩余数据的问题
            dealWithNewLine(stateBean)

            //这里走完的话就收集到了
            //这里lineList开始处理了

            //如果只有一个换行就过滤
            removeOnlyChangeLine(stateBean)

            //去除一次废弃内容
            removediscard(stateBean)
            //这里修改}后面如果是；就连在一起
            for (i in 0..stateBean.linesList.size) {
                let lineBean: LineBean = stateBean.linesList[i]
                //python的单行逻辑可以理解为cpp的宏
                if (lineBean.codeLine.trimAscii() == ";" && !lineBean.isInMultiString && !lineBean.isInMacro) {
                    //如果当前行是单行注释，那就看他有没有上一行
                    if (i > 0) {
                        //有上一行，看上一行的结束是不是\n
                        let lastLineBean: LineBean = stateBean.linesList[i - 1]
                        //如果这样的话，这一行的内容要加到上一行的后面
                        let stringbuilder: StringBuilder = StringBuilder()
                        stringbuilder.append(lastLineBean.codeLine)
                        stringbuilder.append(lineBean.codeLine)
                        lastLineBean.codeLine = stringbuilder.toString()
                        lineBean.isDiscarded = true
                    }
                }
            }
            //过滤单行废弃
            removediscard(stateBean)

            //处理单行只有);但是上一行是}结尾的情况
            for (i in 0..stateBean.linesList.size) {
                let lineBean: LineBean = stateBean.linesList[i]
                let codeStr = lineBean.codeLine.trimAscii().replace(" ", "")
                //python的单行逻辑可以理解为cpp的宏
                if (codeStr.startsWith(");") && !lineBean.isInMultiString && !lineBean.isInMacro) {
                    //如果当前行是单行注释，那就看他有没有上一行
                    if (i > 0) {
                        //有上一行，看上一行的结束是不是\n
                        let lastLineBean: LineBean = stateBean.linesList[i - 1]
                        if (lastLineBean.codeLine.trimAscii().endsWith("}")) {
                            //上一行以}结尾那么合并这两行
                            //如果这样的话，这一行的内容要加到上一行的后面
                            let stringbuilder: StringBuilder = StringBuilder()
                            stringbuilder.append(lastLineBean.codeLine)
                            stringbuilder.append(lineBean.codeLine)
                            lastLineBean.codeLine = stringbuilder.toString()
                            lineBean.isDiscarded = true
                        }
                    }
                }
            }
            removediscard(stateBean)

            //处理上一行,结尾 下一行是];结尾的情况
            for (i in 0..stateBean.linesList.size) {
                let lineBean: LineBean = stateBean.linesList[i]
                let codeStr = lineBean.codeLine.trimAscii().replace(" ", "")
                if (codeStr.endsWith("]") && !codeStr.contains("[") && !lineBean.isInMultilineComment &&
                    !lineBean.isInSinglelineComment) {
                    //如果当前行是单行注释，那就看他有没有上一行
                    if (i > 0) {
                        //有上一行，看上一行是不是逗号结尾
                        let lastLineBean: LineBean = stateBean.linesList[i - 1]
                        if (lastLineBean.codeLine.trimAscii().endsWith(",")) {
                            //上一行以}结尾那么合并这两行
                            //如果这样的话，这一行的内容要加到上一行的后面
                            let stringbuilder: StringBuilder = StringBuilder()
                            stringbuilder.append(lastLineBean.codeLine.trimAscii())
                            stringbuilder.append(lineBean.codeLine.trimAscii())
                            lastLineBean.codeLine = stringbuilder.toString().replace("\n", "")
                            lineBean.isDiscarded = true
                        }
                    }
                }
            }
            removediscard(stateBean)

            //获得最终的list
            let usefulList: ArrayList<LineBean> = stateBean.linesList
            for (item in usefulList) {
                item.codeLine = item.codeLine.trimAscii()
            }

            //最后根据缩进拼接
            for (index in 0..usefulList.size) {
                let item: LineBean = usefulList[index]
                addIndent(stateBean.output, item.indentLevel, cfg)
                stateBean.output.append(item.codeLine)
                if (index != usefulList.size - 1) {
                    stateBean.output.append("\n")
                }
            }
            return stateBean.output.toString()
        } else {
            return ""
        }
    }
}
