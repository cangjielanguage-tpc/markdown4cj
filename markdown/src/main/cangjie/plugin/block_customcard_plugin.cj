package markdown.plugin

internal import commonmark4cj.commonmark.Text as CommonmarkText
internal import commonmark4cj.commonmark.Node as CommonmarkNode
internal import commonmark4cj.commonmark.Image as CommonmarkImage
internal import commonmark4cj.commonmark.Link as CommonmarkLink

var customCardCondition:CustomCardCondition = CustomCardCondition(None,None)

public func setCustomCardConditionImg(blockImage: ?(CardBean) -> Bool) {
    customCardCondition.setImageCondition(blockImage)
}

public func setCustomCardConditionLink(blockLink: ?(CardBean) -> Bool) {
    customCardCondition.setLinkCondition(blockLink)
}

class CustomCardCondition{

    var mBlockImage: ?(CardBean) -> Bool = None
    var mBlockLink: ?(CardBean) -> Bool = None

    init(blockImage: ?(CardBean) -> Bool, blockLink: ?(CardBean) -> Bool) {
        this.mBlockImage = blockImage
        this.mBlockLink = blockLink
    }

    func setImageCondition(blockImage: ?(CardBean) -> Bool):Unit{
         this.mBlockImage = blockImage
    }

    func setLinkCondition(blockLink: ?(CardBean) -> Bool):Unit{
         this.mBlockLink = blockLink
    }

}


public class BlockCustomCardPlugin <: AbstractMarkdownPlugin {
    public static func create(): BlockCustomCardPlugin {
        return BlockCustomCardPlugin()
    }

    public func getClassType(): String {
        "BlockCustomCardPlugin"
    }

    public override func configureParser(builder: ParserBuilder): Unit {
        builder.postProcessor(BlockCustomCardProcessor())
    }
}

class BlockCustomCardProcessor <: PostProcessor {
    public func process(node: Node): Node {
        node.accept(BlockCustomCardVisitor())
        node
    }
}

func getAltText(n: Node): String {
    let altTextBuilder = StringClass()
    n.iterateChildren().forEach({
        child: CommonmarkNode => if (child is CommonmarkText) {
            altTextBuilder.addString((child as CommonmarkText)().getLiteral())
        }
    })
    let altText = altTextBuilder.str.trimAscii()
    return altText
}

func ImgNodeToCardBean(n: Node): CardBean {
    let description:String = getAltText(n)
    let destination = (n as CommonmarkImage)().getDestination()
    let title = (n as CommonmarkImage)().getTitle()
    return CardBean(description,destination,title)
}


func LinkNodeToCardBean(n: Node): CardBean {
    let description:String = getLinkString(StringClass(), n)
    let destination = (n as CommonmarkLink)().getDestination()
    let title = (n as CommonmarkLink)().getTitle()
    return CardBean(description,destination,title)
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
    public func visit(p: Heading): Unit {
        refactorWithSplit(
            p,
            {
                =>
                    let h = Heading()
                    h.setLevel(p.getLevel())
                    return h
            }
        )
    }
    public func visit(p: Paragraph): Unit {
        refactorWithSplit(p, {=> Paragraph()})
    }
    public func visit(n: CustomNode): Unit {
        if (let c: TableCell <- n) {
            refactorTableCell(c, { => TableCellPart()})
        } else {
            visitChildren(n)
        }
    }
    // 判断是否为card, 返回CardContainer, 用于装载Card节点
    func isCard(n: Node): ?() -> Node {
        match (n) {
            case n: Image where isRightImg(n, customCardCondition.mBlockImage) => {
                => CustomCardImage()
            }
            case n: Link where isRightLink(n, customCardCondition.mBlockLink) => {
                => CustomCardLink()
            }
            case _ => return None
        }
    }
    /**
     * 以分割的形式重构Root
     * refactorRoot: 重构的根节点
     * getInlineContainer: 获取Remainer, 用于装载普通行内节点
     */
    public func refactorWithSplit(refactorRoot: Node, getInlineContainer: () -> Node): Unit {
        var p = refactorRoot
        var current: ?Node = p.getFirstChild()
        while (let Some(n) <- current) {
            current = n.getNext()
            if (let Some(getCustomContainer) <- isCard(n)) {
                let oldp = p
                n.unlink()
                let customContainer = getCustomContainer()
                customContainer.appendChild(n)
                customContainer.setSourceSpans(n.getSourceSpans())
                p.insertAfter(customContainer)
                // 分割后续paragraph.children
                if (let Some(_) <- current) {
                    let inlineContainer = getInlineContainer()
                    var n1: ?Node = current
                    while (let Some(n11) <- n1) {
                        n1 = n11.getNext()
                        n11.unlink()
                        inlineContainer.appendChild(n11)
                    }
                    customContainer.insertAfter(inlineContainer)
                    p = inlineContainer
                }
                // 清理空p
                if (oldp.getFirstChild().isNone()) {
                    oldp.unlink()
                }
            }
        }
    }
    /**
     * 以增加一层的形式重构Root
     * refactorRoot: 重构的根节点
     * getInlineContainer: 获取Remainer, 用于装载普通行内节点
     */
    public func refactorTableCell(refactorRoot: TableCell, getInlineContainer: () -> Node): Unit {
        // 初始化新TableCell
        let cell = TableCell()
        cell.setWidth(refactorRoot.getWidth())
        cell.setHeader(refactorRoot.isHeader())
        cell.setAlignment(refactorRoot.getAlignment())
        cell.setSourceSpans(refactorRoot.getSourceSpans())
        cell.custom = refactorRoot.custom

        let getLastPart: () -> TableCellPart = {
            => if (let Some(v: TableCellPart) <- cell.getLastChild()) {
                v
            } else {
                let v = TableCellPart()
                cell.appendChild(v)
                v
            }
        }

        // 保存状态 判断重构时机
        let tasks = ArrayList<() -> Unit>()
        var needRefact = false

        var current: ?Node = refactorRoot.getFirstChild()
        while (let Some(n) <- current) {
            current = n.getNext()
            if (let Some(getCustomContainer) <- isCard(n)) {
                // 需要重构 更新状态 应用并清空task 重构Card节点
                needRefact = true
                for (t in tasks) {
                    t()
                }
                tasks.clear()
                n.unlink()
                let customContainer = getCustomContainer()
                customContainer.appendChild(n)
                customContainer.setSourceSpans(n.getSourceSpans())
                cell.appendChild(customContainer)
            } else {
                if (needRefact) {
                    // customContainer必定已触发 重构普通行内节点
                    n.unlink()
                    getLastPart().appendChild(n)
                } else {
                    // customContainer必定未触发 统计task
                    tasks.add(
                        {
                            =>
                                n.unlink()
                                getLastPart().appendChild(n)
                        }
                    )
                }
            }
        }
        if (needRefact) {
            refactorRoot.replaceWith(cell)
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

func getLinkString(stringClass: StringClass, commonmarkNode: CommonmarkNode): String {
    commonmarkNode.iterateChildren().forEach(
            {
                commonmarkChildrenNode: CommonmarkNode =>
                    let nodeType = commonmarkChildrenNode.getNodeType()
                    if (nodeType == "Text") {
                        stringClass.addString((commonmarkChildrenNode as CommonmarkText)().getLiteral())
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