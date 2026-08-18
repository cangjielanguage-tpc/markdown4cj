import {
  JsNode,
  JsNodeImpl,
  MarkdownParser,
  Options,
  printNode,
  utf8Index2utf16Index,
  utf16Index2utf8Index
} from '../../../../Index';
import { hilog } from "@kit.PerformanceAnalysisKit";

export let opt: Options = {
  jsNodeFactory: () => new JsNodeImpl(),
  includeSourceSpans: 0,

  ADPlugin: true,
  BlockAudioPlugin: true,
  BlockVideoPlugin: true,
  CodeListPlugin: true,
  DescListPlugin: true,
  EmojiPlugin: true,
  EmojiPlugin_light: true,
  FootnotePlugin: true,
  HighlightDelimeterPlugin: true,
  HtmlPlugin: true,
  IdHeadingPlugin: true,
  ImageCollectPlugin: true,
  ImageSinglePlugin: true,
  ImageSlidePlugin: true,
  ImageStylePlugin: true,
  ImageTextMixPlugin: true,
  LatexMathPluginV2: true,
  LinkifyPlugin: true,
  LinkifyPlugin_regs: undefined,
  LinkViewPlugin: true,
  NodeIdPlugin: true,
  StrikethroughPlugin: true,
  SubPlugin: true,
  SupPlugin: true,
  TablePlugin: true,
  TaskListPlugin: true,
  TocPlugin: true,
  BlockCustomCardPlugin:false,
  WhitelistLooseDelimiterPlugin: true
}

export let parser = new MarkdownParser(opt)

export async function parseIntoJsNode(md: string, includeSourceSpans: 0 | 1 | 2): Promise<JsNode> {
  opt.includeSourceSpans = includeSourceSpans
  let parser = new MarkdownParser(opt)
  let node = await parser.parse(md)
  let nodeTreeStr = printNode(node)
  hilog.info(0, '', nodeTreeStr)
  return node
}

export function getParser(opt?: Options): MarkdownParser {
  if (!opt) {
    opt = {
      jsNodeFactory: () => new JsNodeImpl(),
      includeSourceSpans: 2
    }
  }
  if (!opt.jsNodeFactory) {
    opt.jsNodeFactory = () => new JsNodeImpl()
  }
  if (!opt.includeSourceSpans) {
    opt.includeSourceSpans = 2
  }
  let parser = new MarkdownParser(opt)
  return parser
}