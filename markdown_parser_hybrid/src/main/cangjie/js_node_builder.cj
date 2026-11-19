package markdown_parser_hybrid

// 字段数字 ID: 批量协议中用数字替代字段名字符串, 省掉每个字段一次 context.string(key)
// 的 JS 字符串构造与跨语言传输。编号必须与 JsNodeTreeBuilder.setFieldById 的 case 一一对应。
const F_ISDONE: Int64 = 1
const F_LATEX: Int64 = 2
const F_IS_CLOSED: Int64 = 3
const F_NOTEID: Int64 = 4
const F_BLOCK_INDEX: Int64 = 5
const F_LITERAL: Int64 = 6
const F_DESTINATION: Int64 = 7
const F_TITLE: Int64 = 8
const F_TEXT: Int64 = 9
const F_LABEL: Int64 = 10
const F_HEAD_INDEX: Int64 = 11
const F_DELIMITER: Int64 = 12
const F_FENCE_CHAR: Int64 = 13
const F_FENCE_LENGTH: Int64 = 14
const F_FENCE_INDENT: Int64 = 15
const F_INFO: Int64 = 16
const F_LEVEL: Int64 = 17
const F_IS_TIGHT: Int64 = 18
const F_BULLET_MARKER: Int64 = 19
const F_START_NUMBER: Int64 = 20
const F_IS_HEADER: Int64 = 21
const F_ALIGNMENT: Int64 = 22
const F_WIDTH: Int64 = 23
const F_HEIGHT: Int64 = 24
const F_COLOR: Int64 = 25
const F_SIZE: Int64 = 26
const F_NAME: Int64 = 27
const F_DATA: Int64 = 28
// toStr 是 debug 开启才有的可选内容, 作为一个普通字段事件传输(debug 关闭时不产生任何事件)。
const F_TOSTR: Int64 = 29

/*
 * 节点类型数字 ID: 批量协议里用数字替代 nodeType 字符串, 省掉每节点一次
 * context.string(...) 的跨语言字符串构造。必须与 ArkTS 侧 resolveNodeType 的 case 一一对应。
 * 未登记的类型(新插件)自动回退为字符串传输, 因此新增类型无需改协议即可工作。
 */
let NODE_TYPE_IDS = HashMap<String, Int64>([
    ("Document", 1), ("Paragraph", 2), ("Heading", 3), ("Text", 4), ("Code", 5),
    ("HtmlInline", 6), ("HtmlBlock", 7), ("IndentedCodeBlock", 8), ("FencedCodeBlock", 9),
    ("Link", 10), ("Image", 11), ("Emphasis", 12), ("StrongEmphasis", 13), ("BlockQuote", 14),
    ("BulletList", 15), ("OrderedList", 16), ("ListItem", 17), ("ThematicBreak", 18),
    ("SoftLineBreak", 19), ("HardLineBreak", 20), ("LinkReferenceDefinition", 21),
    ("ListBlock", 22), ("TableBlock", 23), ("TableHead", 24), ("TableBody", 25),
    ("TableRow", 26), ("TableCell", 27), ("StyleImage", 28), ("ImageHtmlNode", 29),
    ("SpanNode", 30), ("FontNode", 31), ("CardNode", 32), ("LatexMathBlock", 33),
    ("LatexMathNode", 34), ("TaskListItem", 35), ("Footnote", 36), ("FootnoteBlock", 37),
    ("IdHeading", 38), ("HeadLink", 39), ("TocBlock", 40), ("ImgVideo", 41),
    ("Strikethrough", 42), ("DescList", 43), ("DescTerm", 44), ("DescDef", 45),
    ("SubNode", 46), ("SupNode", 47), ("UnderlineNode", 48), ("SubHtmlNode", 49),
    ("SupHtmlNode", 50), ("IgnoreBlockNode", 51), ("IgnoreInlineNode", 52),
    ("FencedCodeBlockListBlock", 53)
])

// 帧的发射阶段: beginNode -> 字段 -> sourceSpans -> custom props -> 附加事件 -> 子节点 -> endNode。
const PHASE_BEGIN: Int64 = 0
const PHASE_FIELDS: Int64 = 1
const PHASE_SPANS: Int64 = 2
const PHASE_PROPS: Int64 = 3
const PHASE_EXTRAS: Int64 = 4
const PHASE_CHILDREN: Int64 = 5
const PHASE_END: Int64 = 6

