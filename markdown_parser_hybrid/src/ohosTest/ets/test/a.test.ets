import { hilog } from '@kit.PerformanceAnalysisKit';
import { util } from '@kit.ArkTS';
import { common } from '@kit.AbilityKit';
import { abilityDelegatorRegistry } from '@kit.TestKit';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import {
  JsNode, Options, printNode, JsNodeImpl, JsNodeSendableImpl, JsNodeTreeBuilder, JsNodeTreeBuilderBatch,
} from '../../../../Index';
import { getParser, parser } from './md'

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
        includeSourceSpans: 2,
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
      // 事件覆盖全部 8 种数字标记(1=beginNode 2=endNode 3=setField 4=putProp
      // 5=putSpanNodeAttr 6=putSpanNodeStyle 7=putImageStyles 8=addSourceSpans), 含 count 定界。
      let events: Array<string | number | boolean> = [
        1, 'document', 'doc',
          8, 8, 0, 0, 0, 5, 1, 2, 10, 3,
          1, 'paragraph', 'para',
            3, 'literal', 'hello',
            4, 'data-x', '1',
            5, 'href', 'https://a.com',
            6, 'color', 'red',
            7, 2, 'width=100', 'height=50',
            1, 'text', 'text',
              3, 'literal', 'hello',
            2,
          2,
        2
      ]
      let batchBuilder = new JsNodeTreeBuilderBatch()
      // buildNodes 为 rest 参数, 与仓颉侧 callMethod 展开传参语义一致, 直接调用需展开事件数组
      batchBuilder.buildNodes(...events)
      let batchRoot = batchBuilder.getRoot()

      let legacyBuilder = new JsNodeTreeBuilder()
      legacyBuilder.beginNode('document', 'doc')
      legacyBuilder.addSourceSpans(0, 0, 0, 5, 1, 2, 10, 3)
      legacyBuilder.beginNode('paragraph', 'para')
      legacyBuilder.setField('literal', 'hello')
      legacyBuilder.putProp('data-x', '1')
      legacyBuilder.putSpanNodeAttr('href', 'https://a.com')
      legacyBuilder.putSpanNodeStyle('color', 'red')
      legacyBuilder.putImageStyles('width=100', 'height=50')
      legacyBuilder.beginNode('text', 'text')
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
    it('buildNodesLargeDoc', 0, async () => {
      // 大文档分片: 单个 buildSubtree 事件数远超单次 buildNodes 上限(默认 200),
      // 验证 flushIfFull 在事件边界拆分后协议仍自洽。
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
        buildNodesChunkSize: 10
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
        includeSourceSpans: 0
      }).parse(md)
      expect(printNode(doc)).assertEqual(printNode(baseline))
    })
    it('buildNodesChunkSizeSingleEventExceeds', 0, async () => {
      // 单事件超过阈值: span 事件(@n)按节点发射, 单 span = 4 实参 + 标记/数量前缀共 6 实参;
      // 多行段落节点聚合多行 span(10 行 = 42 实参 > 10), 事件整体入队不拆分,
      // 验证"先 flush 再入队单事件"不破坏协议, 建树结果与默认阈值一致。
      let md = ''
      for (let i = 0; i < 10; i++) {
        md += `第${i}行\n`
      }
      let recording = new RecordingChunkBuilder(() => new JsNodeSendableImpl())
      let doc = await getParser({
        jsNodeTreeBuilder: recording,
        includeSourceSpans: 2,
        buildNodesChunkSize: 10
      }).parse(md)
      let hasBig = false
      for (let c of recording.chunkCounts) {
        if (c > 10) {
          hasBig = true
        }
      }
      expect(hasBig).assertTrue()
      let baseline = await getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilderBatch(() => new JsNodeSendableImpl()),
        includeSourceSpans: 2
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
        includeSourceSpans: 0
      }).parse(md)
      let docZero = await getParser({
        jsNodeTreeBuilder: new RecordingChunkBuilder(() => new JsNodeSendableImpl()),
        includeSourceSpans: 0,
        buildNodesChunkSize: 0
      }).parse(md)
      expect(printNode(docZero)).assertEqual(printNode(baseline))
      let docNegative = await getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilderBatch(() => new JsNodeSendableImpl()),
        includeSourceSpans: 0,
        buildNodesChunkSize: -1
      }).parse(md)
      expect(printNode(docNegative)).assertEqual(printNode(baseline))
      let docDefault = await getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilderBatch(() => new JsNodeSendableImpl()),
        includeSourceSpans: 0
      }).parse(md)
      expect(printNode(docDefault)).assertEqual(printNode(baseline))
    })
    it('buildNodesChunkSizeMatrix', 0, async () => {
      // 分块阈值矩阵: 多组阈值(含小于单事件实参量的极端值 1)下建树结果必须与默认阈值完全一致。
      // 数据源: 真实大文档(ohosTest rawfile 下 6000 行综合用例, 与 MarkdownArkUI BigData 页一致),
      // 文档含 span 信息(includeSourceSpans=2), 阈值小于 @n 事件实参量时覆盖"单事件超限整体入队"路径。
      let context: common.Context = abilityDelegatorRegistry.getAbilityDelegator().getAppContext()
      let buf: Uint8Array = context.resourceManager.getRawFileContentSync('001_Comprehensive_6000Lines.md')
      let md: string = util.TextDecoder.create('utf-8').decodeToString(buf)
      console.error(`[chunkSize性能矩阵] 数据源加载完成: ${md.length}字符`)
      let baseline = await getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilderBatch(() => new JsNodeSendableImpl()),
        includeSourceSpans: 2
      }).parse(md)
      let baselineStr = printNode(baseline)
      let chunkSizes: Array<number> = [1, 20, 50, 70, 100, 120, 150, 170, 200, 300, 400, 500, 600, 700, 800, 900, 1000]
      let matrixStart = Date.now()
      for (let size of chunkSizes) {
        let recording = new RecordingChunkBuilder(() => new JsNodeSendableImpl())
        let start = Date.now()
        let doc = await getParser({
          jsNodeTreeBuilder: recording,
          includeSourceSpans: 2,
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
        expect(printNode(doc)).assertEqual(baselineStr)
      }
      console.error(`[chunkSize性能矩阵] 全部完成: 文档=${md.length}字符, 组数=${chunkSizes.length}, 总耗时=${Date.now() - matrixStart}ms`)
    })
  })
}
