import { JsNode } from "./JsNode"
import { JsNodeImpl } from "./JsNodeImpl"

/*
 * 单一 JS 对象形式的节点树构建器。
 * cangjie 端只持有本对象一个互操作引用, 通过调用其方法驱动节点树的构建,
 * 从而避免为每个节点创建 js/cangjie 双向绑定的互操作对象。
 */
export class JsNodeTreeBuilder {
  protected nodeFactory: () => JsNode
  protected root: JsNode | undefined = undefined
  protected current: JsNode | undefined = undefined
  protected stack: Array<JsNode> = []

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
   * toStr 与普通字段同构, 由字段事件(29)统一写入, 不在此处传参。
   */
  beginNode(nodeType: string): void {
    let node = this.nodeFactory()
    node.nodeType = nodeType
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
   * 对当前节点填充一个字段(NonBatch 与外部调用入口)。
   * case 必须与 setFieldById 一一对应; 批量解码不走这里, 以免多一次调用与二次分发。
   *
   * 性能基线: NonBatch 走此方法, 刻意保留字符串 switch 形态, 作为批量路径的对照组;
   * 不要改成转调 setFieldById, 实测会让 NonBatch 字段分发慢 1.5~2.6 倍。
   */
  setField(key: string, value: string | number | boolean): void {
    let node = this.current
    if (!node) {
      return
    }
    switch (key) {
      case 'nodeType':
        node.nodeType = value as string;
        break
      case 'toStr':
        node.toStr = value as string;
        break
      case 'isdone':
        node.isdone = value as boolean;
        break
      case 'latex':
        node.latex = value as string;
        break
      case 'isClosed':
        node.isClosed = value as boolean;
        break
      case 'noteid':
        node.noteid = value as string;
        break
      case 'blockIndex':
        node.blockIndex = value as number;
        break
      case 'literal':
        node.literal = value as string;
        break
      case 'destination':
        node.destination = value as string;
        break
      case 'title':
        node.title = value as string;
        break
      case 'text':
        node.text = value as string;
        break
      case 'label':
        node.label = value as string;
        break
      case 'headIndex':
        node.headIndex = value as number;
        break
      case 'delimiter':
        node.delimiter = value as string;
        break
      case 'fenceChar':
        node.fenceChar = value as string;
        break
      case 'fenceLength':
        node.fenceLength = value as number;
        break
      case 'fenceIndent':
        node.fenceIndent = value as number;
        break
      case 'info':
        node.info = value as string;
        break
      case 'level':
        node.level = value as number;
        break
      case 'isTight':
        node.isTight = value as boolean;
        break
      case 'bulletMarker':
        node.bulletMarker = value as string;
        break
      case 'startNumber':
        node.startNumber = value as number;
        break
      case 'isHeader':
        node.isHeader = value as boolean;
        break
      case 'alignment':
        node.alignment = value as string;
        break
      case 'width':
        node.width = value as (number | string);
        break
      case 'height':
        node.height = value as string;
        break
      case 'color':
        node.color = value as string;
        break
      case 'size':
        node.size = value as string;
        break
      case 'name':
        node.name = value as string;
        break
      case 'data':
        node.data = value as string;
        break
      default:
        break
    }
  }

  /*
   * 批量解码专用: 字段赋值的第二个实现, 按数字 ID 直接分发,
   * 省掉"id→字段名→字符串 switch"的双跳。case 必须与 setField 一一对应。
   * ID 契约与仓颉侧 js_node_builder.cj 的 F_* 常量一一对应(1..29);
   * 越界 ID 抛错, 让两端字段表漂移立即暴露, 而不是静默丢字段。
   */
  protected setFieldById(id: number, value: string | number | boolean): void {
    let node = this.current
    if (!node) {
      return
    }
    switch (id) {
      case 1:
        node.isdone = value as boolean;
        break
      case 2:
        node.latex = value as string;
        break
      case 3:
        node.isClosed = value as boolean;
        break
      case 4:
        node.noteid = value as string;
        break
      case 5:
        node.blockIndex = value as number;
        break
      case 6:
        node.literal = value as string;
        break
      case 7:
        node.destination = value as string;
        break
      case 8:
        node.title = value as string;
        break
      case 9:
        node.text = value as string;
        break
      case 10:
        node.label = value as string;
        break
      case 11:
        node.headIndex = value as number;
        break
      case 12:
        node.delimiter = value as string;
        break
      case 13:
        node.fenceChar = value as string;
        break
      case 14:
        node.fenceLength = value as number;
        break
      case 15:
        node.fenceIndent = value as number;
        break
      case 16:
        node.info = value as string;
        break
      case 17:
        node.level = value as number;
        break
      case 18:
        node.isTight = value as boolean;
        break
      case 19:
        node.bulletMarker = value as string;
        break
      case 20:
        node.startNumber = value as number;
        break
      case 21:
        node.isHeader = value as boolean;
        break
      case 22:
        node.alignment = value as string;
        break
      case 23:
        node.width = value as (number | string);
        break
      case 24:
        node.height = value as string;
        break
      case 25:
        node.color = value as string;
        break
      case 26:
        node.size = value as string;
        break
      case 27:
        node.name = value as string;
        break
      case 28:
        node.data = value as string;
        break
      case 29:
        node.toStr = value as string;
        break
      default:
        throw new Error(`setFieldById: unknown field id ${id}`)
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


/*
 * 单一 JS 对象形式的节点树构建器。
 * cangjie 端只持有本对象一个互操作引用, 通过调用其方法驱动节点树的构建,
 * 从而避免为每个节点创建 js/cangjie 双向绑定的互操作对象。
 */
export class JsNodeTreeBuilderBatch extends JsNodeTreeBuilder {
  /*
   * 批量构建节点树: 解析仓颉侧一次性推送的扁平事件数组, 分发到上述逐节点方法。
   * 事件协议(位置确定性: 仅命令位置读取标记, 数据位置不会误判; 标记为数字 1~8,
   * 避免每事件的字符串分配与比较开销, 与仓颉侧 js_node_builder.cj 的 emitEvent/emitVarEvent 对应):
   *   1 nodeType              -> beginNode(节点在此入栈, 类型随之确定)
   *   2                       -> endNode
   *   3 id value              -> setField(id 为字段数字 ID, 29=toStr, 仅 debug 时出现)
   *   4 k v                   -> putProp
   *   5 k v                   -> putSpanNodeAttr
   *   6 k v                   -> putSpanNodeStyle
   *   7 count v1..vN          -> putImageStyles
   *   8 count n1..nN          -> addSourceSpans(数字按 line/column/index/length 四个一组)
   * 除 7/8 外均为定长事件, 事件大小不随节点内容变化。
   * 注意: 必须用 rest 参数接收——仓颉侧 callMethod('buildNodes', events) 把数组展开为逐个实参
   * (与 addSourceSpans/putImageStyles 的既有模式一致), 非 rest 单参数只会收到第一个事件元素。
   */
  buildNodes(...items: Array<string | number | boolean>): void {
    let i = 0
    try {
      while (i < items.length) {
        switch (items[i]) {
          case 1: {
            // toStr 走字段事件(id=29)传输, 解码到该字段时再写入节点。
            this.beginNode(items[i + 1] as string)
            i += 2
            break
          }
          case 2:
            this.endNode()
            i += 1
            break
          case 3:
            // 数字 ID 直接分发, 省掉 id→字段名 的数组查找与字符串 switch。
            this.setFieldById(items[i + 1] as number, items[i + 2])
            i += 3
            break
          case 4:
            this.putProp(items[i + 1] as string, items[i + 2] as string)
            i += 3
            break
          case 5:
            this.putSpanNodeAttr(items[i + 1] as string, items[i + 2] as string)
            i += 3
            break
          case 6:
            this.putSpanNodeStyle(items[i + 1] as string, items[i + 2] as string)
            i += 3
            break
          case 7: {
            let count = items[i + 1] as number
            this.putImageStyles(...(items.slice(i + 2, i + 2 + count) as Array<string>))
            i += 2 + count
            break
          }
          case 8: {
            let count = items[i + 1] as number
            this.addSourceSpans(...(items.slice(i + 2, i + 2 + count) as Array<number>))
            i += 2 + count
            break
          }
          default:
            throw new Error(`buildNodes: unknown event marker at ${i}: ${items[i]}`)
        }
      }
    } catch (e) {
      // 埋点: callMethod 路径上的 JS 异常会被 ark_interop 包装为不可捕获的 JSInteropNativeError
      // (进程终止, 错误细节丢失), 这里在终止前把出错位置与上下文打进日志用于定位。
      console.error(`[JsNodeTreeBuilder] buildNodes error at i=${i}, items.length=${items.length}, ` +
        `nearby=${JSON.stringify(items.slice(Math.max(0, i - 2), i + 4))}, err=${e}`)
      throw e
    }
  }
}

