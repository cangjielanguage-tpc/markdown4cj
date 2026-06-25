import { requireCJLib } from 'libark_interop_loader.so';
import { JsNode } from './JsNode';
import { Options } from './Options';
import { hilog } from '@kit.PerformanceAnalysisKit';

/**
 * 可复用的MarkdownParser
 */
export interface HybridParser {
  /**
   * parse markdown
   * @param md
   * @returns Promise<JsNode>
   */
  parse(md: string): Promise<JsNode>
}

export declare interface CustomLib {
  HybridParser: {
    /**
     * HybridParser constructor
     * @returns HybridParser
     */
    new(options: Options): HybridParser
  }
}

let global_customLib: CustomLib | undefined = undefined

export function getCustomLib(): CustomLib {
  if (global_customLib) {
    return global_customLib
  } else {
    global_customLib = requireCJLib("libmarkdown_parser_hybrid.so") as CustomLib
    hilog.error(0, 'mdebug', 'requireCJLib libmarkdown_parser_hybrid.so')
    return global_customLib
  }
}
