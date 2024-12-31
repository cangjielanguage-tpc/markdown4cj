/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.plugin

class LatexBlockParser <: AbstractBlockParser {
    private let block: LatexMathBlock = LatexMathBlock()
    private let builder: ArrayList<Byte> = ArrayList<Byte>()

    public func getBlock(): Block {
        block
    }

    public func tryContinue(parserState: ParserState): ?BlockContinue {
        let line = parserState.getLine()
        if (isLatexLine(line)) {
            block.isBroken = true
        }
        return if (block.isClosed) {
            BlockContinue.finished()
        } else {
            BlockContinue.atIndex(parserState.getIndex())
        }
    }

    public func addLine(line: String): Unit {
        if (builder.size > 0) {
            builder.append(UInt8(UInt32(r'\n')))
        }
        builder.appendAll(line)
        if (isLatexEnd(line)) {
            builder.remove(builder.size - 1)
            builder.remove(builder.size - 1)
            block.isClosed = true
        }
    }

    public func closeBlock(): Unit {
        block.latex = unsafe { String.fromUtf8Unchecked(builder.getRawArray()[..builder.size]) }
    }
}

class LatexBlockParserFactory <: AbstractBlockParserFactory {
    public func tryStart(state: ParserState, _: MatchedBlockParser): ?BlockStart {
        let line: String = state.getLine()
        if (line == "$$") {
            return BlockStart.of4Cj(LatexBlockParser()).atIndex(state.getIndex() + 2)
        } else {
            var i = 0
            while (i < line.size) {
                if (line[i] != b' ') {
                    break
                }
                i++
            }
            if (line.size > i + 1 && line[i] == b'$' && line[i + 1] == b'$') {
                if (line.size > i + 2 && line[i + 2] == b'$') {
                    return BlockStart.none()
                }
                return BlockStart.of4Cj(LatexBlockParser()).atIndex(state.getIndex() + i + 2)
            }
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
        case size == 2 && line == "$$" => true
        case size > 2 && line[size - 1] == b'$' && line[size - 2] == b'$' && line[size - 3] != b'\\' => true
        case _ => false
    }
}

type CharSequence = String

type CharSeqCell = Byte
