/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */

package markdown.codeformat

class CandCppFormat <: BaseLanguage {

    public override func dealWithNewLine(stateBean: StateBean): Unit {
        if(stateBean.perLineOutput.size > 0){
            let lineBean: LineBean = LineBean()
            lineBean.codeLine = stateBean.perLineOutput.toString()
            lineBean.indentLevel = stateBean.indentLevel
            lineBean.smallBracketDouble = stateBean.smallBracketDouble
            lineBean.middleBracketDouble = stateBean.middleBracketDouble
            lineBean.sharpBracketDouble = stateBean.sharpBracketDouble
            lineBean.isInString = stateBean.isInString
            lineBean.isInMacro = stateBean.isInMacro
            lineBean.isInFor = stateBean.isInFor
            stateBean.linesList.add(lineBean) //这里保存了
            stateBean.perLineOutput = StringBuilder()
            stateBean.perLineStartIndex = stateBean.currentIndex + 1
            stateBean.lastChar = r'\n'
        }
    }

    public override func dealWithLeftBigBracket(stateBean: StateBean): Unit {
        //这里是先把一行选出来
        let lineBean: LineBean = LineBean()
        let lineStartIndex: Int64 = stateBean.perLineStartIndex
        let lineEndIndex: Int64 = stateBean.currentIndex
        let lineCode: String = String(
            stateBean.codeChars.getOrThrow().slice(lineStartIndex, lineEndIndex - lineStartIndex + 1))
        lineBean.codeLine = lineCode
        //记录上一行结束的index
        lineBean.indentLevel = stateBean.indentLevel //当前还是0级
        lineBean.smallBracketDouble = stateBean.smallBracketDouble
        lineBean.middleBracketDouble = stateBean.middleBracketDouble
        lineBean.sharpBracketDouble = stateBean.sharpBracketDouble
        lineBean.isInString = stateBean.isInString
        lineBean.isInMacro = stateBean.isInMacro
        lineBean.isInFor = stateBean.isInFor
        stateBean.linesList.add(lineBean) //这里保存了一个lineBean了
        stateBean.perLineOutput = StringBuilder()
        stateBean.isLineStart = true
        stateBean.indentLevel++ //下一个层级才加1
        stateBean.perLineStartIndex = stateBean.currentIndex + 1
        stateBean.lastChar = r'{'
        stateBean.currentIndex++
    }

    public override func dealWithRightBigBracket(stateBean: StateBean): Unit {
        //这里是先把一行选出来
        let lineBean: LineBean = LineBean()
        let lineStartIndex: Int64 = stateBean.perLineStartIndex
        let lineEndIndex: Int64 = stateBean.currentIndex
        let lineCode: String = String(
            stateBean.codeChars.getOrThrow().slice(lineStartIndex, lineEndIndex - lineStartIndex + 1))
        lineBean.codeLine = lineCode
        //记录上一行结束的index
        stateBean.indentLevel--
        lineBean.indentLevel = stateBean.indentLevel //当前层级是减去一层后的了
        lineBean.smallBracketDouble = stateBean.smallBracketDouble
        lineBean.middleBracketDouble = stateBean.middleBracketDouble
        lineBean.sharpBracketDouble = stateBean.sharpBracketDouble
        lineBean.isInString = stateBean.isInString
        lineBean.isInMacro = stateBean.isInMacro
        lineBean.isInFor = stateBean.isInFor
        stateBean.linesList.add(lineBean) //这里保存了一个lineBean了
        stateBean.perLineOutput = StringBuilder()
        stateBean.isLineStart = true
        stateBean.perLineStartIndex = stateBean.currentIndex + 1
        stateBean.lastChar = r'}'
        stateBean.currentIndex++
    }

