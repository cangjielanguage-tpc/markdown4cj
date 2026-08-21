package markdown_parser_hybrid

class JsNodeBuilder {
    JsNodeBuilder(let builder: JSObject, let context: JSContext) {}

    /*
     * 将整棵 cangjie 节点树转换为 js 节点树。
     *
     * 遍历采用深度优先的先序遍历, 用显式栈模拟递归, 避免深文档导致栈溢出。
     *
     * 核心思路:
     * 构建器 builder 内部维护一个"当前节点"指针, beginNode 会把新节点挂到当前节点下并下钻,
     * endNode 则把当前节点指针回退到父节点。因此每个节点都需要两件事:
     *   1. 进入它(挂载 + 填充数据), 2. 处理完它所有子节点后离开它(回退)。
     *
     * 这里没有像递归那样靠调用栈天然地区分"进入"和"返回", 而是用一个栈元素同时表达两种动作,
     * 用 Option<Node> 充当"事件":
     *   Some(node) = 进入事件(enter)
     *   None       = 离开事件(exit)
     * 进入某节点时, 先压入一个 None 作为它的离开标记, 再压入其子节点; 由于栈是后进先出,
     * 子节点必然先于该 None 被处理, 于是"离开"自然发生在所有子节点处理完之后——
     * 无需额外的访问状态位, 一个 None 就把"何时回退"这件事交给了栈的先后顺序。
     *
     * 例: 树 A(B(C), D), 栈顶在右, 演变如下:
     *   [A]                     -- 初始压入根节点进入事件
     *   pop A  -> 访问 A, 压入 exit(A) 与子节点 D、B
     *   [exit(A), D, B]         -- 注意先压 None(exit) 再压子节点, 且子节点倒序压入
     *   pop B  -> 访问 B, 压入 exit(B) 与子节点 C
     *   [exit(A), D, exit(B), C]
     *   pop C  -> 访问 C(无子节点)
     *   [exit(A), D, exit(B)]
     *   pop exit(B) -> 离开 B, 回退到 A
     *   pop D  -> 访问 D
     *   pop exit(A) -> 离开 A
     * 最终访问顺序 A -> B -> C -> D, 即先序遍历。
     */
    func buildNode(root: Node): JSValue {
        // 构建前重置 builder 状态, 支持复用同一个 builder 进行多次 parse。
        builder.callMethod('reset', [])
        let stack = ArrayStack<Option<Node>>()
        // 先压入根节点的进入事件。
        stack.add(Some(root))
        while (!stack.isEmpty()) {
            match (stack.remove()) {
                // 进入事件: 创建 js 节点并挂到当前父节点下, 同时填充节点数据。
                case Some(Some(node)) =>
                    enterNode(node)
                    // 先压入"离开事件", 保证所有子节点处理完后才 endNode, 使当前节点指针正确回退。
                    stack.add(None)
                    // 子节点从 lastChild 反向压栈(LIFO), 弹出时即为 firstChild 到 lastChild 的从左到右顺序。
                    var child = node.getLastChild()
                    while (let Some(c) <- child) {
                        stack.add(Some(c))
                        child = c.getPrevious()
                    }
                // 离开事件: 结束当前节点, builder 的当前节点指针回退到父节点。
                case _ =>
                    builder.callMethod('endNode', [])
            }
        }
        // 全部处理完毕, 返回构建出的根节点。
        builder.callMethod('getRoot', [])
    }

