import { util } from "@kit.ArkTS"
import { JsNode } from "./JsNode"

let textDecoder = new util.TextDecoder()
let textEncoder = new util.TextEncoder()

/**
 * 将utf16字符下标转为utf8字节下标
 * @param line
 * @param utf16Index
 * @returns utf8字节下标
 */
export function utf16Index2utf8Index(line: string, utf16Index: number): number {
  let sub = line.slice(0, utf16Index)
  let bytes = textEncoder.encodeInto(sub)
  return bytes.byteLength
}

/**
 * 将utf8字节下标转为utf16字符下标
 * @param line
 * @param utf8Index
 * @returns utf16字符下标
 */
export function utf8Index2utf16Index(line: string, utf8Index: number): number {
  let bytes = textEncoder.encodeInto(line).slice(0, utf8Index)
  let sub = textDecoder.decodeToString(bytes)
  return sub.length
}

export function printNode(node: JsNode): string {
  node = node as JsNode
  if (node) {
    let current: JsNode | undefined = node
    while (current?.parent) {
      current = (current as JsNode).parent
    }
    let builder = Array<string>()
    printNodeDep(current, 0, builder)
    return builder.join('')
  }
  return ''
}

function printNodeDep(node: JsNode | undefined, dep: number, builder: Array<string>) {
  node = node as JsNode
  if (node) {
    let str = node.toStr
    let sss = node.getSourceSpans().map((v) => JSON.stringify(v)).join(',')
    let sssize = node.getSourceSpans().length
    let props = node.getProps()
    let propStr: string = ''
    if (props) {
      propStr = JSON.stringify(Object.fromEntries(props))
    }
    builder.push(`${' '.repeat(dep)}${str}${sssize}:[${sss}] , ${propStr}\n`)
    let child = node.firstChild
    printNodeDep(child, dep + 4, builder)
    let next = node.next
    printNodeDep(next, dep, builder)
  }
}
