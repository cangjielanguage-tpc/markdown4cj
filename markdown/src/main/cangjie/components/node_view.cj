package markdown.components

public class NodeView {
    var children: ArrayList<NodeView> = ArrayList<NodeView>() // 子节点列表
    var nodeType: String = "" // node类型
    var nodeText: String = "" // node文本内容
    var nodeHash: Int64 = 0 // node自身标识
    var contentHash: Int64 = 0 // node子节点标识
    var isParagraph: Bool = false // 段落
    var isHeading: Bool = false // 标题
    var headingLevel: Int64 = 1 // 标题等级
    var headingID: String = "" // 标题ID
    var isTable: Bool = false // 表格
    var tableAlignment: HorizontalAlign = HorizontalAlign.Start // 表格列对齐方式
    var isTableHead: Bool = false // 表格标题
    var isTableBody: Bool = false // 表格内容
    var isTableRow: Bool = false // 表格行
    var isTableCell: Bool = false // 表格列
    var isDescList: Bool = false // 定义列表
    var isDescTerm: Bool = false // 定义列表术语
    var isBulletList: Bool = false // 无序列表
    var isOrderedList: Bool = false // 有序列表
    var orderedListNumber: Int64 = 0 // 有序列表编号
    var isTaskList: Bool = false // 任务列表
    var isTaskListSelected: Bool = false // 任务列表是否选中
    var isQuote: Bool = false // 块引用
    var isFootnote: Bool = false // 脚注
    var footnoteID: Option<String> = Option<String>.None // 脚注ID
    var isLatexMathBlock: Bool = false // 块结构数学公式
    var isLatexMathBlockClose: Bool = false // 块结构数学公式是否结束
    var isFontNode: Bool = false // FontNode
    var fontNodeSize: Option<Float64> = Option<Float64>.None // FontNode文本大小
    var fontNodeColor: Option<Color> = Option<Color>.None // FontNode文本颜色
    var isSpanNode: Bool = false // SpanNode
    var spanNodeSize: Option<Float64> = Option<Float64>.None // SpanNode文本大小
    var spanNodeWeight: Option<FontWeight> = Option<FontWeight>.None // SpanNode文本加粗
    var spanNodeColor: Option<Color> = Option<Color>.None // SpanNode文本颜色
    var isEmphasis: Bool = false // 斜体
    var isStrongEmphasis: Bool = false // 粗体
    var isUnderlineNode: Bool = false // 下划线
    var isStrikethrough: Bool = false // 删除线
    var isSubNode: Bool = false // 下标
    var isSupNode: Bool = false // 上标
    var isInLineCode: Bool = false // 内联代码
    var headLinkIndex: Option<Int64> = Option<Int64>.None // HeadLink标识
    var isLink: Bool = false // 链接
    var linkUrl: Option<String> = Option<String>.None // 链接URL
    var linkTitle: Option<String> = Option<String>.None // 链接标题
    var imageUrl: Option<String> = Option<String>.None // 图片URL
    var imageTitle: Option<String> = Option<String>.None // 图片标题
    var imageWidth: Option<Length> = Option<Length>.None // 图片宽度
    var imageHeight: Option<Length> = Option<Length>.None // 图片高度
    var imageRadius: Option<Length> = Option<Length>.None // 图片圆角
    var imageAlign: Option<HorizontalAlign> = Option<HorizontalAlign>.None // 图片对齐方式
    var codeInfo: Option<String> = Option<String>.None // 代码块的代码类型
    var codeListTab: Option<ArrayList<String>> = Option<ArrayList<String>>.None // 代码块列表标题
    var cardName: Option<String> = Option<String>.None // 卡片名称
    var cardData: Option<String> = Option<String>.None // 卡片内容
    var commonmarkNode: Option<CommonmarkNode> = Option<CommonmarkNode>.None // Node
}

