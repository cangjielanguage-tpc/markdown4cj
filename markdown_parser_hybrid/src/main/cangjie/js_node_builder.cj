package markdown_parser_hybrid

class JsNodeBuilder {
    // 下一个待处理的第一层 child(遍历游标)。
    // 作为成员字段保存, 使遍历状态可以在多个 postJSTask 之间保持。
    // 通过 getFirstChild/getNext 沿 Root 的兄弟链表顺序推进, 无需额外数组缓存。
    var nextChild: ?Node = None

    // onDone 在构造函数中注入, 无异常参数; 构建过程抛出的异常直接向上抛出, 由调用者 catch。
    JsNodeBuilder(let builder: JSObject, let context: JSContext, let onDone: () -> Unit) {}

    /*
     * 开始分片构建节点树。
     *
     * 分片粒度: 只对 Root 的第一层 children 进行分片处理。
     * 整个构建流程拆成多个 postJSTask, 每个 postJSTask 只负责一个 Root 的第一层子节点(及其整棵子树):
     *   - 第0个 postJSTask: 构建 Root 节点本身(start 内部直接 enterNode, 并记录第一个 child 为遍历起点)。
     *   - 第1个 postJSTask: 取出 Root 的第一个子节点, 在单个 task 内构建它及其整棵子树。
     *   - 第n个 postJSTask: 取出 Root 的第 n 个子节点, 同样在单个 task 内构建其整棵子树。
     *   - 最后: 所有第一层 children 处理完后, 结束 Root 节点并回调 onDone()。
     *
     * 子树内部仍用显式栈 while 循环做深度优先先序遍历, 模拟递归, 避免深文档栈溢出。
     * 这样既避免"一次性构建整棵树"导致单次 postJSTask 占用主线程过久, 又避免"逐节点分片"
     * 带来的过多 task 调度开销, 在流畅度与效率之间取得平衡。
     *
     * onDone(无异常参数)在全部处理完毕后回调; 处理过程抛出的异常直接向上抛出, 由调用者 catch。
     */
    func start(root: Node): Unit {
        // 构建前重置 builder 状态, 支持复用同一个 builder 进行多次 parse。
        builder.callMethod('reset', [])
        // 第0个分片: 构建 Root 节点本身。
        enterNode(root)
        // 从 Root 的第一个 child 开始遍历第一层 children。
        nextChild = root.getFirstChild()
        scheduleNext()
    }

    // 调度下一个分片任务, 每个分片处理 Root 的一个第一层子节点及其整棵子树。
    func scheduleNext(): Unit {
        context.postJSTask {
            step()
        }
    }

    // 处理 Root 的一个第一层子节点; 游标非空则继续调度下一个分片, 否则结束 Root 并回调 onDone()。
    func step(): Unit {
        if (let Some(child) <- nextChild) {
            // 先沿兄弟链表推进游标, 再构建当前 child 及其整棵子树。
            nextChild = child.getNext()
            buildSubtree(child)
            scheduleNext()
        } else {
            // 所有第一层 children 处理完毕, 结束 Root 节点(回退当前节点指针)。
            builder.callMethod('endNode', [])
            onDone()
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
