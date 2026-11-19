import { hilog } from '@kit.PerformanceAnalysisKit';
import { util } from '@kit.ArkTS';
import { common } from '@kit.AbilityKit';
import { abilityDelegatorRegistry } from '@kit.TestKit';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import {
  JsNode, Options, printNode, JsNodeImpl, JsNodeSendableImpl, JsNodeTreeBuilder, JsNodeTreeBuilderBatch,
  MarkdownParser,
} from '../../../../Index';
import { getParser, parser } from './md'

/*
 * 性能测量用例开关: 默认关闭。
 * perf* / packetFillStats 会做数百次全量解析(单次 30s 以上), 不适合放进常规回归;
 * 需要采集性能数据时改为 true 再跑。
 */
const RUN_PERF_TESTS: boolean = false

/*
 * 记录每次 buildNodes 推送实参数量的批量 builder。
 * 继承 JsNodeTreeBuilderBatch, 建树行为不变, 仅额外记录每次推送的实参个数, 用于验证分块阈值。
 */
class RecordingChunkBuilder extends JsNodeTreeBuilderBatch {
  chunkCounts: Array<number> = []

  constructor(nodeFactory?: () => JsNode) {
    super(nodeFactory)
  }

  reset(): void {
    super.reset()
    this.chunkCounts = []
  }

  buildNodes(...items: Array<string | number | boolean>): void {
    this.chunkCounts.push(items.length)
    super.buildNodes(...items)
  }
}

/*
 * 性能评估: 统计非 batch 模式下逐事件跨语言调用次数(仅计数, 建树行为不变)。
 */
class CountingLegacyBuilder extends JsNodeTreeBuilder {
  calls: number = 0

  constructor(nodeFactory?: () => JsNode) {
    super(nodeFactory)
  }

  reset(): void {
    super.reset()
    this.calls = 0
  }

  beginNode(nodeType: string): void {
    this.calls++
    super.beginNode(nodeType)
  }

  endNode(): void {
    this.calls++
    super.endNode()
  }

  setField(key: string, value: string | number | boolean): void {
    this.calls++
    super.setField(key, value)
  }

  addSourceSpans(...numbers: Array<number>): void {
    this.calls++
    super.addSourceSpans(...numbers)
  }

  putProp(key: string, value: string): void {
    this.calls++
    super.putProp(key, value)
  }

  putImageStyles(...styles: Array<string>): void {
    this.calls++
    super.putImageStyles(...styles)
  }

  putSpanNodeAttr(key: string, value: string): void {
    this.calls++
    super.putSpanNodeAttr(key, value)
  }

  putSpanNodeStyle(key: string, value: string): void {
    this.calls++
    super.putSpanNodeStyle(key, value)
  }
}

/*
 * 性能评估: 统计 batch 模式下的推送次数与实参总量。
 */
class CountingBatchBuilder extends JsNodeTreeBuilderBatch {
  pushes: number = 0
  args: number = 0

  constructor(nodeFactory?: () => JsNode) {
    super(nodeFactory)
  }

  reset(): void {
    super.reset()
    this.pushes = 0
    this.args = 0
  }

  buildNodes(...items: Array<string | number | boolean>): void {
    this.pushes++
    this.args += items.length
    super.buildNodes(...items)
  }
}

/*
 * 阶段测量基类: 在 reset() 时记录时间戳。
 * reset 是仓颉侧 toMarkdown 完成后、首个 postJSTask 的第一步,
 * 因此 resetAt - start 可近似为"解析"阶段(含跨线程调度), 之后的耗时才属于序列化/解码/建树。
 * 本类不覆盖 buildNodes, 走真实建树路径。
 */
class TimedBatchBuilder extends JsNodeTreeBuilderBatch {
  resetAt: number = 0

  reset(): void {
    super.reset()
    this.resetAt = Date.now()
  }
}

/*
 * 只测"解析 + 序列化 + 跨语言传输": buildNodes 直接返回, 不做事件解码, 也不建树。
 */
class NoOpPushBuilder extends TimedBatchBuilder {
  buildNodes(...items: Array<string | number | boolean>): void {
  }
}

/*
 * 测到"解码"为止: 父类 buildNodes 仍按事件标记做 switch 分发, 但所有事件方法空实现, 不建树。
 */
class NoOpEventBuilder extends TimedBatchBuilder {
  beginNode(nodeType: string): void {
  }

  endNode(): void {
  }

  protected setFieldById(id: number, value: string | number | boolean): void {
  }

  addSourceSpans(...numbers: Array<number>): void {
  }

  putProp(key: string, value: string): void {
  }

  putImageStyles(...styles: Array<string>): void {
  }

  putSpanNodeAttr(key: string, value: string): void {
  }

  putSpanNodeStyle(key: string, value: string): void {
  }
}

/*
 * 一次阶段测量的结果: 解析完成时刻与整次解析耗时。
 */
interface PhaseTiming {
  parseMs: number
  totalMs: number
}

/*
 * 用指定 builder 解析一次, 返回"解析"与"总耗时"两段计时。
 * spans 对应 Options.includeSourceSpans(0/1/2); debug 关闭时 span 不生效, 故默认 0。
 */
async function measurePhase(builder: TimedBatchBuilder, md: string, chunkSize: number,
  spans: 0 | 1 | 2 = 0, debug: boolean = false): Promise<PhaseTiming> {
  let start = Date.now()
  await new MarkdownParser({
    jsNodeTreeBuilder: builder,
    includeSourceSpans: spans,
    buildNodesChunkSize: chunkSize,
    debug: debug
  }).parse(md)
  let totalMs = Date.now() - start
  let parseMs = builder.resetAt > 0 ? builder.resetAt - start : 0
  let timing: PhaseTiming = { parseMs: parseMs, totalMs: totalMs }
  return timing
}

function percentOf(part: number, whole: number): string {
  return whole > 0 ? (part * 100 / whole).toFixed(1) + '%' : 'N/A'
}

/*
 * 综合大文档: ohosTest rawfile 下的 6000 行真实用例文档(与 MarkdownArkUI BigData 页一致)。
 * 性能用例与非批量/批量等价性用例统一以它为数据源。
 */
const COMPREHENSIVE_DOC: string = '001_Comprehensive_6000Lines.md'

/*
 * 读取综合大文档, 作为性能用例与等价性用例的统一数据源。
 */
function loadComprehensiveMarkdown(): string {
  let context: common.Context = abilityDelegatorRegistry.getAbilityDelegator().getAppContext()
  // rawfile 在测试模块内, appContext 只覆盖 bundle 级资源, 需切到测试模块的 Context
  let moduleContext: common.Context = context.createModuleContext('markdown_parser_hybrid_test')
  let buf: Uint8Array = moduleContext.resourceManager.getRawFileContentSync(COMPREHENSIVE_DOC)
  return util.TextDecoder.create('utf-8').decodeToString(buf)
}