/*
 * 节点树构建器(抽象基类): 把解析得到的 Node AST 驱动 ArkTS 侧的 JsNodeTreeBuilder 建树。
 *
 * 本类只负责"遍历状态机 + 阶段调度", 与 ArkTS 互通的方式全部收敛到下面列出的传输原语,
 * 由两个子类实现:
 *   - JsNodeBuilderBatch    : 批量协议。动作先序列化成扁平事件数组, 每个 postJSTask 用一次
 *                             callMethod("buildNodes", events) 推送, 解码与建树在 ArkTS 侧完成;
 *   - JsNodeBuilderNonBatch : 非批量兜底。每产生一个动作就单独 callMethod 一次
 *                             (beginNode/setField/putProp/...), 兼容自定义 builder。
 * 两者的选择发生在 createJsNodeBuilder: builder 含 buildNodes 方法时用批量实现。
 * 两种实现产生完全相同的节点树, 阶段顺序也完全一致。
 *
 * 一、分片模型
 *   - frames 是成员帧栈, 栈顶帧即当前处理位置, 因此遍历可在任意事件边界暂停并原样恢复;
 *   - 一个 task 内循环 advance 推进栈顶帧, 每次发射前由子类的传输原语判断能否继续;
 *   - 批量模式: 包满即 flush 并让出 task, 下个 task 从同一帧、同一游标继续,
 *     推送次数 ≈ ceil(总实参 / chunkSize), 与文档结构、设备性能无关;
 *   - 非批量模式: 一个 Root 第一层子节点结束就让出 task, 与引入批量协议前的分片粒度一致。
 *
 * 二、每个节点的发射阶段(顺序固定, 帧内可被 task 边界打断后原样恢复)
 *   PHASE_BEGIN    -> 1        beginNode, 节点入栈
 *   PHASE_FIELDS   -> 3        每个字段一条(含 toStr, 仅 debug)
 *   PHASE_SPANS    -> 8        每个 SourceSpan 一条(仅 debug 且 includeSourceSpans > 0)
 *   PHASE_PROPS    -> 4        每个自定义属性一条
 *   PHASE_EXTRAS   -> 5/6/7    span 属性、span 样式、图片样式
 *   PHASE_CHILDREN -> 子节点帧逆序压栈, 出栈即从左到右的先序
 *   PHASE_END      -> 2        endNode, 节点出栈
 *   表中箭头后的数字是批量协议标记, 非批量模式没有事件数组, 对应的是 builder 的同名方法。
 *
 * 三、批量事件协议(数字标记, 与 JsNodeTreeBuilderBatch.buildNodes 一一对应)
 *
 *   标记  事件              形状                               实参
 *   1     beginNode         [1, nodeType]                      2
 *   2     endNode           [2]                                1
 *   3     setField          [3, fieldId, value]                3
 *   4     putProp           [4, key, value]                    3
 *   5     putSpanNodeAttr   [5, key, value]                    3
 *   6     putSpanNodeStyle  [6, key, value]                    3
 *   7     putImageStyles    [7, count, v1..vN]                 2+N
 *   8     addSourceSpans    [8, 4, line, col, inputIdx, len]   6
 *   9     leafNode         [9, nodeType, literal]              3
 *
 *   - 9 是批量路径的叶子快速事件(Text/HtmlInline/Code/HtmlBlock/IndentedCodeBlock 且无插件属性):
 *     等价于 1 + 3(literal) + 2, 仅 debug=false 且 includeSourceSpans=0 时发射;
 *     不满足条件时仍走通用序列, 两条路径产出的节点树完全一致。
 *   - 除 7/8 外全部定长, 因此 chunkSize 是每个事件的硬上限;
 *     7 的样式数由发送端按 max(1, min(chunkSize-2, 253)) 分片, 保证单次调用实参不超过 255。
 *   - 3/4/5/6/7/8 都作用于"最近一个 1 打开的节点", 事件顺序即语义, 不能跨节点重排。
 *   - fieldId 见文件开头的 F_* 常量(1..29), 必须与 ArkTS 侧 setFieldById 的 case 严格一致;
 *     29=toStr 仅在 debug=true 时发送, 默认路径不产生该事件。
 *
 * 四、跨 task 不变量
 *   - events / pendingFields 里的 JSValue 只在当前 postJSTask 内有效, 绝不可跨 task 缓存;
 *   - 字段发射中途包满时, 清空 pendingFields 并把 fieldsLoaded 置回 false, 下个 task 重新收集,
 *     再由 frame.index 跳过已发字段。漏掉重置会让缓冲变短而静默丢字段,
 *     回归用例 buildNodesFieldSplitInvariant 断言不同 chunkSize 下总实参严格一致。
 */
abstract class JsNodeBuilder {
    // 待处理的节点帧栈(成员): 遍历状态在多个 postJSTask 之间保持。
    // 栈顶永远是被处理的那一帧; 子节点帧压在父帧之上, 保证父帧在所有子节点结束后才发射 endNode。
    let frames = ArrayList<Frame>()

    // 当前节点待推送的字段 (ID, value) 缓冲, 只在单个 postJSTask 内有效。
    // 批量模式由 phaseFields 逐个发成标记 3 事件; 包满时缓冲里的 JSValue 不能跨 task 保留,
    // 丢弃后由下个 task 重新收集并按 index 跳过已发字段。
    let pendingFields = ArrayList<(Int64, JSValue)>()

    // 本 task 是否已到分片边界(由 phaseEnd 在节点出栈后判定), pump 看到后让出 task。
    var yieldRequested: Bool = false

    // onDone 在构造函数中注入, 无异常参数; 构建过程抛出的异常直接向上抛出, 由调用者 catch。
    JsNodeBuilder(let includeSourceSpans: Int64, let debug: Bool, let builder: JSObject,
        let context: JSContext, let onDone: () -> Unit) {
    }

    /*
     * 开始构建节点树: 重置 builder(支持复用), 压入根帧, 进入第一个 task。
     * 后续流程见类注释"分片模型": 每个 task 推进到包边界(或分片边界)后让出, 遍历完成后收尾并回调 onDone。
     * 处理过程抛出的异常直接向上抛出, 由调用者 catch。
     */
    func start(root: Node): Unit {
        // 构建前重置 builder 状态, 支持复用同一个 builder 进行多次 parse。
        builder.callMethod('reset', [])
        frames.clear()
        frames.add(Frame(root, 0))
        pump()
    }

    // 调度下一个分片任务, 从帧栈断点继续。
    func scheduleNext(): Unit {
        context.postJSTask {
            pump()
        }
    }

