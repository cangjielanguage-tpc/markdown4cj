import { JsNode } from "../../../ets/JsNode";
import { Options } from "../../../ets/Options";

export declare class HybridParser {
  parse(md: string): Promise<JsNode>

  constructor(opt: Options)
}

export declare function testCJ(s: string): string