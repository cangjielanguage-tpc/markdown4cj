import { HybridParser, getCustomLib } from "./interop"
import { JsNode } from "./JsNode"
import { Options } from "./Options"

export class MarkdownParser {
  parser: HybridParser

  constructor(opt: Options) {
    let customLib = getCustomLib()
    this.parser = new customLib.HybridParser(opt)
  }

  parse(md: string): Promise<JsNode> {
    return this.parser.parse(md)
  }
}