    /*
     * 单个 postJSTask 的执行体: 沿帧栈做先序遍历。
     * advance 返回 false 表示本包已满并已推送, 此时帧状态未推进, 直接结束本 task;
     * yieldAfterNodeEnd 为 true 表示到达非批量模式的分片边界;
     * 帧栈为空表示遍历完成, 收尾并回调。
     */
    func pump(): Unit {
        while (!frames.isEmpty()) {
            let frame = frames[frames.size - 1]
            if (!advance(frame)) {
                scheduleNext()
                return
            }
            // 非批量模式: 根的第一层子节点结束后让出 task; 批量模式恒为 false(由包边界决定)。
            if (yieldRequested) {
                yieldRequested = false
                scheduleNext()
                return
            }
        }
        flush()
        onDone()
    }

    // 推进栈顶帧一步; 返回 false 表示需要让出 task(帧状态未推进)。
    func advance(frame: Frame): Bool {
        let phase = frame.phase
        if (phase == PHASE_BEGIN) {
            return phaseBegin(frame)
        }
        if (phase == PHASE_FIELDS) {
            return phaseFields(frame)
        }
        if (phase == PHASE_SPANS) {
            return phaseSpans(frame)
        }
        if (phase == PHASE_PROPS) {
            return phaseProps(frame)
        }
        if (phase == PHASE_EXTRAS) {
            return phaseExtras(frame)
        }
        if (phase == PHASE_CHILDREN) {
            expandChildren(frame)
            return true
        }
        return phaseEnd(frame)
    }

    /*
     * 阶段 0: beginNode, 定长事件 [1, nodeType](2 实参)。
     * 字段(含仅 debug 才有的 toStr)全部由随后阶段 1 的每个字段一个 [3, id, value] 事件完成,
     * 保证所有事件大小固定, chunkSize 对每个事件都是硬上限。
     */
    // 批量子类会覆盖此阶段以启用叶子快速路径; 基类实现保持原样供非批量路径使用。
    protected open func phaseBegin(frame: Frame): Bool {
        if (!beginNodeEvent(frame.node)) {
            return false
        }
        frame.phase = PHASE_FIELDS
        return true
    }

    /*
     * 只有 literal 字段、且必然是叶子的节点类型; 批量路径可用单个事件 9 完成建节点+赋 literal+出栈。
     * 新增此类叶子时在这里扩展; 其他类型返回 None, 始终回落到通用的 1/3/2 序列(保证正确性)。
     */
    protected func simpleLeafLiteral(node: Node): ?String {
        match (node) {
            case v: Text => return Some(v.getLiteral())
            case v: HtmlInline => return Some(v.getLiteral())
            case v: Code => return Some(v.getLiteral())
            case v: HtmlBlock => return Some(v.getLiteral())
            case v: IndentedCodeBlock => return Some(v.getLiteral())
            case _ => return None
        }
    }

    /*
     * 阶段 1: 节点字段, 每个字段一个定长事件 [3, id, value](3 实参)。
     * pendingFields 里的 JSValue 不能跨 task, 包满时清空缓冲并在下个 task 重新收集,
     * 由 frame.index 跳过已发射的字段。
     */
    func phaseFields(frame: Frame): Bool {
        if (!frame.fieldsLoaded) {
            frame.fieldsLoaded = true
            pendingFields.clear()
            collectFields(frame.node)
        }
        while (frame.index < Int64(pendingFields.size)) {
            let (id, value) = pendingFields[frame.index]
            if (!fieldEvent(id, value)) {
                // 缓冲里的 JSValue 不能跨 task: 必须清空并标记未加载, 下个 task 重新收集后按 index 跳过已发字段。
                pendingFields.clear()
                frame.fieldsLoaded = false
                return false
            }
            frame.index++
        }
        pendingFields.clear()
        frame.phase = PHASE_SPANS
        frame.index = 0
        return true
    }

    /*
     * 阶段 2: sourceSpans, 每个 span 一个事件(标记 8 + count=4 + 4 个数字, 共 6 实参)。
     * 事件大小与节点上的 span 数量无关, 因此包内不存在"一组 span 独占一个包"的嵌套结构,
     * chunkSize 对每个事件都是有效上限(仅单事件本身超过 chunkSize 时才独占一包)。
     * 分层: includeSourceSpans=0 不调用 getSourceSpans; =1 仅 Block 节点; =2 全部节点。
     */
    func phaseSpans(frame: Frame): Bool {
        if (!frame.spansLoaded) {
            frame.spansLoaded = true
            var needSpans = includeSourceSpans > 0
            if (needSpans && includeSourceSpans == 1) {
                // =1 时解析库只给 Block 节点附加 span, 非 Block 节点必然为空。
                match (frame.node) {
                    case _: Block => ()
                    case _ => needSpans = false
                }
            }
            if (needSpans) {
                let spans = frame.node.getSourceSpans()
                if (!spans.isEmpty()) {
                    frame.spans = Some(spans)
                }
            }
        }
        if (let Some(spans) <- frame.spans) {
            if (frame.index < spans.size) {
                if (!spanEvent(spans[frame.index])) {
                    return false
                }
                frame.index++
                return true
            }
        }
        frame.phase = PHASE_PROPS
        frame.index = 0
        return true
    }

