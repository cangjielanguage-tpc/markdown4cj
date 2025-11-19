/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.plugin

/**
 * 根据节点的内容计算节点的id
 */
public interface NodeHash {
    func propString(): String
}

extend HtmlInline <: NodeHash {
    public func propString(): String {
        toString() + getLiteral()
    }
}

extend Code <: NodeHash {
    public func propString(): String {
        toString() + getLiteral()
    }
}

extend LinkReferenceDefinition <: NodeHash {
    public func propString(): String {
        toString() + '${getLabel()}${getDestination()}${getTitle()}'
    }
}

extend StrongEmphasis <: NodeHash {
    public func propString(): String {
        toString() + '${getOpeningDelimiter()}${getClosingDelimiter()}'
    }
}

extend Emphasis <: NodeHash {
    public func propString(): String {
        toString() + '${getOpeningDelimiter()}${getClosingDelimiter()}'
    }
}

extend HtmlBlock <: NodeHash {
    public func propString(): String {
        toString() + getLiteral()
    }
}

extend IndentedCodeBlock <: NodeHash {
    public func propString(): String {
        toString() + getLiteral()
    }
}

extend FencedCodeBlock <: NodeHash {
    public func propString(): String {
        toString() + "${getFenceChar()}${getFenceLength()}${getFenceIndent()}${getInfo()}${getLiteral()}"
    }
}

extend Heading <: NodeHash {
    public func propString(): String {
        toString() + "${getLevel()}"
    }
}

extend BulletList <: NodeHash {
    public func propString(): String {
        toString() + "${isTight()}${getBulletMarker()}"
    }
}

extend OrderedList <: NodeHash {
    public func propString(): String {
        toString() + "${isTight()}${getStartNumber()}${getDelimiter()}"
    }
}

extend Strikethrough <: NodeHash {
    public func propString(): String {
        toString() + "${getOpeningDelimiter()}${getClosingDelimiter()}"
    }
}

extend TableCell <: NodeHash {
    public func propString(): String {
        let getAlignment = match (getAlignment()) {
            case Some(LEFT) => "LEFT"
            case Some(CENTER) => "CENTER"
            case Some(RIGHT) => "RIGHT"
            case _ => ""
        }
        toString() + "${isHeader()}${getAlignment}"
    }
}

extend ImageHtmlNode <: NodeHash {
    public func propString(): String {
        toString() + "${getDestination()}${getWidth()}${getHeight()}"
    }
}

extend FontNode <: NodeHash {
    public func propString(): String {
        toString() + "${getColor()}${getSize()}"
    }
}

extend HeadTree <: NodeHash {
    public func propString(): String {
        toString() + "${item}${item_p}${item_list.propString()}"
    }
}
