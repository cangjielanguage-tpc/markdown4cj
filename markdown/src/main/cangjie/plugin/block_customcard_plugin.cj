package markdown.plugin

internal import commonmark4cj.commonmark.Text as CommonmarkText
internal import commonmark4cj.commonmark.Node as CommonmarkNode

var customCardCondition:CustomCardCondition = CustomCardCondition(None,None)

public func setCustomCardConditionImg(blockImage: ?(String) -> Bool){
    customCardCondition.setImageCondition(blockImage)
}

public func setCustomCardConditionLink( blockLink: ?(String) -> Bool){
    customCardCondition.setLinkCondition(blockLink)
}

class CustomCardCondition{

    var mBlockImage:?(String) -> Bool = None
    var mBlockLink:?(String) -> Bool = None

    init(blockImage: ?(String) -> Bool, blockLink: ?(String) -> Bool) {
        this.mBlockImage = blockImage
        this.mBlockLink = blockLink
    }

    func setImageCondition(blockImage: ?(String) -> Bool):Unit{
         this.mBlockImage = blockImage
    }

    func setLinkCondition(blockLink: ?(String) -> Bool):Unit{
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

func isRightImg(str: String, blockImage: ?(String) -> Bool): Bool {
    if (let Some(v) <- blockImage) {
        return v(str)
    }
    return false
}

//评分：[](star_5 "rating")

func isRightLink(str: String, blockLink: ?(String) -> Bool): Bool {
    if (let Some(v) <- blockLink) {
        return v(str)
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
            case n: Image where isRightImg(getAltText(n), customCardCondition.mBlockImage) => {
                => CustomCardImage()
            }
            case n: Link where isRightLink(n.getDestination(), customCardCondition.mBlockLink) => {
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