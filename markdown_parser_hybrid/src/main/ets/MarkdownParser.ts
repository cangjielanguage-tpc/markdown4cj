import { HybridParser, getCustomLib } from "./interop"
import { JsNode } from "./JsNode"
import { Options } from "./Options"
import { JsNodeTreeBuilder } from "./JsNodeTreeBuilder"

export class MarkdownParser {
  parser: HybridParser
  nodeTreeBuilder: JsNodeTreeBuilder

  constructor(opt: Options) {
    let customLib = getCustomLib()
    this.nodeTreeBuilder = opt.jsNodeTreeBuilder
    this.parser = new customLib.HybridParser(opt)
  }

  async parse(md: string): Promise<JsNode> {
    await this.parser.parse(md)
    return this.nodeTreeBuilder.getRoot()
  }
}