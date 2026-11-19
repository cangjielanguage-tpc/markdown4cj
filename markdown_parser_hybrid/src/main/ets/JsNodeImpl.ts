import { JsNode, SourceSpan } from "./JsNode"

/*
 * 普通JsNode实现
 */
export class JsNodeImpl implements JsNode {
  constructor() {
  }

  /* node info */
  nodeType: string = ""
  toStr: string = ""
  /* node tree */
  parent: JsNodeImpl | undefined = undefined
  firstChild: JsNodeImpl | undefined = undefined
  lastChild: JsNodeImpl | undefined = undefined
  previous: JsNodeImpl | undefined = undefined
  next: JsNodeImpl | undefined = undefined
  /* node attr */
  literal: string | undefined = undefined
  destination: string | undefined = undefined
  title: string | undefined = undefined
  label: string | undefined = undefined
  delimiter: string | undefined = undefined
  openingDelimiter: string | undefined
  closingDelimiter: string | undefined
  fenceChar: string | undefined = undefined
  fenceLength: number | undefined = undefined
  fenceIndent: number | undefined = undefined
  level: number | undefined = undefined
  bulletMarker: string | undefined = undefined
  startNumber: number | undefined = undefined
  info: string | undefined = undefined
  isTight: boolean | undefined
  isHeader: boolean | undefined
  alignment: string | undefined = undefined
  width: number | string | undefined = undefined
  height: string | undefined = undefined
  isdone: boolean | undefined = undefined
  latex: string | undefined = undefined
  isClosed: boolean | undefined = undefined
  noteid: string | undefined = undefined
  blockIndex: number | undefined = undefined
  headIndex: number | undefined = undefined
  text: string | undefined = undefined
  color: string | undefined = undefined
  size: string | undefined = undefined
  name: string | undefined = undefined
  data: string | undefined = undefined

  props: Map<string, string> | undefined = undefined // 用于存放Js行内自定义解析插件所产生的数据
  // 默认(不开 span)为 undefined, 不分配数组; 首次 addSourceSpans 时才创建。
  sourceSpans: SourceSpanImpl[] | undefined = undefined
  tagName: string | undefined = undefined

  appendChild(child: JsNodeImpl) {
    child.unlink()
    child.parent = this
    if (this.lastChild) {
      this.lastChild.next = child
      child.previous = this.lastChild
      this.lastChild = child
    } else {
      this.firstChild = child
      this.lastChild = child
    }
  }

  unlink() {
    if (this.previous) {
      this.previous.next = this.next
    } else if (this.parent) {
      this.parent.firstChild = this.next
    }
    if (this.next) {
      this.next.previous = this.previous
    } else if (this.parent) {
      this.parent.lastChild = this.previous
    }
    this.parent = undefined
    this.next = undefined
    this.previous = undefined
  }

  ImageStyles?: Array<string> = undefined

  putImageStyles(...styles: Array<string>): void {
    // 未初始化时 concat(undefined) 会把 undefined 拼成单个尾元素, 与 JsNodeSendable.putImageStyles 对齐
    if (!this.ImageStyles) {
      this.ImageStyles = []
    }
    this.ImageStyles.push(...styles)
  }

  SpanNodeAttr?: Map<string, string> = undefined

  putSpanNodeAttr(styleKey: string, styleValue: string): void {
    if (!this.SpanNodeAttr) {
      this.SpanNodeAttr = new Map()
    }
    this.SpanNodeAttr.set(styleKey, styleValue)
  }

  SpanNodeStyle?: Map<string, string> = undefined

  putSpanNodeStyle(styleKey: string, styleValue: string): void {
    if (!this.SpanNodeStyle) {
      this.SpanNodeStyle = new Map()
    }
    this.SpanNodeStyle.set(styleKey, styleValue)
  }

  getProps(): Map<string, string> | undefined {
    return this.props
  }

  putProp(k: string, v: string): void {
    let m = this.props ?? new Map<string, string>()
    m.set(k, v)
    this.props = m
  }

  getSourceSpans(): SourceSpanImpl[] {
    // 保持既有接口契约(始终返回数组): 首次读取时才为该节点懒建私有空数组,
    // 默认路径不读取, 因此不开 span 时不产生任何分配; 也避免跨节点共享数组。
    let spans = this.sourceSpans
    if (!spans) {
      spans = []
      this.sourceSpans = spans
    }
    return spans
  }

  addSourceSpans(...numbers: Array<number>): void {
    if (numbers.length <= 3) {
      return
    }
    let spans = this.sourceSpans
    if (!spans) {
      spans = []
      this.sourceSpans = spans
    }
    for (let i = 3; i < numbers.length; i += 4) {
      let line: number = numbers[i-3]
      let column: number = numbers[i-2]
      let index: number = numbers[i-1]
      let length: number = numbers[i]
      spans.push(new SourceSpanImpl(line, column, index, length))
    }
  }

  reset(): void {
    this.unlink()

    this.nodeType = ""
    this.toStr = ""

    this.parent = undefined
    this.firstChild = undefined
    this.lastChild = undefined
    this.previous = undefined
    this.next = undefined

    this.literal = undefined
    this.destination = undefined
    this.title = undefined
    this.label = undefined
    this.delimiter = undefined
    this.openingDelimiter = undefined
    this.closingDelimiter = undefined
    this.fenceChar = undefined
    this.fenceLength = undefined
    this.fenceIndent = undefined
    this.level = undefined
    this.bulletMarker = undefined
    this.startNumber = undefined
    this.info = undefined
    this.isTight = undefined
    this.isHeader = undefined
    this.alignment = undefined
    this.width = undefined
    this.height = undefined
    this.isdone = undefined
    this.latex = undefined
    this.isClosed = undefined
    this.noteid = undefined
    this.blockIndex = undefined
    this.headIndex = undefined
    this.text = undefined
    this.color = undefined
    this.size = undefined
    this.name = undefined
    this.data = undefined

    this.props = undefined
    this.sourceSpans = undefined

    this.tagName = undefined
    this.ImageStyles = undefined
    this.SpanNodeAttr = undefined
    this.SpanNodeStyle = undefined
  }
}

/*
 * 普通SourceSpan实现
 */
export class SourceSpanImpl implements SourceSpan {
  line: number
  column: number
  index: number
  length: number

  constructor(line: number, column: number, index: number, length: number) {
    this.line = line
    this.column = column
    this.index = index
    this.length = length
  }

  getLineIndex(): number {
    return this.line
  }

  getColumnIndex(): number {
    return this.column
  }

  getInputIndex(): number {
    return this.index
  }

  getLength(): number {
    return this.length
  }
}