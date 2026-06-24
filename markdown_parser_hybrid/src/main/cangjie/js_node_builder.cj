package markdown_parser_hybrid

class JsNodeBuilder {
    JsNodeBuilder(let jsNodeConstructor: JSFunction, let context: JSContext) {}

    func buildJsNode(instance: Node): JSObject {
        let jsNode = jsNodeConstructor.call().asObject()
        jsNode.set('nodeType', instance.getNodeType(), context)
        jsNode.set('toStr', instance.toString(), context)
        setSourceSpans(instance, jsNode)

        match (instance) {
            case v: TaskListItem => jsNode.set('isdone', v.isDone(), context)
            case v: LatexMathBlock =>
                jsNode.set('latex', v.latex, context)
                jsNode.set('isClosed', v.isClosed, context)
            case v: LatexMathNode => jsNode.set('latex', v.latex, context)
            case v: Footnote =>
                jsNode.set('noteid', v.noteid, context)
                jsNode.set('blockIndex', v.block?.blockIndex ?? -1, context)
            case v: FootnoteBlock =>
                jsNode.set('noteid', v.noteid, context)
                jsNode.set('blockIndex', v.blockIndex, context)
            case v: HeadLink => jsNode.set('headIndex', v.headIndex, context)
            case v: Text => jsNode.set('literal', v.getLiteral(), context)
            case v: HtmlInline => jsNode.set('literal', v.getLiteral(), context)
            case v: Image =>
                jsNode.set('destination', v.getDestination(), context)
                jsNode.set('title', v.getTitle(), context)
            case v: Code => jsNode.set('literal', v.getLiteral(), context)
            case v: LinkReferenceDefinition =>
                jsNode.set('label', v.getLabel(), context)
                jsNode.set('destination', v.getDestination(), context)
                jsNode.set('title', v.getTitle(), context)
            case v: Link =>
                jsNode.set('destination', v.getDestination(), context)
                jsNode.set('title', v.getTitle(), context)
            case v: StrongEmphasis => jsNode.set('delimiter', v.getOpeningDelimiter(), context)
            case v: Emphasis => jsNode.set('delimiter', v.getOpeningDelimiter(), context)
            case v: HtmlBlock => jsNode.set('literal', v.getLiteral(), context)
            case v: IndentedCodeBlock => jsNode.set('literal', v.getLiteral(), context)
            case v: FencedCodeBlock =>
                jsNode.set('fenceChar', v.getFenceChar(), context)
                jsNode.set('fenceLength', v.getFenceLength(), context)
                jsNode.set('fenceIndent', v.getFenceIndent(), context)
                jsNode.set('info', v.getInfo(), context)
                jsNode.set('literal', v.getLiteral(), context)
            case v: Heading => jsNode.set('level', v.getLevel(), context)
            case v: BulletList =>
                jsNode.set('isTight', v.isTight(), context)
                jsNode.set('bulletMarker', v.getBulletMarker(), context)
            case v: OrderedList =>
                jsNode.set('isTight', v.isTight(), context)
                jsNode.set('startNumber', v.getStartNumber(), context)
                jsNode.set('delimiter', v.getDelimiter(), context)
            case v: TableCell =>
                jsNode.set('isHeader', v.isHeader(), context)
                jsNode.set('alignment', v.getAlignment()?.toString(), context)
                jsNode.set('width', v.getWidth(), context)
            case _ => ()
        }
        jsNode
    }

    func buildNode(n: Node): JSObject {
        let nodeProxy = buildJsNode(n)
        visitNode(n.getFirstChild(), nodeProxy)
        nodeProxy
    }

    func visitNode(node: ?Node, parentProxy: JSObject): Unit {
        let current = node ?? return
        let next = current.getNext()
        let currentProxy = buildJsNode(current)
        parentProxy.callMethod('appendChild', currentProxy.toJSValue())
        visitNode(current.getFirstChild(), currentProxy)
        visitNode(next, parentProxy)
    }

    func setSourceSpans(instance: Node, jsNode: JSObject): Unit {
        let sourceSpans = instance.getSourceSpans()
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
            jsNode.callMethod('addSourceSpans', sourceSpansFlatten)
        }
    }
}