    public override func dealWithSingleLineComment(stateBean: StateBean): Unit {
        stateBean.isInSinglelineComment = true
        let lineBean: LineBean = LineBean()
        let lineStartIndex: Int64 = stateBean.currentIndex
        var currChar: Rune = stateBean.codeChars.getOrThrow()[stateBean.currentIndex] //中的第二个/

        //往前循环看看有多少空格
        var beforeSpaceCount: Int64 = 0
        var beforeSpaceIndex = stateBean.currentIndex - 2 //第一个/开始 再前面一个是/的前面一个
        while (beforeSpaceIndex >= 0 && stateBean.codeChars.getOrThrow()[beforeSpaceIndex] == r' ') {
            beforeSpaceCount++
            beforeSpaceIndex--
        }
        // //单行前面是不是换行 判断这个单行注释是不是单独一行
        var tempSingleLineAfterChangLine: Bool = false
        if (beforeSpaceIndex < 0) { //值为-1
            //表示是第一行
            tempSingleLineAfterChangLine = true
        } else {
            let char: Rune = stateBean.codeChars.getOrThrow()[beforeSpaceIndex]
            if (char == r'\n') {
                tempSingleLineAfterChangLine = true
            } else {
                tempSingleLineAfterChangLine = false
            }
        }
        //上面是往前遍历  下面是往后遍历
        while (currChar != r'\n') {
            if(stateBean.currentIndex == stateBean.codeChars.getOrThrow().size - 1){
                break
            }
            stateBean.currentIndex++
            currChar = stateBean.codeChars.getOrThrow()[stateBean.currentIndex]
            stateBean.perLineOutput.append(currChar)
        }
        let lineEndIndex: Int64 = stateBean.currentIndex
        //从前面那个/算起     /012 //012
        let lineCode: String = String(
            stateBean.codeChars.getOrThrow().slice(lineStartIndex - 1, lineEndIndex - lineStartIndex + 1 + 1))
        lineBean.codeLine = lineCode
        //单行注释的缩进和StateBean一致
        lineBean.indentLevel = stateBean.indentLevel
        lineBean.smallBracketDouble = stateBean.smallBracketDouble
        lineBean.middleBracketDouble = stateBean.middleBracketDouble
        lineBean.sharpBracketDouble = stateBean.sharpBracketDouble
        lineBean.isInString = stateBean.isInString
        lineBean.isInMacro = stateBean.isInMacro
        lineBean.isInFor = stateBean.isInFor
        lineBean.isInSinglelineComment = stateBean.isInSinglelineComment
        lineBean.singleLineWhiteSpace = beforeSpaceCount
        lineBean.singlelineCommentisAfterChangline = tempSingleLineAfterChangLine
        stateBean.linesList.add(lineBean) //这里保存了一个lineBean了
        stateBean.perLineOutput = StringBuilder()
        stateBean.isLineStart = true
        stateBean.perLineStartIndex = stateBean.currentIndex + 1
        stateBean.lastChar = r'\n'
        stateBean.currentIndex++
        stateBean.isInSinglelineComment = false
    }

    public override func dealWithMultiLineComment(stateBean: StateBean): Unit {
        stateBean.isInMultilineComment = true
        let lineStartIndex: Int64 = stateBean.currentIndex
        var currChar: Rune = stateBean.codeChars.getOrThrow()[stateBean.currentIndex] // /*中的*
        var lastChar: Rune = r'/'
        //往前循环看看有多少空格
        var beforeSpaceCount: Int64 = 0
        var beforeSpaceIndex = stateBean.currentIndex - 2 //第一个*开始 再前面一个是/
        while (beforeSpaceIndex >= 0 && stateBean.codeChars.getOrThrow()[beforeSpaceIndex] == r' ') {
            beforeSpaceCount++
            beforeSpaceIndex--
        }
        // //多行第一行前面是不是换行 判断这个多行第一行注释是不是单独一行
        var tempMultiLineAfterChangLine: Bool = false
        if (beforeSpaceIndex < 0) { //值为-1
            //表示是第一行
            tempMultiLineAfterChangLine = true
        } else {
            let char: Rune = stateBean.codeChars.getOrThrow()[beforeSpaceIndex]
            if (char == r'\n') {
                tempMultiLineAfterChangLine = true
            } else {
                tempMultiLineAfterChangLine = false
            }
        }
        //这个跟单行注释不一样 如果前面有内容就只加一个 空格
        /* 
         asdsad
         */
        while (!(lastChar == r'*' && currChar == r'/')) {
            if(stateBean.currentIndex == stateBean.codeChars.getOrThrow().size - 1){
                break
            }
            stateBean.currentIndex++
            stateBean.perLineOutput.append(currChar)
            currChar = stateBean.codeChars.getOrThrow()[stateBean.currentIndex]
            lastChar = stateBean.codeChars.getOrThrow()[stateBean.currentIndex - 1]
        }
        //到这里就是结束的Index了
        let lineEndIndex: Int64 = stateBean.currentIndex
        let lineCodeAll: String = String(
            stateBean.codeChars.getOrThrow().slice(lineStartIndex - 1, lineEndIndex - lineStartIndex + 1 + 1))
        //然后这里面的内容根据\n分为几行 解析为几个LineBean
        let lineCodeList: Array<String> = lineCodeAll.split("\n")
        for (index in 0..lineCodeList.size) {
            let lineBean: LineBean = LineBean()
            lineBean.codeLine = lineCodeList[index]
            if (index == 0) {
                lineBean.isFirstMultiCommentLine = true
                lineBean.mutlilineCommentisAfterChangline = tempMultiLineAfterChangLine
            }
            //多行注释的缩进和StateBean一致
            lineBean.indentLevel = stateBean.indentLevel
            lineBean.smallBracketDouble = stateBean.smallBracketDouble
            lineBean.middleBracketDouble = stateBean.middleBracketDouble
            lineBean.sharpBracketDouble = stateBean.sharpBracketDouble
            lineBean.isInString = stateBean.isInString
            lineBean.isInMacro = stateBean.isInMacro
            lineBean.isInFor = stateBean.isInFor
            lineBean.isInMultilineComment = stateBean.isInMultilineComment
            //多行的时候跟单行注释不一样 如果前面有内容就只加一个 空格
            stateBean.linesList.add(lineBean)
            stateBean.perLineOutput = StringBuilder()
        }
        stateBean.isLineStart = true
        stateBean.perLineStartIndex = stateBean.currentIndex + 1
        stateBean.lastChar = r'\n'
        stateBean.currentIndex++
        stateBean.isInMultilineComment = false
    }