/*
 * 构造指定模式的解析器: batch=true 使用 JsNodeTreeBuilderBatch, 否则为非 batch 基准。
 */
function createPerfParser(batch: boolean, chunkSize?: number): MarkdownParser {
  let builder: JsNodeTreeBuilder = batch
    ? new JsNodeTreeBuilderBatch(() => new JsNodeSendableImpl())
    : new JsNodeTreeBuilder(() => new JsNodeSendableImpl())
  let opt: Options = {
    jsNodeTreeBuilder: builder,
    // 性能用例测默认路径(debug 关闭), 此时 span 不生成也不传输
    includeSourceSpans: 0
  }
  if (chunkSize !== undefined) {
    opt.buildNodesChunkSize = chunkSize
  }
  return new MarkdownParser(opt)
}

/*
 * 单次解析耗时(毫秒, 不含 parser 构造开销)。
 */
async function measureOnce(batch: boolean, md: string, chunkSize?: number): Promise<number> {
  let parser = createPerfParser(batch, chunkSize)
  let start = Date.now()
  let doc = await parser.parse(md)
  let cost = Date.now() - start
  if (doc === undefined) {
    throw new Error('parse 返回 undefined')
  }
  return cost
}

function medianOf(values: Array<number>): number {
  let sorted = values.slice()
  sorted.sort((a: number, b: number): number => a - b)
  let mid = Math.floor(sorted.length / 2)
  return sorted.length % 2 === 1 ? sorted[mid] : (sorted[mid - 1] + sorted[mid]) / 2
}

/*
 * 多次解析取中位数, 降低 GC/调度抖动对单次计时的影响。
 */
async function measureMedian(batch: boolean, md: string, rounds: number, chunkSize?: number): Promise<number> {
  let times: Array<number> = []
  for (let i = 0; i < rounds; i++) {
    let cost = await measureOnce(batch, md, chunkSize)
    times.push(cost)
  }
  return medianOf(times)
}

/*
 * 迭代统计节点数(显式栈, 避免深文档递归), 用于校验两种模式建树结果一致。
 */
function countNodes(root: JsNode): number {
  let count = 0
  let stack: Array<JsNode> = [root]
  while (stack.length > 0) {
    let node = stack.pop()
    if (node === undefined) {
      break
    }
    count++
    let child = node.firstChild
    while (child !== undefined) {
      stack.push(child)
      child = child.next
    }
  }
  return count
}

/*
 * 逐节点导出"类型 + 全部公开字段 + sourceSpan"的文本签名(先序),
 * 用于断言两条通路(非批量逐事件 / 批量事件流)建出的节点内容完全一致:
 * 任何 fieldId→字段名 映射漂移、字段丢失或 span 错绑都会表现为两侧签名不同。
 */
function dumpTree(root: JsNode): string {
  let out: Array<string> = []
  let stack: Array<JsNode> = [root]
  while (stack.length > 0) {
    let node = stack.pop()
    if (node === undefined) {
      break
    }
    out.push(`${node.nodeType}#${dumpFields(node)}`)
    let children: Array<JsNode> = []
    let child = node.firstChild
    while (child !== undefined) {
      children.push(child)
      child = child.next
    }
    for (let i = children.length - 1; i >= 0; i--) {
      stack.push(children[i])
    }
  }
  return out.join('\n')
}

function dumpFields(node: JsNode): string {
  let spanParts: Array<string> = []
  let spans = node.getSourceSpans()
  for (let i = 0; i < spans.length; i++) {
    const s = spans[i]
    spanParts.push(`${s.getLineIndex()},${s.getColumnIndex()},${s.getInputIndex()},${s.getLength()}`)
  }
  const values: Array<string | number | boolean | undefined> = [
    node.toStr, node.literal, node.destination, node.title, node.label, node.delimiter,
    node.openingDelimiter, node.closingDelimiter, node.fenceChar, node.fenceLength,
    node.fenceIndent, node.level, node.bulletMarker, node.startNumber, node.info,
    node.isTight, node.isHeader, node.alignment, node.width, node.height, node.isdone,
    node.latex, node.isClosed, node.noteid, node.blockIndex, node.headIndex, node.text,
    node.color, node.size, node.name, node.data
  ]
  let parts: Array<string> = []
  for (let i = 0; i < values.length; i++) {
    const v = values[i]
    parts.push(v === undefined ? '' : String(v))
  }
  return `${parts.join('|')}|spans:${spanParts.join(';')}`
}

/*
 * 生成"只有一个顶层块"的文档(单个超长列表), 用于暴露
 * "一个 task 内多次 flush"(顶层子树不可中断) 对满包的影响:
 * 该文档的 step 只需一个 task, 因此包数 > 2 的部分都发生在同一个 task 内。
 */
function buildSingleBlockMarkdown(items: number): string {
  let md = ''
  for (let i = 0; i < items; i++) {
    md += `- 列表项 ${i}，包含 **加粗** 与 \`代码\`\n`
  }
  return md
}

/*
 * 打印一次解析的包大小分布, 用于量化满包程度。
 * 满包: size >= chunkSize; 超包: size > chunkSize(单事件不可拆分导致); 残包容量: Σ(chunkSize - size)。
 */
function printPacketStats(tag: string, chunkSize: number, counts: Array<number>, nodeCount: number): void {
  let total = 0
  let full = 0
  let over = 0
  let half = 0
  let residual = 0
  for (let c of counts) {
    total += c
    if (c >= chunkSize) {
      full++
    }
    if (c > chunkSize) {
      over++
    }
    if (c < chunkSize / 2) {
      half++
    }
    if (c < chunkSize) {
      residual += chunkSize - c
    }
  }
  let first = counts.length > 0 ? counts[0] : 0
  let last = counts.length > 0 ? counts[counts.length - 1] : 0
  console.error(`[packet] ${tag}, chunk=${chunkSize}, 节点=${nodeCount}, 包数=${counts.length}, ` +
    `总实参=${total}, 理想包数=${Math.ceil(total / chunkSize)}, 满包=${full}, 超包=${over}, ` +
    `半包以下=${half}, 首包=${first}, 尾包=${last}, 残包容量=${residual}`)
  console.error(`[packet] ${tag}, chunk=${chunkSize}, 前 10 包=[${counts.slice(0, 10).join(',')}]`)
}

