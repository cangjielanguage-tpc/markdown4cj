/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.plugin

import std.reflect.*

public class DescListPlugin <: AbstractMarkdownPlugin {
    public static func create(): DescListPlugin {
        return DescListPlugin()
    }
    public func configureParser(builder: ParserBuilder): Unit {
        builder.customBlockParserFactory(DescListParserFactory())
    }

    public func configureVisitor(builder: MarkdownVisitorBuilder): Unit {
    }

    public func getClassType(): String {
        "DescListPlugin"
    }
}

class DescListParserFactory <: BlockParserFactory {
    public func tryStart(state: ParserState, matchedBlockParser: MatchedBlockParser): Option<BlockStart> {
        var indent: Int64 = state.getIndent()
        if (state.getIndent() >= Parsing.CODE_BLOCK_INDENT) {
            return BlockStart.none()
        }
        let paragraphLines = matchedBlockParser.getParagraphContent() ?? return None
        let line = state.getLine().trimLeft()
        if (line.startsWith(": ")) {
            return BlockStart.of4Cj(DescListParser(paragraphLines)).replaceActiveBlockParser()
        }
        return BlockStart.none()
    }
}

class DescListParser <: AbstractBlockParser {
    let block = DescList()
    let ddstr = ArrayList<String>()
    DescListParser(let dt: String) {}
    public func getBlock(): Block {
        return block
    }
    public func addLine(line: String): Unit {
        let lineTrim = line.trimLeft()
        if (lineTrim.size > 2 && lineTrim.startsWith(": ")) {
            ddstr.add(lineTrim[2..])
        } else if (!line.isBlank()) {
            let lastIndex = ddstr.size - 1
            var str = ddstr[lastIndex]
            ddstr[lastIndex] = "${str}\n${lineTrim}"
        }
    }
    public func tryContinue(state: ParserState): Option<BlockContinue> {
        if (state.isBlank()) {
            return BlockContinue.none()
        } else {
            return BlockContinue.atIndex(state.getIndex())
        }
    }
    public func closeBlock(): Unit {
    }
    public func parseInlines(inlineParser: InlineParser): Unit {
        let p = Paragraph()
        inlineParser.parse(dt, p)
        let dtNode = DescTerm()
        dtNode.appendChild(p)
        block.appendChild(dtNode)
        for (dd in ddstr) {
            let p = Paragraph()
            inlineParser.parse(dd, p)
            let ddNode = DescDef()
            ddNode.appendChild(p)
            block.appendChild(ddNode)
        }
    }
}

/* dl */
public class DescList <: CustomBlock {
    public func getNodeType(): String {
        return "DescList"
    }
}
/* dt */
public class DescTerm <: CustomBlock {
    public func getNodeType(): String {
        return "DescTerm"
    }
}
/* dd */
public class DescDef <: CustomBlock {
    public func getNodeType(): String {
        return "DescDef"
    }
}