public func nodeToNodeView(
    parentCommonmarkNode: CommonmarkNode,
    parentNewNodeView: NodeView,
    childrenNewNodeView: NodeView,
    isLinkStyle: Bool
): Unit {
    parentCommonmarkNode.iterateChildren().forEach(
            {
                commonmarkChildrenNode: CommonmarkNode =>
                    let childrenNodeView: NodeView = NodeView()
                    let nodeType = commonmarkChildrenNode.getNodeType()
                    childrenNodeView.nodeType = nodeType
                    childrenNodeView.nodeHash = getProp<Int64>(commonmarkChildrenNode, 'nodeHash', 0)
                    childrenNodeView.contentHash = getProp<Int64>(commonmarkChildrenNode, 'contentHash', 0)

                    childrenNodeView.isParagraph = childrenNewNodeView.isParagraph
                    childrenNodeView.isHeading = childrenNewNodeView.isHeading
                    childrenNodeView.headingLevel = childrenNewNodeView.headingLevel
                    childrenNodeView.headingID = childrenNewNodeView.headingID
                    childrenNodeView.isTable = childrenNewNodeView.isTable
                    childrenNodeView.tableAlignment = childrenNewNodeView.tableAlignment
                    childrenNodeView.isTableHead = childrenNewNodeView.isTableHead
                    childrenNodeView.isTableBody = childrenNewNodeView.isTableBody
                    childrenNodeView.isTableRow = childrenNewNodeView.isTableRow
                    childrenNodeView.isTableCell = childrenNewNodeView.isTableCell
                    childrenNodeView.isDescList = childrenNewNodeView.isDescList
                    childrenNodeView.isDescTerm = childrenNewNodeView.isDescTerm
                    childrenNodeView.isBulletList = childrenNewNodeView.isBulletList
                    childrenNodeView.isOrderedList = childrenNewNodeView.isOrderedList
                    childrenNodeView.orderedListNumber = childrenNewNodeView.orderedListNumber
                    childrenNodeView.isTaskList = childrenNewNodeView.isTaskList
                    childrenNodeView.isTaskListSelected = childrenNewNodeView.isTaskListSelected
                    childrenNodeView.isQuote = childrenNewNodeView.isQuote
                    childrenNodeView.isFootnote = childrenNewNodeView.isFootnote
                    childrenNodeView.footnoteID = childrenNewNodeView.footnoteID
                    childrenNodeView.isLatexMathBlock = childrenNewNodeView.isLatexMathBlock
                    childrenNodeView.isLatexMathBlockClose = childrenNewNodeView.isLatexMathBlockClose
                    childrenNodeView.isFontNode = childrenNewNodeView.isFontNode
                    childrenNodeView.fontNodeSize = childrenNewNodeView.fontNodeSize
                    childrenNodeView.fontNodeColor = childrenNewNodeView.fontNodeColor
                    childrenNodeView.isSpanNode = childrenNewNodeView.isSpanNode
                    childrenNodeView.spanNodeSize = childrenNewNodeView.spanNodeSize
                    childrenNodeView.spanNodeWeight = childrenNewNodeView.spanNodeWeight
                    childrenNodeView.spanNodeColor = childrenNewNodeView.spanNodeColor
                    childrenNodeView.isEmphasis = childrenNewNodeView.isEmphasis
                    childrenNodeView.isStrongEmphasis = childrenNewNodeView.isStrongEmphasis
                    childrenNodeView.isUnderlineNode = childrenNewNodeView.isUnderlineNode
                    childrenNodeView.isStrikethrough = childrenNewNodeView.isStrikethrough
                    childrenNodeView.isSubNode = childrenNewNodeView.isSubNode
                    childrenNodeView.isSupNode = childrenNewNodeView.isSupNode
                    childrenNodeView.isInLineCode = childrenNewNodeView.isInLineCode
                    childrenNodeView.headLinkIndex = childrenNewNodeView.headLinkIndex
                    childrenNodeView.isLink = childrenNewNodeView.isLink
                    childrenNodeView.linkUrl = childrenNewNodeView.linkUrl
                    childrenNodeView.linkTitle = childrenNewNodeView.linkTitle
                    childrenNodeView.imageUrl = childrenNewNodeView.imageUrl
                    childrenNodeView.imageWidth = childrenNewNodeView.imageWidth
                    childrenNodeView.imageTitle = childrenNewNodeView.imageTitle
                    childrenNodeView.imageHeight = childrenNewNodeView.imageHeight
                    childrenNodeView.imageRadius = childrenNewNodeView.imageRadius
                    childrenNodeView.imageAlign = childrenNewNodeView.imageAlign
                    childrenNodeView.codeInfo = childrenNewNodeView.codeInfo
                    childrenNodeView.codeListTab = childrenNewNodeView.codeListTab
                    childrenNodeView.cardName = childrenNewNodeView.cardName
                    childrenNodeView.cardData = childrenNewNodeView.cardData
                    childrenNodeView.commonmarkNode = childrenNewNodeView.commonmarkNode

                    if (nodeType == "Text") {
                        // 普通文本
                        childrenNodeView.nodeText = (commonmarkChildrenNode as CommonmarkText)().getLiteral()
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "Code") {
                        // 内联代码
                        childrenNodeView.nodeText = (commonmarkChildrenNode as Code)().getLiteral()
                        childrenNodeView.isInLineCode = true
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "SoftLineBreak") {
                        // 软换行
                        // 无需处理
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "HardLineBreak") {
                        // 硬换行
                        // 无需处理
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "LinkReferenceDefinition") {
                        // TODO 引用链接
                        // 无需处理
                    } else if (nodeType == "Link") {
                        // 链接, TOC链接/标题ID链接
                        childrenNodeView.isLink = true
                        let link = (commonmarkChildrenNode as CommonmarkLink)()
                        childrenNodeView.linkUrl = link.getDestination()
                        childrenNodeView.linkTitle = link.getTitle()
                        if (isLinkStyle) {
                            childrenNodeView.nodeText = getLinkString(StringClass(), commonmarkChildrenNode)
                            parentNewNodeView.children.add(childrenNodeView)
                        } else {
                            nodeToNodeView(commonmarkChildrenNode, parentNewNodeView, childrenNodeView, isLinkStyle)
                        }
                    } else if (nodeType == "HeadLink") {
                        // TOC链接/标题ID链接
                        childrenNodeView.isLink = true
                        let link = (commonmarkChildrenNode as HeadLink)()
                        childrenNodeView.linkUrl = link.getDestination()
                        childrenNodeView.linkTitle = link.getTitle()
                        childrenNodeView.headLinkIndex = link.headIndex
                        if (isLinkStyle) {
                            childrenNodeView.nodeText = getLinkString(StringClass(), commonmarkChildrenNode)
                            parentNewNodeView.children.add(childrenNodeView)
                        } else {
                            nodeToNodeView(commonmarkChildrenNode, parentNewNodeView, childrenNodeView, isLinkStyle)
                        }
                    } else if (nodeType == "SubNode") {
                        // 下标
                        childrenNodeView.isSubNode = true
                        nodeToNodeView(commonmarkChildrenNode, parentNewNodeView, childrenNodeView, isLinkStyle)
                    } else if (nodeType == "SubHtmlNode") {
                        // Html下标
                        childrenNodeView.isSubNode = true
                        nodeToNodeView(commonmarkChildrenNode, parentNewNodeView, childrenNodeView, isLinkStyle)
                    } else if (nodeType == "SupNode") {
                        // 上标
                        childrenNodeView.isSupNode = true
                        nodeToNodeView(commonmarkChildrenNode, parentNewNodeView, childrenNodeView, isLinkStyle)
                    } else if (nodeType == "SupHtmlNode") {
                        // Html上标
                        childrenNodeView.isSupNode = true
                        nodeToNodeView(commonmarkChildrenNode, parentNewNodeView, childrenNodeView, isLinkStyle)
                    } else if (nodeType == "UnderlineNode") {
                        // 下划线
                        childrenNodeView.isUnderlineNode = true
                        nodeToNodeView(commonmarkChildrenNode, parentNewNodeView, childrenNodeView, isLinkStyle)
                    } else if (nodeType == "FontNode") {
                        // FontNode
                        childrenNodeView.isFontNode = true
                        let fontNode: FontNode = (commonmarkChildrenNode as FontNode)()
                        try {
                            let sizeString: ?String = fontNode.getSize()
                            if (sizeString.isSome()) {
                                let sizeInt64: Int64 = Int64.parse(sizeString())
                                childrenNodeView.fontNodeSize = Float64(sizeInt64)
                            }
                        } catch (_: Exception) {
                        }
                        try {
                            let colorString: ?String = fontNode.getColor()
                            if (colorString.isSome()) {
                                let colorUInt32: UInt32 = UInt32.parse(colorString().replace("#", "0x"))
                                childrenNodeView.fontNodeColor = Color(colorUInt32)
                            }
                        } catch (_: Exception) {
                        }
                        nodeToNodeView(commonmarkChildrenNode, parentNewNodeView, childrenNodeView, isLinkStyle)
                    } else if (nodeType == "SpanNode") {
                        // SpanNode
                        childrenNodeView.isSpanNode = true
                        let spanNode: SpanNode = (commonmarkChildrenNode as SpanNode)()
                        let style: ?HashMap<String, String> = spanNode.getStyle()
                        if (let Some(v) <- style) {
                            try {
                                let sizeStr: ?String = v.get("font-size")
                                if (let Some(n) <- sizeStr) {
                                    let size: ?Float64 = sizeStringToSize(n)
                                    if (let Some(m) <- size) {
                                        childrenNodeView.spanNodeSize = m
                                    }
                                }
                            } catch (_: Exception) {
                            }
                            try {
                                let weightStr: ?String = v.get("font-weight")
                                if (let Some(n) <- weightStr) {
                                    let weight: ?FontWeight = fontWeightToValue(n)
                                    childrenNodeView.spanNodeWeight = weight
                                }
                            } catch (_: Exception) {
                            }
                            try {
                                let colorStr: ?String = v.get("color")
                                if (let Some(n) <- colorStr) {
                                    let color: ?Color = colorStringToColor(n)
                                    if (let Some(m) <- color) {
                                        childrenNodeView.spanNodeColor = m
                                    } else {
                                        if (n.startsWith("#")) {
                                            let colorUInt32: UInt32 = UInt32.parse(n.replace("#", "0x"))
                                            childrenNodeView.spanNodeColor = Color(colorUInt32)
                                        }
                                    }
                                }
                            } catch (_: Exception) {
                            }
                        }
                        nodeToNodeView(commonmarkChildrenNode, parentNewNodeView, childrenNodeView, isLinkStyle)
                    } else if (nodeType == "Emphasis") {
                        // 斜体
                        childrenNodeView.isEmphasis = true
                        nodeToNodeView(commonmarkChildrenNode, parentNewNodeView, childrenNodeView, isLinkStyle)
                    } else if (nodeType == "StrongEmphasis") {
                        // 加粗
                        childrenNodeView.isStrongEmphasis = true
                        nodeToNodeView(commonmarkChildrenNode, parentNewNodeView, childrenNodeView, isLinkStyle)
                    } else if (nodeType == "Strikethrough") {
                        // 删除线
                        childrenNodeView.isStrikethrough = true
                        nodeToNodeView(commonmarkChildrenNode, parentNewNodeView, childrenNodeView, isLinkStyle)
                    } else if (nodeType == "Paragraph") {
                        // 段落
                        if (childrenNodeView.isParagraph == true) {
                            nodeToNodeView(commonmarkChildrenNode, parentNewNodeView, childrenNodeView, isLinkStyle)
                        } else {
                            childrenNodeView.isParagraph = true
                            nodeToNodeView(commonmarkChildrenNode, childrenNodeView, childrenNodeView, isLinkStyle)
                            parentNewNodeView.children.add(childrenNodeView)
                        }
                    } else if (nodeType == "Heading") {
                        // 标题
                        childrenNodeView.isHeading = true
                        childrenNodeView.headingLevel = (commonmarkChildrenNode as Heading)().getLevel()
                        nodeToNodeView(commonmarkChildrenNode, childrenNodeView, childrenNodeView, isLinkStyle)
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "IdHeading") {
                        // 标题ID
                        childrenNodeView.isHeading = true
                        let idHeading = (commonmarkChildrenNode as IdHeading)()
                        childrenNodeView.headingLevel = idHeading.getLevel()
                        childrenNodeView.headingID = idHeading.id
                        nodeToNodeView(commonmarkChildrenNode, childrenNodeView, childrenNodeView, isLinkStyle)
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "FencedCodeBlockListBlock") {
                        // 围栏代码块列表
                        childrenNodeView.codeListTab = (commonmarkChildrenNode as FencedCodeBlockListBlock)().tabs
                        nodeToNodeView(commonmarkChildrenNode, childrenNodeView, childrenNodeView, isLinkStyle)
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "FencedCodeBlock") {
                        // 围栏代码块
                        let fencedCodeBlock = (commonmarkChildrenNode as FencedCodeBlock)()
                        childrenNodeView.nodeText = fencedCodeBlock.getLiteral().removeSuffix("\n") // 围栏代码块数据源会多一行空行
                        childrenNodeView.codeInfo = fencedCodeBlock.getInfo()
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "IndentedCodeBlock") {
                        // 缩进代码块
                        childrenNodeView.nodeText = (commonmarkChildrenNode as IndentedCodeBlock)().getLiteral().removeSuffix("\n") // 缩进代码块数据源会多一行空行
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "BulletList") {
                        // 无序列表
                        childrenNodeView.isBulletList = true
                        nodeToNodeView(commonmarkChildrenNode, childrenNodeView, childrenNodeView, isLinkStyle)
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "OrderedList") {
                        // 有序列表
                        childrenNodeView.isOrderedList = true
                        nodeToNodeView(commonmarkChildrenNode, childrenNodeView, childrenNodeView, isLinkStyle)
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "ListItem") {
                        // 无序/有序列表子节点
                        childrenNodeView.orderedListNumber = commonmarkChildrenNode.listItemIndex()
                        nodeToNodeView(commonmarkChildrenNode, childrenNodeView, childrenNodeView, isLinkStyle)
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "TaskListItem") {
                        // 任务列表子节点
                        childrenNodeView.isTaskList = true
                        childrenNodeView.isTaskListSelected = (commonmarkChildrenNode as TaskListItem)().isDone()
                        nodeToNodeView(commonmarkChildrenNode, childrenNodeView, childrenNodeView, isLinkStyle)
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "BlockQuote") {
                        // 块引用
                        childrenNodeView.isQuote = true
                        nodeToNodeView(commonmarkChildrenNode, childrenNodeView, childrenNodeView, isLinkStyle)
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "LatexMathBlock") {
                        // 数学公式块
                        childrenNodeView.isLatexMathBlock = true
                        let latexMathBlock = (commonmarkChildrenNode as LatexMathBlock)()
                        childrenNodeView.nodeText = latexMathBlock.latex
                        childrenNodeView.isLatexMathBlockClose = latexMathBlock.isClosed
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "LatexMathNode") {
                        // 内联数学公式
                        childrenNodeView.nodeText = (commonmarkChildrenNode as LatexMathNode)().latex
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "TableBlock") {
                        // 表格
                        childrenNodeView.isTable = true
                        nodeToNodeView(commonmarkChildrenNode, childrenNodeView, childrenNodeView, isLinkStyle)
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "TableHead") {
                        // 表格标题
                        childrenNodeView.isTableHead = true
                        nodeToNodeView(commonmarkChildrenNode, parentNewNodeView, childrenNodeView, isLinkStyle)
                    } else if (nodeType == "TableBody") {
                        // 表格内容
                        childrenNodeView.isTableBody = true
                        nodeToNodeView(commonmarkChildrenNode, parentNewNodeView, childrenNodeView, isLinkStyle)
                    } else if (nodeType == "TableRow") {
                        // 表格行
                        childrenNodeView.isTableRow = true
                        nodeToNodeView(commonmarkChildrenNode, childrenNodeView, childrenNodeView, isLinkStyle)
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "TableCell") {
                        // 表格格子
                        childrenNodeView.isTableCell = true
                        let tableCell = (commonmarkChildrenNode as TableCell)()
                        childrenNodeView.tableAlignment = renderTableCellColumnAlign(tableCell.getAlignment())
                        childrenNodeView.isTableHead = tableCell.isHeader()
                        nodeToNodeView(commonmarkChildrenNode, childrenNodeView, childrenNodeView, isLinkStyle)
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "ThematicBreak") {
                        // 分割线
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "FootnoteBlock") {
                        // 脚注文末内容定义
                        childrenNodeView.footnoteID = (commonmarkChildrenNode as FootnoteBlock)().noteid
                        nodeToNodeView(commonmarkChildrenNode, childrenNodeView, childrenNodeView, isLinkStyle)
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "Footnote") {
                        // 脚注行内引用标记
                        let footnote = (commonmarkChildrenNode as Footnote)()
                        childrenNodeView.isFootnote = true
                        childrenNodeView.footnoteID = footnote.noteid
                        childrenNodeView.nodeText = footnote.noteid
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "DescList") {
                        // 定义列表
                        childrenNodeView.isDescList = true
                        nodeToNodeView(commonmarkChildrenNode, childrenNodeView, childrenNodeView, isLinkStyle)
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "DescTerm") {
                        // 定义列表术语
                        childrenNodeView.isDescTerm = true
                        nodeToNodeView(commonmarkChildrenNode, childrenNodeView, childrenNodeView, isLinkStyle)
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "DescDef") {
                        // 定义列表释义
                        nodeToNodeView(commonmarkChildrenNode, childrenNodeView, childrenNodeView, isLinkStyle)
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "HtmlBlock") {
                        // TODO HTML块
                        // 无需处理
                    } else if (nodeType == "HtmlInline") {
                        // TODO 内联HTML
                        // 无需处理
                    } else if (nodeType == "IgnoreBlockNode") {
                        // HTML块级别无用节点
                        nodeToNodeView(commonmarkChildrenNode, parentNewNodeView, childrenNodeView, isLinkStyle)
                    } else if (nodeType == "IgnoreInlineNode") {
                        // Html行内无用节点
                        nodeToNodeView(commonmarkChildrenNode, parentNewNodeView, childrenNodeView, isLinkStyle)
                    } else if (nodeType == "ImageHtmlNode") {
                        // HTML图片
                        let imageHtmlNode = (commonmarkChildrenNode as ImageHtmlNode)()
                        childrenNodeView.imageUrl = imageHtmlNode.getDestination()
                        childrenNodeView.imageWidth = strToLength(imageHtmlNode.getWidth())
                        childrenNodeView.imageHeight = strToLength(imageHtmlNode.getHeight())
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "SlideBlock") {
                        // 幻灯片
                        nodeToNodeView(commonmarkChildrenNode, childrenNodeView, childrenNodeView, isLinkStyle)
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "ImageSingleBlock") {
                        // TODO 图片Block
                        // 无需处理
                    } else if (nodeType == "Image") {
                        // 图片
                        let image = (commonmarkChildrenNode as CommonmarkImage)()
                        childrenNodeView.imageUrl = image.getDestination()
                        childrenNodeView.imageTitle = image.getTitle()
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "StyleImage") {
                        // Style图片
                        let imageStyle = (commonmarkChildrenNode as StyleImage)()
                        childrenNodeView.imageUrl = imageStyle.getDestination()
                        childrenNodeView.imageTitle = imageStyle.getTitle()
                        let picStyle = parsePicStyle(imageStyle.styles)
                        childrenNodeView.imageWidth = picStyle.width
                        childrenNodeView.imageHeight = picStyle.height
                        childrenNodeView.imageRadius = picStyle.borderRadius
                        childrenNodeView.imageAlign = picStyle.align
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "ImgVideo") {
                        // TODO 力扣视频
                        // 无需处理
                    } else if (nodeType == "CardNode") {
                        // 卡片
                        let cardNode = (commonmarkChildrenNode as CardNode)()
                        childrenNodeView.cardName = cardNode.getName()
                        childrenNodeView.cardData = cardNode.getData()
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "BlockVideo") {
                        // 视频
                        commonmarkChildrenNode.iterateChildren().forEach({
                                commonmarkNode: CommonmarkNode => if (commonmarkNode is CommonmarkImage) {
                                    childrenNodeView.imageUrl = (commonmarkNode as CommonmarkImage)().getDestination()
                                }
                            })
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "BlockAudio") {
                        // 音频
                        commonmarkChildrenNode.iterateChildren().forEach({
                                commonmarkNode: CommonmarkNode => if (commonmarkNode is CommonmarkImage) {
                                    childrenNodeView.imageUrl = (commonmarkNode as CommonmarkImage)().getDestination()
                                }
                            })
                        parentNewNodeView.children.add(childrenNodeView)
                    } else if (nodeType == "BlockAD") {
                        // 广告
                        parentNewNodeView.children.add(childrenNodeView)
                    } else {
                        // 自定义其他节点
                        childrenNodeView.commonmarkNode = commonmarkChildrenNode
                        parentNewNodeView.children.add(childrenNodeView)
                    }
            }
        )
}
