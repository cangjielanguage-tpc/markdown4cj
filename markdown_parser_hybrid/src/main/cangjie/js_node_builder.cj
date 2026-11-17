package markdown_parser_hybrid

class JsNodeBuilder {
    // 下一个待处理的第一层 child(遍历游标)。
    // 作为成员字段保存, 使遍历状态可以在多个 postJSTask 之间保持。
    // 通过 getFirstChild/getNext 沿 Root 的兄弟链表顺序推进, 无需额外数组缓存。
    var nextChild: ?Node = None

    // 批量模式: builder 含 buildNodes 方法(即本仓导出的 JsNodeTreeBuilder)时启用,
    // 每个分片把整棵子树序列化为扁平事件数组, 单次跨语言调用推送, 由 JsNodeTreeBuilder.buildNodes 解析建树;
    // 否则退化为旧逐事件 callMethod, 兼容未提供 buildNodes 的自定义 builder, 行为与旧版完全一致。
    let batchMode: Bool

    // 当前分片累积的事件; 只在单个 postJSTask 内产生并消费(JSValue 不跨 postJSTask 缓存), flush 后清空。
    let events: ArrayList<JSValue>

    // 批量建树单次推送的事件实参上限(事件边界分块, 单事件不拆分)。
    // 来自 Options.buildNodesChunkSize, 非正值已在 HybridParser 侧回退默认 200。
    let batchChunkSize: Int64

