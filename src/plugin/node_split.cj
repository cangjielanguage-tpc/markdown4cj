package markdown_parser.plugin

/**
 * 树分割能力，以 Node 接口扩展形式提供。
 *
 * <p>实现沿用 commonmark4cj 的 node_split.cj，移植到 markdown 项目。因依赖 Copyable
 * 接口（集中定义于同包的 copyable.cj），置于 markdown.plugin，避免跨包孤儿扩展与
 * core↔plugin 循环依赖。
 *
 * <p>采用接口扩展（而非直接扩展）：直接扩展对被扩展类型来自其他包时永不导出
 * （见extend规则），故以接口 NodeSplit 承载 splitParent，使其可被插件包外访问。
 */
public interface NodeSplit {
    /**
     * 在当前节点处分割其父节点，把当前节点提升一层。
     *
     * <p>父节点保留当前节点之前的子节点，当前节点作为父节点的兄弟插入其后，
     * 并复制一份父节点（携带当前节点之后的子节点）插入当前节点之后。副本通过
     * {@link Copyable#copy()} 创建，保留父节点属性但无子节点。
     *
     * <p>由于每次只提升一层，重复调用可使节点逐层穿过嵌套祖先。
     *
     * <p>若当前节点是父节点最后一个子节点，则无需携带后续内容，不创建副本。
     */
    func splitParent(): Unit
}

extend Node <: NodeSplit {
    public func splitParent(): Unit {
        let parentOpt = getParent()
        if (parentOpt.isNone()) {
            throw IllegalArgumentException("Cannot split a node that has no parent")
        }
        let parent = parentOpt.getOrThrow()
        if (parent.getParent().isNone()) {
            throw IllegalArgumentException("Cannot split the root node's parent")
        }
        let tail = getNext()
        var copy: ?Node = None
        if (tail.isSome()) {
            let copyOpt = parent as Copyable
            if (copyOpt.isNone()) {
                throw IllegalArgumentException("Parent node type does not support copying")
            }
            copy = Some(copyOpt.getOrThrow().copy())
        }
        unlink()
        if (let Some(c) <- copy) {
            var current = tail
            while (let Some(v) <- current) {
                let next = v.getNext()
                c.appendChild(v)
                current = next
            }
        }
        parent.insertAfter(this)
        if (let Some(c) <- copy) {
            this.insertAfter(c)
        }
        redistributeSourceSpans(parent, copy)
    }

    /**
     * 将 parent 自身的 source spans 分配到分割产生的两半。
     *
     * <p>原节点自身的 span 已覆盖其整体范围，其中包含属于节点本身而非子节点的部分
     * （如强调定界符、引用块/列表标记）。直接合并子节点 span 会丢失这些。因此以当前
     * 节点为界切割原 span：前一半保留到当前节点为止，副本保留当前节点之后的部分。
     *
     * <p>若无法确定分割边界（当前节点无 source spans），则各自依据子节点 span 重建；
     * 若子节点也无 span，则在存活半保留父节点原 span，避免丢失有效数据。
     */
    private func redistributeSourceSpans(parent: Node, copy: ?Node): Unit {
        let originalSpans = parent.getSourceSpans()
        let parentStart = spanStart(parent)
        let parentEnd = spanEnd(parent)
        let thisStart = spanStart(this)
        let thisEnd = spanEnd(this)
        if (parentStart.isSome() && parentEnd.isSome() && thisStart.isSome() && thisEnd.isSome()) {
            parent.setSourceSpans(intersectSpans(originalSpans, parentStart.getOrThrow(), thisStart.getOrThrow()))
            if (let Some(c) <- copy) {
                c.setSourceSpans(intersectSpans(originalSpans, thisEnd.getOrThrow(), parentEnd.getOrThrow()))
            }
        } else if (parentStart.isSome() && parentEnd.isSome()) {
            if (let Some(c) <- copy) {
                c.recomputeSourceSpansFromChildren()
            }
            parent.recomputeSourceSpansFromChildren()
            if (parent.getSourceSpans().isEmpty()) {
                parent.setSourceSpans(originalSpans)
            }
        } else {
            parent.recomputeSourceSpansFromChildren()
            if (let Some(c) <- copy) {
                c.recomputeSourceSpansFromChildren()
            }
        }
    }

    private func intersectSpans(spans: ArrayList<SourceSpan>, lo: Int, hi: Int): ArrayList<SourceSpan> {
        let result = ArrayList<SourceSpan>()
        for (s in spans) {
            let start = s.getInputIndex()
            let end = start + s.getLength()
            let clippedStart = max(start, lo)
            let clippedEnd = min(end, hi)
            if (clippedStart < clippedEnd) {
                result.add(SourceSpan.of(s.getLineIndex(), s.getColumnIndex() + (clippedStart - start), clippedStart,
                    clippedEnd - clippedStart))
            }
        }
        return result
    }

    private func spanStart(n: Node): ?Int {
        var result: ?Int = None
        for (s in n.getSourceSpans()) {
            let v = s.getInputIndex()
            if (result.isNone() || v < result.getOrThrow()) {
                result = Some(v)
            }
        }
        return result
    }

    private func spanEnd(n: Node): ?Int {
        var result: ?Int = None
        for (s in n.getSourceSpans()) {
            let v = s.getInputIndex() + s.getLength()
            if (result.isNone() || v > result.getOrThrow()) {
                result = Some(v)
            }
        }
        return result
    }

    /**
     * 以子节点 source spans 的并集重建本节点 source spans，合并相邻 span。
     * 无子节点（或子节点无 span）的节点不保留 source spans。
     */
    private func recomputeSourceSpansFromChildren(): Unit {
        let spans = SourceSpans.empty()
        var child = getFirstChild()
        while (let Some(v) <- child) {
            spans.addAll(v.getSourceSpans())
            child = v.getNext()
        }
        setSourceSpans(spans.getSourceSpans())
    }
}