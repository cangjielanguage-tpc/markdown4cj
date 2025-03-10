/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.plugin

class LatexBlockParser <: AbstractBlockParser {
    private let block: LatexMathBlock = LatexMathBlock()
    private let builder: StringBuilder = StringBuilder()

    public func getBlock(): Block {
        block
    }

    public func tryContinue(parserState: ParserState): ?BlockContinue {
        let line = parserState.getLine()
        if (isLatexLine(line)) {
            block.isBroken = true
        }
        if (isLatexEnd(line)) {
            block.isClosed = true
            block.isBroken = false
        }
        return if (block.isClosed) {
            BlockContinue.finished()
        } else {
            BlockContinue.atIndex(parserState.getIndex())
        }
    }

    public func addLine(line: String): Unit {
        if (builder.size > 0) {
            builder.append('\n')
        }
        if (block.isClosed) {
            let str = line.trimAsciiRight()
            builder.append(str[..str.size - 2])
        } else {
            builder.append(line)
        }
    }

    public func closeBlock(): Unit {
        block.latex = builder.toString()
    }
}

class LatexBlockParserFactory <: AbstractBlockParserFactory {
    public func tryStart(state: ParserState, _: MatchedBlockParser): ?BlockStart {
        let line: String = state.getLine()
        if (line == "$$" || line == "\\[" || isLatexInList(line)) {
            return BlockStart.of4Cj(LatexBlockParser()).atIndex(state.getIndex() + 2)
        }
        return BlockStart.none()
    }
}

func isLatexLine(line: String): Bool {
    let str = line.replace(#"\$"#, "")
    if (let Some(i) <- str.indexOf("$")) {
        if (i != str.size - 2) {
            return false
        }
    }
    if (let Some(i) <- str.indexOf("$$")) {
        if (i != str.size - 2) {
            return false
        }
    }
    return true
}

func isLatexEnd(lineStr: String): Bool {
    // let reg = Regex(#"[^\\]?\$\$$"#)
    let line = lineStr.trimAscii()
    let size = line.size
    return match {
        case size < 2 => false
        case size == 2 && line == "$$" || line == "\\]" => true
        case size > 2 && line[size - 1] == b'$' && line[size - 2] == b'$' && line[size - 3] != b'\\' => true
        case size > 2 && line[size - 1] == b']' && line[size - 2] == b'\\' && line[size - 3] != b'\\' => true
        case _ => false
    }
}

let LATEX_IN_LIST = Regex(#"(\d+\.|-|>) (\$\$|\\\[)"#)

func isLatexInList(line: String): Bool {
    let str = line.trimAscii()
    if (str == "$$" || str == "\\[") {
        return true
    }
    return LATEX_IN_LIST.matches(str).isSome()
}

type CharSequence = String

type CharSeqCell = Byte