    /*
     * 阶段 3: 节点自定义属性, 每个属性一个事件(标记 4=putProp)。
     * HashMap 无法按下标续发, 首次进入时物化为数组(只有带 custom 属性的节点才分配)。
     */
    func phaseProps(frame: Frame): Bool {
        if (!frame.propsLoaded) {
            frame.propsLoaded = true
            frame.props = collectProps(frame.node)
        }
        if (let Some(props) <- frame.props) {
            if (frame.index < props.size) {
                let (k, v) = props[frame.index]
                if (!propEvent(k, v)) {
                    return false
                }
                frame.index++
                return true
            }
        }
        frame.phase = PHASE_EXTRAS
        frame.index = 0
        return true
    }

    /*
     * 阶段 4: 附加事件 — span 属性(5)/span 样式(6)/图片样式(7), 均作用于当前节点。
     * 图片样式是变长事件(标记 7 + count + N), 由子类按单次调用实参上限分片;
     * imageStyleIndex 记录已发样式数, 包满中断后从同一位置续发(不可归零, 否则重复追加)。
     */
    func phaseExtras(frame: Frame): Bool {
        if (!frame.extrasLoaded) {
            frame.extrasLoaded = true
            frame.extras = collectExtras(frame.node)
            frame.imageStyles = collectImageStyles(frame.node)
        }
        if (let Some(extras) <- frame.extras) {
            if (frame.index < extras.size) {
                let (code, k, v) = extras[frame.index]
                if (!extraEvent(code, k, v)) {
                    return false
                }
                frame.index++
                return true
            }
        }
        if (let Some(styles) <- frame.imageStyles) {
            while (frame.imageStyleIndex < Int64(styles.size)) {
                let next = imageStylesEvent(styles, frame.imageStyleIndex)
                if (next < 0) {
                    return false
                }
                frame.imageStyleIndex = next
            }
            frame.imageStyles = None
        }
        frame.phase = PHASE_CHILDREN
        frame.index = 0
        return true
    }

    /*
     * 阶段 5: 子节点从 lastChild 反向入栈(LIFO 弹出即从左到右), 父帧进入阶段 6,
     * 待所有子节点出栈后再发射 endNode, 使 builder 的当前节点指针正确回退。
     */
    func expandChildren(frame: Frame): Unit {
        frame.phase = PHASE_END
        var child = frame.node.getLastChild()
        while (let Some(c) <- child) {
            frames.add(Frame(c, frame.depth + 1))
            child = c.getPrevious()
        }
    }

    // 阶段 6: 发射 endNode(标记 2)并弹出本帧; 出栈后再按被弹出帧的深度判定分片边界。
    func phaseEnd(frame: Frame): Bool {
        if (!endNodeEvent()) {
            return false
        }
        let poppedDepth = frame.depth
        frames.remove(at: frames.size - 1)
        yieldRequested = yieldAfterNodeEnd(poppedDepth)
        return true
    }

    /*
     * 调试选项: 开启时返回 node.toString()(供 printNode 等调试输出),
     * 关闭时返回空串, 避免每个节点都构造一次含文本的完整字符串(默认关闭)。
     */
    func nodeToString(node: Node): String {
        return if (debug) { node.toString() } else { "" }
    }

