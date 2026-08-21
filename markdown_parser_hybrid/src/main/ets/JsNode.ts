/*
 * js node 接口
 */
export interface JsNode {
  /* 节点类型 */
  nodeType: string
  /* to string */
  toStr: string
  /* 父节点 */
  parent?: JsNode
  /* 第一个子节点 */
  firstChild?: JsNode
  /* 最后一个子节点 */
  lastChild?: JsNode
  /* 前节点 */
  previous?: JsNode
  /* 后节点 */
  next?: JsNode

  /*
   * 插入子节点
   */
  appendChild(child: JsNode): void

  /*
   * 删除关联关系
   */
  unlink(): void

  /**
   * 文本
   * 适用nodeType:Text/HtmlInline/Code/HtmlBlock/IndentedCodeBlock/FencedCodeBlock
   */
  literal?: string
  /**
   * 目标
   * 适用nodeType:Image/LinkReferenceDefinition/Link/ImageHtmlNode
   */
  destination?: string
  /**
   * 标题
   * 适用nodeType:Image/LinkReferenceDefinition/Link
   */
  title?: string
  /**
   * 标签
   * 适用nodeType:LinkReferenceDefinition
   */
  label?: string
  /**
   * 定界符
   * 适用nodeType:StrongEmphasis/Emphasis/OrderedList
   */
  delimiter?: string
  /**
   * 开始定界符
   * 适用nodeType:Delimited子类系列
   */
  openingDelimiter?: string
  /**
   * 结束定界符
   * 适用nodeType:Delimited子类系列
   */
  closingDelimiter?: string
  /**
   * 围栏字符
   * 适用nodeType:FencedCodeBlock
   */
  fenceChar?: string
  /**
   * 围栏长度
   * 适用nodeType:FencedCodeBlock
   */
  fenceLength?: number
  /**
   * 围栏缩进长度
   * 适用nodeType:FencedCodeBlock
   */
  fenceIndent?: number
  /**
   * 等级
   * 适用nodeType:Heading
   */
  level?: number
  /**
   * 无序列表标志
   * 适用nodeType:BulletList
   */
  bulletMarker?: string
  /**
   * 有序列表开始数字
   * 适用nodeType:OrderedList
   */
  startNumber?: number
  /**
   * 信息
   * 适用nodeType:FencedCodeBlock
   */
  info?: string
  /**
   * 列表密集排布
   * 适用nodeType:BulletList/OrderedList
   */
  isTight?: boolean
  /**
   * 表格头
   * 适用nodeType:TableCell
   */
  isHeader?: boolean
  /**
   * 表格对齐
   * 适用nodeType:TableCell
   */
  alignment?: string
  /**
   * 适用: TableCell ImageHtmlNode
   */
  width?: number | string
  /**
   * 适用: ImageHtmlNode
   */
  height?: string
  /**
   * 任务列表选中标志
   * 适用nodeType:TaskListItem
   */
  isdone?: boolean
  /**
   * 数学公式
   * 适用nodeType:LatexMathBlock/LatexMathNode
   */
  latex?: string
  isClosed?: boolean
  /**
   * 脚注id
   * 适用nodeType:Footnote/FootnoteBlock
   */
  noteid?: string
  /**
   * FootnoteBlock下标
   * 适用nodeType:Footnote/FootnoteBlock
   */
  blockIndex?: number
  /**
   * toc标题链接
   * 适用nodeType:HeadLink
   */
  headIndex?: number
  /**
   * 适用: ImgVideo
   */
  text?: string
  /**
   * 适用: FontNode
   */
  color?: string
  /**
   * 适用: FontNode
   */
  size?: string
  /**
   * 适用: CardNode
   */
  name?: string
  /**
   * 适用: CardNode
   */
  data?: string

  /**
   * 添加Style
   * 适用:StyleImage
   */
  putImageStyles(...styles: Array<string>): void

  /**
   * 添加Style
   * 适用:SpanNode
   */
  putSpanNodeAttr(styleKey: string, styleValue: string): void

  /**
   * 添加Style
   * 适用:SpanNode
   */
  putSpanNodeStyle(styleKey: string, styleValue: string): void

  /**
   * 用于存放自定义解析插件所产生的数据
   */
  getProps(): Map<string, string> | undefined

  /**
   * 存放自定义插件所产生的数据
   */
  putProp(k: string, v: string): void

  /*
   * 获取SourceSpan信息
   */
  getSourceSpans(): Array<SourceSpan>

  /*
   * 批量添加SourceSpan信息, 每4个数值一组(line,column,index,length)
   * 性能优化: 不做SourceSpan对象包装
   */
  addSourceSpans(...numbers: Array<number>): void

  /*
   * 重置Node 以供互操作复用
   */
  reset(): void
}

/*
 * markdown节点原文坐标信息
 */
export interface SourceSpan {
  /*
   * 行号
   */
  getLineIndex(): number

  /*
   * 列号(utf8)
   */
  getColumnIndex(): number

  /*
   * 全文起始下标(utf8)
   */
  getInputIndex(): number

  /*
   * 长度
   */
  getLength(): number
}