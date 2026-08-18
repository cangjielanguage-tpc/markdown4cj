package markdown_parser.plugin
import ohos.hilog.Hilog

public class BlockCustomCardPlugin <: AbstractMarkdownPlugin {
    var mBlockImage: ?(CardBean) -> Bool = None
    var mBlockLink: ?(CardBean) -> Bool = None

    init(blockImage: ?(CardBean) -> Bool, blockLink: ?(CardBean) -> Bool) {
        this.mBlockImage = blockImage
        this.mBlockLink = blockLink
    }

    public static func create(blockImage!: ?(CardBean) -> Bool = None, blockLink!: ?(CardBean) -> Bool = None): BlockCustomCardPlugin {
        return BlockCustomCardPlugin(blockImage, blockLink)
    }

    public func getClassType(): String {
        "BlockCustomCardPlugin"
    }

    public override func configureParser(builder: ParserBuilder): Unit {
        builder.postProcessor(BlockCustomCardProcessor(mBlockImage, mBlockLink))
    }
}

class BlockCustomCardProcessor <: PostProcessor {
    var mBlockImage: ?(CardBean) -> Bool = None
    var mBlockLink: ?(CardBean) -> Bool = None

    init(blockImage: ?(CardBean) -> Bool, blockLink: ?(CardBean) -> Bool) {
        this.mBlockImage = blockImage
        this.mBlockLink = blockLink
    }

    public func process(node: Node): Node {
        node.accept(BlockCustomCardVisitor(mBlockImage, mBlockLink))
        node
    }
}

func getAltText(n: Node): String {
    let altTextBuilder = StringClass()
    n.iterateChildren().forEach({
        child: Node => if (child is Text) {
            altTextBuilder.addString((child as Text)().getLiteral())
        }
    })
    let altText = altTextBuilder.str.trimAscii()
    return altText
}

func ImgNodeToCardBean(n: Node): CardBean {
    let description: String = getAltText(n)
    let destination = (n as Image)().getDestination()
    let title = (n as Image)().getTitle()
    return CardBean(description, destination, title)
}

func LinkNodeToCardBean(n: Node): CardBean {
    let description: String = getLinkString(StringClass(), n)
    let destination = (n as Link)().getDestination()
    let title = (n as Link)().getTitle()
    return CardBean(description, destination, title)
}

func isRightImg(n: Node, blockImage: ?(CardBean) -> Bool): Bool {
    if (let Some(v) <- blockImage) {
        return v(ImgNodeToCardBean(n))
    }
    return false
}

func isRightLink(n: Node, blockLink: ?(CardBean) -> Bool): Bool {
    if (let Some(v) <- blockLink) {
        return v(LinkNodeToCardBean(n))
    }
    return false
}

class BlockCustomCardVisitor <: AbstractVisitor {
    var mBlockImage: ?(CardBean) -> Bool = None
    var mBlockLink: ?(CardBean) -> Bool = None

    init(blockImage: ?(CardBean) -> Bool, blockLink: ?(CardBean) -> Bool) {
        this.mBlockImage = blockImage
        this.mBlockLink = blockLink
    }

    public func visit(p: Heading): Unit {
        refactorWithSplit(p)
    }
    public func visit(p: Paragraph): Unit {
        refactorWithSplit(p)
    }
    public func visit(n: CustomNode): Unit {
        if (let c: TableCell <- n) {
            refactorTableCell(c)
        } else {
            visitChildren(n)
        }
    }
    // 判断是否为card, 返回CardContainer, 用于装载Card节点
    func isCard(n: Node): ?() -> Node {
        match (n) {
            case n: Image where isRightImg(n, mBlockImage) => {
                => CustomCardImage()
            }
            case n: Link where isRightLink(n, mBlockLink) => {
                => CustomCardLink()
            }
            case _ => return None
        }
    }
    /**
     * 按文档序收集refactorRoot子树内的所有卡片节点（前序遍历，遇卡片不深入）
     * out: 收集的卡片节点，顺序即文档中的出现顺序
     */
    func collectCards(node: Node, out: ArrayList<Node>): Unit {
        for (child in node.listChildren()) {
            if (isCard(child).isSome()) {
                out.add(child)
            } else {
                collectCards(child, out)
            }
        }
    }

    /**
     * 以分割的形式重构Root，基于{@link Node#splitParent()}，支持任意深度的行内卡片嵌套。
     *
     * 多卡片场景的有序性：先在原树上按文档序收集全部卡片引用，再依序处理。
     * splitParent 是保序的局部变换（前段留在原容器、卡片提升为兄弟、后段进副本并插在
     * 卡片之后），因此按文档序依次处理即可保证最终兄弟顺序正确，不受前面卡片分割对
     * 树结构的改动影响。
     *
     * refactorRoot: 重构的根节点(Paragraph/Heading)
     */
    public func refactorWithSplit(refactorRoot: Node): Unit {
        let cards = ArrayList<Node>()
        collectCards(refactorRoot, cards)
        let rootParent = refactorRoot.getParent()
        for (c in cards) {
            while (c.getParent() != rootParent) {
                c.splitParent()
            }
            // 原地包装：在c的位置插入卡片容器，再把c移入容器
            let container = isCard(c).getOrThrow()()
            c.insertBefore(container)
            container.appendChild(c)
            container.setSourceSpans(c.getSourceSpans())
        }
        // 清理分割产生的空容器：卡片独占某段内容时，中间副本或根容器会被掏空
        if (let Some(p) <- rootParent) {
            var current = p.getFirstChild()
            while (let Some(n) <- current) {
                current = n.getNext()
                if ((n is Paragraph || n is Heading) && n.getFirstChild().isNone()) {
                    n.unlink()
                }
            }
        }
    }