    /*
     * 收集节点字段: 全部写入 pendingFields 缓冲, 由 phaseFields 逐个交给 fieldEvent。
     * 顺序即事件顺序; toStr 与普通字段同构(debug 关闭时不产生该字段),
     * 因此批量/非批量两条路径的字段序列完全一致。
     */
    func collectFields(node: Node): Unit {
        if (debug) {
            setField(F_TOSTR, context.string(nodeToString(node)).toJSValue())
        }
        match (node) {
            case v: TaskListItem => setField(F_ISDONE, context.boolean(v.isDone()).toJSValue())
            case v: LatexMathBlock =>
                setField(F_LATEX, context.string(v.latex).toJSValue())
                setField(F_IS_CLOSED, context.boolean(v.isClosed).toJSValue())
            case v: LatexMathNode => setField(F_LATEX, context.string(v.latex).toJSValue())
            case v: Footnote =>
                setField(F_NOTEID, context.string(v.noteid).toJSValue())
                setField(F_BLOCK_INDEX, context.number(Float64(v.block?.blockIndex ?? -1)).toJSValue())
            case v: FootnoteBlock =>
                setField(F_NOTEID, context.string(v.noteid).toJSValue())
                setField(F_BLOCK_INDEX, context.number(Float64(v.blockIndex)).toJSValue())
            case v: Text => setField(F_LITERAL, context.string(v.getLiteral()).toJSValue())
            case v: HtmlInline => setField(F_LITERAL, context.string(v.getLiteral()).toJSValue())
            case v: Image =>
                setField(F_DESTINATION, context.string(v.getDestination()).toJSValue())
                if (let Some(t) <- v.getTitle()) {
                    setField(F_TITLE, context.string(t).toJSValue())
                }
                match (v) {
                    case i: ImgVideo => setField(F_TEXT, context.string(i.text).toJSValue())
                    case _ => ()
                }
            case v: Code => setField(F_LITERAL, context.string(v.getLiteral()).toJSValue())
            case v: LinkReferenceDefinition =>
                if (let Some(l) <- v.getLabel()) {
                    setField(F_LABEL, context.string(l).toJSValue())
                }
                setField(F_DESTINATION, context.string(v.getDestination()).toJSValue())
                if (let Some(t) <- v.getTitle()) {
                    setField(F_TITLE, context.string(t).toJSValue())
                }
            case v: Link =>
                setField(F_DESTINATION, context.string(v.getDestination()).toJSValue())
                if (let Some(t) <- v.getTitle()) {
                    setField(F_TITLE, context.string(t).toJSValue())
                }
                match (v) {
                    case l: HeadLink => setField(F_HEAD_INDEX, context.number(Float64(l.headIndex)).toJSValue())
                    case _ => ()
                }
            case v: Delimited =>
                if (let Some(d) <- v.getOpeningDelimiter()) {
                    setField(F_DELIMITER, context.string(d).toJSValue())
                }
            case v: HtmlBlock => setField(F_LITERAL, context.string(v.getLiteral()).toJSValue())
            case v: IndentedCodeBlock => setField(F_LITERAL, context.string(v.getLiteral()).toJSValue())
            case v: FencedCodeBlock =>
                setField(F_FENCE_CHAR, context.string(v.getFenceChar().toString()).toJSValue())
                setField(F_FENCE_LENGTH, context.number(Float64(v.getFenceLength())).toJSValue())
                setField(F_FENCE_INDENT, context.number(Float64(v.getFenceIndent())).toJSValue())
                setField(F_INFO, context.string(v.getInfo()).toJSValue())
                setField(F_LITERAL, context.string(v.getLiteral()).toJSValue())
            case v: Heading => setField(F_LEVEL, context.number(Float64(v.getLevel())).toJSValue())
            case v: BulletList =>
                setField(F_IS_TIGHT, context.boolean(v.isTight()).toJSValue())
                setField(F_BULLET_MARKER, context.string(v.getBulletMarker().toString()).toJSValue())
            case v: OrderedList =>
                setField(F_IS_TIGHT, context.boolean(v.isTight()).toJSValue())
                setField(F_START_NUMBER, context.number(Float64(v.getStartNumber())).toJSValue())
                setField(F_DELIMITER, context.string(v.getDelimiter().toString()).toJSValue())
            case v: TableCell =>
                setField(F_IS_HEADER, context.boolean(v.isHeader()).toJSValue())
                if (let Some(a) <- v.getAlignment()) {
                    setField(F_ALIGNMENT, context.string(a.toString()).toJSValue())
                }
                setField(F_WIDTH, context.number(Float64(v.getWidth())).toJSValue())
            case v: ImageHtmlNode =>
                setField(F_DESTINATION, context.string(v.getDestination()).toJSValue())
                if (let Some(w) <- v.getWidth()) {
                    setField(F_WIDTH, context.string(w).toJSValue())
                }
                if (let Some(h) <- v.getHeight()) {
                    setField(F_HEIGHT, context.string(h).toJSValue())
                }
            case v: FontNode =>
                if (let Some(c) <- v.getColor()) {
                    setField(F_COLOR, context.string(c).toJSValue())
                }
                if (let Some(s) <- v.getSize()) {
                    setField(F_SIZE, context.string(s).toJSValue())
                }
            case v: CardNode =>
                setField(F_NAME, context.string(v.getName()).toJSValue())
                setField(F_DATA, context.string(v.getData()).toJSValue())
            case _ => ()
        }
    }

    /*
     * 记录一个字段到待发缓冲。批量模式由 phaseFields 转成 [3, id, value] 事件,
     * 非批量模式由子类按旧协议转成 builder.setField(字段名, value)。
     */
    func setField(id: Int64, value: JSValue): Unit {
        pendingFields.add((id, value))
    }

    /*
     * 物化节点自定义属性(标记 4=putProp 的内容), 供 phaseProps 按下标续发。
     * 只有带 custom 属性的节点才分配数组; 无属性返回 None。
     */
    func collectProps(node: Node): ?ArrayList<(String, String)> {
        if (let props: HashMap<String, Any> <- node.custom) {
            let list = ArrayList<(String, String)>()
            for ((k, v) in props) {
                if (let toStr: ToString <- v) {
                    list.add((k, toStr.toString()))
                }
            }
            if (!list.isEmpty()) {
                return Some(list)
            }
        }
        return None
    }

    /*
     * 物化节点附加事件: span 属性(标记 5)/span 样式(标记 6)。
     * 这些事件作用于 builder 的当前节点, 因此必须排在 beginNode 之后。
     */
    func collectExtras(node: Node): ?ArrayList<(Int64, String, String)> {
        match (node) {
            case v: SpanNode =>
                let list = ArrayList<(Int64, String, String)>()
                if (let Some(attrs) <- v.getAttrs()) {
                    for ((k, val) in attrs) {
                        list.add((5, k, val))
                    }
                }
                if (let Some(style) <- v.getStyle()) {
                    for ((k, val) in style) {
                        list.add((6, k, val))
                    }
                }
                if (!list.isEmpty()) {
                    return Some(list)
                }
            case _ => ()
        }
        return None
    }

    // 图片样式(标记 7 的单个变长事件内容), 只有 StyleImage 且样式非空时才分配。
    func collectImageStyles(node: Node): ?ArrayList<String> {
        match (node) {
            case v: StyleImage =>
                if (!v.styles.isEmpty()) {
                    return Some(v.styles)
                }
            case _ => ()
        }
        return None
    }

    // ---- 传输原语: 由子类实现, 返回值 false 表示本包已满并已推送, 调用方须原样退出让出 task。----

    // 阶段 0: beginNode(批量 = 事件 1; 非批量 = callMethod('beginNode', [type]))。
    protected func beginNodeEvent(node: Node): Bool

    // 阶段 1: 单个字段(批量 = 事件 3; 非批量 = callMethod('setField', [name, value]))。
    protected func fieldEvent(id: Int64, value: JSValue): Bool

