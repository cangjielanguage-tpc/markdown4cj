/*
 * js node 接口
 */
export interface JsNode {
  /* 节点类型 */
  nodeType: string

  /* to string */
  toStr: string

  /* 父节点 */
  parent: JsNode | undefined
  /* 第一个子节点 */
  firstChild: JsNode | undefined
  /* 最后一个子节点 */
  lastChild: JsNode | undefined
  /* 前节点 */
  previous: JsNode | undefined
  /* 后节点 */
  next: JsNode | undefined

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
  literal: string | undefined
  /**
   * 目标
   * 适用nodeType:Image/LinkReferenceDefinition/Link
   */
  destination: string | undefined
  /**
   * 标题
   * 适用nodeType:Image/LinkReferenceDefinition/Link
   */
  title: string | undefined
  /**
   * 标签
   * 适用nodeType:LinkReferenceDefinition
   */
  label: string | undefined
  /**
   * 定界符
   * 适用nodeType:StrongEmphasis/Emphasis/OrderedList
   */
  delimiter: string | undefined
  /**
   * 开始定界符
   * 适用nodeType:Delimited子类系列
   */
  openingDelimiter: string | undefined
  /**
   * 结束定界符
   * 适用nodeType:Delimited子类系列
   */
  closingDelimiter: string | undefined
  /**
   * 围栏字符
   * 适用nodeType:FencedCodeBlock
   */
  fenceChar: string | undefined
  /**
   * 围栏长度
   * 适用nodeType:FencedCodeBlock
   */
  fenceLength: number | undefined
  /**
   * 围栏缩进长度
   * 适用nodeType:FencedCodeBlock
   */
  fenceIndent: number | undefined
  /**
   * 等级
   * 适用nodeType:Heading
   */
  level: number | undefined
  /**
   * 无序列表标志
   * 适用nodeType:BulletList
   */
  bulletMarker: string | undefined
  /**
   * 有序列表开始数字
   * 适用nodeType:OrderedList
   */
  startNumber: number | undefined
  /**
   * 信息
   * 适用nodeType:FencedCodeBlock
   */
  info: string | undefined
  /**
   * 列表密集排布
   * 适用nodeType:BulletList/OrderedList
   */
  isTight: boolean | undefined
  /**
   * 表格头
   * 适用nodeType:TableCell
   */
  isHeader: boolean | undefined
  /**
   * 表格对齐
   * 适用nodeType:TableCell
   */
  alignment: string | undefined
  /**
   * 表格列宽
   * 适用nodeType:TableCell
   */
  width: number | undefined
  /**
   * 任务列表选中标志
   * 适用nodeType:TaskListItem
   */
  isdone: boolean | undefined
  /**
   * 数学公式
   * 适用nodeType:LatexMathBlock/LatexMathNode
   */
  latex: string | undefined
  isClosed: boolean | undefined
  /**
   * 脚注id
   * 适用nodeType:Footnote/FootnoteBlock
   */
  noteid: string | undefined
  /**
   * FootnoteBlock下标
   * 适用nodeType:Footnote/FootnoteBlock
   */
  blockIndex: number | undefined
  /**
   * toc标题链接
   * 适用nodeType:HeadLink
   */
  headIndex: number | undefined

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