    /**
     * 以"提升+加层"的形式重构TableCell：先按文档序收集单元格内所有卡片（含行内嵌套），
     * 用 splitParent 把每张卡片提升为单元格的直接子节点（卡片留在表格内），再重建单元格：
     * 卡片包装为卡片容器，普通行内节点分组进TableCellPart。
     */
    public func refactorTableCell(refactorRoot: TableCell): Unit {
        // 收集单元格内所有卡片（含嵌套），按文档序
        let cards = ArrayList<Node>()
        collectCards(refactorRoot, cards)
        if (cards.isEmpty()) {
            return
        }
        // 逐个把卡片提升为单元格的直接子节点（分割保序，卡片不越出单元格）
        for (c in cards) {
            while (c.getParent() != refactorRoot) {
                c.splitParent()
            }
        }
        // 清理分割掏空的强调容器（如整格加粗卡片）
        removeEmptyEmphasis(refactorRoot)

        // 重建单元格：卡片包装为容器，其余行内节点分组进 TableCellPart
        let cell = TableCell()
        cell.setWidth(refactorRoot.getWidth())
        cell.setHeader(refactorRoot.isHeader())
        cell.setAlignment(refactorRoot.getAlignment())
        cell.setSourceSpans(refactorRoot.getSourceSpans())
        cell.custom = refactorRoot.custom

        var pending = ArrayList<Node>()
        for (n in refactorRoot.listChildren()) {
            if (isCard(n).isSome()) {
                // 冲刷累积的普通行内节点到当前Part
                if (!pending.isEmpty()) {
                    let part = TableCellPart()
                    for (p in pending) {
                        part.appendChild(p)
                    }
                    cell.appendChild(part)
                    pending.clear()
                }
                // 包装卡片
                let customContainer = isCard(n).getOrThrow()()
                customContainer.appendChild(n)
                customContainer.setSourceSpans(n.getSourceSpans())
                cell.appendChild(customContainer)
            } else {
                pending.add(n)
            }
        }
        if (!pending.isEmpty()) {
            let part = TableCellPart()
            for (p in pending) {
                part.appendChild(p)
            }
            cell.appendChild(part)
        }
        refactorRoot.replaceWith(cell)
    }

    /**
     * 移除单元格内被分割掏空的强调类容器（无子节点的 StrongEmphasis/Emphasis 等）。
     */
    func removeEmptyEmphasis(cell: TableCell): Unit {
        var current = cell.getFirstChild()
        while (let Some(n) <- current) {
            current = n.getNext()
            if (n.childrenSize == 0 && (n is StrongEmphasis || n is Emphasis || n is Strikethrough
                || n is SubNode || n is SupNode || n is UnderlineNode)) {
                n.unlink()
            }
        }
    }
}

public open class CustomCardImage <: CustomBlock {
    protected open func setParent(parent: Node): Unit {
        this.parent = parent
    }
    public func getNodeType(): String {
        "CustomCardImage"
    }
}

public open class CustomCardLink <: CustomBlock {
    protected open func setParent(parent: Node): Unit {
        this.parent = parent
    }
    public func getNodeType(): String {
        "CustomCardLink"
    }
}

public class TableCellPart <: CustomNode {
    public func getNodeType(): String {
        "TableCellPart"
    }
}

/**
 * 文本对象
 */
public class StringClass {
    var str: String = "" // 文本内容

    func addString(s: String): Unit {
        str = str + s
    }
}

func getLinkString(stringClass: StringClass, commonmarkNode: Node): String {
    commonmarkNode.iterateChildren().forEach(
        {
            commonmarkChildrenNode: Node =>
                let nodeType = commonmarkChildrenNode.getNodeType()
                if (nodeType == "Text") {
                    stringClass.addString((commonmarkChildrenNode as Text)().getLiteral())
                } else if (nodeType == "Code") {
                    stringClass.addString((commonmarkChildrenNode as Code)().getLiteral())
                } else if (nodeType == "Footnote") {
                    stringClass.addString((commonmarkChildrenNode as Footnote)().noteid)
                } else if (nodeType == "LatexMathNode") {
                    stringClass.addString((commonmarkChildrenNode as LatexMathNode)().latex)
                } else {
                    stringClass.addString(getLinkString(stringClass, commonmarkChildrenNode))
                }
        }
    )
    return stringClass.str
}