    // 阶段 2: 单个 sourceSpan(批量 = 事件 8; 非批量 = callMethod('addSourceSpans', 4 个数字))。
    protected func spanEvent(span: SourceSpan): Bool

    // 阶段 3: 单个自定义属性(批量 = 事件 4; 非批量 = callMethod('putProp', ...))。
    protected func propEvent(k: String, v: String): Bool

    // 阶段 4: 单个附加事件(批量 = 事件 5/6; 非批量 = callMethod('putSpanNodeAttr'/'putSpanNodeStyle', ...))。
    protected func extraEvent(code: Int64, k: String, v: String): Bool

    // 阶段 4: 图片样式分片(批量 = 变长事件 7; 非批量 = callMethod('putImageStyles', values))。
    // from 为本次起始下标, 返回已发到的下标(下次从这里续发); 返回 -1 表示本包已满且未发射, 须让出 task。
    protected func imageStylesEvent(styles: ArrayList<String>, from: Int64): Int64

    // 阶段 6: endNode(批量 = 事件 2; 非批量 = callMethod('endNode'))。
    protected func endNodeEvent(): Bool

    // 让出 task 前的收尾: 批量模式推送当前包并清空, 非批量模式无缓冲。
    protected func flush(): Unit

    // 节点出栈后是否需要让出 task(poppedDepth 为被弹出帧的深度, Root=0)。
    // 非批量模式在根的第一层子节点(depth==1)结束时让出, 批量模式恒 false。
    protected func yieldAfterNodeEnd(poppedDepth: Int64): Bool
}

/*
 * 子类实现之一(主路径): 批量协议实现。
 *
 * 动作先序列化成扁平事件数组(见基类注释"批量事件协议"), 每个 postJSTask 用一次
 * callMethod("buildNodes", events) 推送; chunkSize 是单次推送的实参上限(事件不拆分),
 * 包满即推送并让出 task, 下个 task 从同一帧、同一游标继续。
 */
class JsNodeBuilderBatch <: JsNodeBuilder {
    // 当前分片累积的事件; 只在单个 postJSTask 内产生并消费(JSValue 不跨 postJSTask 缓存), flush 后清空。
    let events = ArrayList<JSValue>()

    // 批量建树单次推送的事件实参上限(事件边界分块, 单事件不拆分)。
    // 来自 Options.buildNodesChunkSize, 非正值回退默认 200(对齐旧协议实证安全的最大实参数量)。
    var batchChunkSize: Int64 = 200

    JsNodeBuilderBatch(chunkSize: Int64, includeSourceSpans: Int64, debug: Bool, builder: JSObject,
        context: JSContext, onDone: () -> Unit) {
        super(includeSourceSpans, debug, builder, context, onDone)
        batchChunkSize = if (chunkSize <= 0) { 200 } else { chunkSize }
    }

    /*
     * 阶段 0 覆盖: 先尝试叶子单事件快速路径。
     * 条件: debug 关闭(无 toStr/span)、节点无插件自定义属性、类型属于只有 literal 字段的叶子。
     * 不满足任一条件时与基类完全一致(1/3/.../2), 因此非批量路径不受影响(仍用基类实现)。
     * 文本类文档中叶子占多数, 这一步把每叶子的 3 个事件(7 个实参)压成 1 个事件(3 个实参)。
     */
    protected override func phaseBegin(frame: Frame): Bool {
        if (debug || includeSourceSpans > 0 || frame.node.custom.isSome()) {
            return generalBegin(frame)
        }
        match (simpleLeafLiteral(frame.node)) {
            case Some(literal) =>
                if (!ensureRoom(3)) {
                    return false
                }
                emitEvent(9, nodeTypeValue(frame.node), context.string(literal).toJSValue())
                let poppedDepth = frame.depth
                frames.remove(at: frames.size - 1)
                yieldRequested = yieldAfterNodeEnd(poppedDepth)
                return true
            case None => return generalBegin(frame)
        }
    }

    // 通用阶段 0: beginNode 后进入字段阶段。
    func generalBegin(frame: Frame): Bool {
        if (!beginNodeEvent(frame.node)) {
            return false
        }
        frame.phase = PHASE_FIELDS
        return true
    }

    protected override func beginNodeEvent(node: Node): Bool {
        if (!ensureRoom(2)) {
            return false
        }
        emitEvent(1, nodeTypeValue(node))
        return true
    }

    /*
     * 节点类型传参: 已登记类型走数字 ID(省一次跨语言字符串构造), 未登记类型回退为字符串,
     * 因此新增插件类型无需同步协议表即可正常工作。
     */
    func nodeTypeValue(node: Node): JSValue {
        let nodeType = node.getNodeType()
        match (NODE_TYPE_IDS.get(nodeType)) {
            case Some(id) => return context.number(Float64(id)).toJSValue()
            case None => return context.string(nodeType).toJSValue()
        }
    }

    protected override func fieldEvent(id: Int64, value: JSValue): Bool {
        if (!ensureRoom(3)) {
            return false
        }
        emitEvent(3, context.number(Float64(id)).toJSValue(), value)
        return true
    }

