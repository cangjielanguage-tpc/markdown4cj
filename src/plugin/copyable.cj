package markdown_parser.plugin

/**
 * 可复制的节点：生成一个携带自身属性（但不含链接与子节点）的独立副本。
 *
 * <p>用于支持 {@link Node#splitParent()}，分割时需要复制父节点以重新分配子节点。
 * 内置节点类型大多通过本文件中的 extend 实现；用户自定义的 CustomNode/CustomBlock
 * 子类如需被分割，可在此集中实现。
 *
 * <p>孤儿规则：扩展须与被扩展类型或接口同包。SubNode/SupNode/UnderlineNode 位于
 * markdown.plugin，故本接口（Copyable）与全部实现集中放在此处，避免跨包孤儿扩展
 * 及 core↔plugin 循环依赖。
 */
public interface Copyable {
    func copy(): Node
}

extend Text <: Copyable {
    public func copy(): Node {
        Text(getLiteral())
    }
}

extend HtmlInline <: Copyable {
    public func copy(): Node {
        HtmlInline(getLiteral())
    }
}

extend Image <: Copyable {
    public func copy(): Node {
        Image(getDestination(), getTitle())
    }
}

extend Code <: Copyable {
    public func copy(): Node {
        Code(getLiteral())
    }
}

extend HardLineBreak <: Copyable {
    public func copy(): Node {
        HardLineBreak()
    }
}

extend SoftLineBreak <: Copyable {
    public func copy(): Node {
        SoftLineBreak()
    }
}

extend Link <: Copyable {
    public func copy(): Node {
        Link(getDestination(), getTitle())
    }
}

extend StrongEmphasis <: Copyable {
    public func copy(): Node {
        let copy = StrongEmphasis()
        match (getOpeningDelimiter()) {
            case Some(delimiter) => copy.setDelimiter(delimiter)
            case None => ()
        }
        copy
    }
}

extend Emphasis <: Copyable {
    public func copy(): Node {
        let copy = Emphasis()
        match (getOpeningDelimiter()) {
            case Some(delimiter) => copy.setDelimiter(delimiter)
            case None => ()
        }
        copy
    }
}

extend BlockQuote <: Copyable {
    public func copy(): Node {
        BlockQuote()
    }
}

extend HtmlBlock <: Copyable {
    public func copy(): Node {
        let copy = HtmlBlock()
        copy.setLiteral(getLiteral())
        copy
    }
}

extend ThematicBreak <: Copyable {
    public func copy(): Node {
        ThematicBreak()
    }
}

extend Document <: Copyable {
    public func copy(): Node {
        Document()
    }
}

extend Paragraph <: Copyable {
    public func copy(): Node {
        Paragraph()
    }
}

extend IndentedCodeBlock <: Copyable {
    public func copy(): Node {
        let copy = IndentedCodeBlock()
        copy.setLiteral(getLiteral())
        copy
    }
}

extend FencedCodeBlock <: Copyable {
    public func copy(): Node {
        let copy = FencedCodeBlock()
        copy.setFenceChar(getFenceChar())
        copy.setFenceLength(getFenceLength())
        copy.setFenceIndent(getFenceIndent())
        copy.setInfo(getInfo())
        copy.setLiteral(getLiteral())
        copy
    }
}

extend ListItem <: Copyable {
    public func copy(): Node {
        ListItem()
    }
}

extend Heading <: Copyable {
    public func copy(): Node {
        let copy = Heading()
        copy.setLevel(getLevel())
        copy
    }
}

extend BulletList <: Copyable {
    public func copy(): Node {
        let copy = BulletList(getBulletMarker())
        copy.setTight(isTight())
        copy
    }
}

extend OrderedList <: Copyable {
    public func copy(): Node {
        let copy = OrderedList(getStartNumber(), getDelimiter())
        copy.setTight(isTight())
        copy
    }
}

extend LinkReferenceDefinition <: Copyable {
    public func copy(): Node {
        let copy = LinkReferenceDefinition()
        match (getLabel()) {
            case Some(label) => copy.setLabel(label)
            case None => ()
        }
        copy.setDestination(getDestination())
        match (getTitle()) {
            case Some(title) => copy.setTitle(title)
            case None => ()
        }
        copy
    }
}

extend Strikethrough <: Copyable {
    public func copy(): Node {
        var delimiter = "~~"
        match (getOpeningDelimiter()) {
            case Some(v) => delimiter = v
            case None => ()
        }
        Strikethrough(delimiter)
    }
}

extend SubNode <: Copyable {
    public func copy(): Node {
        SubNode()
    }
}

extend SupNode <: Copyable {
    public func copy(): Node {
        SupNode()
    }
}

extend UnderlineNode <: Copyable {
    public func copy(): Node {
        UnderlineNode()
    }
}