    func enterNode(node: Node): Unit {
        builder.callMethod('beginNode', [
            context.string(node.getNodeType()).toJSValue(),
            context.string(node.toString()).toJSValue()
        ])
        setSourceSpans(node)
        if (let props: HashMap<String, Any> <- node.custom) {
            for ((k, v) in props) {
                if (let toStr: ToString <- v) {
                    builder.callMethod('putProp', [context.string(k).toJSValue(), context.string(toStr.toString()).toJSValue()])
                }
            }
        }
        match (node) {
            case v: TaskListItem => setField('isdone', context.boolean(v.isDone()).toJSValue())
            case v: LatexMathBlock =>
                setField('latex', context.string(v.latex).toJSValue())
                setField('isClosed', context.boolean(v.isClosed).toJSValue())
            case v: LatexMathNode => setField('latex', context.string(v.latex).toJSValue())
            case v: Footnote =>
                setField('noteid', context.string(v.noteid).toJSValue())
                setField('blockIndex', context.number(Float64(v.block?.blockIndex ?? -1)).toJSValue())
            case v: FootnoteBlock =>
                setField('noteid', context.string(v.noteid).toJSValue())
                setField('blockIndex', context.number(Float64(v.blockIndex)).toJSValue())
            case v: Text => setField('literal', context.string(v.getLiteral()).toJSValue())
            case v: HtmlInline => setField('literal', context.string(v.getLiteral()).toJSValue())
            case v: Image =>
                setField('destination', context.string(v.getDestination()).toJSValue())
                if (let Some(t) <- v.getTitle()) {
                    setField('title', context.string(t).toJSValue())
                }
                match (v) {
                    case i: StyleImage => putImageStyles(i.styles)
                    case i: ImgVideo => setField('text', context.string(i.text).toJSValue())
                    case _ => ()
                }
            case v: Code => setField('literal', context.string(v.getLiteral()).toJSValue())
            case v: LinkReferenceDefinition =>
                if (let Some(l) <- v.getLabel()) {
                    setField('label', context.string(l).toJSValue())
                }
                setField('destination', context.string(v.getDestination()).toJSValue())
                if (let Some(t) <- v.getTitle()) {
                    setField('title', context.string(t).toJSValue())
                }
            case v: Link =>
                setField('destination', context.string(v.getDestination()).toJSValue())
                if (let Some(t) <- v.getTitle()) {
                    setField('title', context.string(t).toJSValue())
                }
                match (v) {
                    case l: HeadLink => setField('headIndex', context.number(Float64(l.headIndex)).toJSValue())
                    case _ => ()
                }
            case v: Delimited =>
                if (let Some(d) <- v.getOpeningDelimiter()) {
                    setField('delimiter', context.string(d).toJSValue())
                }
            case v: HtmlBlock => setField('literal', context.string(v.getLiteral()).toJSValue())
            case v: IndentedCodeBlock => setField('literal', context.string(v.getLiteral()).toJSValue())
            case v: FencedCodeBlock =>
                setField('fenceChar', context.string(v.getFenceChar().toString()).toJSValue())
                setField('fenceLength', context.number(Float64(v.getFenceLength())).toJSValue())
                setField('fenceIndent', context.number(Float64(v.getFenceIndent())).toJSValue())
                setField('info', context.string(v.getInfo()).toJSValue())
                setField('literal', context.string(v.getLiteral()).toJSValue())
            case v: Heading => setField('level', context.number(Float64(v.getLevel())).toJSValue())
            case v: BulletList =>
                setField('isTight', context.boolean(v.isTight()).toJSValue())
                setField('bulletMarker', context.string(v.getBulletMarker().toString()).toJSValue())
            case v: OrderedList =>
                setField('isTight', context.boolean(v.isTight()).toJSValue())
                setField('startNumber', context.number(Float64(v.getStartNumber())).toJSValue())
                setField('delimiter', context.string(v.getDelimiter().toString()).toJSValue())
            case v: TableCell =>
                setField('isHeader', context.boolean(v.isHeader()).toJSValue())
                if (let Some(a) <- v.getAlignment()) {
                    setField('alignment', context.string(a.toString()).toJSValue())
                }
                setField('width', context.number(Float64(v.getWidth())).toJSValue())
            case v: ImageHtmlNode =>
                setField('destination', context.string(v.getDestination()).toJSValue())
                if (let Some(w) <- v.getWidth()) {
                    setField('width', context.string(w).toJSValue())
                }
                if (let Some(h) <- v.getHeight()) {
                    setField('height', context.string(h).toJSValue())
                }
            case v: FontNode =>
                if (let Some(c) <- v.getColor()) {
                    setField('color', context.string(c).toJSValue())
                }
                if (let Some(s) <- v.getSize()) {
                    setField('size', context.string(s).toJSValue())
                }
            case v: SpanNode =>
                putSpanNodeAttr(v.getAttrs())
                putSpanNodeStyle(v.getStyle())
            case v: CardNode =>
                setField('name', context.string(v.getName()).toJSValue())
                setField('data', context.string(v.getData()).toJSValue())
            case _ => ()
        }
    }

    func setField(name: String, value: JSValue): Unit {
        builder.callMethod('setField', [context.string(name).toJSValue(), value])
    }

    func putImageStyles(styles: ArrayList<String>): Unit {
        builder.callMethod('putImageStyles', styles |> map {v => context.string(v).toJSValue()} |> collectArray)
    }

    func putSpanNodeAttr(attrs: ?HashMap<String, String>): Unit {
        if (let Some(attrs) <- attrs) {
            for ((k, v) in attrs) {
                builder.callMethod('putSpanNodeAttr', [context.string(k).toJSValue(), context.string(v).toJSValue()])
            }
        }
    }

    func putSpanNodeStyle(style: ?HashMap<String, String>): Unit {
        if (let Some(style) <- style) {
            for ((k, v) in style) {
                builder.callMethod('putSpanNodeStyle', [context.string(k).toJSValue(), context.string(v).toJSValue()])
            }
        }
    }

    func setSourceSpans(node: Node): Unit {
        let sourceSpans = node.getSourceSpans()
        // 50个一组 批量添加SourceSpan
        for (start in 0..sourceSpans.size : 50) {
            let end = min(start + 50, sourceSpans.size)
            let sourceSpansFlatten = Array<JSValue>((end - start) * 4) {
                i =>
                    let spanIndex = start + i / 4
                    let span = sourceSpans[spanIndex]
                    match (i % 4) {
                        case 0 => context.number(Float64(span.getLineIndex())).toJSValue()
                        case 1 => context.number(Float64(span.getColumnIndex())).toJSValue()
                        case 2 => context.number(Float64(span.getInputIndex())).toJSValue()
                        case _ => context.number(Float64(span.getLength())).toJSValue()
                    }
            }
            builder.callMethod('addSourceSpans', sourceSpansFlatten)
        }
    }
}