    public override func dealWithMacro(stateBean: StateBean): Unit {
        stateBean.isInMacro = true
        let lineBean: LineBean = LineBean()
        let lineStartIndex: Int64 = stateBean.currentIndex
        var currChar: Rune = stateBean.codeChars.getOrThrow()[stateBean.currentIndex] //#
        while (currChar != r'\n') {
            if(stateBean.currentIndex == stateBean.codeChars.getOrThrow().size - 1){
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
        lineBean.indentLevel = 0 //宏没有缩进
        lineBean.smallBracketDouble = stateBean.smallBracketDouble
        lineBean.middleBracketDouble = stateBean.middleBracketDouble
        lineBean.sharpBracketDouble = stateBean.sharpBracketDouble
        lineBean.isInString = stateBean.isInString
        lineBean.isInMacro = stateBean.isInMacro
        lineBean.isInFor = stateBean.isInFor
        stateBean.linesList.add(lineBean) //这里保存了一个lineBean了
        stateBean.perLineOutput = StringBuilder()
        stateBean.isLineStart = true
        stateBean.perLineStartIndex = stateBean.currentIndex + 1
        stateBean.lastChar = r'\n'
        stateBean.currentIndex++
        stateBean.isInMacro = false
    }

    public override func dealWithAccessPublic(stateBean: StateBean): Bool {
        let notNullChar: Array<Rune> = stateBean.codeChars.getOrThrow()
        let currentIndex: Int64 = stateBean.currentIndex
        if (notNullChar.size > currentIndex + 6) {
            if (notNullChar[currentIndex] == r'p' && notNullChar[currentIndex + 1] == r'u'
                && notNullChar[currentIndex + 2] == r'b' && notNullChar[currentIndex + 3] == r'l'
                && notNullChar[currentIndex + 4] == r'i' && notNullChar[currentIndex + 5] == r'c' &&
                notNullChar[currentIndex + 6] == r':') {
                stateBean.isInAccessFlag = true
                let lineBean: LineBean = LineBean()
                let lineCode: String = "public:"
                lineBean.codeLine = lineCode
                lineBean.indentLevel = 0 //访问修饰符没有缩进
                lineBean.smallBracketDouble = stateBean.smallBracketDouble
                lineBean.middleBracketDouble = stateBean.middleBracketDouble
                lineBean.sharpBracketDouble = stateBean.sharpBracketDouble
                lineBean.isInString = stateBean.isInString
                lineBean.isInMacro = stateBean.isInMacro
                lineBean.isInFor = stateBean.isInFor
                stateBean.linesList.add(lineBean) //这里保存了一个lineBean了
                stateBean.perLineOutput = StringBuilder()
                stateBean.isLineStart = true
                stateBean.perLineStartIndex = stateBean.currentIndex + 6 + 1
                stateBean.isInAccessFlag = false
                stateBean.lastChar = r'\n'
                stateBean.currentIndex += 7
                return true
            } else {
                return false
            }
        }
        return false
    }

    public override func dealWithAccessPrivate(stateBean: StateBean): Bool {
        let notNullChar: Array<Rune> = stateBean.codeChars.getOrThrow()
        let currentIndex: Int64 = stateBean.currentIndex
        if (notNullChar.size > currentIndex + 7) {
            if (notNullChar[currentIndex] == r'p' && notNullChar[currentIndex + 1] == r'r' &&
                notNullChar[currentIndex + 2] == r'i' && notNullChar[currentIndex + 3] == r'v' &&
                notNullChar[currentIndex + 4] == r'a' && notNullChar[currentIndex + 5] == r't' &&
                notNullChar[currentIndex + 6] == r'e' && notNullChar[currentIndex + 7] == r':') {
                stateBean.isInAccessFlag = true
                let lineBean: LineBean = LineBean()
                let lineCode: String = "private:"
                lineBean.codeLine = lineCode
                lineBean.indentLevel = 0 //访问修饰符没有缩进
                lineBean.smallBracketDouble = stateBean.smallBracketDouble
                lineBean.middleBracketDouble = stateBean.middleBracketDouble
                lineBean.sharpBracketDouble = stateBean.sharpBracketDouble
                lineBean.isInString = stateBean.isInString
                lineBean.isInMacro = stateBean.isInMacro
                lineBean.isInFor = stateBean.isInFor
                stateBean.linesList.add(lineBean) //这里保存了一个lineBean了
                stateBean.perLineOutput = StringBuilder()
                stateBean.isLineStart = true
                stateBean.perLineStartIndex = stateBean.currentIndex + 7 + 1
                stateBean.isInAccessFlag = false
                stateBean.lastChar = r'\n'
                stateBean.currentIndex += 8
                return true
            } else {
                return false
            }
        }
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

    public override func dealWithFor(stateBean: StateBean): Unit {
        let notNullChar: Array<Rune> = stateBean.codeChars.getOrThrow()
        let currentIndex: Int64 = stateBean.currentIndex
        if (currentIndex >= 2) {
            if (notNullChar[currentIndex - 2] == r'f' && notNullChar[currentIndex - 1] == r'o' &&
                notNullChar[currentIndex] == r'r') {
                stateBean.isInFor = true
            }
        }
        if (stateBean.isInFor) {
            let currChar: Rune = notNullChar[currentIndex]
            if (currChar == r'(') { //主要是用于for循环中的()成对
                stateBean.smallBracketDouble++
            }
            if (currChar == r')') {
                stateBean.smallBracketDouble--
                if (stateBean.smallBracketDouble == 0) { //这里表示走出了for的)括号
                    stateBean.isInFor = false
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
        lineBean.indentLevel = stateBean.indentLevel
        lineBean.smallBracketDouble = stateBean.smallBracketDouble
        lineBean.middleBracketDouble = stateBean.middleBracketDouble
        lineBean.sharpBracketDouble = stateBean.sharpBracketDouble
        lineBean.isInString = stateBean.isInString
        lineBean.isInMacro = stateBean.isInMacro
        lineBean.isInFor = stateBean.isInFor
        stateBean.linesList.add(lineBean) //这里保存了一个lineBean了
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
                //没解析完成的话保留在perLineOutput里
                stateBean.perLineOutput.append(currChar)
                if (currChar == r'#' && stateBean.isLineStart) {
                    //处理宏的逻辑
                    dealWithMacro(stateBean)
                    continue
                }
                //处理private: public: protected:
                if (stateBean.isLineStart) {
                    if (dealWithAccessPublic(stateBean)) {
                        continue
                    }
                    if (dealWithAccessPrivate(stateBean)) {
                        continue
                    }
                }
                //处理单行注释
                if (currChar == r'/' && stateBean.lastChar == r'/' && !stateBean.isInString) {
                    dealWithSingleLineComment(stateBean)
                    continue
                }
                //处理多行注释
                if (currChar == r'*' && stateBean.lastChar == r'/' && !stateBean.isInString) {
                    dealWithMultiLineComment(stateBean)
                    continue
                }
                dealWithString(stateBean)
                if (!stateBean.isInString) {
                    dealWithFor(stateBean)
                }
                if (currChar == r'{' && !stateBean.isInMacro && !stateBean.isInString && !stateBean.isInFor) {
                    //处理左大括号逻辑
                    dealWithLeftBigBracket(stateBean)
                    continue
                }
                if (currChar == r'}' && !stateBean.isInMacro && !stateBean.isInString && !stateBean.isInFor) {
                    //处理右大括号逻辑
                    dealWithRightBigBracket(stateBean)
                    continue
                }
                if (currChar == r';' && !stateBean.isInMacro && !stateBean.isInString && !stateBean.isInFor) {
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


            //  for(item in stateBean.linesList){
            //      println("${item.codeLine.replace("\n","\\n")}")
            //      println("================item.indentLevel=${item.indentLevel}=====================")
            //  }

            //这里走完的话就收集到了
            //println("size=${stateBean.linesList.size}")
            //这里lineList开始处理了
            //处理单行注释合并问题
            for (i in 0..stateBean.linesList.size) {
                let lineBean: LineBean = stateBean.linesList[i]
                if (lineBean.isInSinglelineComment) {
                    //如果当前行是单行注释，那就看他有没有上一行
                    if (i > 0) {
                        //有上一行，看上一行的结束是不是\n
                        let lastLineBean: LineBean = stateBean.linesList[i - 1]
                        if (!lineBean.singlelineCommentisAfterChangline) {
                            //如果这样的话，这一行的内容要加到上一行的后面
                            let stringbuilder: StringBuilder = StringBuilder()
                            stringbuilder.append(lastLineBean.codeLine)
                            for (j in 0..lineBean.singleLineWhiteSpace) {
                                stringbuilder.append(" ")
                            }
                            stringbuilder.append(lineBean.codeLine)
                            lastLineBean.codeLine = stringbuilder.toString()
                            lineBean.isDiscarded = true
                        }
                    }
                }
            }
            //处理多行注释合并问题
            for (i in 0..stateBean.linesList.size) {
                let lineBean: LineBean = stateBean.linesList[i]
                if (lineBean.isInMultilineComment && lineBean.isFirstMultiCommentLine) {
                    //如果当前行是单行注释，那就看他有没有上一行
                    if (i > 0) {
                        //有上一行，看上一行的结束是不是\n
                        let lastLineBean: LineBean = stateBean.linesList[i - 1]
                        //println("tempCodeLine=${tempCodeLine}")
                        if (!lineBean.mutlilineCommentisAfterChangline) {
                            //如果这样的话，这一行的内容要加到上一行的后面
                            let stringbuilder: StringBuilder = StringBuilder()
                            stringbuilder.append(lastLineBean.codeLine)
                            //多行前面有内容 只要隔个一个空格
                            stringbuilder.append(" ")
                            stringbuilder.append(lineBean.codeLine)
                            lastLineBean.codeLine = stringbuilder.toString()
                            lineBean.isDiscarded = true
                        }
                    }
                }
            }
            //  for(item in stateBean.linesList){
            //      println("${item.codeLine.replace("\n","\\n")}")
            //      println("================item.isDiscarded=${item.isDiscarded}=====================")
            //  }

            //如果只有一个换行就过滤
            removeOnlyChangeLine(stateBean)    
            //这里处理如果}前面还有内容就和上一行连在一起解决数组中的{}问题
            for (i in 0..stateBean.linesList.size) {
                let lineBean: LineBean = stateBean.linesList[i]
                if (lineBean.codeLine.trimAscii().endsWith("}") && lineBean.codeLine.trimAscii().size > 1 &&
                    !lineBean.isInMultilineComment && !lineBean.isInSinglelineComment) {
                    if (i > 0) {
                        let lastLineBean: LineBean = stateBean.linesList[i - 1]
                        //如果这样的话，这一行的内容要加到上一行的后面
                        let stringbuilder: StringBuilder = StringBuilder()
                        stringbuilder.append(lastLineBean.codeLine)
                        //多行前面有内容 只要隔个一个空格
                        stringbuilder.append(lineBean.codeLine.trimAscii())
                        lastLineBean.codeLine = stringbuilder.toString()
                        lineBean.isDiscarded = true
                    }
                }
            }
            //去除一次废弃内容
            removediscard(stateBean)
            //这里修改{后面如果是；就连在一起
            for (i in 0..stateBean.linesList.size) {
                let lineBean: LineBean = stateBean.linesList[i]
                if (lineBean.codeLine.trimAscii() == ";") {
                    //如果当前行是单行注释，那就看他有没有上一行
                    if (i > 0) {
                        //有上一行，看上一行的结束是不是\n
                        let lastLineBean: LineBean = stateBean.linesList[i - 1]
                        //println("tempCodeLine=${tempCodeLine}")
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
            //获得最终的list
            let usefulList: ArrayList<LineBean> = stateBean.linesList
            for (item in usefulList) {
                item.codeLine = item.codeLine.trimAscii()
            }
            //修改#开始的宏和后面空格不一致问题
            modifyMacroAndSpace(stateBean)   

            //  for(item in stateBean.linesList){
            //      println("${item.codeLine.replace("\n","\\n")}")
            //      println("================item.indentLevel=${item.indentLevel}=====================")
            //  }


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
