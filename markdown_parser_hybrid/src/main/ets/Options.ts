import { JsNode } from "./JsNode"

/*
 * markdown初始化选项
 */
export interface Options {
  /*
   * 用于JsNode复用
   */
  jsNodeFactory: () => JsNode
  /*
   * 是否包含SourceSpan信息 0:不包含(默认) 1:仅Block节点 2:全部节点
   */
  includeSourceSpans: 0 | 1 | 2
  ADPlugin?: boolean
  BlockAudioPlugin?: boolean
  BlockVideoPlugin?: boolean
  CodeListPlugin?: boolean
  DescListPlugin?: boolean
  EmojiPlugin?: boolean
  EmojiPlugin_light?: boolean
  FootnotePlugin?: boolean
  HighlightDelimeterPlugin?: boolean
  HtmlPlugin?: boolean
  IdHeadingPlugin?: boolean
  ImageCollectPlugin?: boolean
  ImageSinglePlugin?: boolean
  ImageSlidePlugin?: boolean
  ImageStylePlugin?: boolean
  ImageTextMixPlugin?: boolean
  ImageVideoPlugin?: boolean
  LatexMathPluginV2?: boolean
  LinkifyPlugin?: boolean
  LinkifyPlugin_regs?: Array<string>
  LinkViewPlugin?: boolean
  NodeIdPlugin?: boolean
  StrikethroughPlugin?: boolean
  SubPlugin?: boolean
  SupPlugin?: boolean
  TablePlugin?: boolean
  TaskListPlugin?: boolean
  TocPlugin?: boolean
  BlockCustomCardPlugin?:boolean
  WhitelistLooseDelimiterPlugin?: boolean
  WhitelistLooseDelimiterPlugin_DelimiterFilterMode?: "Permissive" | "Strict" | Array<String>
  blockImageCard?: ( desc: string, imageSrc: string, title: string) => boolean
  blockLinkCard?: (desc: string, link: string, title: string) => boolean
}