import { JsNode } from "./JsNode"
import { JsNodeImpl } from "./JsNodeImpl"

/*
 * 单一 JS 对象形式的节点树构建器。
 * cangjie 端只持有本对象一个互操作引用, 通过调用其方法驱动节点树的构建,
 * 从而避免为每个节点创建 js/cangjie 双向绑定的互操作对象。
 */
export class JsNodeTreeBuilder {
  private nodeFactory: () => JsNode
  private root: JsNode | undefined = undefined
  private current: JsNode | undefined = undefined
  private stack: Array<JsNode> = []

  constructor(nodeFactory?: () => JsNode) {
    this.nodeFactory = nodeFactory ?? (() => new JsNodeImpl())
  }

  /*
   * 重置构建器状态, 供复用。
   */
  reset(): void {
    this.root = undefined
    this.current = undefined
    this.stack = []
  }

  /*
   * 创建新节点并挂到当前节点下(作为第一个节点时即为根节点), 同时把新节点设为当前节点。
   */
  beginNode(nodeType: string, toStr: string): void {
    let node = this.nodeFactory()
    node.nodeType = nodeType
    node.toStr = toStr
    if (!this.root) {
      this.root = node
    }
    if (this.current) {
      this.current.appendChild(node)
    }
    this.stack.push(node)
    this.current = node
  }

  /*
   * 结束当前节点, 回退到其父节点。
   */
  endNode(): void {
    this.stack.pop()
    this.current = this.stack.length > 0 ? this.stack[this.stack.length - 1] : undefined
  }

  /*
   * 对当前节点填充一个字段。
   */
  setField(key: string, value: string | number | boolean): void {
    let node = this.current
    if (!node) {
      return
    }
    switch (key) {
      case 'nodeType': node.nodeType = value as string; break
      case 'toStr': node.toStr = value as string; break
      case 'isdone': node.isdone = value as boolean; break
      case 'latex': node.latex = value as string; break
      case 'isClosed': node.isClosed = value as boolean; break
      case 'noteid': node.noteid = value as string; break
      case 'blockIndex': node.blockIndex = value as number; break
      case 'literal': node.literal = value as string; break
      case 'destination': node.destination = value as string; break
      case 'title': node.title = value as string; break
      case 'text': node.text = value as string; break
      case 'label': node.label = value as string; break
      case 'headIndex': node.headIndex = value as number; break
      case 'delimiter': node.delimiter = value as string; break
      case 'openingDelimiter': node.openingDelimiter = value as string; break
      case 'fenceChar': node.fenceChar = value as string; break
      case 'fenceLength': node.fenceLength = value as number; break
      case 'fenceIndent': node.fenceIndent = value as number; break
      case 'info': node.info = value as string; break
      case 'level': node.level = value as number; break
      case 'isTight': node.isTight = value as boolean; break
      case 'bulletMarker': node.bulletMarker = value as string; break
      case 'startNumber': node.startNumber = value as number; break
      case 'isHeader': node.isHeader = value as boolean; break
      case 'alignment': node.alignment = value as string; break
      case 'width': node.width = value as (number | string); break
      case 'height': node.height = value as string; break
      case 'color': node.color = value as string; break
      case 'size': node.size = value as string; break
      case 'name': node.name = value as string; break
      case 'data': node.data = value as string; break
      default: break
    }
  }

  /*
   * 为当前节点批量添加 SourceSpan 信息。
   */
  addSourceSpans(...numbers: Array<number>): void {
    let node = this.current
    if (node) {
      node.addSourceSpans(...numbers)
    }
  }

  /*
   * 为当前节点写入自定义插件数据。
   */
  putProp(key: string, value: string): void {
    let node = this.current
    if (node) {
      node.putProp(key, value)
    }
  }

  putImageStyles(...styles: Array<string>): void {
    let node = this.current
    if (node) {
      node.putImageStyles(...styles)
    }
  }

  putSpanNodeAttr(key: string, value: string): void {
    let node = this.current
    if (node) {
      node.putSpanNodeAttr(key, value)
    }
  }

  putSpanNodeStyle(key: string, value: string): void {
    let node = this.current
    if (node) {
      node.putSpanNodeStyle(key, value)
    }
  }

  /*
   * 返回构建出的根节点。
   */
  getRoot(): JsNode {
    return this.root!
  }
}
