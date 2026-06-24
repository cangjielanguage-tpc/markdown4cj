import { JsNode } from "./JsNode"

/*
 * markdown初始化选项
 */
export class Options {
  /*
   * 用于JsNode复用
   */
  jsNodeFactory: () => JsNode
  /*
   * 是否包含SourceSpan信息 0:不包含(默认) 1:仅Block节点 2:全部节点
   */
  includeSourceSpans: 0 | 1 | 2

  ADPlugin: boolean = false
  BlockAudioPlugin: boolean = false
  BlockVideoPlugin: boolean = false
  CodeListPlugin: boolean = false
  DescListPlugin: boolean = false
  EmojiPlugin: boolean = false
  EmojiPlugin_light: boolean = false
  FootnotePlugin: boolean = false
  HighlightDelimeterPlugin: boolean = false
  HtmlPlugin: boolean = false
  IdHeadingPlugin: boolean = false
  ImageCollectPlugin: boolean = false
  ImageSinglePlugin: boolean = false
  ImageSlidePlugin: boolean = false
  ImageStylePlugin: boolean = false
  ImageTextMixPlugin: boolean = false
  ImageVideoPlugin: boolean = false
  LatexMathPluginV2: boolean = false
  LinkifyPlugin: boolean = false
  LinkifyPlugin_regs: Array<string> | undefined = undefined
  LinkViewPlugin: boolean = false
  NodeIdPlugin: boolean = false
  StrikethroughPlugin: boolean = false
  SubPlugin: boolean = false
  SupPlugin: boolean = false
  TablePlugin: boolean = false
  TaskListPlugin: boolean = false
  TocPlugin: boolean = false
  WhitelistLooseDelimiterPlugin: boolean = false
  WhitelistLooseDelimiterPlugin_DelimiterFilterMode: "Permissive" | "Strict" | Array<String> = "Permissive"
}