    // onDone 在构造函数中注入, 无异常参数; 构建过程抛出的异常直接向上抛出, 由调用者 catch。
    JsNodeBuilder(chunkSize: Int64, let builder: JSObject, let context: JSContext, let onDone: () -> Unit) {
        // 批量能力检测: 取属性走 JS [[Get]] 语义, 能取到非 undefined/null 即支持批量。
        let bn = builder['buildNodes']
        batchMode = !(bn.isUndefined() || bn.isNull())
        // 参数合法性校验: 非正值(含 0)回退默认 200(对齐旧协议实证安全的最大实参数量)。
        batchChunkSize = if (chunkSize <= 0) { 200 } else { chunkSize }
        events = ArrayList<JSValue>()
    }

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
        // 第0个分片: 构建 Root 节点本身, 并在本 postJSTask 内 flush(JSValue 不跨 postJSTask 缓存)。
        enterNode(root)
        // 从 Root 的第一个 child 开始遍历第一层 children。
        nextChild = root.getFirstChild()
        flush()
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
            // 所有第一层 children 处理完毕, 结束 Root 节点(builder 的当前节点指针回退)并回调。
            // 标记 2=endNode。
            emit(2, "endNode", [])
            flush()
            onDone()
        }
    }

    /*
     * 在单个 postJSTask 内, 用显式栈 while 循环构建某节点及其整棵子树。
     * 栈元素是"事件": Some(node) 表示进入该节点, None 表示离开当前节点(即回退到父节点)。
     * 注意: 此方法不跨 postJSTask, 局部栈随方法返回而销毁; 事件在本 task 末尾一次性 flush。
     */
    func buildSubtree(root: Node): Unit {
        let stack = ArrayStack<Option<Node>>()
        stack.add(Some(root))
        while (!stack.isEmpty()) {
            match (stack.remove()) {
                // 进入事件: 依次发射 beginNode/sourceSpans/props/字段事件, 数据落在 builder 的当前节点上。
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
                // 离开事件: 结束当前节点, builder 的当前节点指针回退到父节点。标记 2=endNode。
                case _ =>
                    emit(2, "endNode", [])
            }
        }
        flush()
    }

    func enterNode(node: Node): Unit {
        // 标记 1=beginNode。
        emit(1, "beginNode", [
            context.string(node.getNodeType()).toJSValue(),
            context.string(node.toString()).toJSValue()
        ])
        setSourceSpans(node)
        if (let props: HashMap<String, Any> <- node.custom) {
            for ((k, v) in props) {
                if (let toStr: ToString <- v) {
                    // 标记 4=putProp。
                    emit(4, "putProp", [context.string(k).toJSValue(), context.string(toStr.toString()).toJSValue()])
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

    /*
     * 发射定长参数事件: 批量模式累积 [数字协议标记, ...args] 到事件数组,
     * 标记须与 JsNodeTreeBuilder.buildNodes 的数字 case 协议一致(1~8)。
     * 用数字而非字符串标记: 每个事件省一次 context.string 的 JS 字符串分配与 ArkTS switch 字符串比较,
     * 大文档事件量大时该成本主导建树耗时(实测批量路径比逐事件慢的主因)。
     * 非批量(兜底)模式直接按旧协议逐次 callMethod 真实方法名。
     */
    func emit(code: Int64, method: String, args: Array<JSValue>): Unit {
        if (batchMode) {
            flushIfFull(Int64(args.size) + 1)
            events.add(context.number(Float64(code)).toJSValue())
            for (a in args) {
                events.add(a)
            }
        } else {
            builder.callMethod(method, args)
        }
    }

    /*
     * 发射变长参数事件: 批量模式累积 [数字协议标记, count, ...values](count 供 buildNodes 定界);
     * 非批量(兜底)模式直接 callMethod 真实方法名(旧协议无 count 前缀)。
     */
    func emitList(code: Int64, method: String, values: Array<JSValue>): Unit {
        if (batchMode) {
            flushIfFull(Int64(values.size) + 2)
            events.add(context.number(Float64(code)).toJSValue())
            events.add(context.number(Float64(values.size)).toJSValue())
            for (v in values) {
                events.add(v)
            }
        } else {
            builder.callMethod(method, values)
        }
    }

    /*
     * 事件缓冲接近上限时, 在事件边界提前 flush(单事件整体入队, 绝不跨调用拆分)。
     * 上限由 Options.buildNodesChunkSize 配置, 默认 200 对齐旧协议实证安全的最大实参数量
     * (addSourceSpans 50 span 组 = 202 个实参)——更大的单次 callMethod 实参列表会触发
     * ark_interop 的 JSInteropNativeError(不可捕获, 进程终止)。
     * 单事件自身超过上限时仍整体入队(单次 callMethod), 不做事件内拆分。
     */
    func flushIfFull(nextEventSize: Int64): Unit {
        if (batchMode && events.size + nextEventSize > batchChunkSize) {
            flush()
        }
    }

    /*
     * 把本分片累积的事件一次性推送给 builder 并清空。
     * 批量模式单次 callMethod('buildNodes', ...), 跨语言调用次数从每节点 4~10 次降为每分片 1 次;
     * 非批量模式 events 恒空, 此处仅兜底清空。
     */
    func flush(): Unit {
        if (batchMode && events.size > 0) {
            builder.callMethod("buildNodes", events.toArray())
        }
        events.clear()
    }

    func setField(name: String, value: JSValue): Unit {
        // 标记 3=setField。
        emit(3, "setField", [context.string(name).toJSValue(), value])
    }

    func putImageStyles(styles: ArrayList<String>): Unit {
        // 标记 7=putImageStyles。
        emitList(7, "putImageStyles", styles |> map {v => context.string(v).toJSValue()} |> collectArray)
    }

    func putSpanNodeAttr(attrs: ?HashMap<String, String>): Unit {
        if (let Some(attrs) <- attrs) {
            for ((k, v) in attrs) {
                // 标记 5=putSpanNodeAttr。
                emit(5, "putSpanNodeAttr", [context.string(k).toJSValue(), context.string(v).toJSValue()])
            }
        }
    }

    func putSpanNodeStyle(style: ?HashMap<String, String>): Unit {
        if (let Some(style) <- style) {
            for ((k, v) in style) {
                // 标记 6=putSpanNodeStyle。
                emit(6, "putSpanNodeStyle", [context.string(k).toJSValue(), context.string(v).toJSValue()])
            }
        }
    }

    func setSourceSpans(node: Node): Unit {
        let sourceSpans = node.getSourceSpans()
        // 50个一组 批量添加SourceSpan(includeSourceSpans=0 时为空数组, 循环零次天然跳过)
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
            // 标记 8=addSourceSpans。
            emitList(8, "addSourceSpans", sourceSpansFlatten)
        }
    }
}
