package markdown_parser_hybrid

class JsNodeBuilder {
    // 失败标志: 供多个 postJSTask 串行共享, 任一 child 构建失败后短路后续 task, 避免重复回调 onDone。
    var failed: Bool = false

    JsNodeBuilder(let builder: JSObject, let context: JSContext) {}

    /*
     * 开始分片构建节点树。
     *
     * 分片粒度: 只对 Root 的第一层 children 进行分片处理。
     * 整个构建流程拆成多个 postJSTask, 每个 postJSTask 只负责一个 Root 的第一层子节点(及其整棵子树):
     *   - 第0个 postJSTask: 构建 Root 节点本身(start 内部直接 enterNode)。
     *   - 第1个 postJSTask: 构建 Root 的第一个子节点及其整棵子树。
     *   - 第n个 postJSTask: 构建 Root 的第 n 个子节点及其整棵子树。
     *   - 最后: 额外提交一个结束 task, 结束 Root 节点并回调 onDone(None)。
     *
     * 实现直接通过 getFirstChild/getNext 遍历第一层 children, 为每个 child 提交一个
     * 独立的 postJSTask(无递归), 各 task 由 JS 事件循环按提交顺序串行执行, 让出主线程。
     * 子树内部仍用显式栈 while 循环做深度优先先序遍历, 模拟递归, 避免深文档栈溢出。
     *
     * onDone 回调在全部处理完毕(None)或处理过程抛异常(Some(异常))时被调用。
     */
    func start(root: Node, onDone: (?Exception) -> Unit): Unit {
        // 构建前重置 builder 状态, 支持复用同一个 builder 进行多次 parse。
        builder.callMethod('reset', [])
        failed = false
        // 第0个分片: 构建 Root 节点本身。
        enterNode(root)
        // 直接遍历 Root 的第一层直接子节点, 为每个 child 提交一个构建 task。
        var child = root.getFirstChild()
        while (let Some(c) <- child) {
            submitTask(c, onDone)
            child = c.getNext()
        }
        // 最后提交一个结束 task: 结束 Root 节点并回调 onDone(None)。
        context.postJSTask {
            try {
                if (!failed) {
                    builder.callMethod('endNode', [])
                    onDone(None)
                }
            } catch (e: Exception) {
                failed = true
                onDone(Some(e))
            }
        }
    }

    /*
     * 提交一个构建 task: 在单个 postJSTask 内构建某个第一层 child 及其整棵子树。
     * 无递归: 每个 task 由 start 的 while 循环独立提交, task 之间不相互调用。
     */
    func submitTask(child: Node, onDone: (?Exception) -> Unit): Unit {
        context.postJSTask {
            try {
                if (!failed) {
                    // 同步构建该 child 及其整棵子树。
                    buildSubtree(child)
                }
            } catch (e: Exception) {
                failed = true
                onDone(Some(e))
            }
        }
    }

    /*
     * 在单个 postJSTask 内, 用显式栈 while 循环构建某节点及其整棵子树。
     * 栈元素是"事件": Some(node) 表示进入该节点, None 表示离开当前节点(即回退到父节点)。
     * 注意: 此方法不跨 postJSTask, 局部栈随方法返回而销毁。
     */
    func buildSubtree(root: Node): Unit {
        let stack = ArrayStack<Option<Node>>()
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
    }

    // 返回构建好的根节点(在全部节点构建完成后调用)。
    func getRoot(): JSValue {
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