    protected override func spanEvent(span: SourceSpan): Bool {
        if (!ensureRoom(6)) {
            return false
        }
        // 标记 8 + count=4 + 4 个数字。count 是后续数字个数(不是 span 个数), 与 JsNodeTreeBuilder 的 case 8 定界一致。
        events.add(context.number(8).toJSValue())
        events.add(context.number(4).toJSValue())
        events.add(context.number(Float64(span.getLineIndex())).toJSValue())
        events.add(context.number(Float64(span.getColumnIndex())).toJSValue())
        events.add(context.number(Float64(span.getInputIndex())).toJSValue())
        events.add(context.number(Float64(span.getLength())).toJSValue())
        return true
    }

    protected override func propEvent(k: String, v: String): Bool {
        // 标记 4 + key + value。
        if (!ensureRoom(3)) {
            return false
        }
        emitEvent(4, context.string(k).toJSValue(), context.string(v).toJSValue())
        return true
    }

    protected override func extraEvent(code: Int64, k: String, v: String): Bool {
        // 标记 5/6 + key + value。
        if (!ensureRoom(3)) {
            return false
        }
        emitEvent(code, context.string(k).toJSValue(), context.string(v).toJSValue())
        return true
    }

    /*
     * 图片样式按单次调用实参上限分片: 标记 7 + count 占 2 个实参,
     * 每次最多 max(1, min(chunkSize-2, 253)) 个样式(阈值过小时至少发 1 个);
     * 容量不足时先 flush 并返回 -1 由调用方原样退出。
     */
    protected override func imageStylesEvent(styles: ArrayList<String>, from: Int64): Int64 {
        var cap = batchChunkSize - 2
        if (cap < 1) {
            cap = 1
        }
        if (cap > MAX_BUILD_NODES_ARGS - 2) {
            cap = MAX_BUILD_NODES_ARGS - 2
        }
        let remaining = Int64(styles.size) - from
        let take = if (remaining < cap) { remaining } else { cap }
        if (!ensureRoom(take + 2)) {
            return -1
        }
        let values = Array<JSValue>(take) {i => context.string(styles[from + i]).toJSValue()}
        emitVarEvent(7, values)
        return from + take
    }

    protected override func endNodeEvent(): Bool {
        if (!ensureRoom(1)) {
            return false
        }
        emitEvent(2)
        return true
    }

    protected override func flush(): Unit {
        if (events.size > 0) {
            builder.callMethod("buildNodes", events.toArray())
        }
        events.clear()
    }

    protected override func yieldAfterNodeEnd(poppedDepth: Int64): Bool {
        return false
    }

    /*
     * 检查本包剩余容量, 是"一个 task = 一个满包"的关键:
     * - 放得下: 返回 true, 调用方继续发射;
     * - 放不下且本包非空: 立即推送(满包)并返回 false, 调用方必须原样退出让出 task;
     * - 放不下但本包为空: 单事件自身超过阈值, 整体入队(超包例外)。
     *   该例外只对定长事件成立: 变长事件 7 已由调用方按 255 实参上限预先分片。
     */
    func ensureRoom(nextEventSize: Int64): Bool {
        if (events.size + nextEventSize > batchChunkSize) {
            if (events.size > 0) {
                flush()
                return false
            }
        }
        return true
    }

    /*
     * 发射定长参数事件: 累积 [数字协议标记, ...args] 到事件数组,
     * 标记须与 JsNodeTreeBuilder.buildNodes 的数字 case 协议一致。
     * 用数字而非字符串标记: 每个事件省一次 context.string 的 JS 字符串分配与 ArkTS switch 字符串比较。
     * 容量由调用方在发射前用 ensureRoom 检查, 因此这里不再做 flush 判定。
     *
     * 按实参个数重载而不是收 Array<JSValue>: 每个事件省一次临时数组分配。
     */
    func emitEvent(code: Int64): Unit {
        events.add(context.number(Float64(code)).toJSValue())
    }

    func emitEvent(code: Int64, a: JSValue): Unit {
        events.add(context.number(Float64(code)).toJSValue())
        events.add(a)
    }

    func emitEvent(code: Int64, a: JSValue, b: JSValue): Unit {
        events.add(context.number(Float64(code)).toJSValue())
        events.add(a)
        events.add(b)
    }

    /*
     * 发射变长参数事件: 累积 [数字协议标记, count, ...values](count 供 buildNodes 定界)。
     */
    func emitVarEvent(code: Int64, values: Array<JSValue>): Unit {
        events.add(context.number(Float64(code)).toJSValue())
        events.add(context.number(Float64(values.size)).toJSValue())
        for (v in values) {
            events.add(v)
        }
    }
}

/*
 * 子类实现之二(兜底路径): 非批量实现。
 *
 * 每产生一个动作就单独 callMethod 一次(beginNode/setField/putProp/putSpanNodeAttr/
 * putSpanNodeStyle/putImageStyles/addSourceSpans/endNode), 行为与引入批量协议前完全一致,
 * 用于 builder 未提供 buildNodes 的自定义实现。分片粒度为"一个 Root 第一层子节点"。
 *
 * 性能基线: 本类是批量优化的对照组, 除必要修复外不要在此做性能改造(不要改成数字 ID 调用、
 * 不要合并 callMethod、不要预取), 否则基准数据失去可比性。
 */
class JsNodeBuilderNonBatch <: JsNodeBuilder {
    // 字段数字 ID -> 字段名; 下标与 F_* 对应, 0 位占位(仅非批量模式的 setField(name) 分发使用)。
    let fieldNames: Array<String> = [
        "", "isdone", "latex", "isClosed", "noteid", "blockIndex", "literal", "destination",
        "title", "text", "label", "headIndex", "delimiter", "fenceChar", "fenceLength",
        "fenceIndent", "info", "level", "isTight", "bulletMarker", "startNumber", "isHeader",
        "alignment", "width", "height", "color", "size", "name", "data", "toStr"
    ]