export default function aTest() {
  describe('aTest', () => {
    beforeAll(() => {
    })
    beforeEach(() => {
    })
    afterEach(() => {
    })
    afterAll(() => {
    })
    it('footnote1', 0, async () => {
      let md = `- [^2^]: [异环NTE：免费开放世界RPG封闭测试](https://cg.163.com/static/content/69895252326700b55b0d178b)
- [^1^]: [百度百科 - 异环](https://baike.baidu.com/item/异环)`
      let parser = getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilder(() => new JsNodeSendableImpl()),
        includeSourceSpans: 0,
        FootnotePlugin: true
      })
      let doc = await parser.parse(md)
      let str = printNode(doc)
      console.error(str)
      let p: JsNode = doc.firstChild!
      let node0: JsNode = p.firstChild!.firstChild!
      let node1: JsNode = p.lastChild!.firstChild!
      expect(node0.nodeType).assertEqual("FootnoteBlock")
      expect(node0.firstChild!.lastChild!.destination)
        .assertEqual("https://cg.163.com/static/content/69895252326700b55b0d178b")
      expect(node1.nodeType).assertEqual("FootnoteBlock")
      expect(node1.firstChild!.lastChild!.destination).assertEqual("https://baike.baidu.com/item/异环")
    })
    it('footnote2', 0, async () => {
      let md = `## 参考资料

- [^1^]: [百度百科 - 异环](https://baike.baidu.com/item/异环/64656910)
- [^2^]: [异环NTE：免费开放世界RPG封闭测试](https://cg.163.com/static/content/69895252326700b55b0d178b)
- [^3^]: [异环WIKI - 哔哩哔哩](https://wiki.biligame.com/yh/首页)
- [^4^]: [完美世界收获"二连板" 自研游戏《异环》测试表现亮眼](https://www.stcn.com/article/detail/3635940.html)
- [^5^]: [德国科隆，进入"中国时间"](http://mp.weixin.qq.com/s?__biz=MjM5MjMwMjcyMA==)`
      let parser = getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilder(() => new JsNodeSendableImpl()),
        includeSourceSpans: 0
      })
      let doc = await parser.parse(md)
      let str = printNode(doc)
      console.error(str)
    })
    it('linkify1', 0, async () => {
      let md = `这是一个带中文的链接：
https://www.wanuxi.com/为美好的世界献上祝福第三季主视觉图公开
你好`
      let doc = await parser.parse(md)
      let str = printNode(doc)
      console.error(str)
      expect(doc.firstChild!.firstChild!.next!.next!.destination)
        .assertEqual("https://www.wanuxi.com/")
    })
    it('StyleImage1', 0, async () => {
      let md = `1111![示例图](https://markdown.com.cn/images/blue.jpg){:width=200}1111`
      let doc = await getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilder(),
        includeSourceSpans: 0,
        ImageStylePlugin: true
      }).parse(md)
      let str = printNode(doc)
      console.error(str)
      expect(doc.firstChild!.firstChild!.next!.nodeType).assertEqual("StyleImage")
    })
    it('HtmlSpan1', 0, async () => {
      let md = `<span style="color: red;"> 红色标签 </span>`
      let doc = await parser.parse(md)
      let str = printNode(doc)
      console.error(str)
      let span = doc.firstChild!.firstChild as JsNodeImpl
      expect(span.nodeType).assertEqual("SpanNode")
      expect(span.SpanNodeStyle?.get('color')).assertEqual("red")
    })
    it('buildNodesProtocol', 0, () => {
      // 批量协议一致性: 同构树分别用 buildNodes 扁平事件与旧逐节点 API 构建, 结果必须完全一致。
      // 事件覆盖全部数字标记(1=beginNode 2=endNode 3=setField 4=putProp
      // 5=putSpanNodeAttr 6=putSpanNodeStyle 7=putImageStyles 8=addSourceSpans), 除 7/8 外均为定长事件;
      // 字段以数字 ID 传输(6=literal, 29=toStr), 与仓颉侧 F_LITERAL/F_TOSTR 对应。
      let events: Array<string | number | boolean> = [
        1, 'document',
          3, 29, 'doc',
          8, 8, 0, 0, 0, 5, 1, 2, 10, 3,
          1, 'paragraph',
            3, 29, 'para',
            3, 6, 'hello',
            4, 'data-x', '1',
            5, 'href', 'https://a.com',
            6, 'color', 'red',
            7, 2, 'width=100', 'height=50',
            1, 'text',
              3, 29, 'text',
              3, 6, 'hello',
            2,
          2,
        2
      ]
      let batchBuilder = new JsNodeTreeBuilderBatch()
      // buildNodes 为 rest 参数, 与仓颉侧 callMethod 展开传参语义一致, 直接调用需展开事件数组
      batchBuilder.buildNodes(...events)
      let batchRoot = batchBuilder.getRoot()

      let legacyBuilder = new JsNodeTreeBuilder()
      legacyBuilder.beginNode('document')
      legacyBuilder.setField('toStr', 'doc')
      legacyBuilder.addSourceSpans(0, 0, 0, 5, 1, 2, 10, 3)
      legacyBuilder.beginNode('paragraph')
      legacyBuilder.setField('toStr', 'para')
      legacyBuilder.setField('literal', 'hello')
      legacyBuilder.putProp('data-x', '1')
      legacyBuilder.putSpanNodeAttr('href', 'https://a.com')
      legacyBuilder.putSpanNodeStyle('color', 'red')
      legacyBuilder.putImageStyles('width=100', 'height=50')
      legacyBuilder.beginNode('text')
      legacyBuilder.setField('toStr', 'text')
      legacyBuilder.setField('literal', 'hello')
      legacyBuilder.endNode()
      legacyBuilder.endNode()
      legacyBuilder.endNode()
      let legacyRoot = legacyBuilder.getRoot()

      let batchPara = batchRoot.firstChild as JsNodeImpl
      let batchText = batchPara.firstChild as JsNodeImpl
      expect(printNode(batchRoot)).assertEqual(printNode(legacyRoot))
      expect(batchPara.nodeType).assertEqual('paragraph')
      expect(batchPara.literal).assertEqual('hello')
      expect(batchPara.getProps()!.get('data-x')).assertEqual('1')
      expect(batchPara.SpanNodeStyle?.get('color')).assertEqual('red')
      expect(batchPara.SpanNodeAttr?.get('href')).assertEqual('https://a.com')
      expect(batchPara.ImageStyles!.length).assertEqual(2)
      expect(batchPara.ImageStyles![0]).assertEqual('width=100')
      expect(batchText.literal).assertEqual('hello')
      let spans = batchRoot.getSourceSpans()
      expect(spans.length).assertEqual(2)
      expect(spans[0].getLineIndex()).assertEqual(0)
      expect(spans[0].getColumnIndex()).assertEqual(0)
      expect(spans[0].getInputIndex()).assertEqual(0)
      expect(spans[0].getLength()).assertEqual(5)
      expect(spans[1].getLineIndex()).assertEqual(1)
      expect(spans[1].getColumnIndex()).assertEqual(2)
      expect(spans[1].getInputIndex()).assertEqual(10)
      expect(spans[1].getLength()).assertEqual(3)
    })
    it('buildNodesFastPath', 0, () => {
      // 事件 9(叶子快速路径)等价于 beginNode + literal 字段 + endNode;
      // 事件 1/9 的 nodeType 支持数字 ID(4=Text), 未登记类型回退为字符串传输。
      let events: Array<string | number | boolean> = [
        1, 1,                     // Document(数字 ID)
          1, 'paragraph',         // 字符串类型直传(不在数字表内)
            9, 4, 'hi',           // Text(数字 ID)+ literal
            9, 'NewPluginType', 'x', // 未登记类型回退为字符串
          2,
        2
      ]
      let builder = new JsNodeTreeBuilderBatch()
      builder.buildNodes(...events)
      let root = builder.getRoot()
      expect(root.nodeType).assertEqual('Document')
      let para = root.firstChild as JsNodeImpl
      expect(para.nodeType).assertEqual('paragraph')
      let t1 = para.firstChild as JsNodeImpl
      expect(t1.nodeType).assertEqual('Text')
      expect(t1.literal).assertEqual('hi')
      let t2 = t1.next as JsNodeImpl
      expect(t2.nodeType).assertEqual('NewPluginType')
      expect(t2.literal).assertEqual('x')
      expect(root.getSourceSpans().length).assertEqual(0)
    })
    it('debugOption', 0, async () => {
      // debug 选项: 默认关闭时 toStr 为空串, 开启后输出 Node.toString() 的完整文本。
      let md = '## 标题\n\n正文 **加粗** 内容'
      let off = await new MarkdownParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilderBatch(() => new JsNodeSendableImpl()),
        includeSourceSpans: 2
      }).parse(md)
      let on = await new MarkdownParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilderBatch(() => new JsNodeSendableImpl()),
        includeSourceSpans: 2,
        debug: true
      }).parse(md)
      expect(off.toStr).assertEqual('')
      expect(off.firstChild!.toStr).assertEqual('')
      expect(off.firstChild!.firstChild!.toStr).assertEqual('')
      // span 归入 debug: 关闭时不生成也不传输, 开启时按 includeSourceSpans=2 传输。
      expect(off.getSourceSpans().length).assertEqual(0)
      expect(off.firstChild!.getSourceSpans().length).assertEqual(0)
      expect(on.firstChild!.getSourceSpans().length > 0).assertTrue()
      // 开启后 toStr = Node.toString() 形如 "heading{...}" / "text{literal=标题}"
      expect(on.firstChild!.toStr.length > 0).assertTrue()
      expect(on.firstChild!.firstChild!.toStr.indexOf('标题') >= 0).assertTrue()
    })
    it('buildNodesLargeDoc', 0, async () => {
      // 大文档分片: 总事件实参数远超单次 buildNodes 上限(默认 200),
      // 验证 ensureRoom 在事件边界切包后协议仍自洽。
      // 无分块时数千实参的单次 callMethod 会触发 ark_interop JSInteropNativeError(进程闪退)。
      let md = ''
      for (let i = 0; i < 2000; i++) {
        md += '**加粗** 行内文本节点。'
      }
      let parser = getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilderBatch(() => new JsNodeSendableImpl()),
        includeSourceSpans: 0
      })
      let doc = await parser.parse(md)
      let p: JsNode = doc.firstChild!
      expect(p.nodeType).assertEqual('Paragraph')
      // 不用 printNode 断言: 它递归遍历, 深兄弟链会爆栈; 改用迭代计数, 2000 组 = 2000 Strong + 2000 Text
      let count = 0
      let child = p.firstChild
      while (child !== undefined) {
        count++
        child = child.next
      }
      expect(count).assertEqual(4000)
    })
    it('buildNodesChunkSizeBoundary', 0, async () => {
      // 分块阈值参数化: buildNodesChunkSize=10 时(本用例均为 1~3 元素的小事件),
      // 每次推送的实参数量不得超过 10, 分块次数 > 1, 且建树结果与默认阈值完全一致。
      let md = ''
      for (let i = 0; i < 50; i++) {
        md += `第${i}段文本。\n\n`
      }
      let recording = new RecordingChunkBuilder(() => new JsNodeSendableImpl())
      let doc = await getParser({
        jsNodeTreeBuilder: recording,
        includeSourceSpans: 0,
        buildNodesChunkSize: 10,
        debug: true
      }).parse(md)
      let allWithin = true
      for (let c of recording.chunkCounts) {
        if (c > 10) {
          allWithin = false
        }
      }
      expect(allWithin).assertTrue()
      expect(recording.chunkCounts.length > 1).assertTrue()
      let baseline = await getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilderBatch(() => new JsNodeSendableImpl()),
        includeSourceSpans: 0,
        debug: true
      }).parse(md)
      expect(printNode(doc)).assertEqual(printNode(baseline))
    })
    it('buildNodesFieldSplitInvariant', 0, async () => {
      // 回归: 字段发射中途切包时不得丢字段/重复字段。
      // 缺陷背景: phaseFields 在包满清空 pendingFields 后若未重置 fieldsLoaded,
      // 下个 task 会复用空缓冲并跳过剩余字段, 表现为同一文档不同 chunkSize 的总实参不一致。
      // 这里用小于单个定长事件实参量(3)的阈值, 强制在每个字段事件边界 flush, 断言:
      //   1) 各阈值下 buildNodes 实参总数完全一致(事件流只由 AST 决定, 与切包位置无关);
      //   2) 节点数与结构文本与默认阈值一致。
      let md = ''
      for (let i = 0; i < 40; i++) {
        md += `## 标题${i}\n\n` +
          `段落${i}，含 **加粗**、*斜体* 与 \`代码\`。\n\n` +
          `- 列表项 ${i}\n\n` +
          `> 引用 ${i}\n\n` +
          `\`\`\`ts\nconst v = ${i}\n\`\`\`\n\n` +
          `| A | B |\n| --- | --- |\n| 1 | 2 |\n\n`
      }
      let baselineBuilder = new CountingBatchBuilder(() => new JsNodeSendableImpl())
      let baseline = await getParser({
        jsNodeTreeBuilder: baselineBuilder,
        includeSourceSpans: 0,
        debug: true
      }).parse(md)
      let baselineNodes = countNodes(baseline)
      let baselineStr = printNode(baseline)
      expect(baselineBuilder.args > 0).assertTrue()
      // 2/3/4 均不大于单个事件(3 实参), 必然在字段发射中途触发切包; 64/200 作为常规阈值对照。
      let chunkSizes: Array<number> = [2, 3, 4, 5, 7, 64, 200]
      for (let size of chunkSizes) {
        let builder = new CountingBatchBuilder(() => new JsNodeSendableImpl())
        let doc = await getParser({
          jsNodeTreeBuilder: builder,
          includeSourceSpans: 0,
          debug: true,
          buildNodesChunkSize: size
        }).parse(md)
        expect(builder.args).assertEqual(baselineBuilder.args)
        expect(countNodes(doc)).assertEqual(baselineNodes)
        expect(printNode(doc)).assertEqual(baselineStr)
        if (size < 10) {
          // 极小阈值下单个 task 无法容纳两个事件, 推送次数应显著多于默认阈值。
          expect(builder.pushes > baselineBuilder.pushes).assertTrue()
        }
      }
      // 同一不变量在 debug 模式下同样成立: 此时额外有 toStr 与 sourceSpan 事件参与切包。
      let spanMd = md.substring(0, Math.floor(md.length / 4))
      let debugBaseline = new CountingBatchBuilder(() => new JsNodeSendableImpl())
      let debugBaselineDoc = await getParser({
        jsNodeTreeBuilder: debugBaseline,
        includeSourceSpans: 2,
        debug: true
      }).parse(spanMd)
      let debugChunkSizes: Array<number> = [3, 4, 200]
      for (let size of debugChunkSizes) {
        let builder = new CountingBatchBuilder(() => new JsNodeSendableImpl())
        let doc = await getParser({
          jsNodeTreeBuilder: builder,
          includeSourceSpans: 2,
          debug: true,
          buildNodesChunkSize: size
        }).parse(spanMd)
        console.error(`[fieldSplit][debug] chunk=${size}: 包数=${builder.pushes}, 总实参=${builder.args}, 节点=${countNodes(doc)}`)
        expect(builder.args).assertEqual(debugBaseline.args)
        expect(printNode(doc)).assertEqual(printNode(debugBaselineDoc))
      }
    })
    it('buildNodesChunkSizeSingleEventExceeds', 0, async () => {
      // 单事件超过阈值: 事件不可拆分, 超限时先 flush 再整体入队。
      // 定长事件最多 6 实参(span 事件), 其余 ≤ 3, 这里把阈值设为 2, 必有 c > 2;
      // 验证该路径不破坏协议, 建树结果与默认阈值一致。
      let md = ''
      for (let i = 0; i < 10; i++) {
        md += `第${i}行\n`
      }
      let recording = new RecordingChunkBuilder(() => new JsNodeSendableImpl())
      let doc = await getParser({
        jsNodeTreeBuilder: recording,
        includeSourceSpans: 2,
        debug: true,
        buildNodesChunkSize: 2
      }).parse(md)
      let hasBig = false
      for (let c of recording.chunkCounts) {
        if (c > 2) {
          hasBig = true
        }
      }
      expect(hasBig).assertTrue()
      let baseline = await getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilderBatch(() => new JsNodeSendableImpl()),
        includeSourceSpans: 2,
        debug: true
      }).parse(md)
      expect(printNode(doc)).assertEqual(printNode(baseline))
    })
    it('buildNodesChunkSizeInvalid', 0, async () => {
      // 参数合法性: 非正值(0/-1)与未配置(undefined)均回退默认阈值 200, 解析建树行为不受影响。
      let md = ''
      for (let i = 0; i < 30; i++) {
        md += `段落${i}内容。\n\n`
      }
      let baseline = await getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilderBatch(() => new JsNodeSendableImpl()),
        includeSourceSpans: 0,
        debug: true
      }).parse(md)
      let docZero = await getParser({
        jsNodeTreeBuilder: new RecordingChunkBuilder(() => new JsNodeSendableImpl()),
        includeSourceSpans: 0,
        debug: true,
        buildNodesChunkSize: 0
      }).parse(md)
      expect(printNode(docZero)).assertEqual(printNode(baseline))
      let docNegative = await getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilderBatch(() => new JsNodeSendableImpl()),
        includeSourceSpans: 0,
        debug: true,
        buildNodesChunkSize: -1
      }).parse(md)
      expect(printNode(docNegative)).assertEqual(printNode(baseline))
      let docDefault = await getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilderBatch(() => new JsNodeSendableImpl()),
        includeSourceSpans: 0,
        debug: true
      }).parse(md)
      expect(printNode(docDefault)).assertEqual(printNode(baseline))
      // 超过仓颉→ArkTS 互操作实参上限(255)时必须钳制到 255, 否则 buildNodes 调用直接崩溃。
      let over = new RecordingChunkBuilder(() => new JsNodeSendableImpl())
      let docOver = await getParser({
        jsNodeTreeBuilder: over,
        includeSourceSpans: 0,
        debug: true,
        buildNodesChunkSize: 300
      }).parse(md)
      expect(printNode(docOver)).assertEqual(printNode(baseline))
      expect(over.chunkCounts.length > 0).assertTrue()
      for (let count of over.chunkCounts) {
        expect(count <= 255).assertTrue()
      }
    })
    it('buildNodesChunkSizeMatrix', 0, async () => {
      // 分块阈值矩阵: 多组阈值(含小于单事件实参量的极端值 1)下建树结果必须与默认阈值完全一致。
      // >255 的阈值全部被钳制为 255, 因此只保留一组 1000 验证钳制路径。
      // 数据源: 真实大文档(ohosTest rawfile 下 6000 行综合用例, 与 MarkdownArkUI BigData 页一致)。
      // 打开 debug(只传 toStr, span 关闭)以比对节点内容而非仅结构; 分片边界与跨包续发在此一并覆盖。
      let md: string = loadComprehensiveMarkdown()
      console.error(`[chunkSize性能矩阵] 数据源加载完成: ${md.length}字符`)
      let baseline = await getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilderBatch(() => new JsNodeSendableImpl()),
        includeSourceSpans: 0,
        debug: true
      }).parse(md)
      let baselineStr = printNode(baseline)
      let chunkSizes: Array<number> = [1, 20, 50, 70, 100, 120, 150, 170, 200, 1000]
      let matrixStart = Date.now()
      for (let size of chunkSizes) {
        let recording = new RecordingChunkBuilder(() => new JsNodeSendableImpl())
        let start = Date.now()
        let doc = await getParser({
          jsNodeTreeBuilder: recording,
          includeSourceSpans: 0,
          debug: true,
          buildNodesChunkSize: size
        }).parse(md)
        let cost = Date.now() - start
        let maxArg = 0
        for (let c of recording.chunkCounts) {
          if (c > maxArg) {
            maxArg = c
          }
        }
        // 每组解析完立即打印(在断言之前), 确保断言失败时性能数据也可见
        console.error(`[chunkSize性能矩阵] chunkSize=${size}: parse=${cost}ms, buildNodes推送=${recording.chunkCounts.length}次, 单次最大实参=${maxArg}`)
        // 任何阈值下单次 buildNodes 实参都不得超过仓颉→ArkTS 上限 255(含 1 这样的极端阈值)。
        expect(maxArg <= 255).assertTrue()
        expect(printNode(doc)).assertEqual(baselineStr)
      }
      console.error(`[chunkSize性能矩阵] 全部完成: 文档=${md.length}字符, 组数=${chunkSizes.length}, 总耗时=${Date.now() - matrixStart}ms`)
    })
    it('buildNodesImageStylesChunked', 0, async () => {
      // 回归: 图片样式是变长事件(标记 7 + count + N), 300 个样式必须按 255 实参上限拆片,
      // 否则 buildNodes 会触发不可捕获的 JSInteropNativeError。
      let md = '![img](x.png)'
      for (let i = 0; i < 300; i++) {
        md += `{:style=s${i}}`
      }
      let recording = new RecordingChunkBuilder(() => new JsNodeSendableImpl())
      let batch = await getParser({
        jsNodeTreeBuilder: recording,
        includeSourceSpans: 0,
        debug: true,
        buildNodesChunkSize: 200,
        ImageStylePlugin: true
      }).parse(md)
      expect(recording.chunkCounts.length >= 2).assertTrue()
      for (let c of recording.chunkCounts) {
        expect(c <= 255).assertTrue()
      }
      // 样式必须完整且保序(printNode 开启 debug 后包含 styles=[...])。
      let printed = printNode(batch)
      expect(printed.indexOf('style=s0,') >= 0 || printed.indexOf('style=s0]') >= 0).assertTrue()
      expect(printed.indexOf('style=s299') >= 0).assertTrue()
      // 两套实现(非批量每 255 个值一次调用, 批量每 max(1, min(chunkSize-2, 253)) 个样式一条事件)结果必须一致。
      let nonBatch = await getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilder(() => new JsNodeSendableImpl()),
        includeSourceSpans: 0,
        debug: true,
        ImageStylePlugin: true
      }).parse(md)
      expect(printNode(nonBatch)).assertEqual(printed)
      expect(dumpTree(nonBatch)).assertEqual(dumpTree(batch))
    })
    it('nonBatchBatchEquivalence', 0, async () => {
      // 回归: 两条通路的节点内容必须逐项一致(fieldId→字段名映射 / toStr / sourceSpan)。
      // 数据源取综合大文档的 1/4 档(覆盖全部节点类型), 批量侧用较小 chunkSize 强制跨包,
      // 同时检验字段与图片样式的续发逻辑不会丢项或重复。
      let doc = loadComprehensiveMarkdown()
      let md = doc.substring(0, Math.floor(doc.length / 4))
      let batch = await getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilderBatch(() => new JsNodeSendableImpl()),
        includeSourceSpans: 2,
        debug: true,
        buildNodesChunkSize: 64
      }).parse(md)
      let nonBatch = await getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilder(() => new JsNodeSendableImpl()),
        includeSourceSpans: 2,
        debug: true
      }).parse(md)
      expect(printNode(batch)).assertEqual(printNode(nonBatch))
      expect(dumpTree(batch)).assertEqual(dumpTree(nonBatch))
      expect(countNodes(batch)).assertEqual(countNodes(nonBatch))
    })
    /*
     * ==================== 性能评估用例 ====================
     * 以非 batch 模式(JsNodeTreeBuilder 逐事件跨语言调用)为基准,
     * 从 markdown 文本长度、分片大小(buildNodesChunkSize)两个维度评估批量建树优化成果。
     */
    it('perfCrossLanguageCalls', 0, async () => {
      if (!RUN_PERF_TESTS) {
        return
      }
      // 调用次数维度: 同一文档下对比 非batch 的逐事件调用次数 与 batch 的 buildNodes 推送次数。
      let doc = loadComprehensiveMarkdown()
      let md = doc.substring(0, Math.floor(doc.length / 8))
      let legacy = new CountingLegacyBuilder(() => new JsNodeSendableImpl())
      let legacyDoc = await new MarkdownParser({
        jsNodeTreeBuilder: legacy,
        includeSourceSpans: 0
      }).parse(md)
      let batch = new CountingBatchBuilder(() => new JsNodeSendableImpl())
      let batchDoc = await new MarkdownParser({
        jsNodeTreeBuilder: batch,
        includeSourceSpans: 0,
        buildNodesChunkSize: 200
      }).parse(md)
      let ratio = legacy.calls / batch.pushes
      console.error(`[perf][调用次数] 文档=${md.length}字符, 节点=${countNodes(legacyDoc)}, ` +
        `非batch跨语言调用=${legacy.calls}次, batch推送=${batch.pushes}次(实参总数=${batch.args}), ` +
        `调用次数降低=${ratio.toFixed(2)}x`)
      // 确保两条路径都真实生效: legacy 产生了逐事件调用, batch 走的是 buildNodes 批量推送
      expect(legacy.calls > 0).assertTrue()
      expect(batch.pushes > 0).assertTrue()
      expect(countNodes(batchDoc)).assertEqual(countNodes(legacyDoc))
      expect(printNode(batchDoc)).assertEqual(printNode(legacyDoc))
      expect(batch.pushes * 10 <= legacy.calls).assertTrue()
    })
    it('perfPhaseBreakdown', 0, async () => {
      if (!RUN_PERF_TESTS) {
        return
      }
      // 用三个能力递减的 builder 拆解四段耗时(同一文档、同一 chunkSize、同轮测量):
      //   NoOpPushBuilder  -> 解析 + 序列化 + 跨语言传输(buildNodes 直接返回, 不解码)
      //   NoOpEventBuilder -> 上述 + 解码(父类按事件标记 switch 分发, 事件方法空实现)
      //   TimedBatchBuilder-> 上述 + 建树(真实 appendChild/setField)
      // 解析 = resetAt - start; 序列化+跨语言 = push.total - parse;
      // 解码 = event.total - push.total; 建树 = tree.total - event.total。
      let doc = loadComprehensiveMarkdown()
      let docLens: Array<number> = [Math.floor(doc.length / 4), doc.length]
      let rounds = 3
      let chunkSize = 200
      for (let docLen of docLens) {
        let md = doc.substring(0, docLen)
        let nodeCount = countNodes(await createPerfParser(false).parse(md))
        // 预热三条路径, 避免首次编译/缓存差异污染对比。
        await measurePhase(new NoOpPushBuilder(), md, chunkSize)
        await measurePhase(new NoOpEventBuilder(), md, chunkSize)
        await measurePhase(new TimedBatchBuilder(() => new JsNodeSendableImpl()), md, chunkSize)
        let parseTimes: Array<number> = []
        let pushTimes: Array<number> = []
        let eventTimes: Array<number> = []
        let treeTimes: Array<number> = []
        for (let i = 0; i < rounds; i++) {
          let push = await measurePhase(new NoOpPushBuilder(), md, chunkSize)
          let event = await measurePhase(new NoOpEventBuilder(), md, chunkSize)
          let treeBuilder = new TimedBatchBuilder(() => new JsNodeSendableImpl())
          let tree = await measurePhase(treeBuilder, md, chunkSize)
          // 完整路径必须真的建出整棵树, 否则阶段差值没有意义。
          expect(countNodes(treeBuilder.getRoot())).assertEqual(nodeCount)
          parseTimes.push(push.parseMs)
          pushTimes.push(push.totalMs)
          eventTimes.push(event.totalMs)
          treeTimes.push(tree.totalMs)
        }
        let parseMs = Math.round(medianOf(parseTimes))
        let pushMs = Math.round(medianOf(pushTimes))
        let eventMs = Math.round(medianOf(eventTimes))
        let treeMs = Math.round(medianOf(treeTimes))
        let serializeMs = Math.max(0, pushMs - parseMs)
        let decodeMs = Math.max(0, eventMs - pushMs)
        let buildMs = Math.max(0, treeMs - eventMs)
        console.error(`[perf][阶段] 文档=${md.length}字符, 节点=${nodeCount}, chunkSize=${chunkSize}, ` +
          `总耗时=${treeMs}ms`)
        console.error(`[perf][阶段]   解析=${parseMs}ms(${percentOf(parseMs, treeMs)}), ` +
          `序列化+跨语言=${serializeMs}ms(${percentOf(serializeMs, treeMs)}), ` +
          `解码=${decodeMs}ms(${percentOf(decodeMs, treeMs)}), ` +
          `建树=${buildMs}ms(${percentOf(buildMs, treeMs)})`)
        expect(parseMs > 0).assertTrue()
        expect(treeMs > 0).assertTrue()
      }
    })
    it('perfSourceSpanLayers', 0, async () => {
      if (!RUN_PERF_TESTS) {
        return
      }
      // includeSourceSpans 分层对比: 0=不传 span, 1=仅 Block, 2=全部节点。
      // span 归入 debug 选项管理, 因此三层都开 debug; toStr 在三层中是常量, 差值只反映 span 成本。
      // 三层交替测量(每轮轮换先后顺序)以抵消机器漂移, 每层取 5 轮中位数。
      let doc = loadComprehensiveMarkdown()
      let md = doc.substring(0, Math.floor(doc.length / 2))
      let chunkSize = 200
      let nodeCount = countNodes(await createPerfParser(false).parse(md))
      let levels: Array<0 | 1 | 2> = [0, 1, 2]
      let totals: Array<Array<number>> = [[], [], []]
      let parses: Array<Array<number>> = [[], [], []]
      // 预热: 三层各跑一次, 让 JIT/GC 进入稳定状态。
      for (let level of levels) {
        await measurePhase(new TimedBatchBuilder(() => new JsNodeSendableImpl()), md, chunkSize, level, true)
      }
      let rounds = 5
      for (let r = 0; r < rounds; r++) {
        for (let k = 0; k < levels.length; k++) {
          let level = levels[(k + r) % levels.length]
          let t = await measurePhase(new TimedBatchBuilder(() => new JsNodeSendableImpl()), md, chunkSize,
            level, true)
          totals[level].push(t.totalMs)
          parses[level].push(t.parseMs)
        }
      }
      for (let level of levels) {
        let totalMs = Math.round(medianOf(totals[level]))
        let parseMs = Math.round(medianOf(parses[level]))
        console.error(`[perf][span层] level=${level}, 文档=${md.length}字符, 节点=${nodeCount}, ` +
          `总耗时=${totalMs}ms, 解析=${parseMs}ms, 序列化+跨语言=${Math.max(0, totalMs - parseMs)}ms`)
        expect(totalMs > 0).assertTrue()
      }
    })
    it('perfDebugToString', 0, async () => {
      if (!RUN_PERF_TESTS) {
        return
      }
      // debug 前后对比: false=toStr 传空串, true=输出 Node.toString()。
      // 用全量综合大文档(文本量大, toStr 拷贝成本被放大), 两种配置交替测量, 各取 7 轮中位数。
      let md = loadComprehensiveMarkdown()
      let chunkSize = 200
      let nodeCount = countNodes(await createPerfParser(false).parse(md))
      let toggles: Array<boolean> = [false, true]
      let totals: Array<Array<number>> = [[], []]
      let parses: Array<Array<number>> = [[], []]
      for (let d of toggles) {
        await measurePhase(new TimedBatchBuilder(() => new JsNodeSendableImpl()), md, chunkSize, 2, d)
      }
      let rounds = 7
      for (let r = 0; r < rounds; r++) {
        for (let k = 0; k < toggles.length; k++) {
          let idx = (k + r) % toggles.length
          let t = await measurePhase(new TimedBatchBuilder(() => new JsNodeSendableImpl()), md, chunkSize, 2,
            toggles[idx])
          totals[idx].push(t.totalMs)
          parses[idx].push(t.parseMs)
        }
      }
      for (let i = 0; i < toggles.length; i++) {
        let totalMs = Math.round(medianOf(totals[i]))
        let parseMs = Math.round(medianOf(parses[i]))
        console.error(`[perf][debug] debug=${toggles[i]}, 文档=${md.length}字符, 节点=${nodeCount}, ` +
          `总耗时=${totalMs}ms, 解析=${parseMs}ms, 序列化+跨语言=${Math.max(0, totalMs - parseMs)}ms`)
        expect(totalMs > 0).assertTrue()
      }
    })
    it('perfDebugSpans', 0, async () => {
      if (!RUN_PERF_TESTS) {
        return
      }
      // sourceSpan 归入 debug 后的前后对比(全量综合大文档, 三组配置交替, 各取 7 轮中位数):
      //   arm0: debug=off + includeSourceSpans=2 -> 新默认: 不生成/不传输 span, 不输出 toStr
      //   arm1: debug=on  + includeSourceSpans=0 -> 仅 toStr
      //   arm2: debug=on  + includeSourceSpans=2 -> toStr + span(与改动前的信息量等价)
      // span 成本 ≈ arm2 - arm1; toStr 成本 ≈ arm1 - arm0。
      let md = loadComprehensiveMarkdown()
      let chunkSize = 200
      let nodeCount = countNodes(await createPerfParser(false).parse(md))
      let spans: Array<0 | 1 | 2> = [2, 0, 2]
      let debugs: Array<boolean> = [false, true, true]
      let labels: Array<string> = ['debug=off/spans=2', 'debug=on/spans=0', 'debug=on/spans=2']
      let totals: Array<Array<number>> = [[], [], []]
      let parses: Array<Array<number>> = [[], [], []]
      for (let i = 0; i < spans.length; i++) {
        await measurePhase(new TimedBatchBuilder(() => new JsNodeSendableImpl()), md, chunkSize, spans[i], debugs[i])
      }
      let rounds = 7
      for (let r = 0; r < rounds; r++) {
        for (let k = 0; k < spans.length; k++) {
          let idx = (k + r) % spans.length
          let t = await measurePhase(new TimedBatchBuilder(() => new JsNodeSendableImpl()), md, chunkSize,
            spans[idx], debugs[idx])
          totals[idx].push(t.totalMs)
          parses[idx].push(t.parseMs)
        }
      }
      for (let i = 0; i < labels.length; i++) {
        let totalMs = Math.round(medianOf(totals[i]))
        let parseMs = Math.round(medianOf(parses[i]))
        console.error(`[perf][span传输] ${labels[i]}, 文档=${md.length}字符, 节点=${nodeCount}, ` +
          `总耗时=${totalMs}ms, 解析=${parseMs}ms, 序列化+跨语言=${Math.max(0, totalMs - parseMs)}ms`)
        expect(totalMs > 0).assertTrue()
      }
      let offMs = Math.round(medianOf(totals[0]))
      let toStrMs = Math.round(medianOf(totals[1]))
      let spanMs = Math.round(medianOf(totals[2]))
      console.error(`[perf][span传输] 差值: 默认(off) → toStr+span = ${spanMs - offMs}ms, ` +
        `其中 toStr≈${toStrMs - offMs}ms, span≈${spanMs - toStrMs}ms`)
    })
    it('packetFillStats', 0, async () => {
      if (!RUN_PERF_TESTS) {
        return
      }
      // 量化"满包"程度: 记录每次 buildNodes 的实参数, 统计包大小分布。
      // - 综合大文档(全量): 常规文档, 顶层多为小段落;
      // - 单个 5000 项列表: 只有一个顶层子树, step 只需 1 个 task,
      //   因此除首包(Root)与尾包外, 其余包都发生在同一个 task 内(暴露"子树不可中断")。
      let doc = loadComprehensiveMarkdown()
      let single = buildSingleBlockMarkdown(5000)
      let docs: Array<string> = [doc, single]
      let tags: Array<string> = ['综合大文档', '单列表5000项']
      let chunkSizes: Array<number> = [64, 200]
      for (let d = 0; d < docs.length; d++) {
        let nodeCount = 0
        for (let chunkSize of chunkSizes) {
          let builder = new RecordingChunkBuilder(() => new JsNodeSendableImpl())
          let doc = await new MarkdownParser({
            jsNodeTreeBuilder: builder,
            includeSourceSpans: 2,
            buildNodesChunkSize: chunkSize
          }).parse(docs[d])
          if (nodeCount === 0) {
            nodeCount = countNodes(doc)
          }
          printPacketStats(tags[d], chunkSize, builder.chunkCounts, nodeCount)
        }
      }
      expect(true).assertTrue()
    })
    it('perfByDocSizeAndChunkSize', 0, async () => {
      if (!RUN_PERF_TESTS) {
        return
      }
      // 交叉组合维度: 综合大文档分级大小 x buildNodesChunkSize(1~250 分级)。
      // 每个文档档位先测 非batch 基准(5轮中位数), 再逐 chunkSize 档位测 batch 解析耗时(5轮中位数),
      // 单一组合的多次测量取中位数, 抑制 GC/调度抖动对结论的影响。
      let doc = loadComprehensiveMarkdown()
      console.error(`[perf][交叉] 数据源 ${COMPREHENSIVE_DOC}: ${doc.length}字符`)
      // 文档大小分级: 全量的 1/16、1/8、1/4、1/2、1
      let fractions: Array<number> = [16, 8, 4, 2, 1]
      // chunkSize 分级: 1~250
      let chunkSizes: Array<number> = [1, 2, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100,
        110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250]
      for (let f of fractions) {
        let md = doc.substring(0, Math.floor(doc.length / f))
        await measureOnce(false, md)
        await measureOnce(true, md, 200)
        let legacyMs = await measureMedian(false, md, 5)
        let legacyDoc = await createPerfParser(false).parse(md)
        let nodeCount = countNodes(legacyDoc)
        console.error(`[perf][交叉] 文档=${md.length}字符(全量1/${f}), 非batch=${legacyMs}ms, 节点=${nodeCount}`)
        for (let size of chunkSizes) {
          let times: Array<number> = []
          let pushes = 0
          let args = 0
          for (let round = 0; round < 5; round++) {
            let builder = new CountingBatchBuilder(() => new JsNodeSendableImpl())
            let start = Date.now()
            let doc = await new MarkdownParser({
              jsNodeTreeBuilder: builder,
              includeSourceSpans: 2,
              buildNodesChunkSize: size
            }).parse(md)
            times.push(Date.now() - start)
            pushes = builder.pushes
            args = builder.args
            expect(builder.pushes > 0).assertTrue()
            expect(countNodes(doc)).assertEqual(nodeCount)
          }
          let batchMs = Math.round(medianOf(times))
          let avgArgs = pushes > 0 ? (args / pushes).toFixed(1) : '0'
          let speedup = batchMs > 0 ? (legacyMs / batchMs).toFixed(2) : 'N/A'
          console.error(`[perf][交叉] 文档=${md.length}字符(1/${f}), chunkSize=${size}: batch=${batchMs}ms, ` +
            `推送=${pushes}次, 平均实参=${avgArgs}, 相对基准=${speedup}`)
        }
      }
    })
    it('perfChunkSizeDriven', 0, async () => {
      if (!RUN_PERF_TESTS) {
        return
      }
      // 包大小驱动: task 边界跟随包边界, 推送次数应贴近 ceil(实参总数 / buildNodesChunkSize),
      // 且同一文档同一配置的推送次数在各轮之间完全一致(不随设备负载漂移)。
      let doc = loadComprehensiveMarkdown()
      let docLens: Array<number> = [Math.floor(doc.length / 4), doc.length]
      let chunkSizes: Array<number> = [50, 150, 250]
      for (let docLen of docLens) {
        let md = doc.substring(0, docLen)
        await measureOnce(false, md)
        await measureOnce(true, md, 200)
        let legacyMs = await measureMedian(false, md, 5)
        let nodeCount = countNodes(await createPerfParser(false).parse(md))
        console.error(`[perf][包大小] 文档=${md.length}字符, 非batch=${legacyMs}ms, 节点=${nodeCount}`)
        for (let size of chunkSizes) {
          let times: Array<number> = []
          let pushCounts: Array<number> = []
          let args = 0
          for (let round = 0; round < 5; round++) {
            let builder = new CountingBatchBuilder(() => new JsNodeSendableImpl())
            let start = Date.now()
            let doc = await new MarkdownParser({
              jsNodeTreeBuilder: builder,
              includeSourceSpans: 2,
              buildNodesChunkSize: size
            }).parse(md)
            times.push(Date.now() - start)
            pushCounts.push(builder.pushes)
            args = builder.args
            expect(builder.pushes > 0).assertTrue()
            expect(countNodes(doc)).assertEqual(nodeCount)
          }
          // 确定性断言: 推送次数只由文档与 chunkSize 决定, 5 轮必须完全一致。
          for (let i = 1; i < pushCounts.length; i++) {
            expect(pushCounts[i]).assertEqual(pushCounts[0])
          }
          let pushes = pushCounts[0]
          let batchMs = Math.round(medianOf(times))
          console.error(`[perf][包大小] 文档=${md.length}字符, chunkSize=${size}: batch=${batchMs}ms, ` +
            `推送=${pushes}次(理论最少=${Math.ceil(args / size)}), 平均实参=${(args / pushes).toFixed(1)}, ` +
            `相对基准=${(legacyMs / batchMs).toFixed(2)}`)
        }
      }
    })
  })
}
