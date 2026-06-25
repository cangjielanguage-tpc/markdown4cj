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

export let opt: Options = (() => {
  let opt = new Options()
  opt.jsNodeFactory = () => new JsNodeImpl()
  opt.includeSourceSpans = 0

  opt.ADPlugin = true
  opt.BlockAudioPlugin = true
  opt.BlockVideoPlugin = true
  opt.CodeListPlugin = true
  opt.DescListPlugin = true
  opt.EmojiPlugin = true
  opt.EmojiPlugin_light = true
  opt.FootnotePlugin = true
  opt.HighlightDelimeterPlugin = true
  opt.HtmlPlugin = true
  opt.IdHeadingPlugin = true
  opt.ImageCollectPlugin = true
  opt.ImageSinglePlugin = true
  opt.ImageSlidePlugin = true
  opt.ImageStylePlugin = true
  opt.ImageTextMixPlugin = true
  opt.LatexMathPluginV2 = true
  opt.LinkifyPlugin = true
  opt.LinkifyPlugin_regs = undefined
  opt.LinkViewPlugin = true
  opt.NodeIdPlugin = true
  opt.StrikethroughPlugin = true
  opt.SubPlugin = true
  opt.SupPlugin = true
  opt.TablePlugin = true
  opt.TaskListPlugin = true
  opt.TocPlugin = true
  opt.WhitelistLooseDelimiterPlugin = true
  return opt
})()

export let parser = new MarkdownParser(opt)

export async function parseIntoJsNode(md: string, includeSourceSpans: 0 | 1 | 2): Promise<JsNode> {
  opt.includeSourceSpans = includeSourceSpans
  let parser = new MarkdownParser(opt)
  let node = await parser.parse(md)
  let nodeTreeStr = printNode(node)
  hilog.info(0, '', nodeTreeStr)
  return node
}

export function getParser(includeSourceSpans: 0 | 1 | 2, factory: (() => JsNode) | undefined): MarkdownParser {
  let opt = new Options()
  opt.jsNodeFactory = factory ?? (() => new JsNodeImpl())
  opt.includeSourceSpans = includeSourceSpans
  opt.FootnotePlugin = true
  opt.LinkifyPlugin = true
  let parser = new MarkdownParser(opt)
  return parser
}