    JsNodeBuilderNonBatch(includeSourceSpans: Int64, debug: Bool, builder: JSObject,
        context: JSContext, onDone: () -> Unit) {
        super(includeSourceSpans, debug, builder, context, onDone)
    }

    // 与批量模式一致: beginNode 只带类型, toStr 走普通字段事件(29)。
    protected override func beginNodeEvent(node: Node): Bool {
        builder.callMethod('beginNode', [context.string(node.getNodeType()).toJSValue()])
        return true
    }

    protected override func fieldEvent(id: Int64, value: JSValue): Bool {
        builder.callMethod('setField', [context.string(fieldNames[id]).toJSValue(), value])
        return true
    }

    protected override func spanEvent(span: SourceSpan): Bool {
        builder.callMethod('addSourceSpans', [
            context.number(Float64(span.getLineIndex())).toJSValue(),
            context.number(Float64(span.getColumnIndex())).toJSValue(),
            context.number(Float64(span.getInputIndex())).toJSValue(),
            context.number(Float64(span.getLength())).toJSValue()
        ])
        return true
    }

    protected override func propEvent(k: String, v: String): Bool {
        builder.callMethod("putProp", [context.string(k).toJSValue(), context.string(v).toJSValue()])
        return true
    }

    protected override func extraEvent(code: Int64, k: String, v: String): Bool {
        let method = if (code == 5) { "putSpanNodeAttr" } else { "putSpanNodeStyle" }
        builder.callMethod(method, [context.string(k).toJSValue(), context.string(v).toJSValue()])
        return true
    }

    /*
     * 非批量模式每次 callMethod 最多 255 个实参; putImageStyles 在 ArkTS 侧是追加语义,
     * 因此按 MAX_BUILD_NODES_ARGS 个值分片多次调用即可, 不会丢样式。
     */
    protected override func imageStylesEvent(styles: ArrayList<String>, from: Int64): Int64 {
        let remaining = Int64(styles.size) - from
        let take = if (remaining < MAX_BUILD_NODES_ARGS) { remaining } else { MAX_BUILD_NODES_ARGS }
        let values = Array<JSValue>(take) {i => context.string(styles[from + i]).toJSValue()}
        builder.callMethod("putImageStyles", values)
        return from + take
    }

    protected override func endNodeEvent(): Bool {
        builder.callMethod("endNode", [])
        return true
    }

    // 非批量模式没有事件缓冲。
    protected override func flush(): Unit {
    }

    // 根的第一层子节点(depth==1)处理完就结束本 task(与旧分片粒度一致)。
    // 不能用 frames.size == 1 判定: expandChildren 一次性压入全部兄弟帧,
    // 该条件只在最后一个根级子节点结束时成立, 会把整篇文档挤进首个 task。
    protected override func yieldAfterNodeEnd(poppedDepth: Int64): Bool {
        return poppedDepth == 1
    }
}

/*
 * 按 builder 的能力选择实现: 含 buildNodes 的走批量协议, 否则走逐事件兜底。
 * 探测走 JS [[Get]] 语义, 取到非 undefined/null 即视为支持批量。
 */
func createJsNodeBuilder(chunkSize: Int64, includeSourceSpans: Int64, debug: Bool, builder: JSObject,
    context: JSContext, onDone: () -> Unit): JsNodeBuilder {
    let buildNodes = builder['buildNodes']
    if (buildNodes.isUndefined() || buildNodes.isNull()) {
        return JsNodeBuilderNonBatch(includeSourceSpans, debug, builder, context, onDone)
    }
    return JsNodeBuilderBatch(chunkSize, includeSourceSpans, debug, builder, context, onDone)
}

/*
 * 深度优先遍历的一帧: 一个节点 + 它当前的发射进度。
 *
 * 帧栈是 JsNodeBuilder 的成员, 因此遍历可以在任意事件边界暂停(让出 postJSTask)并原样恢复,
 * 从而让 task 边界与包边界对齐: 一个 task 恰好推送一个满包。
 *
 * phase 表示下一个要发射的事件组, index 是该组内的游标(字段下标 / span 下标 / prop 下标 / 附加事件下标)。
 * depth 是节点深度(Root=0), 用于非批量模式判定"根的第一层子节点"分片边界。
 * HashMap 无法按下标随机访问, 所以 props / extras 在首次进入对应阶段时物化为数组
 * (只有带 custom 属性的 SpanNode/StyleImage 才真正分配)。
 */
class Frame {
    Frame(let node: Node, let depth: Int64) {
    }

    var phase: Int64 = PHASE_BEGIN
    var index: Int64 = 0
    // fieldsLoaded: 首次进入 PHASE_FIELDS 时把字段收集进 pendingFields, 之后按 index 续发。
    var fieldsLoaded: Bool = false
    // spans: None 表示"不需要 span 或该节点没有 span"; Some 时按 index 续发。
    var spansLoaded: Bool = false
    var spans: ?ArrayList<SourceSpan> = None
    var propsLoaded: Bool = false
    var props: ?ArrayList<(String, String)> = None
    var extrasLoaded: Bool = false
    var extras: ?ArrayList<(Int64, String, String)> = None
    var imageStyles: ?ArrayList<String> = None
    // 图片样式分片游标: 包满让出后从这里续发, 避免重复追加。
    var imageStyleIndex: Int64 = 0
}
